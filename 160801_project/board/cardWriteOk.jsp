<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="vo.CardVO"%>
<%@page import="dao.CardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
<%

String boardNo = request.getParameter("boardNo");
String cardTitle = request.getParameter("cardTitle");
String cardContents = request.getParameter("cardContents");

//session -> memno
int memNo = (int)session.getAttribute("memno");
int pNo = (int)session.getAttribute("pno");


//CardWriter를 지정하기 위해 MemberDAO, VO 선언
MemberDAO mDao = new MemberDAO();
MemberVO mVo = new MemberVO();
mVo = mDao.selectOne(memNo);
String cardWriter = mVo.getName();


CardDAO cDao = new CardDAO();
CardVO cVo = new CardVO();
//Card를 insert하기 위해 필요한 값 set;
cVo.setBoardNo(Integer.parseInt(boardNo));
cVo.setpNo(pNo);
cVo.setMemNo(memNo);
cVo.setCardTitle(cardTitle);
cVo.setCardContents(cardContents);
cVo.setCardWriter(cardWriter);

cDao.InsertOne(cVo);

response.sendRedirect("board.jsp");
%>