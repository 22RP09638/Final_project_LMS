<%@page import="java.sql.*, java.util.*"%>
<%@page import="util.DBUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
    <title>Borrowed Books Report</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/style3.css">
</head>
<body>
    <jsp:include page="header.jsp" />
   

    <div class="container">
        <h1>Borrowed Books Report</h1>

        <!-- Form to input date range -->
        <form method="post">
            <label for="startDate">Start Date:</label>
            <input type="date" id="startDate" name="startDate" required>
            <label for="endDate">End Date:</label>
            <input type="date" id="endDate" name="endDate" required>
            <button type="submit">Generate Report</button>
           <a href="admin-dashboard.jsp" style="text-decoration: none; color: #ffffff; background-color: #294c8e; padding: 10px 20px; border-radius: 5px; font-weight: bold;">Back</a>
        </form>
        
        <br><br>
        
        <table>
            <tr>
                <th>Title</th>
                <th>User Email</th>
                <th>Borrow Date</th>
            </tr>
            <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");
                int bookCount = 0;

                if (startDate != null && endDate != null) {
                    try {
                        con = DBUtil.getConnection();

                        String sql = "SELECT b.title, u.email, bb.borrow_date " +
                                     "FROM Books b JOIN BorrowedBooks bb ON b.book_id = bb.book_id " +
                                     "JOIN Users u ON bb.user_id = u.user_id " +
                                     "WHERE bb.borrow_date BETWEEN ? AND ?";
                        ps = con.prepareStatement(sql);
                        ps.setString(1, startDate);
                        ps.setString(2, endDate);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            String title = rs.getString("title");
                            String email = rs.getString("email");
                            java.util.Date borrowDate = rs.getDate("borrow_date");
                            bookCount++;
            %>
            <tr>
                <td><%= title %></td>
                <td><%= email %></td>
                <td><%= new SimpleDateFormat("yyyy-MM-dd").format(borrowDate) %></td>
            </tr>
            <%
                        }
            %>
        </table>
        
        <br>
        <p><strong>Total Number of Books Borrowed:</strong> <%= bookCount %></p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="window.print()" style="background-color: #294c8e; color: white; padding: 10px 20px; text-align: center; text-decoration: none; display: inline-block; border-radius: 5px; font-size: 16px; border: none; cursor: pointer;">Print</a>
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
                }
            %>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>
