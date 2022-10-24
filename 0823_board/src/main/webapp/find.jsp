<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판-검색</title>
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
	
	<br><br><br><br>
	<form action="findproc.jsp?page=<%=1 %>" method="get">
		<input type="button" value="<-" onclick="javascript:history.go(-1)">&nbsp;
		<select name="tag">
			<option value="none">=== 검색 영역 선택 ===</option>
            <option value="제목">제목</option>
            <option value="본문">본문</option>
            <option value="댓글">댓글</option>
            <option value="전체">전체</option>
        </select>
		<input type="text" name="text" placeholder="검색어 입력">&nbsp;
		<input type="submit" value="검색">
	</form>


</body>
</html>