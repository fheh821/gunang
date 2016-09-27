<%@page import="vo.ProjectMemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProjectMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int pno = Integer.parseInt(request.getParameter("pno"));
	int memno = Integer.parseInt(session.getAttribute("memno").toString());

	ProjectMemberDAO pmdao = new ProjectMemberDAO();
	
	ProjectMemberVO pmvo = new ProjectMemberVO(memno, pno, 0);
	
	pmdao.updateOne(pmvo);
	
	response.sendRedirect("projectList.jsp");
%>