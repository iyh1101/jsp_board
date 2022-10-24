<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글달기</title>
</head>
<body>
	<%
		String url = request.getHeader("referer");
		String content = request.getParameter("content");
		String readNum = request.getParameter("num");
		String cid = (String)session.getAttribute("idKey");
		System.out.println("read"+readNum);
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
			Statement st = con.createStatement();
			String sql = "insert into cat_comment values(0, "+readNum+", '"+cid+"', '"+content+"', '+', now());";
			//동작 성공여부
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
	alert("댓글이 작성되었습니다");
 	location.href= "<%=url%>";
	</script>


</body>
</html>