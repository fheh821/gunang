<%@page import="vo.ProjectVO"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="dao.ChatDAO"%>
<%@page import="vo.ChatVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>one-tack!</title>
<!-- CSS  -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link href="../css/materialize.css" type="text/css" rel="stylesheet"
	media="screen,projection" />
<link href="../css/style.css" type="text/css" rel="stylesheet"
	media="screen,projection" />

<!--SCRIPT-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="../js/materialize.min.js"></script>

<script type="text/javascript" src="../js/httpRequest.js"></script>


<script type="text/javascript">
<%
	int memno = (int)session.getAttribute("memno");
	int pno = (int)session.getAttribute("pno");
	
	MemberDAO mdao = new MemberDAO();
	MemberVO mvo = mdao.selectOne(memno);
	String userName = mvo.getName();
	
	ProjectDAO pdao = new ProjectDAO();
	ProjectVO pvo = pdao.selectOne(pno);
	
%>
	var data;
	
	function callback(){
		if(xhr.readyState == 4 && xhr.status == 200){
			console.log("ajax완료");
		}
	}

	$(function(){		
		$("#sendBtn").on("click", function(){
			var data = $("#messageText").val();
			var params = "pno=" + "<%=pno%>" +"&memno=" + "<%=memno%>" + "&name=" + "<%=userName%>" + "&contents=" + data;
			console.log(params);
			sendRequest("saveChat.jsp", params, callback, "GET");
			$("#messageText").val("");
		});
		
		//enter누를 때 전송  
		/*
		$("#messageText").keydown(function(e){
	        if(e.keyCode == 13){
	            e.cancelBubble = true;
	            $("#sendBtn").click();
	            return false;
	        }
	    });
		*/
	  	
	});
</script>

<style type="text/css">
#chatRoom {
	overflow: auto;
	height: 300px;
}

body {
    display: flex;
    min-height: 100vh;
    flex-direction: column;
  }

main {
    flex: 1 0 auto;
}
</style>
</head>
<body class="grey lighten-5">
	<%@ include file="../include/nav.jsp"%>
	<!-- 메시지 표시 영역 -->
	<main>
	<div class="container">
		<!-- menuNav -->
		<br />
		<h4 class="header center">
			<strong><a
				href="../project/project.jsp?pno=<%=(int)session.getAttribute("pno")%>"
				class="grey-text text-darken-3"><%=pvo.getpName() %></a></strong>
		</h4>
		<div class="row center">
			<div class="col m8 offset-m2 s12">
				<div class="col m3">
					<a href="../chatting/chatTest.jsp"
						class="waves-effect waves-light btn-large light-blue 

darken-2 z-depth-2"><i
						class="material-icons left">chat</i>채팅</a>
				</div>
				<div class="col m3">
					<a href="../board/board.jsp"
						class="waves-effect waves-light btn-large light-blue darken-2 z-depth-2"><i
						class="material-icons left">dashboard</i>보드</a>
				</div>
				<div class="col m3">
					<a href="../todo/todoGroup.jsp"
						class="waves-effect waves-light btn-large light-blue darken-2 z-depth-2"><i
						class="material-icons left">done</i>할일</a>
				</div>
				<div class="col m3">
					<a href="../checkin/checkList.jsp"
						class="waves-effect waves-light btn-large light-blue darken-2 z-depth-2"><i
						class="material-icons left">alarm_on</i>알림</a>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col m8 offset-m2 s12 white">
				<br />
				<div class="blue-grey lighten-4" id="chatRoom" id="messageTextArea">
					<ul id="chat">
						<li></li>
						<li></li>
					</ul>
				</div>
				<br />
				<div class="col m9 s12">
					<input type="text" id="messageText" />
				</div>
				<!-- 송신 버튼 -->
				<div class="col m3 s12" id="sendBtn" onclick="sendMessage()">
					<input type="button"
						class="col s10 offset-s1 waves-effect waves btn green accent-4"
						value="전송" />
				</div>
			</div>
		</div>
		<br />
		<br />
	</div>
	</main>
	<script type="text/javascript">
	  var myname = '<%=userName %>';
   		
      //웹소켓 초기화 ws://192.168.0.39:8080/project/broadsocket
      var webSocket = new WebSocket("ws://222.222.222.106:8080/project/broadsocket");
      var messageTextArea = document.getElementById("messageTextArea");
      
      var msgList = new Array;
     
      //메시지가 오면 messageTextArea요소에 메시지를 추가한다.
      webSocket.onmessage = function processMessge(message){
         //Json 풀기
         var jsonData = JSON.parse(message.data);
         
    	 var strArray = jsonData.message.split(':');
    	 var name = strArray[0].trim();
    	 var message = strArray[1].trim();
    	 
    	 var msgNode = {"name":name, "message":message};
    	 msgList.push(msgNode);
    	 
    	 for(var i=0; i<msgList.length; i++){
    		 console.log(msgList[i].name);
	    	 console.log(msgList[i].message);
    	 }
    	 
    	 if(jsonData.message != null) {
    		if(myname == name){
	    		$("#chat").append("<li style='text-align : right'><div class='chip grey lighten-5'>"+message+"</div><div class='chip white-text deep-orange darken-1'><strong>"+name+"</strong></div></li>");
	    		$("#chatRoom").scrollTop($("#chatRoom")[0].scrollHeight);
    		}else{
    			$("#chat").append("<li style='text-align : left'><div class='chip white-text blue darken-4'>"+name+"</div><div class='chip grey lighten-5'><strong>"+message+"</strong></div></li>");
	    		$("#chatRoom").scrollTop($("#chatRoom")[0].scrollHeight);
    		}
         };
      } // processMessge end
      
      // 소켓연결이 완료되면, 실행되는 함수!
      webSocket.onopen = function(){
    	  console.log("연결성공"); 
    	  <%
			// 대화목록 불러오기
			ChatDAO cdao = new ChatDAO();
			ArrayList<ChatVO> list = cdao.selectChatList(pno);
			
			for(ChatVO x : list){
				StringBuffer sbWriter = new StringBuffer();
				StringBuffer sbContents = new StringBuffer();
				sbWriter.append(x.getChatWriter());
				sbContents.append(x.getChatContents());
				
				%>
				if( myname == "<%=sbWriter.toString() %>"){
					$("#chat").append("<li style='text-align : right'><div class='chip grey lighten-5'>"+"<%=sbContents.toString() %>"+"</div><div class='chip white-text deep-orange darken-1'><strong>"+"<%=sbWriter.toString()%>"+"</strong></div></li>");
					$("#chatRoom").scrollTop($("#chatRoom")[0].scrollHeight);
				} else {
					$("#chat").append("<li style='text-align : left'><div class='chip white-text blue darken-4'>"+"<%=sbWriter.toString() %>"+"</div><div class='chip grey lighten-5'>"+"<%=sbContents.toString() %>"+"</div></li>");
					$("#chatRoom").scrollTop($("#chatRoom")[0].scrollHeight);
				}
				<%
			}
    	  %>
		// 소켓연결이 완료되면, 접속한 사람의 이름을 보내준다.
			webSocket.send(myname);
		};

		webSocket.onerror = function(event) {
			onError(event)
		};

		function onMessage(event) {
			// textarea.value += "상대 : " + event.data + "\n";
		}

		function onError(event) {
			alert(event.data);
		}
		function send() {
			webSocket.send(inputMessage.value);
			inputMessage.value = "";
		}

		//메시지 보내기
		function sendMessage() {
			var messageText = document.getElementById("messageText");
			webSocket.send(messageText.value);
		}
	</script>
	<%@include file="../include/footer.jsp"%>
</body>
</html>