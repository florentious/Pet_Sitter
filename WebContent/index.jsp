<%@page import="kr.co.acorn.dto.NoticeDto"%>
<%@page import="kr.co.acorn.dto.WantedDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.acorn.dao.WantedDao"%>
<%@page import="kr.co.acorn.dao.NoticeDao"%>
<%@ page pageEncoding="utf-8" %>

<%@ include file="../inc/header.jsp" %>

<%
	int start = 0;
	int len = 5;
	
	NoticeDao noticeDao = NoticeDao.getInstance();
	WantedDao wantedDao = WantedDao.getInstance();
	
	ArrayList<NoticeDto> noticeList = noticeDao.select(start, len);
	ArrayList<WantedDto> wantedList = wantedDao.select(start, len);

%>

  <!-- breadcrumb start -->
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="<%=contextPath %>/index.jsp">Home</a></li>
      <li class="breadcrumb-item active" aria-current="page">Library</li>
    </ol>
  </nav>
  
  <!-- breadcrumb end -->
  
  <!-- main start -->

  <div class="container">
      <div class="col-sm-12 row">

   <%-- input content --%>
			<div class="col-sm-6">
				<strong><a href="<%=contextPath %>/notice/list.jsp">Notice</a></strong>
				<div class="table-responsive-lg">
				<table class="table table-hover">
					<colgroup>
						<col width="15%" />
						<col width="55%" />
						<col width="15%" />
						<col width="15%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">글번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">작성일</th>
						</tr>
					</thead>
					<tbody>
						<%
							if (noticeList.size() != 0) {
								for (NoticeDto dto : noticeList) {
						%>
						<tr>
							<td><a href="<%=contextPath %>/notice/view.jsp?no=<%=dto.getNo()%>"><%=dto.getNo() %></a></td>
							<td><a href="<%=contextPath %>/notice/view.jsp?no=<%=dto.getNo()%>"><%=dto.getTitle()%></a></td>
							<td><%=dto.getId()%></td>
							<td><%=dto.getRegDate() %></td>
						</tr>
						<%
								}
							} else {
						%>
						<tr>
							<td colspan="4">데이터가 존재하지 않습니다.</td>
						</tr>
						<%
							}
						%>

					</tbody>
				</table>
				</div>
			</div>
			
			<div class="col-sm-6">
				<%-- wanted --%>
				<strong><a href="<%=contextPath %>/wanted/list.jsp">Wanted</a></strong>
				
				<table class="table table-hover">
					<colgroup>
						<col width="10%"/>
						<col width="40%"/>
						<col width="25%"/>
						<col width="25%"/>
					</colgroup>
					  <thead>
					    <tr>		  		
					      <th scope="col">글번호</th>
					      <th scope="col">제목</th>
					      <th scope="col">작성자</th>
					      <th scope="col">등록일</th>   
					    </tr>
					  </thead>
					  <tbody>
							 <%
							 if(wantedList.size() != 0) {
								for(WantedDto wantedDto : wantedList) {
							 
							 %>
						
								    <tr>			    	
								      <td><a href="<%=contextPath %>/wanted/view.jsp?no=<%=wantedDto.getNo() %>"><%=wantedDto.getNo() %></a></td>
								      <td><a href="<%=contextPath %>/wanted/view.jsp?no=<%=wantedDto.getNo() %>"><%=wantedDto.getTitle() %></a></td>
								      <td><%=wantedDto.getId() %></td>
								      <%-- regDate 에 .0 붙는거 처리 .substring(0, dto.getRegDate().length()-2) --%>
								      <td><%=wantedDto.getRegDate() %></td>
								      
								    </tr>
							    <%
									}
								 } else {
								
							    %>
							    
							    <tr>
							    	<td colspan="4"> Don't Exist Data </td>
							    </tr>
							    
							 	<%
							 	} 
							 	%>
							
							
						
					  </tbody>
				</table>
				
				
			</div>
          
            
      </div>
  </div>

  <!-- main end -->
  
  
<%@ include file ="../inc/footer.jsp" %>
