<%@page import="java.sql.*, java.util.*"%>
<%@page import="util.DBUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
    <style>
        .pri {
    margin-top: 20px; /* Add space between the table and this section */
    padding: 15px;
    background-color: #f9f9f9; /* Light background for contrast */
    text-align: center; /* Center-align content */
    border-radius: 8px; /* Rounded corners for a clean look */
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); /* Add a subtle shadow for depth */
}

.pri h3 {
    margin-bottom: 20px;
    font-size: 18px;
    color: #333;
    font-weight: bold;
}

.pri a {
    background-color: #4CAF50; /* Green background for the button */
    color: white; /* White text color */
    padding: 10px 20px; /* Padding for the button */
    text-align: center; /* Center-align the text inside the button */
    text-decoration: none; /* Remove underline from the link */
    display: inline-block; /* Display as a block-level element */
    border-radius: 5px; /* Rounded corners */
    font-size: 16px; /* Increase the font size */
    border: none; /* Remove default border */
    cursor: pointer; /* Pointer cursor on hover */
    transition: background-color 0.3s ease; /* Smooth background color transition on hover */
}

.pri a:hover {
    background-color: #45a049; /* Darker shade on hover */
}

    </style>
    <title>Books Report</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/style3.css">
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <h1>Books Report</h1>
        
        <a href="admin-dashboard.jsp" style="text-decoration: none; color: #ffffff; background-color: #294c8e; padding: 10px 20px; border-radius: 5px; font-weight: bold;">Back</a>

        <table>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>Book Code</th>
                <th>Published Year</th>
            </tr>
            <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                int bookCount = 0;

                try {
                    con = DBUtil.getConnection();

                    // SQL query to get book details
                    String sql = "SELECT title, author, book_code, published_year FROM books";
                    ps = con.prepareStatement(sql);
                    rs = ps.executeQuery();

                    if (!rs.isBeforeFirst()) {
                        out.println("<tr><td colspan='4'>No books found.</td></tr>");
                    }

                    while (rs.next()) {
                        String title = rs.getString("title");
                        String author = rs.getString("author");
                        String bookCode = rs.getString("book_code");
                        String publishedYear = rs.getString("published_year");
                        bookCount++; // Count the number of books
            %>
            <tr>
                <td><%= title %></td>
                <td><%= author %></td>
                <td><%= bookCode %></td>
                <td><%= publishedYear %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='4'>Error retrieving books.</td></tr>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
                 <h3><strong>Total Number of Books Available:</strong> <%= bookCount %></h3>
        <a href="#" onclick="window.print()" style="background-color: #294c8e; color: white; padding: 10px 20px; text-align: center; text-decoration: none; display: inline-block; border-radius: 5px; font-size: 16px; border: none; cursor: pointer;">Print</a>

        </table>

        <br>
       
        </div>

    <jsp:include page="footer.jsp" />
</body>
</html>
