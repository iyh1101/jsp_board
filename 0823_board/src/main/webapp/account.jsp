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

	<div id="box">
	<form action="checkid.jsp" method="get">
		아이디: <input name="id" id="id" type="text" placeholder="ID">
		<input type="submit" value="ID 중복확인">
	</form>
		<input id="account_cancel" type="button" value="가입취소" onclick="location.href='main.html'">
	</div>
	
	
</body>
</html>
