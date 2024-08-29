<!DOCTYPE html>
<html>
<head>
    <title>Register User</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f5f5f5;
            font-family: Arial, sans-serif;
        }

        .seye {
            width: 90%;
            max-width: 600px;
            padding: 0;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }

        h1 {
            margin: 0;
            color: #fff;
            background-color: #294c8e;
            padding: 10px;
            border-radius: 5px 5px 0 0;
            text-align: center;
            margin-top: -10px;
            width: 100%;
            margin-left: -10px;
        }

        form {
            display: flex;
            flex-direction: column;
            padding: 10px;
        }

        label {
            margin-bottom: 3px;
            color: #333;
            font-size: 14px;
        }

        input, select {
            margin-bottom: 10px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            width: 100%;
            box-sizing: border-box;
        }

        button {
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #294c8e;
            color: #fff;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 100%;
            max-width: 200px;
            align-self: center;
        }

        button:hover {
            background-color: #2d4373;
        }

        p {
            margin-top: 10px;
            text-align: center;
            font-size: 14px;
        }

        a {
            color: #3b5998;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
            font-size: 14px;
        }
    </style>
    <script>
        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            if (password !== confirmPassword) {
                alert("Passwords do not match.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="seye">
        <form method="post" action="addUser" onsubmit="return validateForm()">
            <h1>Sign up As guest</h1>
             <br/>
            <label for="username">Full Name:</label>
            <input type="text" id="username" name="username" required/>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required/>
            <input type="hidden" value="external" name="role" required />
        
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            <button type="submit">SIGNUP AS GUEST</button>
            <p>If you have an account, click here to <a href="login.jsp">LOGIN</a></p>
        </form>
        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <p class="error-message"><%= errorMessage %></p>
        <% } %>
    </div>
</body>
</html>
