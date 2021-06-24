package mc.sn.waw;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import mc.sn.waw.ChatbotService;
import mc.sn.waw.STTService;
import mc.sn.waw.TTSService;

@Controller
public class ChatbotController {
	@Autowired
	private TTSService ttsService;
	
	@Autowired
	private STTService sttService;
	
	@Autowired
	private ChatbotService chatService;
	
	
	
	@RequestMapping(value="/chatbotTTS",method = RequestMethod.POST,produces ="application/text; charset=UTF-8")
	@ResponseBody
	public String chatbotTTS(@RequestParam("message") String message) {
		String result = "";
		
		result = ttsService.chatbotTextToSpeech(message);	

		return result;
	}
	
	@RequestMapping(value="/chatbotOnlyVoice",produces ="application/text; charset=UTF-8")
	@ResponseBody
	public String clovaSTT4(@RequestParam("uploadFile") MultipartFile file){
		String result = "";

		try {
			if (file == null) {
				//웰컴 메시지 받기 위해 질문 내용 빈 값으로 설정
				result = "";		
			} else {
				String uploadPath = "c:/ai/";
				String originalFilename = file.getOriginalFilename();
				// 3. 파일 생성
				String filePathName = uploadPath + originalFilename;
				File file1 = new File(filePathName);
				file.transferTo(file1);
				
				// 음성 파일을 받아서 텍스트로 변환
				result = sttService.clovaSpeechToText2(filePathName); // 텍스트 받음						
			}
			// 텍스트 질문을 챗봇에게 보내 답변 받음
			result = chatService.main(result); // 텍스트 받음		
			// 챗봇으로부터 받은 텍스트 답변을 음성으로 변환 변환
			result = ttsService.chatbotTextToSpeech(result); // 음성 파일명 받음
		}  catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println(result); // 음성 파일명 반환
		return result;
	}
	
		
	@RequestMapping(value="/chatbotCall",method = RequestMethod.POST,produces ="application/text; charset=UTF-8")
	@ResponseBody
	public String chatbot(@RequestParam("message") String message) {
		String result = chatService.main(message);			
		return result;  
	}
	
	@RequestMapping(value="/chatbotCallJSON",method = RequestMethod.POST,produces ="application/text; charset=UTF-8")
	@ResponseBody
	public String chatbotCallJSON(@RequestParam("message") String message) {
		String result = chatService.mainJSON(message);			
		return result;  //JSON 형식 그대로 반환
	}
	
	// 챗봇 : 음성 메시지를 텍스트로 변환
	@RequestMapping(value="/clovaSTT2",method = RequestMethod.POST,produces ="application/text; charset=UTF-8")
	@ResponseBody
	public String STT2(@RequestParam("uploadFile") MultipartFile file) {
		String result = "";
		
		try {
			//1. 파일 저장 경로 설정 : 실제 서비스 되는 위치 (프로젝트 외부에 저장)
			  String uploadPath =  "c:/ai/";
			  
			  //2.원본 파일 이름
			  String originalFileName = file.getOriginalFilename();  
			  
			  //3. 파일 생성 
			  String filePathName = uploadPath + originalFileName;
			  File file1 = new File(filePathName);
			  
			  //4. 서버로 전송
			  file.transferTo(file1);
			  
			  result = sttService.clovaSpeechToText2(filePathName);
			  System.out.println("result: "+result);
			  
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	

		return result;
	}
}







