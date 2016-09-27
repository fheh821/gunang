package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.TodoGroupVO;

public class TodoGroupDAO {
	// 환경변수를 private 멤버변수로 설정하기
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	StringBuffer sb = new StringBuffer();

	// 기본생성자에 의해서 connection 객체 생성
	public TodoGroupDAO() {
		conn = MakeConnection.getInstance().getConnection();
	}// TodogroupDAO() contructor 끝!

	public ArrayList<TodoGroupVO> selectAll(int pno) {
		ArrayList<TodoGroupVO> list = new ArrayList<TodoGroupVO>();
		sb.setLength(0);
		sb.append("SELECT * FROM todogroup ");
		sb.append("Where pNo = ? ");
		sb.append("ORDER BY groupno desc ");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, pno);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int groupNo = rs.getInt("groupNo");
				int memNo = rs.getInt("memNo");
				String groupTitle = rs.getString("groupTitle");
				String groupContents = rs.getString("groupContents");
				String groupColor = rs.getString("groupColor");
				TodoGroupVO vo = new TodoGroupVO(groupNo, pno, memNo, groupTitle, groupContents, groupColor);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}// selectAll 끝~~

	// 근데 이게 필요한건지는 잘모르겠어....
	public TodoGroupVO selectOne(int gruopno) {
		sb.setLength(0);
		sb.append("SELECT * FROM todogroup ");
		sb.append("Where groupNo = ? ");
		TodoGroupVO vo = null;
		// 4.문장 객체
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, gruopno); // 1은 첫번째 물음표, 그 다음은 내가 찾는 매개변수(부서번호; no)
										// 넣기
			// 5.실행
			rs = pstmt.executeQuery();
			if (rs.next()) {
				int pNo = rs.getInt("pNo");
				int memNo = rs.getInt("memNo");
				String groupTitle = rs.getString("groupTitle");
				String groupContents = rs.getString("groupContents");
				String groupColor = rs.getString("groupColor");
				vo = new TodoGroupVO(gruopno, pNo, memNo, groupTitle, groupContents, groupColor);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}// selectOne() 끝!!

	public void insertOne(TodoGroupVO vo) {
		sb.setLength(0);
		sb.append("INSERT INTO todogroup ");
		sb.append("VALUES (GROUPNO_SEQ.nextval,?,?,?,?,?) ");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, vo.getpNo());
			pstmt.setInt(2, vo.getMemNo());
			pstmt.setString(3, vo.getGroupTitle());
			pstmt.setString(4, vo.getGroupContents());
			pstmt.setString(5, vo.getGroupColor());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// insertOne() 끝!!

	public String getColor(int groupno) {
		sb.setLength(0);
		sb.append("SELECT GROUPCOLOR FROM todogroup ");
		sb.append("Where groupno = ? ");
		String color = null;
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, groupno);
			rs = pstmt.executeQuery();
			rs.next();
			color = rs.getString("GROUPCOLOR");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return color;
	}

	// group 수정에 관한 DAO
	public void updateOne(TodoGroupVO vo) {
		sb.setLength(0);
		sb.append("UPDATE todogroup ");
		sb.append("SET grouptitle = ? , groupcontents = ? , groupcolor = ? ");
		sb.append("WHERE groupno = ? ");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, vo.getGroupTitle());
			pstmt.setString(2, vo.getGroupContents());
			pstmt.setString(3, vo.getGroupColor());
			pstmt.setInt(4, vo.getGroupNo());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//그룹삭제 DAO
	public void deleteOne(int groupno){
		sb.setLength(0);
		sb.append("DELETE todogroup ");
		sb.append("WHERE groupNO = ? ");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, groupno);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//deleteOne() 끝!!

	// 자원 반납
	public void close() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}// close() 끝!!!
}// main end!!
