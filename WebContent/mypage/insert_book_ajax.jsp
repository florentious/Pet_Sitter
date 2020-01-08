<%@page import="kr.co.acorn.dto.BookDto"%>
<%@page import="kr.co.acorn.dao.BookDao"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page contentType="application/json; charset=utf-8" %>

<%
	request.setCharacterEncoding("utf-8");
	
	int wantedNo = Integer.parseInt(request.getParameter("wantedNo"));
	String applicId = request.getParameter("applicId");
	String content = request.getParameter("content");
	String bookStart = request.getParameter("bookStart");
	String bookEnd = request.getParameter("bookEnd");
	
	BookDao bookDao = BookDao.getInstance();
	
	int no = bookDao.getMaxNo();
	
	BookDto bookDto = new BookDto(no,wantedNo,applicId,content,null,bookStart,bookEnd,false);
	
	
	boolean isSuccess = bookDao.insert(bookDto);

	JSONObject obj = new JSONObject();
	if(isSuccess) {
		obj.put("result","ok");
	}else {
		obj.put("result","fail");
	}
	out.print(obj);

%>

