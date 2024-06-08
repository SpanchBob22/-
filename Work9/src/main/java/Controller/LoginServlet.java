package Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.*;

import Model.User;

public class LoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nickname = request.getParameter("nickname");
        String password = request.getParameter("password");

        User user = authenticateUser(nickname, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole());

            response.sendRedirect("index.jsp"); 
        } else {
            request.setAttribute("errorMessage", "Invalid nickname or password");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        }
    }


    private User authenticateUser(String nickname, String password) throws IOException {
        List<User> users = getAllUsers();
        for (User user : users) {
            if (user.getNickname().equals(nickname) && user.getPassword().equals(password)) {
                return user;
            }
        }
        return null;
    }

    private List<User> getAllUsers() throws IOException {
        List<User> users = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader("E:\\JavaProjects\\Work9\\src\\main\\webapp\\users.txt"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(";");
                String nickname = parts[0].split(":")[1].trim();
                String password = parts[1].split(":")[1].trim();
                String role = parts[2].split(":")[1].trim();
                users.add(new User(nickname, password, role));
            }
        }
        return users;
    }
}
