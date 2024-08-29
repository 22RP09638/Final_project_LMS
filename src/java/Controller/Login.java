package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import util.DBUtil;

//@WebServlet("/login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         response.setContentType("text/html"); 
 PrintWriter out=response.getWriter();  
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBUtil.getConnection();
            String sql = "SELECT * FROM Users WHERE email = ? AND password = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, pass);
            rs = ps.executeQuery();

            if (rs.next()) {
            String role = rs.getString("role");
            String userId = rs.getString("user_id");
            HttpSession session = request.getSession();
            session.setAttribute("userId", userId);
            session.setAttribute("email", email);
            session.setAttribute("role", role);

                System.out.println("User role: " + role);
                if ("admin".equals(role)) {
                    response.sendRedirect("addUser.jsp");
                } 
                
                else if("student".equals(role)){
                     response.sendRedirect("index3.jsp");
                }
                 else if("staff".equals(role)){
                     response.sendRedirect("index1.jsp");
                }
                  else if("external".equals(role)){
                     response.sendRedirect("index2.jsp");
                }
                  else if("librarian".equals(role)){
                     response.sendRedirect("admin-dashboard.jsp");
                }
                
            } else {
                out.print("Sorry, username or password incorrect!"); 
 request.getRequestDispatcher("login.jsp").include(request, response); 
               
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
