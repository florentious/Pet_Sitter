<%@page import="kr.co.acorn.dao.NoticeDao"%>

<%@page import="kr.co.acorn.dto.NoticeDto"%>

<%@ page pageEncoding="utf-8"%>

<%
	request.setCharacterEncoding("utf-8");

	int no = 0;

	String title = request.getParameter("title");

	String id = request.getParameter("id");

	String contents = request.getParameter("contents");

	NoticeDao dao = NoticeDao.getInstance();

	no = dao.getMaxNextNo();

	NoticeDto dto = new NoticeDto(no, title, id, null, contents);

	boolean isSuccess = dao.insert(dto);

	if (isSuccess) {
%>

<script>
	alert('게시물이 등록되었습니다.');

	location.href = "list.jsp?page=1";
</script>

<%
	} else {
%>

<script>
	alert('DB Error');

	history.back(-1);
</script>

<%
	}
%>