<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        h1 {
            color: #343a40;
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            width: 100%;
            max-width: 400px;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            box-sizing: border-box;
        }
        form label {
            display: block;
            margin: 8px 0 5px;
            font-weight: normal;
            font-size: 16px;
            color: #343a40;
        }
        form input[type="text"], form input[type="password"], form input[type="submit"], form button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ced4da;
            border-radius: 4px;
            box-sizing: border-box;
        }
        form input[type="submit"], form button {
            border: none;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        form input[type="submit"]:hover, form button:hover {
            background-color: #0056b3;
        }
        p, .error-message {
            text-align: center;
            color: red;
        }
    </style>
</head>
<body>
    <form action="RegisterServlet" method="post">
        <h1>Registration</h1>
        <label for="nickname">Nickname:</label>
        <input type="text" id="nickname" name="nickname" required>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <button type="submit">Register</button>
        <%
            if (request.getAttribute("errorMessage") != null) {
        %>
        <div class="error-message"><%= request.getAttribute("errorMessage") %></div>
        <%
            }
        %>
    </form>
</body>
</html>
