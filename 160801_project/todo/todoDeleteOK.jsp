<%@page import="vo.TodoListVO"%>
<%@page import="dao.TodoListDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	String list = request.getParameter("listno");
	int listno = Integer.parseInt(list);
	if(list == null || list.equals("")){
		response.sendRedirect("index.jsp");
	}
	TodoListDAO listdao = new TodoListDAO();
	TodoListVO listvo = listdao.selectOne(listno);
	
	
	listvo.getListTitle();
	listvo.getListContents();
	listvo.getStartDate();
	listvo.getEndDate();
	
	listdao.deletOne(listno);
	
	response.sendRedirect("todoList.jsp?groupno="+listvo.getGroupNo());

%>