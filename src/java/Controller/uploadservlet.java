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
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/uploadservlet")
@MultipartConfig
public class uploadservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookCode = request.getParameter("bookCode");
        String bookTitle = request.getParameter("bookTitle");
        String author = request.getParameter("author");
        Part filePart = request.getPart("file");

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String fileType = filePart.getContentType();

        if (!fileType.equals("application/pdf")) {
            response.getWriter().println("Only PDF files are allowed!");
            return;
        }

        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        // Generate a unique file name by appending the current timestamp
        String uniqueFileName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + "_" + fileName;
        String filePath = uploadPath + File.separator + uniqueFileName;

        File file = new File(filePath);
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, file.toPath());
        }

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/librarydb", "root", "");
                 PreparedStatement statement = connection.prepareStatement("INSERT INTO books (title,author,book_code,published_year,file_path,availability) VALUES (?,?,?,?,?,'Available')")) {

                statement.setString(1, bookCode);
                statement.setString(2, bookTitle);
                statement.setString(3, author);
                statement.setString(4, filePath);
                statement.executeUpdate();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("JDBC Driver not found: " + e.getMessage());
            return;
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
            return;
        }

        response.getWriter().println("Book uploaded successfully!");
    }
}
