
<%@page import="kr.co.acorn.dao.CommentDao"%>
<%@page import="kr.co.acorn.dto.MemberDto"%>
<%@page import="kr.co.acorn.dao.WantedDao"%>
<%@ page pageEncoding="utf-8" %>

<%
	
	
	request.setCharacterEncoding("utf-8");		
	
	
	int cPage = Integer.parseInt(request.getParameter("page"));
	
	String tempNo = request.getParameter("wantedNo");
	
	int cNo = 0;
	
	try {
		cNo = Integer.parseInt(tempNo);
	} catch(NumberFormatException e) {
		response.sendRedirect("list.jsp");
		return;
	}
	
	WantedDao dao = WantedDao.getInstance();
	CommentDao commentDao = CommentDao.getInstance();
	
	boolean isSuccess = false;
	if(commentDao.deleteWantedNo(cNo) && dao.delete(cNo)) {
		isSuccess = true;	
	}
	
	
	if(isSuccess) {
	
%>
<script>
	alert("삭제가 완료되었습니다.");
	location.href="list.jsp?page=<%=cPage%>";
	
	
</script>

<%
	} else {
%>
<script>
	alert("에러났습니다");
	history.back(-1);
</script>

<%
	}
%>