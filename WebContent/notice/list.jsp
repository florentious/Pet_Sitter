<%@ page import="kr.co.acorn.dto.NoticeDto"%>

<%@ page import="java.util.ArrayList"%>

<%@ page import="kr.co.acorn.dao.NoticeDao"%>




<%@ page pageEncoding="utf-8"%>

<%@ include file="../inc/header.jsp"%>

<%
	int len = 10;

	int pageLength = 2;

	int start = 0;

	int totalRows = 0;

	int totalPage = 0;

	int startPage = 0;

	int endPage = 0;

	int pageNum = 0;

	int cPage = 0;

	String tempPage = request.getParameter("page");

	if (tempPage == null || tempPage.length() == 0) {

		cPage = 1;

	}

	try {

		cPage = Integer.parseInt(tempPage);

	} catch (NumberFormatException e) {

		cPage = 1;

	}

	//An = a1 + (n-1)*d

	NoticeDao dao = NoticeDao.getInstance();

	totalRows = dao.getTotalRows();

	totalPage = totalRows % len == 0 ? totalRows / len : totalRows / len + 1;

	if (totalPage == 0) {

		totalPage = 1;

	}

	if (cPage > totalPage) {

		response.sendRedirect("list.jsp?page=1");

		return;

	}

	start = (cPage - 1) * len;

	pageNum = totalRows + (cPage - 1) * (-len);

	ArrayList<NoticeDto> list = dao.select(start, len);


	int currentBlock = cPage % pageLength == 0 ?

			(cPage / pageLength) : (cPage / pageLength + 1);

	int totalBlock = totalPage % pageLength == 0 ?

			(totalPage / pageLength) : (totalPage / pageLength + 1);

	startPage = 1 + (currentBlock - 1) * pageLength;

	endPage = pageLength + (currentBlock - 1) * pageLength;

	if (currentBlock == totalBlock) {

		endPage = totalPage;

	}
%>

<!-- breadcrumb start-->

<nav aria-label="breadcrumb">

	<ol class="breadcrumb">

		<li class="breadcrumb-item"><a href="/index.jsp">Home</a></li>

		<li class="breadcrumb-item active" aria-current="page">Notice</li>

	</ol>

</nav>

<!-- breadcrumb end-->



<!-- main start-->

<div class="container">

	<div class="row">

		<div class="col-lg-12">



			<h3>
				공지사항(<%=totalRows%>)
			</h3>

			<div class="table-responsive-lg">

				<table class="table table-hover">

					<colgroup>

						<col width="15%" />

						<col width="55%" />

						<col width="15%" />

						<col width="15%" />

					</colgroup>

					<thead>

						<tr>

							<th scope="col">글번호</th>

							<th scope="col">제목</th>

							<th scope="col">작성자</th>

							<th scope="col">작성일</th>

						</tr>

					</thead>

					<tbody>

						<%
							if (list.size() != 0) {
						%>

						<%
							for (NoticeDto dto : list) {
						%>

						<tr>

							<td><%=pageNum--%></td>

							<td><a href="view.jsp?page=<%=cPage%>&no=<%=dto.getNo()%>"><%=dto.getTitle()%></a></td>

							<td><%=dto.getId()%></td>

							<td><%=dto.getRegDate() %></td>

						</tr>

						<%
							}
						%>

						<%
							} else {
						%>

						<tr>

							<td colspan="3">데이터가 존재하지 않습니다.</td>

						</tr>

						<%
							}
						%>



					</tbody>

				</table>

			</div>

			<nav aria-label="Page navigation example">

				<ul class="pagination justify-content-center">

					<%
						if (currentBlock == 1) {
					%>

					<li class="page-item disabled"><a class="page-link" href="#"
						tabindex="-1" aria-disabled="true">Previous</a></li>

					<%
						} else {
					%>

					<li class="page-item"><a class="page-link"
						href="list.jsp?page=<%=startPage - 1%>">Previous</a></li>

					<%
						}
					%>

					<%
						for (int i = startPage; i <= endPage; i++) {
					%>

					<li class="page-item <%if (cPage == i) {%>active<%}%>"><a
						class="page-link" href="list.jsp?page=<%=i%>"><%=i%></a></li>

					<%
						}
					%>

					<%
						if (currentBlock == totalBlock) {
					%>

					<li class="page-item disabled"><a class="page-link" href="#"
						tabindex="-1" aria-disabled="true">Next</a></li>

					<%
						} else {
					%>

					<li class="page-item"><a class="page-link"
						href="list.jsp?page=<%=endPage + 1%>">Next</a></li>

					<%
						}
					%>

				</ul>

			</nav>



			<div class="text-right">

				<a href="write.jsp?page=<%=cPage%>"
					class="btn btn-outline-secondary">공지등록</a>

			</div>



		</div>

	</div>

</div>

<!-- main end-->

<%@ include file="../inc/footer.jsp"%>