<%@page import="java.sql.*, java.util.*"%>
<%@page import="util.DBUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script>
        function searchBooks() {
            var searchQuery = document.getElementById('search').value;
            var xhr = new XMLHttpRequest();
            xhr.open('GET', 'searchBooks?query=' + searchQuery, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    document.getElementById('booksTable').innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }

        function requestBorrow(bookId) {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'requestBorrow', true);
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
    <style>
        .h, .f {
            height: 60px;
            width: 100%;
            background-color: #294c8e;
            padding-top: 15px;
            text-align: center;
            margin-left: 0px;
            margin-top: auto;
            color: white;
        }

        .nav a {
            text-decoration: none;
            margin-right: 20px;
            color: black;
        }

        .nav a:hover {
            background-color: #294c8e;
            padding: 15px;
        }
.p{
    text-align: center;
    font-size: 24px;
 margin-top: 70px;
}

.book-list {
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
}

.book {
    background-color: white;
    border: 1px solid #ddd;
    margin: 10px;
    padding: 15px;
    text-align: center;
    width: 200px;
    height: 200px;
}

.book img {
    max-width: 100%;
    height: 200px;
    margin-top: 10px;
}
h2{
  .p{
    text-align: center;
    font-size: 24px;
    margin-bottom: 30px;
}  
}
    </style>
</head>
<body>
    <%
        // Check if the user is logged in
        String email = (String) session.getAttribute("email");
        String role = (String) session.getAttribute("role");
        String userId = (String) session.getAttribute("userId");

        // If any session attribute is null, the user is not logged in
        if (email == null || role == null || userId == null) {
            // Redirect to login page with a message
    %>
        <script>
            alert("Please login first.");
            window.location.href = "login.jsp"; // Redirect to login page
        </script>
    <%
            return; // Stop further processing of the page
        }
    %>

    <jsp:include page="header.jsp" />
    <jsp:include page="navigation.jsp" />
<h1>Guest Dashboard</h1>
    <main>
        <p class="p">Your gateway to endless knowledge and adventure.Explore a world of books and enrich your mind. <br>Our collection is continually expanding, so there's always something new to discover!</p>
        <h2>Featured Books</h2>
        <div class="book-list">
            <div class="book">
                <img src="11.png" alt="Book 1">
               
            </div>
            <div class="book">
                <img src="14.png" alt="Book 2">
                
            </div>
            <div class="book">
                <img src="13.png" alt="Book 3">
               
            </div>
            <!-- Add more books as needed -->
        </div>
    </main>
    <jsp:include page="footer.jsp" />
</body>
</html>
