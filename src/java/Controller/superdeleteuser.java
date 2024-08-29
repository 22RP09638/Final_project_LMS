package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteUserServlet")
public class superdeleteuser extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String URL = "jdbc:mysql://localhost:3306/librarydb"; // Update with your DB details
    private static final String USERNAME = "root"; // Update with your username
    private static final String PASSWORD = ""; // Update with your password

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId = request.getParameter("userId");
        deleteUser(userId, response);
    }

    private void deleteUser(String userId, HttpServletResponse response) throws IOException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        PrintWriter out = response.getWriter();

        response.setContentType("text/html;charset=UTF-8");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);

            String sql = "DELETE FROM users WHERE user_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);

            int rowsDeleted = pstmt.executeUpdate();

            if (rowsDeleted > 0) {
                out.println("<html><body><h3>User deleted successfully. "); response.sendRedirect("addUser.jsp");
            } else {
                out.println("<html><body><h3>Error deleting user.</h3></body></html>");
            }

        } catch (ClassNotFoundException e) {
            out.println("<html><body><h3>Error: JDBC Driver not found: " + e.getMessage() + "</h3></body></html>");
            e.printStackTrace();
        } catch (SQLException e) {
            out.println("<html><body><h3>Error deleting user data: " + e.getMessage() + "</h3></body></html>");
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
