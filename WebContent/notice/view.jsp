<%@page import="kr.co.acorn.dto.NoticeDto"%>

<%@page import="kr.co.acorn.dao.NoticeDao"%>

<%@ page pageEncoding="utf-8"%>

<%@ include file="../inc/header.jsp"%>

<%
	request.setCharacterEncoding("utf-8");

	String tempPage = request.getParameter("page");

	String tempNo = request.getParameter("no");

	if (tempPage == null || tempPage.length() == 0) {

		tempPage = "1";

	}

	/*
	
	if(tempNo == null || tempNo.length()==0){
	
	    response.sendRedirect("list.jsp?page="+tempPage);
	
	    return;
	
	}
	
	 */

	int cPage = 0;

	int no = 0;

	try {

		cPage = Integer.parseInt(tempPage);

	} catch (NumberFormatException e) {

		cPage = 1;

	}

	try {

		no = Integer.parseInt(tempNo);

	} catch (NumberFormatException e) {

		response.sendRedirect("list.jsp?page=" + cPage);

		return;

	}

	NoticeDao dao = NoticeDao.getInstance();

	NoticeDto dto = dao.select(no);

	/*
	
	if(dto == null){
	
	    response.sendRedirect("list.jsp?page="+cPage);
	
	    return;
	
	}
	
	*/
%>

<!-- breadcrumb start-->

<nav aria-label="breadcrumb">

	<ol class="breadcrumb">

		<li class="breadcrumb-item"><a href="<%=contextPath %>/index.jsp">Home</a></li>

		<li class="breadcrumb-item active" aria-current="page">Notice</li>

	</ol>

</nav>

<!-- breadcrumb end-->


<!-- main start-->

<div class="container">

	<div class="row">

		<div class="col-lg-12">

			<h3>글내용 상세보기</h3>

			<form name="f" method="post">
				<div class="form-group row">
					<label for="title" class="col-sm-2 col-form-label">제목</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="title" name="title"
							value="<%=dto.getTitle()%>">
					</div>
				</div>
				<div class="form-group row">
					<label for="id" class="col-sm-2 col-form-label">내용</label>
					<div class="col-sm-10">
						<%-- <input type="text" class="form-control" id="id" name="id" value="<%=dto.getContents() %>"> --%>
						<%-- textarea name 태그 안넣어줌 --%>
						<textarea name="contents" id="contents" rows="4" class="col-sm-12"><%=dto.getContents()%></textarea>
					</div>
				</div>
				<%-- 수정부분  id 값 hidden 으로 넣어줌 --%>
				<input type="hidden" name="id" value="<%=dto.getId() %>"/>
				<input type="hidden" name="page" value="<%=cPage%>" />
				<input type="hidden" name="no" value="<%=no%>">



			</form>



			<div class="text-right">

				<button type="button" id="prevPage"
					class="btn btn-outline-secondary">이전</button>

				<button type="button" id="updateNotice"
					class="btn btn-outline-success">수정</button>

				<button type="button" id="deleteNotice"
					class="btn btn-outline-danger">삭제</button>

			</div>

		</div>

	</div>

</div>

<!-- main end-->

<%@ include file="../inc/footer.jsp"%>

<script>
	$(function() {

		$("#title").focus();

		$("#prevPage").click(function() {

			history.back(-1);

		});

		$("#updateNotice").click(function() {

			/*

			//자바스크립트 유효성 검사

			if($("#name").val().length==0){

			        alert("제목을 입력하세요.");

			        $("#name").focus();

			        return;

			}

			if($("#name").val().length==0){

			        alert("내용을 입력하세요.");

			        $("#name").focus();

			        return;

			}

			 */

			f.action = "update.jsp";

			f.submit();

		});

		$("#deleteNotice").click(function() {

			f.action = "delete.jsp";

			f.submit();

		});

	});
</script>