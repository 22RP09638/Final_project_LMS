package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.DBUtil;

//@WebServlet("/updateUserInfo")
public class UpdateUserInfo extends HttpServlet {
   private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          response.setContentType("text/html"); 
 PrintWriter out=response.getWriter(); 
        String username = request.getParameter("username");
        String email = request.getParameter("email");
         String user_id = request.getParameter("user_id");

        if (username == null || username.isEmpty() || email == null || email.isEmpty()) {
            response.getWriter().write("Username and email cannot be empty.");
            return;
        }

        try (Connection con = DBUtil.getConnection()) {
            String sql = "UPDATE users SET email = ? ,username = ? WHERE user_id =? ";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, username);
              ps.setString(3, user_id);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                request.getRequestDispatcher("userInfo.jsp").include(request, response); 
            } else {
                response.getWriter().write("No user found with the provided username.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Failed to update user information: " + e.getMessage());
        }
    }
}


