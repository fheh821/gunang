<%@page import="dao.ProjectDAO"%>
<%@page import="vo.ProjectVO"%>
<%@page import="vo.TodoListVO"%>
<%@page import="dao.TodoListDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
<script src="//cdn.ckeditor.com/4.5.10/basic/ckeditor.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- CSS  -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="../css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
<link href="../css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
<!--SCRIPT-->
  <script type="text/javascript" src="../js/materialize.min.js"></script>
<!-- editor -->
<script src="//cdn.ckeditor.com/4.5.10/basic/ckeditor.js"></script>
<!-- alert -->
<script src="../js/sweetalert.min.js"></script> 
<link rel="stylesheet" type="text/css" href="../css/sweetalert.css">


<script src="//cdn.ckeditor.com/4.5.10/basic/ckeditor.js"></script>
      

<script type="text/javascript" src="../js/materialize.min.js"></script>


<!-- 여기에 있는 jquery를 사용해주세요 다른건 달력오류남 -->

<title>one-tack!</title>
<%
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String listno = request.getParameter("listno");
		int list = Integer.parseInt(listno);
		//우선은 원래의 값을 불러온다.
		TodoListDAO listdao = new TodoListDAO();
		TodoListVO listvo = listdao.selectOne(list);
		

%>
<style type="text/css">
h1{
text-align: center;
font-weight: bold;
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

  <script>
  
  $(function(){
   	CKEDITOR.replace('editor1');	
  });
  
  
  $( function() {
    $( "#datepicker1" ).datepicker({dateFormat: 'yy/mm/dd'});
    $( "#datepicker2" ).datepicker({dateFormat: 'yy/mm/dd'});
    
  } );
  
  $(function(){
	  $("#datepicker2").on("change", function(){
		  if($( "#datepicker1" ).datepicker({dateFormat: 'yy/mm/dd'}).val()>$( "#datepicker2" ).datepicker({dateFormat: 'yy/mm/dd'}).val()){
			  alert("시작날짜보다 끝나는 날짜가 작을수 없습니다");
			  $( "#datepicker2" ).datepicker({dateFormat: 'yy/mm/dd'}).val($( "#datepicker1" ).datepicker({dateFormat: 'yy/mm/dd'}).val());
		  };
	  });
  });
  

  $(function(){
		$("#wu").on("click",function(){
			 $("#p1").hide();
			 $("#p2").hide();
			 $("#p3").hide();
			 $( "#datepicker1" ).val(null);
			 $( "#datepicker2" ).val(null);
			 /* disabled="disabled" */
		});
		$("#you").on("click",function(){
			 $("#p1").show();
			 $("#p2").show();
			 /* disabled="disabled" */
		});
		
		$("#p1").on("click", function(){
			$("#p3").show();
		})
	});
  
  
  $(function(){
		$("#save").on("click", function(){
		var form = $(this)[0].form;
		if($("#input_text").val()==''){
			swal("제목을 입력하세요");
			$("#input_text").focus();
			return;
		}if(CKEDITOR.instances.editor1.getData()==''){
			swal("내용을 입력하세요");		
			return;
		}if($("#wu")[0].checked == false && $("#you")[0].checked == false){
			swal("둘 중의 하나는 선택해야 합니다.");
			//alert(CKEDITOR.instances.editor1.getData());
			return;
		}
		//위의 스크립트를 사용하기위해 form의  내용을 보냄
		swal({
			title : "일정이 수정됩니다.",
			text : "당신이 수정한 내용이 저장되고 전에 작성한 내용은 되돌릴 수 없습니다!",
			type : "warning",
			showCancelButton : true,
			confirmButtonColor : "#DD6B55",
			confirmButtonText : "예, 수정!",
			cancelButtonText : "아니요, 취소!",
			closeOnConfirm : false,
			closeOnCancel : false
		}, function(isConfirm) {
			if (isConfirm) {
				swal("저장!", "변경 된 내용이 저장되었습니다.", "success");
						form.action = "todoListModifyOK.jsp?listno="+<%=listvo.getListNo()%>;
						form.method = "post";
						form.submit();
					
				} else {
					swal("취소", "내용이 변경되지 않았습니다.", "error");
				}

			});

		});
		$("#cancel").on("click",function() {
    		swal({
				title : "취소합니다",
				text : "당신이 작성한 내용이 지워집니다!",
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#DD6B55",
				confirmButtonText : "예, 취소합니다!",
				closeOnConfirm : true
			}, function() {
				  location.href = "todoListDetail.jsp?listNo="+<%=listvo.getListNo()%>;		
				});
      		});
	});
  
  
  
  
  
  </script>
</head>
<body>
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
				<div class="card col m8 offset-m2 brown lighten-5">
					<div class="input-field col m12">
						<input type="text" name="input_text" id="input_text" value="<%=listvo.getListTitle()%>"/>
						<label for="input_text">제목을 입력하세요</label>
					</div>
					<div id="textEditor" class="col m12">
						<textarea name="editor1" id="editor1" rows="25" cols="100"><%=listvo.getListContents() %></textarea>
						<label for="listContents">내용을 입력하세요</label>
					</div>
					<div class="col m12 s12">
							<input type="radio" class="with-gap" name="date" id="wu" value="" />
							<label for="wu">기한 제한이 없는 선택지입니다.</label>
					</div>
					<div class="col m12">
							<input type="radio" class="with-gap" name="date" id="you" />
							<label for="you">기한</label>
					</div>
					<div class="col m5 s12" id="p1">
							<input type="text" id="datepicker1" name="datepicker1" value="<%=listvo.getStartDate()%>">
					</div>
					<div class="col m2 s12" id="p2">
					<p>부터</p>
					</div>
					<div class="col m5 s12" id="p3">					
							<input type="text" id="datepicker2" name="datepicker2" value="<%=listvo.getEndDate()%>">
					</div>
						<div class="col m12 s12">
							<div class="col m8 offset-m2 s12">
								<button class="col m5 s12 btn waves-effect waves-light green accent-4" id="save" type="button">수정</button>
								<div class="col m2 s0"></div>
								<button class="col m5 s12 btn waves-effect waves-light green accent-4" type="button" id="cancel">취소</button>
							</div>
							<br /><br /><br />
						</div>
					</div>
					<br />
		</div>	
	</form>
</div>
</main>
	<%@ include file="footer.jsp" %>
</body>
</html>