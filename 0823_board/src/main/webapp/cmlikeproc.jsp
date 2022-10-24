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
	String cNum = request.getParameter("num");
	System.out.println("댓글좋아요 리드넘버"+cNum);
	String url = request.getHeader("referer");
	String id = (String)session.getAttribute("idKey");
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
		Statement st = con.createStatement();
		
		ResultSet r = st.executeQuery("select (length(recom)) - length(replace(recom,'+"+id+"]+','')) as recom from cat_comment where num ="+cNum);
		r.next();
		String clcl = r.getString("recom");
		int cln = Integer.parseInt(clcl);
		if(cln == 0) {
			st.executeUpdate("update cat_comment set recom = concat(recom, '"+id+"]+') where num = "+cNum);
			System.out.println("추천하기를 눌렀습니다");
		} else {
			st.executeUpdate("update cat_comment set recom = replace(recom, '+"+id+"]+', '+') where recom like '%+"+id+"]%' and num ="+cNum);
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
