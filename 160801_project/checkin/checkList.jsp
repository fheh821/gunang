<%@page import="vo.ProjectVO"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="com.sun.javafx.scene.layout.region.SliceSequenceConverter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.CheckinVO"%>
<%@page import="dao.CheckinDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>one-tack!</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>

  <!-- CSS  -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="../css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="../css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>

  <!--  Scripts-->
  <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
  <script src="../js/materialize.js"></script>
  <script src="../js/init.js"></script>
<style type="text/css">

	.toggle-switch {
	width: 80px;
	height: 44px;
	position: relative;
	display: inline-block;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	-o-user-select: none;
	user-select: none;
	-webkit-border-radius: 9999px;
	-moz-border-radius: 9999px;
	border-radius: 9999px;
	cursor: pointer

	}
	
	.toggle-switch .toggle-handler {
	
		width: 40px;
		height: 40px;
		position: absolute;
		-webkit-border-radius: 80px;
		-moz-border-radius: 80px;
		border-radius: 80px;
		top: 0;
		-webkit-transition: all .2s ease-out;
		-moz-transition: all .2s ease-out;
		-o-transition: all .2s ease-out;
		transition: all .2s ease-out
	}
	
	
	.toggle-switch .toggle-bg-on {
		width: 80px;
		height: 40px;
		background-color: #78b5e6;
		-webkit-border-radius: 9999px;
		-moz-border-radius: 9999px;
		border-radius: 9999px;
		position: absolute;
		top: 0;
		left: 0;
		-webkit-transition: all .2s ease-out;
		-moz-transition: all .2s ease-out;
		-o-transition: all .2s ease-out;
		transition: all .2s ease-out;
		transform-origin: 0 50%
	}
	
	.toggle-switch .toggle-bg-on {
	  width: 80px;
	  height: 40px;
	  background-color: #78b5e6;
	  -webkit-border-radius: 9999px;
	  -moz-border-radius: 9999px;
	  border-radius: 9999px;
	  position: absolute;
	  top: 0;
	  left: 0;
	  -webkit-transition: all .2s ease-out;
	  -moz-transition: all .2s ease-out;
	  -o-transition: all .2s ease-out;
	  transition: all .2s ease-out;
	  transform-origin: 0 50%
	}
	
	.toggle-switch.toggle-off .toggle-handler {
	  background-color: #f1f1f1;
	  -webkit-transform: translateX(0);
	  -moz-transform: translateX(0);
	  -ms-transform: translateX(0);
	  -o-transform: translateX(0);
	  transform: translateX(0);
	  left: 0
	}
	
	.toggle-switch.toggle-off .toggle-bg-on {
	  visibility: hidden;
	  opacity: .4;
	  -webkit-transform: scale(.8);
	  -moz-transform: scale(.8);
	  -ms-transform: scale(.8);
	  -o-transform: scale(.8);
	  transform: scale(.8);
	  width: 50%
	}
	
	.toggle-switch.toggle-on .toggle-handler {
	  background-color: #fff;
	  -webkit-transform: translateX(40px);
	  -moz-transform: translateX(40px);
	  -ms-transform: translateX(40px);
	  -o-transform: translateX(40px);
	  transform: translateX(40px);
	  -webkit-box-shadow: 1px 1px 2px #ccc;
	  -moz-box-shadow: 1px 1px 2px #ccc;
	  box-shadow: 1px 1px 2px #ccc
	}
	
	.toggle-switch.toggle-on .toggle-bg-on {
	  visibility: visible;
	  -webkit-transform: scale(1);
	  -moz-transform: scale(1);
	  -ms-transform: scale(1);
	  -o-transform: scale(1);
	  transform: scale(1);
	  opacity: 1;
	  width: 100%
	}
	
	*{
		margin:0;
	}
	
	.checkList{
		width: 80%;
		margin: 20px;
		/* border: black solid 1px; */
	}
	
	.onelist{
		margin: 1% 10% 5% 10%;	
		border-radius: 30px;
		width:100%;
	}
	
	.addbtn{
		margin: 2% 45%;
	}
	
	#checkList_left{
		width: 50%;
		height: 100%;
		//border: black solid 1px;
		float : left;
	}
	#checkList_middle{
		width: 30%;
		height: 100%;
		//border: black solid 1px;
		float : left;
	}
	#checkList_right{
		width: 18%;
		height: 100%;
		//border: black solid 1px;
		float : left;
	}
	
	
	#menu{
		margin: 0% 20%;
	}
	
	h1{
	font-weight: bold;
	text-align: center;
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
<script src="//cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"></script>
<script type="text/javascript">
<%
if(request.getParameter("flag")!=null){
	if(request.getParameter("flag").equals("true")){
		response.sendRedirect("checkList.jsp");
	}
}

	String smemno = session.getAttribute("memno").toString();// 멤버번호 pasing
	String spno = session.getAttribute("pno").toString();// 멤버번호 pasing
	int memno = Integer.parseInt(smemno);
	int pno = Integer.parseInt(spno);
	

%>
$(function(){
	var count=0;
	$("#btn").click(function(){
		
	})	
		
/* 		count++;
		var btnName = "btn" + count;
		$("#menu").prepend("<div id='div"+count+"'>newmenu"+count+"</br>"+"추가하기!"+"<input type='button' id='btn"+ count +"' value='삭제'/></div>");		
 */
/* 
	function remove(num){
		console.log("삭제");
	} */

});
(function($) {
	$.fn.extend({
	toggleSwitch: function(){
	

	$('.toggle-switch').on('click',function(){
		var toggle;
		var checkno = $(this).attr("id");
		
		if($(this).hasClass('toggle-off')){
			toggle = 1;
			$(this).removeClass('toggle-off').addClass('toggle-on');
		}else{
			toggle = 0;
			$(this).removeClass('toggle-on').addClass('toggle-off');
		}
		var sendData = 'switch=' + toggle;
		var checkstr = '&checkno='+checkno;
		sendData += checkstr;
		$.post("checkSwitch.jsp", sendData);
	})

	}
	})
	})(jQuery)

	$(document).ready(function(){
	$('.toggle-switch').toggleSwitch();
	});

</script>
</head>
<body class="body grey lighten-5">
<%@ include file="../include/nav.jsp" %>
<main>
<div class="container">


<!-- <input type="button" value="+" id="btn"></a> -->

<!-- menuNav --> 
<%

	ProjectDAO pdao = new ProjectDAO();
	ProjectVO pvo = pdao.selectOne(pno);
%>
		<br />
		<h4 class="header center"><strong><a href="../project/project.jsp?pno=<%=(int)session.getAttribute("pno")%>" class="grey-text text-darken-3"><%=pvo.getpName() %></a></strong></h4>
			<div class="row center">
				<div class="col m8 offset-m2 s12">
					<div class="col m3">
						<a href="../chatting/chatTest.jsp" class="waves-effect waves-light btn-large light-blue darken-2 z-depth-2"><i class="material-icons left">chat</i>채팅</a>
					</div>
						<div class="col m3">
							<a href="../board/board.jsp" class="waves-effect waves-light btn-large light-blue darken-2 z-depth-2"><i class="material-icons left">dashboard</i>보드</a>
						</div>
						<div class="col m3">
							<a href="../todo/todoGroup.jsp" class="waves-effect waves-light btn-large light-blue darken-2 z-depth-2"><i class="material-icons left">done</i>할일</a>
						</div>
					<div class="col m3">
						<a href="../checkin/checkList.jsp" class="waves-effect waves-light btn-large light-blue darken-2 z-depth-2"><i class="material-icons left">alarm_on</i>알림</a>
					</div>
				</div>
			</div>





<div class="row" id="menu" style="margin-left: 110px; margin-bottom:0px;">
<div style="margin-left: 80px; margin-top:0px;">
 <a href="checkWrite.jsp"class="btn-floating btn-large waves-effect red accent-4 addbtn"><i class="material-icons">add</i></a>
</div> 
	<div class="col m12 s12 list">
		<div class="checkList">
<%
	CheckinDAO cidao = new CheckinDAO();
	CheckinVO civo = new CheckinVO();
	
	ArrayList<CheckinVO> list = new ArrayList<>();
	list = cidao.selelctAll(pno);
	System.out.println("1111111");
	if(list!=null){	
		for(CheckinVO vo : list){
			System.out.println("222222");
%>

					<div class="col m12 s12 onelist grey lighten-2 z-depth-2" style="width: 680px; padding-bottom 20px;padding-top: 20px; padding-bottom: 20px;">
						<a href="checkDetail.jsp?cno=<%=vo.getCheckno()%>">
					<div id="checkList_left" >
						<span>
							<h5 class="black-text"><strong><%=vo.getChecktitle()%></strong></h5>
							<br />
							<hr class="grey-text"/>
						</span>
						<h5><div class="chip light-blue darken-4 white-text "><strong>
		<%
						String daystr = vo.getCheckday();
						String[] arr = daystr.split("[$]");
						%>
						<%
						for(int i=0;i<arr.length;i++){
		%>
							<%=arr[i]%>
		<%
			}
		%>
					</strong></div></h5>	
					</div>
				</a>
			<%
				String str="";
					if(vo.getCheckonoff()==0){//off일때
						str = "toggle-off";
	
					}else{//on일때
						str = "toggle-on";
					}
			%>
		
				<div class="col m6 s6" id="checkList_middle" style="padding-top: 20px;">
					
						<div class="toggle-switch <%=str %>" id=<%=vo.getCheckno() %>>
		  					<div class="toggle-wrap">
							<div class="toggle-bg-on"></div>
			  				</div>
			  				<div class="toggle-handler"></div>
						</div>
					
				</div>
		
		
				<div class="col m6 right" id="checkList_right">
					<div class="col m12" style="padding-top: 20px;">
						<a href="checkDeleteOk.jsp?cno=<%=vo.getCheckno()%> ">
							<!-- <input type="button" class="btn-default" value="삭제" name="deletebtn" /> -->
							<i class="medium material-icons">delete</i>
						</a>
						<br>
					
						<a href="checkModify.jsp?cno=<%=vo.getCheckno()%>">
						<!-- <input type="button" class="btn-default" value="수정" /> -->
							<i class="medium material-icons">settings_applications</i>
						</a>
					
					</div>
				</div>
				</div>
				
			
			
	
<%
		}
	}
%>
	</div>
	
	</div>

	</div>
	<br /><br />
</div>
</main>
<%@ include file="../include/footer.jsp" %>
</body>
</html>
