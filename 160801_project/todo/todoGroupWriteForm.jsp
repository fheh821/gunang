<%@page import="vo.ProjectVO"%>
<%@page import="dao.ProjectDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>one-tack!</title>
<script type="text/javascript" 
src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"> </script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- CSS  -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="../css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="../css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
<!--SCRIPT-->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script type="text/javascript" src="../js/materialize.min.js"></script>
<!-- editor -->
<script src="//cdn.ckeditor.com/4.5.10/basic/ckeditor.js"></script>
<!-- alert -->
<script src="../js/sweetalert.min.js"></script> 
<link rel="stylesheet" type="text/css" href="../css/sweetalert.css">

<script type="text/javascript">
	$(function(){
		
		$("#write").on("click", function(){
			var form = $(this)[0].form;
			var title = form.input_text.value;
			//var contents = form.groupContents.value;
			var color = form.color.value;
			
			if(title==''){
				sweetAlert("제목을 입력해주세요");
				$("#input_text").focus();
			console.log(title);
				return; 
			}if(CKEDITOR.instances.editor1.getData()==''){
				swal("내용을 입력해주세요");
				console.log($("#editor1").find("textarea").val());
				return; 
			}if(color==''){
				sweetAlert("색깔을 지정해주세요");
				return; 
			}
			
			swal({
				title : "카드를 생성합니다!",
				text : "당신의 TodoGroup에 Card를 추가합니다!",
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#DD6B55",
				confirmButtonText : "예, 저장!",
				cancelButtonText : "아니요, 취소!",
				closeOnConfirm : false,
				closeOnCancel : false
			}, function(isConfirm) {
				if (isConfirm) {
					swal("Saved!", "저장되었습니다.",
							"success");
					form.action = "GroupWriteFormOk.jsp";
					form.method = "get";
					form.submit();
				} else {
					swal("Cancelled", "취소되었습니다. :)", "error");
				}
			});
		
			
		});
		
		$("#cancel").on("click",function(){
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
					swal("확인!", "CardList로 되돌아갑니다.",
							"success");
					console.dir(swal);
						history.go(-1); // 이전 페이지로 이동!
				} else {
					swal("취소!", "내용을 계속 작성해 주세요 :)", "error");
				}
			});
		});
	});
	
	
    $(function(){
      	CKEDITOR.replace('editor1');	
     });

    $(document).ready(function() {
	    $('select').material_select();
	  });
</script>
<style>
	table, th, td{
		border : 1px solid black;
		border-collapse:  collapse;
	}
	table{
		width: 800px;
		margin: 0 auto;
		text-align: center;
	}
	tr{
		height: 50px;
	}
	
	h1{
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
</head>
<body class="grey lighten-5">
<!-- 상단바 호출 -->
<%@ include file="../include/nav.jsp" %>
<main>
<div class="container">
	<!-- menuNav --> 
	<%
		int pNo = (int)session.getAttribute("pno"); //세션 안에 있는 값을 사용한다.
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
		
	<form action="" method="get">
			<div class="row">
				<div class="col m8 offset-m2 grey lighten-2 z-depth-1">
					<div class="input-field col m12">				
						<input type="text" name="input_text" id="input_text"/>
						<label for="input_text">제목을 입력하세요</label>	
						<br />				
				</div>
				<div id="testEditor" class="col m12">
				<label for="groupContents">내용을 입력하세요</label>
					<textarea class="materialize-textarea" name="editor1" id="editor1" cols="100" rows="10" ></textarea>
					<br />
						<div class="input-field col s12">
						<!-- <label for="color">색상을 선택하세요</label> -->
						<select name="color" id="color">
							<option value="">group색깔</option>
							<option value="#ffcdd2">red</option>
							<option value="#ffab91">orange</option>
							<option value="#fff9c4">yellow</option>
							<option value="#c8e6c9">green</option>
							<option value="#bbdefb">blue</option>
							<option value="#e1bee7">purple</option>
							<option value="#cfd8dc">gray</option>
							<option value="#f5f5f5">white</option>
						</select>
						<label>색상을 선택하세요</label>
						</div>
						<br />
						<div class="col m12 s12">
							<div class="col m8 offset-m2 s12">
								<button class="col m5 s12 waves-effect waves btn green accent-4 z-depth-1" type="button" value="글쓰기" id="write">작성</button>
								<div class="col m2 s0"></div>
								<button class="col m5 s12 waves-effect waves btn green accent-4 z-depth-1" type="button" value="취소" id="cancel">취소</button>
								
							</div>
							<br /><br /><br />
						</div>	
					</div>
				</div>
			</div>
	</form>
	<br />
</div>
</main>
<%@ include file="footer.jsp" %>
</body>
</html>