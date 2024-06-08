<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Book" %>
<%@ page import="Model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="Controller.GetBooks" %>

<%
    User user = (User) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
    List<Book> books = GetBooks.getAllBooks();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Library</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
            position: relative;
        }
        h1,h2 {
            color: #343a40;
            text-align: center;
        }
        .role {
            position: absolute;
            top: 20px;
            right: 20px;
            padding: 10px 20px;
            background-color: #343a40;
            color: white;
            border-radius: 8px;
            font-weight: bold;
        }
        a {
            text-decoration: none;
            color: #007bff;
            margin: 0 10px;
        }
        a:hover {
            text-decoration: underline;
        }
        form {
            margin: 20px 0;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .form-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .form-group label {
            margin-right: 10px;
            font-weight: normal;
            font-size: 16px;
            color: #343a40;
        }
        .form-group select, .form-group input[type="text"], .form-group button {
            padding: 10px;
            margin: 0 5px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            box-sizing: border-box;
            flex: 1;
        }
        .form-group button {
            background-color: #007bff;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
            border: none;
            flex: 0 0 auto;
        }
        .form-group button:hover {
            background-color: #0056b3;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin: 20px 0;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            border: 1px solid #dee2e6;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #e9ecef;
        }
    </style>
</head>
<body>
    <%
        if (user == null) {
    %>
    <h1>Welcome to the Library !</h1>
    <h2>Login to see information</h2>
    <div style="text-align: center;">
        <a href='register.jsp'>Register</a>
        <a href='login.jsp'>Login</a>
    </div>
    <%
        } else {
    %>
    <h1>Welcome, <%= user.getNickname() %>!</h1>
    <div style="text-align: center;">
        <a href='logout.jsp'>Logout</a>
        <%
            if ("superadmin".equals(role)) {
        %>
        <a href='SuperAdminServlet'>Manage Users</a>
        <a href='BookServlet'>Manage Books</a>
        <div class="role">Super Administrator</div>
        <%
            } else if ("admin".equals(role)) {
        %>
        <a href='BookServlet'>Manage Books</a>
        <div class="role">Administrator</div>
        <%
            } else if ("reader".equals(role)) {
        %>
        <div class="role">Reader</div>
        <%
            } 
        %>
        
    </div>
    <h1>Library</h1>

    <form action="SearchServlet" method="get">
        <div class="form-group">
            <label for="searchBy">Search by:</label>
            <select id="searchBy" name="searchBy">
                <option value="title">Title</option>
                <option value="author">Author</option>
                <option value="keywords">Keywords</option>
            </select>
            <input type="text" name="query" required>
            <button type="submit">Search</button>
        </div>
    </form>

    <table>
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
    <%
        }
    %>
</body>
</html>
