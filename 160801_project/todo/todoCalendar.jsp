
<%@page import="vo.ProjectVO"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="vo.TodoGroupVO"%>
<%@page import="dao.TodoGroupDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.TodoListVO"%>
<%@page import="dao.TodoListDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
h1{
font-weight: bold;
text-align: center;
}
body {
    display: flex;
    min-height: 100vh;
    flex-direction: column;
  }

  main {
    flex: 1 0 auto;
  }
#calendar{
	width: 90%;
	margin : auto;
	margin-top : 40px;
	margin-bottom : 40px;
}
</style>
<html>

<head>
<meta charset="UTF-8">
<title>one-tack!</title>
<link rel='stylesheet' href='css/fullcalendar.min.css' />
<script src='js/jquery.min.js'></script>
<script src='js/moment.min.js'></script>
<script src='js/fullcalendar.min.js'></script>
	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
      <script src="//cdn.ckeditor.com/4.5.10/basic/ckeditor.js"></script>
<script type="text/javascript" src="../js/materialize.min.js"></script>


	<style type="text/css">
		h2{
		font-size: 30px;
		font-weight: bold;
		}
		
	</style>
	
	<%
	    
	    // 일단 테스트를 위해 groupno와 pno는 임의로 주었소 (광해)
	    int pNo = (int) session.getAttribute("pno");
	    System.out.println("pNo : " + pNo);
		TodoListDAO tlDao = new TodoListDAO();
		TodoListVO tlVo = new TodoListVO();
	    
	    ArrayList<TodoListVO> tlList = tlDao.calendarAll(pNo);
	    int[] listNo = new int[100];
	    int[] groupNo = new int[100];
	    String[] listTitle = new String[100];
	    String[] startDate = new String[100];
	    String[] endDate = new String[100];
	    String[] color = new String[100];
	    int tlSize = tlList.size();
	    
	    for(int i=0; i<tlList.size(); i++){
	    	tlVo = tlList.get(i);
	    	listNo[i] = tlVo.getListNo();
	    	groupNo[i] = tlVo.getGroupNo();
	    	listTitle[i] = tlVo.getListTitle();
	    	startDate[i] = tlVo.getStartDate();
	    	endDate[i] = tlVo.getEndDate();
	    	//System.out.println(listTitle[i]);
	    }
	    
	   	ProjectDAO pdao = new ProjectDAO();
	   	ProjectVO pvo = pdao.selectOne(pNo);
	    
	    TodoGroupDAO tgDao = new TodoGroupDAO();
	    TodoGroupVO tgVo = new TodoGroupVO();
	    for(int i=0; i<tlList.size(); i++){
	    	color[i] = "'"+tgDao.getColor(groupNo[i])+"'";
	    	//System.out.println(color[i]);
	    };
	    
	   	//색상 배열만들기
	   	String listColor[] = {
	   		"#ffcdd2", "#f8bbd0","#e1bee7","#d1c4e9","#c5cae9","#bbdefb","#b3e5fc","#b2ebf2",
	   		"#b2dfdb","#c8e6c9","#dcedc8","#f0f4c3","#fff9c4","#ffecb3","#ffe0b2","#ffccbc",
	   		"#d7ccc8","#f5f5f5","#cfd8dc"
	   	};
	%>	
	
	<script type="text/javascript">	 	
		var toDo = new Array();
		var tlSize =<%=tlSize%>;
	 	toDo = [
	 	        <%for(int i =0 ;i<51;i++){
	 	        	if(i==50){
	 	        		%>
	 	        		 {
	 	 	            	"listNo":"<%=listNo[i]%>","listTitle":"<%=listTitle[i]%>", "startDate":"<%=startDate[i]%>", "endDate":"<%=endDate[i]%>"
	 	 	            	}
	 	        		<%
	 	        		break;
	 	        	}else{
		 	        %>
		 	
		 	            {
		 	            	"listNo":"<%=listNo[i]%>","listTitle":"<%=listTitle[i]%>", "startDate":"<%=startDate[i]%>", "endDate":"<%=endDate[i]%>"
		 	            	},
		 	           <%
	 	        			}
	 	        		}
	 	        		%>
	 	            
	 	
	 	];

	 	$(document).ready(function() {
		    // page is now ready, initialize the calendar...

			    $('#calendar').fullCalendar({
			        // put your options and callbacks here
			        
			    //월 이름
			    monthNames : ['1월', '2월', '3월', '4월', '5월', '6', '7월',
			                  '8월', '9월', '10월', '11월', '12월'],
			    //요일 이름  
				dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
			    
				//헤더 형식
				header : {
			    left:   'title',
			    center: '',
			    right:  'today, prev,next'
				},
				
				
				//타이틀 형식
			    titleFormat : 'YYYY년 MMMM',
			
			    events: [
			             <%
			             	for(int i = 0 ;i<51;i++){
			             		if(i==50){
			             			%>
			             			 {	 
						                 title: toDo[<%=i%>].listTitle,
						                 start: toDo[<%=i%>].startDate,
						                 end: toDo[<%=i%>].endDate,
						                 url: 'todoListDetail.jsp?listNo='+toDo[<%=i%>].listNo,
						             	 color : '<%=listColor[(i%18)]%>',
						                 
						             }
			             			<%
			             		}else{
			             %>
			            	 {	 
				                 title: toDo[<%=i%>].listTitle,
				                 start: toDo[<%=i%>].startDate,
				                 end: toDo[<%=i%>].endDate,
				                 url: 'todoListDetail.jsp?listNo='+toDo[<%=i%>].listNo,
				             	 color : '<%=listColor[(i%18)]%>',
				             	 //color의 배열의 크기는 0부터 18까지 i는 50까지 여기서 color의 index값을 
				             	 //배열의 크기만큼 나누면 for문을 돌때 18을 넘어갈 수 없다!!
				                 
				             },
				             
				             <%
			             		}
			             	}
				             %>
				             
			         ],
			         //event end
			       			         
			         eventClick: function(event) {
			             if (event.url) {
			                 window.replace(event.url);
			                 return false;
			             }
			         }
			  
			}) //funciton end
		
			
			
		})
	</script>
	
</head>
<body>
<%@ include file="../include/nav.jsp" %>
<main>
	<div class="container" id="Container">
		<!-- menuNav --> 
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
		
		
	<div class="todoContents brown darken-2 z-depth-4">
		<div id="toDoNav" class="row">
			<div class="center">
				<br />
				<a href="todoGroupWriteForm.jsp" class="col m4 offset-m4 waves-effect waves btn green accent-4 z-depth-4">할 일 목록 추가</a>
			</div>
			<div class="col m10 offset-m1">
				<br />
				<a class="col m2 left white-text" href="todoGroup.jsp" id="cardview"><strong>카드로 보기</strong></a>
				<a class="col m2 left white-text" href="todoCalendar.jsp"><strong>달력으로 보기</strong></a>
			</div>
		</div>
	<div class="row center">
		<div class="col m10 offset-m1 grey lighten-4">
			<div class="grey lighten-4" id='calendar'></div>
		</div>
	</div>	
	<br />
	<br />
	</div>
	<br />
	<br />
	</div>
	</main>
<%@ include file="footer.jsp" %>
</body>
</html>