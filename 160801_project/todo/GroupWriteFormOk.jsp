<%@page import="sun.nio.cs.HistoricallyNamedCharset"%>
<%@page import="dao.ProjectMemberDAO"%>
<%@page import="vo.ProjectMemberVO"%>
<%@page import="dao.TodoGroupDAO"%>
<%@page import="vo.TodoGroupVO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="vo.ProjectVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String groupTitle = request.getParameter("input_text");
	String groupContents = request.getParameter("editor1");
	String groupColor = request.getParameter("color");
	
	// 색깔정보는 ... varchar2로 가지고 있어서, 속성값 바꿔줄 때 string타입으로 넣어줘도 편할거같다는 생각이 문득 든다.
	// 아아 생각이 문득들었군
	// todo그룹안에 위의 내용을 insert해야한다.
	TodoGroupDAO tgdao = new TodoGroupDAO();
	TodoGroupVO tgvo = new TodoGroupVO();
	
	// 카드를 생성하기위해서는 프로젝트번호와 멤버의 번호를 비교해야한다!!
	// 근데 이미 session이나 주소창에 둘다 넘겨주나? 그런건없군.. 그럼 session안에 값이 담겨있나?
	// 아래의 코드를 이용하여 session안에 담긴 memno를 확인 할수있었다 
	// 타이틀 컬러 컨텐츠를 작성하고 글쓰기 버튼을 누르면 알 수 있다. 서버가 켜져있는 동안에는 session이 유지된다. 
	int memno = Integer.parseInt(session.getAttribute("memno").toString());
	System.out.println("TestGrouMemno : " + memno);
	int pno = Integer.parseInt(session.getAttribute("pno").toString());
	System.out.println("TestGroupPno : " + pno);
	
	tgvo.setpNo(pno);
	tgvo.setMemNo(memno);
	tgvo.setGroupTitle(groupTitle);
	tgvo.setGroupContents(groupContents);
	tgvo.setGroupColor(groupColor);
	
	//왜? 무결성 제약조건이 위배된다고 나오지???
	
	tgdao.insertOne(tgvo);
	//tgvo.setGroupNo(groupNo)는 입력하지 않은면 자동으로 작성된다.
	
	// session에 저장되어있는 pno와 memno를 가져와서 
	// todoGroup 테이블에 넣어주면 되겠군!! 그렇군!!
	
	response.sendRedirect("todoGroup.jsp");
%>