<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>
     <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/style3.css">
    <style>
        h4 {
            text-align: center;
            color: #c59;
            margin-top: 35px;
        }
        form {
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
          
        }
        label {
            display: block;
            margin: 10px 0 5px;
            font-weight: bold;
        }
        input[type="text"], input[type="date"] {
            width: calc(60% - 22px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #70a;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 10px 0;
            border-radius: 4px;
            cursor: pointer;
        }
               
         a.button {
    display: inline-block;
    background-color: #80c; 
    color: white; 
    padding: 10px 20px; 
    text-align: center; 
    text-decoration: none; 
    font-size: 16px; 
    border-radius: 4px;
    border: 1px solid #a50; 
 
    margin-left: 50px;
}

a.button:hover {
    background-color: #567; 
    color: #fff; 
}
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
    </style>
        <script type="text/javascript">
        function validateForm() {
            var title = document.getElementById("title").value;
            if (title.trim() === "") {
                alert("Please enter the name of the book.");
                return false;
            }
            return true;
        }
    </script>
</head>
    <jsp:include page="header.jsp" />
    <jsp:include page="navigation.jsp" />
<body>
    <h1>Search for Books</h1>
    
    <form action="BookSearchServlet" method="get" onsubmit="return validateForm();">
        <label for="title">Book Title:</label>
        <input type="text" id="title" name="title">
        <input type="submit" value="Search">
    </form>
</body>
    <jsp:include page="footer.jsp" />
</html>
