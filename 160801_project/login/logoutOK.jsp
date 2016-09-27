<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- 사용자에게 보여줄 내용이 없는부분 -->
<%
	session.invalidate();
	//기존의 session을 폐기하고 새로운 session을 만들어준다.
	response.sendRedirect("index.jsp");
%>