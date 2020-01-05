
<%@page import="kr.co.acorn.dto.WantedDto"%>
<%@page import="kr.co.acorn.dao.WantedDao"%>
<%@page import="java.util.ArrayList"%>

<%@ page pageEncoding="utf-8" %>

<%@ include file="../inc/header.jsp" %>

<%
	String tempPage = request.getParameter("page");
	//String tempLen = request.getParameter("len");

	int cPage = 0;
	
	int start = 0;
	int len = 10;
	int totalRows = 0;
	int totalPage = 0; 
	int startPage = 0;
	int endPage = 0;
	int pageLength = 3;
	
	int pageNum = 0;
	
	// page값을 공개로 넣기 때문에 코드값에 막넣는 경우에 대해 예외처리하기 위해서 조정함
	if(tempPage == null || tempPage.length() == 0) {
		cPage = 1;
	}
	try {
		cPage = Integer.parseInt(tempPage);
	} catch(NumberFormatException e) {
		cPage = 1;
	}
	/* 
	if(tempLen == null || tempLen.length() == 0) {
		len = 2;
	}
	try {
		len = Integer.parseInt(tempLen);
	} catch(NumberFormatException e) {
		len = 2;
	}
	 */
	
	WantedDao dao = WantedDao.getInstance(); 
	
	totalRows = dao.getTotalRows();
	
	
	totalPage = totalRows % len ==0 ? totalRows/len : totalRows/len +1;
	if(totalPage == 0) {
		totalPage = 1;
	}
	
	if(cPage > totalPage) {
		response.sendRedirect("list.jsp?page=1");
		return;
	}
	
	/*
	if(cPage > totalPage) {
		cPage=1;
	}
	*/
	
	start = (cPage-1)*len ;
	
	
	int currentBlock = cPage % pageLength == 0 ? cPage/pageLength : cPage/pageLength+1;
	int totalBlock = totalPage % pageLength == 0 ? totalPage/pageLength : totalPage/pageLength+1;
	startPage = 1 + (currentBlock - 1) * pageLength;
	endPage = pageLength + (currentBlock-1)*pageLength;
	
	if(currentBlock == totalBlock) {
		endPage = totalPage;
	}
	
	/* 
	startPage = cPage % pageLength == 0 ? 1 + (cpage/pageLength - 1) * pageLength  : 1 + (cpage/pageLength ) * pageLength;
	endPage = totalPage > (startPage + pageLength -1 )? (startPage + pageLength -1 ) : totalPage;
	 */
	ArrayList<WantedDto> list = dao.select(start, len);
	 
	pageNum = totalRows-((cPage-1)*len);
	
	if(memberDto == null) {
		response.sendRedirect(contextPath + "/index.jsp ");
		return;
	}
	

%>

  <!-- breadcrumb start -->
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="<%=contextPath %>/index.jsp">Home</a></li>
      <li class="breadcrumb-item active" aria-current="page">Wanted</li>
    </ol>
  </nav>
  
  <!-- breadcrumb end -->
  
  <!-- main start -->

  <div class="container">
    <div class="row">
      <div class="col-lg-12">
      
      <h3><strong>애완동물과 함께 해드립니다</strong><small>( 글 수 : <%=totalRows %> )</small></h3><br>
      
      <div class="text-right"></div>


		<table class="table table-hover">
		<colgroup>
			<col width="10%" />
			<col width="45%"/>
			<col width="15%"/>
			<col width="15%"/>
			<col width="15%"/>
		</colgroup>
		  <thead>
		    <tr>		  		
		      <th scope="col">글번호</th>
		      <th scope="col">제목</th>
		      <th scope="col">작성자</th>
		      <th scope="col">등록일</th>
		      <th scope="col">예약하기</th>     
		    </tr>
		  </thead>
		  <tbody>
		 
		 <%
		 if(list.size() != 0) {
			for(WantedDto dto : list) {
		 
		 %>
	
			    <tr>			    	
			      <td><a href="view.jsp?page=<%=cPage%>&no=<%=dto.getNo() %>"><%=dto.getNo() %></a></td>
			      <td><a href="view.jsp?page=<%=cPage%>&no=<%=dto.getNo() %>"><%=dto.getTitle() %></a></td>
			      <td><%=dto.getId() %></td>
			      <%-- regDate 에 .0 붙는거 처리 .substring(0, dto.getRegDate().length()-2) --%>
			      <td><%=dto.getRegDate() %></td>
			      <td> <% if(dto.getId().equals(memberDto.getId()) || memberDto.getType()==0 ) { %> <button class="btn btn-outline-success book">예약</button> <%} %> </td>
			    </tr>
			    <tr>
			    	<%-- select 부분 --%>
			    	<%-- <input type="hidden" class="booking" value="test123"/> --%>
			    </tr>
			    <tr>
			    	<%-- insert, update 부분 --%>
			    </tr>
	    
		    <%
				}
			 } else {
			
		    %>
		    
		    <tr>
		    	<td colspan="5"> Don't Exist Data </td>
		    </tr>
		    
		 	<%
		 	} 
		 	%>
		    
		  </tbody>
		</table>

			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<% if(currentBlock == 1) { %>
						<li class="page-item disabled">
						<a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>					
						</li>
					<% }else { %>
						<li class="page-item">
						<a class="page-link" href="list.jsp?page=<%=startPage-1 %>">Previous</a>
						</li>
					<%} %>
					
					<%for(int i = startPage;i<=endPage;i++) { %>
					<li class="page-item <%if(cPage==i){ %>active<% }%>"><a class="page-link" href="list.jsp?page=<%=i%>"><%=i%></a></li>
					<%} %>
					<% if(currentBlock == totalBlock) { %>
						<li class="page-item disabled">
						<a class="page-link" href="#" tabindex="-1" aria-disabled="true">Next</a>
						</li>
					<% } else { %>
						<li class="page-item">
						<a class="page-link" href="list.jsp?page=<%=endPage+1%>" >Next</a>
						</li>
					<%} %>	
					
				</ul>
			</nav>

			<% if(memberDto.getType() == 1 ) { %>
			<div class="text-right">
				<a href="write.jsp?page=<%=cPage %>" class="btn btn-outline-success">등록하기</a>
			</div>
			<% } %>
		
			
		</div>
    </div>
  </div>

  <!-- main end -->
  
  
<%@ include file ="../inc/footer.jsp" %>

<script>
	
	$(".book").click(function() {
		// 비어있는 ajax용 노드찾기
		//console.log($(this).parent().parent().next().children('.booking').val());
		//console.log($(this).parent().parent().next().children());
		if($(this).parent().parent().next().children() == null || $(this).parent().parent().next().children().length == 0) {
			// 비어있을 때
			$(this).html('접기');
			
			
			
			<%
			if(memberDto.getType() == 1) {
				//petSitter
			%>
				// 테이블 내에 내부 테이블 형태로 만들어?
				let html = "";
				const curThis = $(this);
				/* 
				html += '<td colspan="5">';
				html += 'PetSitter-make table..';
				html += '</td>';
				$(this).parent().parent().next().append(html);
				 */
				//console.log($(this).parent().prev().prev().text());
				<%-- 위에서 조정해버림(본인인경우만 버튼이 나옴)
				if($(this).parent().prev().prev().text() == "<%=memberDto.getId() %>") {
					// 작성자인 경우	
				} else {
					// 작성자가 아닌 경우
				}
				 --%>
				
				 $.ajax({
						type : 'post',
						url : 'select_book_ajax.jsp',
						data : {wantedNo : $(this).parent().prev().prev().prev().prev().text()},
						datatype : 'json',
						error : function(){
						},
						success : function(json){
							if(json.item.length == 0) {
								let html = "";
								html += '<td colspan="4">';
								html += '<strong>데이터가 없습니다.</strong>';
								
								html += '</td>';
								html += '<td>';
								html += '<button class="bookInsert btn btn-outline-primary">등록</button>';
								html += '</td>';
								curThis.parent().parent().next().append(html);
							}else {
								let html = "";
								html += '<td colspan="4">';
								
								html += '<table class="col-sm-12">';
								html += '<colgroup>';
								html += '<col width="15%"/>'; // 신청자 아이디	
								html += '<col width="20%"/>'; // 시작일
								html += '<col width="20%"/>'; // 종료일
								html += '<col width="30%"/>'; // 내용
								html += '<col width="15%"/>'; // 확정결과
								html += '</colgroup>';
								html += '<thead>';
								html += '<tr>';
							    html += '<th scope="col">아이디</th>';
							    html += '<th scope="col">시작일</th>';
							    html += '<th scope="col">종료일</th>';
							    html += '<th scope="col">내  용</th>';
							    html += '<th scope="col">확정결과</th>';
							    html += '</tr>';
								html += '</thead>';
								html += '<tbody>';
								
								
								for(let i=0;i<json.item.length;i++) {
									html += '<tr>';
									
									html += '<td>' + json.item[i].applicId + '</td>' ;
									html += '<td>' + json.item[i].bookStart + '</td>' ;
									html += '<td>' + json.item[i].bookEnd + '</td>' ;
									html += '<td>' + json.item[i].content + '</td>' ;
									html += '<td>';
									if(json.item[i].isConfirm == false) {
										// no;
										html += '<button type="button" class="bookConfirm">no</button>'; 
									} else {
										html += '<button type="button" class="bookConfirm">yes</button>';
									}

									html += '<input type="hidden" value="'+json.item[i].no+'"/>';
									html +=  '</td>' ;
								
									
									html += '</tr>';
									
								}
								
								html += '</tbody>';
								html += '</table>';
								
								html += '</td>';
								
								
								curThis.parent().parent().next().append(html);
								
							}
						}
					});
				
				
				
			<%
			} else {
				//applicant
			%>
				// 현위치를 저장해야함 왜냐하면 문제가 생기니까요
				// <div style="display : none"> 옵션으로 바꾸면 하드코딩/개발코딩 안해도 되요 => 더 좋음 방법
				const curThis = $(this);
				
				// inner table
				
				
				$.ajax({
					type : 'post',
					url : 'select_book_ajax.jsp',
					data : {wantedNo : $(this).parent().prev().prev().prev().prev().text()},
					datatype : 'json',
					error : function(){
					},
					success : function(json){
						if(json.item.length == 0) {
							let html = "";
							html += '<td colspan="4">';
							html += '<strong>데이터가 없습니다.</strong>';
							
							html += '</td>';
							html += '<td>';
							html += '<button class="bookInsert btn btn-outline-primary">등록</button>';
							html += '</td>';
							curThis.parent().parent().next().append(html);
						}else {
							let html = "";
							html += '<td colspan="4">';
							
							html += '<table class="col-sm-12">';
							html += '<colgroup>';
							html += '<col width="20%"/>'; // 시작일
							html += '<col width="20%"/>'; // 종료일
							html += '<col width="30%"/>'; // 내용
							html += '<col width="15%"/>'; // 확정결과
							html += '<col width="15%"/>'; // 수정/삭제 버튼			
							html += '</colgroup>';
							html += '<thead>';
							html += '<tr>';
						    html += '<th scope="col">시작일</th>';
						    html += '<th scope="col">종료일</th>';
						    html += '<th scope="col">내  용</th>';
						    html += '<th scope="col">확정결과</th>';
						    html += '<th scope="col">수정/삭제</th>';
						    html += '</tr>';
							html += '</thead>';
							html += '<tbody>';
							
							
							for(let i=0;i<json.item.length;i++) {
								html += '<tr>';
								
								html += '<td>' + json.item[i].bookStart + '</td>' ;
								html += '<td>' + json.item[i].bookEnd + '</td>' ;
								html += '<td>' + json.item[i].content + '</td>' ;
								html += '<td>';
								if(json.item[i].isConfirm == false) {
									html += "No"
								} else {
									html += "Yes";
								}

								html +=  '</td>' ;
								
								//button
								html += '<td>';
								html += '<input type="hidden" value="'+json.item[i].no+'"/>';
								html += '<button class="bookUpdate btn btn-outline-warning">수정</button>';
								html += '<button class="bookDelete btn btn-outline-danger">삭제</button>';
								html += '</td>';
								
								html += '</tr>';
								
							}
							
							html += '</tbody>';
							html += '</table>';
							
							html += '</td>';
							html += '<td>';
							html += '<button class="bookInsert btn btn-outline-primary">등록</button>';
							html += '</td>';
							
							
							curThis.parent().parent().next().append(html);
							
						}
					}
				});
				
				
			
			<%	
			}
			%>
			
			
			
			
		} else {
			$(this).html('예약');
			$(this).parent().parent().next().html('');
			$(this).parent().parent().next().next().html('');
		}
		
	});

	// 추가 수정문 열때 쓰는것
	$(document).on('click','.bookInsert',function(event){
		if($(this).parent().parent().next().children() == null || $(this).parent().parent().next().children().length == 0) {
			$(this).html('접기');
			$(this).parent().parent().next().html('');
			
			
			let html ="";
			html += '<td colspan="4">';
			html += '<div class="form-group row">';
	
			html += '<div class="col-sm-4">';
			html += '시작일';
			html += '<input type="datetime-local" name="inputBookStart" id="inputBookStart"/>';
			html += '<br>';
			html += '종료일';
			html += '<input type="datetime-local" name="inputBookEnd" id="inputBookEnd"/>';
			html += '</div>';
			html += '<div class="col-sm-8">';
			html += '내용<br>';
			html += '<input type="text" class="col-sm-10" name="inputBookContent" id="inputBookContent" value=""/>';
			html += '<div class="bookMessage"></div>';
			html += '</div>';
			
			html += '</div>';
			html += '</td>';
			html += '<td>';
			html += '<button class="bookInsertConfirm btn btn-outline-primary">등록</button>'
			html += '</td>';
			
			$(this).parent().parent().next().append(html);
		} else {
			$(this).html('등록');
			$(this).parent().parent().next().html('');
		}
		
	});
	
	$(document).on('click','.bookUpdate',function(event){
		const curThis = $(this);
		//console.log($(this).parent().parent().children(":first").text().substring(0,$(this).parent().parent().children(":first").text().length-2));
		//console.log($(this).parent().parent().parent().parent().parent().parent().next());
		
		const nextTr = $(this).parent().parent().parent().parent().parent().parent().next();
		
		//console.log($(this).parent().children('input').val());
		
		
		
		if(nextTr.children() == null || nextTr.children().length == 0) {
			
			$(this).parent().parent().parent().children().find('.bookUpdate').html('수정');
			
			$(this).html('접기');
			nextTr.html('');
			 
			let html ="";
			html += '<td colspan="4">';
			html += '<div class="form-group row">';
	
			html += '<div class="col-sm-4">';
			html += '시작일';
			html += '<input type="datetime-local" name="inputBookStart" id="inputBookStart" value="'+$(this).parent().parent().children(":first").text().substring(0,$(this).parent().parent().children(":first").text().length-2).replace(" ","T")+'"/>';
			html += '<br>';
			html += '종료일';
			html += '<input type="datetime-local" name="inputBookEnd" id="inputBookEnd" value="'+$(this).parent().parent().children(":first").next().text().substring(0,$(this).parent().parent().children(":first").next().text().length-2).replace(" ","T")+'"/>';
			html += '</div>';
			html += '<div class="col-sm-8">';
			html += '내용<br>';
			html += '<input type="text" class="col-sm-10" name="inputBookContent" id="inputBookContent" value="'+$(this).parent().parent().children(":first").next().next().text()+'"/>';
			html += '<div class="bookMessage"></div>';
			html += '</div>';
			
			html += '</div>';
			html += '</td>';
			html += '<td>';
			html += '<button class="bookUpdateConfirm btn btn-outline-primary">수정</button>';
			html += '<input type="hidden" value="'+$(this).parent().children('input').val() +'"/>';
			html += '</td>';
			
			nextTr.append(html);
			
		} else {
			$(this).parent().parent().parent().children().find('.bookUpdate').html('수정');
			//$(this).html('수정');
			$(this).parent().parent().parent().parent().parent().parent().next().html('');
		}
		
		
		
	});
	
	$(document).on('click','.bookInsertConfirm',function(event){
		/* 
		// if start Date doesn't input
		if($(this).parent().prev().find('#inputBookStart').val() ==null && $(this).parent().prev().find('#inputBookStart').val().length() == 0) {
			return;
		}
		// if end Date doesn't input
		if($(this).parent().prev().find('#inputBookEnd').val() ==null && $(this).parent().prev().find('#inputBookEnd').val().length() == 0) {
			return;
		}
		// if comment doesn't input
		if($(this).parent().prev().find('#inputBookContent').val() ==null && $(this).parent().prev().find('#inputBookContent').val().length() == 0) {
			return;
		}
		*/
		
		const curThis = $(this);
		
		//console.log($(this).parent().prev().find('#inputBookStart'));
		//onsole.log($(this).parent().prev().find('#inputBookStart').val());
		 
		$.ajax({
			type : 'post',
			url : 'insert_book_ajax.jsp',
			// 넘겨야할 것 : wantedNo, applicId, content, bookStart, bookEnd
			data : {
				wantedNo : $(this).parent().parent().prev().prev().children(":first").text(),
				applicId : "<%=memberDto.getId() %>",
				content : $(this).parent().prev().find('#inputBookContent').val(),
				bookStart : $(this).parent().prev().find('#inputBookStart').val(),
				bookEnd : $(this).parent().prev().find('#inputBookEnd').val()
			},
			datatype : 'json',
			error : function(){
			},
			success : function(json){
				if(json.result == "ok") {
					//console.log("success");
					const resetBtn = curThis.parent().parent().prev().prev().children(":last").find(".book");
					resetBtn.trigger("click");
					resetBtn.trigger("click");
					
					
				} else {
					//$(this).parent().prev().find('#bookMessage').html("<span class='text-danger'>정보를 입력해주세요</span>");
				}
			}
		});
		
	});
	
	$(document).on('click','.bookUpdateConfirm',function(event){
		/* 
		// if start Date doesn't input
		if($(this).parent().prev().find('#inputBookStart').val() ==null && $(this).parent().prev().find('#inputBookStart').val().length() == 0) {
			return;
		}
		// if end Date doesn't input
		if($(this).parent().prev().find('#inputBookEnd').val() ==null && $(this).parent().prev().find('#inputBookEnd').val().length() == 0) {
			return;
		}
		// if comment doesn't input
		if($(this).parent().prev().find('#inputBookContent').val() ==null && $(this).parent().prev().find('#inputBookContent').val().length() == 0) {
			return;
		}
		*/
		
		const curThis = $(this);
		
		//console.log($(this).parent().children('input').val());
		// 여러개 수정인경우 다른거 수정 누르다가 조정하는거 처리
		  
		$.ajax({
			type : 'post',
			url : 'update_book_ajax.jsp',
			// 넘겨야할 것 : no, content, bookStart, bookEnd
			data : {
				no : $(this).parent().children('input').val(),
				content : $(this).parent().prev().find('#inputBookContent').val(),
				bookStart : $(this).parent().prev().find('#inputBookStart').val(),
				bookEnd : $(this).parent().prev().find('#inputBookEnd').val()
			},
			datatype : 'json',
			error : function(){
			},
			success : function(json){
				if(json.result == "ok") {
					//console.log("success");
					const resetBtn = curThis.parent().parent().prev().prev().children(":last").find(".book");
					resetBtn.trigger("click");
					resetBtn.trigger("click");
					
					
				} else {
					//$(this).parent().prev().find('#bookMessage').html("<span class='text-danger'>정보를 입력해주세요</span>");
				}
			}
		});
		
	});
	
	$(document).on('click','.bookConfirm', function(){
		const curThis = $(this);
		
		let isConfirmNow = false;
		
		//console.log($(this).text());
		if($(this).text() == 'yes') {
			isConfirmNow = true;
		}
		
		
		$.ajax({
			type : 'post',
			url : 'confirm_book_ajax.jsp',
			// 넘겨야할 것 : no, content, bookStart, bookEnd
			data : {
				no : $(this).parent().children('input').val(),
				isConfirm : isConfirmNow
			},
			datatype : 'json',
			error : function(){
			},
			success : function(json){
				if(json.result == "ok") {
					//console.log("success");
					
					if(json.isConfirm == true) {
						curThis.text('yes');
					} else {
						curThis.text('no');
					}
					
					
				} else {
					//$(this).parent().prev().find('#bookMessage').html("<span class='text-danger'>정보를 입력해주세요</span>");
				}
			}
		});
		
	});
	
	$(document).on('click','.bookDelete', function(){
		const curThis = $(this);
		
		$.ajax({
			type : 'post',
			url : 'delete_book_ajax.jsp',
			// 넘겨야할 것 : no
			data : {
				no : $(this).parent().children('input').val()
			},
			datatype : 'json',
			error : function(){
			},
			success : function(json){
				if(json.result == "ok") {
					//console.log("success");
					const resetBtn = curThis.parent().parent().parent().parent().parent().parent().prev().children(":last").find(".book");
					resetBtn.trigger("click");
					resetBtn.trigger("click");
					
				} else {
					//$(this).parent().prev().find('#bookMessage').html("<span class='text-danger'>아이디를 입력해주세요</span>");
				}
			}
		});
		
		
	});
	

</script>


