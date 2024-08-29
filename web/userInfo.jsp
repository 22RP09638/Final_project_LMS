<%@page import="util.DBUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Information</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
     <link rel="stylesheet" type="text/css" href="css/style3.css">
</head>
<body>
     <jsp:include page="header.jsp" />
    <jsp:include page="navigation.jsp" />
    <div class="container">
        <h1>My Information</h1>
      
        <br><br>
        <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            String email = (String) session.getAttribute("email");

            try {
                con = DBUtil.getConnection();

                String sql = "SELECT * FROM users WHERE email = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, email);
                rs = ps.executeQuery();

                if (rs.next()) {
                    String username = rs.getString("username");
                     String user_id = rs.getString("user_id");
        %>
        <form action="updateUserInfo" method="post">
           
            <input type="number" id="user_id" name="user_id" value="<%= user_id %>" hidden><br>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= email %>" readonly><br>
            <label for="email">username:</label>
            <input type="username" id="username" name="username" value="<%= username %>" required><br>
            <button type="submit" onclick="alert('username well updated') ">Update</button>
        </form>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
       <jsp:include page="footer.jsp" />
</body>
</html>
