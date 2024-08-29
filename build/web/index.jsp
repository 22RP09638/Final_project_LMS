<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <style>
        /* Apply general styles to the body */
body {
    font-family: Arial, sans-serif; /* Use a clean, readable font */
    background-color: #f4f4f4; /* Light grey background for the whole page */
    margin: 0; /* Remove default margin */
    padding: 0; /* Remove default padding */
    color: #333; /* Dark grey text color for readability */
    display: flex; /* Use Flexbox for centering */
    justify-content: center; /* Center horizontally */
    align-items: center; /* Center vertically */
    height: 100vh; /* Full viewport height */
}

/* Style the container div */
.container {
    max-width: 800px; /* Limit the width for better readability */
    width: 100%; /* Ensure it uses full width available up to max-width */
    padding: 20px; /* Add padding inside the container */
    background-color: #ffffff; /* White background for the container */
    border-radius: 8px; /* Rounded corners for the container */
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
    text-align: center; /* Center-align text inside the container */
    height: 300px; /* Set a specific height for the container */
    display: flex; /* Use Flexbox for centering content */
    flex-direction: column; /* Align children vertically */
    justify-content: center; /* Center content vertically */
}

/* Style the main heading */
h1 {
    font-size: 24px; /* Larger font size for the heading */
    color: #294c8e; /* Dark blue color for the heading */
    margin-bottom: 20px; /* Space below the heading */
}

/* Style the paragraph text */
p {
    font-size: 18px; /* Slightly larger font size for better readability */
    color: #555; /* Medium grey color for the paragraph text */
}

/* Style the link */
a {
    color: #294c8e; /* Blue color for the link */
    text-decoration: none; /* Remove underline from the link */
    font-weight: bold; /* Make the link text bold */
}

a:hover {
    text-decoration: underline; /* Add underline on hover for better user experience */
}

    </style>
    <meta charset="UTF-8">
    <title>LIBRARY MANAGEMENT SYSTEM AT IPRC KARONGI</title>
    
</head>
<body>

    <div class="container">
        <h1>WELCOME TO LIBRARY MANAGEMENT SYSTEM AT IPRC KARONGI</h1>
       
        <p>Your are already have an account  <a href="login.jsp">Login Here</a></p>
        <p>If Your are Guest Create an account  <a href="guestSignup.jsp">Create Account</a></p>
    </div>

</body>
</html>
