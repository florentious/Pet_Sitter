<%@page import="kr.co.acorn.dto.BookDto"%>
<%@page import="kr.co.acorn.dao.BookDao"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page contentType="application/json; charset=utf-8" %>

<%
	request.setCharacterEncoding("utf-8");
	
	int no = Integer.parseInt(request.getParameter("no"));
	String content = request.getParameter("content");
	String bookStart = request.getParameter("bookStart");
	String bookEnd = request.getParameter("bookEnd");
	
	BookDao bookDao = BookDao.getInstance();
	
	BookDto bookDto = new BookDto(no,0,null,content,null,bookStart,bookEnd,false);
	
	
	boolean isSuccess = bookDao.update(bookDto);

	JSONObject obj = new JSONObject();
	if(isSuccess) {
		obj.put("result","ok");
	}else {
		obj.put("result","fail");
	}
	out.print(obj);

%>

