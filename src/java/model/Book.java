package model;

public class Book {
    private int bookId;
    private String title;
    private String author;
    private String book_code;
    private String published_year;
    private String availability;

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getAvailability() {
        return availability;
    }

    public void setAvailability(String availability) {
        this.availability = availability;
    }


    public String getBook_code() {
        return book_code;
    }

    public void setBook_code(String book_code) {
        this.book_code = book_code;
    }
    
    public String getPublished_year() {
        return published_year;
    }
    
    public void setPublished_year(String published_year) {
        this.published_year = published_year;
    }
}
