<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    <%
    	String id = (String)session.getAttribute("newid");
    	String pw = request.getParameter("pw");
    	String pw2 = request.getParameter("pw2");
    	System.out.println("pw: "+pw);
    	System.out.println("id: "+id);
    	
    if(pw.equals(pw2) ) {
    	try {
    		Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
			Statement st = con.createStatement();
    		int resultCount = st.executeUpdate("insert into member values('"+id+"','"+pw+"');");
    			
    		if(resultCount == 1) {
    			%>
    			<script>
    			alert("가입완료");
    			location.href="main.html";
    			</script>
    			<%
    		} else {
    			%>
    			<script>
    			alert("가입실패");
    			location.href="javascript:history.go(-1)";
    			</script>
    			<%
    			}
    		   		
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    } else {
    	%>
		<script>
		alert("비밀번호 불일치");
		location.href="javascript:history.go(-1)";
		</script>
		<%
    }
    
    %>