<%@page import="org.json.simple.JSONObject"%>
<%@page import="kr.co.acorn.dao.MemberDao"%>
<%@ page contentType="application/json; charset=utf-8" %>

<%
	String email = request.getParameter("email");
	String password = request.getParameter("password");

	MemberDao dao = MemberDao.getInstance();
	
	boolean isCorrect = dao.isCorrect(email, password);
	
	JSONObject obj = new JSONObject();
	if(isCorrect) {
		obj.put("result","ok");
	} else {
		obj.put("result","fail");
	}
	out.print(obj.toString());
	
%>