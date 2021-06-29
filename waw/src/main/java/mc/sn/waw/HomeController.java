package mc.sn.waw;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpServletRequest request, Model model) {
		HttpSession sess = request.getSession();
		String session = (String)sess.getAttribute("msg");
		model.addAttribute("msg" , session);
		return "home";
	}
	
	@RequestMapping("/sign_up")
	public String sign_up() {
		return "sign_up";
	}
	
	@RequestMapping("/chatbot")
	public String chatbot(HttpServletRequest request, Model model) {
		HttpSession sess = request.getSession();
		String session = (String)sess.getAttribute("id");
		model.addAttribute("userId", session);
		
		System.out.println(session);
	
		
		return "chatbot";
	}
	
	@RequestMapping(value = "/echo",produces = "application/text; charset=utf8", method = RequestMethod.GET)
	public String chatting(Locale locale, Model model) {
		
		return "chatting";
	}
	@RequestMapping(value = "/chat.do", produces = "application/text; charset=utf8",method = RequestMethod.GET)
	public String view_chat() throws Exception {
		
		return "view_chat";
	}
	
	@RequestMapping("/room1")
	public String room1(HttpServletRequest request, Model model) {
		
		HttpSession sess = request.getSession();
		String session = (String)sess.getAttribute("id");
		model.addAttribute("userId", session);
		
		System.out.println(session);
		return "room1";
	}
	
	
}
