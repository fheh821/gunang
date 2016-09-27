<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="vo.CheckAlarmVO"%>
<%@page import="dao.CheckAlarmDAO"%>
<%@page import="vo.CheckinVO"%>
<%@page import="dao.CheckinDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>one-tack!</title>
</head>
<body>
<%
	/* String time = request.getParameter("time");
	System.out.println(time);
	String hour = request.getParameter("hour");
	System.out.println(time);
	String min = request.getParameter("min");
	System.out.println(time); */
	
	String smemno = session.getAttribute("memno").toString();// 멤버번호 pasing
	String spno = session.getAttribute("pno").toString();// 멤버번호 pasing
	int memno = Integer.parseInt(smemno);
	int pno = Integer.parseInt(spno);
	
	String quest = request.getParameter("quest");
	System.out.println(quest);
	
	String[] chkmem = request.getParameterValues("filled-in1");
	System.out.println("멤버 수 : "+chkmem.length);
	int[] alarmmem = new int[chkmem.length];
 	for(int i=0;i<chkmem.length;i++){
		System.out.println(chkmem[i]);
		alarmmem[i] = Integer.parseInt(chkmem[i]);
	}
 	
 	String time = request.getParameter("time");
 	System.out.println(time);
 	String hour = request.getParameter("hour");
 	System.out.println(hour);
 	String min = request.getParameter("min");
 	System.out.println(min);
 	
 	String alarmday="";
 	String[] chkday = request.getParameterValues("filled-in2");
 	for(int i=0;i<chkday.length;i++){
		System.out.println(chkday[i]);
		alarmday += (chkday[i]+'$');
	}
 	
 	String period = request.getParameter("period");
 	int alarmperiod = Integer.parseInt(period);
 	System.out.println(period);

 	
   	CheckinDAO cidao = new CheckinDAO(); 	
 	CheckAlarmDAO cadao = new CheckAlarmDAO();
 	MemberDAO mdao = new MemberDAO();
 	
 	CheckinVO civo = new CheckinVO();
 	CheckAlarmVO cavo = new CheckAlarmVO();
 	MemberVO mvo = new MemberVO();

 	civo.setPno(pno);
 	civo.setMemno(memno);
 	civo.setChecktitle(quest);
 	//civo.setCheckonoff(1);
 	if(time.equals("오후")){
 		hour+=12;
 	}
 	String alarmtime = hour+min+"00";
 	civo.setChecktime(alarmtime);
 	
 	civo.setCheckday(alarmday);
 	civo.setCheckonoff(1);
 	civo.setPeriodcode(alarmperiod);
 	
 	cidao.checkinInsert(civo); // checkin table에 값 저장 
 		 
 	
 	
 	//System.out.println(civo.getCheckno());//0
 	int checkno = cidao.getcheckNum();
 	System.out.println("checkno : "+checkno);
 	cavo.setCheckNo(checkno);
	
 	for(int i=0;i<chkmem.length;i++){ 		
 		cavo.setCheckMember(alarmmem[i]);
 	 	cadao.insertOne(cavo); // check alarm table에 값 저장
	} 	

 
 	//response.sendRedirect("checkList.jsp");
%>
</body>
</html>