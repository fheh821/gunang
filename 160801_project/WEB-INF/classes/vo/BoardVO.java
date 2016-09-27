package vo;

public class BoardVO {
	private int boardNo;
	private int pNo;
	private int memNo;
	private String boardTitle;
	
	public BoardVO(){
		
	}
	
	public BoardVO(int boardNo, int pNo, int memNo, String boardTitle) {
		this.boardNo = boardNo;
		this.pNo = pNo;
		this.memNo = memNo;
		this.boardTitle = boardTitle;
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

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	
}
