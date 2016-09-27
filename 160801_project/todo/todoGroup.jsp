
<%@page import="vo.ProjectVO"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="vo.TodoListVO"%>
<%@page import="dao.TodoListDAO"%>
<%@page import="dao.TodoGroupDAO"%>
<%@page import="vo.TodoGroupVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>one-tack!</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0" />
<!-- CSS  -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="../css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection" />
<link href="../css/style.css" type="text/css" rel="stylesheet" media="screen,projection" />

<!--  Scripts-->
<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script src="../js/materialize.js"></script>
<script src="../js/init.js"></script>

<script type="text/javascript" src="../js/httpRequest.js"></script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"> </script>

<!-- editor -->
<script src="//cdn.ckeditor.com/4.5.10/basic/ckeditor.js"></script>

<!-- alert -->
<script src="../js/sweetalert.min.js"></script> 
<link rel="stylesheet" type="text/css" href="../css/sweetalert.css">

<script type="text/javascript">
	function saveTodoState(){
		if(xhr.readyState == 4 && xhr.status == 200){
			//console.log("ajax 완료");
		}
	}
	
	$(function(){
		$("input:checkbox").on("click", function(){
			var listno = $(this).attr('value');
			var isComplete = $(this).prop("checked");//체크여부 true / false
			var params = "listno=" + listno + "&isComplete=" + isComplete;
			sendRequest("saveTodoListState.jsp", params, saveTodoState, "GET");
		});
	
		
		$(".delete").on("click", function() {
			var id = $(this).attr('id'); //function의 안에서 값을 못찾아서 밖에서 값을 찾은후 안에 넣어준다.
			swal({
				title : "확실합니까?",
				text : "당신의 하위 일정이 모두 삭제됩니다! 지우시겠습니까?",
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#DD6B55",
				confirmButtonText : "예, 지웁니다!",
				closeOnConfirm : false
			}, function() { //예를 누르면function안의 조건이 실행
					location.href = "deletetodoGroupOk.jsp?groupno=" + id;
			});
		});
	});
</script>

<style>
	h2{
		font-weight: bold;
	}	

	h6{
		font-weight: bold;
		color: #424242;
	}
	.card{		
		background-color: #D599EF; /* 554 */
		float: left;
		width: 400px;
		height: 200px;
		margin-bottom: 10px;
		padding: 20px 20px 20px 20px;
		overflow: auto;
	}	
	
.close-thik:after {
  content: '✖'; /* UTF-8 symbol */
}
#titleAndXbtn{
	margin: 0px;
}
#titleAndXbtn:hover {
	cursor: pointer;
}

body {
    display: flex;
    min-height: 100vh;
    flex-direction: column;
  }

  main {
    flex: 1 0 auto;
  }

.todoContents{
	height : 650px;
	overflow : auto;
	overflow-x : hidden;
}
</style>

</head>
<body>
	<%@ include file="../include/nav.jsp" %>
	<main>
		<%
		int pNo = (int)session.getAttribute("pno"); //세션 안에 있는 값을 사용한다.
		ProjectDAO pdao = new ProjectDAO();
		ProjectVO pvo = pdao.selectOne(pNo);
		
		%>
		
		<div class="container"> 
		<!-- menuNav --> 
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
		
		<div class="todoContents brown darken-2 z-depth-4">
			<div id="toDoNav" >
				<div class="row">
					<br />
					<div class="center">
						<a href="todoGroupWriteForm.jsp" class="col m4 offset-m4 waves-effect waves btn green accent-4 z-depth-4" id="addbtn">할 일 목록 추가</a>
					</div>
					
					<div class="col m10 offset-m1">
						<br />
						<a class="col m2 left white-text" href="todoGroup.jsp" id="cardview"><strong>카드로 보기</strong></a>
						<a class="col m2 left white-text" href="todoCalendar.jsp"><strong>달력으로 보기</strong></a>
					</div>
				</div>
			</div>
		<!-- memNo를 session에 저장하고 있어야겠군 -->
		<!-- pNo도 session에 가지고 있거나..
		projectMember 테이블에 접근해서, memNo에 맞는 pNo불러오기 -->
		
		<div class="row" id="groupContainer">
			<div class="col m10 offset-m1">
				<div class="col m12">
		<%
			int memno = Integer.parseInt(session.getAttribute("memno").toString()); 
			//int sessionPno = (int)session.getAttribute("pno"); 위의 방식으로 사용이 가능하고 이 방식으로 사용이 가능함
			//Object obj = session.getAttribute("groupNo");
			if(session.getAttribute("pno") == null || session.getAttribute("pno").equals("")){
				response.sendRedirect("index.jsp");
			}else{
			
			//System.out.println("obj :" + obj );
			
	
			//System.out.println("memno : " + memno);
			//System.out.println("pNo : " + pNo);
			//int groupNo = 10;
			// 프로젝트 번호에 해당하는 Group 가져오기
			
			ArrayList<TodoGroupVO> groups = new ArrayList<TodoGroupVO>();
			TodoGroupDAO groupdao = new TodoGroupDAO();
			// groups : 프로젝트에 들어있는 group의 목록을 가지고 있는 ArrayList
			groups = groupdao.selectAll(pNo);
			
			TodoListDAO listdao = new TodoListDAO();
			
			for(int i = 0; i < groups.size(); i++){
				TodoGroupVO groupvo = new TodoGroupVO();
				groupvo = groups.get(i);
		%>
		<a href="todoList.jsp?groupno=<%=groupvo.getGroupNo() %>">
			<div class="col m4">
				<div class="card col m12 z-depth-2" style = "background-color :<%=groupvo.getGroupColor()%>" >  <!-- warning이지만, 되는 듯 -->
				<%-- <span class="card-title"><h6><%=groupvo.getGroupTitle() %></h6></span> --%>
					<div class="row" id="titleAndXbtn">
						<br />
						<div class="col s10"><h6 class="card-title"><strong><%=groupvo.getGroupTitle() %><strong></h6></div>
							<div class="col s2 delete" id="<%=groupvo.getGroupNo()%>" ><a href="#" class="close-thik grey-text text-darken-2"></a></div>
					</div>
		
		<% 
					ArrayList<TodoListVO> lists = new ArrayList<TodoListVO>();
					// lists : 프로젝트번호와 그룹번호에 해당하는 list의 목록을 저장한다.
					lists = listdao.selectAll(groupvo.getGroupNo(), pNo);
					// groupNo++;
					for(int k = 0; k < lists.size(); k++){
					TodoListVO listvo = new TodoListVO();
					listvo = lists.get(k);					
					// 완료여부에 따른 체크박스 체크여부 결정하기 
			
		%>
					<div class="card-action">
						<input type="checkbox" name="test" id="test<%=listvo.getListNo()%>" value=<%=listvo.getListNo() %>
			<%
							String isCompleted = "";
							if(listvo.getIsComplete() == 1) // 0: 미완료  1: 완료
							{
							isCompleted = "checked"; // 속성에 checked가 들어가면, 체크된 상태로 나온다.
			%>
							<%=isCompleted %><%} %>/><label class = "grey-text text-darken-2" for="test<%=listvo.getListNo()%>"><%=listvo.getListTitle() %></label>
					</div>
			<% 					
							} // 안쪽 for문 end
			%> 
				</div>
			</div>
		</a>
			
		<%
			} // 바깥 for문 end
			
			groupdao.close();
			listdao.close();
			
			}
			pdao.close();
		%>
			
						</div>
					</div>
				</div>
			</div>
			<br /><br />
		</div>
	</main>
	
	<%@ include file="footer.jsp" %>
</body>
</html>