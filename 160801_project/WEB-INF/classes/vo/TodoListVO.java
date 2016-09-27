package vo;

public class TodoListVO {
	private int listNo;
	private int groupNo;
	private int pNo;
	private String listTitle;
	private String listContents;
	private String startDate;
	private String endDate;
	private int isComplete;
	
	public TodoListVO(){}

	public TodoListVO(int listNo, int groupNo, int pNo, String listTitle, String listContents, String startDate,
			String endDate, int isComplete) {
		super();
		this.listNo = listNo;
		this.groupNo = groupNo;
		this.pNo = pNo;
		this.listTitle = listTitle;
		this.listContents = listContents;
		this.startDate = startDate;
		this.endDate = endDate;
		this.isComplete = isComplete;
	}

	public int getListNo() {
		return listNo;
	}

	public void setListNo(int listNo) {
		this.listNo = listNo;
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

	public String getListTitle() {
		return listTitle;
	}

	public void setListTitle(String listTitle) {
		this.listTitle = listTitle;
	}

	public String getListContents() {
		return listContents;
	}

	public void setListContents(String listContents) {
		this.listContents = listContents;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public int getIsComplete() {
		return isComplete;
	}

	public void setIsComplete(int isComplete) {
		this.isComplete = isComplete;
	}
	
	
}
