<%@page import="java.net.URLEncoder"%>
<%@page import="util.DBUtil"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Book</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/style3.css">
    <style>
                form label, 
        form input, 
        form select {
            display: block; /* Ensures each element takes up the full width */
            margin-bottom: -9px; /* Adjust the margin-bottom value as needed */
        }

        form select option {
            padding-bottom: -5px; /* Option padding (for visual effect, but note that most browsers don't render padding on option elements) */
        }
        button{
            background: #294c8e;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
  
    <div class="container">
        <h1>Edit Book</h1>
        <%
//            String email = (String) session.getAttribute("email");
//            if (email == null) {
//                response.sendRedirect("login.jsp");
//                return;
//            }

            int bookId = Integer.parseInt(request.getParameter("bookId"));
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            String title = "";
            String author = "";
            String book_code = "";
            String published_year = "";
            String file_path = "";
            String availability = "";

            try {
                con = DBUtil.getConnection();
                String sql = "SELECT * FROM Books WHERE book_id = ?";
                ps = con.prepareStatement(sql);
                ps.setInt(1, bookId);
                rs = ps.executeQuery();

                if (rs.next()) {
                    title = rs.getString("title");
                    author = rs.getString("author");
                    book_code = rs.getString("book_code");
                    published_year = rs.getString("published_year");
                    file_path = rs.getString("file_path");
                    availability = rs.getString("availability");
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
        %>
             <a href="admin-dashboard.jsp" style="text-decoration: none; color: #ffffff; background-color: #294c8e; padding: 10px 20px; border-radius: 5px; font-weight: bold;">Back</a>
        <form action="editBook" method="post">
            <input type="hidden" name="bookId" value="<%= bookId %>">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" value="<%= title %>" required><br>
            <label for="author">Author:</label>
            <input type="text" id="author" name="author" value="<%= author %>" required><br>
            <label for="book_code">Book code</label>
            <input type="text" id="book_code" name="book_code" value="<%= book_code %>" required><br>
            <label for="published_year">Published year</label>
            <input type="text" id="published_year" name="published_year" value="<%= published_year %>" required><br>
          
            <input type="file" id="file_path" name="file" value="<a href="DownloadFile?filePath=<%= URLEncoder.encode(file_path, "UTF-8") %>" target="_blank" style="text-decoration:none"><br>
            <label for="availability">Availability:</label>
            <select id="availability" name="availability" required>
                <option value="Available" <%= "Available".equals(availability) ? "selected" : "" %>>Available</option>
                <option value="Borrowed" <%= "Borrowed".equals(availability) ? "selected" : "" %>>Borrowed</option>
            </select><br>
            <button type="submit">Update Book</button>
        </form>
        <br>
        <a href="admin-dashboard.jsp">Back to Admin Dashboard</a>
    </div>
              <jsp:include page="footer.jsp" />
</body>
</html>
