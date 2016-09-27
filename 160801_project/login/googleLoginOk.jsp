<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String email = request.getParameter("email");
	String name = request.getParameter("name");
	
	MemberDAO mdao = new MemberDAO();
	// 해당하는 이메일이 테이블에 없으면 0을 리턴해준다
	int memno = mdao.searchOne(email);
	
	if(memno == 0){
		MemberVO mvo = new MemberVO(0,name,email,null,1,null);
		mdao.insertOne(mvo);
	}
	
	memno = mdao.searchOne(email);
	session.setAttribute("memno", memno);
	
	response.sendRedirect("../project/projectList.jsp");
%>