<%@page import="org.json.simple.JSONArray"%>
<%@page import="kr.co.acorn.dto.CommentDto"%>
<%@page import="kr.co.acorn.dao.CommentDao"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page contentType="application/json; charset=utf-8" %>

<%
	request.setCharacterEncoding("utf-8");

	String tempNo = request.getParameter("no");
	
	int no = Integer.parseInt(tempNo);
	
	CommentDao commentDao = CommentDao.getInstance();
	
	boolean isSuccess = commentDao.delete(no);
		
	// jsonArray 형태로만들어서 보냄(Dao에서도 JSON으로 코딩해야함)
	JSONArray item = commentDao.selectJson();
	
	JSONObject obj = new JSONObject();
	if(isSuccess) {
		obj.put("result","ok");
		obj.put("item",item);
	}else {
		obj.put("result","fail");
	}
	//out.print(obj.toString());
	out.print(obj);
	

%>