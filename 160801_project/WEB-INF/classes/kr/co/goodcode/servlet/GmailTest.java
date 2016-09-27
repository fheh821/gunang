package kr.co.goodcode.servlet;
 
import java.util.Date;
import java.util.Properties;
import java.util.Scanner;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


 
public class GmailTest {
	public static void main(String[] args) throws MessagingException{
    	//메일을 보낼 수 있는 메소드를 만들어야한다? 
    	
        // 메일 관련 정보
        String host = "smtp.gmail.com";
        String username = "ssm5070@gmail.com";
        String password = "epatjs0731";

        // 메일 받는 사람의 인원수 구하기
        int count = 0;
        int i = 0;
        while(args[i]!=null){
        	count++;
        	i++;
        }
        
        // 메일 받아야하는 사람 수만큼.. 수신자 설정하기
        InternetAddress[] emails = new InternetAddress[count];
        for (int k = 0; k < count; k++) {
        	emails[k] = new InternetAddress(args[k]);
        }

        // 메일 제목과 내용
        String subject = "welcome!!!";
        String body = "http://localhost:8080/projectTest/login/login.jsp";
        //String body = new String();
       
        
        //properties 설정
        Properties props = new Properties();
        props.put("mail.smtps.auth", "true");
        // 메일 세션
        Session session = Session.getDefaultInstance(props);      
        MimeMessage msg = new MimeMessage(session);
       
        msg.setSubject(subject);
        //msg.setText(body);
        msg.setContent(body, "text/html;charset=utf-8");
        msg.setFrom(new InternetAddress(username));
        //msg.addRecipient(Message.RecipientType.TO, new InternetAddress(x));
        msg.setRecipients(Message.RecipientType.TO, emails);
        
        // 발송 처리
        Transport transport = session.getTransport("smtps");
        transport.connect(host, username, password);
        transport.sendMessage(msg, msg.getAllRecipients());
        transport.close();     

    } // main end
    
}