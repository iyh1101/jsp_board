<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판-글작성</title>
<link rel="stylesheet" href="common.css">
</head>
<body>

	

<%
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String id = (String)session.getAttribute("idKey");
	
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
		Statement st = con.createStatement();
		String sql = "insert into cat_board (title, content, id, recom, count, tm) values('"+title+"','"+content+"','"+id+"', default, default, now())";
		System.out.println("실행문:"+sql);
		int resultCount = st.executeUpdate(sql);
		if(resultCount == 1) {
			System.out.println("글쓰기 성공");
		} else {
			System.out.println("글쓰기 실패");
		}
	
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
	<script>
	alert("게시글이 작성되었습니다");
 	location.href= "list.jsp";
	</script>
</body>
</html>