package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebServlet("/selectData")
public class viewcomment extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Database credentials
        String jdbcURL = "jdbc:mysql://localhost:3306/librarydb";
        String dbUser = "root";
        String dbPassword = "";

        // Database query
        String sql = "SELECT comment,role,date FROM comment";

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the connection
            Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Create a statement
            PreparedStatement statement = connection.prepareStatement(sql);

            // Execute the query
            ResultSet resultSet = statement.executeQuery();

            // Process the result set
            out.println("<html><body><table border='1'>");
            out.println("<tr><th>comment</th><th>role</th><th>date</th></tr>");
            while (resultSet.next()) {
                String comment = resultSet.getString("comment");
                String role = resultSet.getString("role");
                String date = resultSet.getString("date");
                out.println("<tr><td>" + comment + "</td><td>" + role + "</td><td>" + date + "</td></tr>");
            }
            out.println("</table></body></html>");

            // Close the connections
            resultSet.close();
            statement.close();
            connection.close();

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        } finally {
            out.close();
        }
    }
}
