package mc.sn.waw.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import mc.sn.waw.member.dao.MemberDAO;
import mc.sn.waw.member.vo.MemberVO;

@Service("memberService")
@Transactional(propagation = Propagation.REQUIRED)
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO memberDAO;

	@Override
	public List listMembers() throws DataAccessException {
		List membersList = null;
		membersList = memberDAO.selectAllMemberList();
		return membersList;
	}

	@Override
	public int addMember(MemberVO member) throws DataAccessException {
		return memberDAO.insertMember(member);
	}

	@Override
	public int removeMember(Integer tid) throws DataAccessException {
		return memberDAO.deleteMember(tid);
	}
	@Override
	public MemberVO searchMember(Integer tid) throws DataAccessException {
		return memberDAO.searchMember(tid);
	}
	
	@Override
	public int updateMember(MemberVO memberVO) throws DataAccessException {
		int result = memberDAO.updateMember(memberVO);
		return result;
	}
	
	@Override
	public MemberVO login(MemberVO memberVO) throws Exception{
		MemberVO vo = null;
		vo = memberDAO.loginById(memberVO);
		return vo;
	}
}
