<!DOCTYPE html>
<html>
<head>
    <title>Register User</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
           
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
            margin-top: 60px;
            align-items: center;
            margin-left: 300px;
        }

        h2 {
            margin: 0;
            color: #fff;
            background-color: #294c8e;
            padding: 10px;
            width:580px;
            border-radius: 5px 5px 0 0;
            text-align: center;
            margin-top: -10px;
            
            margin-left: -10px;
            margin-left: -50px;
            
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
            padding: -14px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            width: 100%;
            box-sizing: border-box;
            height: 25px;
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
        .nav a{
    
            margin-left: 100px;
            text-decoration: none;
            color:black;
            padding-top: -70px;
            padding: 14px 16px;
        }
         .nav a:hover{
         background-color: #294c8e;
         
        
            
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
        <script>
        function showSection(sectionId) {
            document.getElementById('adduser').style.display = 'none';
            document.getElementById('viewallusers').style.display = 'none';
            document.getElementById('managerusers').style.display = 'none';
            document.getElementById(sectionId).style.display = 'block';
        }
    </script>
   <script>
        function msg(){
            return confirm("Are you sure want to logout?");
        }
       
        function delmsg(){
            return confirm("Are you sure want to Delete this user?");
        }
    </script>
</head>
<body>
     <jsp:include page="header.jsp" />
     <ul class="nav">
         <a href="#" onclick="showSection('adduser')">Add User</a>
         <a  href="#" onclick="showSection('viewallusers')">View All users</a>
         <a  href="#" onclick="showSection('managerusers')">Manager Users</a>
         <a  href="logout" onclick="return msg()">Logout</a>
     </ul>
     <div id="adduser" style="display: none;">
<div class="seye">
        <form method="post" action="addUser" onsubmit="return validateForm()">
            <h2>ADD USER</h2>
            <label for="username">Username or student Registration Number:</label>
            <input type="text" id="username" name="username" required>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            <label for="role">Role:</label>
            <select id="role" name="role" required>
                <option value="Student">Student</option>
                <option value="Staff">Staff</option>
                 <option value="admin">admin</option>
                 <option value="librarian">librarian</option>
            </select>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            <button type="submit">ADD USER</button>
            <p>click here to <a href="admin-dashboard.jsp">back to home</a></p>
        </form>
        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <p class="error-message"><%= errorMessage %></p>
        <% } %>
    </div>
     </div>
     <div id="viewallusers" style="display: none;">   
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>

<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    String URL = "jdbc:mysql://localhost:3306/librarydb"; // Update with your database details
    String USERNAME = "root"; // Update with your username
    String PASSWORD = ""; // Update with your password

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        stmt = conn.createStatement();
        String sql = "SELECT * FROM users";
        rs = stmt.executeQuery(sql);
%>

<!DOCTYPE html>
<html>
<head>
    <title>List Users</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .button { padding: 5px 10px; border: none; border-radius: 3px; color: white; cursor: pointer; text-decoration: none; }
        .edit-button { background-color: #4CAF50; }
        .delete-button { background-color: #f44336; }
        .edit-button:hover { background-color: #45a049; }
        .delete-button:hover { background-color: #e53935; }
    </style>
</head>
<body>
    <h1>User List</h1>
    <table>
        <thead>
            <tr>
                <th>User ID</th>
                <th>Username</th>
                <th>Role</th>
                <th>Email</th>
            </tr>
        </thead>
        <tbody>
            <%
                boolean hasData = false;
                while (rs.next()) {
                    hasData = true;
                    String id = rs.getString("user_id");
                    String username = rs.getString("username");
                    String role = rs.getString("role");
                    String email = rs.getString("email");
            %>
            <tr>
                <td><%= id %></td>
                <td><%= username %></td>
                <td><%= role %></td>
                <td><%= email %></td>

            </tr>
            <%
                }

                if (!hasData) {
            %>
            <tr>
                <td colspan="5">No users found.</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>

<%
    } catch (ClassNotFoundException e) {
        out.println("<h3>Error: JDBC Driver not found: " + e.getMessage() + "</h3>");
    } catch (SQLException e) {
        out.println("<h3>Error retrieving data: " + e.getMessage() + "</h3>");
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

     </div>
     <div id="managerusers" style="display: none;">  
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>

<%


    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        stmt = conn.createStatement();
        String sql = "SELECT * FROM users";
        rs = stmt.executeQuery(sql);
%>

<!DOCTYPE html>
<html>
<head>
    <title>List Users</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .button { padding: 5px 10px; border: none; border-radius: 3px; color: white; cursor: pointer; text-decoration: none; }
        .edit-button { background-color: #4CAF50; }
        .delete-button { background-color: #f44336; }
        .edit-button:hover { background-color: #45a049; }
        .delete-button:hover { background-color: #e53935; }
    </style>
</head>
<body>
    <h1>User List</h1>
    <table>
        <thead>
            <tr>
                <th>User ID</th>
                <th>Username</th>
                <th>Role</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                boolean hasData = false;
                while (rs.next()) {
                    hasData = true;
                    String id = rs.getString("user_id");
                    String username = rs.getString("username");
                    String role = rs.getString("role");
                    String email = rs.getString("email");
            %>
            <tr>
                <td><%= id %></td>
                <td><%= username %></td>
                <td><%= role %></td>
                <td><%= email %></td>
                <td>
                    <a href="superedituser.jsp?action=edit&userId=<%= id %>" class="button edit-button">Edit</a>
                    <a href="superdeleteuser?action=delete&userId=<%= id %> " class="button delete-button" onclick='delmsg()'>Delete</a>
                </td>
            </tr>
            <%
                }

                if (!hasData) {
            %>
            <tr>
                <td colspan="5">No users found.</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>

<%
    } catch (ClassNotFoundException e) {
        out.println("<h3>Error: JDBC Driver not found: " + e.getMessage() + "</h3>");
    } catch (SQLException e) {
        out.println("<h3>Error retrieving data: " + e.getMessage() + "</h3>");
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

    </div>
  
</body>
</html>
