<%@page import="vo.ProjectMemberVO"%>
<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProjectMemberDAO"%>
<%@page import="vo.ProjectVO"%>
<%@page import="dao.ProjectDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>one-tack!</title>
<!-- CSS  -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="../css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="../css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
<!--SCRIPT-->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script type="text/javascript" src="../js/materialize.min.js"></script>

<style type="text/css">
#wrap{
	height: 690px;
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
<body class="no-pad-bot grey lighten-5">
	<%@ include file="../include/nav.jsp" %>
	<main>
	
	<%
		String p = request.getParameter("pno");
		int pNo = Integer.parseInt(p);
		int memNo = (int) session.getAttribute("memno");

		ProjectMemberDAO pmdao = new ProjectMemberDAO();
		ProjectMemberVO pmvo = pmdao.checkOne(pNo, memNo);

		if (pmvo == null) { // 접근권한없으면, 접근 못하게...
	%>
		<script type="text/javascript">
			alert("접근권한이 없습니다");
			history.go(-1);
		</script>
	<%
		}

		// project에 들어가면, session에 pNo를 저장해야할거 같은데?!?!
		session.setAttribute("pno", pNo);

		ProjectDAO pdao = new ProjectDAO();
		MemberDAO mdao = new MemberDAO();
		ProjectVO pvo = pdao.selectOne(pNo);
	%>
	<div class="container" id="wrap">
		<h2 class="header center grey-text text-darken-4"><strong><%=pvo.getpName() %></strong></h2>
		<h5 class="center light grey-text text-darken-2"><strong><%=pvo.getpInfo() %></strong></h5>
		<div class="center light grey-text">
		<%
			ArrayList<Integer> members = pmdao.selectAllMember(pNo);
			for(Integer x : members){
			MemberVO mvo = mdao.selectOne(x);
		%>
			<div class="chip"><%=mvo.getName() %></div>
		<%
			}
			
		%>
			<a href="addMember.jsp" class="btn-floating red darken-1"><i class="tiny material-icons">add</i></a>
		</div>
		<br />
		<div class="row">
			<div id="menu" class="col m10 offset-m1 s12" >
				<div class="col m3 s6" onclick="location.href='../chatting/chatTest.jsp'">
					<div class="card small col m11 s12">
						<div class="card-content center">
					      <h5><strong><a href="#" class="grey-text text-darken-4">원탁책상</a></strong></h5>
					      <span class="activator grey-text text-darken-1">자세히</span>
					      <br />
					      <hr />
					      <br />
					    </div>
					    <div class="center card-image waves-effect waves-block waves-light">
					      <i class="activator large material-icons">chat</i>
					    </div>
					    <div class="col m12 card-reveal">
					      <span class="card-title grey-text text-darken-4"><strong>원탁책상</strong>
					      <i class="small material-icons right">close</i>
					    </span>
					      
					      <br />
					      <hr />
					      <p>"원탁 책상"은 <br />팀원과 자유롭게 <br />대화를 나누고 <br />대화 내용을 <br />기록할 수 있는 <br />공간입니다.</p>
					    </div>
				    </div>
				</div>
				
				<div class="col m3 s6" onclick="location.href='../board/board.jsp'">
					<div class="card small col m11 s12">
						<div class="card-content center">
					      <h5><strong><a href="#" class="grey-text text-darken-4">메모보드 </a></strong></h5>
					      <span class="activator grey-text text-darken-1">자세히</span>
					      <br />
					      <hr />
					      <br />
					    </div>
					    <div class="center card-image waves-effect waves-block waves-light">
					      <i class="activator large material-icons">dashboard</i>
					    </div>
					    <div class="col m12 card-reveal">
					      <span class="card-title grey-text text-darken-4"><strong>메모보드</strong>
					      <i class="small material-icons right">close</i>
					    </span>
					      
					      <br />
					      <hr />
					      <p>"메모보드"는 <br> 아이디어를 <br> 자유롭게 <br> 메모로 작성하고 <br> 팀원과 공유하며 <br> 발전시켜나가는 <br> 공간입니다.</p>
					    </div>
				    </div>
				</div>
				
				<div class="col m3 s6" onclick="location.href='../todo/todoGroup.jsp'">
					<div class="card small col m11 s12">
						<div class="card-content center">
					      <h5><strong><a href="#" class="grey-text text-darken-4">해야할일</a></strong></h5>
					      <span class="activator grey-text text-darken-1">자세히</span>
					      <br />
					      <hr />
					      <br />
					    </div>
					    <div class="center card-image waves-effect waves-block waves-light">
					      <i class="activator large material-icons">done</i>
					    </div>
					    <div class="col m12 card-reveal">
					      <span class="card-title grey-text text-darken-4"><strong>해야할일</strong>
					      <i class="small material-icons right">close</i>
					    </span>
					      
					      <br />
					      <hr />
					      <p>"해야할일"은 <br> 프로젝트를 <br> 진행함에 있어<br> 필요한 일들을 <br> 그룹 화하고 <br> 세부적으로 <br> 계획, 작성하는 <br> 공간입니다.</p>
					    </div>
				    </div>
				</div>
				
				<div class="col m3 s6" onclick="location.href='../checkin/checkList.jsp'">
					<div class="card small col m11 s12">
						<div class="card-content center">
					      <h5><strong><a href="#" class="grey-text text-darken-4">알리미</a></strong></h5>
					      <span class="activator grey-text text-darken-1">자세히</span>
					      <br />
					      <hr />
					      <br />
					    </div>
					    <div class="center card-image waves-effect waves-block waves-light">
					      <i class="activator large material-icons">alarm_on</i>
					    </div>
					    <div class="col m12 card-reveal">
					      <span class="card-title grey-text text-darken-4"><strong>알리미</strong>
					      <i class="small material-icons right">close</i>
					    </span>
					      
					      <br />
					      <hr />
					      <p>"알리미"는 <br>정해놓은 시간에<br> 지정한 팀원에게 <br> 메세지를 전송해주는 기능을 합니다.<br> 명심해야할 것이나  잊지 말아야 할 것을 놓치지 않게 <br>됩니다.</p>
					    </div>
				    </div>
				</div>
			</div>
		</div>
		<br /><br /><br />
	</div> <!-- container end -->
	</main>
	<%@ include file="../include/footer.jsp" %>
		
</body>
</html>