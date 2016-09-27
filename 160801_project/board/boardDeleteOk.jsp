<%@page import="java.util.ArrayList"%>
<%@page import="dao.CardDAO"%>
<%@page import="vo.CardVO"%>
<%@page import="dao.BoardDAO"%>
<%@page import="vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
<%
	String boardNo = request.getParameter("boardNo");
	int pNo = (int) session.getAttribute("pno");

	BoardVO bVo = new BoardVO();
	BoardDAO bDao = new BoardDAO();
	
	CardVO cVo = new CardVO();
	CardDAO cDao = new CardDAO();
	
	int bNo = Integer.parseInt(boardNo);
	
	ArrayList<CardVO> cList = cDao.selectAll(pNo, bNo);

	if(cList.size() < 1){
		out.println("<script language='javascript'>");
		out.println("alert('삭제 되었습니다.');");
		out.println("location.href = 'board.jsp';");
		out.println("</script>");
		bDao.deleteOne(bNo);
	} else {
		out.println("<script language='javascript'>");
		out.println("alert('하위 카드 삭제 후에 삭제 가능합니다.');");
		out.println("location.href = 'board.jsp';");
		out.println("</script>");
		//response.sendRedirect("board.jsp");
	}
	
%>