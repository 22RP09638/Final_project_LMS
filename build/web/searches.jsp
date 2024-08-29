<!DOCTYPE html>
<html>
<head>
    <title>Search Books</title>
</head>
<body>
    <h2>Search for Books</h2>
    <form action="SearchServlet" method="post">
        <label for="title">Title:</label>
        <input type="text" id="title" name="title"><br>
        
        <label for="author">Author:</label>
        <input type="text" id="author" name="author"><br>
        
        <label for="bookCode">Book Code:</label>
        <input type="text" id="bookCode" name="bookCode"><br>
        
        <label for="publishedYear">Published Year:</label>
        <input type="text" id="publishedYear" name="publishedYear"><br>
        
        <label for="availability">Availability:</label>
        <select id="availability" name="availability">
            <option value="">Any</option>
            <option value="Available">Available</option>
            <option value="Not Available">Not Available</option>
        </select><br>
        
        <button type="submit">Search</button>
    </form>
</body>
</html>
