<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.User" %>
<%@ page import="java.util.List" %>
<%
    List<User> users = (List<User>) request.getAttribute("users");
%>
<%
    
    String userRole = (String) session.getAttribute("role"); 
    if (userRole == null || !userRole.equals("superadmin")) {
       
        response.sendRedirect("index.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Super Admin - Manage Users</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 20px;
            border-bottom: 1px solid #dee2e6;
        }
        h1 {
            color: #343a40;
            margin: 0;
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
        <h1>Manage Users</h1>
        <a class="home-link" href="index.jsp">Home</a>
    </div>

    <form action="SuperAdminServlet" method="post">
        <input type="hidden" name="action" value="add">
        <label for="nickname">Nickname:</label><br>
        <input type="text" id="nickname" name="nickname" required><br>
        <label for="password">Password:</label><br>
        <input type="text" id="password" name="password" required><br>
        <label for="role">Role:</label><br>
        <input type="text" id="role" name="role" required><br>
        <input type="submit" value="Add User">
    </form>

    <table>
        <tr>
            <th>Nickname</th>
            <th>Password</th>
            <th>Role</th>
            <th>Actions</th>
        </tr>
        <%
            if (users != null) {
                for (User user : users) {
                    String sanitizedNickname = user.getNickname().replaceAll("\\s", "_");
        %>
        <tr>
            <form id="update-<%= sanitizedNickname %>" action="SuperAdminServlet" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="oldNickname" value="<%= user.getNickname() %>">
                <td><input type="text" name="nickname" value="<%= user.getNickname() %>" required></td>
                <td><input type="text" name="password" value="<%= user.getPassword() %>" required></td>
                <td><input type="text" name="role" value="<%= user.getRole() %>" required></td>
                <td>
                    <input type="submit" value="Update">
            </form>
            <form action="SuperAdminServlet" method="post">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="oldNickname" value="<%= user.getNickname() %>">
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
