<%@page import="util.DBUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/style3.css">
    <script>
        function showSection(sectionId) {
            document.getElementById('addBookForm').style.display = 'none';
            document.getElementById('borrowedBooks').style.display = 'none';
            document.getElementById('borrowRequests').style.display = 'none';
            document.getElementById(sectionId).style.display = 'block';
        }
    </script>
    </style>
</head>
<body>
     
    <jsp:include page="header.jsp" />
    <jsp:include page="navigation.jsp" />
       <br><br><br><br><br><br>
      <form method="POST" action="comment">
          <table border="0">
              <tr><td><b>Add comment</b></td></tr>
              <tr> <td><label>Role:</label></td>
              <tr><td> <select id="role" name="role" required>
                <option value="Student">Student</option>
                <option value="Staff">Staff</option>
                <option value="External">External</option>
                      </select></tr></td>
              <tr><td><textarea name="comment" style="width: 500px;height: 120px">
                      </textarea></td></tr>
              <tr><td><input type="submit" onclick="alert('Comment Recorded Successfully ') "value="Send"></td></tr>
          </table>
      </form>
   
          <jsp:include page="footer.jsp" />
</body>
</html>
