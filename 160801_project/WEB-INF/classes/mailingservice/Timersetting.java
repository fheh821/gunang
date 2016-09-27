package mailingservice;

import java.util.Date;
import java.util.Timer;
public class Timersetting {
	public static void main(String[] args) {
		while (true) {
			alarm th = new alarm();
			Timer t = new Timer();
			Date today = new Date();
			Date d = new Date(today.getYear(), today.getMonth(), today.getDate(), today.getHours(), today.getMinutes(), today.getSeconds());
			t.schedule(th, d);             // while을 일정한 시간만큰 돌려야 함으로 
			try {
				Thread.sleep(1000 * 60);
			} catch (Exception e) {
				
			}        
		} // while end
	} // main end
}// class end