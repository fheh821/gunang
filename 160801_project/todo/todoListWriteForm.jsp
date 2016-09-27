<%@page import="vo.ProjectVO"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="vo.TodoGroupVO"%>
<%@page import="dao.TodoGroupDAO"%>
<%@page import="vo.TodoListVO"%>
<%@page import="dao.TodoListDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>one-tack!</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

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

<script src="http://cdn.ckeditor.com/4.5.10/basic/ckeditor.js"></script>
<script src="../js/ckeditor.js"></script>
<script type="text/javascript" src="../js/materialize.min.js"></script> 

<!-- alert -->
<script src="../js/sweetalert.min.js"></script> 
<link rel="stylesheet" type="text/css" href="../css/sweetalert.css">


<script>
<%
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");		

		String gNo = request.getParameter("groupno");
		int gruopno = Integer.parseInt(gNo);
		int pNo = (int)session.getAttribute("pno");
		
		TodoGroupDAO gruopdao = new TodoGroupDAO();
		TodoGroupVO gruopvo = gruopdao.selectOne(gruopno);
		
		TodoListDAO listdao = new TodoListDAO();
		TodoListVO listvo = listdao.selectOne(pNo);
		//System.out.println(gruopvo.getGroupNo());
%>
 //텍스트칸 클릭시 달력이 보여서 선택하는 function:희정
$(function() {
  $( ".datepicker" ).datepicker({
    dateFormat: 'yy/mm/dd'
    /* 데이터타입 /로 넣어서 DB에 바로 넣기?? */
  });
});

//앞의 날자가 변경되어지고 뒤에날자를 변경할때 시작날자보다 값을작게 하지못하게 함
$(function(){
	  $("#endDate").on("change", function(){
		  if($( "#startDate" ).datepicker({dateFormat: 'yy/mm/dd'}).val()>$( "#endDate" ).datepicker({dateFormat: 'yy/mm/dd'}).val()){
			  swal("시작날짜보다 끝나는 날짜가 작을수 없습니다");
			  $( "#endDate" ).datepicker({dateFormat: 'yy/mm/dd'}).val($( "#startDate" ).datepicker({dateFormat: 'yy/mm/dd'}).val());
		  };
	  });
});

$(function(){
	$("#wu").on("click",function(){
		
		 $("#p1").hide();
		 $("#p2").hide();
		 $("#p3").hide();
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


// 입력창에 아무것도 없으면 경고창띄우기

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
			title : "리스트를 생성합니다.",
			text : "당신에 일정카드에 할 일을 추가합니다",
			type : "warning",
			showCancelButton : true,
			confirmButtonColor : "#DD6B55",
			confirmButtonText : "예, 저장!",
			cancelButtonText : "아니요, 취소!",
			closeOnConfirm : false,
			closeOnCancel : false
		}, function(isConfirm) {
			if (isConfirm) {
				swal("저장!", "저장합니다.",
						"success");
				form.action = "todoWriteFormOk.jsp?gruopno="+<%=gruopvo.getGroupNo() %>;
				form.method = "post";
				form.submit();
			} else {
				swal("취소", "취소합니다 :)", "error");
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
				swal("확인!", "ListPage로 되돌아갑니다.",
						"success");
				location.href = "todoList.jsp?groupno="+<%=gruopvo.getGroupNo()%>
			} else {
				swal("취소!", "내용을 계속 작성해 주세요 :)", "error");
			}
			
			
		
		});	
 	});
	
	
	
});

$(function(){
 	CKEDITOR.replace('editor1');	
});

</script>
<style type="text/css">
h1{
text-align: center;
font-weight: bold;
}

#p1, #p2, #p3{
display: none;
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
<body>
<%@ include file="../include/nav.jsp" %>
<main>
<div class="container">
<!-- menuNav --> 
	<%
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

	<form action="" method="post">
		<div class="row">
		<div class="center">
		     <a href="javascript:history.go(-1)" id="todogroup" class="black-text"><h6><strong>이전 페이지로 이동</strong></h6></a>
		</div>
		<div class="card col m8 offset-m2  grey lighten-2 z-depth-1">
			
			<div class="input-field col m12">
				<input type="text" name="title" id="input_text" size="50"/>
				<label for="input_text">제목을 입력하세요</label>	
				<br />	
			</div>
			<div id="textEditor" class="col m12">
				<textarea name="editor1" id="editor1" cols="100" rows="10" ></textarea>
				<label for="listContents">내용을 입력하세요</label>
				<br />
			</div>
				
			<div class="col m12 s12">
				<input type="radio" class="with-gap" name="date" id="wu" value="" checked="checked"/>
				<label for="wu">기한 제한이 없는 선택지입니다.</label>
				<br />
			</div>
				<!-- 해당 메소드에서 선택자로 지명한 class가 testDatepicker인 input 태그를 추가합니다. -->
				
			<div class="col m12">
				<input type="radio" class="with-gap" name="date" id="you" value=""/>
				<label for="you">기한</label>
			</div>
					
			<div class="col m5 s12" id="p1">
				<input class = "datepicker" type="text" name="start" id="startDate" >
			</div>
					
			<div class="col m2 s12" id="p2">
				<p>부터</p>
			</div>
					
			<div class="col m5 s12" id="p3">
				<input class = "datepicker" type="text" name="end" id="endDate" >	
				<br />
			</div>	
			
			<div class="col m12 s12">
				<div class="col m8 offset-m2 s12">
						<button class="col m5 s12 waves-effect waves btn green accent-4 z-depth-1" id="save" type="button">저장</button>
						<!-- get방식으로 데이터를 넘겨주면 그것으로 데이터를 저장한다. -->
						<div class="col m2 s0"></div>
						<button class="col m5 s12 waves-effect waves btn green accent-4 z-depth-1" type="button" id="cancel">취소</button>
					</div>
					<br /><br />
				</div>
			</div>
		</div>
	</form>
</div>
</main>
<%@ include file="../include/footer.jsp" %>
</body>
</html>