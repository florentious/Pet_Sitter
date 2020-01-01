<%@page import="kr.co.acorn.dto.MemberDto"%>
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
	if( dao.insert(dto) && memberDao.updatePoint(sitterId, point )) {
		isSuccess = true;
	}
	// 이미 있으면 true
	
	MemberDto memberDto = memberDao.select(sitterId);
	String avgPoint = String.format("%.1f", (double)memberDto.getPoint() / (double)memberDto.getPointCount());
	String pointCountOver = null;
	if(memberDto.getPointCount() <5) {
		pointCountOver = "no";
	} else {
		pointCountOver = "yes";
	}
	
	JSONObject obj = new JSONObject();
	if(isSuccess) {
		obj.put("result","ok");
		obj.put("avgPoint",avgPoint);
		obj.put("pointCountOver",pointCountOver);
	}else {
		obj.put("result","fail");
	}
	out.print(obj.toString());
	
%>