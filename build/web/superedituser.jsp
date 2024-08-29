<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
    String action = request.getParameter("action");
    String userId = request.getParameter("userId");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String URL = "jdbc:mysql://localhost:3306/librarydb"; // Update with your DB details
    String USERNAME = "root"; // Update with your username
    String PASSWORD = ""; // Update with your password

    String message = "";

    if (action != null && userId != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);

            if (action.equals("edit")) {
                // Retrieve the user details for editing
                String sql = "SELECT * FROM users WHERE user_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, userId);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    String username = rs.getString("username");
                    String role = rs.getString("role");
                    String email = rs.getString("email");

%>
                    <!DOCTYPE html>
                    <html>
                    <head>
                        <title>Edit User</title>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    </head>
                    <body>
                          <jsp:include page="addUser.jsp" />
                        <h1>Edit User</h1>
                        <form action="superedituser" method="post">
                            <input type="hidden" name="userId" value="<%= userId %>"/>
                            <input type="hidden" name="action" value="update"/>
                            <p>Username: <input type="text" name="username" value="<%= username %>" required/></p>
                            <p>Role: <input type="text" name="role" value="<%= role %>" required/></p>
                            <p>Email: <input type="email" name="email" value="<%= email %>" required/></p>
                            <p><input type="submit" value="Update"/></p>
                        </form>
                    </body>
                    </html>
<%
                } else {
                    message = "No user found with ID " + userId;
                }
            } else if (action.equals("delete")) {
                // Handle delete action by sending a request to the servlet
                response.sendRedirect("superediituser?action=delete&userId=" + userId);
            }
        } catch (ClassNotFoundException e) {
            message = "Error: JDBC Driver not found: " + e.getMessage();
            e.printStackTrace();
        } catch (SQLException e) {
            message = "Error retrieving user data: " + e.getMessage();
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    } else {
        message = "Invalid request: action and user ID are required.";
    }
%>

<% if (!message.isEmpty()) { %>
    <html>
    <body>
        <h3><%= message %></h3>
        <p><a href="ManageUserServlet">Go back to list</a></p>
    </body>
    </html>
<% } %>
