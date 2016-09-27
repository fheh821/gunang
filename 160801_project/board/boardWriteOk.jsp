<%@page import="vo.BoardVO"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

String boardTitle = request.getParameter("boardTitle");

//session -> pno
int pNo = (int)session.getAttribute("pno");

//session -> memno
int memNo = (int)session.getAttribute("memno"); 

BoardDAO dao = new BoardDAO();
BoardVO vo = new BoardVO();

vo.setBoardTitle(boardTitle);
vo.setpNo(pNo);
vo.setMemNo(memNo);
dao.insertOne(vo);
response.sendRedirect("board.jsp");
%>