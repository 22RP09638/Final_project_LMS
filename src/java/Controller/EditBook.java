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
import util.DBUtil;

//@WebServlet("/editBook")
public class EditBook extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String book_code = request.getParameter("book_code");
        String published_year = request.getParameter("published_year");
        String availability = request.getParameter("availability");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBUtil.getConnection();
            String sql = "UPDATE Books SET title = ?, author = ?, book_code=?,published_year=?,availability = ? WHERE book_id = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, author);
            ps.setString(3, book_code);
            ps.setString(4, published_year);
            ps.setString(5, availability);
            ps.setInt(6, bookId);
            ps.executeUpdate();
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
