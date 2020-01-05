<%@page import="kr.co.acorn.dto.BookDto"%>
<%@page import="kr.co.acorn.dao.BookDao"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page contentType="application/json; charset=utf-8" %>

<%
	request.setCharacterEncoding("utf-8");
	
	int no = Integer.parseInt(request.getParameter("no"));
	
	BookDao bookDao = BookDao.getInstance();
	
	
	boolean isSuccess = bookDao.delete(no);
	
	JSONObject obj = new JSONObject();
	if(isSuccess) {
		obj.put("result","ok");
	}else {
		obj.put("result","fail");
	}
	out.print(obj);

%>