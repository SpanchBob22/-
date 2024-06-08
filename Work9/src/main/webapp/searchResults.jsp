<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Book" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
    <style>
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
        a {
            text-decoration: none;
            color: #007bff;
            margin: 0 10px;
        }
        a:hover {
            text-decoration: underline;
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
        p {
            text-align: center;
            color: #343a40;
        }
    </style>
</head>
<body>
    <h1>Search Results</h1>
    <a href='index.jsp'>Home</a>
    <%
        List<Book> resultBooks = (List<Book>) request.getAttribute("resultBooks");
        if (resultBooks == null || resultBooks.isEmpty()) {
    %>
    <p>No results found</p>
    <%
        } else {
    %>
    <table>
        <tr>
            <th>Title</th>
            <th>Author</th>
            <th>Description</th>
            <th>Keywords</th>
        </tr>
        <%
            for (Book book : resultBooks) {
        %>
        <tr>
            <td><%= book.getTitle() %></td>
            <td><%= book.getAuthor() %></td>
            <td><%= book.getDescription() %></td>
            <td><%= book.getKeywords() %></td>
        </tr>
        <%
            }
        %>
    </table>
    <%
        }
    %>
</body>
</html>
