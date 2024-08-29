package Controller;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Book;

//@WebServlet("/SearchServlet")
public class searchbookservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/librarydb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "password";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookTitle = request.getParameter("bookTitle");
        List<Book> books = new ArrayList<>();
        String errorMessage = null;
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT * FROM books WHERE title LIKE ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, "%" + bookTitle + "%");
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        Book book = new Book();
                        book.setTitle(rs.getString("bookTitle"));
                        book.setAuthor(rs.getString("author"));
                        book.setBook_code(rs.getString("bookCode"));
                        book.setPublished_year(rs.getString("year"));
                        books.add(book);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            errorMessage = "An error occurred while querying the database. Please try again later.";
        }
        
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
        } else {
            request.setAttribute("books", books);
        }
        
        request.getRequestDispatcher("displaysearchbook.jsp").forward(request, response);
    }
}
