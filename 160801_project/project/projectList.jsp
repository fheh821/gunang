<%@page import="vo.MemberVO"%>
<%@page import="vo.ProjectVO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProjectMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1.0" />
<title>one-tack!</title>
<!-- CSS  -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link href="../css/materialize.css" type="text/css" rel="stylesheet"
	media="screen,projection" />
<link href="../css/style.css" type="text/css" rel="stylesheet"
	media="screen,projection" />

<!--  Scripts-->
<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script src="../js/materialize.js"></script>
<script src="../js/init.js"></script>

<script type="text/javascript" src="../js/httpRequest.js"></script>
<script type="text/javascript" 
src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"> </script>
<script type="text/javascript">
 	$(function(){
		$(".delete").on("click", function(){
			console.log("삭제버튼눌림");
			var id = $(this).attr('id');
			
			location.href = "deleteProjectOk.jsp?pno=" + id;
		});
	}); 
</script>
<style>
div{
	<!--border : 1px solid black;-->
}

.projectCard{
	text-align : center;
	margin-bottom : 20px;
}

body {
    display: flex;
    min-height: 100vh;
    flex-direction: column;
  }

main {
    flex: 1 0 auto;
}

.close-thik:after {
  content: '✖'; /* UTF-8 symbol */
}
#titleAndXbtn{
	margin: 0px;
}

.white-text:hover {
	cursor: pointer;
}
</style>
</head>
<body class="no-pad-bot grey lighten-5">
	<%
		// session에 저장되어있는 memno 가져오기
		Object obj = session.getAttribute("memno");
		if(obj == null){
			response.sendRedirect("../login/login.jsp");
		}else{
	%>
	<main>
		<div id="total">
			
			<%@ include file="../include/nav.jsp" %>
			
			<div class="container">
			<div class="">
			<br /><br />
			<h4 class="header center light grey-text text-darken-2">
				<strong>One-tack! 에 오신 것을 환영합니다.</strong>
			</h4>
			<br />
			
	
			<%
				// obj = session.getAttribute("memno");
				int memNo = Integer.parseInt(obj.toString()); 
			
				ProjectMemberDAO pmdao = new ProjectMemberDAO();
				ProjectDAO pdao = new ProjectDAO();
				MemberDAO mdao = new MemberDAO();
				
			%>
			<div id="projectContainer " class="row"> 
				
				<% 
				ArrayList<Integer> projects = pmdao.selectAllProject(memNo);
				if(projects.size() == 0){ // 참여중인 프로젝트가 없을 경우!
			%>
				<div class="row center">
						<h5 class="header col s12 light grey-text"><strong>참여 중인 프로젝트가 없습니다.</strong></h5>
						<h5 class="header col s12 light grey-text"><strong>프로젝트를 생성해주세요.</strong></h5>
						
						<div class="col s10 offset-s1">
						<br />
							<a href="createProject1.jsp" class="white-text">
								<div class="projectCard col s6 offset-s3">
									<div class="card-panel projectInfo green accent-4 z-depth-2">
										<div class="row" id="titleAndXbtn"> 
											<div class="col s12"><h6><strong>새로운 프로젝트 만들기</strong></h6></div>
										</div>
									</div>
								</div>
							</a>
						</div>
				</div>
				<%
				}else{
					%>
					<div class="row center">
						<h5 class="header light grey-text"><strong>참여 중인 프로젝트</strong></h5>
					</div>
					<div class="col s10 offset-s1">
					<hr />
				<%
					for(int i = 0; i < projects.size(); i++){
						ProjectVO pvo = pdao.selectOne(projects.get(i));
				%>
					<div class="projectCard col s4" >
						<div class="card-panel projectInfo light-blue darken-3 z-depth-2">
							<div class="row" id="titleAndXbtn">
								<div class="col s8" onclick="location.href='project.jsp?pno=<%=pvo.getpNo() %>'"><h6 class="card-title white-text"><%=pvo.getpName() %></h6></div>
								<div class="col s2 offset-s2 delete" id="<%=pvo.getpNo()%>"><a href="#" class="close-thik white-text"></a></div>
							</div>
							<hr />
							
						</div>
					</div>
					
				
	
				<%
					} // for end
				%>
						<a href="createProject1.jsp" class="white-text">
							<div class="projectCard col s4">
								<div class="card-panel projectInfo green accent-4 z-depth-2">
									<div class="row" id="titleAndXbtn"> 
										<div class="col s12 "><h6>새로운 프로젝트 만들기</h6></div>
									</div>
									<hr />
								</div>
							</div>
						</a>
			<%		
				} // else end
			%>
			</div>
				</div> <!-- projectContainer -->
				</div>
			</div> <!-- container end -->
		</div> <!-- total end -->
	 </main> <!-- main end -->	
	 <%@ include file="../include/footer.jsp" %>
	 <%
		} // if else end
	 %>
	 
</body>
</html>