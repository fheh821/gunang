<%@page import="vo.ProjectVO"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.TodoGroupDAO"%>
<%@page import="vo.TodoGroupVO"%>
<%@page import="dao.TodoListDAO"%>
<%@page import="vo.TodoListVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>one-tack!</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="../js/httpRequest.js"></script>
<!-- Compiled and minified CSS -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/css/materialize.min.css">
<!-- Compiled and minified JavaScript -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/js/materialize.min.js"></script>
<!--Import Google Icon Font-->
      <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<!--Import materialize.css-->
      <link type="text/css" rel="stylesheet" href="../css/materialize.min.css"  media="screen,projection"/>
<!--Let browser know website is optimized for mobile-->
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script type="text/javascript" src="../js/materialize.min.js"></script>

<!-- alert -->
<script src="../js/sweetalert.min.js"></script> 
<link rel="stylesheet" type="text/css" href="../css/sweetalert.css">


<style type="text/css">
/* .container {border: 2px solid black;}
 .col{border: 1px solid black;} */

body {
    display: flex;
    min-height: 100vh;
    flex-direction: column;
  }

  main {
    flex: 1 0 auto;
  }
.card{
	height: 450px;
}
</style>


</head>

<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	// 우선 재주가 해야하는일은? 넘겨받은 listno와 sesssion안에 들어있는 값을 이용? datail을 본다? 
	String listno = request.getParameter("listNo");

	//현재 둘의 값의 null값을 가지고있으며 DB안의 값을 불러오지 못한다. 파라메터값이 아닌 이미 저장되어있거나 없는 값을 이용한다.
	//체크의 유무 저장은 todolistdao안에 저장되어있다!!
	//우리는 그 값을 불러오고 업데이트 하기만 하면 된다.

	int list = Integer.parseInt(listno);
	System.out.println("listno : " + list);
	//다음으로 해야할 일은 체크박스의 체크여부를 디비에 저장한다. 선미가 한것을 todolist에서 참고하여 작성한다.

	int memno = Integer.parseInt(session.getAttribute("memno").toString());
	System.out.println(memno);
	int pNo = (int)session.getAttribute("pno");
	
	ProjectDAO pdao = new ProjectDAO();
	ProjectVO pvo = pdao.selectOne(pNo);
	//DB안에있는 것을 이용하여 체크박스의 체크여부를 작성한다.

	TodoListDAO listdao = new TodoListDAO();
	TodoListVO listvo = listdao.selectOne(list);
	TodoGroupDAO groupdao = new TodoGroupDAO();
	TodoGroupVO groupvo = groupdao.selectOne(memno);

	if (listno == null || listno.equals("")) {
		response.sendRedirect("login.jsp");
	} else {
		/* int complete = listvo.getIsComplete();
		System.out.println("complete : " + complete);
		//이렇게하면 DB안에 있는 체크상태를 불러올수있다. */
%>
<script type="text/javascript">

		//ajax를 이용하여 값을 넣은것 같은데 ?
		function saveTodoState(){
			if(xhr.readyState == 4 && xhr.status == 200){
				//console.log("ajax 완료");
			}		
		}
		
		$(function(){
			$("input:checkbox").on("click", function(){
				var listno = $(this).attr('id');
				var isComplete = $(this).prop("checked");//체크여부 true / false
				var params = "listno=" + listno + "&isComplete=" + isComplete;
				sendRequest("saveTodoListState.jsp", params, saveTodoState, "GET");				
				});
			$("a[name = 'delete']").on("click", function(){
				location.href = "todoDeleteOK.jsp?listno=<%=listvo.getListNo()%>";
				});
			$("#delete").on("click", function(){
				swal({
					title : "취소합니다",
					text : "당신이 작성한 내용이 지워집니다!",
					type : "warning",
					showCancelButton : true,
					confirmButtonColor : "#DD6B55",
					confirmButtonText : "예, 삭제합니다!",
					closeOnConfirm : false
				}, function() {
					  location.href = "todoDeleteOK.jsp?listno="+<%=listvo.getListNo()%>;		
					});
			});
			$("#edit").on("click", function(){
				swal({
					title : "수정합니다",
					text : "당신이 작성한 일정을 수정합니다!",
					type : "warning",
					showCancelButton : true,
					confirmButtonColor : "#DD6B55",
					confirmButtonText : "예, 수정합니다!",
					closeOnConfirm : true
				}, function() {
					  location.href = "todoListModify.jsp?listno="+<%=listvo.getListNo()%>;		
					});
			});
			
			
	});
</script>
<body class="grey lighten-5">
	<%@ include file="../include/nav.jsp"%>
<main>
<div id="total">
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
	
		<div class="row">
		<div class="row">
			<div class="center">
		     <a href="javascript:history.go(-1)" id="todogroup" class="black-text"><h6><strong>이전 페이지로 이동</strong></h6></a>
		</div>
		
			<div class="card col m8 offset-m2 grey lighten-2 z-depth-1">
				<form action="#">
					<!-- 수정버튼을 누르면 modify.jsp로 연결한다. 이때 보내주는 값은? -->
					<div class="right">
						<br />
						<button class="waves-effect waves-light btn green accent-4" type="button" id="edit">수정</button>
					</div>
					<!--
						오류 나서 일단 주석 처리 
						<div class="right" style="margin-right: 10px">
						<br />
						<button class=" waves-effect waves-light btn red accent-4" id="delete" name="delete">삭제</button>
					</div>
					-->
					<br />
					<br />
					<br />
					<div class="col m12">
						<div>
						<input type="checkbox" id=<%=listvo.getListNo()%> <%
							String isCompleted = "";
								if (listvo.getIsComplete() == 1) // 0: 미완료  1: 완료
								{
									isCompleted = "checked"; // 속성에 checked가 들어가면, 체크된 상태로 나온다.
						%>
						<%=isCompleted%>
						<%
							}
						%>/> 
						<label for="<%=listvo.getListNo()%>"><strong><%=listvo.getListTitle()%></strong></label>
						</div>						
					</div>		
					<div class="col m12 "> <br />
						<h5><strong>내용</strong></h5><h6> <%=listvo.getListContents()%></h6>
					</div>
					
				</form>
				<div class=" col m12 "><br />
				<h5><strong>기한</strong></h5><h6>
				<%
					//기한이 null일 경우 자를값이 없어 오류가남 그래서 null값의 경우 예외를 둠
						String start = listvo.getStartDate();
						String enddate = listvo.getEndDate();
						if (start != null && enddate != null) {
							String s = start.substring(0, 11);
							String e = enddate.substring(0, 11);
				%>
				<%=s%>부터<%=e%>까지 </h6><%
					} else if (start == null && enddate == null) {
				%>기한이 존재하지 않는 프로젝트입니다.</h6>
				</div>
			</div>
		</div>
		
		<%
				}
			}
		%>
		<div class=" col m12 "><br /></div>
	
	</div>
	</div>
	</div>
	<br />
</main>
	<%@ include file="footer.jsp"%>
</body>
</html>