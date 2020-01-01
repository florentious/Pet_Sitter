<%@page import="kr.co.acorn.dto.CommentDto"%>
<%@page import="kr.co.acorn.dao.CommentDao"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page contentType="application/json; charset=utf-8" %>

<%
	request.setCharacterEncoding("utf-8");

	String tempWantedNo = request.getParameter("wantedNo");
	String id = request.getParameter("commentId");
	String comment = request.getParameter("commentTextArea");
	
	int wantedNo = Integer.parseInt(tempWantedNo);
	
	CommentDao commentDao = CommentDao.getInstance();
	int no = commentDao.getMaxNo();
	CommentDto commentDto = new CommentDto(no,wantedNo,id,comment,null);
	
	boolean isSuccess = commentDao.insert(commentDto);
	
	JSONObject obj = new JSONObject();
	if(isSuccess) {
		obj.put("result","ok");
	}else {
		obj.put("result","fail");
	}
	out.print(obj.toString());
	

%>