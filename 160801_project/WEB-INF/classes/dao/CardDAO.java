package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.CardVO;

public class CardDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private StringBuffer sb = new StringBuffer();
	
	public CardDAO(){
		conn = MakeConnection.getInstance().getConnection();
	}// CardDAO생성자 end
	
	// card생성
	public void InsertOne(CardVO vo){
		sb.setLength(0);
		sb.append("INSERT INTO card ");
		sb.append("VALUES(CARDNO_SEQ.nextval, ?, ?, ?, ?, ?, ?, sysdate) ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, vo.getBoardNo());
			pstmt.setInt(2, vo.getpNo());
			pstmt.setInt(3, vo.getMemNo());
			pstmt.setString(4, vo.getCardTitle());
			pstmt.setString(5, vo.getCardContents());
			pstmt.setString(6, vo.getCardWriter());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}// insertOne end
	
	// card삭제
	public void deleteOne(int cardNo){
		sb.setLength(0);
		sb.append("DELETE card ");
		sb.append("WHERE cardNo = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, cardNo);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}// deleteOne end
	
	// 프로젝트번호와 board번호에 해당하는 list목록 가져오기
	public ArrayList<CardVO> selectAll(int pNo, int boardNo){
		ArrayList<CardVO> list = new ArrayList<CardVO>();
		sb.setLength(0);
		sb.append("SELECT * FROM card ");
		sb.append("WHERE pNo = ? AND boardNo = ? ");
		sb.append("ORDER BY cardNo asc");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, pNo);
			pstmt.setInt(2, boardNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				int cardNo = rs.getInt("cardNo");
				int memNo = rs.getInt("memNo");
				String cardTitle = rs.getString("cardTitle");
				String cardContents = rs.getString("cardContents");
				String cardWriter = rs.getString("cardWriter");
				String cardDate = rs.getString("cardDate");
				
				CardVO vo = new CardVO(cardNo, boardNo, pNo, memNo, cardTitle, cardContents, cardWriter, cardDate);
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 이전에 한거와는 조금 다르게 했는데...
	// 이렇게 해도 되는 건지...ㅎㅎ
	public void updateOne(int cardNo, String cardTitle, String cardContents){
		sb.setLength(0);
		sb.append("UPDATE card ");
		// 날짜는.. 수정날짜로 바꿔야되나?
		sb.append("SET cardtitle = ?, cardContents = ? ");
		sb.append("WHERE cardNo = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, cardTitle);
			pstmt.setString(2, cardContents);
			pstmt.setInt(3, cardNo);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}// update end
	
	// 카드 상세보기를 위해서
	public CardVO selectOne(int cardNo){
		CardVO vo = null;
		sb.setLength(0);
		sb.append("SELECT * FROM card ");
		sb.append("WHERE cardNo = ? " );
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, cardNo);
			rs = pstmt.executeQuery();
			if(rs.next()){
				int boardNo = rs.getInt("boardNo");
				int pNo = rs.getInt("pNo");
				int memNo = rs.getInt("memNo");
				String cardTitle = rs.getString("cardTitle");
				String cardContents = rs.getString("cardContents");
				String cardWriter = rs.getString("cardWriter");
				String cardDate = rs.getString("cardDate");
				
				vo = new CardVO(cardNo, boardNo, pNo, memNo, cardTitle, cardContents, cardWriter, cardDate);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return vo;
	}// selectOne
	
	public void close(){
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// close end
}
