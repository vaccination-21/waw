package mc.sn.waw;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;

import org.json.JSONObject;
import org.springframework.stereotype.Service;

@Service
public class STTService {
	public String clovaSpeechToText(String filePathName, String language) {
		String clientId = "gm3v16zsfg";             // Application Client ID";
        String clientSecret = "DboMQbLgxizWEefWFlUMTQSqhLNgvrZ4IBaclRob";     // Application Client Secret";
        String result = "";
        
        try {
            String imgFile = filePathName;
            File voiceFile = new File(imgFile);

            //String language = "Kor";        // 언어 코드 ( Kor, Jpn, Eng, Chn )
            String apiURL = "https://naveropenapi.apigw.ntruss.com/recog/v1/stt?lang=" + language;
            URL url = new URL(apiURL);

            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
            conn.setUseCaches(false);
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setRequestProperty("Content-Type", "application/octet-stream");
            conn.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
            conn.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);

            OutputStream outputStream = conn.getOutputStream();
            FileInputStream inputStream = new FileInputStream(voiceFile);
            byte[] buffer = new byte[4096];
            int bytesRead = -1;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
            outputStream.flush();
            inputStream.close();
            BufferedReader br = null;
            int responseCode = conn.getResponseCode();
            if(responseCode == 200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {  // 오류 발생
                System.out.println("error!!!!!!! responseCode= " + responseCode);
                br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            }
            String inputLine;

            if(br != null) {
                StringBuffer response = new StringBuffer();
                while ((inputLine = br.readLine()) != null) {
                    response.append(inputLine);
                }
                br.close();
                System.out.println(response.toString()); //결과 출력 (JSON 형식의 문자열)
                result = jsonToString(response.toString());
//                resultToFileSave(result);
                resultToFileSave2(result);
            } else {
                System.out.println("error !!!");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        
        return result;
	}
	
	public String clovaSpeechToText2(String filePathName) {
		String clientId = "gm3v16zsfg";             // Application Client ID";
        String clientSecret = "DboMQbLgxizWEefWFlUMTQSqhLNgvrZ4IBaclRob";     // Application Client Secret";
        String result = "";
        
        try {
            String imgFile = filePathName;
            File voiceFile = new File(imgFile);

            String language = "Kor";        // 언어 코드 ( Kor, Jpn, Eng, Chn )
            String apiURL = "https://naveropenapi.apigw.ntruss.com/recog/v1/stt?lang=" + language;
            URL url = new URL(apiURL);

            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
            conn.setUseCaches(false);
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setRequestProperty("Content-Type", "application/octet-stream");
            conn.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
            conn.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);

            OutputStream outputStream = conn.getOutputStream();
            FileInputStream inputStream = new FileInputStream(voiceFile);
            byte[] buffer = new byte[4096];
            int bytesRead = -1;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
            outputStream.flush();
            inputStream.close();
            BufferedReader br = null;
            int responseCode = conn.getResponseCode();
            if(responseCode == 200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {  // 오류 발생
                System.out.println("error!!!!!!! responseCode= " + responseCode);
                br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            }
            String inputLine;

            if(br != null) {
                StringBuffer response = new StringBuffer();
                while ((inputLine = br.readLine()) != null) {
                    response.append(inputLine);
                }
                br.close();
                System.out.println(response.toString()); //결과 출력 (JSON 형식의 문자열)
                result = jsonToString(response.toString());
//                resultToFileSave(result);
                resultToFileSave2(result);
            } else {
                System.out.println("error !!!");
            }
            
            //voiceFile.delete(); //텍스트로 변환된 후 녹음된 음성 파일 삭제
        } catch (Exception e) {
            System.out.println(e);
        }
        
        return result;
	}
	
	public void resultToFileSave(String result) {
		String fileName = Long.valueOf(new Date().getTime()).toString();
		String filePathName = "c:/ai/" + "stt_" + fileName + ".txt";
		
		try {
			FileWriter fw = new FileWriter(filePathName);
			fw.write(result);
			fw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void resultToFileSave2(String result) {
		String fileName = Long.valueOf(new Date().getTime()).toString();
		String filePathName = "c:/ai/" + "stt_" + fileName + ".txt";

		try {
			OutputStream os = new FileOutputStream(filePathName);
			byte[] bytes = result.getBytes();
			os.write(bytes);
			os.close();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	
	
	public String jsonToString(String jsonStr) {
		String resultText = "";
		
		try {
			JSONObject jsonObj = new JSONObject(jsonStr);
			resultText = (String)jsonObj.get("text");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultText;
	}
}










