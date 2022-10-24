<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 - 글수정</title>
<link rel="stylesheet" href="style.css">
</head>
<body id="main">


<%
	String editNum = request.getParameter("num");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String id = (String)session.getAttribute("idKey");
	if(id == null) {
		%>
		<script>
		alert("잘못된 접근입니다.");
		location.href="main.html";
		</script>
		<%
	}
	
	String url = request.getHeader("referer");
	session.setAttribute("back",url);
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
		Statement st = con.createStatement();
		String sql = "select*from cat_board where num ="+editNum;
		System.out.println("실행문:"+sql);
		ResultSet rs = st.executeQuery(sql);
		rs.next();
		title = rs.getString("title");
		content = rs.getString("content");
		id = rs.getString("id");
		
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
	<br><br>
	글번호 [ <%=editNum %> ]<br><br>
	<form action="modifyproc.jsp" method="get">
		<input name="num" type="hidden" value=<%=editNum %>>
		제목&nbsp;&nbsp;<input id="m_title" class="modify" name="title" value="<%=title%>"><br><br>	
		내용<br><br>
		<textarea id="m_write" class="modify" name="content" rows="5" cols="40"><%=content%></textarea>		
		<input id="m_button1" class="modify" type="submit" value="글수정"><br>
		작성자 [ <%=id %> ]<br>
	</form><br><br>
	<input id="m_button2" type="button" value="취소" onclick="javascript:history.back();">
	
</body>
</html>





