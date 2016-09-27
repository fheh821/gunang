<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"></script>
<script type="text/javascript">


function closeWindow(){
	console.log("닫기링크 누름");
	window.close();
	//체크박스의 체크여부를 콘솔에 출력한다.
	document.frm.submit()
	
}

</script>

<title>Insert title here</title>

<%
String chk = request.getParameter("chk");
if(chk != null){
	Cookie c = new Cookie("popup", "no");
	c.setMaxAge(60);
	response.addCookie(c);
%>
	<script type="text/javascript">
		self.close();
	</script>
<%
}
%>
</head>
<body>
	<form action="popUp.jsp" name = "frm">
			<img src="../images/park.gif" alt="park" />
				<input type="checkbox" name="chk" id="box1"/> 다시보지 않기 
				<input type="hidden" name="flag" value = false/>
			<a href="javascript:closeWindow();">닫기</a>
			
		</form>
</body>
</html>