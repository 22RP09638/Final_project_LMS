package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.DBUtil;

//@WebServlet("/processRequest")
public class ProcessRequest extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int requestId = Integer.parseInt(request.getParameter("requestId"));

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBUtil.getConnection();

            // Update the request status
            String updateRequestStatusSql = "UPDATE Requests SET status = ? WHERE request_id = ?";
            ps = con.prepareStatement(updateRequestStatusSql);
            ps.setString(1, action.equals("approve") ? "Approved" : "Denied");
            ps.setInt(2, requestId);
            ps.executeUpdate();
            ps.close();

            if (action.equals("approve")) {
                // Get user_id and book_id from the request
                String getRequestDetailsSql = "SELECT user_id, book_id FROM Requests WHERE request_id = ?";
                ps = con.prepareStatement(getRequestDetailsSql);
                ps.setInt(1, requestId);
                ResultSet rs = ps.executeQuery();
                int userId = 0, bookId = 0;
                if (rs.next()) {
                    userId = rs.getInt("user_id");
                    bookId = rs.getInt("book_id");
                }
                rs.close();
                ps.close();

                // Check the user's role
                String getUserRoleSql = "SELECT role FROM Users WHERE user_id = ?";
                ps = con.prepareStatement(getUserRoleSql);
                ps.setInt(1, userId);
                rs = ps.executeQuery();
                String role = "";
                if (rs.next()) {
                    role = rs.getString("role");
                }
                rs.close();
                ps.close();

                // Set the return date interval based on the user's role
                int returnDays = role.equals("student") ? 1 : 14;

                // Insert into BorrowedBooks
                String insertBorrowedBookSql = "INSERT INTO BorrowedBooks (user_id, book_id, borrow_date, return_date) VALUES (?, ?, NOW(), DATE_ADD(NOW(), INTERVAL ? DAY))";
                ps = con.prepareStatement(insertBorrowedBookSql);
                ps.setInt(1, userId);
                ps.setInt(2, bookId);
                ps.setInt(3, returnDays);
                ps.executeUpdate();
                ps.close();

                // Update the book's availability
                String updateBookAvailabilitySql = "UPDATE Books SET availability = 'Borrowed' WHERE book_id = ?";
                ps = con.prepareStatement(updateBookAvailabilitySql);
                ps.setInt(1, bookId);
                ps.executeUpdate();
                ps.close();

                // Insert notification for the user
                String notificationMessage = "Your request for the book has been approved.";
                String insertNotificationSql = "INSERT INTO Notifications (user_id, message, date) VALUES (?, ?, NOW())";
                ps = con.prepareStatement(insertNotificationSql);
                ps.setInt(1, userId);
                ps.setString(2, notificationMessage);
                ps.executeUpdate();
            } else {
                // Insert notification for the user if request is denied
                String getRequestDetailsSql = "SELECT user_id FROM Requests WHERE request_id = ?";
                ps = con.prepareStatement(getRequestDetailsSql);
                ps.setInt(1, requestId);
                ResultSet rs = ps.executeQuery();
                int userId = 0;
                if (rs.next()) {
                    userId = rs.getInt("user_id");
                }
                rs.close();
                ps.close();

                String notificationMessage = "Your request for the book has been denied.";
                String insertNotificationSql = "INSERT INTO Notifications (user_id, message, date) VALUES (?, ?, NOW())";
                ps = con.prepareStatement(insertNotificationSql);
                ps.setInt(1, userId);
                ps.setString(2, notificationMessage);
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("admin-dashboard.jsp");
    }
}
