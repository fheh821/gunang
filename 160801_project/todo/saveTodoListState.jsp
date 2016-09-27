<%@page import="dao.TodoListDAO"%>
<%@page import="dao.TodoGroupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 체크박스 체크할때마다, isComplete의 값을 바꿔주는 jsp파일!!
	String no = request.getParameter("listno");
	String flag = request.getParameter("isComplete");
	System.out.println("no : " + no + "flag : " + flag);
	int listno = Integer.parseInt(no);
	int isComplete = 0;
	if(flag.equals("true")) isComplete = 1;

	System.out.println("listno : " + listno + " isComplete : " + isComplete);
	TodoListDAO dao = new TodoListDAO();
	dao.updateIsComplete(listno, isComplete);	
%>