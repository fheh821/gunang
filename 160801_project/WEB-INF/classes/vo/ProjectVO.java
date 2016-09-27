package vo;

public class ProjectVO {
	int pNo;
	String pInfo;
	String pName;
	
	public ProjectVO() {
	}

	public ProjectVO(int pNo, String pInfo, String pName) {
		this.pNo = pNo;
		this.pInfo = pInfo;
		this.pName = pName;
	}

	public int getpNo() {
		return pNo;
	}

	public void setpNo(int pNo) {
		this.pNo = pNo;
	}

	public String getpInfo() {
		return pInfo;
	}

	public void setpInfo(String pInfo) {
		this.pInfo = pInfo;
	}

	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}	
	
}
