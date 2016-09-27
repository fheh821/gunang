<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="vo.CheckreplyVO"%>
<%@page import="dao.CheckreplyDAO"%>
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
	String smemno = session.getAttribute("memno").toString();// 멤버번호 pasing
	String spno = session.getAttribute("pno").toString();// 멤버번호 pasing
	int memno = Integer.parseInt(smemno);
	int pno = Integer.parseInt(spno);
	
	MemberDAO mdao = new MemberDAO();
	MemberVO mvo = mdao.selectOne(memno);
	

	String cno = request.getParameter("cno");
	String contents = request.getParameter("addreply");
	System.out.println(cno+" "+contents);
	
	CheckreplyDAO crdao = new CheckreplyDAO();
	CheckreplyVO crvo = new CheckreplyVO();

	crvo.setCheckno(Integer.parseInt(cno));
	crvo.setPno(1);
	crvo.setCheckreplycontents(contents);
	crvo.setCheckreplywriter(mvo.getName());
	crdao.checkReplyInsert(crvo);
	
	response.sendRedirect("checkDetail.jsp?cno="+cno);

%>
</body>
</html>