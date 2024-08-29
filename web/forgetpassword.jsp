<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: skyblue;
            padding: 20px;
            
        }
        .container {
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 20px;
            width: 400px;
            margin: 0 auto;
        }
        .form-group {
            margin-bottom: 20px;
          
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 8px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #26b7f5;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #26b7f5;
        }
        .error-message {
            color: #ff0000;
            font-size: 14px;
            margin-top: 5px;
        }
        .success-message {
            color: #008000;
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
<script>
    function getmesg(){
        return confirm("reset sucessful");
    }
</script>
</head>

   
<body>
    <div class="container">
        <h2>Reset Password</h2>
        
       
        <% String errorMessage = (String) request.getAttribute("error"); %>
        <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
            <div class="error-message"><%= errorMessage %></div>
        <% } %>
        
        
        <% String successMessage = (String) request.getAttribute("message"); %>
        <% if (successMessage != null && !successMessage.isEmpty()) { %>
            <div class="success-message"><%= successMessage %></div>
            
        <% } %>
       
        
        <form action="index.html" method="post">
            <div class="form-group">
                <label for="password">Enter Received password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <input type="submit" value="Reset Password" onlclick="return getmesg()">
                  </div>
        </form>
           
    </div>
</body>
</html>
