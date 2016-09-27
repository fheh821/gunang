package vo;

public class ChatVO {

	//멤버변수
	private int chatno;
	private int pNo;
	private int memNo;
	private String chatWriter;
	private String chatContents;
	private String chatTime;
	
	//기본생성자
	public ChatVO(){}

	//멤버변수있는생성자
	public ChatVO(int chatno, int pNo, int memNo, String chatWriter, String chatContents, String chatTime) {
		super();
		this.chatno = chatno;
		this.pNo = pNo;
		this.memNo = memNo;
		this.chatWriter = chatWriter;
		this.chatContents = chatContents;
		this.chatTime = chatTime;
	}
	
	public ChatVO(String chatWriter, String chatTime, String chatContents){
		super();
		this.chatWriter = chatWriter;
		this.chatTime = chatTime;
		this.chatContents = chatContents;
	}

	//getter, setter
	public int getChatno() {
		return chatno;
	}

	public void setChatno(int chatno) {
		this.chatno = chatno;
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

	public String getChatWriter() {
		return chatWriter;
	}

	public void setChatWriter(String chatWriter) {
		this.chatWriter = chatWriter;
	}

	public String getChatContents() {
		return chatContents;
	}

	public void setChatContents(String chatContents) {
		this.chatContents = chatContents;
	}

	public String getChatTime() {
		return chatTime;
	}

	public void setChatTime(String chatTime) {
		this.chatTime = chatTime;
	};
	
	
	
	
	
}
