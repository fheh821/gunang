<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
/* 이곳에서 스크립트를 이용하여 공백을 검사한다. */
//이메일주소 유효성 체크


	

function check(){
 
 if(document.getElementById("name").value==""){ //id값이 없을 경우
 alert("이름을 입력하세요");         //메세지 경고창을 띄운 후
 document.getElementById("name").focus();// id 텍스트박스에 커서를 위치
 return;
 }else if(document.getElementById("email").value==""){
 alert("이메일을 입력하세요");
 document.getElementById("email").focus();
 return;
 }else if(document.getElementById("pw").value==""){
 alert("비밀번호를 입력하세요");
 document.getElementById("pw").focus();
 return;
 }else if(document.getElementById("pwcheck").value==""){
 alert("비밀번호 확인을 입력하게나");
 document.getElementById("pwcheck").focus();
 return;
 }
 
 
 if(document.getElementById("pw").value!=document.getElementById("pwcheck").value){
 //비밀번호와 비밀번호확인의 값이 다를 경우
 
 alert("입력한 2개의 비밀번호가 일치하지 않습니다.");
 document.getElementById("pw").focus();
 return;

 }
 
 
 var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
 
 if(exptext.test(document.getElementById("email").value)==false){
 //이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우

 
 alert("이 메일형식이 올바르지 않습니다.");
 document.getElementById("email").focus();
 return;
 }
 
 $(function(){
		$("input[value = '회원가입']").on("click",function(){
			$("form").action = "registerOK.jsp"; //resultview안으로 데이터를 전송한다.
			$("form").method = "post";
			$("form").submit();
		});
	});
 
}

</script>



<!-- 비밀번호 확인에 입력하면 옆에 버튼을 누르면 알링창으로 비밀번호가 사용이 가능한것인지 띄워준다 -->
<style type="text/css">
table,th{
margin: 0 auto;
border: 1px solid black;
border-collapse: collapse;
text-align: center;
}
table{
width: 300px;
height: 400px;
background-color: #eeeeee;
}

</style>

</head>
<body>
<form action="registerOK.jsp">
	<table>
	<caption><h1>FRESHRICE SIGNIN</h1></caption>
		<tr>
			<td>이름</td>
			<td><input type="text" name="name" id="name" /></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input type="text" name="email" id="email" /></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="pw" id="pw" /></td>
		</tr>
		<tr>
			<td>비밀번호 확인</td>
			<td><input type="password" name="pwcheck" id="pwcheck" /></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" value="회원가입" id="join" onclick="check()"/>
			</td>
		</tr>
	</table>
		</form>
</body>
</html>