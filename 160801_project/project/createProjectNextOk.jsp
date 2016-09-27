<%@page import="vo.ProjectMemberVO"%>
<%@page import="dao.ProjectMemberDAO"%>
<%@page import="vo.ProjectVO"%>
<%@page import="dao.ProjectDAO"%>
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
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	
	String title = request.getParameter("title");
	String info = request.getParameter("info");
	
	// 프로젝트 테이블에 넣기
	ProjectDAO pdao = new ProjectDAO();
	ProjectVO pvo = new ProjectVO(0,info,title);
	
	pdao.insertOne(pvo);
	
	// 프로젝트와 만든사람 연결하기
	int pno = pdao.getMaxPno();
	int memno = Integer.parseInt(session.getAttribute("memno").toString());
	
	ProjectMemberDAO pmdao = new ProjectMemberDAO();
	ProjectMemberVO pmvo = new ProjectMemberVO(pno, memno, 1);
	pmdao.insertOne(pmvo);
	
	response.sendRedirect("../project/projectList.jsp");
%>
</body>
</html>