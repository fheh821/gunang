<%@page import="vo.TodoListVO"%>
<%@page import="dao.TodoListDAO"%>
<%@page import="vo.TodoGroupVO"%>
<%@page import="dao.TodoGroupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//앞에서 보내오는 groupno 받기
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	int pNo = Integer.parseInt(session.getAttribute("pno").toString());
	
	String gNo = request.getParameter("groupno");
	int groupno = Integer.parseInt(gNo);
	if(gNo == null || gNo.equals("")){
		response.sendRedirect("index.jsp");
	}else{
	TodoGroupDAO groupdao = new TodoGroupDAO();
	TodoGroupVO groupvo = groupdao.selectOne(groupno);
	TodoListDAO listdao = new TodoListDAO();
	TodoListVO listvo = listdao.selectOne(pNo);
	
	
	String groupTitle = request.getParameter("input_text");
	String groupContents = request.getParameter("editor1");
	String groupColor = request.getParameter("color");
	
	groupvo.setGroupTitle(groupTitle);
	groupvo.setGroupContents(groupContents);
	groupvo.setGroupColor(groupColor);
	/* System.out.println("groupTitle : " + groupTitle);
	System.out.println("groupContents : " + groupContents);
	System.out.println("groupColor : " + groupColor); */
	
	groupdao.updateOne(groupvo);
	response.sendRedirect("todoList.jsp?groupno="+groupvo.getGroupNo());
	}
%>