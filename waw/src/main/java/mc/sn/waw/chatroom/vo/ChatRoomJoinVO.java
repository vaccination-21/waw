package mc.sn.waw.chatroom.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("ChatRoomJoinVO")
//채팅방조인 
public class ChatRoomJoinVO {

	 // 사용자ID 
	 private Integer tid;
	
	 // 방ID 
	 private Integer roomTid;

	 // 생성시간 
	 private Date roomJoinCreationDate;
	 
	 public ChatRoomJoinVO() {
			
	}

	public ChatRoomJoinVO(Integer tid, Integer roomTid) {
		this.tid = tid;
		this.roomTid = roomTid;
	}

	public Integer getTid() {
	     return tid;
	 }
	
	 public void setTid(Integer tid) {
	     this.tid = tid;
	 }
	
	 public Integer getRoomTid() {
	     return roomTid;
	 }
	
	 public void setRoomtid(Integer roomTid) {
	     this.roomTid = roomTid;
	 }
	 
	 public Date getRoomJoinCreationDate() {
			return roomJoinCreationDate;
		}

	 public void setRoomJoinCreationDate(Date roomJoinCreationDate) {
		this.roomJoinCreationDate = roomJoinCreationDate;
	}
	
}
