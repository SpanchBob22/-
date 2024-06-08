package Controller;

import Model.Book;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class GetBooks {

    public static List<Book> getAllBooks() throws IOException {
        List<Book> books = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader("E:\\JavaProjects\\Work9\\src\\main\\webapp\\books.txt"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(";");
                String title = parts[0].split(":")[1].trim();
                String author = parts[1].split(":")[1].trim();
                String description = parts[2].split(":")[1].trim();
                String keywords = parts[3].split(":")[1].trim();
                books.add(new Book(title, author, description, keywords));
            }
        }
        return books;
    }
    
}
