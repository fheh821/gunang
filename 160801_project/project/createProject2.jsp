<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
  <title>one-tack!</title>

  <!-- CSS  -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="../css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="../css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>

  <!--  Scripts-->
  <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
  <script src="../js/materialize.js"></script>
  <script src="../js/init.js"></script>
<script type="text/javascript" 
src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"> </script>
<script type="text/javascript" src="../js/httpRequest.js"></script>
<style>
#total {
	width: 1000px;
	height: 600px;
	margin: 30px auto 35px;
	text-align: center;
}

#name {
	width: 38%;
	float: left;
	text-align: center;
}

#email {
	width: 98%;
	float: left;
	text-align: center;
}

#inviteInfo {
	width: 100%;
	text-align: center;
	height: 400px;
}

input[type=text] {
	width: 50%;
	height : 40px;
	margin: 10px;
}

.btn {
	width: 200px;
	margin: 10px;
}

.btn-floating{
	width: 30px;
	height: 30px;
}

</style>
<script type="text/javascript">
	$(function(){
		$("#cancel").on("click",function(){
			history.go(-2);
		});
		
		$("#xbtn1").on("click", function(){
			$("#input1").val("");
		});
		$("#xbtn2").on("click", function(){
			$("#input2").val("");
		});
		$("#xbtn3").on("click", function(){
			$("#input3").val("");
		});
		$("#xbtn4").on("click", function(){
			$("#input4").val("");
		});
		$("#xbtn5").on("click", function(){
			$("#input5").val("");
		});
		
		
		$("input:text").keyup(function(){
			var email = $(this).val();
			var params = "email=" + email;
			sendRequest("searchMember.jsp", params, callback, "GET");
		});
		
		$("#next").on("click", function(){
			console.log("다음에하기 버튼 눌림");
			$("form")
			.attr('action','createProjectNextOk.jsp')
			.submit();
		});
		
	});
	
	function callback(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var data = xhr.responseText;
			data = data.trim();
			
			if(data == "true" ){ // 해당하는 아이디가 있을 경우
				$("#alert").text("");
			}else{ // 없을 경우
				$("#alert").text("해당하는 회원은 존재하지 않습니다.");
			}
		}
	}// callback end
	
	
	
</script>
</head>
<body class="no-pad-bot grey lighten-5">
	<%
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String title = request.getParameter("title");
		String info = request.getParameter("info");
	%>
	<%@ include file="../include/nav.jsp" %>
	<div id="total">
	<form action="createProjectOk.jsp" method="get">
		<div id="total">
			<h5><strong>초대할 팀원의 이메일을 입력해주세요</strong></h5>
			<h6>fresh rice에 등록되는 멤버들과 채팅, 할 일, 스케줄을 공유할 수 있습니다</h6>
			
			<input type="hidden" name="title" value="<%=title %>" />
			<input type="hidden" name="info" value="<%=info %>"/>
			
			<div id="inviteInfo">
			<div class="row">
				<div id="email" class="">
					<h5>e-mail</h5>
					<hr style="width:600px"/>
					<input type="text" name="email" id="input1"/> 
					<a class="btn-floating grey lighten-1" id="xbtn1"><strong>X</strong></a>
					<input type="text" name="email" id="input2"/> 
					<a class="btn-floating grey lighten-1" id="xbtn2"><strong>X</strong></a>
					<input type="text" name="email" id="input3"/> 
					<a class="btn-floating grey lighten-1" id="xbtn3"><strong>X</strong></a>
					<input type="text" name="email" id="input4"/> 
					<a class="btn-floating grey lighten-1" id="xbtn4"><strong>X</strong></a>
					<input type="text" name="email" id="input5"/> 
					<a class="btn-floating grey lighten-1" id="xbtn5"><strong>X</strong></a>
				</div>
			</div>
 				
			</div>
				<!-- 해당하는 회원이 존재하지 않습니다 알림칸 -->
				<div><h6 id="alert" class="pink-text text-accent-3"></h6></div> 
				
				<button class="col m4 offset-m4 btn waves-effect waves-light green accent-4 z-depth-1" type="submit" name="action">초대하기
   					 <i class="material-icons right">send</i>
 				</button>
 				
				<button class="col m4 offset-m4 btn waves-effect waves-light green accent-4 z-depth-1" type="submit" name="action" id="next">다음에하기
 				</button>
		</div> <!-- total end -->
	</form>
	</div>
	 <%@ include file="../include/footer.jsp" %>
</body>
</html>