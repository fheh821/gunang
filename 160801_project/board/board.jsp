<%@page import="vo.CardReplyVO"%>
<%@page import="dao.CardReplyDAO"%>
<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="vo.ProjectVO"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="vo.CardVO"%>
<%@page import="dao.CardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.BoardDAO"%>
<%@page import="vo.BoardVO"%>
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
  <script src="../js/materialize.js"></script>
  <script src="../js/init.js"></script>
  
  <!-- Sweet Alert -->
  <script src="../js/sweetalert.min.js"></script> 
  <link rel="stylesheet" type="text/css" href="../css/sweetalert.css">


	<!--CSS영역-->
	<style type="text/css">
	.addBoardForm, .addCardForm{
		display:inline;
	}
	.cardGroup{width:100%; height:600px; overflow:auto}
	
	.wrapper {width: 100%; height: 100%; white-space: nowrap; }
	
	.cardNode{
		width : 180px;
		display: inline-block;
		float : left;
		margin : 0px 20px 20px 20px;
	}
	
	.cardTitle{
		margin : 10px;
		padding : 5px;
	}
	
	.cardName{
		margin : 0px 10px 10px 10px;
		padding : 5px;
	}
	
	.cancelBtn{
		margin-left : 10px;
		font-size : 1.5em;
		font-weight : bold;
		text-aligin: center;
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
<%  
	//session에서 pno 받아옴
	int pno = (int)session.getAttribute("pno");
	
	//session에서 다른 값 받아옴 (test)
	String email = (String)session.getAttribute("email");
	String pw = (String)session.getAttribute("password");
	int memNo = (int)session.getAttribute("memno");

	ProjectDAO pdao = new ProjectDAO();
	ProjectVO pvo = pdao.selectOne(pno);
	BoardDAO bDao = new BoardDAO();	
	ArrayList<BoardVO> bList = bDao.selectAll(pno);
	int bListSize = bList.size();
	System.out.println(bListSize);
%>
	<!--SCRIPT영역-->
	<script type="text/javascript">
		
		$(function(){
			var cardWidth = $('.cardNode').outerWidth(true);;
			var circle = <%=bListSize %>;
			//console.log(circle);
			var cardsWidth = (cardWidth * circle) + cardWidth;
			//console.log(cardsWidth);
			var locFrom;
			
			if(cardsWidth>$('.wrapper').outerWidth(true)){
				$('.wrapper').css('width', cardsWidth);
			};
			$('.cardGroup').scrollLeft($('.wrapper').outerWidth(true));
			
			$(".addBoardForm").hide();
			$(".addCardForm").hide();
			
			$(".addList").on("click", function(){
				console.log("addList눌림");
				$(".addBoardForm").show();
			});	
			
			$(".addToggle").on("click", function(){
				//console.log("토글눌림");
				if($(this).siblings("form").css("display")=="none"){
					$(this).siblings("form").show();
				} else {
					$(this).siblings("form").hide();
				}
				
			});
			
			$(".cancelBtn").on("click", function(){
				//console.log("cancelBtn 눌림");
				$(this).parents("form").hide();
			});
			
			
			$("#btnDeleteList").on("click", function(){
				//console.log("삭제 전 wrapper : " + $(".wrapper").outerWidth(true));
				//console.log("버튼눌림");
				$(".wrapper").css('width', '-='+cardWidth);
				//console.log("삭제 후 wrapper : " + $(".wrapper").outerWidth(true));
			});	   
			
			//내용이 null일 시 알림창 띠우게 함
			$(".btnAddCard").on("click", function(){
				console.log("버튼눌림");
				
				
				if($(this).siblings("input").val()==""){
					swal("내용을 입력해주세요");
				} else {
					$(this).attr("type", "submit");
				}
				
				
			});
			
			$("#btnAddList").on("click", function(){
				if($("#addedList").val()=="" || $("#addedList").val()==null){
					swal("메모의 제목을 입력해주세요");
					
				} else {
					$(this).attr("type", "submit");
				}
			});
						
		});
	</script>
</head>
<body class="no-pad-bot grey lighten-5">	
<%@include file="../include/nav.jsp" %>
	<main>
	<div class="container">
	<!-- menuNav --> 
		<br />
		<h4 class="header center"><strong><a href="../project/project.jsp?pno=<%=pno%>" class="grey-text text-darken-3"><%=pvo.getpName() %></a></strong></h4>
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
	
	
	<!-- cardGroup -->	
	<div class="cardGroup col m10 offset-m1 s12 z-depth-4">
		<div id="wrapper" class="wrapper  grey darken-3">
		<br />
		
		<%
		for(BoardVO bVo : bList){
		%>
			<div>
			<div class="cardNode col m3 s6 grey lighten-2 z-depth-2">
				 <div class="col m11 s12 grey-text text-darken-4">
				 	<div class="cardTitle">
	              		<h6><strong><%=bVo.getBoardTitle()%></strong></h6>
	              		<hr />
	              	</div>
	             <!-- 리스트 삭제 -->
	             	<form action="boardDeleteOk.jsp">
						<input type="hidden" name="boardNo" value="<%=bVo.getBoardNo() %>" />
						<input id="btnDeleteList" type="hidden" value="X"/>
						<!--  <input id="btnDeleteList" type="submit" value="X"/>-->
				    </form>
				<!-- 리스트 삭제 -->
				 
					<%
					
					CardDAO cDao = new CardDAO();
					ArrayList<CardVO> cList = cDao.selectAll(pno, bVo.getBoardNo());
	
					for(CardVO cVo : cList){
					%>

					 <a class="grey-text text-darken-2" href="cardDetail.jsp?boardNo=<%=cVo.getBoardNo() %>&cardNo=<%=cVo.getCardNo()%>">
					<!--  <a class="grey-text text-darken-2 modal-trigger" href="#modal1?boardNo=<%=cVo.getBoardNo() %>&cardNo=<%=cVo.getCardNo()%>"> -->
						<div class="cardName white z-depth-1">
							<h6>
								
									<!-- 
										cVo.getCardWriter() 
									 -->
									<%=cVo.getCardTitle() %>
							</h6>
						</div>
					</a>
					<div>
					
				<!-- 카드 삭제 -->
					<form action="cardDeleteOk.jsp">
							<input type="hidden" name="cardNo" value="<%=cVo.getCardNo()%>"/>
							<input type="hidden" name="cardTitle" id="" value="<%=cVo.getCardTitle() %>"/>
							<%-- <input type="text" name="cardContents" id="" value="카드내용 : <%=cVo.getCardContents()%>"/> --%>
							<input readonly type="hidden" name="cardWriter" id="" value="<%=cVo.getCardWriter()%>" />
						<input id="btnDeleteCard" type="hidden" value="X" onclick="return confirm('정말로 삭제하시겠습니까?')"/> 
						<!--  <input id="btnDeleteCard" type="submit" value="X" onclick="return confirm('정말로 삭제하시겠습니까?')"/> -->
					</form>	
				<!-- 카드 삭제  -->
					</div>
					
					<%
					}			
					%>
					<div class="addCard" >
						<div class="addToggle">
						<div class="cardTitle">
							<h6 id="addToggle"><strong>메모 더하기</strong></h6>
							<hr />
						</div>
						</div>
						
						<form class="addCardForm" id="<%=bVo.getBoardNo()%>" action="cardWriteOk.jsp">
							<div class="cardName">
								<div class="addCardDetail">
									<div class="hiddenCard">
										<!-- hidden type으로 boardNo가져옴  -->
										<input type="hidden" name="boardNo" value="<%=bVo.getBoardNo() %>" />
										<input type="text" id="addedCard" class="addedCard cardName white grey-text text-darken-4 z-depth-2" name="cardTitle" placeholder="" autocomplete="off" >
									</div>	
									<div>
										<!--  카드내용
										<input type="text" id="addedCard" class="cardName white" name="cardContents" placeholder="카드내용" autocomplete="off" >
										<br />
										-->
										<input class="btnAddCard waves-effect waves btn green accent-4" id="btnAddCard" type="button" value="더하기">
										
										<span class="cancelBtn">X</span>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			</div>
		<%
		}
		%>	
		 
		<div class="cardNode col m3 s6 red darken-1 z-depth-4">
			<div class="">
				<div class="addList white-text">
					<div class="cardTitle">
					<h6><strong>메모목록 더하기</strong></h6>
					</div>
				</div>
				<form class="addBoardForm" action="boardWriteOk.jsp">
					<div class="cardName" id="addListDetail">
						<div>
							<input class="white z-depth-4" id="addedList" type="text" name="boardTitle" autocomplete="off" >	
							<br />
							<input id="btnAddList" class="waves-effect waves btn red darken-4" type="button" value="더하기">
							<span class="cancelBtn gray-text">X</span>
						</div>
					</div>
				</form>
			</div>
		</div>	
	</div>	
</div>
		<br /><br />
	</div>
</main>
<%@include file="../include/footer.jsp" %>	


  
  

</body>
</html>