package mc.sn.waw.chatroom.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import mc.sn.waw.chatroom.vo.ChatRoomJoinVO;
import mc.sn.waw.chatroom.vo.ChatRoomVO;


public interface ChatRoomController {
	//전체 챗방 불러오기
	public ModelAndView listChatRoom(HttpServletRequest request, HttpServletResponse response) throws Exception;
	//챗방 만들기
	public ModelAndView addChatRoom(@ModelAttribute("info") ChatRoomVO ChatRoom,HttpServletRequest request, HttpServletResponse response) throws Exception;
	//챗방 삭제
	public ModelAndView removeChatRoom(@RequestParam("roomTid") Integer roomTid, HttpServletRequest request, HttpServletResponse response) throws Exception;
	//특정 챗방 불러오기
	//public ModelAndView searchChatRoom(@RequestParam("roomTid") Integer roomTid, HttpServletRequest request, HttpServletResponse response) throws Exception;
	//챗방 들어가기,조인
	public ModelAndView addChatRoomJoin(@ModelAttribute("info") ChatRoomJoinVO ChatRoomJoin,HttpServletRequest request, HttpServletResponse response) throws Exception;
	//챗방 조인 삭제
	public ModelAndView removeChatRoomJoin(@RequestParam("info") ChatRoomJoinVO ChatRoomJoinVO, HttpServletRequest request, HttpServletResponse response) throws Exception;
}
