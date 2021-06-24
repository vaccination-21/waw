package mc.sn.waw;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;
import java.util.Date;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

@Service
public class ChatbotService {
	
	public String main(String voiceMessage) {
		String apiURL = "https://2e16145a3da84b8ead39cc41f95bbe66.apigw.ntruss.com/custom/v1/4818/23384e6ae85686b7926ebcbda69e9c0a6d1bb1a2fa4d9cd6fc7b7e58f3c906af";
		String secretKey = "blZETWNrZFl1Z2lGWU1vZWNjVUhIc0FsWUhqdkFsSU0=";

        String chatbotMessage = "";

        try {
            //String apiURL = "https://ex9av8bv0e.apigw.ntruss.com/custom_chatbot/prod/";

            URL url = new URL(apiURL);

            String message = getReqMessage(voiceMessage);
            System.out.println("##" + message);

            String encodeBase64String = makeSignature(message, secretKey);

            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json;UTF-8");
            con.setRequestProperty("X-NCP-CHATBOT_SIGNATURE", encodeBase64String);

            // post request
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.write(message.getBytes("UTF-8"));
            wr.flush();
            wr.close();
            int responseCode = con.getResponseCode();

            BufferedReader br;

            if(responseCode==200) { // Normal call
                System.out.println(con.getResponseMessage());

                BufferedReader in = new BufferedReader(
                        new InputStreamReader(
                                con.getInputStream()));
                String decodedString;
                while ((decodedString = in.readLine()) != null) {
                    chatbotMessage = decodedString;
                }
                //chatbotMessage = decodedString;
                in.close();
                
                System.out.println(chatbotMessage);  // 전달받은 결과 출력
                System.out.println(chatbotMessage.getClass()); //String 타입
                //System.out.println(chatbotMessage.toString());
                
                chatbotMessage = jsonToString(chatbotMessage);
                
            } else {  // Error occurred
                chatbotMessage = con.getResponseMessage();
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        return chatbotMessage;
    }
	
	public String mainJSON(String voiceMessage) {
		String apiURL = "https://2e16145a3da84b8ead39cc41f95bbe66.apigw.ntruss.com/custom/v1/4818/23384e6ae85686b7926ebcbda69e9c0a6d1bb1a2fa4d9cd6fc7b7e58f3c906af";
		String secretKey = "blZETWNrZFl1Z2lGWU1vZWNjVUhIc0FsWUhqdkFsSU0=";

        String chatbotMessage = "";

        try {
            //String apiURL = "https://ex9av8bv0e.apigw.ntruss.com/custom_chatbot/prod/";

            URL url = new URL(apiURL);

            String message = getReqMessage(voiceMessage);
            System.out.println("##" + message);

            String encodeBase64String = makeSignature(message, secretKey);

            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json;UTF-8");
            con.setRequestProperty("X-NCP-CHATBOT_SIGNATURE", encodeBase64String);

            // post request
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.write(message.getBytes("UTF-8"));
            wr.flush();
            wr.close();
            int responseCode = con.getResponseCode();

            BufferedReader br;

            if(responseCode==200) { // Normal call
                System.out.println(con.getResponseMessage());

                BufferedReader in = new BufferedReader(
                        new InputStreamReader(
                                con.getInputStream()));
                String decodedString;
                while ((decodedString = in.readLine()) != null) {
                    chatbotMessage = decodedString;
                }
                //chatbotMessage = decodedString;
                in.close();
                
                System.out.println(chatbotMessage);  // 전달받은 결과 출력
                System.out.println(chatbotMessage.getClass()); //String 타입
                //System.out.println(chatbotMessage.toString());
                //다음 변환 메소드 사용 안함
                //chatbotMessage = jsonToString(chatbotMessage); 
                
            } else {  // Error occurred
                chatbotMessage = con.getResponseMessage();
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        //JSON 형식 문자열 그대로 반환
        return chatbotMessage;
    }
	
	
	public static String jsonToString(String jsonStr) {
		String resultText = "";

		try {
			// 추출할 오브젝트 
			JSONObject jsonObj = new JSONObject(jsonStr);

			// jsonObj에서 bubbles 추출 : 리스트
			JSONArray bubblesArray = (JSONArray) jsonObj.get("bubbles");
			// 리스트의 요소가 1개밖에 없으므로 index를 0으로 지정
			JSONObject obj0 = (JSONObject) bubblesArray.get(0);
			
			JSONObject dataObj = (JSONObject) obj0.get("data");
			resultText = (String) dataObj.get("description");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("jsontostring "+resultText);
		return resultText;
	}
	
	

    public static String makeSignature(String message, String secretKey) {

        String encodeBase64String = "";

        try {
            byte[] secrete_key_bytes = secretKey.getBytes("UTF-8");

            SecretKeySpec signingKey = new SecretKeySpec(secrete_key_bytes, "HmacSHA256");
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(signingKey);

            byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
           // encodeBase64String = Base64.encodeToString(rawHmac, Base64.NO_WRAP);
            encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);

            return encodeBase64String;

        } catch (Exception e){
            System.out.println(e);
        }

        return encodeBase64String;

    }

    public static String getReqMessage(String voiceMessage) {

        String requestBody = "";

        try {

            JSONObject obj = new JSONObject();

            long timestamp = new Date().getTime();

            System.out.println("##"+timestamp);

            obj.put("version", "v2");
            obj.put("userId", "U47b00b58c90f8e47428af8b7bddc1231heo2");
//=> userId is a unique code for each chat user, not a fixed value, recommend use UUID. use different id for each user could help you to split chat history for users.

            obj.put("timestamp", timestamp);

            JSONObject bubbles_obj = new JSONObject();

            bubbles_obj.put("type", "text");

            JSONObject data_obj = new JSONObject();
            data_obj.put("description", voiceMessage);

            bubbles_obj.put("type", "text");
            bubbles_obj.put("data", data_obj);

            JSONArray bubbles_array = new JSONArray();
            bubbles_array.put(bubbles_obj);

            obj.put("bubbles", bubbles_array);
            
            //처음 시작 시 웰컴 메시지 출력
            if(voiceMessage == "") {
            	obj.put("event", "open"); //웰컴 메시지
            } else {
            	obj.put("event", "send"); //답변 메시지
            }

            requestBody = obj.toString();

        } catch (Exception e){
            System.out.println("## Exception : " + e);
        }

        return requestBody;

    }
}
