<%@page import="util.DBUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/style3.css">
    <script>
        function showSection(sectionId) {
            document.getElementById('addBookForm').style.display = 'none';
            document.getElementById('borrowedBooks').style.display = 'none';
            document.getElementById('borrowRequests').style.display = 'none';
            document.getElementById(sectionId).style.display = 'block';
        }
    </script>
    <style>
  .nav a{
   text-decoration:  none;
   margin-right: 20px;
   color: black;
   
}
.nav a:hover{
background-color: #294c8e;;
padding: 15px;

   
}
    </style>
</head>
<body>
     
      <jsp:include page="header.jsp" />
   
    <div class="container">
        
        <!-- View Borrowed Books -->
        <div id="borrowedBooks" style="">
            <h2>Borrowed Books</h2>
            <table border="1">
                <tr>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Borrower</th>
                    <th>Borrow Date</th>
                    <th>Return Date</th>
                    <th>Returned</th>
                </tr>
                <%
                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        con = DBUtil.getConnection();
                        String sql = "SELECT b.title, b.author, u.email AS borrower, bb.borrow_date, bb.return_date, bb.returned " +
                                     "FROM BorrowedBooks bb " +
                                     "JOIN Books b ON bb.book_id = b.book_id " +
                                     "JOIN Users u ON bb.user_id = u.user_id";
                        ps = con.prepareStatement(sql);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            String title = rs.getString("title");
                            String author = rs.getString("author");
                            String borrower = rs.getString("borrower");
                            Date borrowDate = rs.getDate("borrow_date");
                            Date returnDate = rs.getDate("return_date");
                            boolean returned = rs.getBoolean("returned");
                %>
                <tr>
                    <td><%= title %></td>
                    <td><%= author %></td>
                    <td><%= borrower %></td>
                    <td><%= borrowDate %></td>
                    <td><%= returnDate != null ? returnDate.toString() : "Not Returned" %></td>
                    <td><%= returned ? "Yes" : "No" %></td>
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
    </div>
          <jsp:include page="footer.jsp" />
</body>
</html>
