<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

  <!-- CSS  -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="../css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="../css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <!--SCRIPT-->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script type="text/javascript" src="../js/materialize.min.js"></script>

<title>회원가입</title>
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
		 }else if(document.getElementById("password").value==""){
		 alert("비밀번호를 입력하세요");
		 document.getElementById("password").focus();
		 return;
		 }else if(document.getElementById("passwordcheck").value==""){
		 alert("비밀번호 확인을 입력하게나");
		 document.getElementById("passwordcheck").focus();
		 return;
		 }
 
		if(document.getElementById("password").value!=document.getElementById("passwordcheck").value){
		//비밀번호와 비밀번호확인의 값이 다를 경우
		 
		 alert("입력한 2개의 비밀번호가 일치하지 않습니다.");
		 document.getElementById("password").focus();
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
				$("#signBtn").on("click",function(){
					$("form").action = "signUpOK.jsp"; //resultview안으로 데이터를 전송한다.
					$("form").method = "post";
					$("form").submit();
				});
			});
		 
	}
</script>

<!-- 비밀번호 확인에 입력하면 옆에 버튼을 누르면 알링창으로 비밀번호가 사용이 가능한것인지 띄워준다 -->
<style type="text/css">
	  .signupForm{
	  	margin: 5% auto auto auto;
	  	width:350px;
	  	border:1px solid white;
	  }
</style>
</head>
<body class="no-pad-bot light-blue darken-4">
	<div class="signupForm grey lighten-5">
<!-- form 안의 내용을 testlogOK 로 보낸다. -->
      <form role="form" action="signUpOK.jsp" method="post">
      		<div class="row">
          		<h2 class="col s10 offset-s1 header center"><a class="grey-text text-darken-4" href="index.html"><strong>one-tack!</strong></a></h2>
				<div class="input-field col s10 offset-s1">
					<input type="text" name="name" id="name" class="form-control" placeholder="이름을 입력하세요" >
					<label for="name">사용할 이름을 입력하세요</label>
				</div>
       			<div class="input-field col s10 offset-s1">
	           		 <input type="text" name="email" id="email" class="form-control" placeholder="E-mail">
 					 <label for="email">email을 입력하세요</label>
				</div>
       			<div class="input-field col s10 offset-s1">
            		 <input type="password" name="password" id="password" class="form-control" placeholder="password를 입력하세요" autocomplete = "off" >
           			 <label for="email">password를 입력하세요</label>
				</div>
				<div class="input-field col s10 offset-s1">
					<input type="password" name="passwordcheck" id="passwordcheck" class="form-control" placeholder="password를 한번더 입력하세요" autocomplete = "off" >
           			 <label for="email">password를 한번더 입력하세요</label>
				</div>
			</div>
        <div class="row"> 
             <input type="button" id="signBtn" class="col s10 offset-s1 waves-effect waves btn green accent-4" onclick="check()" value="회원가입">
			 <br />  <br /> <br />
		</div>      
        	
      </form>
</div>
</body>
</html>