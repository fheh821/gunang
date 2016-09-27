package vo;

public class CheckreplyVO {

	//private와 getter, setter로 권한을 갖는 인간만 수정이 가능토록한다. 
	private int checkreplyno;
	private int checkno;
	private int pno;
	private String checkreplycontents;
	private String checkreplywriter;
	private String checkreplydate;
	
	//기본생성자
	public CheckreplyVO(){}

	//매개변수있는 생성자
	public CheckreplyVO(int checkreplyno, int checkno, int pno, String checkreplycontents, String checkreplywriter,
			String checkreplydate) {
		super();
		this.checkreplyno = checkreplyno;
		this.checkno = checkno;
		this.pno = pno;
		this.checkreplycontents = checkreplycontents;
		this.checkreplywriter = checkreplywriter;
		this.checkreplydate = checkreplydate;
	}

	public int getCheckreplyno() {
		return checkreplyno;
	}

	public void setCheckreplyno(int checkreplyno) {
		this.checkreplyno = checkreplyno;
	}

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

	public String getCheckreplycontents() {
		return checkreplycontents;
	}

	public void setCheckreplycontents(String checkreplycontents) {
		this.checkreplycontents = checkreplycontents;
	}

	public String getCheckreplywriter() {
		return checkreplywriter;
	}

	public void setCheckreplywriter(String checkreplywriter) {
		this.checkreplywriter = checkreplywriter;
	}

	public String getCheckreplydate() {
		return checkreplydate;
	}

	public void setCheckreplydate(String checkreplydate) {
		this.checkreplydate = checkreplydate;
	}
	
	//getter, setter
	
	
	
}
