<%@ page pageEncoding="utf-8"%>

<%@ include file="../inc/header.jsp"%>

<!-- breadcrumb start -->

<nav aria-label="breadcrumb">

	<ol class="breadcrumb">

		<li class="breadcrumb-item"><a href="/index.jsp">Home</a></li>

		<li class="breadcrumb-item active" aria-current="page">Library</li>

	</ol>

</nav>

<!-- breadcrumb end -->

<%
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
%>

<!-- main start -->

<div class="container">

	<div class="row">

		<div class="col-lg-12">

			<div class="alert alert-secondary" role="alert">공지 작성</div>


			<form name="f" method="post" action="save.jsp">

				<div class="form-group row">

					<label for="id" class="col-sm-1 col-form-label">작성자</label>

					<div class="col-sm-10">

						<input type="text" readonly class="form-control-plaintext" id="id"
							name="id" value="관리자">

					</div>

				</div>

				<div class="form-group row">

					<label for="title" class="col-sm-1 col-form-label">제목</label>

					<div class="col-sm-10">

						<input type="text" name="title" class="form-control" id="title">

					</div>

				</div>

				<div class="form-group">

					<label for="contents">내용</label>

					<textarea class="form-control" id="contents" name="contents"
						rows="10"></textarea>

				</div>

			</form>

			<div class="text-right">

				<button type="button" id="saveNotice"
					class="btn btn-outline-success">저장</button>

				<a href="list.jsp?page=<%=cPage%>" type="button"
					class="btn btn-outline-secondary">목록</a>

			</div>


		</div>

	</div>

</div>

<!-- main end -->

<%@ include file="../inc/footer.jsp"%>


<script>
	$(function() {

		$("#title").focus();

		$("#saveNotice").click(function() {

			//자바스크립트 유효성 검사

			if ($("#title").val().length == 0) {

				alert("제목을 입력하세요.");

				$("#title").focus();

				return;

			}

			if ($("#contents").val().length == 0) {

				alert("내용을 입력하세요.");

				$("#contents").focus();

				return;

			}

			f.submit();

		});

	});
</script>