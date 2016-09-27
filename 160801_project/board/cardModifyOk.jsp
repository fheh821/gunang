<%@page import="vo.CardVO"%>
<%@page import="dao.CardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
<%
	String boardNo =request.getParameter("boardNo");
	String cardNo = request.getParameter("cardNo");
	String cardContents = request.getParameter("cardContents");
	String cardTitle = request.getParameter("cardTitle");
	
	CardDAO cDao = new CardDAO();
	CardVO cVo = new CardVO();
	
	int cno = Integer.parseInt(cardNo);
	cDao.updateOne(cno, cardTitle, cardContents);
	
	response.sendRedirect("cardDetail.jsp?boardNo="+boardNo+"&cardNo="+cardNo);
%>