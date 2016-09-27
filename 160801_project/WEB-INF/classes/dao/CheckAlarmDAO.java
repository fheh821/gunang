package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.CheckAlarmVO;

public class CheckAlarmDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private StringBuffer sb = new StringBuffer();
	
	public CheckAlarmDAO() {
		conn = MakeConnection.getInstance().getConnection();
	}
	
	// selectAll()
	public ArrayList<CheckAlarmVO> selectAll(int checkno){
		ArrayList<CheckAlarmVO> list = new ArrayList<>();
		CheckAlarmVO vo;
				
		sb.setLength(0);
		sb.append("SELECT * ");
		sb.append("FROM checkalarm ");
		sb.append("WHERE checkno = ?");
		//System.out.println(sb);
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, checkno);
			rs = pstmt.executeQuery();
			//System.out.println(rs.next());
			while(rs.next()){
				int checkmemNo = rs.getInt("checkmemNo");
				int checkNo = rs.getInt("checkNo");
				int checkMember = rs.getInt("checkMember");
				vo = new CheckAlarmVO(checkmemNo, checkNo, checkMember);
				list.add(vo);				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		return list;
	}
	
	
	public CheckAlarmVO selectOne(int checkmemNo){
		CheckAlarmVO vo = null;
		sb.setLength(0);
		sb.append("SELECT * ");
		sb.append("FROM checkalarm ");
		sb.append("WHERE checkmemNo = ?");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, checkmemNo);
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				int checkNo = rs.getInt("checkNo");
				int checkMember = rs.getInt("checkMember");
				vo = new CheckAlarmVO(checkmemNo, checkNo, checkMember);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vo;
	}	
	
	public void insertOne(CheckAlarmVO vo){
		
		sb.setLength(0);
		sb.append("INSERT INTO checkalarm ");
		sb.append("VALUES (checkalarm_seq.nextval, ?, ? ) ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, vo.getCheckNo());
			pstmt.setInt(2, vo.getCheckMember());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	public void updateOne(CheckAlarmVO vo){
		
		sb.setLength(0);
		sb.append("UPDATE checkalarm ");
		sb.append("SET checkNo = ?, checkMember = ? ");
		sb.append("WHERE checkmemNo = ? ");

		try {

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, vo.getCheckNo());
			pstmt.setInt(2, vo.getCheckMember());
			pstmt.setInt(3, vo.getCheckmemNo());
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	public void deleteOne(int checkmemNo){
		
		sb.setLength(0);
		sb.append("DELETE checkalarm ");
		sb.append("WHERE checkmemNo = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, checkmemNo);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	public int getcheckNum(int checkno){
		int checkmemNo = 0;
		sb.setLength(0);
		sb.append("Select checkmemNo ");
		sb.append("from checkalarm ");
		sb.append("WHERE checkno = ? ");
		
		try{
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, checkno);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				checkmemNo = rs.getInt("checkmemNo");
			}
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return checkmemNo;
	}
	
	public void resetmem(int checkno){
		
		sb.setLength(0);
		sb.append("DELETE checkalarm ");
		sb.append("WHERE checkno = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, checkno);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	public void close(){
		
		try {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			//if(conn!=null) conn.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
