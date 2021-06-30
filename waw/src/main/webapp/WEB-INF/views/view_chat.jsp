<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>웹소켓 채팅</title>
<link rel="stylesheet" href="resources/css/view_chat.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="view_chat.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.js"></script>
<script type="text/javascript">
		var webSocket = {
			init: function(param) {
				this._url = param.url;
				this._initSocket();
			},
			sendChat: function() {
				this._sendMessage('${param.bang_id}', 'CMD_MSG_SEND', $('#message').val(), '${userId}');
				$('#message').val('');
				//alert("hi");
			},
			sendEnter: function() {
				this._sendMessage('${param.bang_id}', 'CMD_ENTER', $('#message').val(), '${userId}');
				$('#message').val('');
			},
			receiveMessage: function(msgData) {

				// 정의된 CMD 코드에 따라서 분기 처리
				if(msgData.cmd == 'CMD_MSG_SEND') {					
					$('#divChatData').append('<div>' + msgData.msg + '</div>');
				}
				// 입장
				else if(msgData.cmd == 'CMD_ENTER') {
					$('#divChatData').append('<div>' + msgData.msg + '</div>');
				}
				// 퇴장
				else if(msgData.cmd == 'CMD_EXIT') {					
					$('#divChatData').append('<div>' + msgData.msg + '</div>');
				}
			},
			closeMessage: function(str) {
				$('#divChatData').append('<div>' + '연결 끊김 : ' + str + '</div>');
			},
			disconnect: function() {
				this._socket.close();
			},
			_initSocket: function() {
				this._socket = new SockJS(this._url);
				this._socket.onopen = function(evt) {
					webSocket.sendEnter();
				};
				this._socket.onmessage = function(evt) {
					webSocket.receiveMessage(JSON.parse(evt.data));
				};
				this._socket.onclose = function(evt) {
					webSocket.closeMessage(JSON.parse(evt.data));
				}
			},
			_sendMessage: function(bang_id, cmd, msg, userId) {
				var msgData = {
						bang_id : bang_id,
						cmd : cmd,
						msg : msg,
						user : userId
				};
				var jsonData = JSON.stringify(msgData);
				this._socket.send(jsonData);
			}
		};
		
		

		$("#btnSend").click(function() {
			sendMessage();
			$('#message').val('')
		});
		
	
	      $(window).on('load', function () {
				webSocket.init({ url: '<c:url value="/chat" />' });	
			});		
		
		
		
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
						webSocket.sendChat();
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
</head>
<body>
	 <div class="main">
    <div class="title">
      👨🏼‍🤝‍👨🏻 WAW 소통해요 :) <br>
    </div>
    <div
		  style="width: 800px; height: 500px; padding: 10px; height: 75vh; border: solid 1px #e1e3e9;">
      <div id="divChatData" style="overflow: scroll; height: 100%;"></div>
    </div>
<!--     <div style="width: 100%;"> -->
      <div id="chatForm">
        <input type="text" id="message" size="110"
          onkeypress="if(event.keyCode==13){webSocket.sendChat();}" /> <input
          type="button" id="btnSend" value="채팅 전송"
          onclick="webSocket.sendChat()" />
      </div>
    </div>
    <div class="voice">
      📢 음성으로 채팅해요 
      <button id="record">소리 녹음</button>
      <button id="stop">소리 전송</button>
      <div id="sound-clips"></div>
      <div>
        <audio preload="auto" controls></audio>
      </div>
    </div>  
  </div>
<c:choose>
	<c:when test="${empty userId}">
		<div class="user_login" style="	    font-family: 'Nanum Gothic';
												    color: #fff;
												    position: absolute;
												    top: 5%;
												    right: 0px;
												    width: 300px;
												    height: 100px;
												    margin-right: 2%;
												    background-color: #0d2230;
												    text-align: center;
												    padding: 20px;">
									    🤗 서비스 이용을 위해 <a href="/waw" style="color:red;">로그인</a> 해주세요 <br><br><span style="padding-top:10px;color: red;font-size:40px;font-weight: bolder;">👫 이용 불가능<span></div>
	</c:when>
	<c:otherwise>
	<div class="user_login" style="    font-family: 'Nanum Gothic';
									    color: #fff;
									    position: absolute;
									    top: 5%;
									    right: 0px;
									    width: 300px;
									    height: 100px;
									    margin-right: 2%;
									    background-color: #0d2230;
									    text-align: center;
									    padding: 20px;">
									    🤗 ${userId}님  현재 로그인 상태입니다. <br><a href="/waw/member/logout.do" style="color:red;">로그아웃 및 나가기</a><br><span style="padding-top:10px;color: #2ed7be;font-size:40px;font-weight: bolder;">👫 이용 가능<span></div>
	</c:otherwise>
</c:choose>

</body>
</html>