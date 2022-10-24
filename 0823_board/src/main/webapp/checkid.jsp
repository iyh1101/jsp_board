<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%	
    	String id = request.getParameter("id");
    	try {
    		Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
			Statement st = con.createStatement();
    		ResultSet rs = st.executeQuery("select count(case when id='"+id+"' then 1 end) as id from member;");
    		rs.next();
    		String c = rs.getString("id");
    		
    		if(c.equals("1") ) {
    			%>
				<script>
    			alert("중복된 아이디가 존재합니다");
    			location.href="javascript:history.go(-1)";
    			</script>
				<%
    		} if(c.equals("0") ) {
    	   		session.setAttribute("newid",id);
    	   		
    	   		if(id.equals("") || id.contains(" ") ) {
        			%>
    				<script>
        			alert("아이디를 다시 입력해주세요");
        			location.href="javascript:history.go(-1)";
        			</script>
    				<%
        		} else {
    			%>
				<script>
    		        if (confirm("사용가능한 아이디입니다. 확인을 누르시면 다음단계로 이동합니다")) {
    		            location.href="account2.jsp";
    		        } else {
    		            location.href="javascript:history.go(-1)";
    		        }
    			</script>
				<%
        		}
    		}
    		
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    	
    			
    	
    %>
    	
    	
    	