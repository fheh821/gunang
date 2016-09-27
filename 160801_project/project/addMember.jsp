<%@page import="vo.ProjectVO"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProjectMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	/* width: 1000px;
	height: 600px;*/
	margin-top: 30px; 
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
	width: 70%;
	margin: 10px;
}

.btn {
	width: 200px;
	margin: 30px;
}

.btn-floating{
	width: 30px;
	height: 30px;
}
#left{
	margin-top: 50px; 
	border-right: 1px solid lightgrey;
	height: 600px;
	text-align: center;
	padding-right: 100px;
}
ul{
	text-align: left;
}
a{
	color: black;
}
#container{
	width: 1000px;
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
<body>
	<%@ include file="../include/nav.jsp" %>
	
	<%
		int pno = Integer.parseInt(session.getAttribute("pno").toString());
		
		ProjectMemberDAO pmdao = new ProjectMemberDAO();
		ArrayList<Integer> list = pmdao.selectAllMember(pno);
		
		MemberDAO mdao = new MemberDAO();
		ProjectDAO pdao = new ProjectDAO();
		ProjectVO pvo = pdao.selectOne(pno);
	%>	
	<div id="container" class="row">
	
		<div class="col s5" id="left">
			<h5 class="pname"><a href="project.jsp?pno=<%=pno%>"><%=pvo.getpName() %></a></h5>
			<h6>참여중인 팀원</h6>
			<br />
			 <ul class="collection">
			 	<%
			 		for(int i = 0; i < list.size(); i++){
			 			MemberVO mvo = new MemberVO();
			 			mvo = mdao.selectOne(list.get(i));
			 	%>
    	    	<li class="collection-item avatar">
    		    <img src="<%=mvo.getIcon() %>" alt="images" class="circle">
                <span class="title"><%=mvo.getName() %></span>
                <p><%=mvo.getEmail() %><br> </p>
                </li>
                <% 
                	} // for end			 		
			 	%>
            </ul>
          
		</div> <!-- 왼쪽 div end -->
		
		<!-- 오른쪽 div -->
		<div id="total" class="col s6 offset-s1">
		<form action="addMemberOk.jsp" method="get">
			<div id="total">
				<h5>초대할 팀원의 이메일을 입력해주세요</h5>
				<h6>fresh rice에 등록되는 멤버들과 채팅, 할 일, 스케쥴을 공유할 수 있습니다</h6>
				
				<div id="inviteInfo">
					<div id="email">
						<h5>e-mail</h5>
						<hr />
						<input type="text" name="email" id="input1"/> 
						<a class="btn-floating grey lighten-1" id="xbtn1">X</a>
						<input type="text" name="email" id="input2"/> 
						<a class="btn-floating grey lighten-1" id="xbtn2">X</a>
						<input type="text" name="email" id="input3"/> 
						<a class="btn-floating grey lighten-1" id="xbtn3">X</a>
						<input type="text" name="email" id="input4"/> 
						<a class="btn-floating grey lighten-1" id="xbtn4">X</a>
						<input type="text" name="email" id="input5"/> 
						<a class="btn-floating grey lighten-1" id="xbtn5">X</a>
					</div>
					
				</div>
					<!-- 해당하는 회원이 존재하지 않습니다 알림칸 -->
					<div><h6 id="alert" class="pink-text text-accent-3"></h6></div> 
					
					<button class="btn waves-effect waves-light" type="submit" name="action">초대하기
	   					 <i class="material-icons right">send</i>
	 				</button>
			</div> <!-- total end -->
		</form>
		</div>
	</div> <!-- container end -->
	 <%@ include file="../include/footer.jsp" %>
</body>
</html>