package mc.sn.waw;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {		
		return "home";
	}
	
	@RequestMapping("/sign_up")
	public String sign_up() {
		return "sign_up";
	}
	
	@RequestMapping("/chatbot")
	public String chatbot() {
		return "chatbot";
	}
	
	@RequestMapping(value = "/echo", method = RequestMethod.GET)
	public String chatting(Locale locale, Model model) {
		
		return "chatting";
	}
	@RequestMapping(value = "/chat.do", method = RequestMethod.GET)
	public String view_chat() throws Exception {
		
		return "view_chat";
	}
	
	@RequestMapping("/room1")
	public String room1() {
		return "room1";
	}
	
	
}
