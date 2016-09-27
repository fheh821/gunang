<%@page import="vo.ProjectVO"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.ProjectMemberVO"%>
<%@page import="dao.ProjectMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>one-tack!</title>
<style type="text/css">
	*{box-sizing: border-box; margin: 0; padding: 0;}
	.boxWrap{width: 80%; margin: auto; overflow: hidden;}
	table{
		border: 1px solid black;
		width: 100%;
	}
	img{
		width: 50px;
		height: 50px;
	}
	body {
    display: flex;
    min-height: 100vh;
    flex-direction: column;
  }

  main {
    flex: 1 0 auto;
  }	

	.quest input{width: 100%;}
	.box1{width: 40%; float: left; height: 250px; overflow: auto;}
	.box2{width: 100%; float: left; height: 80px; display: block;}
	#time{width: 30%; float: left; margin-left: 10px;}
	#hour{width: 30%; float: left; margin-left: 10px;}
	#min{width: 30%; float: left; margin-left: 10px;}
	/* p{width: 60%; float: left; height: 80px;} */
	.box3{width: 100%; float: left; text-align: center; margin-left: 20px;}
	.box4{width: 90%; float: left; text-align: center; margin-left: 20px;}
	.box5{width: 100%; text-align: center; margin-top: 50px;}
	.boxes{
		width: 60%;
		height: 250px;
		float: left;
	}
</style>
 <!-- CSS  -->
 <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
 <link href="../css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
 <link href="../css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>

 <!--  Scripts-->
 <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
 <script src="../js/materialize.js"></script>
 <script src="../js/init.js"></script>

<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"></script>
<script type="text/javascript">
$(function(){
 	$("#submit").click(function(){
		
		var quest = $("#quest").val();
		var sendData = 'quest=' + quest;
		var memArr = [];
		var dayArr = [];

		$("input[name='filled-in1']:checked").each(function(i){
			memArr.push($(this).val());
			chkData1 = '&filled-in1=' + memArr[i];
			sendData += chkData1;
		})
		
		var selectedtime= $("#time option:selected").text();
		var time = '&time='+selectedtime;
		sendData += time;

		var selectedhour= $("#hour option:selected").text();
		var hour = '&hour='+selectedhour;
		sendData += hour;
		
		var selectedmin= $("#min option:selected").text();
		var min = '&min='+selectedmin;
		sendData += min;
		 
		$("input[name='filled-in2']:checked").each(function(i){
			dayArr.push($(this).val());
			chkData2 = '&filled-in2=' + dayArr[i];
			sendData += chkData2;
		})	
		
		//var selectedperiod = $("#period option:selected").text();
		var selectedperiod = $("#period option").index($("#period option:selected"));
		var period = '&period='+selectedperiod;
		sendData += period;
		
		$.post("checkWriteOk.jsp", sendData);
		
	})   
		
})

</script>
</head>
<body class="grey lighten-5">
<%@ include file="../include/nav.jsp" %>
<main>
<div class="container">

<%
	String smemno = session.getAttribute("memno").toString();// 멤버번호 pasing
	String spno = session.getAttribute("pno").toString();// 멤버번호 pasing
	int memno = Integer.parseInt(smemno);
	int pno = Integer.parseInt(spno);
	
	ProjectDAO pdao = new ProjectDAO();
	ProjectVO pvo = pdao.selectOne(pno);
%>

   <h4 class="header center"><strong><a href="../project/project.jsp?pno=<%=(int)session.getAttribute("pno")%>" class="grey-text text-darken-3"><%=pvo.getpName() %></a></strong></h4>
   <div class="row center">
      <div class="col m8 offset-m2 s12">
         <div class="col m3">
            <a href="../chatting/chatTest.jsp" class="waves-effect waves-light btn-large light-blue darken-2"><i class="material-icons left">chat</i>채팅</a>
         </div>
         <div class="col m3">
            <a href="../board/board.jsp" class="waves-effect waves-light btn-large light-blue darken-2"><i class="material-icons left">dashboard</i>보드</a>
         </div>
         <div class="col m3">
            <a href="../todo/todoGroup.jsp" class="waves-effect waves-light btn-large light-blue darken-2"><i class="material-icons left">done</i>할일</a>
         </div>
         <div class="col m3">
            <a href="../checkin/checkList.jsp" class="waves-effect waves-light btn-large light-blue darken-2"><i class="material-icons left">alarm_on</i>알림</a>
         </div>
      </div>
   </div>
<div class="row white grey lighten-3 black-text">
<form name="checkform" action="" method="post">
	<div class="boxWrap">
		<div class="quest">
			<br />
			<input type="text" class="black-text grey lighten-4" id="quest" placeholder="알릴 메세지를 입력하세요.">
		</div>
		<div class="box1 grey darken-2">
			<table class="striped grey darken-2">
		        <thead>
		          <tr >
		              <th data-field="id" class="white-text" style="text-align:center">알림 전송 할 멤버</th>
		          </tr>
		        </thead>
		        <tbody>
			<%
				ProjectMemberDAO pmdao = new ProjectMemberDAO();
				MemberDAO mdao = new MemberDAO();
				ArrayList<Integer> pmlist = pmdao.selectAllMember(pno);
				int cnt=0;
				for(int pmemno : pmlist){
					MemberVO mvo = mdao.selectOne(pmemno);
				
				
				if(mvo==null){
					System.out.println("비어있음");
				}
				
		
			%>
				<tr class="grey darken-2">
					<td><img src="<%=mvo.getIcon()%>" alt="" /></td>
					<td style="margin-right:auto" class="white-text"><strong><%=mvo.getName()%></strong></td>			
					<td>
					<form method="post">
					    <p>					      
					      <input type="checkbox" class="filled-in1" id="filled-mem-box<%=cnt%>" name="filled-in1" value=<%=mvo.getMemNo()%> />
					      <label for="filled-mem-box<%=cnt%>"></label>
					    </p>
				    </form>					
					</td>  
				</tr>
			<%
				cnt++;
				
				}
			%>
			</tbody>
			</table>
		</div>
		 <div class="boxes grey darken-2 ">
		<div class="input-field col m12 s2 box2">
			<select class="browser-default" id="time">
                <option>오전</option>
                <option>오후</option>
            </select>
			<select class="browser-default" id="hour">
                <%
            		for(int i=1;i<=12;i++){
            			if(i%10==i){
            				%>
                			<option><%="0"+i%></option>
                			<%
            			}else{
            			%>
            				<option><%=i%></option>
            			<%
            			}
            		}
            	%>
            </select>
			 <select class="browser-default" id="min">
	            	<%
	            		for(int i=0;i<60;i++){
	            			if(i%10==i){
	            				%>
	                			<option><%="0"+i%></option>
	                			<%
	            			}else{
	            			%>
	            				<option><%=i%></option>
	            			<%
	            			}
	            		}
	            	%>
	            </select>		
			</div>

		<div class="box3 white-text">
		    <table>
			<form method="post">
				<p class=" white-text">
					<input type="checkbox" class="filled-in2" id="filled-in-box1" name="filled-in2" value="mon"/>
					<label class="white-text" for="filled-in-box1" style="padding-left: 20px; padding-right: 10px;">월</label>
					
					<input type="checkbox" class="filled-in2" id="filled-in-box2" name="filled-in2" value="tue">
					 &nbsp; &nbsp;
					<label class="white-text" for="filled-in-box2" style="padding-left: 20px; padding-right: 10px;">화</label>
					<input type="checkbox" class="filled-in2" id="filled-in-box3" name="filled-in2" value="wed">
					 &nbsp; &nbsp;
					<label class="white-text" for="filled-in-box3" style="padding-left: 20px; padding-right: 10px;">수</label>
					<input type="checkbox" class="filled-in2" id="filled-in-box4" name="filled-in2" value="thr">
					 &nbsp; &nbsp;
					<label class="white-text" for="filled-in-box4" style="padding-left: 20px; padding-right: 10px;">목</label>
					<input type="checkbox" class="filled-in2" id="filled-in-box5" name="filled-in2" value="fri">
					 &nbsp; &nbsp;
					<label class="white-text" for="filled-in-box5" style="padding-left: 20px; padding-right: 10px;">금</label>
					<input type="checkbox" class="filled-in2" id="filled-in-box6" name="filled-in2" value="sat">
					 &nbsp; &nbsp;
					 <label class="white-text" for="filled-in-box6" style="padding-left: 20px; padding-right: 10px;">토</label>
					<input type="checkbox" class="filled-in2" id="filled-in-box7" name="filled-in2" value="sun">
					 &nbsp; &nbsp;
					<label class="white-text" for="filled-in-box7" style="padding-left: 20px; padding-right: 10px;">일</label>
				</p>
			</table>
		</div>
		<div class="box4">
			<select class="browser-default" id="period" >
					<option>매 주 마다</option>
					<option>2 주 마다</option>
					<option>매 달 마다</option>
					<option>매 해 마다</option>
			</select>		
		</div>
	</div>
		<div class="col m12 s12 center box5" style="margin-bottom: 60px;">
			<a href="checkList.jsp?flag=true"><button class="col m3 offset-m2 btn waves-effect waves-light green accent-4" id="submit" type="button">등록
   				<i class="material-icons right"></i>
 				</button></a>
			<a href="checkList.jsp?flag=true" class="col m3 offset-m1 btn waves-effect waves-light green accent-4">취소</a>
		</div>
	</div>
</form>
</div>
</div>
<br />
</main>
<%@ include file="../include/footer.jsp" %>	
</body>
</html>