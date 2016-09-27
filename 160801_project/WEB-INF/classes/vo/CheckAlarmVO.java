package vo;

public class CheckAlarmVO {

	int checkmemNo;
	int checkNo;
	int checkMember;
	
	public CheckAlarmVO() {
		super();
	}

	public CheckAlarmVO(int checkmemNo, int checkNo, int checkMember) {
		super();
		this.checkmemNo = checkmemNo;
		this.checkNo = checkNo;
		this.checkMember = checkMember;
	}

	public int getCheckmemNo() {
		return checkmemNo;
	}

	public void setCheckmemNo(int checkmemNo) {
		this.checkmemNo = checkmemNo;
	}

	public int getCheckNo() {
		return checkNo;
	}

	public void setCheckNo(int checkNo) {
		this.checkNo = checkNo;
	}

	public int getCheckMember() {
		return checkMember;
	}

	public void setCheckMember(int checkMember) {
		this.checkMember = checkMember;
	}	
	
}
