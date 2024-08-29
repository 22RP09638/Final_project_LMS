package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Date;
import javax.servlet.RequestDispatcher;

public class BookSearchServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String title = request.getParameter("title");

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establish the connection to the database
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/librarydb", "root", "");
            
            // Prepare the SQL query
            String query = "SELECT book_id, title, author, book_code, published_year, file_path, availability FROM books WHERE title LIKE ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, "%" + title + "%");
            
            // Execute the query and get the result set
            ResultSet rs = stmt.executeQuery();

            // Output the search results with styling and structure
            out.println("<style>");
            out.println("table { width: 100%; border-collapse: collapse; }");
            out.println("th, td { padding: 10px; text-align: left; border: 1px solid #ddd; }");
            out.println("th { background-color: #f2f2f2; }");
            out.println("tr:nth-child(even) { background-color: #f9f9f9; }");
            out.println("tr:hover { background-color: #f1f1f1; }");
            out.println("</style>");
            out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/style.css\">");
            out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/style3.css\">");

            // Include header and navigation JSP files
            RequestDispatcher dispatcher = request.getRequestDispatcher("header.jsp");
            dispatcher.include(request, response);
            RequestDispatcher dis = request.getRequestDispatcher("navigation.jsp");
            dis.include(request, response);

            // Include JavaScript code for handling borrow requests
            out.println("<script type=\"text/javascript\">");
            out.println("function requestBorrow(bookId) {");
            out.println("    if (confirm(\"Are you sure you want to request to borrow this book?\")) {");
            out.println("        var form = document.createElement(\"form\");");
            out.println("        form.method = \"POST\";");
            out.println("        form.action = \"RequestBorrow\";"); // Point to the new servlet
            out.println("        var input = document.createElement(\"input\");");
            out.println("        input.type = \"hidden\";");
            out.println("        input.name = \"bookId\";");
            out.println("        input.value = bookId;");
            out.println("        form.appendChild(input);");
            out.println("        document.body.appendChild(form);");
            out.println("        form.submit();");
            out.println("    }");
            out.println("}");
            out.println("</script>");

            out.println("<html><head><title>Search Results</title></head><body>");
            out.println("<h1>Search Results</h1>");
            out.println("<table border='1' cellpadding='10' cellspacing='0'>");

            // Check if no rows were returned
            if (!rs.isBeforeFirst()) {  
                out.println("<p style='color:red;'>Book not found.</p>");
            } else {
                out.println("<tr><th>Book ID</th><th>Title</th><th>Author</th><th>Book Code</th><th>Published Year</th><th>File Path</th><th>Availability</th><th>Action</th></tr>");
                
                while (rs.next()) {
                    int bookId = rs.getInt("book_id");
                    String bookTitle = rs.getString("title");
                    String author = rs.getString("author");
                    String bookCode = rs.getString("book_code");
                    Date publishedYear = rs.getDate("published_year");
                    String filePath = rs.getString("file_path");
                    String availability = rs.getString("availability");

                    out.println("<tr>");
                    out.println("<td>" + bookId + "</td>");
                    out.println("<td>" + bookTitle + "</td>");
                    out.println("<td>" + author + "</td>");
                    out.println("<td>" + bookCode + "</td>");
                    out.println("<td>" + (publishedYear != null ? publishedYear.toString() : "Not Available") + "</td>");
                    
                    if (filePath != null && !filePath.isEmpty()) {
                        String encodedFilePath = java.net.URLEncoder.encode(filePath, "UTF-8");
                        String readUrl = "http://docs.oracle.com/javase/specs/jls/se8/html/index.html?file=" + encodedFilePath;
                        out.println("<td><a href='" + readUrl + "' target='_blank' style='text-decoration:none'>Read</a></td>");
                    } else {
                        out.println("<td>No File</td>");
                    }

                    out.println("<td>" + (availability != null ? availability : "Not Available") + "</td>");
                    out.println("<td><button type=\"button\" onclick=\"requestBorrow(" + bookId + ")\">Request Borrow</button></td>");
                    out.println("</tr>");
                }
            }

            out.println("</table>");

            RequestDispatcher disp = request.getRequestDispatcher("footer.jsp");
            disp.include(request, response);

            out.println("</body></html>");

            // Close resources
            rs.close();
            stmt.close();
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        } finally {
            out.close();
        }
    }
}
