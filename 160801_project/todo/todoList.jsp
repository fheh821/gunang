<%@page import="vo.ProjectVO"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.TodoListVO"%>
<%@page import="dao.TodoListDAO"%>
<%@page import="vo.TodoGroupVO"%>
<%@page import="dao.TodoGroupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>one-tack!</title>
<script type="text/javascript"
   src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"> </script>
<script type="text/javascript" src="../js/httpRequest.js"></script>

<!-- Compiled and minified CSS -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/css/materialize.min.css">
<!-- Compiled and minified JavaScript -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/js/materialize.min.js"></script>
<!--Import Google Icon Font-->
      <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<!--Import materialize.css-->
      <link type="text/css" rel="stylesheet" href="../css/materialize.min.css"  media="screen,projection"/>
<!--Let browser know website is optimized for mobile-->
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
      
<!-- alert -->
<script src="../js/sweetalert.min.js"></script> 
<link rel="stylesheet" type="text/css" href="../css/sweetalert.css">


<script type="text/javascript" src="../js/materialize.min.js"></script>
      
<style>

body {
    display: flex;
    min-height: 100vh;
    flex-direction: column;
  }

  main {
    flex: 1 0 auto;
  }
.tlContent{
	height : 450px;
}
</style>
</head>
<body class="grey lighten-5">
<%@ include file="../include/nav.jsp" %>
<main>
   <%
   request.setCharacterEncoding("UTF-8");
   response.setContentType("text/html;charset=UTF-8");   
   // session에 저장되어 있는 pno 가져오기
   int pNo = Integer.parseInt(session.getAttribute("pno").toString());
   // session에 저장되어있는 gno가져오기
   
   		ProjectDAO pdao = new ProjectDAO();
   		ProjectVO pvo = pdao.selectOne(pNo);
   
   String isComplete = request.getParameter("isComplete");
   System.out.println("isComplete : " +  isComplete);
   
      String g = request.getParameter("groupno");
      int groupno = Integer.parseInt(g);

      TodoGroupDAO groupdao = new TodoGroupDAO();
      TodoGroupVO groupvo = groupdao.selectOne(groupno);
      TodoListDAO listdao = new TodoListDAO();

      ArrayList<TodoListVO> list = listdao.selectAll(groupno, pNo);
   %>
   <script type="text/javascript">
   function saveTodoState(){
      if(xhr.readyState == 4 && xhr.status == 200){
         //console.log("ajax 완료");
      }
   }
   $(function(){
      $("input:checkbox").on("click", function(){
         var listno = $(this).attr('value');
         var isComplete = $(this).prop("checked");//체크여부 true / false
         var params = "listno=" + listno + "&isComplete=" + isComplete;
         sendRequest("saveTodoListState.jsp", params, saveTodoState, "GET");
         });
      
      
      
      $("#modify").on("click",function() {
    		swal({
				title : "수정하시겠습니까?",
				text : "당신이 작성한 일정을 수정합니다!",
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#DD6B55",
				confirmButtonText : "예, 수정합니다!",
				closeOnConfirm : true
			}, function() {
				  location.href = "todoGroupModify.jsp?groupno="+<%=groupvo.getGroupNo()%>;			
				});
      		});
      });
   

   
</script>

<div class="container">
	
	
<!-- menuNav --> 
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
		
		<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->
		    <div class="row">
		          <div class="col m10 offset-m1">
		               
		          	<div class="col m10 offset-m1">
		          		<div class="center">
		            		<a href="todoGroup.jsp" id="todogroup" class="black-text"><h6><strong>이전 페이지로 이동</strong></h6></a>
		            	</div>
		            	<%-- <a href="todoListWriteForm.jsp?groupno=<%=groupvo.getGroupNo()%>" id="listadd">LISTADD</a> --%>
		                
		        	</div>		
		        	<div class="tlContent col m10 offset-m1 grey lighten-2 z-depth-1">
		        		<br />
		        		<div class="col right">
		               		 <button id="modify" class="waves-effect waves btn green accent-4 z-depth-1">수정</button>
		                </div>
		        		<div class="col right">
		               		 <a href="todoListWriteForm.jsp?groupno=<%=groupvo.getGroupNo()%>"><button id="modify" class="waves-effect waves btn red accent-4 z-depth-1">추가</button></a>
		                </div>
		                <br />
					      	   <div class="col m10 offset-m1">
		        	
						        	<h4><strong><%=groupvo.getGroupTitle() %></strong></h4>
						        
						        
						        	<h5><%=groupvo.getGroupContents() %></h5>
		        	
		         <!-- todolist 가져오기 -->
		         <hr />
		         <h6><strong>할일 목록</strong></h6>
		         <%
		         // text를 눌렀을때 그룹번호? 를 넘겨준다?
		         for(int k = 0; k < list.size(); k++){
		         TodoListVO listvo = new TodoListVO();
		         listvo = list.get(k);
		                  
		         // 완료여부에 따른 체크박스 체크여부 결정하기 
		         
		                  
		         %>
		         <div>
		            <input type="checkbox" name="test" id="test<%=listvo.getListNo()%>" value=<%=listvo.getListNo() %>
		            <%
		            String isCompleted = "";
		            if(listvo.getIsComplete() == 1) // 0: 미완료  1: 완료
		            {
		               isCompleted = "checked"; // 속성에 checked가 들어가면, 체크된 상태로 나온다.
		            
		            %>
		               <%=isCompleted %><%} %>/>
		               
		               <label for="test<%=listvo.getListNo()%>"><a class="" href="todoListDetail.jsp?listNo=<%=listvo.getListNo()%>"><%=listvo.getListTitle() %></a></label>
		         </div>
		         <% 
		         } // 안쪽 for문 end
		         
		            %>
		      </div>
		        </div>
		        <!--  
		        <div class="col m12 center">
		           <a href="todoListWriteForm.jsp?groupno=<%=groupvo.getGroupNo()%>" id="listadd"><i class="material-icons medium tooltipped" data-position="bottom" data-delay="50" data-tooltip="새로운 리스트를 생성합니다">library_add</i></a>
		 		</div>
		 		-->
		      </div>
	      </div>
	      </div>
      </main>
      <%@ include file="footer.jsp" %>
</body>
</html>