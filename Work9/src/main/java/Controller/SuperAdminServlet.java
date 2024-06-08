package Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.*;

import Model.User;

public class SuperAdminServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = (String) request.getSession().getAttribute("role");
        
        if (role == null || !role.equals("superadmin")) {
            response.sendRedirect("index.jsp");
            return;
        }

        List<User> users = getAllUsers();
        request.setAttribute("users", users);
        RequestDispatcher dispatcher = request.getRequestDispatcher("superadmin.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                insertUser(request, response);
                break;
            case "update":
                updateUser(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
            default:
                doGet(request, response);
                break;
        }
    }

    private void insertUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String nickname = request.getParameter("nickname");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User newUser = new User(nickname, password, role);
        saveUser(newUser);

        response.sendRedirect("SuperAdminServlet");
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String oldNickname = request.getParameter("oldNickname");
        String nickname = request.getParameter("nickname");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User updatedUser = new User(nickname, password, role);
        updateUser(oldNickname, updatedUser);

        response.sendRedirect("SuperAdminServlet");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String nickname = request.getParameter("oldNickname");

        deleteUser(nickname);

        response.sendRedirect("SuperAdminServlet");
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

    private void saveUser(User user) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter("E:\\JavaProjects\\Work9\\src\\main\\webapp\\users.txt", true))) {
            writer.write("Nickname: " + user.getNickname() + "; Password: " + user.getPassword() + "; Role: " + user.getRole());
            writer.newLine();
        }
    }

    private void updateUser(String oldNickname, User updatedUser) throws IOException {
        List<User> users = getAllUsers();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter("E:\\JavaProjects\\Work9\\src\\main\\webapp\\users.txt"))) {
            for (User user : users) {
                if (!user.getNickname().equals(oldNickname)) {
                    writer.write("Nickname: " + user.getNickname() + "; Password: " + user.getPassword() + "; Role: " + user.getRole());
                    writer.newLine();
                }
            }
            writer.write("Nickname: " + updatedUser.getNickname() + "; Password: " + updatedUser.getPassword() + "; Role: " + updatedUser.getRole());
            writer.newLine();
        }
    }

    private void deleteUser(String nickname) throws IOException {
        List<User> users = getAllUsers();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter("E:\\JavaProjects\\Work9\\src\\main\\webapp\\users.txt"))) {
            for (User user : users) {
                if (!user.getNickname().equals(nickname)) {
                    writer.write("Nickname: " + user.getNickname() + "; Password: " + user.getPassword() + "; Role: " + user.getRole());
                    writer.newLine();
                }
            }
        }
    }
}
