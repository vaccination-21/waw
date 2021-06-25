package mc.sn.waw.member.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import mc.sn.waw.member.vo.MemberVO;

public interface MemberService {
	 public List listMembers() throws DataAccessException;
	 public int addMember(MemberVO memberVO) throws DataAccessException;
	 public int removeMember(Integer tid) throws DataAccessException; 
	 public MemberVO searchMember(Integer tid) throws DataAccessException;
	 public int updateMember(MemberVO memberVO) throws DataAccessException;
	 public MemberVO login(MemberVO memberVO) throws Exception; 
}
