package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nickname = request.getParameter("nickname");
        String password = request.getParameter("password");
        String role = "reader"; // Default role
        boolean userExists = false;

        // Check if user already exists
        try (BufferedReader reader = new BufferedReader(new FileReader("E:\\JavaProjects\\Work9\\src\\main\\webapp\\users.txt"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.startsWith("Nickname: " + nickname + ";")) {
                    userExists = true;
                    break;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        if (userExists) {
            request.setAttribute("errorMessage", "Nickname already exists. Please choose another one.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter("E:\\JavaProjects\\Work9\\src\\main\\webapp\\users.txt", true))) {
                writer.write("Nickname: " + nickname + "; Password: " + password + "; Role: " + role);
                writer.newLine();
            } catch (IOException e) {
                e.printStackTrace();
            }
            response.sendRedirect("login.jsp");
        }
    }
}
