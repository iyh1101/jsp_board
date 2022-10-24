<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
	String readNum = request.getParameter("num");
	System.out.println("본문 좋아요 리드넘버"+readNum);
	String url = request.getHeader("referer");
	String id = (String)session.getAttribute("idKey");
	
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
		Statement st = con.createStatement();
		
		ResultSet r = st.executeQuery("select (length(recom)) - length(replace(recom,'+"+id+"]+','')) as recom from cat_board where num ="+readNum);
		r.next();
		String clcl = r.getString("recom");
		int cln = Integer.parseInt(clcl);
		if(cln == 0) {
			st.executeUpdate("update cat_board set recom = concat(recom, '"+id+"]+') where num = "+readNum);
			System.out.println("추천하기를 눌렀습니다");
		} else {
			st.executeUpdate("update cat_board set recom = replace(recom, '+"+id+"]+', '+') where recom like '%+"+id+"]%' and num ="+readNum);
			System.out.println("추천하기를 취소합니다");
		}
		
		
	}	catch(Exception e) {
		e.printStackTrace();
	}
%>
	
	;
	%>
</body>
</ml>

	<script>
	location.href="<%=url%>";
	</script>