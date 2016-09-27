package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.ProjectVO;

public class ProjectDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private StringBuffer sb = new StringBuffer();
	
	
	public ProjectDAO() {
		conn = MakeConnection.getInstance().getConnection();
	}
	
	// selectAll()
	public ArrayList<ProjectVO> selectAll(){
		ArrayList<ProjectVO> list = new ArrayList<>();
		ProjectVO vo;
		
		sb.setLength(0);
		sb.append("SELECT pNo, pInfo, pName ");
		sb.append("FROM project ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				int pno = rs.getInt("pNo");
				String pinfo = rs.getString("pInfo");
				String pname = rs.getString("pName");
				vo = new ProjectVO(pno, pinfo, pname);
				list.add(vo);				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		return list;
	}
	
	
	public ProjectVO selectOne(int pNo){
		ProjectVO vo = null;
		sb.setLength(0);
		sb.append("SELECT pNo, pInfo, pName ");
		sb.append("FROM project ");
		sb.append("WHERE pNo = ?");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, pNo);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				int pno = rs.getInt("pNo");
				String pinfo = rs.getString("pInfo");
				String pname = rs.getString("pName");
				vo = new ProjectVO(pno, pinfo, pname);	
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vo;
	}	
	
	public void insertOne(ProjectVO vo){
		
		sb.setLength(0);
		sb.append("INSERT INTO project ");
		sb.append("VALUES (pno_seq.nextval, ?, ? )");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, vo.getpInfo());
			pstmt.setString(2, vo.getpName());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void updateOne(ProjectVO vo){
		
		sb.setLength(0);
		sb.append("UPDATE project ");
		sb.append("SET pinfo = ?, pname = ? ");
		sb.append("WHERE pno = ? ");

		
/*		int pNo;
String pInfo;
String pName;*/
		try {

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, vo.getpNo());
			pstmt.setString(2, vo.getpInfo());
			pstmt.setString(3, vo.getpName());
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	public int getMaxPno(){
		int max = 0;
		sb.setLength(0);
		sb.append("SELECT max(pno) ");
		sb.append("FROM project ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			if(rs.next()){
				max = rs.getInt("max(pno)");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return max;
	}
	
	public void deleteOne(int pNo){
		
		sb.setLength(0);
		sb.append("DELETE project ");
		sb.append("WHERE pNo = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, pNo);
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
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
