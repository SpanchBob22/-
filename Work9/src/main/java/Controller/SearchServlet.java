package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Model.Book;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchBy = request.getParameter("searchBy");
        String query = request.getParameter("query");

        List<Book> books = getAllBooks();
        List<Book> resultBooks = new ArrayList<>();

        for (Book book : books) {
            switch (searchBy) {
                case "title":
                    if (book.getTitle().equalsIgnoreCase(query)) {
                        resultBooks.add(book);
                    }
                    break;
                case "author":
                    if (book.getAuthor().equalsIgnoreCase(query)) {
                        resultBooks.add(book);
                    }
                    break;
                case "keywords":
                    String[] keywords = book.getKeywords().split(",\\s*");
                    String[] queryKeywords = query.split(",\\s*");
                    boolean allKeywordsMatch = true;
                    for (String qk : queryKeywords) {
                        boolean keywordMatch = false;
                        for (String k : keywords) {
                            if (k.equalsIgnoreCase(qk)) {
                                keywordMatch = true;
                                break;
                            }
                        }
                        if (!keywordMatch) {
                            allKeywordsMatch = false;
                            break;
                        }
                    }
                    if (allKeywordsMatch) {
                        resultBooks.add(book);
                    }
                    break;
            }
        }

        request.setAttribute("resultBooks", resultBooks);
        request.getRequestDispatcher("searchResults.jsp").forward(request, response);
    }

    private List<Book> getAllBooks() throws IOException {
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
