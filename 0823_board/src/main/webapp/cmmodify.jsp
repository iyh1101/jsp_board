<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판-글수정</title>
<link rel="stylesheet" href="style.css">
</head>
<body id="main">
	<br>
	<%	
		String id = null;
		String cid = (String)session.getAttribute("idKey");
		if(cid == null) {
			%>
			<script>
			alert("잘못된 접근입니다.");
			location.href="main.html";
			</script>
			<%
		}
		String readNum = request.getParameter("num");
		String url = request.getHeader("referer");
		session.setAttribute("cmoback",url);
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select num, title, content, id, count, tm, (length(recom)) - length(replace(recom,']','')) as recom from cat_board where num="+readNum);
			rs.next();
			String num = rs.getString("num");
			String title = rs.getString("title");
			String content = rs.getString("content");
			id = rs.getString("id");
			String like = rs.getString("recom");
			String count = rs.getString("count");
			String tm = rs.getString("tm");
			
	%>		
		
		글번호: <%=num %><br>
		글제목: <%=title %><br>
		작성자: <%=id %><br>
		<%=tm %>
		조회 <%=count %><br>
		---------------------------------
		<br><%=content %><br><br>
		추천수: <%=like %>
	<%
		}	catch(Exception e) {
			e.printStackTrace();
		}
	%>
	
	
	
	
	
	
	| 댓글 |<br><br>
	<%	
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select num, id, content, (length(recom)) - length(replace(recom,']','')) as recom from cat_comment where icode="+readNum);
			while(rs.next() ) {
			String rid = rs.getString("id");
			String content = rs.getString("content");
			String like = rs.getString("recom");
			String cnum = rs.getString("num");
	%>		
		
		<%=rid %>&nbsp;&nbsp;|&nbsp;&nbsp;<%=content %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;👍[<%=like %>]
		<br><br>
		<%if(rid.equals(cid) ) { %>
	<form action="cmmodifyproc.jsp" method="get">
		<input name="num" type="hidden" value="<%=cnum%>">
		<textarea name="content" id="content"><%=content%></textarea>
		<input type="button" value="취소" onclick="javascript:history.go(-1)">&nbsp;
		<input type="submit" value="등록">
	</form>
		
		<%}
		
	
		}
			
		}	catch(Exception e) {
			e.printStackTrace();
		}
	%>
	
	
	
	
	<br>
	<br>
	<input type="button" value="고양이게시판" onclick="location.href='list.jsp'">

</body>
</html>



