
<%@page import="kr.co.acorn.dto.MemberDto"%>
<%@page import="kr.co.acorn.dao.MemberDao"%>
<%@ page pageEncoding="utf-8" %>


<% 
	request.setCharacterEncoding("utf-8");	

	int cPage = Integer.parseInt(request.getParameter("page"));
	
	String tempEmail = request.getParameter("tempEmail");
	
	String email = request.getParameter("email");
	String name = request.getParameter("name");
	String pwd = request.getParameter("password");
	String phone = request.getParameter("phone");
	
	boolean isChangePwd = true;
	
	if(pwd == null || pwd.length() == 0) {
		isChangePwd = false;
	}
	
	
	MemberDto dto = new MemberDto(email,name, pwd, phone);
	
	MemberDao dao = MemberDao.getInstance();
	
	boolean isSuccess = dao.update(dto,tempEmail,isChangePwd);
	
	if(isSuccess) {
%>
<script>
	alert("Update Success");
	location.href = "view.jsp?page=<%=cPage%>&email=<%=email%>";
</script>


<%
	} else {
%>
<script>
	alert("DataBase Error");
	history.back(-1)
	<%-- location.href = "view.jsp?page="+<%=cPage%>+"&no="+<%=no%>; --%>
</script>

<%
	}
%>