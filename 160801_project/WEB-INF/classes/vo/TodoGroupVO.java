package vo;

public class TodoGroupVO {
	
	private int groupNo; //그룹번호
	private int pNo; // 프로젝트번호
	private int memNo; //멤버번호
	private String groupTitle; //그룹타이틀
	private String groupContents;
	private String groupColor;
	
	public TodoGroupVO(){}

	public TodoGroupVO(int groupNo, int pNo, int memNo, String groupTitle, String groupContents, String groupColor) {
		super();
		this.groupNo = groupNo;
		this.pNo = pNo;
		this.memNo = memNo;
		this.groupTitle = groupTitle;
		this.groupContents = groupContents;
		this.groupColor = groupColor;
	}

	public int getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}

	public int getpNo() {
		return pNo;
	}

	public void setpNo(int pNo) {
		this.pNo = pNo;
	}

	public int getMemNo() {
		return memNo;
	}

	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}

	public String getGroupTitle() {
		return groupTitle;
	}

	public void setGroupTitle(String groupTitle) {
		this.groupTitle = groupTitle;
	}

	public String getGroupContents() {
		return groupContents;
	}

	public void setGroupContents(String groupContents) {
		this.groupContents = groupContents;
	}

	public String getGroupColor() {
		return groupColor;
	}

	public void setGroupColor(String groupColor) {
		this.groupColor = groupColor;
	}
	
	
}
