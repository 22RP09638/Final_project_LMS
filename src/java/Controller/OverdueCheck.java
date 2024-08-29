package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.EmailException;
import util.DBUtil;
import util.EmailUtil;

public class OverdueCheck extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ScheduledExecutorService scheduler;

    @Override
    public void init() throws ServletException {
        scheduler = Executors.newSingleThreadScheduledExecutor();
        scheduler.scheduleAtFixedRate(new Runnable() {
            public void run() {
                try {
                    checkAndHandleOverdueBooks();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }, 0, 1, TimeUnit.MINUTES); // Check every hour
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("OverdueCheckServlet is running");
    }

    @Override
    public void destroy() {
        scheduler.shutdownNow();
    }

    private void checkAndHandleOverdueBooks() throws SQLException, EmailException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBUtil.getConnection();

            // Query to get overdue books and user details
            String sql = "SELECT bb.borrow_id, u.email, u.username, b.title, bb.return_date " +
                         "FROM Users u " +
                         "JOIN BorrowedBooks bb ON u.user_id = bb.user_id " +
                         "JOIN Books b ON bb.book_id = b.book_id " +
                         "WHERE bb.return_date < ? AND bb.returned = 0 AND mailed = 0";
            ps = con.prepareStatement(sql);
            ps.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            rs = ps.executeQuery();

            while (rs.next()) {
                int borrowId = rs.getInt("borrow_id");
                String email = rs.getString("email");
                String username = rs.getString("username");
                String title = rs.getString("title");
                Timestamp returnDate = rs.getTimestamp("return_date");

                // Calculate fine
                long daysOverdue = (System.currentTimeMillis() - returnDate.getTime()) / (1000 * 60 * 60 * 24);
                int fine = (int) (daysOverdue * 500); // 500 RWF per day overdue

                // Send email notification
                EmailUtil.sendOverdueEmail(email, username, title, returnDate.toString(), fine);

                // Update the mailed status
                markEmailAsSent(con, borrowId);

                // Update user fine
                updateUserFine(con, borrowId, fine);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }

    private void markEmailAsSent(Connection con, int borrowId) throws SQLException {
        PreparedStatement ps = null;
        try {
            String updateSql = "UPDATE BorrowedBooks SET mailed = 1 WHERE borrow_id = ?";
            ps = con.prepareStatement(updateSql);
            ps.setInt(1, borrowId);
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
        }
    }

    private void updateUserFine(Connection con, int borrowId, int fine) throws SQLException {
        PreparedStatement ps = null;
        try {
            String updateSql = "UPDATE BorrowedBooks SET fine = fine + ? WHERE borrow_id = ?";
            ps = con.prepareStatement(updateSql);
            ps.setInt(1, fine);
            ps.setInt(2, borrowId);
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
        }
    }
}
