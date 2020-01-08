
<%@page import="kr.co.acorn.dto.CommentDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.acorn.dao.CommentDao"%>
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
	
	// if don't login
	if (memberDto == null ) {
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
	
	String pointValue = null;
	if(dto.getPointCount() < 5) {
		pointValue = "정보가 적습니다.";
	} else {
		pointValue = String.format("%.1f", (double)dto.getPoint() / (double)dto.getPointCount() );
	}
	

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
		
		
	
		<form name="f" method="post" >
		  <div class="form-group row">
		    <label for="title" class="col-sm-3 col-form-label">제목</label>
		    <div class="col-sm-7">
		      <input type="text" class="form-control " id="title" name="title" <%if(!memberDto.getId().equals(wantedDto.getId())){ %>readonly <%} %> value="<%=wantedDto.getTitle() %>">
		      <div id="titleMessage"></div>
		    </div>
		    
		    <div class="custom-control custom-switch col-sm-2">
				<input type="checkbox" class="custom-control-input" id="isEnd" name="isEnd" value="checked" <%if(wantedDto.getIsEnd()==true) { %> checked <% } %> <%if(!memberDto.getId().equals(wantedDto.getId())){ %>disabled <%} %> >
				<label class="custom-control-label" for="isEnd">활성화</label>
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
					<textarea class="form-control col-sm-12" rows="4" id="comment" readonly name="comment" ><%=dto.getComment() %></textarea>
					<%-- <input type="text" class="form-control " id="comment" name="comment" placeholder="뭐든 좋습니다"> --%>
					<div id="commentMessage"></div>
				</div>
			</div>
			
			<div class="form-group row">
				<label for="content" class="col-sm-3 col-form-label">할말</label>
				<div class="col-sm-9">
					<textarea class="form-control col-sm-12" rows="4" id="content" <%if(!memberDto.getId().equals(wantedDto.getId())){ %>readonly <%} %> name="content"><%=wantedDto.getContent() %></textarea>
					
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
				<label for="point" class="col-sm-3 col-form-label">게시자 평점</label>
				<div class="col-sm-9">
				
					<input type="text" class="form-control " id="point" name="point" readonly value="<%=pointValue %>">
				
				</div>
			</div>
			
			<%-- form 에 글 번호를 넣기 위한 것 --%>
			<input type="hidden" name="wantedNo" id="wantedNo" value="<%=wantedDto.getNo() %>"/>
			<input type="hidden" name="wantedNo" id="wantedId" value="<%=wantedDto.getId() %>"/>
			  
		</form>
		<%
			String regDate = null;
		
			if(memberDto.getType() == 0) {
				//킹반인만 평가 가능하게 - 펫시터끼리는 평가가 불가능함
			
			// point 기록시간 확인해서 인터벌 7일기준으로 체크해서 시간이 안되있으면 안뜨는것
			PointDao pointDao = PointDao.getInstance();
			regDate = pointDao.getTime(wantedDto.getId(), memberDto.getId());
			
			
			
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
			}
		%>
		 
		
		  
		<div class="text-right">			
			<button type="button" id="prevPage" class="btn btn-outline-info">뒤로</button>
			
			<%
			if(memberDto.getId().equals(wantedDto.getId())) {
			%>
			<button type="button" id="updateWanted" class="btn btn-outline-success">수정</button>
			<button type="button" id="deleteWanted" class="btn btn-outline-danger">삭제</button>
			
			<%
			}
			%>
		</div>
		
		
		<h5><strong>댓글</strong></h5><br>
		
		<%-- 댓글 등록 --%>
		<form name="fComment" method="post">
			
	   		<textarea class="form-control" name="commentTextArea" id="commentTextArea" rows="3"></textarea>
			
	    	<div class="text-right" style="margin-top : 1em; margin-bottom : 1em">
		    	<button type="button" id="insertComment" class="btn btn-outline-secondary">등록</button>
	    	</div>
	
		</form>
		
		<%
			CommentDao commentDao = CommentDao.getInstance();
			ArrayList<CommentDto> commentList = commentDao.select(no);
			
			int commentTotalRows = commentDao.getTotalRows(no);
		
		
		%>
        <table class="table table-sm" id="commentTable">
       		<colgroup>
        	</colgroup>
        	<thead>
        		<tr>
        			<th id="commentTotal"> 댓글 수 : <%=commentTotalRows %></th>
        		</tr>	
        	</thead>
        	<tbody>
        		<%
        		if(commentList.size() != 0) {
        			for(CommentDto commentDtoList : commentList) {
        			
        		%>
        	
        		<tr>
        			<td>
        				<div class="form-group row">
        					<div class="col-sm-2"><%=commentDtoList.getId() %></div>
        					<div class="col-sm-6"><%=commentDtoList.getRegDate() %></div>
        					<div class="col-sm-4">
        						<a type="button" class="updateComment" href="#" >수정</a>
        						<a type="button" class="deleteComment" href="#" >삭제</a>
        						<input type="hidden" id="commentNo" name="commentNo" value="<%=commentDtoList.getNo() %>">
							</div>
							
							<div class="col-sm-1"></div>
        					<textarea class="form-control col-sm-10" rows="3" id="comment" <%if(commentDtoList.getId().equals(memberDto.getId()) == false) { %>readonly <%} %>name="comment" ><%=commentDtoList.getComment() %></textarea>
        				</div>
        			</td>
        		</tr>
        		
        		<%
					}
				 } else {
				
			    %>
			    
			    <tr>
		    		<td> Don't Exist Data </td>
			    </tr>
			    
			 	<%} %>
			    
			    
        	
        	</tbody>
        </table>
        
            
      </div>
    </div>
  </div>

  <!-- main end -->
  
  
<%@ include file ="../inc/footer.jsp" %>

<script>
	$(function() {
		

		
		/* point등록 regeister
		    파라미터를 하나 더 넘기면 파일 한개로 충분하지 않았을까 함
		    어차피 같은 기능인데 그 파라미터로 insert, update 판단하는게 좋았을듯
		*/
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
						if(json.pointCountOver == "no" ) {
							$("#point").val("정보가 부족합니다.");
						} else {
							$("#point").val(json.avgPoint);
						}
						
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
						if(json.pointCountOver == "no" ) {
							$("#point").val("정보가 부족합니다.");
						} else {
							$("#point").val(json.avgPoint);
						}
					} else {
						// out - db error
						
					}
				}
			});
			
			<%
			}
			%>
		});	
		
		
		/* 댓글등록 listener */
		$("#insertComment").click(function() {
			//댓글창 빈 상태로 등록버튼 누르면 무반응
			 
			if ($("#commentTextArea").val().length == 0 || $("#commentTextArea").val() == null) {
				return;
			}
			
			$.ajax({
				type : 'post',
				url : 'insert_comment_ajax.jsp',
				data : { wantedNo : "<%=wantedDto.getNo() %>", commentId : "<%=memberDto.getId() %>", commentTextArea : $("#commentTextArea").val()},
				dataType : 'json',
				error : function() {
					
				},
				success : function(json) {
					if(json.result == "ok") {
						// db insert
						
						// 여기 수정봐야함
						// 다시 값을 받는것이 불가능하니 값을 땡겨와야할듯 JSON.stringify
						// totalRows 표기
						$("#commentTotal").html("댓글 수 : " + json.item.length);
						
						$("#commentTable>tbody").html(''); // 그전에 있던거 초기화(추가형태로하면 힘드니까)
						
						// insert가 되면 절대 사이즈가 0이 아닐테니
						for(let i=0;i<json.item.length;i++) {
							let html = "";
							html += '<tr><td>';
							html += '<div class="form-group row">';
        					html += '<div class="col-sm-2">'+json.item[i].id +'</div>';
        					html += '<div class="col-sm-6">'+json.item[i].regDate + '</div>';
        					html += '<div class="col-sm-4">';
        					if(json.item[i].id == "<%=memberDto.getId() %>") {
	        					html += '<a type="button" class="updateComment" href="#" > 수정  </a>';
	        					html += '<a type="button" class="deleteComment" href="#" > 삭제  </a>';        						
        					}
        					html += '<input type="hidden" id="commentNo" name="commentNo" value="'+json.item[i].no +'">';
        					html += '</div>';
							html += '<div class="col-sm-1"></div>';
							
							if(json.item[i].id == "<%=memberDto.getId() %>") {
	        					html += '<textarea class="form-control col-sm-10" rows="3" id="comment" name="comment" >'+ json.item[i].comment +'</textarea>';								
							} else {
	        					html += '<textarea class="form-control col-sm-10" rows="3" id="comment" readonly name="comment" >'+ json.item[i].comment +'</textarea>';
								
							}
							
        					html += '</div>';
							html += '</td></tr>';
							
							$("#commentTable>tbody").append(html);
							
						}
						
						$("#commentTextArea").val('');
						$("#commentTextArea").focus();
					}else {
						// db fail
						
					}
				}
				
			});
			
		});
		
		// comment update 눌렀을때
		$(document).on('click','.updateComment',function(){
			// 클릭대상 글번호값
			//$(this).parent().children('input').val();
			// textarea 위치
			//$(this).parent().parent().children('textarea').val();
			
			if ($(this).parent().parent().children('textarea').val().length == 0 || $(this).parent().parent().children('textarea').val() == null) {
				return;
			}
			
			// ajax
			$.ajax({
				type : 'post',
				url : 'update_comment_ajax.jsp',
				data : { no:$(this).parent().children('input').val(),
					wantedNo : "<%=wantedDto.getNo() %>",
					commentId : "<%=memberDto.getId() %>",
					commentTextArea : $(this).parent().parent().children('textarea').val()},
				dataType : 'json',
				error : function() {
					
				},
				success : function(json) {
					if(json.result == "ok") {
						// db insert
						
						// 여기 수정봐야함
						// 다시 값을 받는것이 불가능하니 값을 땡겨와야할듯 JSON.stringify
						// totalRows 표기
						$("#commentTotal").html("댓글 수 : " + json.item.length);
						
						$("#commentTable>tbody").html(''); // 그전에 있던거 초기화(추가형태로하면 힘드니까)
						
						// insert가 되면 절대 사이즈가 0이 아닐테니
						for(let i=0;i<json.item.length;i++) {
							let html = "";
							html += '<tr><td>';
							html += '<div class="form-group row">';
        					html += '<div class="col-sm-2">'+json.item[i].id +'</div>';
        					html += '<div class="col-sm-6">'+json.item[i].regDate + '</div>';
        					html += '<div class="col-sm-4">';
        					if(json.item[i].id == "<%=memberDto.getId() %>") {
	        					html += '<a type="button" class="updateComment" href="#" > 수정  </a>';
	        					html += '<a type="button" class="deleteComment" href="#" > 삭제  </a>';        						
        					}
        					html += '<input type="hidden" id="commentNo" name="commentNo" value="'+json.item[i].no +'">';
        					html += '</div>';
							html += '<div class="col-sm-1"></div>';
							
							if(json.item[i].id == "<%=memberDto.getId() %>") {
	        					html += '<textarea class="form-control col-sm-10" rows="3" id="comment" name="comment" >'+ json.item[i].comment +'</textarea>';								
							} else {
	        					html += '<textarea class="form-control col-sm-10" rows="3" id="comment" readonly name="comment" >'+ json.item[i].comment +'</textarea>';
								
							}
							
        					html += '</div>';
							html += '</td></tr>';
							
							$("#commentTable>tbody").append(html);
							
						}
						$("#commentTextArea").focus();
						
					}else {
						// db fail
						
					}
				}
				
			});
			
		});
		
		$(document).on('click','.deleteComment',function(){
			// 클릭대상 글번호값
			//$(this).parent().children('input').val();
			// textarea 위치
			//$(this).parent().parent().children('textarea').val();
			
			if ($(this).parent().parent().children('textarea').val().length == 0 || $(this).parent().parent().children('textarea').val() == null) {
				return;
			}
			
			// ajax
			$.ajax({
				type : 'post',
				url : 'delete_comment_ajax.jsp',
				data : { no:$(this).parent().children('input').val(),
				    	 wantedNo : "<%=wantedDto.getNo() %>",	
				},
				dataType : 'json',
				error : function() {
					
				},
				success : function(json) {
					if(json.result == "ok") {
						// db insert
						
						// 여기 수정봐야함
						// 다시 값을 받는것이 불가능하니 값을 땡겨와야할듯 JSON.stringify
						// totalRows 표기
						$("#commentTotal").html("댓글 수 : " + json.item.length);
						
						$("#commentTable>tbody").html(''); // 그전에 있던거 초기화(추가형태로하면 힘드니까)
						
						// insert가 되면 절대 사이즈가 0이 아닐테니
						
						if(json.item.length != 0) {
							for(let i=0;i<json.item.length;i++) {
								let html = "";
								html += '<tr><td>';
								html += '<div class="form-group row">';
	        					html += '<div class="col-sm-2">'+json.item[i].id +'</div>';
	        					html += '<div class="col-sm-6">'+json.item[i].regDate + '</div>';
	        					html += '<div class="col-sm-4">';
	        					if(json.item[i].id == "<%=memberDto.getId() %>") {
		        					html += '<a type="button" class="updateComment" href="#" > 수정  </a>';
		        					html += '<a type="button" class="deleteComment" href="#" > 삭제  </a>';        						
	        					}
	        					html += '<input type="hidden" id="commentNo" name="commentNo" value="'+json.item[i].no +'">';
	        					html += '</div>';
								html += '<div class="col-sm-1"></div>';
								
								if(json.item[i].id == "<%=memberDto.getId() %>") {
		        					html += '<textarea class="form-control col-sm-10" rows="3" id="comment" name="comment" >'+ json.item[i].comment +'</textarea>';								
								} else {
		        					html += '<textarea class="form-control col-sm-10" rows="3" id="comment" readonly name="comment" >'+ json.item[i].comment +'</textarea>';
									
								}
								
	        					html += '</div>';
								html += '</td></tr>';
								
								$("#commentTable>tbody").append(html);
								
							}
						} else {
							let html = "";
							html += '<tr><td>';
							html += "Don't Exist Data";
							html += '</td></tr>';
							
							$("#commentTable>tbody").append(html);
						}
						$("#commentTextArea").focus();
						
					}else {
						// db fail
						
					}
				}
				
			});
			
		});
		
		
		
		
		/* update start */
		$("#updateWanted").click(function() {
			// 자바 스크립트 유효성 검사
			
			// 제목 수정시에
			if ($("#title").val().length == 0) {
				$("#title").addClass("is-invalid");
				$("#titleMessage").html("<span class='text-danger'>제목을 입력해주세요</span>");
				$("#title").focus();
				return;
			}
			
			if ($("#content").val().length == 0) {
				$("#content").addClass("is-invalid");
				$("#contentMessage").html("<span class='text-danger'>내용에는 빈칸이 들어갈 수 없습니다.</span>");
				$("#content").focus();
				return;
			}
			
			
			f.action ="update.jsp?page=<%=cPage%>";
			
			f.submit();
		});
		
		/* update end */
		
		/* delete start */
		$("#deleteWanted").click(function() {
			
			// 안에 댓글 다 삭제하고 삭제해야되나?
			f.action ="delete.jsp?page=<%=cPage%>";
			
			f.submit();
			
		});
		
		/* delete end */
		
		
		
		$("#title").keyup(function() {
			$("#title").removeClass("is-invalid");
			$("#titleMessage").html('');
		});
				
		
		$("#content").keyup(function() {
			$("#content").removeClass("is-invalid");
			$("#content").html('');
		});
		
		$("#prevPage").click(function() {
			history.back(-1);
		});
		
		
		
		
		
	});
</script>
