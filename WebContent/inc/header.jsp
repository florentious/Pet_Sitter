
<%@page import="kr.co.acorn.dto.MemberDto"%>
<%@ page pageEncoding="utf-8" %>

<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
    integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

  <title>펫시터 - 애완동물을 잠시 보관해드립니다.</title>
</head>

<body>
  <!-- navbar start -->
  <nav class="navbar navbar-expand-lg navbar-dark " style="background-color: #563d7c;">
    <a class="navbar-brand" href="/Pet_Sitter/index.jsp">Home</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02"
      aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
<%
	// 해당부분을 강조하기 위해서 시작값이 다름- 해당위치에 있다는 것을 강조하기 위해서
	String uri = request.getRequestURI();
	String contextPath = request.getContextPath();
	
%>

    <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
      <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
        <li class="nav-item <%if(uri.startsWith("/wanted/")) {%>active<%} %>">
          <a class="nav-link" href="<%=contextPath %>/wanted/list.jsp">펫시터 <span class="sr-only">(current)</span></a>
        </li>
        
        
        <li class="nav-item <%if(uri.startsWith("/notice/")) {%>active<%} %>">
          <a class="nav-link" href="<%=contextPath %>/notice/list.jsp">공지사항</a>
        </li>
      </ul>
      
      <ul class="navbar-nav">
      <%
      	MemberDto memberDto = (MemberDto)session.getAttribute("member");	
      	
      	if(memberDto == null) {
      %>
      	<li class="nav-item">
      		<a class="nav-link" href="<%=contextPath %>/member/write.jsp"> 가입하기</a>
      	</li>
      	
      	<li class="nav-item">
      		<a class="nav-link" href="<%=contextPath %>/member/login.jsp"> 로그인</a>
      	</li>
      
      <%
     	 } else {
      %>
      	<li class="nav-item">
      		<a class="nav-link" href="<%=contextPath %>/member/view.jsp?email=<%=memberDto.getId()%>"><%=memberDto.getName() %>(<%=memberDto.getId() %>)님 환영합니다. </a>
      	</li>
      	
      	<li class="nav-item">
      		<a class="nav-link" href="<%=contextPath %>/member/logout.jsp"> 로그아웃 </a>
      	</li>
      	
      
      <% } %>
      </ul>
      
      
    </div>
  </nav>
  <!-- navbar end -->
  
  
  