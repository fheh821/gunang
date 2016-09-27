package vo;

public class CardReplyVO {
	private int cardReplyNo;
	private int cardNo;
	private int pNo;
	private int boardNo;
	private String cardReplyContents;
	private String cardReplyWriter;
	private String cardReplyDate;
	
	public CardReplyVO(){
		
	}
	
	public CardReplyVO(int cardReplyNo, int cardNo, int pNo, int boardNo, String cardReplyContents,
			String cardReplyWriter, String cardReplyDate) {
		super();
		this.cardReplyNo = cardReplyNo;
		this.cardNo = cardNo;
		this.pNo = pNo;
		this.boardNo = boardNo;
		this.cardReplyContents = cardReplyContents;
		this.cardReplyWriter = cardReplyWriter;
		this.cardReplyDate = cardReplyDate;
	}

	public int getCardReplyNo() {
		return cardReplyNo;
	}

	public void setCardReplyNo(int cardReplyNo) {
		this.cardReplyNo = cardReplyNo;
	}

	public int getCardNo() {
		return cardNo;
	}

	public void setCardNo(int cardNo) {
		this.cardNo = cardNo;
	}

	public int getpNo() {
		return pNo;
	}

	public void setpNo(int pNo) {
		this.pNo = pNo;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getCardReplyContents() {
		return cardReplyContents;
	}

	public void setCardReplyContents(String cardReplyContents) {
		this.cardReplyContents = cardReplyContents;
	}

	public String getCardReplyWriter() {
		return cardReplyWriter;
	}

	public void setCardReplyWriter(String cardReplyWriter) {
		this.cardReplyWriter = cardReplyWriter;
	}

	public String getCardReplyDate() {
		return cardReplyDate;
	}

	public void setCardReplyDate(String cardReplyDate) {
		this.cardReplyDate = cardReplyDate;
	}
	
}
