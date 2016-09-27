<%@page import="dao.CheckAlarmDAO"%>
<%@page import="vo.CheckinVO"%>
<%@page import="dao.CheckinDAO"%>
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
	String b = request.getParameter("cno");
	System.out.println(b);
	
 	if (!(b == null || b.equals(""))) {
	
 		int checkno = Integer.parseInt(b);
		CheckAlarmDAO cadao = new CheckAlarmDAO();
		CheckinDAO cidao = new CheckinDAO();
		int checkmemno = cadao.getcheckNum(checkno);
		cadao.deleteOne(checkmemno);
		cidao.checkDelete(checkno);		
	}
	response.sendRedirect("checkList.jsp"); 
	
%>
</body>
</html>