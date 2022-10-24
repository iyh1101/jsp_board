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
<title>게시판-로그인</title>
<link rel="stylesheet" href="common.css">
</head>
<body>
	
	


<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	session.setAttribute("idKey",id);
	session.setAttribute("pwKey",pw);
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
		Statement st = con.createStatement();
		ResultSet result = null;
		String sql = "select id, pw from member where id = '"+id+"' and pw = '"+pw+"';";
		result = st.executeQuery(sql);
		result.next();
		String cid = result.getString("id");
		String cpw = result.getString("pw");		
		System.out.println("id:"+cid);
		System.out.println("pw:"+cpw);
		
		if(id.equals(cid) && pw.equals(cpw) ) {
			System.out.println("성공");
%>
			<script>
			alert("<%=id%>님 환영합니다");
		 	location.href= "list.jsp";
			</script>
<%
		} else {
			System.out.println("실패");
		}
	
	} catch(Exception e) {
%>
			<script>
			alert("아이디 또는 패스워드 불일치");
		 	location.href= "main.html";
			</script>
<%			
		e.printStackTrace();
	}
%>
	
</body>
</html>