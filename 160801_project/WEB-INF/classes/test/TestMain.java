package test;

import java.util.ArrayList;

import dao.BoardDAO;
import dao.CardDAO;
import dao.CardReplyDAO;
import dao.TodoGroupDAO;
import vo.BoardVO;
import vo.CardReplyVO;
import vo.CardVO;
import vo.TodoGroupVO;

public class TestMain {
	public static void main(String[] args) {
		// BoardDAO TEST
		/*BoardDAO dao = new BoardDAO();
		
		BoardVO vo = new BoardVO(1, 1, 1, "boardtest1");
		
		dao.insertOne(vo);
		
		dao.close();*/
		
		/*BoardDAO dao = new BoardDAO();
		
		ArrayList<BoardVO>list = dao.selectAll(1);
		for(BoardVO x : list){
			System.out.println(x.getBoardTitle());
		}
		
		dao.close();*/
		
		/*CardDAO dao = new CardDAO();
		CardVO vo = new CardVO(1, 1, 1, 1, "card제목test", "card내용test", "card작성자","날짜");
		dao.InsertOne(vo);
		dao.close();*/
		
		//CardDAO dao2 = new CardDAO();
		/*ArrayList<CardVO>list2 = dao2.selectAll(1, 1);
		for(CardVO x : list2){
			System.out.println(x.getCardTitle());
		}*/
		
		//dao2.updateOne(1, "card update 테스트", "카드내용 수정중");
		
		/*CardVO vo = dao2.selectOne(1);
		System.out.println(vo.getCardTitle());
		dao2.close();*/
		
		
		//CardReplyDAO dao3 = new CardReplyDAO();
		/*CardReplyVO vo = new CardReplyVO(1, 1, 1, 1, "카드댓글내용", "fresh", "날짜");
		dao.insertOne(vo);
		dao.close();*/
		
		//ArrayList<CardReplyVO> list3 = dao3.selectAll(1, 1);
		
		TodoGroupDAO dao = new TodoGroupDAO();
		TodoGroupVO vo = dao.selectOne(11);
		System.out.println(vo.getGroupTitle());
		System.out.println(vo.getGroupContents());
	}
	
}
