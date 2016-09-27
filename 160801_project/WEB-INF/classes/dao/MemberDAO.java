package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.MemberVO;


public class MemberDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private StringBuffer sb = new StringBuffer();
	
	public MemberDAO() {
		conn = MakeConnection.getInstance().getConnection();
	}
	
	// selectAll()
	public ArrayList<vo.MemberVO> selectAll(){
		ArrayList<MemberVO> list = new ArrayList<>();
		MemberVO vo;
				
		sb.setLength(0);
		sb.append("SELECT memNo, name, email, password, joinway, icon ");
		sb.append("FROM member ");
		//System.out.println(sb);
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			//System.out.println(rs.next());
			while(rs.next()){
				int pno = rs.getInt("memNo");
				String name = rs.getString("name");
				String email = rs.getString("email");
				String password = rs.getString("password");
				int joinway = rs.getInt("joinway");
				String icon = rs.getString("icon");
				vo = new MemberVO(pno, name, email,password, joinway, icon);
				list.add(vo);				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		return list;
	}
	
	// 로그인에 필요한 메소드
	public MemberVO login(String email, String password){
		MemberVO vo = null;
		sb.setLength(0);
		sb.append("SELECT * FROM member ");
		sb.append("WHERE email = ? and password = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			rs = pstmt.executeQuery();
			if(rs.next()){
				int pno = rs.getInt("memNo");
				String name = rs.getString("name");
				int joinway = rs.getInt("joinway");
				String icon = rs.getString("icon");
				vo = new MemberVO(pno, name, email, password, joinway, icon);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vo;
		
	}
	
	// 구글 로그인에 필요한 메소드
	public MemberVO Glogin(String email, String password){
		MemberVO vo = null;
		sb.setLength(0);
		sb.append("SELECT * FROM member ");
		sb.append("WHERE email = ? and password = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			rs = pstmt.executeQuery();
			if(rs.next()){
				String name = rs.getString("name");
				int pno = rs.getInt("memNo");
				int joinway = rs.getInt("joinway");
				String icon = rs.getString("icon");
				vo = new MemberVO(pno, name, email, password, joinway, icon);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vo;
		
	}
	
	//회원가입시 email을 체크하는 메서드를 만들었다.
	public boolean checkEmail(String email){
		sb.setLength(0);
		sb.append("SELECT * FROM member ");
		sb.append("WHERE email = ? ");
		MemberVO vo = new MemberVO();
		System.out.println(sb.toString());
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()){// 디비에 값이 있으면
				int pno = rs.getInt("memNo");
				String name = rs.getString("name");
				String password = rs.getString("password");
				int joinway = rs.getInt("joinway");
				String icon = rs.getString("icon");
				vo = new MemberVO(pno, name, email,password, joinway, icon);
			}else{// 디비에 값이 없으면
				System.out.println("새로운 email이네요~~~");
				return false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return true;
	}
	
	
	public MemberVO selectOne(int memNo){
		MemberVO vo = null;
		sb.setLength(0);
		sb.append("SELECT memNo, name, email, password, joinway, icon ");
		sb.append("FROM member ");
		sb.append("WHERE memNo = ?");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, memNo);
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				int pno = rs.getInt("memNo");
				String name = rs.getString("name");
				String email = rs.getString("email");
				String password = rs.getString("password");
				int joinway = rs.getInt("joinway");
				String icon = rs.getString("icon");
				vo = new MemberVO(pno, name, email, password, joinway, icon);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vo;
	}	
	
	public void insertOne(MemberVO vo){
		
		sb.setLength(0);
		sb.append("INSERT INTO member ");
		sb.append("VALUES (MEMNO_SEQ.NEXTVAL, ?, ?, ?, ?, '../images/park.gif' )");
		//아이콘은 기본적으로 생성이 되는 것인지?
		//아이콘텍스트필드를 클릭하면 이미지를 가지고오는 것을 시도한다?
		//아니다 기본값으로 아이콘을 생성하고 나머지는 수정하게한다.
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getEmail());
			pstmt.setString(3, vo.getPassword());
			pstmt.setInt(4, vo.getJoinway());
			//가입방법은 기본적으로  0이 부여된다.
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void updateOne(MemberVO vo){
		
		sb.setLength(0);
		sb.append("UPDATE member ");
		sb.append("SET name = ?, email = ?, password = ?, joinway = ?, icon = ? ");
		sb.append("WHERE memNo = ? ");

		try {

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getEmail());
			pstmt.setString(3, vo.getPassword());
			pstmt.setInt(4, vo.getJoinway());
			pstmt.setString(5, vo.getIcon());
			pstmt.setInt(6, vo.getMemNo());
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
/*	public void deleteOne(int memNo){
		
		sb.setLength(0);
		sb.append("DELETE member ");
		sb.append("WHERE memNo = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, memNo);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}*/
	
	public int searchOne(String email){
		int memno = 0;
		sb.setLength(0);
		sb.append("SELECT memNo ");
		sb.append("FROM member ");
		sb.append("WHERE email = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				memno = rs.getInt("memNo");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return memno;
	}	
	
	public ArrayList<vo.MemberVO> selectmemEmailList(){
		ArrayList<MemberVO> list = new ArrayList<>();
		MemberVO vo;
				
		sb.setLength(0);
		sb.append("SELECT memNo, name, email, password, joinway, icon ");
		sb.append("FROM member ");
		//System.out.println(sb);
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			//System.out.println(rs.next());
			while(rs.next()){
				int pno = rs.getInt("memNo");
				String name = rs.getString("name");
				String email = rs.getString("email");
				String password = rs.getString("password");
				int joinway = rs.getInt("joinway");
				String icon = rs.getString("icon");
				vo = new MemberVO(pno, name, email,password, joinway, icon);
				list.add(vo);				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		return list;
	}
	
	public ArrayList<MemberVO> selectAllMemberName(int pNo) {
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
		MemberVO vo;
		sb.setLength(0);
		sb.append("SELECT name ");
		sb.append("FROM member ");
		sb.append("WHERE pNo = ?");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, pNo);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				int pno = rs.getInt("memNo");
				String name = rs.getString("name");
				String email = rs.getString("email");
				String password = rs.getString("password");
				int joinway = rs.getInt("joinway");
				String icon = rs.getString("icon");
				vo = new MemberVO(pno, name, email,password, joinway, icon);
				list.add(vo);				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	
	public void close(){
		
		try {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			/*if(conn!=null) conn.close();*/
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
