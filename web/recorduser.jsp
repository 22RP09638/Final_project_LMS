<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management System</title>
    <style>
        
.nav a{
   text-decoration:  none;
   color: black;
   margin-top: 50px;
   padding: 20px;
}
.nav a:hover{
background-color: #294c8e;;


   
}
     </style>
      
    
</head>
<body>
   
 <jsp:include page="header.jsp" />
    <div id="super-admin-dashboard" class="page">
      <h1>Super Admin Dashboard</h1>
      <nav class="nav">
          <a href="recorduser.jsp" style="margin-left: 500px;">Record User</a>
      <a href="assignrole.jsp">Assign role</a>
        </nav>
      
     
        <h2>Record Users</h2>
        <form>
          <label for="username">Username:</label>
          <input type="text" id="username" name="username" required>
          
          <label for="password">Password:</label>
          <input type="password" id="password" name="password" required>
          
          <label for="role">Role:</label>
          <select id="role" name="role" required>
            <option value="">Select</option>
            <option value="admin">Admin</option>
            <option value="staff">Staff</option>
            <option value="member">Member</option>
          </select><br><br>
          
          <button type="submit">Record User</button>
        </form>

    
  <jsp:include page="footer.jsp" />
  
</body>
</html>