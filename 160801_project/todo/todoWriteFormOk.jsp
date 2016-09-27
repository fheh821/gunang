
<%@page import="vo.TodoGroupVO"%>
<%@page import="dao.TodoGroupDAO"%>
<%@page import="vo.TodoListVO"%>
<%@page import="dao.TodoListDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");	
	String gNo = request.getParameter("gruopno");
	int gruopno = Integer.parseInt(gNo);
	
	TodoGroupDAO gruopdao = new TodoGroupDAO();
	TodoGroupVO gruopvo = gruopdao.selectOne(gruopno);
	
	int pNo = Integer.parseInt(session.getAttribute("pno").toString());
	
	if(gNo == null || gNo.equals("")){
		response.sendRedirect("index.jsp");
	}else{
		
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");	
	String listTitle = request.getParameter("title");
	String listContents = request.getParameter("editor1");
	String startDate = request.getParameter("start");
	String endDate = request.getParameter("end");
	
		TodoListDAO dao = new TodoListDAO();
		TodoListVO vo = new TodoListVO();
		
		vo.setGroupNo(gruopno);
		vo.setpNo(pNo);
		
		vo.setListTitle(listTitle);
		vo.setListContents(listContents);
		vo.setStartDate(startDate);
		vo.setEndDate(endDate);
		vo.setIsComplete(0);

		dao.insertOne(vo);
		//start랑 end가 둘다 null 이면 기한없음?? 이니깐... 아마 괜찮을거야-희정
		
		response.sendRedirect("todoList.jsp?groupno="+gruopvo.getGroupNo());
		
	}
	
%>