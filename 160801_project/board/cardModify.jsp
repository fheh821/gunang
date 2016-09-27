<!DOCTYPE html>
<%@page import="vo.ProjectVO"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CardReplyDAO"%>
<%@page import="vo.CardReplyVO"%>
<%@page import="dao.CardDAO"%>
<%@page import="vo.CardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta charset="utf-8">
        <title>one-tack!</title>
        
  <!-- CSS  -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="../css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="../css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <!--SCRIPT-->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script type="text/javascript" src="../js/materialize.min.js"></script>
  <script src="../js/materialize.js"></script>
  <script src="../js/init.js"></script>
  <script src="//cdn.ckeditor.com/4.5.10/basic/ckeditor.js"></script>
        
        <style type="text/css">
        	.cardEdit{
         		width : 100%;
         	}
         	.btnCardModify, .cancelCardModify{
         		margin: 10px;
         	}
         	
         	.cardWhite{
         		margin-bottom : 20px;
         	}
         	.modifyForm{
         		padding-bottom : 30px;
         	}
         	#cardTitle{
         		font-size : 2em;
         		font-weight : bold;
         	}
         	
        </style>
        
        <script>
         	$(function(){
         		CKEDITOR.replace('cardContents');	
         	});
        </script>
    </head>
    <body>
    <%@include file="../include/nav.jsp"%>
    <%
    	int pno = (int) session.getAttribute("pno");
		String cardNo = request.getParameter("cardNo");
		
		ProjectDAO pDao = new ProjectDAO();
		ProjectVO pVo = pDao.selectOne(pno);
		
		CardVO cVo = new CardVO();
		CardDAO cDao = new CardDAO();
		
		cVo = cDao.selectOne(Integer.parseInt(cardNo));
	%>
	<div class="container">
	<!-- menuNav --> 
		<br />
		<h4 class="header center"><strong><a href="../project/project.jsp?pno=<%=pno%>" class="grey-text text-darken-3"><%=pVo.getpName() %></a></strong></h4>
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
		
<!-- contents -->
		<div class="modifyForm row col m10 offset-m1 s12 grey darken-3 z-depth-4">
			<div class="col m12">
				<div class="center col m8 offset-m2 s12">
						<h6 class="moveBefore"><strong><a class="white-text" href="javascript:history.go(-1)">이전 페이지로 이동</a></strong></h6>
				</div>
				<div class="card col m8 offset-m2 s12 grey lighten-2 z-depth-1">
					<br />
					
					<div class="cardWhite col m12 s12 white">
						<div class="cardEdit">
				    		<form action="cardModifyOk.jsp">
				    			<input type="hidden" name="boardNo" value="<%=cVo.getBoardNo() %>"/>
				    			<input type="hidden" name="cardNo" value="<%=cVo.getCardNo() %>" />
				    			<input type="text" name="cardTitle" id="cardTitle" value="<%=cVo.getCardTitle() %>"/>
					        	
					        	<textarea name="cardContents"><%=cVo.getCardContents() %></textarea>
					        	<div class="center">
						        	<input class="btnCardModify waves-effect waves btn green accent-4 z-depth-1" type="submit" value="수정" />
					        		<a href="javascript:history.go(-1)"><input class="cancelCardModify waves-effect waves btn green accent-4 z-depth-1" type="button" value="취소" /></a>
				        		</div>
				        	</form>
				        </div>
					</div>
				</div>
			</div>	<!-- dark -->
    </div>
    <br /><br />
    </div>   
    <%@include file="../include/footer.jsp" %>
    </body>
</html>