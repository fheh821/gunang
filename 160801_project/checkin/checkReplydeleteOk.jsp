<%@page import="dao.CheckreplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>one-tack!</title>
</head>
<body>
<%
	String replyno = request.getParameter("replyno");
	System.out.println(replyno);
	String b = request.getParameter("cno");
	System.out.println(b);
	int cno=0;
	
 	if (!(replyno == null || replyno.equals(""))) {
	
 		int checkreplyno = Integer.parseInt(replyno);
 		cno = Integer.parseInt(b);
		CheckreplyDAO crdao = new CheckreplyDAO();
		crdao.checkReplyDelete(checkreplyno);

	}
	response.sendRedirect("checkDetail.jsp?cno="+cno);
	
%>
</body>
</html>