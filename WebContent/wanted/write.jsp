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

	// if already login, go back
	if (memberDto != null) {
		response.sendRedirect("../index.jsp");
		return;
	}
	
	if(memberDto.getType() == 1) {
		
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
				<strong>회원가입</strong>
			</h3>
			<br>

			<form name="f" method="post">


				<%-- ID(need to idReg) primary key --%>
				<div class="form-group row">
					<label for="id" class="col-sm-3 col-form-label">아이디(4-25, 첫글자 영문한글,-._ )</label>
					<div class="col-sm-9">
						<input type="text" class="form-control " id="id" name="id" placeholder="아이디를 입력해주세요.">
						<div id="idMessage"></div>
					</div>
				</div>

				<%-- PWD(check confirm) --%>
				<div class="form-group row">
					<label for="password" class="col-sm-3 col-form-label">비밀번호</label>
					<div class="col-sm-9">
						<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력해주세요">
						<div id="passwordMessage"></div>
					</div>
				</div>

				<div class="form-group row">
					<label for="rePassword" class="col-sm-3 col-form-label">비밀번호 확인</label>
					<div class="col-sm-9">
						<input type="password" class="form-control" id="rePassword" name="rePassword" placeholder="비밀번호를 입력해주세요">
						<div id="rePasswordMessage"></div>
					</div>
				</div>

				<%-- normal data --%>
				<div class="form-group row">
					<label for="name" class="col-sm-3 col-form-label">이름</label>
					<div class="col-sm-9">
						<input type="text" class="form-control " id="name" name="name" placeholder="이름을 알려주세요">
						<div id="nameMessage"></div>
					</div>
				</div>

				<div class="form-group row">
					<label for="loc" class="col-sm-3 col-form-label">주소</label>
					<div class="col-sm-9">
						<input type="text" class="form-control " id="loc" name="loc" placeholder="주소를 알려주세요">
						<div id="locMessage"></div>
					</div>
				</div>
				
				<div class="form-group row">
					<label for="phone" class="col-sm-3 col-form-label">전화번호</label>
					<div class="col-sm-9">
						<input type="tel" class="form-control " id="phone" name="phone" placeholder="전화번호를 알려주세요">
						<div id="phoneMessage"></div>
					</div>
				</div>

				<div class="form-group row">
					<label for="pet" class="col-sm-3 col-form-label">현재 반려동물</label>
					<div class="col-sm-9">
						<input type="text" class="form-control " id="pet" name="pet" placeholder="반려동물을 알려주세요">
						<div id="petMessage"></div>
					</div>
				</div>

				<div class="form-group row">
					<label for="comment" class="col-sm-3 col-form-label">간단 자기소개</label>
					<div class="col-sm-9">
						<textarea class="col-sm-12" rows="4" id="comment" name="comment"></textarea>
						<%-- <input type="text" class="form-control " id="comment" name="comment" placeholder="뭐든 좋습니다"> --%>
						<div id="commentMessage"></div>
					</div>
				</div>

				<%-- type 1:sitter, 0:applicant --%>
				
				<div class="form-group row">
					<label class="col-sm-3 col-form-label">여부</label>
					<div class="col-sm-1"></div>
					
					<div class="form-check col-sm-4">
						<input class="form-check-input" type="radio" name="type" id="typeAppli" value="applicant" checked>
						<label class="form-check-label" for="typeAppli"> 일반인 </label>
					</div>
					
					<div class="form-check col-sm-4">
						<input class="form-check-input" type="radio" name="type" id="typeSitter" value="petSitter" >
						<label class="form-check-label" for="typeSitter"> 펫시터 </label>
					</div>

				</div>
				
				<input type="hidden" name="imgPath" id="imgPath" value="" />

			</form>
			
			<%-- 이미지는 따로 --%>
			<form name="fImg" id ="fImg" method="post" enctype="multipart/form-data" action="upload.jsp">
				<div class="form-group row">
					<label for="img" class="col-sm-3 col-form-label">사진(최대 10mb)</label>
					<div class="col-sm-4">
						<input type="file" class="form-control" id="img" name="img"/>
						<div id="imgMessage"></div>
					</div>
					<div class="col-sm-2">
						<button type="button" id="upload" class="btn btn-outline-success">업로드</button>
					</div>
					<div class="col-sm-3">
						<%-- 사진 올리면 반응할 부분 --%>
						<img id="imgCheck" style="width : 9em; height : 9em">
						<%-- <input type="text" id="test" value=""/> --%>
					</div>
				</div>
			</form>
			
			
			<%-- check something --%>
			<input type="hidden" name="checkId" id="checkId" value="no" />
			<%-- <input type="hidden" name="checkPwd" id="checkPwd" value="no" /> --%>
			<input type="hidden" name="checkImg" id="checkImg" value="no" />
			
			<div class="text-right">
				<button type="button" id="goBack" class="btn btn-outline-warning">뒤로가기</button>
				<button type="button" id="saveMember" class="btn btn-outline-success">회원가입</button>
			</div>



		</div>
	</div>
</div>

<!-- main end -->


<%@ include file="../inc/footer.jsp"%>

<script>
	$(function() {
		// id focus
		$("#id").focus();
		
		$("#upload").click(function(){
			var formData = new FormData($("#fImg")[0]);
			
			$.ajax({
				type : "POST",
				enctype: 'multipart/form-data',
				url : 'upload_img_ajax.jsp',
				data : formData,
				processData : false,
				contentType : false,
				dataType : 'json',
				error : function() {

				},

				success : function(json) {
					//json => {"result" : "ok or fail"}

					// success insert db data->ok
					if (json.result == "fail") {
						//$("#imgMessage").html("<span class='text-danger'>이미지에 문제 있습니다.</span>");
						$("#checkImg").val("no");
					} else {
						//$("#imgMessage").html("<span class='text-success'>해당이미지를 사용할 수 있습니다.</span>");
						//$("#imgCheck").html("<img src='"+json.result+"' />"  );
						
						$("#imgCheck").attr("src", json.path);
						//$("#test").val(json.path);
						$("#imgPath").val(json.path);
						$("#checkImg").val("yes");
					}
				}

			});
			
			
			
		});
		
		
		$("#saveMember").click(function() {
			// 자바 스크립트 유효성 검사

			if ($("#id").val().length == 0) {
				$("#id").addClass("is-invalid");
				$("#idMessage").html("<span class='text-danger'>아이디를 입력해주세요</span>");
				$("#id").focus();
				return;
			}
			
			/* 비밀번호 빈것과 중복체크까지 */
			if ($("#password").val().length == 0) {
				$("#password").addClass("is-invalid");
				$("#passwordMessage").html("<span class='text-danger'>비밀번호를 입력해주세요</span>");
				$("#password").focus();
				return;
			}
			
			if ($("#rePassword").val().length == 0) {
				$("#rePassword").addClass("is-invalid");
				$("#rePasswordMessage").html("<span class='text-danger'>비밀번호 확인을 입력해주세요</span>");
				$("#rePassword").focus();
				return;
			}

			if ($("#password").val() != $("#rePassword").val()) {
				$("#rePassword").addClass("is-invalid");
				$("#rePasswordMessage").html("<span class='text-danger'>비밀번호와 비밀번호 확인이 다릅니다.</span>");
				$("#rePassword").val('');
				$("#rePassword").focus();
				return;
			}
			
			if ($("#name").val().length == 0) {
				$("#name").addClass("is-invalid");
				$("#nameMessage").html("<span class='text-danger'>이름을 입력해주세요</span>");
				$("#name").focus();
				return;
			}
			
			if ($("#loc").val().length == 0) {
				$("#loc").addClass("is-invalid");
				$("#locMessage").html("<span class='text-danger'>지역을 입력해주세요</span>");
				$("#loc").focus();
				return;
			}
			
			if ($("#phone").val().length == 0) {
				$("#phone").addClass("is-invalid");
				$("#phoneMessage").html("<span class='text-danger'>전화번호를 입력해주세요</span>");
				$("#phone").focus();
				return;
			}
			
			if ($("#pet").val().length == 0) {
				$("#pet").addClass("is-invalid");
				$("#petMessage").html("<span class='text-danger'>반려동물을 알려주세요</span>");
				$("#pet").focus();
				return;
			}
			
			if ($("#comment").val().length == 0) {
				$("#comment").addClass("is-invalid");
				$("#commentMessage").html("<span class='text-danger'>자기소개를 해주세요</span>");
				$("#comment").focus();
				return;
			}
			
			if ($("#checkId").val() == "no") {
				return;
			}
			
			/* 
			if ($("#checkPwd").val() == "no") {
				return;
			}
			 */
			 
			if ($("#checkImg").val() == "no") {
				return;
			}

			f.action = "save.jsp";
			f.submit();
		});

		// img check listener function
		$("#img").on('change', function() {
			let ext = $(this).val().split('.').pop().toLowerCase();
			
			 if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
				 //resetFormElement($(this));
				 $("#imgMessage").html("<span class='text-danger'>이미지파일이 아닙니다.</span>");
			 } else {
				 $("#imgMessage").html("<span class='text-success'>해당이미지를 사용할 수 있습니다.</span>");
			 }
			
		});
		
		
		
		$("#id").keyup(function() {
			$("#id").removeClass("is-invalid");
			$("#idMessage").html('');

			//primary key 이기 때문에 확인
			let regId = /^[a-zA-Z가-힣][a-zA-Z0-9가-힣_\-]{2,26}$/;
			if (regId.test($("#id").val())) {
			//if($("#id").val().length > 3) {
				$.ajax({
					type : "GET",
					url : 'check_id_ajax.jsp?id='+ $("#id").val(),
					dataType : 'json',
					error : function() {

					},

					success : function(json) {
						//json => {"result" : "ok or fail"}

						// success insert db data->ok
						if (json.result == "ok") {
							$("#idMessage").html("<span class='text-success'>해당 아이디를 사용할 수 있습니다.</span>");
							$("#checkId").val("yes");
						} else {
							$("#id").addClass("is-invalid");
							$("#idMessage").html("<span class='text-danger'>아이디가 중복되었습니다.</span>");
							$("#checkId").val("no");
						}
					}

				});
			}

		});
		
		$("#password").keyup(function() {
			$("#password").removeClass("is-invalid");
			$("#passwordMessage").html('');
			
			//let regPwd = /^[.]{4,20}$/	
			//if(regPwd.test($("#password").val())) {
			if($("#password").val().length >= 3 && $("#password").val().length <= 20) {
				$("#password").removeClass("is-invalid");
				$("#passwordMessage").html('');
				$("#checkPwd").val("yes");
			} else {
				$("#password").addClass("is-invalid");
				$("#passwordMessage").html("<span class='text-danger'>비밀번호는 3-20글자 사이입니다.</span>");
				$("#password").focus();
			}
		});
		$("#rePassword").keyup(function() {
			$("#rePassword").removeClass("is-invalid");
			$("#rePasswordMessage").html('');
			
			//let regPwd = /^{3,20}&/;
			//if(regPwd.test($("#rePassword").val())) {
			if($("#rePassword").val().length >= 3 && $("#rePassword").val().length <= 20) {
			
				$("#rePassword").removeClass("is-invalid");
				$("#rePasswordMessage").html('');
			} else {
				$("#rePassword").addClass("is-invalid");
				$("#rePasswordMessage").html("<span class='text-danger'>비밀번호는 3-20글자 사이입니다.</span>");
				$("#rePassword").focus();
			}
		});
		
		$("#name").keyup(function() {
			$("#name").removeClass("is-invalid");
			$("#nameMessage").html('');
		});
		
		$("#loc").keyup(function() {
			$("#loc").removeClass("is-invalid");
			$("#locMessage").html('');
		});
		
		$("#phone").keyup(function() {
			$("#phone").removeClass("is-invalid");
			$("#phoneMessage").html('');
		});
		
		$("#pet").keyup(function() {
			$("#pet").removeClass("is-invalid");
			$("#petMessage").html('');
		});
		
		$("#comment").keyup(function() {
			$("#comment").removeClass("is-invalid");
			$("#comment").html('');
		});
		
		

		// click goBack button
		$("#goBack").click(function() {
			history.back(-1);
			return;
		});

	});
</script>
