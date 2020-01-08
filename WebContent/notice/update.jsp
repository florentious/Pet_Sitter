<%@page import="kr.co.acorn.dto.NoticeDto"%>

<%@page import="kr.co.acorn.dao.NoticeDao"%>

<%@ page pageEncoding="utf-8"%>

<%
	request.setCharacterEncoding("utf-8");

	String tempPage = request.getParameter("page");
	int no = Integer.parseInt(request.getParameter("no"));
	String regdate = request.getParameter("regdate");
	String title = request.getParameter("title");
	String id = request.getParameter("id");
	String contents = request.getParameter("contents");
	
	NoticeDao dao = NoticeDao.getInstance();
	NoticeDto dto = new NoticeDto(no, title, id, regdate, contents);
	boolean isSuccess = dao.update(dto);

	if (isSuccess) {
%>

<script>

        alert('공지사항이 수정되었습니다.');
        location.href="view.jsp?page=<%=tempPage%>&no=<%=no%>";
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