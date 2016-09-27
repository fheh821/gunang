<%@page import="kr.co.goodcode.servlet.GmailTest"%>
<%@page import="vo.ProjectMemberVO"%>
<%@page import="dao.ProjectMemberDAO"%>
<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String[] e = request.getParameterValues("email");
	String[] emails = new String[10];
	
	// 받아온 메일 주소 중... 빈칸인 애는 제외하기위해서
	int i = 0;
	while(i < e.length){
		if(e[i].equals("")){
			break;			
		}
		emails[i] = e[i];
		i++;
	}
	
	int pno = Integer.parseInt(session.getAttribute("pno").toString());
	ProjectMemberDAO pmdao = new ProjectMemberDAO();
	MemberDAO mdao = new MemberDAO();
	
	// 프로젝트에 초대된 사람들과 프로젝트 연결해주기
	for(int k = 0; k < emails.length; k++){
		ProjectMemberVO pmvo = new ProjectMemberVO(pno, mdao.searchOne(emails[k]), 1);
		pmdao.insertOne(pmvo);
	}
	
	GmailTest.main(emails);

	response.sendRedirect("../project/project.jsp?pno=" + pno);
	
%>