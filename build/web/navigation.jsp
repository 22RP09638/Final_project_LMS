
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <script>
        function msg(){
            return confirm("Are you sure want to logout?");
        }
    </script>
<nav class="nav">
            <a href="firstpage.jsp">Home</a>
            <a href="searchbook.jsp">Search Book</a>
            <a href="userInfo.jsp">My Information</a>
            <a href="viewBorrowedBooks.jsp">View My Borrowed Books</a>
            <a href="viewNotifications.jsp">View Notifications</a>
            <a href="userHistory.jsp">View Borrowing History</a>
            <a href="comment.jsp">comment</a>
            <a href="logout" onclick="return msg()">Logout</a>
        </nav>
</head>
</html>