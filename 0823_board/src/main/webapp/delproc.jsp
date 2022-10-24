<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String delNum = request.getParameter("num");
	System.out.println("dfdfkd"+delNum);
	String url = request.getHeader("referer");
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
		Statement st = con.createStatement();
		String sql = "delete from cat_board where num="+delNum;
		System.out.println("실행문:"+sql);
		int resultCount = st.executeUpdate(sql);
		if(resultCount == 1) {
			System.out.println("글삭제 성공");
		} else {
			System.out.println("글삭제 실패");
		}
	
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
	<script>
	alert("게시글이 삭제되었습니다");
	<% 
	if(url.contains("my") ) {
		%>location.href="list_my.jsp"; <%
	} else {
		%>location.href="list.jsp"; <%
	}
	%>
	</script>