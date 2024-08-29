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
import javax.servlet.http.HttpSession;
import util.DBUtil;

@WebServlet("/RequestBorrow")  // Make sure this mapping is active
public class RequestBorrow extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html"); 
 PrintWriter out=response.getWriter(); 
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        if(userId == null){
            response.getWriter().write("Login to Borrow Book.");
            return;
        }
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        
        try {
            Connection con = DBUtil.getConnection();
            String sql = "INSERT INTO Requests (user_id, book_id, request_date, status) VALUES (?, ?, NOW(), 'Pending')";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, userId);
            ps.setInt(2, bookId);
            int rows = ps.executeUpdate();
             

            if (rows > 0) {
              response.getWriter().write("<script>alert('Request sent successfully.');</script>");
 request.getRequestDispatcher("index1.jsp").include(request, response); 
               
                
            } else {
                response.getWriter().write("Failed to send request.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("An error occurred: " + e.getMessage());
        }
    }
}
