<%@page import="kr.co.acorn.dao.MemberDao"%>
<%@ page pageEncoding="utf-8" %>

<%
	request.setCharacterEncoding("utf-8");		

	int cPage = Integer.parseInt(request.getParameter("page"));
	String email = request.getParameter("email");
	
	
	MemberDao dao = MemberDao.getInstance();
	
	
	boolean isSuccess = dao.delete(email);
	
	if(isSuccess) {
	
%>
<script>
	alert("delete complete");
	location.href="list.jsp?page=<%=cPage%>";
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