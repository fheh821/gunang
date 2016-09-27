<%@page import="vo.ProjectVO"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="dao.CardReplyDAO"%>
<%@page import="vo.CardReplyVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="vo.CardVO"%>
<%@page import="dao.CardDAO"%>
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
  <script src="../js/materialize.js"></script>
  <script src="../js/init.js"></script>
	
	
	
	<style type="text/css">
		/*
		div{
			border : 1px solid black;
		}
		*/
		
		.changeBtn, .moveBefore{
			margin : 10px;
		}
		.cardDetailHeader, .cardDetailContents, .cardTitle, .cardContents, .replyNode, .replyWriter, .replyContents{
			margin-top : 10px;
			margin-bottom : 10px;
		}
		.cardWhite{
			margin-bottom : 20px;
		}
		
		.cardContents{
			overflow: visible;
			overflow-y:auto;
			
			height: 180px;
		}
		.replyList{
			overflow: visible;
			overflow-y:auto;
			
			height: 150px;
		}
		.card, .reply{
			margin-botton : 20px;
		}
		
		.replyWriter, .replyContents, .replyInput{
			float : left;
			margin : 10px;
		}
		
		.replyContents{
			width: 65%;
			height: 38px;
		}
		
		.replyInput{
			width:15%;
			height: 100%;
		}
	
	</style>
	<script type="text/javascript">
		$(function(){
			$(".replyList").scrollTop($(".replyList")[0].scrollHeight);
		});
	
	
	</script>
</head>
<body class="grey lighten-5">
<%@include file="../include/nav.jsp" %>
	<%
		String cardNo = request.getParameter("cardNo");
		int pno = (int) session.getAttribute("pno");
		int memNo = (int)session.getAttribute("memno");
		
		ProjectDAO pDao = new ProjectDAO();
		ProjectVO pVo = pDao.selectOne(pno);
		
		CardVO cVo = new CardVO();
		CardDAO cDao = new CardDAO();
		
		MemberDAO mDao = new MemberDAO();
	    MemberVO mVo = new MemberVO();
	    
	    mVo = mDao.selectOne(memNo);
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
	<div class="row col m10 offset-m1 s12 z-depth-4">
		<div class="col m12 grey darken-3">
			<div class="center col m8 offset-m2 s12">
					<h6 class="moveBefore"><strong><a class="white-text" href="javascript:history.go(-1)">이전 페이지로 이동</a></strong></h6>
			</div>
			<div class="card col m8 offset-m2 s12 grey lighten-2 z-depth-1">
				<div class="changeBtn col m2 right waves-effect waves btn red darken-1 z-depth-1">
					<section id="btnCardDelete">
						<a class="white-text" href="cardDeleteOk.jsp?cardNo=<%=cVo.getCardNo()%>">
							<input type="button" value="삭제" />
						</a>
					</section>
				</div>
				
				<div class="changeBtn col m2 right waves-effect waves btn green accent-4 z-depth-1" id="cardDetail">
					<section id="btnCardModify">
						<a class="white-text" href="cardModify.jsp?cardNo=<%=cVo.getCardNo()%>">
							<input type="button" value="수정" />
						</a>
					</section>
				</div>
				
				<br /><br />
				
				<div class="cardWhite col m12 s12 white">
					<div class="cardDetailHeader">
						<div class="cardWriter chip grey darken-2"><h6 class="white-text"><strong><%=cVo.getCardWriter() %></strong></h6></div>
						<div class="cardDate chip grey">
							<h6 class="white-text"><%=cVo.getCardDate() %></h6>
						</div>
						<hr />
					</div>	
					
					<div class="cardDetailContents">
						<div class="cardTitle center">
							<h5><strong><%=cVo.getCardTitle() %></strong></h5>
							<hr />
						</div>
						<div class="cardContents">
							<%=cVo.getCardContents() %>
						</div>
					</div>
				</div>
			</div>
			
	<!-- 리플 목록 -->	
			<div class="reply col m8 offset-m2 s12">
			<hr />			
				<div class="replyList col m12 s12">
					
		<% 
			String boardNo = request.getParameter("boardNo");
			CardReplyDAO crDao = new CardReplyDAO();
	    	ArrayList<CardReplyVO> crList = crDao.selectAll(pno, Integer.parseInt(boardNo));
	    	for(CardReplyVO crVo : crList){
	   	%> 	
			   		<div class="replyNode"> 
			   			<div class="chip light-blue darken-2 white-text"><h6><strong><%=crVo.getCardReplyWriter()%></strong></h6></div>
			   			<div class="chip white"><h6><strong><%=crVo.getCardReplyContents()%></strong></h6></div>
			   			<div class="chip grey darken-4 right white-text"><h6><strong><%=crVo.getCardReplyDate()%></strong></h6></div>
			        </div>
	   	<%	
	    	}
	    %>
				</div>
				<hr />
			</div>
		<div class="reply col m8 offset-m2 s12">
			<div class="col m12 s12">
				<div class="replyForm">
			    		<form action="cardReplyWriteOk.jsp">
			    			<input type="hidden" name="cardNo" value="<%=cVo.getCardNo() %>"/>
			    			<input type="hidden" name="pNo" value="<%=cVo.getpNo() %>" />
			    			<input type="hidden" name="boardNo" value="<%=cVo.getBoardNo()%>" />
			    			<input type="hidden" name="cardReplyWriter" id="" value="<%=mVo.getName() %>" readonly />
			    			
				    		<div class="replyWriter chip light-blue darken-4 white-text"><h6><strong><%=mVo.getName() %></strong></h6></div>
					    	<div class="replyContents white"><input type="text" name="cardReplyContents" id="" /></div>
					    	<div class="replyInput"><input class="waves-effect waves btn green accent-4 z-depth-1" type="submit" value="댓글 등록" /></div>
					    	<br /><br /><br /><br />
					    </form>
				    </div>  
			    </div>	
	    	</div>
    	</div>	
    </div>
    <br /><br />
	</div>
<%@include file="../include/footer.jsp" %>
</body>

</html>