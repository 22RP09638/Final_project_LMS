<%@page import="util.DBUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Borrowed Books</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/style3.css">
</head>
<body>
    <div class="container">
        <h1>All Borrowed Books</h1>
        <nav>
            <a href="admin-dashboard.jsp">Admin Dashboard</a>
            <a href="logout">Logout</a>
        </nav>
        <br><br>
        <table>
            <tr>
                <th>Username</th>
                <th>Role</th>
                <th>Title</th>
                <th>Author</th>
                <th>Book code</th>
                <th>Published year</th>
                <th>Borrow Date</th>
                <th>Return Date</th>
                <th>Overdue</th>
            </tr>
            <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    con = DBUtil.getConnection();

                    String sql = "SELECT u.email, u.role, b.title, b.author, b.book_code, b.published_year,bb.borrow_date, bb.return_date " +
                                 "FROM Users u JOIN BorrowedBooks bb ON u.user_id = bb.user_id " +
                                 "JOIN Books b ON bb.book_id = b.book_id";
                    ps = con.prepareStatement(sql);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                        String email = rs.getString("email");
                        String role = rs.getString("role");
                        String title = rs.getString("title");
                        String author = rs.getString("author");
                        String book_code = rs.getString("book_code");
                        String published_year = rs.getString("published_year");
                        
                        String bdate = rs.getString("borrow_date");
                        String rdate = rs.getString("return_date");
                        java.sql.Date borrowDate = rs.getDate("borrow_date");
                        java.sql.Date returnDate = rs.getDate("return_date");

                        // Determine if the book is overdue
                        java.util.Date currentDate = new java.util.Date();
                        boolean isOverdue = returnDate.before(new java.sql.Date(currentDate.getTime()));
                        String returnDateClass = isOverdue ? "overdue" : "";
                        String text = isOverdue ? "Overdue!" : "";
            %>
            <tr>
                <td><%= email %></td>
                <td><%= role %></td>
                <td><%= title %></td>
                <td><%= author %></td>
                <td><%= book_code %></td>
                <td><%= published_year %></td>
                <td><%= borrowDate %></td>
                <td class="<%= returnDateClass %>"><%= rdate %></td>
                <td><%= isOverdue ? "Yes" : "No" %></td>
            </tr>
            <%
                    }
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
        </table>
    </div>
</body>
</html>
