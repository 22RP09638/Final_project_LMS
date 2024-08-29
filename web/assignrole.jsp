<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management System</title>
    <link rel="stylesheet" href="styles.css"> <!-- Link to your CSS file -->
    <style>
        
    </style>
</head>
<body>
   
 <jsp:include page="header.jsp" />
    <div id="super-admin-dashboard" class="page">
      <h1>Super Admin Dashboard</h1>
      <div class="seye">
        <form method="post" action="addUser" onsubmit="return validateForm()">
            <h1>ADD USER</h1>
            <label for="username">Username or student Registration Number:</label>
            <input type="text" id="username" name="username" required>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            <label for="role">Role:</label>
            <select id="role" name="role" required>
                <option value="Student">Student</option>
                <option value="Staff">Staff</option>
                 <option value="admin">admin</option>
            </select>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            <button type="submit">ADD USER</button>
        </form>
        
        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <p class="error-message"><%= errorMessage %></p>
        <% } %>
    </div>
    
  <jsp:include page="footer.jsp" />
  
</body>
</html>
