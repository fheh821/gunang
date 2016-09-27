<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"></script>
<%
	request.setCharacterEncoding("UTF-8");
	//insert한다 : 회원가입시 아이디를 비교하여 있으면 있는 아이디라고 해줘야한다.!!
	//내가 입력한 값 email과 DB의 내용을 비교한다. 그럼 DAO에서 email을 비교하는 메서드가 필요한가?
	
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String password = request.getParameter("password");

	// 입력란이 공백이면 다시 되돌아온다 경고창을 띄우고 싶은데 어쩌지?
	// 이메일란이 공백이거나 일치하는 정보가 존재한다면 경고창을 띄우자
	//vo의 선언과....nullpoint 에러는....
	

	/* if(name == null || name.equals("") || password == null 
	|| password.equals("") || email == null){
		System.out.println("빈칸을 채워주세요~~");
	
	
	}
	 */
	
	MemberDAO dao = new MemberDAO();
	MemberVO vo = new MemberVO(); 
	
	boolean bool = dao.checkEmail(email);
	if(bool){
		System.out.println("빈칸을 채워주세요~~");
%>

<script type="text/javascript">
$(function(){
	alert("존재하는 ID 이거나 가입형식이 아닙니다.");
	location.href = "signUp.jsp";
});
</script>
<%		

	}else{
		//회원가입 버튼을 누르고 회원가입이 완료되어지면 기본값으로 0을 입력한다. 나머지 memNo는 시퀀스값으로 들어간다.

		vo.setName(name);
		vo.setEmail(email);
		vo.setPassword(password);
		dao.insertOne(vo);
		dao.close();
	
	response.sendRedirect("login.jsp");
	}
%>
	
