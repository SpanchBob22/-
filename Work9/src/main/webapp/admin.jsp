<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Book" %>
<%@ page import="java.util.List" %>
<%
    List<Book> books = (List<Book>) request.getAttribute("books");
%>
<%
    
    String userRole = (String) session.getAttribute("role"); 
    if (userRole == null || (!userRole.equals("superadmin") & (!userRole.equals("admin")))) {
       
        response.sendRedirect("index.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Manage Books</title>
    <style>
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 20px;
            border-bottom: 1px solid #dee2e6;
        }
        .home-link {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .home-link:hover {
            background-color: #0056b3;
        }    
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #343a40;
            text-align: center;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin: 20px 0;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        table, th, td {
            border: 1px solid #dee2e6;
        }
        th, td {
            padding: 12px;
            text-align: left;
            vertical-align: middle;
            box-sizing: border-box;
        }
        th {
            background-color: #e9ecef;
        }
        form {
            margin: 0;
            padding: 0;
            border: none;
        }
        form input[type="text"] {
            margin: 8px 0;
            padding: 8px;
            box-sizing: border-box;
            border: 2px solid #ced4da;
            border-radius: 4px;
            width: 100%; 
            display: inline-block;
        }
        form input[type="submit"] {
            margin: 8px 0;
            padding: 10px 15px;
            box-sizing: border-box;
            border: none; 
            border-radius: 4px;
            width: 100%;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        form input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .button-container {
            display: flex;
            flex-direction: column;
        }
        .button-container form {
            flex: 1;
        }
        table input[type="text"], table input[type="submit"] {
            margin: 8px 0;
            padding: 8px;
            box-sizing: border-box;
        }
        table input[type="text"] {
            border: 2px solid #ced4da;
            border-radius: 4px;
            width: 90%;
            display: inline-block;
        }
        table input[type="submit"] {
            border: none; 
            border-radius: 4px;
            width: 100%;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        table input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="header">
    	<h1>Manage Books</h1>
        <a class="home-link" href="index.jsp">Home</a>
    </div>
    <form action="BookServlet" method="post">
        <input type="hidden" name="action" value="add">
        <label for="title">Title:</label><br>
        <input type="text" id="title" name="title" required><br>
        <label for="author">Author:</label><br>
        <input type="text" id="author" name="author" required><br>
        <label for="description">Description:</label><br>
        <input type="text" id="description" name="description" required><br>
        <label for="keywords">Keywords:</label><br>
        <input type="text" id="keywords" name="keywords" required><br>
        <input type="submit" value="Add Book">
    </form>

    <table>
        <tr>
            <th>Title</th>
            <th>Author</th>
            <th>Description</th>
            <th>Keywords</th>
            <th>Actions</th>
        </tr>
        <%
            if (books != null) {
                for (Book book : books) {
                    String sanitizedTitle = book.getTitle().replaceAll("\\s", "_");
        %>
        <tr>
            <form id="update-<%= sanitizedTitle %>" action="BookServlet" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="oldTitle" value="<%= book.getTitle() %>">
                <td><input type="text" name="title" value="<%= book.getTitle() %>" required></td>
                <td><input type="text" name="author" value="<%= book.getAuthor() %>" required></td>
                <td><input type="text" name="description" value="<%= book.getDescription() %>" required></td>
                <td><input type="text" name="keywords" value="<%= book.getKeywords() %>" required></td>
                <td>
                    <input type="submit" value="Update">
            </form>
            <form action="BookServlet" method="post">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="oldTitle" value="<%= book.getTitle() %>">
                    <input type="submit" value="Delete">
            </form>
                </td>
        </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>
