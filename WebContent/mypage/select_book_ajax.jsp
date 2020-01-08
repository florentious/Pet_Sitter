<%@page import="kr.co.acorn.dao.BookDao"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page contentType="application/json; charset=utf-8" %>

<%
	request.setCharacterEncoding("utf-8");

	int wantedNo = Integer.parseInt(request.getParameter("wantedNo"));
	
	String id = request.getParameter("id");
	
	
	BookDao bookDao = BookDao.getInstance();
	
	// jsonArray 형태로만들어서 보냄(Dao에서도 JSON으로 코딩해야함)
	JSONArray item = null;
	
	if(id == null) {
		item = bookDao.selectJson(wantedNo);
		
	} else {
		item = bookDao.selectJson(wantedNo, id);
		
	}
	
	
	JSONObject obj = new JSONObject();
	
	obj.put("item",item);
	out.print(obj);
	

%>
