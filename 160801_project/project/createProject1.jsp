<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/bootstrap.css" />
<link rel="stylesheet" href="../css/bootstrap-theme.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
  <title>one-tack!</title>

  <!-- CSS  -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="../css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="../css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>

  <!--  Scripts-->
  <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
  <script src="../js/materialize.js"></script>
  <script src="../js/init.js"></script>
<style>
	#total{
		width: 1000px;
		height: 400px;
		margin: auto;
		text-align: center;
	}
	input[type= text]{
		width: 500px;
	}
	input[type= submit]{
		width: 200px;
		margin: 20px;
		margin: 20px auto 20px;
	}
	.progress{
		width: 400px;
		margin: 100px auto;
	}
</style>
</head>
<body class="no-pad-bot grey lighten-5">
	<%@ include file="../include/nav.jsp" %>
	<div id="total">
		<form action="createProject2.jsp" method="get">
			<h5><strong>프로젝트 이름을 설정하세요.</strong></h5>
			<h6>이 One-tack!이 어떤 프로젝트에 대한 것인지 작성하세요.</h6>
				<input type="text" name="title"/>
			<h5><strong>프로젝트의 추가 정보를 입력해주세요.</strong></h5>
			<h6>One-tack! 상단에 노출되는 정보입니다.</h6>
				<input type="text" name="info"/> <br />
			<div class="row">
				<div class="col m10 offset-m1">
					<button class="col m4 offset-m4 btn waves-effect waves-light green accent-4 z-depth-1" type="submit">다음
		 			</button>
	 			</div>
 			</div>
		</form>
	</div>
	
	 <%@ include file="../include/footer.jsp" %>
</body>
</html>