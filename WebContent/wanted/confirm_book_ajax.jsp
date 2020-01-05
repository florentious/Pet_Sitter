<%@page import="kr.co.acorn.dto.BookDto"%>
<%@page import="kr.co.acorn.dao.BookDao"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page contentType="application/json; charset=utf-8" %>

<%
	request.setCharacterEncoding("utf-8");
	
	int no = Integer.parseInt(request.getParameter("no"));
	Boolean isConfirm = Boolean.parseBoolean(request.getParameter("isConfirm"));
	
	if(isConfirm == false) {
		isConfirm = true;
	} else {
		isConfirm = false;
	}
	
	BookDao bookDao = BookDao.getInstance();
	
	BookDto bookDto = new BookDto(no,0,null,null,null,null,null,isConfirm);
	
	
	boolean isSuccess = bookDao.updateConfirm(bookDto);

	JSONObject obj = new JSONObject();
	if(isSuccess) {
		obj.put("result","ok");
		obj.put("isConfirm",isConfirm);
	}else {
		obj.put("result","fail");
	}
	out.print(obj);

%>

