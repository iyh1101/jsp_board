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
<title>게시판-글읽기</title>
<link rel="stylesheet" href="style.css">
</head>
<body id="main">
	<br>
	&nbsp;&nbsp;
	<form>
		<input type ="button" value="검색" onclick="location.href='find.jsp'">
	</form>
	<br>
	<%	
		//팔로우기능 비밀글, 비밀댓글
		String id = null;
		String cid = (String)session.getAttribute("idKey");
		String readNum = request.getParameter("num");
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
			Statement ss = con.createStatement();
			ResultSet r = ss.executeQuery("select (length(count)) - length(replace(count,'+"+cid+"]+','')) as count from cat_board where num ="+readNum);
			r.next();
			String cl = r.getString("count");
			int cln = Integer.parseInt(cl);
			
			if(cln == 0) {
				Statement st = con.createStatement();
				st.executeUpdate("update cat_board set count = concat(count,'"+cid+"]+') where num ="+readNum);
				
				ResultSet rs = st.executeQuery("select num, title, content, id, (length(count)) - length(replace(count,']','')) as count, tm, (length(recom)) - length(replace(recom,']','')) as recom from cat_board where num="+readNum);		
				rs.next();
				String num = rs.getString("num");
				String title = rs.getString("title");
				String content = rs.getString("content");
				id = rs.getString("id");
				String like = rs.getString("recom");
				String count = rs.getString("count");
				String tm = rs.getString("tm");
				
				%>		
				<div id="contentbox">
				글번호: <%=num %><br>
				글제목: <%=title %><br>
				작성자: <%=id %><br>
				<%=tm %>
				조회 <%=count %><br>
				<hr>
				<br><%=content %><br><br>
				</div>
				👍 [ <%=like %> ]
			<%
				
			} else {
				Statement st = con.createStatement();
				
				ResultSet rs = st.executeQuery("select num, title, content, id, (length(count)) - length(replace(count,']','')) as count, tm, (length(recom)) - length(replace(recom,']','')) as recom from cat_board where num="+readNum);		
				rs.next();
				String num = rs.getString("num");
				String title = rs.getString("title");
				String content = rs.getString("content");
				id = rs.getString("id");
				String like = rs.getString("recom");
				String count = rs.getString("count");
				String tm = rs.getString("tm");
				
				%>		
				<div id="contentbox">
				글번호: <%=num %><br>
				글제목: <%=title %><br>
				작성자: <%=id %><br>
				<%=tm %>
				조회 <%=count %><br>
				<hr>
				<br><%=content %><br><br>
				</div>
				<br>
				<label id="like-button">
				👍 [ <%=like %> ]
			<%
				
			}
			
		}	catch(Exception e) {
			e.printStackTrace();
		}
	%>
	<input type="checkbox" onclick="location.href='likeproc.jsp?num=<%=readNum%>'">추천!
	</label><br><br>
	
	
	
	
	
	
	
	
	| 댓글 
	<%	
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select num, id, content, tm, (length(recom)) - length(replace(recom,']','')) as recom from cat_comment where icode="+readNum);
			
			Statement s = con.createStatement();
			ResultSet rc = s.executeQuery("select count(case when icode="+readNum+" then 1 end) as icode from cat_comment;");
			rc.next();
			String crp = rc.getString("icode");
			%>
			: <%=crp %>&nbsp;|<br><br>			
			
			<%
			while(rs.next() ) {
			String rid = rs.getString("id");
			String content = rs.getString("content");
			String like = rs.getString("recom");
			String cnum = rs.getString("num");
			String tm = rs.getString("tm");
	%>		
		
		<%=rid %>&nbsp;&nbsp;|&nbsp;&nbsp;<%=content %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;👍 [ <%=like %> ]
		<label class="like-button">
		<input type="checkbox" onclick="location.href='cmlikeproc.jsp?num=<%=cnum%>'">추천!
		</label><br><%=tm %><br><br>
		<%
	if(rid.equals(cid) ) {
		System.out.println("아이디 일치");
		%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="수정" onclick="location.href='cmmodify.jsp?num=<%=readNum%>'">&nbsp;
		<input type="button" value="삭제" onclick="location.href='cmdelproc.jsp?num=<%=cnum%>'">
		<br><br>
	
	<%
	}
		}
			
		}	catch(Exception e) {
			e.printStackTrace();
		}
	%>
	
	
	
	<form action="commentproc.jsp" method="get">
		<input name="num" type="hidden" value="<%=readNum%>">
		<textarea name="content" id="r_comment"></textarea>
		<input type="submit" value="댓글작성">
	</form>
	<br>
	<br>
	<input type="button" value="글목록으로" onclick="location.href='list_my.jsp'">
	<%
	if(id.equals(cid) ) {
		System.out.println("아이디일치");
		%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="글수정" onclick="location.href='modify.jsp?num=<%=readNum%>'">
	<input type="button" value="글삭제" onclick="location.href='delproc.jsp?num=<%=readNum%>'">
		<%
	} else {
		System.out.println("아이이 불일치");
	}
	%>

</body>
</html>



