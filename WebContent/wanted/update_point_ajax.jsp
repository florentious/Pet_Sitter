<%@page import="kr.co.acorn.dao.MemberDao"%>
<%@page import="kr.co.acorn.dto.PointDto"%>
<%@page import="kr.co.acorn.dao.PointDao"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page contentType="application/json; charset=utf-8" %>

<%
	
	String sitterId = request.getParameter("sitterId");
	String applicId = request.getParameter("applicId");
	String tempPoint = request.getParameter("point");
	int point = Integer.parseInt(tempPoint);
	
	PointDao dao = PointDao.getInstance();
	PointDto dto = new PointDto(sitterId, applicId, null);
	
	MemberDao memberDao = MemberDao.getInstance();
	
	boolean isSuccess = false;
	if( dao.update(dto) && memberDao.updatePoint(sitterId, point )) {
		isSuccess = true;
	}
	// 이미 있으면 true
	
	JSONObject obj = new JSONObject();
	if(isSuccess) {
		obj.put("result","ok");
	}else {
		obj.put("result","fail");
	}
	out.print(obj.toString());
	
%>