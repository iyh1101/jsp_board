<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   <%
    String readNum = request.getParameter("num");
   	String content = request.getParameter("content");
    String url = (String)session.getAttribute("cmoback");
   	try{
   		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
		Statement st = con.createStatement();
   		String sql = "update cat_comment set content='"+content+"', tm = now() where num="+readNum;
   		System.out.println("실행문"+sql);
   		int resultCount = st.executeUpdate(sql);
   		if(resultCount == 1) {
			System.out.println("댓글수정 성공");
		} else {
			System.out.println("댓글수정 실패");
		}
   		
   	} catch(Exception e) {
   		e.printStackTrace();
   	}
    
    
     %>
     
     <script>
     alert("댓글이 수정되었습니다");
 	location.href= "<%=url%>";
	</script>