package mc.sn.waw.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import mc.sn.waw.member.vo.MemberVO;

public interface MemberController {
	public ModelAndView listMembers(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView addMember(@ModelAttribute("info") MemberVO memberVO,HttpServletRequest request, HttpServletResponse response, Model model) throws Exception;
	public ModelAndView removeMember(@RequestParam("tid") Integer tid, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView searchMember(@RequestParam("tid") Integer tid, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView updateMember(@ModelAttribute("info") MemberVO memberVO,HttpServletRequest request, HttpServletResponse response) throws Exception;
	//로그인
	public ModelAndView loginAccess(@RequestParam Map<String, String> loginMap,HttpServletRequest request, HttpServletResponse response, Model model) throws Exception;
	
	
	
}
