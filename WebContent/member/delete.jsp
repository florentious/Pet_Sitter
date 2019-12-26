<%@page import="kr.co.acorn.dao.MemberDao"%>
<%@ page pageEncoding="utf-8" %>

<%
	request.setCharacterEncoding("utf-8");		

	int cPage = Integer.parseInt(request.getParameter("page"));
	String id = request.getParameter("id");
	
	
	MemberDao dao = MemberDao.getInstance();
	
	boolean isSuccess = dao.delete(id);
	
	if(isSuccess) {
	
%>
<script>
	alert("delete complete");
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