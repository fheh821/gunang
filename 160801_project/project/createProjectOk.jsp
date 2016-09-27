<%@page import="dao.MemberDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.goodcode.servlet.GmailTest"%>
<%@page import="vo.ProjectMemberVO"%>
<%@page import="dao.ProjectMemberDAO"%>
<%@page import="vo.ProjectVO"%>
<%@page import="dao.ProjectDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String title = request.getParameter("title");
		String info = request.getParameter("info");
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
		
		ProjectDAO pdao = new ProjectDAO();
		ProjectVO pvo = new ProjectVO(0,info,title);
		
		pdao.insertOne(pvo);
		
		// 방금 들어간 프로젝트의 pno값 가져오기
		int pno = pdao.getMaxPno();
		
		int memno = Integer.parseInt(session.getAttribute("memno").toString());
				
		// 프로젝트 생성한 사람과 프로젝트를 연결해주기
		ProjectMemberDAO pmdao = new ProjectMemberDAO();
		ProjectMemberVO pmvo = new ProjectMemberVO(pno, memno, 1);
		pmdao.insertOne(pmvo);
		
		// 프로젝트에 초대된 사람들과 프로젝트 연결해주기
		MemberDAO mdao = new MemberDAO();
		
		// 초대받은 애들의 memno 가져오기
		for(int p = 0; p < emails.length; p++){
			pmvo = new ProjectMemberVO(pno, mdao.searchOne(emails[p]), 1);
			pmdao.insertOne(pmvo);
		}

		GmailTest.main(emails);
		
		response.sendRedirect("../project/projectList.jsp");
	%>
