<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String delNum = request.getParameter("num");
	System.out.println("댓글삭제 번호 넘어왔는가"+delNum);
	String url = request.getHeader("referer");
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
		Statement s = con.createStatement();
		ResultSet rs = s.executeQuery("select icode from cat_comment where num ="+delNum);
		rs.next();
		String rnum = rs.getString("icode");
		System.out.println("알넘버"+rnum);
		
		Statement st = con.createStatement();
		String sql = "delete from cat_comment where num="+delNum;
		System.out.println("실행문:"+sql);
		int resultCount = st.executeUpdate(sql);
		if(resultCount == 1 && url.contains("my")) {
			System.out.println("댓글삭제 성공");
			%>
			<script>
			alert("댓글이 삭제되었습니다");
			location.href="read_my.jsp?num=<%=rnum%>";
			</script>
			<%
		} else {
			System.out.println("댓글삭제 성공");
			%>
			<script>
			alert("댓글이 삭제되었습니다");
			location.href="read.jsp?num=<%=rnum%>";
			</script>
			<%
		}
	
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
	