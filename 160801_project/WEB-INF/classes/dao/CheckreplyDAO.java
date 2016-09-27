package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.CheckreplyVO;

public class CheckreplyDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private StringBuffer sb = new StringBuffer();
	
	public CheckreplyDAO() {
		conn = MakeConnection.getInstance().getConnection();
	}

	// 전제를 조회하는 메서드?
	public ArrayList<CheckreplyVO> selectAll(int checkno) {
		sb.setLength(0);
		sb.append("SELECT * FROM checkreply ");
		sb.append("WHERE checkno = ? ");

		CheckreplyVO vo = null;
		ArrayList<CheckreplyVO> list = new ArrayList<CheckreplyVO>();

		try {

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, checkno);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int checkreplyno = rs.getInt("checkreplyno");
				int pno = rs.getInt("pno");
				String checkreplycontents = rs.getString("checkreplycontents");
				String checkreplywriter = rs.getString("checkreplywriter");
				String checkreplydate = rs.getString("checkreplydate");

				vo = new CheckreplyVO(checkreplyno, checkno, pno, checkreplycontents, checkreplywriter, checkreplydate);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	// 하나만 조회하는 메서드
	public CheckreplyVO selectOne(int checkreplyno) {
		sb.setLength(0);
		sb.append("SELECT * FROM checkreply ");
		sb.append("WHERE checkreplyno = ? ");

		CheckreplyVO vo = new CheckreplyVO();
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, checkreplyno);
			pstmt.executeQuery();
			while (rs.next()) {
				int checkno = rs.getInt("checkno");
				int pno = rs.getInt("pno");
				String checkreplycontents = rs.getString("checkreplycontents");
				String checkreplywriter = rs.getString("checkreplywriter");
				String checkreplydate = rs.getString("checkreplydate");

				vo = new CheckreplyVO(checkreplyno, checkno, pno, checkreplycontents, checkreplywriter, checkreplydate);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vo;
	}

	// insert를 위한메서드
	public void checkReplyInsert(CheckreplyVO vo) {
		sb.setLength(0);
		sb.append("INSERT INTO checkreply ");
		sb.append("VALUES (CHECKREPLYNO_SEQ.NEXTVAL , ?, ?, ?, ?, sysdate) ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, vo.getCheckno());
			pstmt.setInt(2, vo.getPno());
			pstmt.setString(3, vo.getCheckreplycontents());
			pstmt.setString(4, vo.getCheckreplywriter());
			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	// 수정을 위한 update메서드

	public void checkReplyDelete(int checkreplyno) {
		sb.setLength(0);
		sb.append("DELETE checkreply ");
		sb.append("WHERE checkreplyno = ? ");
		System.out.println(sb);
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, checkreplyno);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void close(){
		try {
			if(rs != null)rs.close();
			if(pstmt != null)pstmt.close();
			//if(conn != null)conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
