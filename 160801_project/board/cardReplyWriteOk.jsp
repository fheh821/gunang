<%@page import="vo.CardReplyVO"%>
<%@page import="dao.CardReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
<%
	String cardNo = request.getParameter("cardNo");
	String pNo = request.getParameter("pNo");
	String boardNo = request.getParameter("boardNo");
	String cardReplyContents = request.getParameter("cardReplyContents");
	String cardReplyWriter = request.getParameter("cardReplyWriter");
	String url = request.getParameter("url");
	
	CardReplyDAO crDao = new CardReplyDAO();
	CardReplyVO crVo = new CardReplyVO();
	
	crVo.setCardNo(Integer.parseInt(cardNo));
	crVo.setpNo(Integer.parseInt(pNo));
	crVo.setBoardNo(Integer.parseInt(boardNo));
	crVo.setCardReplyContents(cardReplyContents);
	crVo.setCardReplyWriter(cardReplyWriter);
	
	crDao.insertOne(crVo);
	
	response.sendRedirect("cardDetail.jsp?boardNo="+boardNo+"&cardNo="+cardNo);
%>	    
	    
	    