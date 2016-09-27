package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.CardReplyVO;

public class CardReplyDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private StringBuffer sb = new StringBuffer();
	
	public CardReplyDAO(){
		conn = MakeConnection.getInstance().getConnection();
	}// CardReplyDAO생성자 end
	
	public void insertOne(CardReplyVO vo){
		sb.setLength(0);
		sb.append("INSERT INTO cardReply ");
		sb.append("VALUES(CARDREPLYNO_SEQ.nextval, ?, ?, ?, ?, ?, sysdate) ");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, vo.getCardNo());
			pstmt.setInt(2, vo.getpNo());
			pstmt.setInt(3, vo.getBoardNo());
			pstmt.setString(4, vo.getCardReplyContents());
			pstmt.setString(5, vo.getCardReplyWriter());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	} // insertOne end
	public void deleteChildReply(int cardNo){
		
		sb.setLength(0);
		sb.append("DELETE FROM cardReply ");
		sb.append("WHERE cardNo = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, cardNo);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public ArrayList<CardReplyVO> selectAll(int pNo, int boardNo){
		ArrayList<CardReplyVO> list = new ArrayList<CardReplyVO>();
		sb.setLength(0);
		sb.append("SELECT * FROM cardReply ");
		sb.append("WHERE pNo = ? and boardNo = ? ");
		sb.append("ORDER BY cardReplyNo asc");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1,pNo);
			pstmt.setInt(2, boardNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				int cardReplyNo = rs.getInt("cardReplyNo");
				int cardNo = rs.getInt("cardNo");
				String cardReplyContents = rs.getString("cardReplyContents");
				String cardReplyWriter = rs.getString("cardReplyWriter");
				String cardReplyDate = rs.getString("cardReplyDate");
				
				CardReplyVO vo = new CardReplyVO(cardReplyNo, cardNo, pNo, boardNo, cardReplyContents, cardReplyWriter, cardReplyDate);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}// selectAll end
	
	public void close(){
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// close end
}
