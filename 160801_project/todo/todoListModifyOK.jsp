
<%@page import="vo.TodoListVO"%>
<%@page import="dao.TodoListDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		//modify안에서 listno를 넘겨주는 값을 이용하여 작성한다. 업데이트하는 메소드가 필요하다.
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String list = request.getParameter("listno");
		int listno = Integer.parseInt(list);
		if(list == null || list.equals("")){
			
		response.sendRedirect("index.jsp");
		
		}else{
			
		TodoListDAO listdao = new TodoListDAO();
		TodoListVO listvo = listdao.selectOne(listno);
		//modify안의 parameter값을 불러온다.
		
		String listTitle = request.getParameter("input_text");
		String listContents = request.getParameter("editor1");
		String startDate = request.getParameter("datepicker1");
		String endDate = request.getParameter("datepicker2");
		
		listvo.setListTitle(listTitle);
		listvo.setListContents(listContents);
		listvo.setStartDate(startDate);
		listvo.setEndDate(endDate);
		
		listdao.updateOne(listvo);
		
		response.sendRedirect("todoListDetail.jsp?listNo="+listvo.getListNo());
		}

%>