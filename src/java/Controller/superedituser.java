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

//@WebServlet("/ManageUserServlet")
public class superedituser extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String URL = "jdbc:mysql://localhost:3306/librarydb"; // Update with your DB details
    private static final String USERNAME = "root"; // Update with your username
    private static final String PASSWORD = ""; // Update with your password

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("update".equals(action)) {
            updateUser(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String userId = request.getParameter("userId");

      
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        String role = request.getParameter("role");
        String email = request.getParameter("email");

        Connection conn = null;
        PreparedStatement pstmt = null;

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);

            String sql = "UPDATE users SET username = ?, role = ?, email = ? WHERE user_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, role);
            pstmt.setString(3, email);
            pstmt.setString(4, userId);

            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
                out.println("<html><body><h3>User updated successfully. ");response.sendRedirect("addUser.jsp");
            } else {
                out.println("<html><body><h3>Error updating user.</h3></body></html>");
            }

        } catch (ClassNotFoundException e) {
            out.println("<html><body><h3>Error: JDBC Driver not found: " + e.getMessage() + "</h3></body></html>");
            e.printStackTrace();
        } catch (SQLException e) {
            out.println("<html><body><h3>Error updating user data: " + e.getMessage() + "</h3></body></html>");
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

   
        
}
