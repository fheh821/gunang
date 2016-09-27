package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.TodoListVO;

public class TodoListDAO {
	//환경변수를 private 멤버변수로 설정하기
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	StringBuffer sb = new StringBuffer();
			
	public TodoListDAO(){
		conn = MakeConnection.getInstance().getConnection();
	}// TodoListDAO() contructor 끝!!	
	
	public ArrayList<TodoListVO> selectAll(int groupno, int pno){
		ArrayList<TodoListVO> list = new ArrayList<TodoListVO>();
		sb.setLength(0);
		sb.append("SELECT * FROM todolist ");
		sb.append("Where groupno=? and pno =? ");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, groupno);
			pstmt.setInt(2, pno);
			rs = pstmt.executeQuery();
			while(rs.next()){
				int listNo = rs.getInt("listNo");
				String listTitle = rs.getString("listTitle");
				String listContents = rs.getString("listContents");
				String startDate = rs.getString("startDate");
				String endDate = rs.getString("endDate");
				int isComplete = rs.getInt("isComplete");
				TodoListVO vo = new TodoListVO(listNo, groupno, pno, listTitle,listContents, startDate, endDate, isComplete);
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}// selectAll 끝!!
	
	public ArrayList<TodoListVO> calendarAll(int pno){
		ArrayList<TodoListVO> clist = new ArrayList<TodoListVO>();
		sb.setLength(0);
		sb.append("SELECT * FROM todolist ");
		sb.append("Where pno =? ");
		sb.append("order by pno desc ");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, pno);
			rs = pstmt.executeQuery();
			while(rs.next()){
				int listNo = rs.getInt("listNo");
				int groupNo = rs.getInt("groupNo");
				String listTitle = rs.getString("listTitle");
				String listContents = rs.getString("listContents");
				String startDate = rs.getString("startDate");
				String endDate = rs.getString("endDate");
				int isComplete = rs.getInt("isComplete");
				TodoListVO vo = new TodoListVO(listNo, groupNo, pno, listTitle,listContents, startDate, endDate, isComplete);
				clist.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return clist;
	}// selectAll 끝!!
	
	public TodoListVO selectOne(int listno){
		sb.setLength(0);
		sb.append("SELECT * FROM todolist ");
		sb.append("Where listno = ? ");
		TodoListVO vo = null;
		// 4.문장 객체
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, listno); 
			rs = pstmt.executeQuery();
			if(rs.next()){
			int groupNo = rs.getInt("groupNo");
			int pNo = rs.getInt("pNo");
			String listTitle = rs.getString("listTitle");
			String listContents = rs.getString("listContents");
			String startDate = rs.getString("startDate");
			String endDate = rs.getString("endDate");
			int isComplete = rs.getInt("isComplete");
			vo = new TodoListVO(listno, groupNo, pNo, listTitle,listContents, startDate, endDate, isComplete);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}// selectOne() 끝!!	
	
	public void insertOne(TodoListVO vo){
		sb.setLength(0);
		sb.append("INSERT INTO todolist ");
		sb.append("VALUES (LISTNO_SEQ.nextval,?,?,?,?,?,?,? ) ");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, vo.getGroupNo());
			pstmt.setInt(2, vo.getpNo());
			pstmt.setString(3, vo.getListTitle());
			pstmt.setString(4, vo.getListContents());
			pstmt.setString(5, vo.getStartDate());
			pstmt.setString(6, vo.getEndDate());
			pstmt.setInt(7, vo.getIsComplete());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//insertOne 끝!!
	
	public void updateOne(TodoListVO vo){
		sb.setLength(0);
		sb.append("UPDATE todolist ");
		sb.append("SET listTitle=?, listContents=?, startDate=?, endDate=?, isComplete=? ");
		sb.append("WHERE listno = ? ");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, vo.getListTitle());
			pstmt.setString(2, vo.getListContents());
			pstmt.setString(3, vo.getStartDate());
			pstmt.setString(4, vo.getEndDate());
			pstmt.setInt(5, vo.getIsComplete());
			pstmt.setInt(6, vo.getListNo());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// updateOne() 끝!!
	
	public void updateIsComplete(int listno, int isComplete){
		sb.setLength(0);
		sb.append("UPDATE todolist ");
		sb.append("SET isComplete = ? ");
		sb.append("WHERE listno = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, isComplete);
			pstmt.setInt(2, listno);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void deletOne(int listno){
		sb.setLength(0);
		sb.append("DELETE todolist ");
		sb.append("WHERE listNO = ? ");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, listno);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//deleteOne() 끝!!
		
	// 자원 반납
		public void close(){
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}// close() 끝!!!		
}//main 끝!!!
