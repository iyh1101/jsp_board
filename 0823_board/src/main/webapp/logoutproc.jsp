<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    <%
    	session.removeAttribute("idKey");
    
    %>
    
    <script>
    alert("로그아웃되었습니다");
    location.href="main.html";
    </script>