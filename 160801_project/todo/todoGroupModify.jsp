<%@page import="vo.ProjectVO"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="vo.TodoGroupVO"%>
<%@page import="dao.TodoGroupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- CSS  -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="../css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="../css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <script type="text/javascript" src = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"></script>
<!--SCRIPT-->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script type="text/javascript" src="../js/materialize.min.js"></script>
<!-- editor -->
<script src="//cdn.ckeditor.com/4.5.10/basic/ckeditor.js"></script>
<!-- alert -->
<script src="../js/sweetalert.min.js"></script> 
<link rel="stylesheet" type="text/css" href="../css/sweetalert.css">


<title>one-tack!</title>
<%
		//modify를 누르면 무엇을 설정할수있게?
		//contents와 title 그리고 color를 변경할수있게?
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	String group = request.getParameter("groupno");
	int groupno = Integer.parseInt(group);
	//세션에 저장되어있는 값을 불러와 사용한다.
	
	TodoGroupDAO groupdao = new TodoGroupDAO();
	TodoGroupVO groupvo = groupdao.selectOne(groupno);

	
	
	//앞의 
%>
<script type="text/javascript">
	
	 $(function(){
         	CKEDITOR.replace('editor1');	
        });
	 
	 $(function(){
			$("#modify").on("click", function(){
			var form = $(this)[0].form;
			
			if($("#groupTitle").val()==''){
				swal("제목을 입력하세요");
				$("#input_text").focus();
				return;
				
			}if(CKEDITOR.instances.editor1.getData()==''){
				swal("내용을 입력하세요");		
				return;
				
			}if($("#color").val() == ''){
				swal("Color를 선택해야 합니다.");
				//alert(CKEDITOR.instances.editor1.getData());
				return;
			}
			
			swal({
				title : "내용을 수정합니다!!",
				text : "사용자가 수정한 내용을 저장합니다!",
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#DD6B55",
				confirmButtonText : "예, 저장!",
				cancelButtonText : "아니요, 취소!",
				closeOnConfirm : false,
				closeOnCancel : false
			}, function(isConfirm) {
				if (isConfirm) {
					swal("수정!", "당신이 작성한 내용이 수정됩니다.",
							"success");
						form.action = "todoGroupModifyOK.jsp?groupno="+<%=groupvo.getGroupNo() %>;
						form.method = "post";
						form.submit();
				} else {
					swal("취소", "저장을 취소합니다. :)", "error");
				}
			});

			});
	 	$("#cancel").on("click", function(){
	 		swal({
				title : "작성을 취소합니다!",
				text : "지금까지 작성한 내용이 사라집니다 계속하시겠습니까?",
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#DD6B55",
				confirmButtonText : "예, 취소!",
				cancelButtonText : "아니요, 작성!",
				closeOnConfirm : false,
				closeOnCancel : false
			}, function(isConfirm) {
				if (isConfirm) {
					swal("확인!", "GroupPage로 되돌아갑니다.",
							"success");
					location.href = "todoList.jsp?groupno="+<%=groupvo.getGroupNo() %>
				} else {
					swal("취소!", "내용을 계속 작성해 주세요 :)", "error");
				}
				
				
			
			});	
	 	});
		
	 });


</script>
<style type="text/css">

h1{
text-align: center;
font-weight: bold;
}

#groupContents{
padding-top: 0%;
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
<%@ include file="../include/nav.jsp" %>
<main>
	<div class="container">
	<!-- menuNav --> 
	<%
		int pNo = (int)session.getAttribute("pno");
		ProjectDAO pdao = new ProjectDAO();
		ProjectVO pvo = pdao.selectOne(pNo);
		
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
	<form action="" method="post" id="frm">
		<div class="row">
			<div class="center">
		     <a href="javascript:history.go(-1)" id="todogroup" class="black-text"><h6><strong>이전 페이지로 이동</strong></h6></a>
		</div>
		
			<div class="card col m8 offset-m2 grey lighten-2 z-depth-1">
			
				<div class="input-field col m12">
				
						<input type="text" class="col m12"name="input_text" id="groupTitle" length="10"
									value="<%=groupvo.getGroupTitle() %>" placeholder="제목을 입력해주세요"/>
						<label for="input_text">제목을 입력하세요</label>	
							<br />	
				</div>
	        	
	        	<div class="col m12">     	
					<label for="groupContents">내용을 입력하세요</label>
					<textarea class="materialize-textarea" name="editor1" id="editor1" placeholder="내용을 입력해주세요">
						<%=groupvo.getGroupContents() %>
					</textarea><br />

					<label for="color">색상을 선택하세요</label>
					<select name="color" id="color" class="browser-default">
								<option value="">group색깔</option>
								<option value="#C70039">red</option>
								<option value="#FF5733">orange</option>
								<option value="#F2FF9B">yellow</option>
								<option value="#6AF79A">green</option>
								<option value="#2794EB">blue</option>
								<option value="#581845">purple</option>
								<option value="#516C8D">gray</option>
								<option value="#DDDDDD">white</option>
					</select>
					<br />
				</div>
			<br />
					
			<div class="col m12 s12">
				<div class="col m8 offset-m2 s12">
				<button class="col m5 s12 btn waves-effect waves-light  green accent-4" type="button" id="modify">수정</button>
				<div class="col m2 s0"></div>		
				<button class="col m5 s12 btn waves-effect waves-light  green accent-4" type="button" id="cancel">취소</button>
				</div>
				<br /><br />	
			</div>
		</div>
		
	</form>
</div>	
	</main>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>