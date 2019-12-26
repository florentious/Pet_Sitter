
<%@page import="kr.co.acorn.dto.MemberDto"%>
<%@page import="kr.co.acorn.dao.MemberDao"%>
<%@ page pageEncoding="utf-8" %>

<%@ include file="../inc/header.jsp" %>

<%
	String tempPage = request.getParameter("page");
	//String tempId = request.getParameter("id");
	
	// 이상하게 치는 양반을 위한 방안
	if(tempPage == null || tempPage.length() == 0) {
		tempPage="1";
	}
	/* 
	if(tempId == null || tempId.length() == 0) {
		response.sendRedirect("../index.jsp?page="+tempPage);
		return;
	}
	 */
	int cPage = 0;
	
	
	
	MemberDao dao = MemberDao.getInstance();
	MemberDto dto = dao.select(memberDto.getId());
	
	if(dto == null) {
		response.sendRedirect("../index.jsp?page="+cPage);
		return;
	}
	
	

%>

  <!-- breadcrumb start -->
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="../index.jsp">Home</a></li>
      <li class="breadcrumb-item active" aria-current="page">Member</li>
    </ol>
  </nav>
  
  <!-- breadcrumb end -->
  
  <!-- main start -->

  <div class="container">
    <div class="row">
      <div class="col-lg-12">

   <%-- input content --%>
		<h3><strong>세부사항</strong></h3><br>
		
		<form name="f" method="post" >
		
		 <%--  <div class="form-group row">
		    <label for="no" class="col-sm-3 col-form-label">Employer Number</label>
		    <div class="col-sm-9">
		      <input type="number" class="form-control" id="no" name="no">
		    </div>
		  </div> --%>
		  
		  <div class="form-group row">
		    <label for="id" class="col-sm-3 col-form-label">아이디</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control " id="id" name="id" readonly value="<%=dto.getId() %>">
		      <div id="nameMessage"></div>
		    </div>
		  </div>

		  <div class="form-group row">
		    <label for="beforePassword" class="col-sm-3 col-form-label">현재 비밀번호(입력주셔야 수정/탈퇴 가능)</label>
		    <div class="col-sm-9">
		      <input type="password" class="form-control" id="beforePassword" name="beforePassword">
		      <div id="beforePasswordMessage"></div>
		    </div>
		  </div>
		  
		  <div class="form-group row">
		    <label for="password" class="col-sm-3 col-form-label">새로운 비밀번호</label>
		    <div class="col-sm-9">
		      <input type="password" class="form-control" id="password" name="password">
		      <div id="passwordMessage"></div>
		    </div>
		  </div>
		  
		  <div class="form-group row">
		    <label for="rePassword" class="col-sm-3 col-form-label">새로운 비밀번호 확인</label>
		    <div class="col-sm-9">
		      <input type="password" class="form-control" id="rePassword" name="rePassword">
		      <div id="rePasswordMessage"></div>
		    </div>
		  </div>
		  
		  		  
		  <div class="form-group row">
		    <label for="name" class="col-sm-3 col-form-label">이름</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control " id="name" name="name" value="<%=dto.getName()%>">
		      <div id="nameMessage"></div>
		    </div>
		  </div>
		  
		  <div class="form-group row">
				<label for="loc" class="col-sm-3 col-form-label">주소</label>
				<div class="col-sm-9">
					<input type="text" class="form-control " id="loc" name="loc" value="<%=dto.getLoc() %>">
					<div id="locMessage"></div>
				</div>
			</div>
		  
		  <div class="form-group row">
		    <label for="phone" class="col-sm-3 col-form-label">전화번호</label>
		    <div class="col-sm-9">
		      <input type="tel" class="form-control" id="phone" name="phone" value="<%=dto.getPhone()%>">
		      <div id="phoneMessage"></div>
		    </div>
		  </div>
		  
		  <div class="form-group row">
				<label for="pet" class="col-sm-3 col-form-label">현재 반려동물</label>
				<div class="col-sm-9">
					<input type="text" class="form-control " id="pet" name="pet" value="<%=dto.getCurPet() %>">
					<div id="petMessage"></div>
				</div>
			</div>

			<div class="form-group row">
				<label for="comment" class="col-sm-3 col-form-label">간단 자기소개</label>
				<div class="col-sm-9">
					<textarea class="col-sm-12" rows="4" id="comment" name="comment"><%=dto.getComment() %></textarea>
					<%-- <input type="text" class="form-control " id="comment" name="comment" placeholder="뭐든 좋습니다"> --%>
					<div id="commentMessage"></div>
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-3 col-form-label">여부</label>
				<div class="col-sm-1"></div>
				
				<div class="form-check col-sm-4">
					<input class="form-check-input" type="radio" name="type" id="typeAppli" value="applicant" <% if(dto.getType()==0){ %> checked <%} %>>
					<label class="form-check-label" for="typeAppli"> 일반인 </label>
				</div>
				
				<div class="form-check col-sm-4">
					<input class="form-check-input" type="radio" name="type" id="typeSitter" value="petSitter" <% if(dto.getType()==1){ %> checked <%} %> >
					<label class="form-check-label" for="typeSitter"> 펫시터 </label>
				</div>

			</div>
			
			<div class="form-group row">
				<label for="regDate" class="col-sm-3 col-form-label">등록 일자</label>
				<div class="col-sm-9">
					<input type="text" class="form-control " id="regDate" name="regDate" readonly value="<%=dto.getRegDate() %>">
					<div id="regDateMessage"></div>
				</div>
			</div>
			
			<div class="form-group row">
				<label for="point" class="col-sm-3 col-form-label">평점</label>
				<div class="col-sm-9">
				<%
					// point 체크 메서드
					if(dto.getPointCount() < 5) {
						
				%>
					<input type="text" class="form-control " id="point" name="point" readonly value="정보가 너무 적습니다.">					
				<%} else {
					String pointForm = String.format("%.1f", (double)dto.getPoint() / (double)dto.getPointCount() );
				%>
					<input type="text" class="form-control " id="point" name="point" readonly value="<%=pointForm %>">
				<% } %>
				
				</div>
			</div>
		  		  
		</form>
		 
		  
		  
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
					<img id="imgCheck" style="width : 9em; height : 9em" src="<%=dto.getImgPath() %>">
					<%-- <input type="text" id="test" value=""/> --%>
				</div>
			</div>
		</form>
		
		<input type="hidden" name="checkPwd" id="checkPwd" value="no"/>
		  
		<div class="text-right">			
			<button type="button" id="prevPage" class="btn btn-outline-info">뒤로</button>
			<button type="button" id="updateMember" class="btn btn-outline-success">수정</button>
			<button type="button" id="deleteMember" class="btn btn-outline-danger">삭제</button>
			
		</div>
	
          
            
      </div>
    </div>
  </div>

  <!-- main end -->
  
  
<%@ include file ="../inc/footer.jsp" %>

<script>
	$(function() {
		$("#beforePassword").focus();
		
		
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
		
		/* update start */
		$("#updateMember").click(function() {
			// 자바 스크립트 유효성 검사

			if ($("#id").val().length == 0) {
				$("#id").addClass("is-invalid");
				$("#idMessage").html("<span class='text-danger'>아이디를 입력해주세요</span>");
				$("#id").focus();
				return;
			}
			
			if($("#beforePassword").val().length==0) {
				$("#beforePassword").addClass("is-invalid");
				$("#beforePasswordMessage").html("<span class='text-danger'>현재 비밀번호를 입력해주세요</span>");
				$("#beforePassword").focus();
				return;
			}
				
			if($("#password").val().length!=0 ||  $("#rePassword").val().length!=0) {
				
				if($("#password").val().length==0) {
					$("#password").addClass("is-invalid");
					$("#passwordMessage").html("<span class='text-danger'>비밀번호를 입력해주세요</span>");
					$("#password").focus();
					return;
				}			
				if($("#rePassword").val().length==0) {
					$("#rePassword").addClass("is-invalid");
					$("#rePasswordMessage").html("<span class='text-danger'>비밀번호 확인을 입력해주세요</span>");
					$("#rePassword").focus();
					return;
				}
				
				if($("#password").val() != $("#rePassword").val()) {
					$("#rePassword").addClass("is-invalid");
					$("#rePasswordMessage").html("<span class='text-danger'>비밀번호와 비밀번호 확인이 다릅니다</span>");
					$("#rePassword").val('');
					$("#rePassword").focus();
					return;
				}
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
			
			
			f.action ="update.jsp?page=<%=cPage%>";
			
			if($("#checkPwd").val() == "no") {
				return;
			}
			
			f.submit();
		});
		
		/* update end */
		
		/* delete start */
		$("#deleteMember").click(function() {
			
			
			if ($("#id").val().length == 0) {
				$("#id").addClass("is-invalid");
				$("#idMessage").html("<span class='text-danger'>아이디를 입력해주세요</span>");
				$("#id").focus();
				return;
			}
			
			if($("#beforePassword").val().length==0) {
				$("#beforePassword").addClass("is-invalid");
				$("#beforePasswordMessage").html("<span class='text-danger'>현재 비밀번호를 입력해주세요</span>");
				$("#beforePassword").focus();
				return;
			}
				
			if($("#password").val().length!=0 ||  $("#rePassword").val().length!=0) {
				
				if($("#password").val().length==0) {
					$("#password").addClass("is-invalid");
					$("#passwordMessage").html("<span class='text-danger'>비밀번호를 입력해주세요</span>");
					$("#password").focus();
					return;
				}			
				if($("#rePassword").val().length==0) {
					$("#rePassword").addClass("is-invalid");
					$("#rePasswordMessage").html("<span class='text-danger'>비밀번호 확인을 입력해주세요</span>");
					$("#rePassword").focus();
					return;
				}
				
				if($("#password").val() != $("#rePassword").val()) {
					$("#rePassword").addClass("is-invalid");
					$("#rePasswordMessage").html("<span class='text-danger'>비밀번호와 비밀번호 확인이 다릅니다.</span>");
					$("#rePassword").val('');
					$("#rePassword").focus();
					return;
				}
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
			
			f.action ="delete.jsp?page=<%=cPage%>";
			
			
			if($("#checkPwd").val() == "no") {
				return;
			}
			
			f.submit();
			
		});
		
		/* delete end */
		
		
		
		
		$("#name").keyup(function() {
			$("#name").removeClass("is-invalid");
			$("#nameMessage").html('');
		});
				
		$("#beforePassword").keyup(function() {
			$("#beforePassword").removeClass("is-invalid");
			$("#beforePasswordMessage").html('');
		
			$.ajax({
				type : "POST",
				url : 'check_pwd_ajax.jsp',
				data : {"id": "<%=dto.getId() %>", "password": $("#beforePassword").val()},
				dataType : 'json',
				error : function(){
				},
				
				success : function(json) {
					//json => {"result" : "ok or fail"}
					
					// same pwd => return 'ok'
					if(json.result == "ok") {
						$("#beforePasswordMessage").html("<span class='text-success'>변경 가능합니다.</span>");
						$("#checkPwd").val("yes");
					} else {
						$("#beforePassword").addClass("is-invalid");
						$("#beforePasswordMessage").html("<span class='text-danger'>비밀번호가 틀렸어요</span>");
						$("#checkPwd").val("no");
					}
				}
			
				
				
			});
			
			
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
		
		$("#prevPage").click(function() {
			history.back(-1);
		});
		
		
	});
</script>
