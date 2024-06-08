package Model;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Book {
    private String title;
    private String author;
    private String description;
    private String keywords;

    public Book(String title, String author, String description, String keywords) {
        this.title = title;
        this.author = author;
        this.description = description;
        this.keywords = keywords;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public String getDescription() {
        return description;
    }
    
    
    public String getKeywords() {
        return keywords;
    }
}
