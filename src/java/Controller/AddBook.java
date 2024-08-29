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

//@WebServlet("/AddBook")
//@MultipartConfig
public class AddBook extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookTitle = request.getParameter("bookTitle");
        String author = request.getParameter("author");
        String bookCode = request.getParameter("bookCode");
        String year = request.getParameter("year");
        Part filePart = request.getPart("file");

        if (filePart == null || filePart.getSubmittedFileName().isEmpty()) {
            request.setAttribute("message", "File is required!");
            request.getRequestDispatcher("addBook.jsp").forward(request, response);
            return;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String fileType = filePart.getContentType();

        if (!fileType.equals("application/pdf")) {
            request.setAttribute("message", "Only PDF files are allowed!");
            request.getRequestDispatcher("addBook.jsp").forward(request, response);
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
                statement.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Database error: " + e.getMessage());
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
            return;
        }

        request.setAttribute("message", "Book uploaded successfully!");
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }
}
