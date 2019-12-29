<%@ page pageEncoding="utf-8"%>

<%@ include file="../inc/header.jsp"%>

<%
	request.setCharacterEncoding("utf-8");

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

	
	// if not log in, go back
	if (memberDto == null || memberDto.getType() == 0) {
		response.sendRedirect("../index.jsp");
		return;
	}
	
	
	
%>

<!-- breadcrumb start -->
<nav aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="list.jsp">Home</a></li>
		<li class="breadcrumb-item active" aria-current="page">등록</li>
	</ol>
</nav>

<!-- breadcrumb end -->

<!-- main start -->

<div class="container">
	<div class="row">
		<div class="col-lg-12">

			<%-- input content --%>
			<h3>
				<strong>글 등록</strong>
			</h3>
			<br>

			<form name="f" method="post">


				<%-- don't need to wanted number --%>
				
				<%-- normal data --%>
				<div class="form-group row">
					<label for="title" class="col-sm-2 col-form-label">제목</label>
					<div class="col-sm-7">
						<input type="text" class="form-control " id="title" name="title" placeholder="제목을 입력해주세요">
						<div id="nameMessage"></div>
					</div>
					
					<div class="custom-control custom-switch col-sm-3">
						<input type="checkbox" class="custom-control-input" id="isEnd" value="checked">
						<label class="custom-control-label" for="isEnd">활성화</label>
					</div>
				</div>

				

				<div class="form-group row">
					<label for="content" class="col-sm-2 col-form-label">추가내용</label>
					<div class="col-sm-10">
						<textarea class="col-sm-12" rows="8" id="content" name="content"></textarea>
						<%-- <input type="text" class="form-control " id="comment" name="comment" placeholder="뭐든 좋습니다"> --%>
						<div id="commentMessage"></div>
					</div>
				</div>

			
			<input type="hidden" name="id" id="id" value="<%=memberDto.getId() %>" />	
				

			</form>
			
			
			
			
			<%-- check something --%>
			<input type="hidden" name="checkId" id="checkId" value="no" />
			<%-- <input type="hidden" name="checkPwd" id="checkPwd" value="no" /> --%>
			<input type="hidden" name="checkImg" id="checkImg" value="no" />
			
			<div class="text-right">
				<button type="button" id="goBack" class="btn btn-outline-warning">뒤로가기</button>
				<button type="button" id="saveWanted" class="btn btn-outline-success">등록</button>
			</div>



		</div>
	</div>
</div>

<!-- main end -->


<%@ include file="../inc/footer.jsp"%>

<script>
	$(function() {
		// title focus
		$("#title").focus();
		
		$("#saveWanted").click(function() {
			

			if ($("#title").val().length == 0) {
				$("#title").addClass("is-invalid");
				$("#titleMessage").html("<span class='text-danger'>제목을 입력해주세요</span>");
				$("#title").focus();
				return;
			}
			
			if ($("#comment").val().length == 0) {
				$("#comment").addClass("is-invalid");
				$("#commentMessage").html("<span class='text-danger'>추가 멘트를 입력해주세요</span>");
				$("#comment").focus();
				return;
			}
			
		
			f.action = "save.jsp";
			f.submit();
		});

		
		$("#title").keyup(function() {
			$("#title").removeClass("is-invalid");
			$("#titleMessage").html('');
		});
		
		$("#content").keyup(function() {
			$("#content").removeClass("is-invalid");
			$("#contentMessage").html('');
		});
		
		

		// click goBack button
		$("#goBack").click(function() {
			history.back(-1);
			return;
		});

	});
</script>
