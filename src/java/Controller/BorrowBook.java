package Controller;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//@WebServlet("/BorrowBookServlet")
public class BorrowBook extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int userId = (Integer) session.getAttribute("userId");
        int bookId = Integer.parseInt(request.getParameter("bookId"));

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/LibraryDB", "root", "password")) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM BorrowedBooks WHERE user_id = ? AND returned = 0");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                response.getWriter().write("You must return your current book before borrowing another.");
                return;
            }

            ps = con.prepareStatement("INSERT INTO Requests (user_id, book_id) VALUES (?, ?)");
            ps.setInt(1, userId);
            ps.setInt(2, bookId);
            ps.executeUpdate();

            response.getWriter().write("Request Sent");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
