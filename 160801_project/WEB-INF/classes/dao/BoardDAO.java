package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.BoardVO;

public class BoardDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private StringBuffer sb = new StringBuffer();
	
	public BoardDAO(){
		conn = MakeConnection.getInstance().getConnection();
	}// BoardDAO생성자 end
	
	// board추가
	public void insertOne(BoardVO vo){
		// sql문 작성
		sb.setLength(0);
		sb.append("INSERT INTO board ");
		sb.append("VALUES(BOARDNO_SEQ.nextval, ?, ?, ?) ");
		
		try {
			// 문장객체 생성
			pstmt = conn.prepareStatement(sb.toString());
			
			// 물음표채우기
			pstmt.setInt(1, vo.getpNo());
			pstmt.setInt(2, vo.getMemNo());
			pstmt.setString(3, vo.getBoardTitle());
			
			//실행
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}// insertOne end
	
	// 프로젝트의 번호에 해당하는 모든 board 가져오기
	public ArrayList<BoardVO> selectAll(int pNo){
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		sb.setLength(0);
		sb.append("SELECT * FROM Board ");
		sb.append("WHERE pNo = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, pNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				int boardNo = rs.getInt("boardNo");
				int memNo = rs.getInt("memNo");
				String boardTitle = rs.getString("boardTitle");
				
				BoardVO vo = new BoardVO(boardNo, pNo, memNo, boardTitle);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	} // selectAll end
	
	// board 삭제
	public void deleteOne(int boardNo){
		sb.setLength(0);
		sb.append("DELETE board ");
		sb.append("WHERE boardNo = ? ");
		
		try {
			// 문장객체 생성
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setInt(1, boardNo);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}// deleteOne end
	
	public void close(){
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// close end
}
