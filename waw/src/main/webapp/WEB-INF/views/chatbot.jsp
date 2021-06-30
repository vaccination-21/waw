<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>챗봇 페이지</title>
	<script src="<c:url value='resources/js/jquery-3.6.0.min.js'/>"></script>
	<script src="<c:url value='resources/js/chatbot.js'/>"></script>
 	<script type="text/javascript">	
		$(function(){
			// 웰컴 메시지 받기 위해서 message 란에 입력 받기 전에
			//빈 값으로 서버에 전송하고 웰컴 메시지 받음
			// message 값 없이 서버로 전송
			$('audio').hide();
			
			///////////////////////////////////////////////////////////////
			/* 음성 질문 녹음 */
			
			const record = document.getElementById("record");
		       const stop = document.getElementById("stop");
		       const soundClips = document.getElementById("sound-clips");

		       const audioCtx = new(window.AudioContext || window.webkitAudioContext)(); // 오디오 컨텍스트 정의

		       if (navigator.mediaDevices) {
		           var constraints = {
		               audio: true
		           }
		            let chunks = [];

		           navigator.mediaDevices.getUserMedia(constraints)
		               .then(stream => {
		                   const  mediaRecorder = new MediaRecorder(stream);
		             
		                   record.onclick = () => {
		                       mediaRecorder.start();
		                       record.style.background = "red";
		                       record.style.color = "black";
		                   }

		                   stop.onclick = () => {//정지 버튼 클릭 시
		                       mediaRecorder.stop();//녹음 정지                       
		                       record.style.background = "";
		                       record.style.color = "";
		                   }
		                   
		                   mediaRecorder.onstop = e => {
		                       
		                       const clipName = "voiceMsg";  // 파일명 : 확장자 안 붙었음
								//태그 3개 생성
		                       const clipContainer = document.createElement('article');                     
		                       //const audio = document.createElement('audio');
		                       const a = document.createElement('a');
								// 속성/ 컨텐츠 설정
		                       //clipContainer.classList.add('clip');
		                       //audio.setAttribute('controls', '');                        
		                       //clipContainer.appendChild(audio);
		                      
		                       clipContainer.appendChild(a);
		                       soundClips.appendChild(clipContainer);                        
								
		                       //chunks에 저장된 녹음 데이터를 audio 양식으로 설정
		                      // audio.controls = true;
		                       const blob = new Blob(chunks, {
		                           'type': 'audio/mp3 codecs=opus'
		                       }); 
		                       
		                       chunks = [];
		                       const audioURL = URL.createObjectURL(blob);
		                       //audio.src = audioURL;
		                       //a.href=audio.src;
		                      //blob:http://localhost:8011/6377d19d-2ca8-49b1-a37f-068d602ceb60    
		                       a.href=audioURL;                   
		                       a.download = clipName;                      
		                      //a.innerHTML = "DOWN"
		                      
/* 								a.click(); // 다운로드 폴더에 저장하도록 클릭 이벤트 발생		 */
								
								//서버로 업로드: 다운로드 후 1초 대기
								/*setTimeout(function(){
									fileUpload(clipName + ".mp3"); //파일명
								}, 1000);*/
								//파일 다운로드 하지 않으니까 1초 대기할 필요 없음
								fileUpload(blob, clipName); //파일 데이터와 파일명 전달
								
												
		                   }//mediaRecorder.onstop

		                   //녹음 시작시킨 상태가 되면 chunks에 녹음 데이터를 저장하라 
		                   mediaRecorder.ondataavailable = e => {
		                       chunks.push(e.data)
		                   }
		                   
		               })
		               .catch(err => {
		                   console.log('The following error occurred: ' + err)
		               })
		       }   
			
			
		});
			///////////////////////////////////////////////////////////////
			
			/* 서버에 업로드 */
			function fileUpload(blob, clipName){
				// 파일 업로드 부분 추가
				var formData = new FormData();
				formData.append('uploadFile', blob, clipName+".mp3");
				
				$.ajax({
					type:"post",
					url:"clovaSTT2",
					async:false,
					//dataType:"application/text; charset=UTF-8",
					data: formData, // 폼 데이터 전송
					processData:false, //필수
					contentType:false, //필수
					success:function(result){
						/* chatBox에 보낸 메시지 추가 (동적 요소 추가) */ /* 넌 누구니? */
						//$('#messageArea').append('<div class="msgBox send"><span>' +
						//							result + '</span></div><br>');	
						
						//webSocket._socket.send("");
					//챗봇에게 전달
						$('#message').val(result);
						$('#chatBox').append('<div class="msgBox send"><span>' +
								$('#message').val() + '</span></div><br>');		
						callAjax();
						/* 입력란 비우기 */
						$('#message').val('');
						callAjaxTTS(result);
						
						//$('audio').prop("c", '/ai/' + 'tts__1624494930089.mp3')[0].play();
						
						//var audio = new Audio('c/ai/tts__1624494930089.mp3');
						//audio.play();
						console.log("play");
						
					},
					error:function(e){
						alert("에러 발생 file upload: " + e);
					}		
				});
				
				
				
			}
			
			function callAjax(){
				$.ajax({
					type:"post",
					//dataType:'application/json;UTF-8',/*추가*/
					url:"chatbotCall",
					data:{message:$('#message').val()},
					success:function(result){	  //JSON  형식 그대로 받음
						 //result = JSON.parse(result); 
						 // alert(result);
						 $('#chatBox').append('<div class="msgBox receive"><div class="name">🤖 WAW팀 챗봇</div><br><div class="dsc">' +
							result + '</div></div><br><br>');	
						//console.log(result);
						var bubbles = result.bubbles;
						//alert(bubbles);
						for(var b in bubbles){
							//alert(bubbles[b]);
							console.log([b]);
							if(bubbles[b].type == 'text'){ //기본 답변인 경우
								/*chatBox에 받은 메시지 출력 (챗봇의 답변))*/
								$('#chatBox').append('<div class="msgBox receive"><div class="name">🤖 WAW팀 챗봇</div><br><div class="dsc">' +
													result + '</div></div><br><br>');	
								//챗봇으로 부터 받은 텍스트 답변을 음성으로 변환하기 위해  TTS  호출
								callAjaxTTS(bubbles[b].data.description);		
								//alert(bubbles+", "+bubbles[b].data.description);			
							} else if(bubbles[b].type == 'template'){  //이미지 답변 또는 멀티링크 답변인 경우
								if(bubbles[b].data.cover.type == 'image'){ //이미지인 경우
									// 이미지 출력
									$('#chatBox').append("<img src='" +  bubbles[b].data.cover.data.imageUrl +  "'  alt=' 이미지 없음' >");	
									
									// 이미지만 있는 경우 / 이미지 + 텍스트 경우
									if(bubbles[b].data.contentTable == null){   //이미지만 있는 경우 url  추출
										$('#chatBox').append("<a href='" + bubbles[b].data.cover.data.url + "' target='_blank'> " +
										bubbles[b].data.cover.data.url + "</a><br>" );
										
									} else{  //이미지+ 텍스트인 경우 텍스트와  url 추출
										//텍스트만 추출하고 멀티링크와 공통되는 contentTable은 아래에서 다중 for문 사용해서  url 추출
										$('#chatBox').append("<p>" + bubbles[b].data.cover.data.description + "</p>");	
										//챗봇으로 부터 받은 텍스트 답변을 음성으로 변환하기 위해  TTS  호출
										callAjaxTTS(bubbles[b].data.cover.data.description);
									}
									
								} else if(bubbles[b].data.cover.type == 'text'){ //멀터링크인 경우
									$('#chatBox').append("<p>" + bubbles[b].data.cover.data.description + "</p>");	
										//챗봇으로 부터 받은 텍스트 답변을 음성으로 변환하기 위해  TTS  호출
										callAjaxTTS(bubbles[b].data.cover.data.description);
								}
								
								//이미지/멀티링크 답변 공통 (contentTable  포함)
								for(var ct in bubbles[b].data.contentTable){
									var ct_data = bubbles[b].data.contentTable[ct];
									for(var ct_d in ct_data){
										$('#chatBox').append("<a href='" + ct_data[ct_d].data.data.action.data.url + "' target='_blank'> " +
										ct_data[ct_d].data.data.action.data.url + "</a><br>" );
									}
								}						
							}
							
						} // bubbles for 문 종료
													
						/* 스크롤해서 올리기 */
						$('#chatBox').scrollTop($('#chatBox').prop("scrollHeight"));
						
						
					},
					error:function(e){
						alert("에러 발생 : " + e);
					}			
				});
			}
			
			
			///////////////////////////////////////////////////////////////
			
			$('#chatForm').on('submit', function(event){
				event.preventDefault(); //submit 후에  reload 안 되게
				
				/* chatBox에 보낸 메시지 추가 (동적 요소 추가) */ /* 넌 누구니? */
				if($('#message').val() != ""){
					$('#divChatData').append('<div class="msgBox send"><span>' +
													$('#message').val() + '</span></div><br>');		
				}
				
				//callAjax();
				/* 입력란 비우기 */
				$('#message').val('');
				
			}); //submit 끝
			
			///////////////////////////////////////////////////
			// 이미지/멀티링크 답변 포함된 답변 처리
				
			
			function callAjaxTTS(result){
				$.ajax({
					type:"post",
					//dataType:"application/x-www-form-urlencoded; charset=UTF-8",
					url:"chatbotTTS",
					//async:false,

					data:{message:result},
					success:function(result){
						$('audio').prop("c", '/ai/' + result)[0].play();
						console.log(result);
						
						
						
					},
					error:function(e){
						alert("에러 발생 call ajax tts: " + e);
					}			
				});
				
			}
	</script> 
	  <link rel="stylesheet" href="resources/css/chatbot.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@700&display=swap" rel="stylesheet">

</head>
<body>
  <div class="float_div">
    <div class="chat_home">
      <div class="chat_intro">
        <div class="title">
          👨🏼‍🤝‍👨🏻 WAW 챗봇 주의사항
        </div>
        <div class="sub_title">
 
          <ol>
            <li>취미, 취업 2가지 분야 중 선택 가능해요.</li>
            <li>잘못된 응답에는 자동 답변이 안될 수 있어요.</li>
            <li>간혹, 녹음 버튼이 활성화 안될 경우 새로 고침을 해주세요.</li>
          </ol>
          
        </div>
      </div>
    </div>
    <div class="wrap">
      <!-- Header -->
      <div id="chatHeader">
        <span>@ 2021. WAW from NAVER CLOVA Chabot</span>
        <!-- <button id="btnClose">X</button> -->

      </div>
    
      <!-- 채팅 내용 출력 박스 -->
      <div id="chatBox"></div>
      
      <!--  질문 입력 폼 -->
      <div class="chat_input">
        <form id="chatForm" method="post">
          <input type="text" id="message" name="message" size="30" placeholder="챗봇에게 질문해주세요. :)" autofocus>
          <input type="submit" id="btnSubmit" value="전송">
        </form>
      </div> 
      
      <br>
      
      <div class="voice">
      📢 음성으로 채팅해요 
      <button id="record">소리 녹음</button>
      <button id="stop">소리 전송</button>
      <div id="sound-clips"></div>
      <div>
        <audio preload="auto" controls></audio>
      </div>
	    </div>  
      
      <!-- <div>
        <audio preload="auto" controls></audio>
      </div> -->
      <br><br>
    </div>
    <div class="sub_wrap">
    </div>
    <c:choose>
	<c:when test="${empty userId}">
		<div class="user_login" style="	 font-family: 'Nanum Gothic';color: #fff;
									    position: absolute;
									    bottom: 20%;
									    left: 0px;
									    width: 300px;
									    height: 100px;
									    margin-left: 2%;
									    background-color: #0d2230;
									    text-align: center;
									    padding: 20px;;">
									    🤗 서비스 이용을 위해 <a href="/waw" style="color:red;">로그인</a> 해주세요 <br><br><span style="padding-top:10px;color: red;font-size:40px;font-weight: bolder;">👫 이용 불가능<span></div>
	</c:when>
	<c:otherwise>
	<div class="user_login" style="    font-family: 'Nanum Gothic'; color: #fff;
									    position: absolute;
									    bottom: 20%;
									    left: 0px;
									    width: 300px;
									    height: 100px;
									    margin-left: 2%;
									    background-color: #0d2230;
									    text-align: center;
									    padding: 20px;">
									    🤗 ${userId}님  현재 로그인 상태입니다. <br><a href="/waw/member/logout.do" style="color:red;">로그아웃 및 나가기</a><br><span style="padding-top:10px;color: #2ed7be;font-size:40px;font-weight: bolder;">👫 이용 가능<span></div>
	</c:otherwise>
</c:choose>
  </div>
</body>
</html>