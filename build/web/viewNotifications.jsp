<%@page import="util.DBUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Notifications</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/style3.css">
</head>
<body>
     <jsp:include page="header.jsp" />
    <jsp:include page="navigation.jsp" />
    <div class="container">
        <h1>Notifications</h1>
        
        <br><br>
        <table>
            <tr>
                <th>Notification</th>
                <th>Date</th>
            </tr>
            <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                String email = (String) session.getAttribute("email");
                String userId = (String) session.getAttribute("userId");

                if (email== null || userId == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }

                try {
                    con = DBUtil.getConnection();
                    String sql = "SELECT message, date FROM Notifications WHERE user_id = ? ORDER BY date DESC";
                    ps = con.prepareStatement(sql);
                    ps.setString(1, userId);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                        String message = rs.getString("message");
                        Timestamp date = rs.getTimestamp("date");
            %>
            <tr>
                <td><%= message %></td>
                <td><%= date %></td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
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
        </table>
    </div>
           <jsp:include page="footer.jsp" />
</body>
</html>
