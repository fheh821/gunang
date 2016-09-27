package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.ProjectMemberVO;

public class ProjectMemberDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private StringBuffer sb = new StringBuffer();
	
	
	public ProjectMemberDAO() {
		conn = MakeConnection.getInstance().getConnection();
	}
	
	// selectAll()
	public ArrayList<ProjectMemberVO> selectAll(){
		ArrayList<ProjectMemberVO> list = new ArrayList<>();
		ProjectMemberVO vo;
		
		sb.setLength(0);
		sb.append("SELECT memNo, pNo, status ");
		sb.append("FROM projectmember ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				int memNo = rs.getInt("memNo");
				int pNo = rs.getInt("pNo");
				int status = rs.getInt("status");
				vo = new ProjectMemberVO(memNo, pNo, status);
				list.add(vo);				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		return list;
	}
	
	// 멤버의 번호를 입력하면, 멤버의 모든 프로젝트 번호를 list형식으로 리턴해준다.
	public ArrayList<Integer> selectAllProject(int memNo){
		ArrayList<Integer> list = new ArrayList<Integer>();
		sb.setLength(0);
		sb.append("SELECT pNo ");
		sb.append("FROM projectMember ");
		sb.append("WHERE memNo = ? and status = 1 ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, memNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				int pno = rs.getInt("pNo");
				list.add(pno);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	// 프로젝트의 번호를 입력하면, 해당 프로젝트에 들어있는 멤버들을 list로 리턴
	public ArrayList<Integer> selectAllMember(int pNo) {
		ArrayList<Integer> list = new ArrayList<Integer>();
		sb.setLength(0);
		sb.append("SELECT memNo ");
		sb.append("FROM projectMember ");
		sb.append("WHERE pNo = ? and status = 1 ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, pNo);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				int pno = rs.getInt("memNo");
				list.add(pno);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public ProjectMemberVO selectOne(int No){
		ProjectMemberVO vo = null;
		sb.setLength(0);
		sb.append("SELECT memNo, pNo, status ");
		sb.append("FROM projectmember ");
		sb.append("WHERE memNo = ?");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, No);
			pstmt.executeQuery();
			
			rs.next();
			int memNo = rs.getInt("memNo");
			int pNo = rs.getInt("pNo");
			int status = rs.getInt("status");
			vo = new ProjectMemberVO(memNo, pNo, status);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vo;
	}	
	
	public ProjectMemberVO checkOne(int pNo, int memNo){
		ProjectMemberVO vo = null;
		sb.setLength(0);
		sb.append("SELECT * ");
		sb.append("FROM projectmember ");
		sb.append("WHERE pNo = ? AND memNo = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, pNo);
			pstmt.setInt(2, memNo);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				int status = rs.getInt("status");
				vo = new ProjectMemberVO(memNo, pNo, status);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vo;
	}	
	
	public void insertOne(ProjectMemberVO vo){
		
		sb.setLength(0);
		sb.append("INSERT INTO projectmember ");
		sb.append("VALUES (?, ?, 1 )"); // 가입상태: 1, 탈퇴: 0
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, vo.getpNo());
			pstmt.setInt(2, vo.getMemNo());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	public void updateOne(ProjectMemberVO vo){
		
		sb.setLength(0);
		sb.append("UPDATE projectmember ");
		sb.append("SET memNo = ?, pNo = ?, status = ? ");
		sb.append("WHERE memNo = ? and pNo = ? ");

		try {

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, vo.getMemNo());
			pstmt.setInt(2, vo.getpNo());
			pstmt.setInt(3, vo.getstatus());
			pstmt.setInt(4, vo.getMemNo());
			pstmt.setInt(5, vo.getpNo());
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	public void deleteOne(int pno, int memNo){
		sb.setLength(0);
		sb.append("DELETE projectMember ");
		sb.append("WHERE pno = ? and memno = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, pno);
			pstmt.setInt(2, memNo);
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
