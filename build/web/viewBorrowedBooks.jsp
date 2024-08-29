<%@page import="java.sql.*, java.util.*"%>
<%@page import="util.DBUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
    <title>My Borrowed Books</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/style3.css">
    <style>
        .overdue {
            color: red;
        }
    </style>
    <script>
        function returnBook(bookId) {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'returnBook', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    alert(xhr.responseText);
                    window.location.reload();
                }
            };
            xhr.send('bookId=' + bookId);
        }
    </script>
</head>
<body>
     <jsp:include page="header.jsp" />
    <jsp:include page="navigation.jsp" />

    <div class="container">
        <h1>My Borrowed Books</h1>
       
        <br><br>
        <table>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>Book code</th>
                <th>Published Year</th>
                <th>Borrow Date</th>
                <th>Return Date</th>
                <th>Action</th>
                <th>Fine</th>
            </tr>
            <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                String email = (String) session.getAttribute("email");

                try {
                    con = DBUtil.getConnection();

                    String sql = "SELECT b.title, b.author, b.book_code, b.published_year, bb.borrow_id, bb.borrow_date, bb.return_date, b.book_id, " +
                                 "DATEDIFF(CURDATE(), bb.return_date) AS days_overdue " +
                                 "FROM Books b JOIN BorrowedBooks bb ON b.book_id = bb.book_id " +
                                 "JOIN Users u ON bb.user_id = u.user_id WHERE u.email = ? AND bb.returned = 0";
                    ps = con.prepareStatement(sql);
                    ps.setString(1, email);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                    int borrowId = rs.getInt("borrow_id");
                        int bookId = rs.getInt("book_id");
                        String title = rs.getString("title");
                        String author = rs.getString("author");
                        String book_code = rs.getString("book_code");
                        String published_year = rs.getString("published_year");
                        String bdate = rs.getString("borrow_date");
                        String rdate = rs.getString("return_date");
                        java.util.Date borrowDate = rs.getDate("borrow_date");
                        java.util.Date returnDate = rs.getDate("return_date");
                        int daysOverdue = rs.getInt("days_overdue");
                        int fine = daysOverdue > 0 ? daysOverdue * 500 : 0; // Calculate fine based on overdue days

                        // Determine if the book is overdue
                        boolean isOverdue = daysOverdue > 0;
                        String returnDateClass = isOverdue ? "overdue" : "";
                        String text = isOverdue ? "Overdue!" : "";
                        
                        if(isOverdue){
                            String updateSql = "UPDATE BorrowedBooks SET fine = fine + ? WHERE borrow_id = ?";
                            ps = con.prepareStatement(updateSql);
                            ps.setInt(1, fine);
                            ps.setInt(2, borrowId);
                            ps.executeUpdate();
                        }

            %>
            <tr>
                <td><%= title %></td>
                <td><%= author %></td>
                <td><%= book_code %></td>
                <td><%= published_year %></td>
                <td><%= new SimpleDateFormat("yyyy-MM-dd").format(borrowDate) %></td>
                <td class="<%= returnDateClass %>"><%= new SimpleDateFormat("yyyy-MM-dd").format(returnDate) %> <%= text %></td>
                <td><button onclick="returnBook(<%= bookId %>)">Return</button></td>
                <td><%= fine > 0 ? fine + " RWF" : "No Fine" %></td>
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
        <jsp:include page="footer.jsp" />

</body>
</html>
