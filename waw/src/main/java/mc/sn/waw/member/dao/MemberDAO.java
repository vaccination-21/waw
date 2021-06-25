package mc.sn.waw.member.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import mc.sn.waw.member.vo.MemberVO;


public interface MemberDAO {
	 public List selectAllMemberList() throws DataAccessException;
	 //회원가입
	 public int insertMember(MemberVO memberVO) throws DataAccessException;
	 //로그인
	 public MemberVO loginById(MemberVO memberVO) throws DataAccessException;
	 //탈퇴하기
	 public int deleteMember(Integer tid) throws DataAccessException;
	 //멤버찾기
	 public MemberVO searchMember(Integer tid) throws DataAccessException;
	 //정보 업데이트
	 public int updateMember(MemberVO memberVO) throws DataAccessException;
	
}
