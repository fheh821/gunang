<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<%
	//login page에서보내는 값을 가지고 DB안의 데이터와 비교하여 로그인을 시도한다.
	String email = request.getParameter("inputEmail");
	String password = request.getParameter("inputPassword");
	
	MemberDAO dao = new MemberDAO();
	MemberVO vo = dao.Glogin(email, password);
	dao.close();
	if(vo != null){
		session.setAttribute("email", vo.getEmail());
		session.setAttribute("password", vo.getPassword());
		
		////////메인으로 넘어갈때 사용자는 멤버번호를 가지고 메인으로 이동한다 ==> 선미 /////
				
		session.setAttribute("memno", vo.getMemNo());
		response.sendRedirect("../project/projectList.jsp");
		///////////////////////////////////////////////////////////////////////
		
		
		//response.sendRedirect("testMain.jsp?memNo="+vo.getMemNo());
		//위에서 받아온 아이디와 비밀번호를 DB와 비교하여 로그인이 성공되면 main page안으로 들어간다.
		
	%>
	
	<%
		
	}else{
		%>
		<script type="text/javascript">
		window.onload = function(){
			alert("아이디와 비밀번호가 일치하지 않습니다.");
			location.href = "login.jsp";
		}
		</script>

		<%
		}
		%>
	
</body>
</html>