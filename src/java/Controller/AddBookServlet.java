package Controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.util.UUID;

//@WebServlet("/AddBookServlet")
@MultipartConfig
public class AddBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookTitle = request.getParameter("bookTitle");
        String author = request.getParameter("author");
        String bookCode = request.getParameter("bookCode");
        String year = request.getParameter("year");
        Part filePart = request.getPart("file");

        if (filePart == null) {
            response.getWriter().println("File part is missing!");
            return;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String fileType = filePart.getContentType();

        if (fileType == null || !fileType.equals("application/pdf")) {
            response.getWriter().println("Only PDF files are allowed!");
            return;
        }

        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String uniqueFileName = UUID.randomUUID().toString().substring(0, 8) + ".pdf";
        String filePath = uploadPath + File.separator + uniqueFileName;

        File file = new File(filePath);
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, file.toPath());
        } catch (IOException e) {
            e.printStackTrace();
            response.getWriter().println("File upload failed: " + e.getMessage());
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/librarydb", "root", "");
                 PreparedStatement statement = connection.prepareStatement(
                         "INSERT INTO books (title, author, book_code, published_year, file_path, availability) VALUES (?, ?, ?, ?, ?, 'Available')")) {

                statement.setString(1, bookTitle);
                statement.setString(2, author);
                statement.setString(3, bookCode);
                statement.setString(4, year);
                statement.setString(5, filePath);
                int rowsAffected = statement.executeUpdate();

                if (rowsAffected > 0) {
                
                     response.sendRedirect("admin-dashboard.jsp");
                    
                } else {
                    response.getWriter().println("Failed to add book.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }
}
