<%@page import="com.peisia.util.mysql.MysqlProc"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 글목록</title>
<link rel="stylesheet" href="style.css">
</head>
<body id="main">
	<br><bb name="main_name">내가 쓴 글</bb><br><br>
	<ttl>
	| 번호 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제목&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;작성일&nbsp;&nbsp;|&nbsp;&nbsp;조회&nbsp;&nbsp;|&nbsp;&nbsp;추천&nbsp;&nbsp;|
	</ttl><br>
<%
	String id = (String)session.getAttribute("idKey");
	String pw = (String)session.getAttribute("pwKey");
	if(id == null) {
		%>
		<script>
		alert("잘못된 접근입니다.");
		location.href="main.html";
		</script>
		<%
	}
	
	String sCurrentPageNum = request.getParameter("page");
	int currentPageNum = 1;
	if(sCurrentPageNum != null) {
		currentPageNum = Integer.parseInt(sCurrentPageNum);
	}

	MysqlProc.initDb();
	MysqlProc.connectDb();
	ResultSet a = MysqlProc.exeQuery("select count(*) from cat_board where id='"+id+"';");
	int dataCount = 0;
	try {
		a.next();
		dataCount = Integer.parseInt(a.getString("count(*)")); 
		MysqlProc.disconnectDb();
	} catch(Exception e) {
		e.printStackTrace();
	}
	int pageMaxNumber = (int)Math.ceil((double)dataCount / MysqlProc.BOARD_LIST_AMOUNT);

	MysqlProc.connectDb();
	int currentDataIndex = 0;
	currentDataIndex = (currentPageNum - 1) * MysqlProc.BOARD_LIST_AMOUNT;
	
	String sql = "select num, title, tm, (length(count)) - length(replace(count,']','')) as count, (length(recom)) - length(replace(recom,']','')) as recom from cat_board where id='"+id+"' order by tm desc limit "+currentDataIndex+","+MysqlProc.BOARD_LIST_AMOUNT;
	ResultSet rs = MysqlProc.exeQuery(sql);
	
	while(rs.next()){
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
		
		String num = rs.getString("num");
		String title = rs.getString("title");
		String like = rs.getString("recom");
		String ct = rs.getString("count");
		String tm = rs.getString("tm");
		
		
		Statement s = con.createStatement();
		ResultSet rc = s.executeQuery("select count(case when icode="+num+" then 1 end) as icode from cat_comment;");
		rc.next();
		String crp = rc.getString("icode");
%>
	&nbsp;&nbsp;&nbsp;<%=num %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="read_my.jsp?num=<%=num%>"><%=title%></a>&nbsp;&nbsp;[<%=crp %>]
	&nbsp;&nbsp;
	<%=tm %>&nbsp;&nbsp;<%=ct %>&nbsp;&nbsp;<%=like%>
	<br><br>
<%		
	}
	MysqlProc.disconnectDb();
%>

<br>
<%
	for(int i=1;i<=pageMaxNumber;i++){

		if(currentPageNum == i){
%>
			🌰<%=i %>🌰&nbsp;&nbsp;
<%
		} else {
%>						
			🌰<a href="list_my.jsp?page=<%=i %>"><%=i %></a>🌰
<%
		}
	}
%>	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	<input type="button" value="고양이게시판" onclick="location.href='list.jsp'">

</body>
</html>



