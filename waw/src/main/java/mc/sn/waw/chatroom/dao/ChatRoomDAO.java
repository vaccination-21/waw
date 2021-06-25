package mc.sn.waw.chatroom.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import mc.sn.waw.chatroom.vo.ChatRoomJoinVO;
import mc.sn.waw.chatroom.vo.ChatRoomVO;

public interface ChatRoomDAO {

	 //채팅방리스트
	 public List selectAllChatRoomList() throws DataAccessException;
	 //채팅방 생성
	 public int insertChatRoom(ChatRoomVO ChatRoomVO) throws DataAccessException;
	 //특정 챗방 불러오기
	 public ChatRoomVO searchChatRoom(Integer roomTid) throws DataAccessException;
	 //챗방 나가기
	 public int deleteChatRoom(Integer roomTid) throws DataAccessException;
	 //채팅방 들어가기,조인
	 public int insertChatRoomJoin(ChatRoomJoinVO ChatRoomJoinVO) throws DataAccessException;
	 //조인 테이블 나가기
	 public int deleteChatRoomJoin(ChatRoomJoinVO ChatRoomJoinVO) throws DataAccessException;
}
