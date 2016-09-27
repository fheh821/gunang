package vo;

public class CheckinVO {
	
		//private로 권한을 가진 인간만 접근이 가능하게 한다.
		private int checkno;
		private int pno;
		private int memno;
		private String checktitle;
		private int checkonoff;
		private String checkdate;
		private String checktime;
		private String checkday;
		private int periodcode;
		
		//기본생성자
		public CheckinVO(){}
		
		//매개변수있는 생성자
		public CheckinVO(int checkno, int pno, int memno, String checktitle, int checkonoff, String checkdate, String checktime, String checkday, int periodcode) {
			super();
			this.checkno = checkno;
			this.pno = pno;
			this.memno = memno;
			this.checktitle = checktitle;
			this.checkonoff = checkonoff;
			this.checkdate = checkdate;
			this.checktime = checktime;
			this.checkday = checkday;
			this.periodcode = periodcode;
		}

		//getter, setter
		public int getCheckno() {
			return checkno;
		}

		public void setCheckno(int checkno) {
			this.checkno = checkno;
		}

		public int getPno() {
			return pno;
		}

		public void setPno(int pno) {
			this.pno = pno;
		}

		public int getMemno() {
			return memno;
		}

		public void setMemno(int memno) {
			this.memno = memno;
		}

		public String getChecktitle() {
			return checktitle;
		}

		public void setChecktitle(String checktitle) {
			this.checktitle = checktitle;
		}

		public int getCheckonoff() {
			return checkonoff;
		}

		public void setCheckonoff(int checkonoff) {
			this.checkonoff = checkonoff;
		}

		public String getCheckdate() {
			return checkdate;
		}

		public void setCheckdate(String checkdate) {
			this.checkdate = checkdate;
		}
		
		public String getChecktime() {
			return checktime;
		}

		public void setChecktime(String checktime) {
			this.checktime = checktime;
		}
		
		public String getCheckday() {
			return checkday;
		}

		public void setCheckday(String checkday) {
			this.checkday = checkday;
		}

		public int getPeriodcode() {
			return periodcode;
		}

		public void setPeriodcode(int periodcode) {
			this.periodcode = periodcode;
		}
		
		
		
		
		
}
