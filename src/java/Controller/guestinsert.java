package Controller;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//WebServlet("/addUser")
public class guestinsert extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/librarydb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get parameters from the form
        String fullname = request.getParameter("username");
        String email = request.getParameter("email");
        String nationalid = request.getParameter("national");
        String password = request.getParameter("password");

        // Validate that passwords match (this could be done better in the JSP form validation)
        String confirmPassword = request.getParameter("confirmPassword");
        if (!password.equals(confirmPassword)) {
            // Redirect to the form with an error message
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("guestSignup.jsp").forward(request, response);
            return;
        }

        // JDBC code to insert into the database
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL Insert query
            String sql = "INSERT INTO guest (fullname, email, nationalid, password) VALUES (?, ?, ?, ?)";

            // Use a prepared statement to set values
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullname);
            stmt.setString(2, email);
            stmt.setString(3, nationalid);
            stmt.setString(4, password); // You might want to hash the password here

            // Execute update and check if the insertion was successful
            int rows = stmt.executeUpdate();
            if (rows > 0) {
                // Successful insertion
                response.sendRedirect("loginguest.jsp"); // Redirect to a success page
            } else {
                // Insertion failed
                request.setAttribute("errorMessage", "Failed to register user.");
                request.getRequestDispatcher("guestSignup.jsp").forward(request, response);
            }

            // Close resources
            stmt.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            // Handle database connection issues
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred. Please try again.");
            request.getRequestDispatcher("guestSignup.jsp").forward(request, response);
        }
    }
}
