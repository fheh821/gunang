<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 초대할 메일 주소를 입력하면, 해당하는 회원이 있는지 검색
	String email = request.getParameter("email");
	MemberDAO dao = new MemberDAO();
	int memno = dao.searchOne(email);
	boolean flag = false;
	
	if(memno != 0){
		flag = true;
	}
	
	if(flag || email.equals("") || email == null){ // 해당하는 아이디가 있다면!!
		out.println("true");
	}else{
		out.println("false");
	}
	
%>