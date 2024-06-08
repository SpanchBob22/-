<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Book" %>
<%@ page import="java.util.List" %>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    List<Book> books = (List<Book>) request.getAttribute("books");
%>

<html>
<head>
    <title>Library</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <% 
        if (username != null) {
            out.println("<h1>Welcome, " + username + "!</h1>");
            if ("admin".equalsIgnoreCase(role) || "superadmin".equalsIgnoreCase(role)) {
                out.println("<a href='logout.jsp'>Logout</a>");
                out.println("<a href='manageBooks.jsp'>Manage Books</a>");
                if ("superadmin".equalsIgnoreCase(role)) {
                    out.println("<a href='manageUsers.jsp'>Manage Users</a>");
                }
            }
        } else {
            out.println("<h1>Welcome to the Library</h1>");
            out.println("<a href='register.jsp'>Register</a>");
            out.println("<a href='login.jsp'>Login</a>");
        }
    %>
    
    <h1>Library</h1>
    <table border="1" style="width: 100%; border-collapse: collapse;">
        <tr>
            <th>Title</th>
            <th>Author</th>
            <th>Description</th>
            <th>Keywords</th>
        </tr>
        <% 
            if (books != null) {
                for (Book book : books) {
        %>
        <tr>
            <td><%= book.getTitle() %></td>
            <td><%= book.getAuthor() %></td>
            <td><%= book.getDescription() %></td>
            <td><%= book.getKeywords() %></td>
        </tr>
        <% 
                }
            }
        %>
    </table>
</body>
</html>