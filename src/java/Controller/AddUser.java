package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebServlet("/addUser")
public class AddUser extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Error: Passwords do not match.");
            request.getRequestDispatcher("addUser.jsp").forward(request, response);
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = util.DBUtil.getConnection();
            String sql = "INSERT INTO Users (username, password, email, role) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password); // Consider hashing the password before storing
            ps.setString(3, email);
            ps.setString(4, role);
            ps.executeUpdate();

            response.sendRedirect("addUser.jsp"); // Redirect to login page after successful registration
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error adding user: " + e.getMessage());
            request.getRequestDispatcher("guestSignup.jsp").forward(request, response);
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
