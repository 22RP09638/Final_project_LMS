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

//@WebServlet("/searchBooks")
public class SearchBooks extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        response.setContentType("text/html");

        try {
            Connection con = DBUtil.getConnection();
            String sql = "SELECT * FROM Books WHERE availability = 'Available' AND (title LIKE ? OR author LIKE ? OR book_code LIKE ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");
            ps.setString(3, "%" + query + "%");
            ResultSet rs = ps.executeQuery();

            StringBuilder result = new StringBuilder();
            while (rs.next()) {
                int bookId = rs.getInt("book_id");
                String title = rs.getString("title");
                String author = rs.getString("author");
                String book_code = rs.getString("book_code");

                result.append("<tr>")
                      .append("<td>").append(title).append("</td>")
                      .append("<td>").append(author).append("</td>")
                      .append("<td>").append(book_code).append("</td>")
                      .append("<td>Available</td>")
                      .append("<td><button onclick=\"requestBorrow(").append(bookId).append(")\"> Request Borrow</button></td>")
                      .append("</tr>");
            }

            response.getWriter().write(result.toString());
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Error occurred while searching books.");
        }
    }
}
