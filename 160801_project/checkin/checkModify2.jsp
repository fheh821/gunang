<%@page import="dao.CheckAlarmDAO"%>
<%@page import="dao.CheckinDAO"%>
<%@page import="vo.CheckAlarmVO"%>
<%@page import="vo.CheckinVO"%>
<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.ProjectMemberVO"%>
<%@page import="dao.ProjectMemberDAO"%>
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
<title>Insert title here</title>
<style type="text/css">
 	*{box-sizing: border-box; margin: 0; padding: 0;}
	.boxWrap{width: 100%; margin: auto; overflow: hidden;}

	img{
		width: 50px;
		height: 50px;
	}
	
	.quest input{width: 100%;}
	.box1{
		width: 100%; 
		float: left; 
		height: 600px; 
		overflow: auto;
		border: 3px solid #4db6ac;
		border-radius: 30px;
	}
	.box2{
		width: 100%; 
		float: left; 
		height: 200px;
		border: 3px solid #4db6ac;
		border-radius: 30px;
	}
	.box3{
		width: 100%; 
		text-align: center;
	}
	
	.timebox{
	
	} 
</style>
<!-- <link rel="stylesheet" href="../css/checkIn.css" /> -->
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"></script>
<script type="text/javascript">
$(function(){
	
	$("#submit").click(function(){
		
		var quest = $("#quest").val();
		var sendData = 'quest=' + quest;
		var memArr = [];
		var dayArr = [];

		var cno = $("#cno").val();
		console.log(cno);
		var num = '&cno='+ cno
		sendData += num;
		
		$("input[name=chkmem]:checked").each(function(i){
			memArr.push($(this).val());
			chkData1 = '&chkmem=' + memArr[i];
			sendData += chkData1;
		})
		
		var selectedtime= $("#time option:selected").text();
		var time = '&time='+selectedtime;
		sendData += time;

		var selectedhour= $("#hour option:selected").text();
		var hour = '&hour='+selectedhour;
		sendData += hour;
		
		var selectedmin= $("#min option:selected").text();
		var min = '&min='+selectedmin;
		sendData += min;
		 
		$("input[name=chkday]:checked").each(function(i){
			dayArr.push($(this).val());
			chkData2 = '&chkday=' + dayArr[i];
			sendData += chkData2;
		})	
		
		//var selectedperiod = $("#period option:selected").text();
		var selectedperiod = $("#period option").index($("#period option:selected"));
		var period = '&period='+selectedperiod;
		sendData += period;
		
		$.post("checkModifyOk.jsp", sendData);
		
	})   
		
})

</script>
</head>
<body>
<div class="container">
<form name="checkform" action="checkWriteOk.jsp" method="post">

<%
	String cno = request.getParameter("cno");
	int checkno = Integer.parseInt(cno);

	CheckinDAO cidao = new CheckinDAO();
	CheckAlarmDAO cadao = new CheckAlarmDAO();
	CheckinVO civo = cidao.selectOne(checkno);
	CheckAlarmVO cavo = cadao.selectOne(checkno);
%>
	<div class="boxWrap" style="margin-top: 30px;">
		<div class="quest" style="margin-bottom: 30px;">
			<input type="hidden" id="cno" name="" value=<%=checkno %> />
			<input type="text" id="quest" value=<%=civo.getChecktitle() %>>
		</div>
		<div class="col m6 s6 box1">
			
			<%
				MemberDAO mdao = new MemberDAO();
				ArrayList<MemberVO> mlist = mdao.selectAll();
				ArrayList<CheckAlarmVO> clist = cadao.selectAll(checkno);
				boolean flag=true;

				
				if(mlist.isEmpty()){
					System.out.println("비어있음");
				}
				int cnt=0;
				for(MemberVO vo : mlist){
					flag=true;
			%>
				<div class="col m12 s12 memone">
					<div class="col m8 s4 icon">
					<img src="../images/bo1.gif" alt="" />
					<%=vo.getName()%>		
				<%
					for(CheckAlarmVO vo2 : clist){
						if(vo.getMemNo()==vo2.getCheckMember()){
				%>
					</div>
					<input type="checkbox" name="chkmem" value=<%=vo.getMemNo()%> 
				
					<%=vo.getMemNo()==vo2.getCheckMember()?"checked":"" %> >  
				
			<%
					flag=false;
						}else continue;
					}
				if(flag){
				%>
				
				<input type="checkbox" name="chkmem" value=<%=vo.getMemNo()%>>  
				<%
				}
				cnt++;
				}
			%>
			
			</div>
		</div>

		<div class="col m6 s6 box2">
		
				<div>
					<%
						String checktime = civo.getChecktime();
						String hour="", time="", min="";
						
						if(checktime.length()==6){
							hour = checktime.substring(0, 2);
							time = "0";
							min = checktime.substring(2, 4);
						}else if(checktime.length()==8){
							hour = checktime.substring(0, 2);
							time = checktime.substring(2, 4);
							min = checktime.substring(4, 6);
						}

					%>
					<div class="col m8 offset-m2 s8 timebox" style="margin-bottom: 100px;">
						<select id="time">
			                <option <%="0".equals(time)?"selected":""%>>오전</option>
			                <option <%="12".equals(time)?"selected":""%>>오후</option>
			            </select>
			            <select id="hour">
			                <%
			            		for(int i=1;i<=12;i++){
			            			if(i%10==i){
			            				%>
			                			<option <%=("0"+i).equals(hour)?"selected":""%>><%="0"+i%></option>
			                			<%
			            			}else{
			            			%>
			            				<option <%=(""+i+"").equals(hour)?"selected":""%>><%=i%></option>
			            			<%
			            			}
			            		}
			            	%>
			            </select>
			            <select id="min">
			            	<%
			            		for(int i=0;i<60;i++){
			            			if(i%10==i){
			            				%>
			                			<option <%=("0"+i).equals(min)?"selected":""%>><%="0"+i%></option>
			                			<%
			            			}else{
			            			%>
			            				<option <%=(""+i+"").equals(min)?"selected":""%>><%=i%></option>
			            			<%
			            			}
			            		}
			            	%>
			            </select>
	
					</div>
			</div>
			<%
					String checkday = civo.getCheckday();
					String[] dayarr = checkday.split("[$]");
					if(dayarr!=null){
						int i=0;
						int length = dayarr.length;
						
				%>
			<div>
						
				<div>		
					<input type="checkbox" name="chkday" value="mon" <%="mon".equals(dayarr[i])?"checked":"" %>>월
					<%
						if("mon".equals(dayarr[i])&&(i<length)) i++;
						if(i==length) i=length-1;
					%>
					<input type="checkbox" name="chkday" value="tue" <%="tue".equals(dayarr[i])?"checked":"" %>>화
					<%
						if("tue".equals(dayarr[i])&&(i<length)) i++;	
						if(i==length) i=length-1;
					%>	
					<input type="checkbox" name="chkday" value="wed" <%="wed".equals(dayarr[i])?"checked":"" %>>수
					<%
						if("wed".equals(dayarr[i])&&(i<length)) i++;		
						if(i==length) i=length-1;
					%>
					<input type="checkbox" name="chkday" value="thr" <%="thr".equals(dayarr[i])?"checked":"" %>>목
					<%
						if("thr".equals(dayarr[i])&&(i<length)) i++;
						System.out.println(i);
						if(i==length) i=length-1;
					%>
					<input type="checkbox" name="chkday" value="fri" <%="fri".equals(dayarr[i])?"checked":"" %>>금
					<%
						if("fri".equals(dayarr[i])&&(i<length)) i++;
						if(i==length) i=length-1;
					%>
					<input type="checkbox" name="chkday" value="sat" <%="sat".equals(dayarr[i])?"checked":"" %>>토
					<%
						if("sat".equals(dayarr[i])&&(i<length)) i++;	
						if(i==length) i=length-1;
					%>
					<input type="checkbox" name="chkday" value="sun" <%="sun".equals(dayarr[i])?"checked":"" %>>일

				</div>	
			</div>
			<%
					}
			%>
			<div>
			<tr>
			<td>
				<select id="period" >
					<option value="0" <%=0==civo.getPeriodcode()?"selected":""%>>매 주 마다</option>
					<option value="1" <%=1==civo.getPeriodcode()?"selected":""%>>2 주 마다</option>
					<option value="2" <%=2==civo.getPeriodcode()?"selected":""%>>매 달 마다</option>
					<option value="3" <%=3==civo.getPeriodcode()?"selected":""%>>매 해 마다</option>
				</select>		
			</td>
			</tr>
			</div>
		</div>
		<div class="col m3 s12 box3" style="margin-bottom: 60px;">
			<a href="checkList.jsp">
				<button class="btn waves-effect waves-light" type="submit" name="action">Submit
   				<i class="material-icons right">send</i>
 				</button>
 			</a>
 			
			<a href="checkList.jsp" class="waves-effect waves-light btn">취소</a>
			</div>
		
</div>
</form>
</div>
<%@ include file="../include/footer.jsp" %>
</body>
</html>