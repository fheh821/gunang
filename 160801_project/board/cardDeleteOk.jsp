<%@page import="vo.CardReplyVO"%>
<%@page import="dao.CardReplyDAO"%>
<%@page import="vo.CardVO"%>
<%@page import="dao.CardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>

<% 
	String cardNo = request.getParameter("cardNo");
	CardDAO cDao = new CardDAO();
	CardVO cVo = new CardVO();
	
	CardReplyDAO crDao = new CardReplyDAO();	
	
	crDao.deleteChildReply(Integer.parseInt(cardNo));

	cDao.deleteOne(Integer.parseInt(cardNo));

	
	cDao.deleteOne(Integer.parseInt(cardNo));
	
	response.sendRedirect("board.jsp");
%>