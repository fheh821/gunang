<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
	src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"></script>
<!-- Compiled and minified CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/css/materialize.min.css">
<!-- Compiled and minified JavaScript -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/js/materialize.min.js"></script>
<!--Import Google Icon Font-->
<link href="http://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet" href="../css/materialize.min.css"
	media="screen,projection" />
<!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="//cdn.ckeditor.com/4.5.10/basic/ckeditor.js"></script>
<script type="text/javascript" src="../js/materialize.min.js"></script>

<!-- alert -->
<script src="../js/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/sweetalert.css">

<title>Insert title here</title>
</head>
<body>
	<div class="col m6 right" id="checkList_right">
	<div class="col m12">
		<button href="checkDeleteOk.jsp?cno=">
			<!-- <input type="button" class="btn-default" value="삭제" name="deletebtn" /> -->
			<i class="material-icons default">delete</i>
		</button>
	
	
		<a>
		<!-- <input type="button" class="btn-default" value="수정" /> -->
			<i class="material-icons btn-default">settings_applications</i>
		</a>
	
	</div>
</div>

	<script type="text/javascript">


		$(function() {
			swal({
				title : "Are you sure?",
				text : "You will not be able to recover this imaginary file!",
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#DD6B55",
				confirmButtonText : "Yes, delete it!",
				closeOnConfirm : false
			}, function() {
				
			});
		})
	</script>

	<input type="button" value="gg" id="btn1" />
</body>
</html>