package vo;

public class CardVO {
	private int cardNo;
	private int boardNo;
	private int pNo;
	private int memNo;
	private String cardTitle;
	private String cardContents;
	private String cardWriter;
	private String cardDate;
	
	public CardVO(){
		
	}
	
	public CardVO(int cardNo, int boardNo, int pNo, int memNo, String cardTitle, String cardContents, String cardWriter,
			String cardDate) {
		this.cardNo = cardNo;
		this.boardNo = boardNo;
		this.pNo = pNo;
		this.memNo = memNo;
		this.cardTitle = cardTitle;
		this.cardContents = cardContents;
		this.cardWriter = cardWriter;
		this.cardDate = cardDate;
	}

	public int getCardNo() {
		return cardNo;
	}

	public void setCardNo(int cardNo) {
		this.cardNo = cardNo;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
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

	public String getCardTitle() {
		return cardTitle;
	}

	public void setCardTitle(String cardTitle) {
		this.cardTitle = cardTitle;
	}

	public String getCardContents() {
		return cardContents;
	}

	public void setCardContents(String cardContents) {
		this.cardContents = cardContents;
	}

	public String getCardWriter() {
		return cardWriter;
	}

	public void setCardWriter(String cardWriter) {
		this.cardWriter = cardWriter;
	}

	public String getCardDate() {
		return cardDate;
	}

	public void setCardDate(String cardDate) {
		this.cardDate = cardDate;
	}
	
}
