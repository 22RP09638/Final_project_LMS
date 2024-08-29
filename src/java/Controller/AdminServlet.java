package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Book;
import util.DBUtil;

public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<Book> books = new ArrayList<>();

        try {
            Connection con = DBUtil.getConnection();
            String sql = "SELECT * FROM Books";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setBook_code(rs.getString("book_code"));
                book.setPublished_year(rs.getString("published_year"));
                book.setAvailability(rs.getString("availability"));
                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
//PrintWriter pw=response.getWriter();
//pw.println(books);
        request.setAttribute("books", books);
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addBook".equals(action)) {
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String book_code = request.getParameter("book_code");
            String published_year = request.getParameter("published_year");

            try (Connection con = DBUtil.getConnection()) {
                String sql = "INSERT INTO Books (title, author,book_code,published_year) VALUES (?,?,?,?)";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, title);
                ps.setString(2, author);
                ps.setString(3, book_code);
                ps.setString(4, published_year);
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            response.sendRedirect("admin-dashboard");
        } else if ("viewBorrowedBooks".equals(action)) {
            // Code to view borrowed books can be added here.
        }
    }
}
