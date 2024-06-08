<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.*" %>
<%
    HttpSession currentSession = request.getSession(false);

    if (currentSession != null) {
        currentSession.invalidate();
    }

    response.sendRedirect("index.jsp");
%>
