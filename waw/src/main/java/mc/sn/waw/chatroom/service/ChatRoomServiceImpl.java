package mc.sn.waw.chatroom.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import mc.sn.waw.chatroom.dao.ChatRoomDAO;
import mc.sn.waw.chatroom.vo.ChatRoomJoinVO;
import mc.sn.waw.chatroom.vo.ChatRoomVO;

@Service("ChatRoomService")
@Transactional(propagation = Propagation.REQUIRED)
public class ChatRoomServiceImpl implements ChatRoomService {
	@Autowired
	private ChatRoomDAO ChatRoomDAO;

	@Override
	public List listChatRoom() throws DataAccessException {
		List ChatRoomList = null;
		ChatRoomList = ChatRoomDAO.selectAllChatRoomList();
		return ChatRoomList;
	}

	@Override
	public int addChatRoom(ChatRoomVO ChatRoomVO) throws DataAccessException {
		return ChatRoomDAO.insertChatRoom(ChatRoomVO);
	}
	
	@Override
	public int removeChatRoom(Integer roomTid) throws DataAccessException {
		return ChatRoomDAO.deleteChatRoom(roomTid);
	}
	
	@Override
	public ChatRoomVO searchChatRoom(Integer roomTid) throws DataAccessException {
	
		return ChatRoomDAO.searchChatRoom(roomTid);
	}
	
	@Override
	public int addChatRoomJoin(ChatRoomJoinVO ChatRoomJoinVO) throws DataAccessException {
		return ChatRoomDAO.insertChatRoomJoin(ChatRoomJoinVO);
	}
	
	@Override
	public int removeChatRoomJoin(ChatRoomJoinVO ChatRoomJoinVO) throws DataAccessException {
		return ChatRoomDAO.deleteChatRoomJoin(ChatRoomJoinVO);
	}
}
