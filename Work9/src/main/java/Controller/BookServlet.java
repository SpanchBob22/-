package Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.*;

import Model.Book;

public class BookServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Checker(role)
        String role = (String) request.getSession().getAttribute("role");
        
     // Checker(admin or superadmin)
        if (role == null || (!role.equals("admin") && !role.equals("superadmin"))) {
            response.sendRedirect("index.jsp");
            return;
        }

    	List<Book> books = getAllBooks();
        request.setAttribute("books", books);
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                insertBook(request, response);
                break;
            case "update":
                updateBook(request, response);
                break;
            case "delete":
                deleteBook(request, response);
                break;
            default:
                doGet(request, response);
                break;
        }
    }

    private void insertBook(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String description = request.getParameter("description");
        String keywords = request.getParameter("keywords");

        Book newBook = new Book(title, author, description, keywords);
        saveBook(newBook);

        response.sendRedirect("BookServlet");
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String oldTitle = request.getParameter("oldTitle");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String description = request.getParameter("description");
        String keywords = request.getParameter("keywords");

        Book updatedBook = new Book(title, author, description, keywords);
        updateBook(oldTitle, updatedBook);

        response.sendRedirect("BookServlet");
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String title = request.getParameter("oldTitle");

        deleteBook(title);

        response.sendRedirect("BookServlet");
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

    private void saveBook(Book book) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter("E:\\JavaProjects\\Work9\\src\\main\\webapp\\books.txt", true))) {
            writer.write("Title: " + book.getTitle() + "; Author: " + book.getAuthor() + "; Description: " + book.getDescription() + "; Keywords: " + book.getKeywords());
            writer.newLine();
        }
    }

    private void updateBook(String oldTitle, Book updatedBook) throws IOException {
        List<Book> books = getAllBooks();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter("E:\\JavaProjects\\Work9\\src\\main\\webapp\\books.txt"))) {
            for (Book book : books) {
                if (!book.getTitle().equals(oldTitle)) {
                    writer.write("Title: " + book.getTitle() + "; Author: " + book.getAuthor() + "; Description: " + book.getDescription() + "; Keywords: " + book.getKeywords());
                    writer.newLine();
                }
            }
            writer.write("Title: " + updatedBook.getTitle() + "; Author: " + updatedBook.getAuthor() + "; Description: " + updatedBook.getDescription() + "; Keywords: " + updatedBook.getKeywords());
            writer.newLine();
        }
    }

    private void deleteBook(String title) throws IOException {
        List<Book> books = getAllBooks();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter("E:\\JavaProjects\\Work9\\src\\main\\webapp\\books.txt"))) {
            for (Book book : books) {
                if (!book.getTitle().equals(title)) {
                    writer.write("Title: " + book.getTitle() + "; Author: " + book.getAuthor() + "; Description: " + book.getDescription() + "; Keywords: " + book.getKeywords());
                    writer.newLine();
                }
            }
        }
    }
}
