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
<title>게시판 - 글목록</title>
<link rel="stylesheet" href="style.css">
</head>
<body id="main">
	<br><bb name="main_name">고양이 게시판</bb>	<br><br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<form>
		<input type ="button" value="검색" onclick="location.href='find.jsp'">
	</form><br>
	<ttl>
	| 번호 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제목&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;작성자&nbsp;&nbsp;|&nbsp;&nbsp;작성일&nbsp;&nbsp;|&nbsp;&nbsp;조회&nbsp;&nbsp;|&nbsp;&nbsp;추천&nbsp;&nbsp;|
	</ttl><br>
	<%	
		String idKey = (String)session.getAttribute("idKey");
		if(idKey == null) {
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
		
		int dataCount = MysqlProc.getDataCount();
		
		int pageMaxNumber = (int)Math.ceil((double)dataCount / MysqlProc.BOARD_LIST_AMOUNT);
		int totalBlock = (int)Math.ceil((double) pageMaxNumber / MysqlProc.BOARD_BLOCK_PAGE_AMOUNT);
		int currentBlockNo = (int)Math.ceil((double) currentPageNum / MysqlProc.BOARD_BLOCK_PAGE_AMOUNT);
		
		MysqlProc.connectDb();
		int currentDataIndex = 0;
		currentDataIndex = (currentPageNum - 1) * MysqlProc.BOARD_LIST_AMOUNT;
		
		String sql = "select num, title, id, tm, (length(count)) - length(replace(count,']','')) as count, (length(recom)) - length(replace(recom,']','')) as recom from cat_board order by tm desc limit "+currentDataIndex+","+MysqlProc.BOARD_LIST_AMOUNT;
		System.out.println("전송할 sql문: "+sql); // sql문 확인용
		ResultSet rs = MysqlProc.exeQuery(sql);
		
		while(rs.next()){
			String num = rs.getString("num");
			String title = rs.getString("title");
			String id = rs.getString("id");
			String like = rs.getString("recom");
			String count = rs.getString("count");
			String tm = rs.getString("tm");
			
			
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
			Statement s = con.createStatement();
			ResultSet rc = s.executeQuery("select count(case when icode="+num+" then 1 end) as icode from cat_comment;");
			rc.next();
			String crp = rc.getString("icode");
	%>
		&nbsp;&nbsp;&nbsp;<%=num %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="read.jsp?num=<%=num%>"><%=title%></a>&nbsp;&nbsp;[<%=crp %>]
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=id %>&nbsp;&nbsp;&nbsp;&nbsp;
		<%=tm %>&nbsp;&nbsp;<%=count %>&nbsp;&nbsp;<%=like%>
		<br><br>
	<%		
		}
		MysqlProc.disconnectDb();
	%>

	<br>
	<%
		int blockStartNo = (currentBlockNo - 1) * MysqlProc.BOARD_BLOCK_PAGE_AMOUNT + 1;
		int blockEndNo = currentBlockNo * MysqlProc.BOARD_BLOCK_PAGE_AMOUNT;
		if(blockEndNo > pageMaxNumber) {
			blockEndNo = pageMaxNumber;
		}
		
		int prevPage = 0;
		int nextPage = 0;
		
		boolean hasPrev = true;
		if(currentBlockNo == 1) {
			hasPrev = false;
		} else {
			hasPrev = true;
			prevPage = (currentBlockNo - 1) * MysqlProc.BOARD_BLOCK_PAGE_AMOUNT; 
		}
		
		boolean hasNext = true;
		if(currentBlockNo < totalBlock) {
			hasNext = true;
			nextPage = currentBlockNo * MysqlProc.BOARD_BLOCK_PAGE_AMOUNT + 1;
		} else {
			hasNext = false;
		}
		
		if(hasPrev) {
			%>
			<a href="list.jsp?page=<%=prevPage%>">🐿️이전블럭가기🐿️</a>
			<%
		}
		
		for(int i = blockStartNo; i <= blockEndNo; i++) {
			
			if(currentPageNum == i) {
				%>
					🌰<%=i %>🌰
				<%
			} else {
				%>
				🌰<a href="list.jsp?page=<%=i %>"><%=i %></a>🌰
				<%
			}
			
		}
		
		if(hasNext) {
			%>
			<a href="list.jsp?page=<%=nextPage%>">🐿️다음블럭가기🐿️</a>
			<%
		}
		
		
		// 5.페이지 리스트 출력 처리 [1] [2] [3] [4] ...
		// 현재 페이지 번호에는 링크 X
		
	%>	
		
		
		
		
		
		
		
	
		
	
		
	<br><br>
	<input type="button" value="글쓰기" onclick="location.href='write.jsp'">
	<br><br><br>
	<input type="submit" value="내글보기" onclick="location.href='list_my.jsp'">
	<input type="button" value="로그아웃" onclick="location.href='logoutproc.jsp'">
	

</body>
</html>