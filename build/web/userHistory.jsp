<%@page import="util.DBUtil"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Borrowing History</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/style3.css">
</head>
<body>
      <jsp:include page="header.jsp" />
    <jsp:include page="navigation.jsp" />
    <div class="container">
        <h1>Your Borrowing History</h1>
        <%
            String email = (String) session.getAttribute("email");
            if (email == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            int userId = 0;

            try {
                con = DBUtil.getConnection();
                
                // Fetch user ID based on email
                String userQuery = "SELECT user_id FROM Users WHERE email = ?";
                ps = con.prepareStatement(userQuery);
                ps.setString(1, email);
                rs = ps.executeQuery();
                
                if (rs.next()) {
                    userId = rs.getInt("user_id");
                }
                
                rs.close();
                ps.close();
                
                // Fetch borrowing history
                String sql = "SELECT b.title, b.author, b.book_code,b.published_year, bb.borrow_date, bb.return_date, bb.fine, bb.returned " +
                             "FROM BorrowedBooks bb " +
                             "JOIN Books b ON bb.book_id = b.book_id " +
                             "WHERE bb.user_id = ?";
                ps = con.prepareStatement(sql);
                ps.setInt(1, userId);
                rs = ps.executeQuery();
        %>
        <table>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>Book code</th>
                <th>Published year</th>
                <th>Borrow Date</th>
                <th>Return Date</th>
                <th>Returned</th>
                <th>Fine</th>
            </tr>
            <%
                while (rs.next()) {
                    String title = rs.getString("title");
                    String author = rs.getString("author");
                    String book_code = rs.getString("book_code");
                    String published_year = rs.getString("published_year");
                    Date borrowDate = rs.getDate("borrow_date");
                    Date returnDate = rs.getDate("return_date");
                    boolean returned = rs.getBoolean("returned");
                    double fine = rs.getDouble("fine");
            %>
            <tr>
                <td><%= title %></td>
                <td><%= author %></td>
                <td><%= book_code %></td>
                <td><%= published_year %></td>
                <td><%= borrowDate %></td>
                <td><%= returnDate != null ? returnDate.toString() : "Not Returned" %></td>
                <td><%= returned ? "Yes" : "No" %></td>
                <td><%= fine %></td>
            </tr>
            <%
                }
            %>
        </table>
        <%
            } catch (Exception e) {
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
        <br>
        <a href="index.jsp">Back to Home</a>
           <jsp:include page="footer.jsp" />
    </div>
</body>
</html>
