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
		response.sendRedirect("/index.jsp");
		return;
	}

%>

  <!-- breadcrumb start -->
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="list.jsp">Home</a></li>
      <li class="breadcrumb-item active" aria-current="page">Log In</li>
    </ol>
  </nav>
  
  <!-- breadcrumb end -->
  
  <!-- main start -->

  <div class="container">
    <div class="row">
      <div class="col-lg-12">

   <%-- input content --%>
		<h3><strong>Log In</strong></h3><br>
		
		<form name="f" method="post" >
		
		  <div class="form-group row">
		    <label for="email" class="col-sm-3 col-form-label">E-mail</label>
		    <div class="col-sm-9">
		      <input type="email" class="form-control" id="email" name="email">
		      <div id="emailMessage"></div>
		    </div>
		  </div>
		  
		  <div class="form-group row">
		    <label for="password" class="col-sm-3 col-form-label">Password</label>
		    <div class="col-sm-9">
		      <input type="password" class="form-control" id="password" name="password">
		      <div id="passwordMessage"></div>
		    </div>
		  </div>
		  
		</form>
		<div class="text-right">
			<button type="button" id="goback" class="btn btn-outline-info">Go back</button>
			<button type="button" id="loginMember" class="btn btn-outline-success">Sign In</button>
		</div>
	
          
            
      </div>
    </div>
  </div>

  <!-- main end -->
  
  
<%@ include file ="../inc/footer.jsp" %>

<script>
	$(function() {
		$("#email").focus();
		$("#loginMember").click(function() {
			// 자바 스크립트 유효성 검사
			
			if($("#email").val().length==0) {
				$("#email").addClass("is-invalid");
				$("#emailMessage").html("<span class='text-danger'>Input E-mail</span>");
				$("#email").focus();
				return;
			}
			
			let regEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
			if(regEmail.test($("#email").val()) == false) {
				$("#email").addClass("is-invalid");
				$("#emailMessage").html("<span class='text-danger'>Input Correct E-mail Type</span>");
				$("#email").focus();
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
		});
		
		$("#password").keydown(function(key) {

			if (key.keyCode == 13) {
				if($("#email").val().length==0) {
					$("#email").addClass("is-invalid");
					$("#emailMessage").html("<span class='text-danger'>Input E-mail</span>");
					$("#email").focus();
					return;
				}
				
				let regEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
				if(regEmail.test($("#email").val()) == false) {
					$("#email").addClass("is-invalid");
					$("#emailMessage").html("<span class='text-danger'>Input Correct E-mail Type</span>");
					$("#email").focus();
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
		
		
		$("#email").keyup(function() {
			$("#email").removeClass("is-invalid");
			$("#emailMessage").html('');
			
			
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
