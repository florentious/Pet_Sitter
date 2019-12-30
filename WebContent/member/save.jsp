
<%@page import="kr.co.acorn.dto.MemberDto"%>
<%@page import="kr.co.acorn.dao.MemberDao"%>
<%@ page pageEncoding="utf-8" %>

<% 
	request.setCharacterEncoding("utf-8"); // 한글이 깨지니까
	
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
	
	MemberDao dao = MemberDao.getInstance();
	
	MemberDto dto = new MemberDto(id, pwd, name, loc, phone, curPet, imgPath, comment, type, null, 0, 0 );
	
	boolean isSuccess = dao.insert(dto);
	
	if(isSuccess) {
	
%>
		
<script>
	alert("회원가입에 성공하셨습니다.");
	location.href="../index.jsp";
</script>
<% } else { %>
<script>
	alert("회원가입에 실패하셨습니다.");	
	history.back(-1);
</script>
<% }%>
	