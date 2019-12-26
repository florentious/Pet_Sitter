<%@page import="kr.co.acorn.dto.NoticeDto"%>

<%@page import="kr.co.acorn.dao.NoticeDao"%>

<%@ page pageEncoding="utf-8"%>

<%
	request.setCharacterEncoding("utf-8");

	int n_no = Integer.parseInt(request.getParameter("no"));

	String tempPage = request.getParameter("page");

	NoticeDao dao = NoticeDao.getInstance();

	boolean isSuccess = dao.delete(n_no);

	if (isSuccess) {
%>

<script>

        alert('공지사항이 삭제되었습니다.');

        location.href="list.jsp?page=<%=tempPage%>";
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