
<%@page import="kr.co.acorn.dto.MemberDto"%>
<%@page import="kr.co.acorn.dao.MemberDao"%>
<%@ page pageEncoding="utf-8" %>


<% 
	request.setCharacterEncoding("utf-8");	

	int cPage = Integer.parseInt(request.getParameter("page"));
	
	String id = request.getParameter("id");
	String pwd = request.getParameter("password");
	String name = request.getParameter("name");
	String loc = request.getParameter("loc");
	String phone = request.getParameter("phone");
	String curPet = request.getParameter("pet");
	String comment = request.getParameter("comment");
	String tempType = request.getParameter("type");
	String imgPath = request.getParameter("imgPath");
	
	byte type = (byte)0;
	
	if(tempType.equals("petSitter")) {
		type = (byte)1;
	}
	
	boolean isChangePwd = true;
	
	if(pwd == null || pwd.length() == 0) {
		isChangePwd = false;
	}
	
	boolean isChangeImg = true;
	if(imgPath == null || imgPath.length() == 0) {
		isChangeImg = false;
	}
	
	
	MemberDto dto = new MemberDto(id, pwd, name, loc, phone, curPet, imgPath, comment, type, null, 0, 0 );
	
	MemberDao dao = MemberDao.getInstance();
	
	boolean isSuccess = dao.update(dto, isChangePwd, isChangeImg);
	
	if(isSuccess) {
%>
<script>
	alert("업데이트 완료");
	location.href = "view.jsp?page=<%=cPage%>";
</script>


<%
	} else {
%>
<script>
	alert("에러났어요");
	history.back(-1)
	<%-- location.href = "view.jsp?page="+<%=cPage%>+"&no="+<%=no%>; --%>
</script>

<%
	}
%>