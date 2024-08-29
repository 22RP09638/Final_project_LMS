package Controller;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//@WebServlet("/returnBook")
public class ReturnBook extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        int bookId = Integer.parseInt(request.getParameter("bookId"));

        try {
            Connection con = util.DBUtil.getConnection();
            con.setAutoCommit(false);
            PreparedStatement ps = con.prepareStatement("UPDATE BorrowedBooks SET returned = 1 WHERE user_id = ? AND book_id = ?");
            ps.setString(1, userId);
            ps.setInt(2, bookId);
            int rows = ps.executeUpdate();

            if (rows > 0) {
                ps = con.prepareStatement("UPDATE Books SET availability = 'Available' WHERE book_id = ?");
                ps.setInt(1, bookId);
                ps.executeUpdate();
                
                // Notify user
                ps = con.prepareStatement("INSERT INTO Notifications (user_id, message, date) VALUES (?, ?, NOW())");
                ps.setString(1, userId);
                ps.setString(2, "Book returned successfully.");
                ps.executeUpdate();

                con.commit();
                response.getWriter().write("Book returned successfully.");
            } else {
                response.getWriter().write("Failed to return book.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("An error occurred.");
        }
    }
}
