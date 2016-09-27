package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.ChatVO;

public class ChatDAO{

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	StringBuffer sb = new StringBuffer();
	
	//기본 생성자
	public ChatDAO()
	{
		conn = MakeConnection.getInstance().getConnection();
	}
	
	//전체조회
		public ArrayList<ChatVO> selectChatList(int pNo){
			ArrayList<ChatVO> list = new ArrayList<ChatVO>();
			
			sb.setLength(0);
			sb.append("SELECT chatWriter, chatTime, chatContents ");
			sb.append("FROM CHAT ");
			sb.append("WHERE pNo=? ");
			sb.append("ORDER BY chatno ");
			
			try {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, pNo);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					String chatWriter = rs.getString("chatWriter");
					String chatTime = rs.getString("chatTime");
					String chatContents = rs.getString("chatContents");

					
					ChatVO vo = new ChatVO(chatWriter, chatTime, chatContents);
					list.add(vo);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return list;
		}//seletAll end
		
	//채팅 추가
		public void insertOne(ChatVO vo)
		{
			sb.setLength(0);
			sb.append("INSERT INTO CHAT ");
			sb.append("VALUES (CHATNO_SEQ.nextval, ?, ?, ?, ?, sysdate) ");
			
			try {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, vo.getpNo());
				pstmt.setInt(2, vo.getMemNo());
				pstmt.setString(3, vo.getChatWriter());
				pstmt.setString(4, vo.getChatContents());
				pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}//채팅끝
		
		//자원정리
		public void close()
		{
				try {
					if(rs!=null) rs.close();
					if(pstmt!=null)	pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
}
