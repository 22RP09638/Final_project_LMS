<%@page import="java.net.URLEncoder"%>
<%@page import="util.DBUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/style3.css">
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <script>
        function showSection(sectionId) {
            document.getElementById('addBookForm').style.display = 'none';
            document.getElementById('borrowedBooks').style.display = 'none';
            document.getElementById('borrowRequests').style.display = 'none';
            document.getElementById('viewcomment').style.display = 'none';
            document.getElementById('generatereport').style.display = 'none';
            document.getElementById(sectionId).style.display = 'block';
        }
    </script>
    <style>
  .nav a{
   text-decoration:  none;
   margin-right: 20px;
   color: black;
   
}
.nav a:hover{
background-color: #294c8e;
padding: 15px;

   
}
        addbook {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
        }

        input[type="text"],
        input[type="file"] {
            width: calc(100% - 20px);
            padding: 8px 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .bup {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 4px;
            background-color: #294c8e;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
        }

        .bup:hover {
            background-color: #294c8e;
        }
        /* Style the dropdown button */
.dropbtn {
    background-color:#fff ;
    color: #000;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;
}

/* Style the dropdown container */
.dropdown {
    position: relative;
    display: inline-block;
}

/* Dropdown content (hidden by default) */
.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

/* Links inside the dropdown */
.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

/* Change color of dropdown links on hover */
.dropdown-content a:hover {
    background-color: #f1f1f1;
}

/* Show the dropdown menu on hover */
.dropdown:hover .dropdown-content {
    display: block;
}

/* Change the background color of the dropdown button when the dropdown content is shown */
.dropdown:hover .dropbtn {
    background-color: #294c8e;
}

    </style>
        <script>
        function msg(){
            return confirm("Are you sure want to logout?");
        }
    </script>
</head>
<body>
     <%
        // Check if the user is logged in
        String email = (String) session.getAttribute("email");
        String role = (String) session.getAttribute("role");
        String userId = (String) session.getAttribute("userId");

        // If any session attribute is null, the user is not logged in
        if (email == null || role == null || userId == null) {
    %>
        <script>
            alert("Please login first.");
            window.location.href = "login.jsp"; // Redirect to login page
        </script>
    <%
            return; // Stop further processing of the page
        }
    %>
    
      <jsp:include page="header.jsp" />
   
    <div class="container">
        <h1>Librarian Dashboard</h1>
        <nav class="nav">
            <a href="#" onclick="showSection('addBookForm')">Add Book</a>
           <!--   <a href="addUser.jsp">Add User</a>-->
            <a href="#" onclick="showSection('borrowedBooks')">View Borrowed Books</a>
            <a href="#" onclick="showSection('borrowRequests')">Manage Borrow Requests</a>
            <a href="#" onclick="showSection('viewcomment')">View Comment</a>
           <!-- <a href="#" onclick="showSection('generatereport')">Generate Report</a>-->
           <div class="dropdown">
    <button class="dropbtn">Generate Report</button>
    <div class="dropdown-content">
        <a href="returnreport.jsp" onclick="showSection('generatereport')">Return Report</a>
        <a href="borrowreport.jsp" onclick="showSection('generatereport')">Borrower Report</a>
        <a href="bookreport.jsp" onclick="showSection('generatereport')">Book Report</a>
    </div>
</div>

         <a href="logout" onclick="return msg()">Logout</a>
        </nav>

        <!-- Add Book Form -->
        <div id="addBookForm" style="display: none;">
            <h2>Add a New Book</h2>
            <form action="AddBookServlet" method="post" enctype="multipart/form-data" class="addbook">
                <label for="bookTitle">Book Title:</label>
        <input type="text" id="bookTitle" name="bookTitle" required><br>
        <label for="author">Author:</label>
        <input type="text" id="author" name="author" required><br>
        <label for="bookCode">Book code:</label>
        <input type="text" id="bookCode" name="bookCode" required><br>
        
        <label for="author">Published Year:</label>
        <input type="date" id="author" name="year" required><br>
        <label for="file">Choose File:</label>
        <input type="file" id="file" name="file" accept=".pdf" required><br>
        <button type="submit" class="bup" onclick="alert('Book Uploaded Successfully') ">Upload</button>
    </form>
        </div>

        <!-- View Borrowed Books -->
        <div id="borrowedBooks" style="display: none;">
            <h2>Borrowed Books</h2>
            <table>
                <tr>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Borrower</th>
                    <th>Book code</th>
                    <th>Borrow Date</th>
                    <th>Return Date</th>
                    <th>Returned</th>
                </tr>
                <%
                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        con = DBUtil.getConnection();
                        String sql = "SELECT b.title, b.author, u.email AS borrower, b.book_code ,bb.borrow_date, bb.return_date, bb.returned " +
                                     "FROM BorrowedBooks bb " +
                                     "JOIN Books b ON bb.book_id = b.book_id " +
                                     "JOIN Users u ON bb.user_id = u.user_id";
                        ps = con.prepareStatement(sql);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            String title = rs.getString("title");
                            String author = rs.getString("author");
                            String borrower = rs.getString("borrower");
                            String book_code = rs.getString("book_code");
                            Date borrowDate = rs.getDate("borrow_date");
                            Date returnDate = rs.getDate("return_date");
                            boolean returned = rs.getBoolean("returned");
                %>
                <tr>
                    <td><%= title %></td>
                    <td><%= author %></td>
                    <td><%= borrower %></td>
                    <td><%= book_code %></td>
                    <td><%= borrowDate %></td>
                    <td><%= returnDate != null ? returnDate.toString() : "Not Returned" %></td>
                    <td><%= returned ? "Yes" : "No" %></td>
                </tr>
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
            </table>
        </div>

        <!-- Manage Borrow Requests -->
        <div id="borrowRequests" style="display: none;">
            <h2>Manage Borrow Requests</h2>
            <table>
                <tr>
                    <th>User</th>
                    <th>Book</th>
                    <th>Request Date</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                <%
                    try {
                        con = DBUtil.getConnection();
                        String sql = "SELECT r.request_id, u.email, b.title, r.request_date, r.status " +
                                     "FROM Requests r " +
                                     "JOIN Users u ON r.user_id = u.user_id " +
                                     "JOIN Books b ON r.book_id = b.book_id";
                        ps = con.prepareStatement(sql);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            int requestId = rs.getInt("request_id");
                            String em = rs.getString("email");
                            String bookTitle = rs.getString("title");
                            Date requestDate = rs.getDate("request_date");
                            String status = rs.getString("status");
                %>
                <tr>
                    <td><%= em %></td>
                    <td><%= bookTitle %></td>
                    <td><%= requestDate %></td>
                    <td><%= status %></td>
                    <td>
                        <% if ("Pending".equals(status)) { %>
                        <form action="processRequest" method="post">
                            <input type="hidden" name="requestId" value="<%= requestId %>">
                            <button type="submit" name="action" value="approve">Approve</button>
                            <button type="submit" name="action" value="deny">Deny</button>
                        </form>
                        <% } else { %>
                            <%= status %>
                        <% } %>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (ps != null) ps.close();
                            if (con !=null) con.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </table>
        </div>
<div id="viewcomment" style="display: none;">
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
            //ResultSet rs = null;
            
            try {
                conn = DBUtil.getConnection(); // Assuming DBUtil provides the connection to librarydb
                String query = "SELECT role,comment, date FROM comment";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(query);
                
                while(rs.next()) {
                  String roles = rs.getString("role");
                    String comment = rs.getString("comment");
                    String date = rs.getString("date");
                  
        %>
                    <tr>
                        <td><%= roles %></td>
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
    </div>
<div id="generatereport">
        
        <!-- View Borrowed Books -->
            <h2>Borrowed Books</h2>
            <table border="1">
                <tr>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Borrower</th>
                    <th>Borrow Date</th>
                    <th>Return Date</th>
                    <th>Returned</th>
                </tr>
                <%

                    try {
                        con = DBUtil.getConnection();
                        String sql = "SELECT b.title, b.author, u.email AS borrower, bb.borrow_date, bb.return_date, bb.returned " +
                                     "FROM BorrowedBooks bb " +
                                     "JOIN Books b ON bb.book_id = b.book_id " +
                                     "JOIN Users u ON bb.user_id = u.user_id";
                        ps = con.prepareStatement(sql);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            String title = rs.getString("title");
                            String author = rs.getString("author");
                            String borrower = rs.getString("borrower");
                            Date borrowDate = rs.getDate("borrow_date");
                            Date returnDate = rs.getDate("return_date");
                            boolean returned = rs.getBoolean("returned");
                %>
                <tr>
                    <td><%= title %></td>
                    <td><%= author %></td>
                    <td><%= borrower %></td>
                    <td><%= borrowDate %></td>
                    <td><%= returnDate != null ? returnDate.toString() : "Not Returned" %></td>
                    <td><%= returned ? "Yes" : "No" %></td>
                </tr>
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
            </table>
        </div>     
    </div>
        <!-- Display All Books -->
        <h2>All Books</h2>
        <table>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>Book code</th>
                <th>Published Year</th>
              
                <th>Availability</th>
                <th colspan="2">Action</th>
            </tr>
            <%
                try {
                    con = DBUtil.getConnection();
                    String sql = "SELECT * FROM Books";
                    PreparedStatement pst = con.prepareStatement(sql);
                    ResultSet rst = pst.executeQuery();

                    while (rst.next()) {
                        String bookId = rst.getString("book_id");
                        String title = rst.getString("title");
                        String author = rst.getString("author");
                        String book_code = rst.getString("book_code");
                        String published_year = rst.getString("published_year");
                       
                        String availability = rst.getString("availability");
            %>
            <tr>
                <td><%= title %></td>
                <td><%= author %></td>
                <td><%= book_code %></td>
                <td><%= published_year %></td>
                
                <td><%= availability %></td>
                <td>
                    <form action="editBook.jsp" method="get" style="display:inline;">
                        <input type="hidden" name="bookId" value="<%= bookId %>">
                        <button type="submit" style="background-color: forestgreen;cursor:pointer;color: whitesmoke">Edit</button>
                    </form>
                </td><td>
                    <form action="deleteBook" method="post" style="display:inline;">
                        <input type="hidden" name="bookId" value="<%= bookId %>">
                        <button type="submit" style="background-color: red;cursor:pointer;color: whitesmoke" onclick="return confirm('Are you Sure want to delete this Book?')">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                    rst.close();
                    pst.close();
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </table>
    </div>
          <jsp:include page="footer.jsp" />
          
</body>
</html>
