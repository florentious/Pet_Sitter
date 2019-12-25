
<%@page import="kr.co.acorn.dto.MemberDto"%>
<%@page import="kr.co.acorn.dao.MemberDao"%>
<%@ page pageEncoding="utf-8" %>

<%@ include file="../inc/header.jsp" %>

<%
	String tempPage = request.getParameter("page");
	String tempEmail = request.getParameter("email");
	
	// 이상하게 치는 양반을 위한 방안
	if(tempPage == null || tempPage.length() == 0) {
		tempPage="1";
	}
	
	if(tempEmail == null || tempEmail.length() == 0) {
		response.sendRedirect("list.jsp?page="+tempPage);
		return;
	}
	
	int cPage = 0;
	
	
	
	MemberDao dao = MemberDao.getInstance();
	MemberDto dto = dao.select(tempEmail);
	
	if(dto == null) {
		response.sendRedirect("list.jsp?page="+cPage);
		return;
	}
	
	

%>

  <!-- breadcrumb start -->
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="list.jsp">Home</a></li>
      <li class="breadcrumb-item active" aria-current="page">Member</li>
    </ol>
  </nav>
  
  <!-- breadcrumb end -->
  
  <!-- main start -->

  <div class="container">
    <div class="row">
      <div class="col-lg-12">

   <%-- input content --%>
		<h3><strong>Member Details</strong></h3><br>
		
		<form name="f" method="post" >
		
		 <%--  <div class="form-group row">
		    <label for="no" class="col-sm-3 col-form-label">Employer Number</label>
		    <div class="col-sm-9">
		      <input type="number" class="form-control" id="no" name="no">
		    </div>
		  </div> --%>
		  
		  <div class="form-group row">
		    <label for="name" class="col-sm-3 col-form-label">Name</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control " id="name" name="name" value="<%=dto.getName()%>">
		      <div id="nameMessage"></div>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="email" class="col-sm-3 col-form-label">E-mail</label>
		    <div class="col-sm-9">
		      <input type="email" class="form-control" id="email" name="email" value="<%=dto.getEmail()%>">
		      <div id="emailMessage"></div>
		    </div>
		  </div>
		  
		  <div class="form-group row">
		    <label for="beforePassword" class="col-sm-3 col-form-label">Before Password</label>
		    <div class="col-sm-9">
		      <input type="password" class="form-control" id="beforePassword" name="beforePassword">
		      <div id="beforePasswordMessage"></div>
		    </div>
		  </div>
		  
		  <div class="form-group row">
		    <label for="password" class="col-sm-3 col-form-label">Password</label>
		    <div class="col-sm-9">
		      <input type="password" class="form-control" id="password" name="password">
		      <div id="passwordMessage"></div>
		    </div>
		  </div>
		  
		  <div class="form-group row">
		    <label for="rePassword" class="col-sm-3 col-form-label">Password Confirm</label>
		    <div class="col-sm-9">
		      <input type="password" class="form-control" id="rePassword" name="rePassword">
		      <div id="rePasswordMessage"></div>
		    </div>
		  </div>
		  
		  <div class="form-group row">
		    <label for="phone" class="col-sm-3 col-form-label">Phone</label>
		    <div class="col-sm-9">
		      <input type="tel" class="form-control" id="phone" name="phone" value="<%=dto.getPhone()%>">
		      <div id="phoneMessage"></div>
		    </div>
		  </div>
		  
		  <input type="hidden" name="checkEmail" id="checkEmail" value="yes"/>
		  <input type="hidden" name="checkPwd" id="checkPwd" value="no"/>
		  
		</form>
		<div class="text-right">			
			<button type="button" id="prevPage" class="btn btn-outline-info">Go Back</button>
			<button type="button" id="updateMember" class="btn btn-outline-success">Update</button>
			<button type="button" id="deleteMember" class="btn btn-outline-danger">Delete</button>
			
		</div>
	
          
            
      </div>
    </div>
  </div>

  <!-- main end -->
  
  
<%@ include file ="../inc/footer.jsp" %>

<script>
	$(function() {
		$("#beforePassword").focus();
		
		/* update start */
		$("#updateMember").click(function() {
			// 자바 스크립트 유효성 검사
			if($("#name").val().length==0) {
				$("#name").addClass("is-invalid");
				$("#nameMessage").html("<span class='text-danger'>Input Name</span>");
				$("#name").focus();
				return;
			}
			
			let regEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
			
			if($("#email").val().length==0) {
				$("#email").addClass("is-invalid");
				$("#emailMessage").html("<span class='text-danger'>Input E-mail</span>");
				$("#email").focus();
				return;
			}
			
			if(regEmail.test($("#email").val()) == false) {
				$("#email").addClass("is-invalid");
				$("#emailMessage").html("<span class='text-danger'>Input Correct E-mail Type</span>");
				$("#email").focus();
				return;
			}
			
			if($("#beforePassword").val().length==0) {
				$("#beforePassword").addClass("is-invalid");
				$("#beforePasswordMessage").html("<span class='text-danger'>Input Current Password</span>");
				$("#beforePassword").focus();
				return;
			}
				
				
			if($("#password").val().length!=0 ||  $("#rePassword").val().length!=0) {
				
				if($("#password").val().length==0) {
					$("#password").addClass("is-invalid");
					$("#passwordMessage").html("<span class='text-danger'>Input Password</span>");
					$("#password").focus();
					return;
				}			
				if($("#rePassword").val().length==0) {
					$("#rePassword").addClass("is-invalid");
					$("#rePasswordMessage").html("<span class='text-danger'>Input Password Confirm</span>");
					$("#rePassword").focus();
					return;
				}
				
				if($("#password").val() != $("#rePassword").val()) {
					$("#rePassword").addClass("is-invalid");
					$("#rePasswordMessage").html("<span class='text-danger'>Input Same Password</span>");
					$("#rePassword").val('');
					$("#rePassword").focus();
					return;
				}
			}
				
			
			if($("#phone").val().length==0) {
				$("#phone").addClass("is-invalid");
				$("#phoneMessage").html("<span class='text-danger'>Input Phone</span>");
				$("#phone").focus();
				return;
			}
			
			f.action ="update.jsp?page=<%=cPage%>&tempEmail=<%=tempEmail%>";
			
			if($("#checkEmail").val() == "no") {
				return;
			}
			
			if($("#checkPwd").val() == "no") {
				return;
			}
			
			f.submit();
		});
		
		/* update end */
		
		/* delete start */
		$("#deleteMember").click(function() {
			
			
			if($("#email").val().length==0) {
				$("#email").addClass("is-invalid");
				$("#emailMessage").html("<span class='text-danger'>Input E-mail</span>");
				$("#email").focus();
				return;
			}
			
			if($("#beforePassword").val().length==0) {
				$("#beforePassword").addClass("is-invalid");
				$("#before{asswordMessage").html("<span class='text-danger'>Input Before Password</span>");
				$("#beforePassword").focus();
				return;
			}
			
			f.action ="delete.jsp?page=<%=cPage%>&email=<%=tempEmail%>";
			
			if($("#checkEmail").val() == "no") {
				return;
			}
			
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
		$("#email").keyup(function() {
			$("#email").removeClass("is-invalid");
			$("#emailMessage").html('');
			
			if("<%=tempEmail%>" != $("#email").val()) {
				//primary key 이기 때문에 확인
				let regEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
				
				if(regEmail.test($("#email").val())) {
					$.ajax({
						type : "GET",
						url : 'check_email_ajax.jsp?email='+ $("#email").val(),
						dataType : 'json',
						error : function(){
							
						},
						
						success : function(json) {
							//json => {"result" : "ok or fail"}
							
							// success insert db data->ok
							if(json.result == "ok") {
								$("#emailMessage").html("<span class='text-success'>Can use E-mail</span>");
								$("#checkEmail").val("yes");
							} else {
								$("#email").addClass("is-invalid");
								$("#emailMessage").html("<span class='text-danger'>Duplicate E-mail already, Re-Input Another one</span>");
								$("#checkEmail").val("no");
							}
						}
					});
				}	
			} else {
				$("#checkEmail").val("yes");
			}
			
			
		});
		
		$("#beforePassword").keyup(function() {
			$("#beforePassword").removeClass("is-invalid");
			$("#beforePasswordMessage").html('');
		
			$.ajax({
				type : "POST",
				url : 'check_pwd_ajax.jsp',
				data : {"email": "<%=tempEmail%>", "password": $("#beforePassword").val()},
				dataType : 'json',
				error : function(){
				},
				
				success : function(json) {
					//json => {"result" : "ok or fail"}
					
					// same pwd => return 'ok'
					if(json.result == "ok") {
						$("#beforePasswordMessage").html("<span class='text-success'> Can Change</span>");
						$("#checkPwd").val("yes");
					} else {
						$("#beforePassword").addClass("is-invalid");
						$("#beforePasswordMessage").html("<span class='text-danger'>Incorrect Password</span>");
						$("#checkPwd").val("no");
					}
				}
			
				
				
			});
			
			
		});
		
		$("#password").keyup(function() {
			$("#password").removeClass("is-invalid");
			$("#passwordMessage").html('');
		});
		
		$("#rePassword").keyup(function() {
			$("#rePassword").removeClass("is-invalid");
			$("#rePasswordMessage").html('');
			/* 
			// 즉시 비밀번호 확인하는 코드
			if($("#password").val() != $(rePassword).val()) {
				$("#rePassword").addClass("is-invalid");
				$("#rePasswordMessage").html("<span class='text-danger'>Input Same Password and Password Confirm</span>");
			} else {
				$("#rePassword").removeClass("is-invalid");
				$("#rePasswordMessage").html('');
			}
			 */
		});
		
		$("#phone").keyup(function() {
			$("#phone").removeClass("is-invalid");
			$("#phoneMessage").html('');
		});
		
		$("#prevPage").click(function() {
			history.back(-1);
		});
		
		
	});
</script>
