<%@page import="vo.TodoListVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.TodoListDAO"%>
<%@page import="vo.TodoGroupVO"%>
<%@page import="dao.TodoGroupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");   
	// session에 저장되어 있는 pno 가져오기
	int pno = Integer.parseInt(session.getAttribute("pno").toString());
	// session에 저장되어있는 gno가져오기

	String group = request.getParameter("groupno");
	int groupno = Integer.parseInt(group);
	//리스트를 먼저 삭제해야 그룹도 삭제 가능함
	TodoListDAO listdao = new TodoListDAO();
	ArrayList<TodoListVO> list = listdao.selectAll(groupno, pno); 
	
	for(TodoListVO vo : list){
		listdao.deletOne(vo.getListNo());
	}
	
	TodoGroupDAO groupdao = new TodoGroupDAO();
	TodoGroupVO groupvo = groupdao.selectOne(groupno);
	
	groupdao.deleteOne(groupno);
	
	response.sendRedirect("todoGroup.jsp");
%>