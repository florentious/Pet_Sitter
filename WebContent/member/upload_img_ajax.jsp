<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Calendar"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page contentType="application/json; charset=utf-8" %>

<%
	request.setCharacterEncoding("utf-8");	
	
	boolean isSuccess = false;
	 
	String path = request.getRealPath("/upload/file");
	Calendar c = Calendar.getInstance();
	int year = c.get(Calendar.YEAR);
	int month = c.get(Calendar.MONTH)+1;
	path += File.separator + year + File.separator + month;
	
	String contextPath = request.getContextPath();
	 
	 
	//String path = "D:/dev/workspace/Pet_Sitter/img/";
	File f = new File(path);
	if(!f.exists()) {
		f.mkdirs();
	}
	
	MultipartRequest multi = null;
	try {
		multi = new MultipartRequest(
				request,	
				path,							// upload할 디렉토리
				10*1024*1024,					// 업로드할 파일 최대크기
				"utf-8",						// 인코딩 타입
				//파일이이름이 중복되었을떄 파일명 끝에 1,2,3, 순으로 숫자 붙여주는 클래스
				new DefaultFileRenamePolicy()
				);
		isSuccess = true;
	}catch(Exception e) {
		e.printStackTrace();
	}
	
	String fileName =  multi.getFilesystemName("img");
	
	String imgPath =  contextPath + "/upload/file/"+ year+ "/" + month  + "/" + fileName;
	String absPath = path + "/"+ fileName;
	
	JSONObject obj = new JSONObject();
	if(isSuccess) {
		obj.put("path",imgPath);
		obj.put("absPath", absPath);
	}else {
		obj.put("result","fail");
	}
	out.print(obj.toString());
%>