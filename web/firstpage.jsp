<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
     <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/style3.css">
    <style>
      


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
    <meta charset="UTF-8">
    <title>Library Management System - IPRC Karongi</title>
</head>
<body>
<jsp:include page="header.jsp" />
    <jsp:include page="navigation.jsp" />
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
