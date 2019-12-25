<%@ page pageEncoding="utf-8" %>

<%
	/*
		http session 객체를 종료하는 방법
		1. 브라우저를 종료했을 경우
		2. 해당페이지의 시간이ㅏ 세션 만료시간을 겨오가했을 경우
		3. invalidate() 메서드를 호출하는 경우
	
	*/
	//session.removeAttribute("member");	// 정보만 날리기 위해서 attribute
	session.invalidate();
	response.sendRedirect("/index.jsp");


%>