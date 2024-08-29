package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebServlet("/comment")
public class comment extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
   response.setContentType("text/html"); 
    PrintWriter out = response.getWriter(); 

        String comment = request.getParameter("comment");
          String role = request.getParameter("role");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = util.DBUtil.getConnection();
            String sql = "INSERT INTO comment (comment,role) VALUES (?,?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, comment);
             ps.setString(2, role);
            ps.executeUpdate();
out.print("<script>('Comment Added Successfuly.'); </script>");
            response.sendRedirect("comment.jsp"); // Redirect to login page after successful registration
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error adding user: " + e.getMessage());
            request.getRequestDispatcher("addUser.jsp").forward(request, response);
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
