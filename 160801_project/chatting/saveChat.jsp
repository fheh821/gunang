<%@page import="dao.ChatDAO"%>
<%@page import="vo.ChatVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String p = request.getParameter("pno");
	String m = request.getParameter("memno");
	String name = request.getParameter("name");
	String contents = request.getParameter("contents");
	
	int pno = Integer.parseInt(p);
	int memno = Integer.parseInt(m);
	
	ChatDAO dao = new ChatDAO();
	ChatVO vo = new ChatVO(0, pno, memno, name, contents, "16/07/26");
	
	dao.insertOne(vo);
%>