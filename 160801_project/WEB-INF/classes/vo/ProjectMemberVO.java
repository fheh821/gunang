package vo;

public class ProjectMemberVO {
	int memNo;
	int pNo;
	int status;
	
	public ProjectMemberVO() {
		super();
	}

	public ProjectMemberVO(int memNo, int pNo, int status) {
		super();
		this.memNo = memNo;
		this.pNo = pNo;
		this.status = status;
	}

	public int getMemNo() {
		return memNo;
	}

	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}

	public int getpNo() {
		return pNo;
	}

	public void setpNo(int pNo) {
		this.pNo = pNo;
	}
	
	public int getstatus() {
		return status;
	}

	public void setstatus(int status) {
		this.status = status;
	}
	
}
