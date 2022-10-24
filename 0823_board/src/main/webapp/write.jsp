<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판-글쓰기</title>
<link rel="stylesheet" href="style.css">
</head>
<body id="main">
	<%
	String idKey = (String)session.getAttribute("idKey");
	if(idKey == null) {
		%>
		<script>
		alert("잘못된 접근입니다.");
		location.href="main.html";
		</script>
		<%
	}
	%>
	<form action="writeproc.jsp" method="get">
		<br><br>제목 &nbsp;<input id="w_title" name="title"><br><br>내용<br><br>
		<textarea id="write" name="content" rows="5" cols="50"></textarea>
		<input id="w_button1" type="submit" value="글쓰기"><br><br>
		<input id="w_button2"type="button" value="취소" onclick="javascript:history.back();">
	</form>
		
</body>
</html>