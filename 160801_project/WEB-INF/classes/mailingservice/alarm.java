package mailingservice;

import java.util.ArrayList;
import java.util.TimerTask;

import dao.CheckAlarmDAO;
import dao.CheckinDAO;
import dao.MemberDAO;
import kr.co.goodcode.servlet.GmailTest;
import vo.CheckAlarmVO;
import vo.CheckinVO;


public class alarm extends TimerTask {
	@Override
	public void run() {
		System.out.println("hello world");
		
/*		
		// 토글이 1인 checkin의 멤버들에게 메일을 보낸다.
		
				1. 체크인 테이블에서 onoff == 1인 checkNo 목록 가져오기


				2. checkAlarm 테이블에서 checkNo와 일치하는 checkMember의 멤버번호 목록을 가져오기.

				3. memberDAO로 이메일 가져와서 이메일 목록 만들기

				4. 이메일 목록을 GmailTest(); 에 매개변수로 넘겨주기
				
		*/
		
		CheckinDAO cidao = new CheckinDAO();
		MemberDAO mdao = new MemberDAO();
		
		CheckAlarmDAO cadao = new CheckAlarmDAO();
		CheckAlarmVO cavo = new CheckAlarmVO();
		
		// ciarr : 체크인 목록 중 0(on)인 애들만 가져오기
		ArrayList<CheckinVO> ciarr = cidao.selelctChecknolist();
		
		for(CheckinVO civo : ciarr){
			System.out.println(civo.getCheckdate());
		}
		
		
		//GmailTest.main();
	}
}