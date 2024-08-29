<%@page import="java.sql.*, java.util.*"%>
<%@page import="util.DBUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
    <title>Returned Books Report</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/style3.css">
</head>
<body>
    <jsp:include page="header.jsp" />
   

    <div class="container">
        <h1>Returned Books Report</h1>
       
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
        
        <table border="1" cellspacing="0" cellpadding="5">
            <tr>
                <th>Title</th>
                <th>User Email</th>
                <th>Return Date</th>
            </tr>
            <%
                // Initialize database variables
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");
                int bookCount = 0;

                // Validate if startDate and endDate are provided
                if (startDate != null && endDate != null) {
                    try {
                        // Establish the database connection
                        con = DBUtil.getConnection();

                        // SQL query to select returned books within the date range (inclusive of start and end dates)
                        String sql = "SELECT b.title, u.email, bb.return_date " +
                                     "FROM Books b " +
                                     "JOIN BorrowedBooks bb ON b.book_id = bb.book_id " +
                                     "JOIN Users u ON bb.user_id = u.user_id " +
                                     "WHERE bb.return_date BETWEEN ? AND ?";

                        // Prepare and set the SQL statement parameters
                        ps = con.prepareStatement(sql);

                        // Set the startDate and endDate as parameters
                        ps.setString(1, startDate);
                        ps.setString(2, endDate);

                        // Execute the query and process the result set
                        rs = ps.executeQuery();

                        // Iterate through the result set and populate the table
                        while (rs.next()) {
                            String title = rs.getString("title");
                            String email = rs.getString("email");
                            java.util.Date returnDate = rs.getDate("return_date");

                            // Increment the book count for each returned book
                            bookCount++;
            %>
            <tr>
                <td><%= title %></td>
                <td><%= email %></td>
                <td><%= new SimpleDateFormat("yyyy-MM-dd").format(returnDate) %></td>
            </tr>
            <%
                        }
            %>
        </table>
        
        <!-- Display the total count of returned books -->
        <br>
        <p><strong>Total Number of Books Returned:</strong> <%= bookCount %></p>
       <a href="#" onclick="window.print()" style="background-color: #294c8e; color: white; padding: 10px 20px; text-align: center; text-decoration: none; display: inline-block; border-radius: 5px; font-size: 16px; border: none; cursor: pointer;">Print</a>
        <%
                    } catch (Exception e) {
                        // Handle any exceptions that occur during the process
                        e.printStackTrace();
                    } finally {
                        // Clean up and close the database resources
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
