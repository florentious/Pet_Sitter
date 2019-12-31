<%@page import="java.io.File"%>
<%@page import="kr.co.acorn.dao.MemberDao"%>
<%@ page pageEncoding="utf-8" %>

<%
	request.setCharacterEncoding("utf-8");		

	int cPage = Integer.parseInt(request.getParameter("page"));
	String id = request.getParameter("id");
	
	String contextPath = request.getContextPath();
	
	MemberDao dao = MemberDao.getInstance();
	
	String imgPath = dao.getImgPath(id);
	String subImgPath = imgPath.replace(contextPath, "");
	
	String absPath = request.getRealPath(subImgPath);
	boolean isSuccess = dao.delete(id);
	
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