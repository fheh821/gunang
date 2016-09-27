<%@page import="dao.ProjectMemberDAO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="vo.MemberVO"%>
<%@page import="vo.CheckAlarmVO"%>
<%@page import="dao.CheckAlarmDAO"%>
<%@page import="vo.ProjectVO"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="vo.CheckreplyVO"%>
<%@page import="dao.CheckreplyDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.CheckinVO"%>
<%@page import="dao.CheckinDAO"%>
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

 <!--  Scripts-->
 <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
 <script src="../js/materialize.js"></script>
 <script src="../js/init.js"></script>
<%@ include file="../include/nav.jsp" %>

<style type="text/css">

	#replyWrap{
		height: 200px;
		overflow : auto;
		padding: auto 100px;
	}
	.checkList{
		padding: auto 30px;
		border-radius: 20px;
		margin: 0px;
	}
	
	.titletop{
		margin: 10px 100px 10px 100px;	
		padding 10%;
		border-radius: 30px;
	}
	.close-thik:after {
     	content: '✖'; /* UTF-8 symbol */
   	}
   	img{
   		width: 30px;
   		height: 30px;
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
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"></script>
<script type="text/javascript">

</script>
</head>
<body class="grey lighten-5">
<main>
<div class="container">	
   
   
 <!-- menuNav --> 
<%
	String smemno = session.getAttribute("memno").toString();// 멤버번호 pasing
	String spno = session.getAttribute("pno").toString();// 멤버번호 pasing
	int memno = Integer.parseInt(smemno);
	int pno = Integer.parseInt(spno);

	ProjectDAO pdao = new ProjectDAO();
	ProjectVO pvo = pdao.selectOne(pno);
%>  
   <h4 class="header center"><strong><a href="../project/project.jsp?pno=<%=(int)session.getAttribute("pno")%>" class="grey-text text-darken-3"><%=pvo.getpName() %></a></strong></h4>
   <div class="row center">
      <div class="col m8 offset-m2 s12">
         <div class="col m3">
            <a href="../chatting/chatTest.jsp" class="waves-effect waves-light btn-large light-blue darken-2"><i class="material-icons left">chat</i>채팅</a>
         </div>
         <div class="col m3">
            <a href="../board/board.jsp" class="waves-effect waves-light btn-large light-blue darken-2"><i class="material-icons left">dashboard</i>보드</a>
         </div>
         <div class="col m3">
            <a href="../todo/todoGroup.jsp" class="waves-effect waves-light btn-large light-blue darken-2"><i class="material-icons left">done</i>할일</a>
         </div>
         <div class="col m3">
            <a href="../checkin/checkList.jsp" class="waves-effect waves-light btn-large light-blue darken-2"><i class="material-icons left">alarm_on</i>알림</a>
         </div>
      </div>
   </div>
	
<div class="row" id="total">

	<%
	String b = request.getParameter("cno");
	//System.out.println("checknum:"+b);
	int checkno = 0;
	
	if (!(b == null || b.equals(""))) { 		
		checkno = Integer.parseInt(b);
	}
	MemberDAO mdao = new MemberDAO();	
	CheckinDAO cidao = new CheckinDAO();
	CheckreplyDAO crdao = new CheckreplyDAO();
	CheckinVO civo = cidao.selectOne(checkno);
	CheckreplyVO crvo = new CheckreplyVO();
	CheckAlarmDAO cadao = new CheckAlarmDAO();
	CheckAlarmVO cavo = new CheckAlarmVO();
	ProjectMemberDAO pmdao = new ProjectMemberDAO();
	
	
%>	
		<div class="row">
			<br />
			<div class="center">
		     <a href="javascript:history.go(-1)" id="todogroup" class="black-text"><h6><strong>이전 페이지로 이동</strong></h6></a>
		</div>	
<div class="col m8 offset-m2 reply titletop grey lighten-2 z-depth-2" style="padding-top: 20px;padding-bottom: 20px;margin-top: 5px;margin-bottom: 10px;">
	<div class="col m10">
			<div class="title">
					<span>
						<h5 class="black-text"><strong><%=civo.getChecktitle()%></strong></h5>
					</span>
					<span>
					<br />
					
				<%
					String daystr = civo.getCheckday();
					String[] arr = daystr.split("[$]");
					for(int i=0;i<arr.length;i++){
				%>
						<div class="chip light-blue darken-4 white-text"><h6><%=arr[i]%></h6></div>
				<%
					}
					
				%>
				<br>
		   <%
				ArrayList<MemberVO> mlist = mdao.selectAll();
				ArrayList<CheckAlarmVO> clist = cadao.selectAll(checkno);
				ArrayList<Integer> pmlist = pmdao.selectAllMember(pno);
				boolean flag=true;

				
				int cnt=0;
				for(int pmemno : pmlist){
   					MemberVO vo = mdao.selectOne(pmemno);
					flag=true;
					
					if(vo==null){
	   					System.out.println("비어있음");
	   				}
			%>
					
				<%
					for(CheckAlarmVO vo2 : clist){
						if(vo.getMemNo()==vo2.getCheckMember()){
%>
							<img src="<%=vo.getIcon()%>" alt="" class="circle responsive-img"/>
								<%=vo.getName()%>&nbsp;

<%
				}else continue;
					}
				cnt++;
				}	
				%>
					</span>
			</div>		
				</div>
	
	<div class="col m2 right">
		<div style="padding-top: 20px;">
			<a href="checkDeleteOk.jsp?cno=<%=civo.getCheckno()%>">
				<i class="small material-icons">delete</i>
								<!-- <input type="button" class="btn-default" value="삭제" /> -->
				</a>
				<br />
				<a href="checkModify.jsp?cno=<%=civo.getCheckno()%>">
				<i class="small material-icons">settings_applications</i>
				<!-- <input type="button" class="btn-default" value="수정" /> -->
			</a>
		</div>
	</div>
</div>

		<form action="checkReplyOk.jsp">
			<div class="addreply">
				<div class="row">
					<div class="col m8 offset-m2">
						<div class="col m9">
							<input type="text" name="addreply" id="" value="" placeholder="댓글을 입력할 수 있습니다."/>
							<input type="hidden" name="cno" id="" value="<%=checkno%>">
						</div>
						<div class="right" >
							<button class="btn waves-effect waves-light green accent-4" type="submit" name="action">전송
			   				<i class="material-icons right">send</i>
			 				</button>
		 				</div>
	 				</div>
 				</div>
				
				<!-- <input type="submit" value="댓글입력" id="submit"/> -->
			</div>
		</form>
			
<div class="row">		
<div id="replyWrap" class="col m8 offset-m2 s12" style="margin-top: 20px; margin-bottom: 40px;"
>
			<%
				ArrayList<CheckreplyVO> list = new ArrayList<>();
				list = crdao.selectAll(checkno);
			
				if(list!=null){	
					//System.out.println("1111");
					for(CheckreplyVO vo : list){
					System.out.println(vo.getCheckreplywriter());
						//System.out.println(vo);
			%>
			
		<div class="checkList" style="padding-top: 10px; padding-bottom: 0px; text-align:center">
			<div class="chip col m2 s12 light-blue darken-4 white-text">
				<span><strong><%=vo.getCheckreplywriter()%></strong></span>	
			</div>
						
						
			<div class="chip col m5">		
				<span><%=vo.getCheckreplycontents() %></span>
			</div>
			<div>
				<span class="chip col m3 grey darken-2 white-text">
					<%=vo.getCheckreplydate() %>
				</span>
			</div>
			<div class="chip grey darken-2 white-text">
			<a href="checkReplydeleteOk.jsp?replyno=<%=vo.getCheckreplyno()%>&cno=<%=vo.getCheckno()%>" class="close-thik"></a>
			</div>
		</div>

		<%
					}
				}
		%>
			</div>
		
		
		</div>
	</div>
</div>
</div>
</main>
<%@ include file="../include/footer.jsp" %>
</body>
</html>