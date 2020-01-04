
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
			      <td><button class="btn btn-outline-success book">예약</button></td>
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
				
				html += '<td colspan="5">';
				html += 'PetSitter-make table..';
				html += '</td>';
				$(this).parent().parent().next().append(html);
				
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
			html += '<input type="date" name="inputBookStart" id="inputBookStart"/>';
			
			html += '종료일';
			html += '<input type="date" name="inputBookEnd" id="inputBookEnd"/>';
			html += '</div>';
			html += '<div class="col-sm-8">';
			html += '내용<br>';
			html += '<input type="text" name="inputBookComment" id="inputBookComment" value=""/>';
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
	
	$(document).on('click','.bookInsertConfirm',function(event){
			
		const curThis = $(this);
		
		$.ajax({
			type : 'post',
			url : 'insert_book_ajax.jsp',
			// 넘겨야할 것 : bookStart, bookEnd, comment, wantedNo, applicId
			data : {},
			datatype : 'json',
			error : function(){
			},
			success : function(json){
				
			}
		});
		
		
		
		
	});
	
	

</script>


