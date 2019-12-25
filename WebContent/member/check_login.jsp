<%@page import="kr.co.acorn.dto.MemberDto"%>
<%@page import="kr.co.acorn.dao.MemberDao"%>
<%@ page pageEncoding="utf-8"%>

<%
	request.setCharacterEncoding("utf-8");

	String email = request.getParameter("email");
	String password = request.getParameter("password");
	
	MemberDao dao = MemberDao.getInstance();
	
	//boolean isSuccess = dao.isCorrect(email, password);
	
	MemberDto dto = new MemberDto(email, null, password, null, null);
		
	dto = dao.getMember(dto);		// 일관성이 있어야함, 객체 2~3개이상 파라미터로 넘기면 객체로 넘기는 버릇!
	
	if(dto!=null) {
		//session에 시간을 설정한다. 기본시간은 30분
		session.setMaxInactiveInterval(60*60*24);
		
		// session에  dto 정보를 저장한다
		session.setAttribute("member", dto);
		
%>
	<script>
		alert('Success LogIn');
		location.href="/index.jsp";
	</script>	
<%
	} else {
%>
	<script>
		alert('Failed LogIn, Input correct Info');
		history.back(-1);
	</script>	
<%
		
	}
	

%>