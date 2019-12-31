
<%@page import="kr.co.acorn.dto.WantedDto"%>
<%@page import="kr.co.acorn.dao.WantedDao"%>
<%@ page pageEncoding="utf-8" %>


<% 
	request.setCharacterEncoding("utf-8");	

	int cPage = Integer.parseInt(request.getParameter("page"));
	
	
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String tempIsEnd = request.getParameter("isEnd");
	String tempNo = request.getParameter("wantedNo");
	String id = request.getParameter("wnatedId");
	
	int no = 0;
	try {
		no = Integer.parseInt(tempNo);
	} catch(NumberFormatException e) {
		
	}
	
	
	boolean isEnd = true;
	if(tempIsEnd == null || tempIsEnd.length() == 0) {
		isEnd = false;
	}
	
	
	WantedDao dao = WantedDao.getInstance();
	WantedDto dto = new WantedDto(no,title,content,null,isEnd,id);
	
	boolean isSuccess = dao.update(dto);
	
	if(isSuccess) {
%>
<script>
	alert("업데이트 완료");
	location.href = "view.jsp?page=<%=cPage%>";
</script>


<%
	} else {
%>
<script>
	alert("에러났어요");
	history.back(-1)
	<%-- location.href = "view.jsp?page="+<%=cPage%>+"&no="+<%=no%>; --%>
</script>

<%
	}
%>