package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.CheckinVO;

public class CheckinDAO {
	//연결자
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private StringBuffer sb = new StringBuffer();
	
	public CheckinDAO() {
		conn = MakeConnection.getInstance().getConnection();
	}
			
			//전체를 조회하는 메서드
			public ArrayList<CheckinVO> selelctAll(int prjno){   
				sb.setLength(0);
				sb.append("SELECT * FROM checkin ");
				sb.append("WHERE pno = ? ");
				sb.append("ORDER BY checkno DESC ");
				
				ArrayList<CheckinVO> list = new ArrayList<CheckinVO>();
				
				try {
					pstmt = conn.prepareStatement(sb.toString());
					pstmt.setInt(1, prjno);
					rs = pstmt.executeQuery();
					while(rs.next()){
						int checkno = rs.getInt("checkno");
						int pno = prjno;
						int memno = rs.getInt("memno");
						String checktitle = rs.getString("checktitle");
						int checkonoff = rs.getInt("checkonoff");
						String checkdate = rs.getString("checkdate");
						String checktime = rs.getString("checktime");
						String checkday = rs.getString("checkday");
						int periodcode = rs.getInt("periodcode");
						
						CheckinVO vo = new CheckinVO(checkno, pno, memno, checktitle, checkonoff, checkdate, checktime, checkday, periodcode);
						list.add(vo);
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return list;
			}
			
			//하나만 조회하는 메서드
			public CheckinVO selectOne(int checkno){
				sb.setLength(0);
				sb.append("SELECT * FROM checkin ");
				sb.append("WHERE checkno = ? ");
				CheckinVO vo = new CheckinVO();
				
				try {
					pstmt = conn.prepareStatement(sb.toString());
					pstmt.setInt(1, checkno);
					rs = pstmt.executeQuery();
					while(rs.next()){
						int pno = rs.getInt("pno");
						int memno = rs.getInt("memno");
						String checktitle = rs.getString("checktitle");
						int checkonoff = rs.getInt("checkonoff");
						String checkdate = rs.getString("checkdate");
						String checktime = rs.getString("checktime");
						String checkday = rs.getString("checkday");
						int periodcode = rs.getInt("periodcode");
						
						vo = new CheckinVO(checkno, pno, memno, checktitle, checkonoff, checkdate, checktime, checkday, periodcode);
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return vo;
			}
			
			//게시물의 총갯수를 위한 메서드? 가 필요한가? 그냥 써놀고 나중에 버릴까?
			public int checkGetTotalCount(){
				sb.setLength(0);
				sb.append("SELECT COUNT(*) CHECKCNT FROM checkin ");
				int totalcount = 0;
				//기본적으로 생성시 0으로 생성 게시물이 생성될때마다 하나씩 늘어남
				try {
					pstmt = conn.prepareStatement(sb.toString());
					rs = pstmt.executeQuery();
					rs.next();
					totalcount = rs.getInt("CHECKCNT");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return totalcount;
			}
		
			
			
			//날짜주기를 위한 메서드도 만들어야하나? 딱히 필요는 없을듯? 업데이트로 대신?
			
			
			
			//insert메서드
			public void checkinInsert(CheckinVO vo){
				sb.setLength(0);
				sb.append("INSERT INTO checkin ");
				sb.append("VALUES (checkno_seq.nextval , ?, ?, ?, 1, sysdate, ?, ?, ?) ");
				// status : 0(false) off 처리, 1(true) on처리
				//나머지 pno, memno는 중앙 DB에서 생성하는 것을 가지고 사용한기 때문에 ?를 사용한다.(선미)
				
				try {
					pstmt = conn.prepareStatement(sb.toString());
					pstmt.setInt(1, vo.getPno());
					pstmt.setInt(2, vo.getMemno());
					pstmt.setString(3, vo.getChecktitle());
					pstmt.setString(4, vo.getChecktime());
					pstmt.setString(5, vo.getCheckday());
					pstmt.setInt(6, vo.getPeriodcode());
					pstmt.executeUpdate();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			//update메서드 수정을 위한메서드 라고나 할까?
			public void checkUpdate(CheckinVO vo){
				sb.setLength(0);
				sb.append("UPDATE checkin ");
				sb.append("SET checktitle = ? , checkonoff = ? , checktime = ?, checkday = ?, periodcode = ? ");
				sb.append("WHERE checkno = ? ");
				try {
					pstmt = conn.prepareStatement(sb.toString());
					pstmt.setString(1, vo.getChecktitle());
					pstmt.setInt(2, vo.getCheckonoff());
					pstmt.setString(3, vo.getChecktime());
					pstmt.setString(4, vo.getCheckday());
					pstmt.setInt(5, vo.getPeriodcode());
					pstmt.setInt(6, vo.getCheckno());
					pstmt.executeUpdate();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			
			
			
			//delete메서드
			public void checkDelete(int checkno){
				sb.setLength(0);
				sb.append("DELETE checkin ");
				sb.append("WHERE checkno = ? ");
				System.out.println(sb);
				try {
					pstmt = conn.prepareStatement(sb.toString());
					pstmt.setInt(1, checkno);
					pstmt.executeUpdate();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} 
			
			public int getcheckNum(){
				int checkmemNo = 0;
				sb.setLength(0);
				sb.append("Select max(checkNo) ");
				sb.append("from checkin ");
				
				try{
					pstmt = conn.prepareStatement(sb.toString());
					rs = pstmt.executeQuery();
					
					if(rs.next()){
						checkmemNo = rs.getInt("max(checkNo)");
					}
				}catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
				return checkmemNo;
			}
			
			public ArrayList<CheckinVO> selelctChecknolist(){
				sb.setLength(0);
				sb.append("SELECT * FROM checkin ");
				sb.append("WHERE checkonoff = 1 && pno = ? "); 				
				
				ArrayList<CheckinVO> list = new ArrayList<CheckinVO>();
				CheckinVO vo = new CheckinVO();
				
				try {
					pstmt = conn.prepareStatement(sb.toString());
					rs = pstmt.executeQuery();
					while(rs.next()){
						int checkno = rs.getInt("checkno");
						int pno = rs.getInt("pno");
						int memno = rs.getInt("memno");
						String checktitle = rs.getString("checktitle");
						int checkonoff = rs.getInt("checkonoff");
						String checkdate = rs.getString("checkdate");
						String checktime = rs.getString("checktime");
						String checkday = rs.getString("checkday");
						int periodcode = rs.getInt("periodcode");
						
						vo = new CheckinVO(checkno, pno, memno, checktitle, checkonoff, checkdate, checktime, checkday, periodcode);
						list.add(vo);
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return list;
			}
			
			
			//close메서드
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
