<%@ page pageEncoding="utf-8" %>

<%@ include file="../inc/header.jsp" %>

<%
	int cPage = 0;
	String tempPage = request.getParameter("page");
	
	if(tempPage == null || tempPage.length() == 0) {
		cPage = 1;
	}
	try {
		cPage = Integer.parseInt(tempPage);
	} catch(NumberFormatException e) {
		cPage = 1;
	}
	
	if(memberDto != null) {
		response.sendRedirect("../index.jsp");
		return;
	}

%>

  <!-- breadcrumb start -->
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="../index.jsp">Home</a></li>
      <li class="breadcrumb-item active" aria-current="page">로그인</li>
    </ol>
  </nav>
  
  <!-- breadcrumb end -->
  
  <!-- main start -->

  <div class="container">
    <div class="row">
      <div class="col-lg-12">

   <%-- input content --%>
		<h3><strong>로그인</strong></h3><br>
		
		<form name="f" method="post" >
		
		  <div class="form-group row">
		    <label for="id" class="col-sm-3 col-form-label">아이디</label>
		    <div class="col-sm-9">
		      <input type="email" class="form-control" id="id" name="id" placeholder="아이디를 입력해주세요">
		      <div id="idMessage"></div>
		    </div>
		  </div>
		  
		  <div class="form-group row">
		    <label for="password" class="col-sm-3 col-form-label">비밀번호</label>
		    <div class="col-sm-9">
		      <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력해주세요">
		      <div id="passwordMessage"></div>
		    </div>
		  </div>
		  
		</form>
		<div class="text-right">
			<button type="button" id="goback" class="btn btn-outline-info">뒤로</button>
			<button type="button" id="loginMember" class="btn btn-outline-success">로그인</button>
		</div>
	
          
            
      </div>
    </div>
  </div>

  <!-- main end -->
  
  
<%@ include file ="../inc/footer.jsp" %>

<script>
	$(function() {
		$("#id").focus();
		$("#loginMember").click(function() {
			// 자바 스크립트 유효성 검사
			
			if($("#id").val().length==0) {
				$("#id").addClass("is-invalid");
				$("#idMessage").html("<span class='text-danger'>아이디를 입력해주세요</span>");
				$("#id").focus();
				return;
			}
			
			let regId = /^[a-zA-Z가-힣][a-zA-Z0-9가-힣_\-]{2,26}$/;
			if(regId.test($("#email").val()) == false) {
				$("#email").addClass("is-invalid");
				$("#emailMessage").html("<span class='text-danger'>적절한 아이디를 입력해주세요</span>");
				$("#email").focus();
				return;
			}
			
			
			if($("#password").val().length==0) {
				$("#password").addClass("is-invalid");
				$("#passwordMessage").html("<span class='text-danger'>비밀번호를 입력해주세요</span>");
				$("#password").focus();
				return;
			}			
			
			
			f.action ="check_login.jsp";
			f.submit();
		});
		
		$("#password").keydown(function(key) {

			if (key.keyCode == 13) {
				if($("#id").val().length==0) {
					$("#id").addClass("is-invalid");
					$("#idMessage").html("<span class='text-danger'>아이디를 입력해주세요</span>");
					$("#id").focus();
					return;
				}
				
				let regId = /^[a-zA-Z가-힣][a-zA-Z0-9가-힣_\-]{2,26}$/;
				if(regId.test($("#id").val()) == false) {
					$("#id").addClass("is-invalid");
					$("#idMessage").html("<span class='text-danger'>아이디를 입력해주세요</span>");
					$("#id").focus();
					return;
				}
				
				
				if($("#password").val().length==0) {
					$("#password").addClass("is-invalid");
					$("#passwordMessage").html("<span class='text-danger'>Input Password</span>");
					$("#password").focus();
					return;
				}			
				
				
				f.action ="check_login.jsp";
				f.submit();
			}

		});
		
		
		$("#id").keyup(function() {
			$("#id").removeClass("is-invalid");
			$("#idMessage").html('');
			
			
		});
		
		$("#password").keyup(function() {
			$("#password").removeClass("is-invalid");
			$("#passwordMessage").html('');
		});
		
		

		$("#goback").click(function() {
			history.back(-1);
			return;
		});
	});
</script>
