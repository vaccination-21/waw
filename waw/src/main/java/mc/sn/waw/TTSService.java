package mc.sn.waw;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Date;

import org.springframework.stereotype.Service;

@Service
public class TTSService {
	public String clovaTextToSpeech(String filePathName, String language) {
		 String clientId = "dhmge0vn1o";//애플리케이션 클라이언트 아이디값";
	        String clientSecret = "nf3rJZkgRdHqyWrEmO3YMhhhmNcMKxoZo3ANRt7X";//애플리케이션 클라이언트 시크릿값";
	        String voiceFileName  = "";
	        
	        try {
	        	
	        	// fileRead()에게 파일이름 전송하고 읽은 파일 내용을 문자열로 받음
	        	String fileContents = fileRead(filePathName);
	        	
	            String text = URLEncoder.encode(fileContents, "UTF-8"); // 13자
	            String apiURL = "https://naveropenapi.apigw.ntruss.com/tts-premium/v1/tts";
	            URL url = new URL(apiURL);
	            HttpURLConnection con = (HttpURLConnection)url.openConnection();
	            con.setRequestMethod("POST");
	            con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
	            con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);
	            // post request
	            String postParams = "speaker=" + language + "&volume=0&speed=0&pitch=0&format=mp3&text=" + text;
	            con.setDoOutput(true);
	            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
	            wr.writeBytes(postParams);
	            wr.flush();
	            wr.close();
	            int responseCode = con.getResponseCode();
	            BufferedReader br;
	            if(responseCode==200) { // 정상 호출
	                InputStream is = con.getInputStream();
	                int read = 0;
	                byte[] bytes = new byte[1024];
	                // 랜덤한 이름으로 mp3 파일 생성
	                String tempname = Long.valueOf(new Date().getTime()).toString();
	                
	                 voiceFileName = "tts_" + tempname +  ".mp3";
	                
	                File f = new File("c:/ai/" + voiceFileName); //반환값(저장되는 파일명)
	                
	                f.createNewFile();
	                OutputStream outputStream = new FileOutputStream(f);
	                while ((read =is.read(bytes)) != -1) {
	                    outputStream.write(bytes, 0, read);
	                }
	                is.close();
	            } else {  // 오류 발생
	                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	                String inputLine;
	                StringBuffer response = new StringBuffer();
	                while ((inputLine = br.readLine()) != null) {
	                    response.append(inputLine);
	                }
	                br.close();
	                System.out.println(response.toString());
	            }
	        } catch (Exception e) {
	            System.out.println(e);
	        }
	        
	        return voiceFileName;
	}
	
	public String chatbotTextToSpeech(String message) {
		 String clientId = "dhmge0vn1o";//애플리케이션 클라이언트 아이디값";
	        String clientSecret = "nf3rJZkgRdHqyWrEmO3YMhhhmNcMKxoZo3ANRt7X";//애플리케이션 클라이언트 시크릿값";
	        String voiceFileName  = "";
	        
	        try {
	        	
	        	// fileRead()에게 파일이름 전송하고 읽은 파일 내용을 문자열로 받음
	        	//String fileContents = fileRead(filePathName);
	        	
	            String text = URLEncoder.encode(message, "UTF-8"); // 13자
	            String apiURL = "https://naveropenapi.apigw.ntruss.com/tts-premium/v1/tts";
	            URL url = new URL(apiURL);
	            HttpURLConnection con = (HttpURLConnection)url.openConnection();
	            con.setRequestMethod("POST");
	            con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
	            con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);
	            // post request
	            String postParams = "speaker=nara&volume=0&speed=0&pitch=0&format=mp3&text=" + text;
	            con.setDoOutput(true);
	            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
	            wr.writeBytes(postParams);
	            wr.flush();
	            wr.close();
	            int responseCode = con.getResponseCode();
	            BufferedReader br;
	            if(responseCode==200) { // 정상 호출
	                InputStream is = con.getInputStream();
	                int read = 0;
	                byte[] bytes = new byte[1024];
	                // 랜덤한 이름으로 mp3 파일 생성
	                String tempname = Long.valueOf(new Date().getTime()).toString();
	                
	                 voiceFileName = "tts_" + tempname +  ".mp3";
	                
	                File f = new File("c:/ai/" + voiceFileName); //반환값(저장되는 파일명)
	                
	                f.createNewFile();
	                OutputStream outputStream = new FileOutputStream(f);
	                while ((read =is.read(bytes)) != -1) {
	                    outputStream.write(bytes, 0, read);
	                }
	                is.close();
	            } else {  // 오류 발생
	                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	                String inputLine;
	                StringBuffer response = new StringBuffer();
	                while ((inputLine = br.readLine()) != null) {
	                    response.append(inputLine);
	                }
	                br.close();
	                System.out.println(response.toString());
	            }
	        } catch (Exception e) {
	            System.out.println(e);
	        }
	        
	        return voiceFileName;
	}
	
	
	public String fileRead(String filePathName) {
		String result = "";
		
		try {
			File file = new File(filePathName);
			FileReader fr = new FileReader(file);
			BufferedReader br = new BufferedReader(fr);
			
			String line= "";
			while((line = br.readLine()) != null) {
				result += line;
			}
			
			br.close();
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println(result);
		return result;
	}
	
	
}







