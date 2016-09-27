<%@page import="vo.CheckinVO"%>
<%@page import="dao.CheckinDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>one-tack!</title>
</head>
<body>
<%
	String tog = request.getParameter("switch");
	System.out.println("t:"+tog);
	String chkno = request.getParameter("checkno");
	System.out.println("c:"+chkno);
	int toggle = Integer.parseInt(tog);
	int checkno = Integer.parseInt(chkno);
	
	CheckinDAO cidao = new CheckinDAO();
	CheckinVO civo = cidao.selectOne(checkno);
	
	civo.setCheckonoff(toggle);
	cidao.checkUpdate(civo);
	

%>
</body>
</html>