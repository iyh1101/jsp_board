<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
</head>
<body>
	
	<%
		//아이디 작성한 글수 추천수 댓글수? 회원정보변경 이정도
		String id = (String)session.getAttribute("idKey");
				
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("select (length(recom)) - length(replace(recom,']','')) as recom from cat_board where id = '"+id+"';");
		rs.next();
		String recom = rs.getString("recom");
		
		
		
		
	} catch(Exception e) {
		e.getStackTrace();
	}
	%>


</body>
</html>