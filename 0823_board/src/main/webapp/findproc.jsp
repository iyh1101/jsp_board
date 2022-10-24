<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.peisia.util.mysql.MysqlProc"%>
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
    
    <%
    	int pageCount = 0;
    	String keyword = (String)request.getParameter("text");
    	String[] array = keyword.split(" ");
    	
	    String tag = request.getParameter("tag");
	    //System.out.println(tag);
    	if(keyword.equals("") ) {
    		System.out.println("no word");
    		%>
    		<script>
    		alert("검색어를 입력해주세요");
    		location.href="find.jsp";
    		</script>
    		<%
    	}
    	String sCurrentPageNum = request.getParameter("page");
    	int currentPageNum = 1;
    	if(sCurrentPageNum != null){		
    		currentPageNum = Integer.parseInt(sCurrentPageNum);
    	}
    	
	    switch(tag) {
	    case "제목" :
	    	%>
	    	<br><bb name="main_name">검색결과</bb><br><br>
			<ttl>
			| 번호 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제목&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;작성일&nbsp;&nbsp;|&nbsp;&nbsp;조회&nbsp;&nbsp;|&nbsp;&nbsp;추천&nbsp;&nbsp;|
			</ttl><br>
	<%	
	    	try {
	    		Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
				
				Statement su = con.createStatement();
				ResultSet sp = su.executeQuery("select count(*) as count from cat_board where title like '%"+keyword+"%';");
				sp.next();
				pageCount += Integer.parseInt(sp.getString("count") );
				
				if(array.length == 1) {
					System.out.println("1");
				
				Statement st = con.createStatement();
	    		ResultSet rs = st.executeQuery("select num, title, (length(count)) - length(replace(count,']','')) as count, id, tm, content, (length(recom)) - length(replace(recom,']','')) as recom from cat_board where title like '%"+keyword+"%';");
	    		
	    		while(rs.next() ) {
	    		String num = rs.getString("num");
	    		String title = rs.getString("title");
	    		String count = rs.getString("count");
	    		String id = rs.getString("id");
	    		String tm = rs.getString("tm");
	    		String content = rs.getString("content");
	    		String recom = rs.getString("recom");
	    		
	    		Statement s = con.createStatement();
	    		ResultSet rc = s.executeQuery("select count(case when icode="+num+" then 1 end) as icode from cat_comment;");
	    		rc.next();
	    		String crp = rc.getString("icode");
	    		%>
	    			&nbsp;&nbsp;&nbsp;<%=num %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="read_my.jsp?num=<%=num%>"><%=title%></a>&nbsp;&nbsp;[<%=crp %>]
					&nbsp;&nbsp;
					<%=tm %>&nbsp;&nbsp;<%=count %>&nbsp;&nbsp;<%=recom%>
					<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=content %><br><br>
	    		<%
	    			}
	    			break;
	    		}
				else {
					String sql = "select num, title, (length(count)) - length(replace(count,']','')) as count, id, tm, content, (length(recom)) - length(replace(recom,']','')) as recom from cat_board where title like '%"+keyword+"%'";
					//0 1 2  and (title like '' or title like '')
	    			for(int i = 0; i < array.length; i++) {
	    				sql = sql+" or title like '%"+array[i]+"%'";
	    			}
	    				Statement s = con.createStatement();
	    				ResultSet rc = s.executeQuery(sql);
	    				System.out.println("실행:"+sql);
	    				while(rc.next() ) {
	    					String num = rc.getString("num");
	    		    		String title = rc.getString("title");
	    		    		String count = rc.getString("count");
	    		    		String id = rc.getString("id");
	    		    		String tm = rc.getString("tm");
	    		    		String content = rc.getString("content");
	    		    		String recom = rc.getString("recom");
	    		    		
	    		    		Statement t = con.createStatement();
	    		    		ResultSet r = t.executeQuery("select count(case when icode="+num+" then 1 end) as icode from cat_comment;");
	    		    		r.next();
	    		    		String crp = r.getString("icode");
	    		    		%>
	    		    			&nbsp;&nbsp;&nbsp;<%=num %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    						<a href="read_my.jsp?num=<%=num%>"><%=title%></a>&nbsp;&nbsp;[<%=crp %>]
	    						&nbsp;&nbsp;
	    						<%=tm %>&nbsp;&nbsp;<%=count %>&nbsp;&nbsp;<%=recom%>
	    						<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=content %><br><br>
	    		    		<%
	    				}
	    		    			break;
					}
	    		
	    	} catch(Exception e) {
	    		e.printStackTrace();
	    	}
	    	break;
	    	
	    	
	    	
	    	
	    	
	    case "본문" :
	    	%>
	    	<br><bb name="main_name">검색결과</bb><br><br>
			<ttl>
			| 번호 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제목&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;작성일&nbsp;&nbsp;|&nbsp;&nbsp;조회&nbsp;&nbsp;|&nbsp;&nbsp;추천&nbsp;&nbsp;|
			</ttl><br>
	<%
	    	
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
		
		Statement su = con.createStatement();
		ResultSet sp = su.executeQuery("select count(*) as count from cat_board where title like '%"+keyword+"%';");
		sp.next();
		pageCount += Integer.parseInt(sp.getString("count") );
		
		if(array.length == 1) {
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("select num, title, (length(count)) - length(replace(count,']','')) as count, id, tm, content, (length(recom)) - length(replace(recom,']','')) as recom from cat_board where content like '%"+keyword+"%';");
				
		while(rs.next() ) {
		String num = rs.getString("num");
		String title = rs.getString("title");
		String count = rs.getString("count");
		String id = rs.getString("id");
		String tm = rs.getString("tm");
		String content = rs.getString("content");
		String recom = rs.getString("recom");
		
		Statement s = con.createStatement();
		ResultSet rc = s.executeQuery("select count(case when icode="+num+" then 1 end) as icode from cat_comment;");
		rc.next();
		String crp = rc.getString("icode");
		%>
			&nbsp;&nbsp;&nbsp;<%=num %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="read_my.jsp?num=<%=num%>"><%=title%></a>&nbsp;&nbsp;[<%=crp %>]
			&nbsp;&nbsp;
			<%=tm %>&nbsp;&nbsp;<%=count %>&nbsp;&nbsp;<%=recom%>
			<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=content %><br><br>
		<%
			}
			break;
		}
		else {
			String sql = "select num, title, (length(count)) - length(replace(count,']','')) as count, id, tm, content, (length(recom)) - length(replace(recom,']','')) as recom from cat_board where content like '%"+keyword+"%'";
			//0 1 2  and (title like '' or title like '')
			for(int i = 0; i < array.length; i++) {
				sql = sql+" or content like '%"+array[i]+"%'";
			}
				Statement s = con.createStatement();
				ResultSet rc = s.executeQuery(sql);
				System.out.println("실행:"+sql);
				while(rc.next() ) {
					String num = rc.getString("num");
		    		String title = rc.getString("title");
		    		String count = rc.getString("count");
		    		String id = rc.getString("id");
		    		String tm = rc.getString("tm");
		    		String content = rc.getString("content");
		    		String recom = rc.getString("recom");
		    		
		    		Statement t = con.createStatement();
		    		ResultSet r = t.executeQuery("select count(case when icode="+num+" then 1 end) as icode from cat_comment;");
		    		r.next();
		    		String crp = r.getString("icode");
		    		%>
		    			&nbsp;&nbsp;&nbsp;<%=num %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="read_my.jsp?num=<%=num%>"><%=title%></a>&nbsp;&nbsp;[<%=crp %>]
						&nbsp;&nbsp;
						<%=tm %>&nbsp;&nbsp;<%=count %>&nbsp;&nbsp;<%=recom%>
						<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=content %><br><br>
		    		<%
				}
		    			break;
			}
		
	} catch(Exception e) {
		e.printStackTrace();
	}
	break;
	    	
	
	
	
	
	    case "댓글" :
	    	%>
	    	<br><bb name="main_name">검색결과</bb><br><br>
			<ttl>
			| 글번호 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;본문제목&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;작성일&nbsp;&nbsp;|&nbsp;&nbsp;조회&nbsp;&nbsp;|&nbsp;&nbsp;추천&nbsp;&nbsp;|
			</ttl><br>
	<%	// num id tm content recom   select num, id, tm, content, (length(recom)) - length(replace(recom,']','')) as recom from cat_comment where content like '%"+keyword+"%';
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
			
			Statement su = con.createStatement();
			ResultSet sp = su.executeQuery("select count(*) as count from cat_board where title like '%"+keyword+"%';");
			sp.next();
			pageCount += Integer.parseInt(sp.getString("count") );
			
			if(array.length == 1) {
				System.out.println("1");
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select id, tm, content, icode, (length(recom)) - length(replace(recom,']','')) as recom from cat_comment where content like '%"+keyword+"%';");
				
			while(rs.next() ) {
			String id = rs.getString("id");
			String tm = rs.getString("tm");
			String content = rs.getString("content");
			String recom = rs.getString("recom");
			String icode = rs.getString("icode");
			
			Statement ss = con.createStatement();
			ResultSet r = ss.executeQuery("select id, tm, content, title, num, (length(recom)) - length(replace(recom,']','')) as recom from cat_board where num ="+icode);
			r.next();
			String num = r.getString("num");
			String mid = r.getString("id");
			String mtm = r.getString("tm");
			String mrc = r.getString("recom");
			String mtt = r.getString("title");
			
			Statement s = con.createStatement();
			ResultSet rc = s.executeQuery("select count(case when icode="+num+" then 1 end) as icode from cat_comment;");
			rc.next();
			String crp = rc.getString("icode");
			%>
				&nbsp;&nbsp;&nbsp;<%=num %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="read_my.jsp?num=<%=num%>"><%=mtt%></a>&nbsp;&nbsp;[<%=crp %>]
				&nbsp;&nbsp;
				<%=mtm %>&nbsp;&nbsp;<%=mrc%>
				<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;댓id: <%=id %>&nbsp;&nbsp;|&nbsp;댓글내용: <%=content %>&nbsp;|&nbsp;<%=tm %>&nbsp;|&nbsp;추천: <%=recom %>
				<br><br>
			<%	
			}
				break;
			}
			else {
				String sql = "select num, id, tm, content, (length(recom)) - length(replace(recom,']','')) as recom from cat_comment where title like '%"+keyword+"%'";
				//0 1 2  and (title like '' or title like '')
				for(int i = 0; i < array.length; i++) {
					sql = sql+" or title like '%"+array[i]+"%'";
				}
					Statement s = con.createStatement();
					ResultSet rc = s.executeQuery(sql);
					System.out.println("실행:"+sql);
					while(rc.next() ) {
						String num = rc.getString("num");
			    		String id = rc.getString("id");
		    			String tm = rc.getString("tm");
		    			String content = rc.getString("content");
		    			String recom = rc.getString("recom");
		    		
			    		Statement t = con.createStatement();
			    		ResultSet r = t.executeQuery("select count(case when icode="+num+" then 1 end) as icode from cat_comment;");
			    		r.next();
		    			String crp = r.getString("icode");
		    			%>
		    				&nbsp;&nbsp;&nbsp;<%=num %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="read_my.jsp?num=<%=num%>"><%=content%></a>&nbsp;&nbsp;[<%=crp %>]
							&nbsp;&nbsp;
							<%=tm %>&nbsp;&nbsp;<%=recom%>
							<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=content %><br><br>
		    			<%
					}
		    			break;
				}
		
		} catch(Exception e) {
			e.printStackTrace();
		}
			break;
	
	
	
	
			
	    case "전체" :
	    	%>
	    	<br><bb name="main_name">검색결과</bb><br><br>
			<ttl>
			| 번호 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제목&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;작성일&nbsp;&nbsp;|&nbsp;&nbsp;조회&nbsp;&nbsp;|&nbsp;&nbsp;추천&nbsp;&nbsp;|
			</ttl><br>
			<%
			
			try {
	    		Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_cat","root","admin");
				
				Statement su = con.createStatement();
				ResultSet sp = su.executeQuery("select count(*) as count from cat_board where title like '%"+keyword+"%';");
				sp.next();
				pageCount += Integer.parseInt(sp.getString("count") );
				
				if(array.length == 1) {
				
				Statement s1 = con.createStatement();
	    		ResultSet r1 = s1.executeQuery("select num, title, (length(count)) - length(replace(count,']','')) as count, id, tm, content, (length(recom)) - length(replace(recom,']','')) as recom from cat_board where title like '%"+keyword+"%';");
	    		while(r1.next() ) {
	    		String num = r1.getString("num");
	    		String title = r1.getString("title");
	    		String count = r1.getString("count");
	    		String id = r1.getString("id");
	    		String tm = r1.getString("tm");
	    		String content = r1.getString("content");
	    		String recom = r1.getString("recom");
	    		
	    		Statement s2 = con.createStatement();
	    		ResultSet r2 = s2.executeQuery("select count(case when icode="+num+" then 1 end) as icode from cat_comment;");
	    		r2.next();
	    		String crp = r2.getString("icode");
	    		%>
	    			&nbsp;&nbsp;&nbsp;<%=num %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="read_my.jsp?num=<%=num%>"><%=title%></a>&nbsp;&nbsp;[<%=crp %>]
					&nbsp;&nbsp;
					<%=tm %>&nbsp;&nbsp;<%=count %>&nbsp;&nbsp;<%=recom%>
					<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=content %><br><br>
	    		<%
	    			}
	    		
	    		
				Statement s2 = con.createStatement();
	    		ResultSet r2 = s2.executeQuery("select num, title, (length(count)) - length(replace(count,']','')) as count, id, tm, content, (length(recom)) - length(replace(recom,']','')) as recom from cat_board where content like '%"+keyword+"%';");
	    		
	    		while(r2.next() ) {
	    		String num = r2.getString("num");
	    		String title = r2.getString("title");
	    		String count = r2.getString("count");
	    		String id = r2.getString("id");
	    		String tm = r2.getString("tm");
	    		String content = r2.getString("content");
	    		String recom = r2.getString("recom");
	    		
	    		Statement s3 = con.createStatement();
	    		ResultSet r3 = s3.executeQuery("select count(case when icode="+num+" then 1 end) as icode from cat_comment;");
	    		r3.next();
	    		String crp = r3.getString("icode");
	    		%>
	    			&nbsp;&nbsp;&nbsp;<%=num %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="read_my.jsp?num=<%=num%>"><%=title%></a>&nbsp;&nbsp;[<%=crp %>]
					&nbsp;&nbsp;
					<%=tm %>&nbsp;&nbsp;<%=count %>&nbsp;&nbsp;<%=recom%>
					<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=content %><br><br>
	    		<%
	    		}
	    		
	    		Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select id, tm, content, icode, (length(recom)) - length(replace(recom,']','')) as recom from cat_comment where content like '%"+keyword+"%';");
					
				while(rs.next() ) {
				String id = rs.getString("id");
				String tm = rs.getString("tm");
				String content = rs.getString("content");
				String recom = rs.getString("recom");
				String icode = rs.getString("icode");
				
				Statement ss = con.createStatement();
				ResultSet r = ss.executeQuery("select id, tm, content, title, num, (length(recom)) - length(replace(recom,']','')) as recom from cat_board where num ="+icode);
				r.next();
				String num = r.getString("num");
				String mid = r.getString("id");
				String mtm = r.getString("tm");
				String mrc = r.getString("recom");
				String mtt = r.getString("title");
				
				Statement s = con.createStatement();
				ResultSet rc = s.executeQuery("select count(case when icode="+num+" then 1 end) as icode from cat_comment;");
				rc.next();
				String crp = rc.getString("icode");
				%>
					&nbsp;&nbsp;&nbsp;<%=num %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="read_my.jsp?num=<%=num%>"><%=mtt%></a>&nbsp;&nbsp;[<%=crp %>]
					&nbsp;&nbsp;
					<%=mtm %>&nbsp;&nbsp;<%=mrc%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;댓id: <%=id %>&nbsp;&nbsp;|&nbsp;댓글내용: <%=content %>&nbsp;|&nbsp;<%=tm %>&nbsp;|&nbsp;추천: <%=recom %>
					<br><br>
	    		<%
				}
	    			break;
	    		}
				// 빈칸있을때
				else {
					
					String sql = "select num, title, (length(count)) - length(replace(count,']','')) as count, id, tm, content, (length(recom)) - length(replace(recom,']','')) as recom from cat_board where title like '%"+keyword+"%'";
					//0 1 2  and (title like '' or title like '')
	    			for(int i = 0; i < array.length; i++) {
	    				sql = sql+" or title like '%"+array[i]+"%'";
	    			}
	    				Statement s1 = con.createStatement();
	    				ResultSet r1 = s1.executeQuery(sql);
	    				System.out.println("실행:"+sql);
	    				while(r1.next() ) {
	    					String num = r1.getString("num");
	    		    		String title = r1.getString("title");
	    		    		String count = r1.getString("count");
	    		    		String id = r1.getString("id");
	    		    		String tm = r1.getString("tm");
	    		    		String content = r1.getString("content");
	    		    		String recom = r1.getString("recom");
	    		    		
	    		    		Statement s2 = con.createStatement();
	    		    		ResultSet r2 = s2.executeQuery("select count(case when icode="+num+" then 1 end) as icode from cat_comment;");
	    		    		r2.next();
	    		    		String crp = r2.getString("icode");
	    		    		%>
	    		    			&nbsp;&nbsp;&nbsp;<%=num %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    						<a href="read_my.jsp?num=<%=num%>"><%=title%></a>&nbsp;&nbsp;[<%=crp %>]
	    						&nbsp;&nbsp;
	    						<%=tm %>&nbsp;&nbsp;<%=count %>&nbsp;&nbsp;<%=recom%>
	    						<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=content %><br><br>
	    		    		<%
	    				}

	    				String sql2 = "select num, title, (length(count)) - length(replace(count,']','')) as count, id, tm, content, (length(recom)) - length(replace(recom,']','')) as recom from cat_board where content like '%"+keyword+"%'";
	    				//0 1 2  and (title like '' or title like '')
	    				for(int i = 0; i < array.length; i++) {
	    					sql2 = sql2+" or content like '%"+array[i]+"%'";
	    				}
	    					Statement s2 = con.createStatement();
	    					ResultSet r2 = s2.executeQuery(sql2);
	    					while(r2.next() ) {
	    						String num = r2.getString("num");
	    			    		String title = r2.getString("title");
	    			    		String count = r2.getString("count");
	    			    		String id = r2.getString("id");
	    			    		String tm = r2.getString("tm");
	    			    		String content = r2.getString("content");
	    			    		String recom = r2.getString("recom");
	    			    		
	    			    		Statement t = con.createStatement();
	    			    		ResultSet r = t.executeQuery("select count(case when icode="+num+" then 1 end) as icode from cat_comment;");
	    			    		r.next();
	    			    		String crp = r.getString("icode");
	    			    		%>
	    			    			&nbsp;&nbsp;&nbsp;<%=num %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    							<a href="read_my.jsp?num=<%=num%>"><%=title%></a>&nbsp;&nbsp;[<%=crp %>]
	    							&nbsp;&nbsp;
	    							<%=tm %>&nbsp;&nbsp;<%=count %>&nbsp;&nbsp;<%=recom%>
	    							<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=content %><br><br>
	    			    		<%
	    					}
	    				
	    					String sql3 = "select num, id, tm, content, (length(recom)) - length(replace(recom,']','')) as recom from cat_comment where title like '%"+keyword+"%'";
	    					//0 1 2  and (title like '' or title like '')
	    					for(int i = 0; i < array.length; i++) {
	    						sql3 = sql3+" or title like '%"+array[i]+"%'";
	    					}
	    						Statement s3 = con.createStatement();
	    						ResultSet r3 = s3.executeQuery(sql3);
	    						while(r3.next() ) {
	    							String num = r3.getString("num");
	    				    		String id = r3.getString("id");
	    			    			String tm = r3.getString("tm");
	    			    			String content = r3.getString("content");
	    			    			String recom = r3.getString("recom");
	    			    		
	    				    		Statement t = con.createStatement();
	    				    		ResultSet r = t.executeQuery("select count(case when icode="+num+" then 1 end) as icode from cat_comment;");
	    				    		r.next();
	    			    			String crp = r.getString("icode");
	    			    			%>
	    			    				&nbsp;&nbsp;&nbsp;<%=num %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    								<a href="read_my.jsp?num=<%=num%>"><%=content%></a>&nbsp;&nbsp;[<%=crp %>]
	    								&nbsp;&nbsp;
	    								<%=tm %>&nbsp;&nbsp;<%=recom%>
	    								<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=content %><br><br>
	    			    			<%
	    						}
	    				
   		    			break;
					}
	    		
	    	} catch(Exception e) {
	    		e.printStackTrace();
	    	}
	    	break;
			
	    default :
	    	%>
	    	<script>
		    alert("검색 영역을 선택해주세요");
		    location.href="javascript:history.go(-1)";
	    	</script>
	    	<%
	 		break;
	    }
	    
	int pageMaxNumber = (int)Math.ceil((double)pageCount / MysqlProc.BOARD_LIST_AMOUNT);
    	MysqlProc.initDb();
    	MysqlProc.connectDb();
    	int currentDataIndex = 0;
    	currentDataIndex = (currentPageNum - 1) * MysqlProc.BOARD_LIST_AMOUNT;
	
	for(int i=1;i<=pageMaxNumber;i++){

		if(currentPageNum == i){
%>
			🌰<%=i %>🌰&nbsp;&nbsp;
<%
		} else {
			String urlEncoded = java.net.URLEncoder.encode(keyword);
%>			
			🌰<a href="findproc.jsp?tag=<%=tag%>&text=<%=urlEncoded%>&page=<%=i %>"><%=i %></a>🌰
<%
		}
	}
%>
    <input type="button" value="뒤로가기" onclick="javascript:history.back()">
</body>
</html>