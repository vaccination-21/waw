package mc.sn.waw.chatroom.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import mc.sn.waw.chatroom.vo.ChatRoomJoinVO;
import mc.sn.waw.chatroom.vo.ChatRoomVO;

public interface ChatRoomService {
	 public List listChatRoom();
	 public int addChatRoom(ChatRoomVO ChatRoomVO) throws DataAccessException;
	 public int removeChatRoom(Integer roomTid) throws DataAccessException;
	 public ChatRoomVO searchChatRoom(Integer roomTid) throws DataAccessException;
	 public int addChatRoomJoin(ChatRoomJoinVO ChatRoomJoinVO) throws DataAccessException;
	 public int removeChatRoomJoin(ChatRoomJoinVO ChatRoomJoinVO) throws DataAccessException;
}
