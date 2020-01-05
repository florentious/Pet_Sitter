<%@page import="kr.co.acorn.dao.CommentDao"%>
<%@page import="kr.co.acorn.dao.PointDao"%>
<%@page import="kr.co.acorn.dao.BookDao"%>
<%@page import="kr.co.acorn.dao.WantedDao"%>
<%@page import="java.io.File"%>
<%@page import="kr.co.acorn.dao.MemberDao"%>
<%@ page pageEncoding="utf-8" %>

<%
	request.setCharacterEncoding("utf-8");		

	int cPage = Integer.parseInt(request.getParameter("page"));
	String id = request.getParameter("id");
	
	String contextPath = request.getContextPath();
	
	// 기존에 있던 정보들을 전부 삭제해야한다
	MemberDao dao = MemberDao.getInstance();
	WantedDao wantedDao = WantedDao.getInstance();
	PointDao pointDao = PointDao.getInstance();
	BookDao bookDao = BookDao.getInstance();
	CommentDao commentDao = CommentDao.getInstance();
	
	String imgPath = dao.getImgPath(id);
	String subImgPath = imgPath.replace(contextPath, "");
	
	String absPath = request.getRealPath(subImgPath);
	 
	boolean isSuccess = false;
	if( commentDao.deleteFromId(id) && bookDao.deleteFromId(id) && pointDao.deleteFromID(id) && wantedDao.deleteFromId(id) && dao.delete(id)) {
		isSuccess = true;
	}
	
	
	//boolean isSuccess = dao.delete(id);
	
	
	if(isSuccess) {
	    
		
		File file = new File(absPath);
		
		if(file.exists()) {
			// file 존재하면 삭제
			file.delete();
		} 
		
		
%>
 
<script>
	alert("삭제 완료 ");
	location.href="../index.jsp?page=<%=cPage%>";
	<%
	session.invalidate();
	%>
	
</script>

<%
	} else {
%>
<script>
	alert("Database Error");
	history.back(-1);
</script>

<%
	}
	
	
%>