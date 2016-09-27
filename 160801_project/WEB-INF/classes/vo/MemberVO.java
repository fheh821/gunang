package vo;

public class MemberVO {
	int memNo;
	String name;
	String email;
	String password;
	int joinway;
	String icon;
	
	public MemberVO() {
		super();
	}

	public MemberVO(int memNo, String name, String email, String password, int joinway, String icon) {
		super();
		this.memNo = memNo;
		this.name = name;
		this.email = email;
		this.password = password;
		this.joinway = joinway;
		this.icon = icon;
	}
	
	public MemberVO(String name, String email, String password, int joinway){
		this.name = name;
		this.email = email;
		this.password = password;
		this.joinway = joinway;
		
	}

	public int getMemNo() {
		return memNo;
	}

	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getJoinway() {
		return joinway;
	}

	public void setJoinway(int joinway) {
		this.joinway = joinway;
	}
	
	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}
	
	
}
