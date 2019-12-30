
<%@page import="kr.co.acorn.dto.WantedDto"%>
<%@page import="kr.co.acorn.dao.WantedDao"%>
<%@ page pageEncoding="utf-8" %>

<% 
	request.setCharacterEncoding("utf-8"); // 한글이 깨지니까

	WantedDao dao = WantedDao.getInstance();
	
	int no = dao.getMaxNo();
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	/* 
	// togle check box는 어떻게 나오는가 확인해봐야함
	String temp = request.getParameter("isEnd");
	boolean isEnd = false;
	if(temp.equals("checked")) {
		isEnd = true;
	}
	 */
	 
	String temp = request.getParameter("isEnd");
	
	boolean isEnd = false;
	 
	if(temp != null) {
		isEnd = true;
	}
	
	String id = request.getParameter("id");
	
	WantedDto dto = new WantedDto(no,title,content,null,isEnd,id);
	
	
	boolean isSuccess = dao.insert(dto);
	
	if(isSuccess) {
	
%>
		
<script>
	alert("글 등록이 완료 되었습니다.");
	location.href="list.jsp";
</script>
<% } else { %>
<script>
	alert("등록에 실패하셨습니다.");	
	history.back(-1);
</script>
<% }%>
	