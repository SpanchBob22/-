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

public class LoadBooksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Book> books = new ArrayList<>();
        String filePath = "E:\\JavaProjects\\Work9\\src\\main\\webapp\\books.txt";
        
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] bookDetails = line.split(";");
                if (bookDetails.length == 4) {
                    String title = bookDetails[0].split(":")[1].trim();
                    String author = bookDetails[1].split(":")[1].trim();
                    String description = bookDetails[2].split(":")[1].trim();
                    String keywords = bookDetails[3].split(":")[1].trim();
                    books.add(new Book(title, author, description, keywords));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        request.setAttribute("books", books);
        request.getRequestDispatcher("books.jsp").forward(request, response);
    }
}
