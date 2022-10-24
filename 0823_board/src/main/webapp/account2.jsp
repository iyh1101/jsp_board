<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="style.css">
</head>
<body id="main">
	
	<%
		String id = (String)session.getAttribute("newid");
	%>
	
	<div id="box">
		<input name="id" id="id" type="text" value="<%=id%>" disabled>
	<form action="checkid2.jsp" method="get">
		<input name="pw" id="pw" type="password" placeholder="비밀번호 입력"><br>
		<input name="pw2" id="pw2" type="password" placeholder="비밀번호 확인"><br><br>
		<input type="submit" value="회원가입">
		<input id="account_cancel2" type="button" value="가입취소" onclick="location.href='main.html'">
	</form>
	</div>
	
</body>
</html>
