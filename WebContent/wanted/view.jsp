
<%@page import="kr.co.acorn.util.CompareTime"%>
<%@page import="kr.co.acorn.dto.PointDto"%>
<%@page import="kr.co.acorn.dao.PointDao"%>
<%@page import="kr.co.acorn.dto.WantedDto"%>
<%@page import="kr.co.acorn.dao.WantedDao"%>
<%@page import="kr.co.acorn.dto.MemberDto"%>
<%@page import="kr.co.acorn.dao.MemberDao"%>
<%@ page pageEncoding="utf-8" %>

<%@ include file="../inc/header.jsp" %>

<%
	String tempPage = request.getParameter("page");
	String tempNo = request.getParameter("no");
	
	// 이상하게 치는 양반을 위한 방안
	if(tempPage == null || tempPage.length() == 0) {
		tempPage="1";
	}
	
	 
	if(tempNo == null || tempNo.length() == 0) {
		response.sendRedirect("list.jsp?page="+tempPage);
		return;
	}
	
	int no = 1;
	try {
		no = Integer.parseInt(tempNo);
	} catch(NumberFormatException e) {
		response.sendRedirect("list.jsp?page="+tempPage);
		return;
	}
	 
	int cPage = 1;
	try {
		cPage = Integer.parseInt(tempPage);
	} catch(NumberFormatException e) {
		response.sendRedirect("list.jsp?page="+tempPage);
		return;
	}
	
	
	
	WantedDao wantedDao = WantedDao.getInstance();
	WantedDto wantedDto = wantedDao.select(no);
	 
	if(wantedDto == null ) {
		response.sendRedirect("list.jsp?page="+cPage);
		return;
	}
	
	MemberDao dao = MemberDao.getInstance();
	MemberDto dto = dao.select(wantedDto.getId());
	
	

%>

  <!-- breadcrumb start -->
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="../index.jsp">Home</a></li>
      <li class="breadcrumb-item active" aria-current="page">Wanted</li>
    </ol>
  </nav>
  
  <!-- breadcrumb end -->
  
  <!-- main start -->

  <div class="container">
    <div class="row">
      <div class="col-lg-12">

   <%-- input content --%>
		<h3><strong>세부내용</strong></h3><br>
		
		
		 <%
		 if(memberDto.getId().equals(wantedDto.getId())) {
			 // 작성자인경우 제목이나 content를 수정가능하게 해야함
		%> 
			
			
			
		<%
		 } else if(memberDto.getType() == 1){
			 // 작성자가 아닌 펫시터인경우
			
			 
		%>
		
		
		<%
		 } else {
			 // 킹반인 인경우
		
		%>
		
		
		<%
		 }
		 %>
		  
		<form name="f" method="post" >
		  <div class="form-group row">
		    <label for="title" class="col-sm-3 col-form-label">제목</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control " id="title" name="title" readonly value="<%=wantedDto.getTitle() %>">
		      <div id="titleMessage"></div>
		    </div>
		  </div>
		  
		  
		  <div class="form-group row">
		  	<div class="col-sm-9">
		  		<div class="form-group row">
				    <label for="id" class="col-sm-4 col-form-label">작성자 아이디</label>
				    <div class="col-sm-8">
				      <input type="text" class="form-control " id="id" name="id" readonly value="<%=dto.getId() %>">
				      <div id="nameMessage"></div>
				    </div>
				  </div>
		
				  
				  <div class="form-group row">
				    <label for="name" class="col-sm-4 col-form-label">이름</label>
				    <div class="col-sm-8">
				      <input type="text" class="form-control " id="name" name="name" readonly value="<%=dto.getName()%>">
				      <div id="nameMessage"></div>
				    </div>
				  </div>
		  	</div>
		  	<div class="col-sm-3">
		  		<img style="width : 9em; height : 9em" src="<%=dto.getImgPath() %>">
		  	</div>
		  </div>
		  
		  
		  
		  
		  <div class="form-group row">
				<label for="loc" class="col-sm-3 col-form-label">주소</label>
				<div class="col-sm-9">
					<input type="text" class="form-control " id="loc" name="loc" readonly value="<%=dto.getLoc() %>">
					<div id="locMessage"></div>
				</div>
			</div>
		  
		  <div class="form-group row">
		    <label for="phone" class="col-sm-3 col-form-label">전화번호</label>
		    <div class="col-sm-9">
		      <input type="tel" class="form-control" id="phone" name="phone" readonly value="<%=dto.getPhone()%>">
		      <div id="phoneMessage"></div>
		    </div>
		  </div>
		  
		  <div class="form-group row">
				<label for="pet" class="col-sm-3 col-form-label">현재 반려동물</label>
				<div class="col-sm-9">
					<input type="text" class="form-control " id="pet" name="pet" readonly value="<%=dto.getCurPet() %>">
					<div id="petMessage"></div>
				</div>
			</div>

			<div class="form-group row">
				<label for="comment" class="col-sm-3 col-form-label">간단 자기소개</label>
				<div class="col-sm-9">
					<textarea class="col-sm-12" rows="4" id="comment" readonly name="comment" ><%=dto.getComment() %></textarea>
					<%-- <input type="text" class="form-control " id="comment" name="comment" placeholder="뭐든 좋습니다"> --%>
					<div id="commentMessage"></div>
				</div>
			</div>
			
			<div class="form-group row">
				<label for="content" class="col-sm-3 col-form-label">할말</label>
				<div class="col-sm-9">
					<textarea class="col-sm-12" rows="4" id="content" readonly name="content"><%=wantedDto.getContent() %></textarea>
					
					<div id="contentMessage"></div>
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
		<%
			// point 기록시간 확인해서 인터벌 7일기준으로 체크해서 시간이 안되있으면 안뜨는것
			PointDao pointDao = PointDao.getInstance();
			String regDate = pointDao.getTime(wantedDto.getId(), memberDto.getId());
			
			if(regDate == null || CompareTime.compareTime(CompareTime.changeTime(regDate), CompareTime.getNowTime())) {
				// compareTime true => second is later
			
		%>	
		
		<form name="fPoint" method="post">
			<div class="form-group row" id="pointDiv">
				<label for="regDate" class="col-sm-4 col-form-label">평점등록</label>
			
			
				<%
				for(int i=1; i<=5;i++) {
					
				%>
				<div class="form-check form-check-inline col-sm-1">
				  <input class="form-check-input" type="radio" name="pointReg" id="pointReg" value="<%=i%>">
				  <label class="form-check-label" for="pointReg"> <%=i %>   </label>
				</div>
			
				<%
				}
				%>
			
				<div class="col-sm-2">
					<button type="button" class="btn btn-outline-warning" id="pointRegister" name="pointRegister">등록</button>
				</div>
			
			</div>
		</form>
		 
		<%
			}
		%>
		 
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
		
		/* point등록 regeister */
		$("#pointRegister").click(function(){
			<%
			if(regDate == null) {
			%>
			
			$.ajax({
				type : "GET",
				url : 'insert_point_ajax.jsp?sitterId=<%=wantedDto.getId() %>&applicId=<%=memberDto.getId() %>&point=' + $("input:radio[name='pointReg']:checked").val(),
				dataType : 'json',
				error : function(){
					//out- json error
				},
				
				success : function(json) {
					//json => {"result" : "ok or fail"}
					
					// success insert db data->ok
					if(json.result == "ok") {
						// 등록됬다고 표기
						$("#pointDiv").html("<label for='regDate' class='col-sm-4 col-form-label'>평점등록</label> <div class='col-sm-8'> 등록이 완료되었습니다</div>");
						<% 
						// 실제 대상 멤버에 점수 반영하는 코드
						%>
					} else {
						// out - db error
						
						
					}
				}
			});
			
			
			<%
			} else {
	
			%>
			
			$.ajax({
				type : "GET",
				url : 'update_point_ajax.jsp?sitterId=<%=wantedDto.getId() %>&applicId=<%=memberDto.getId() %>&point='+ $("input:radio[name='pointReg']:checked").val(),
				dataType : 'json',
				error : function(){
					//out- json error
				},
				
				success : function(json) {
					//json => {"result" : "ok or fail"}
					
					// success insert db data->ok
					if(json.result == "ok") {
						$("#pointDiv").html("<label for='regDate' class='col-sm-4 col-form-label'>평점등록</label> <div class='col-sm-8'> 등록이 완료되었습니다</div>");
						
					} else {
						// out - db error
						
						
					}
				}
			});
			
			
			<%
			}
			%>
		});	
		
		
		
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
