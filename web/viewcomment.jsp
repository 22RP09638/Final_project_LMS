<%@page import="java.sql.*"%>
<%@page import="util.DBUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>View Comments</title>
</head>
<body>

    <h2>All Given Comments</h2>
    <table border="1">
        <tr>
            <th>Role</th>
            <th>Comment</th>
            <th>Date</th>
            
        </tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            
            try {
                conn = DBUtil.getConnection(); // Assuming DBUtil provides the connection to librarydb
                String query = "SELECT role,comment, date FROM comment";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(query);
                
                while(rs.next()) {
                  String role = rs.getString("role");
                    String comment = rs.getString("comment");
                    String date = rs.getString("date");
                  
        %>
                    <tr>
                        <td><%= role %></td>
                        <td><%= comment %></td>
                        <td><%= date %></td>
                        
                    </tr>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </table>
</body>
</html>
