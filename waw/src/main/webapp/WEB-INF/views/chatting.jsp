<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"
	integrity="sha512-hsqWiVBsPC5Hz9/hy5uQX6W6rEtBjtI8vyOAR4LAFpZAbQjJ43uIdmKsA7baQjM318sf8BBqrMkcWsfSsaWCNg=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>
	
	음성 메시지 :
	<button id="record">녹음</button>
	<button id="stop">정지</button>
	<div id="sound-clips"></div>
	<div>
		<audio preload="auto" controls></audio>
	</div>
	<form id="chatForm" method="post">
	<input type="text" id="message" name="message"/>
	<input type="button" id="sendBtn" value="submit" />
	</form>
	
	<div id="messageArea"></div>
	
</body>


<script type="text/javascript">

$("#sendBtn").click(function() {
	sendMessage();
	$('#message').val('')
});

let sock = new SockJS("<c:url value = "/echo"/>");
sock.onmessage = onMessage;
sock.onclose = onClose;
// 메시지 전송
function sendMessage() {
	//alert($("#message").val());
	sock.send($("#message").val());
}
// 서버로부터 메시지를 받았을 때
function onMessage(msg) {
	var data = msg.data;
	$("#messageArea").append(data + "<br/>");
	callAjaxTTS(data);
}
// 서버와 연결을 끊었을 때
function onClose(evt) {
	$("#messageArea").append("연결 끊김");

}
function callAjaxTTS(result){
	$.ajax({
		type:"post",
		//dataType:'application/json;UTF-8',/*추가*/
		url:"chatbotTTS",
		data:{message:result},
		success:function(result){				
			$('audio').prop("c", '/ai/' + result)[0].play();
			//$('audio').hide();
		},
		error:function(e){
			alert("에러 발생 : " + e);
		}			
	});
	
}

$(function(){
	// 웰컴 메시지 받기 위해서 message 란에 입력 받기 전에
	//빈 값으로 서버에 전송하고 웰컴 메시지 받음
	callAjax(); // message 값 없이 서버로 전송
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
						a.click(); // 다운로드 폴더에 저장하도록 클릭 이벤트 발생		
						
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
	
	
	
	///////////////////////////////////////////////////////////////
	
	/* 서버에 업로드 */
	function fileUpload(blob, clipName){
		// 파일 업로드 부분 추가
		var formData = new FormData();
		formData.append('uploadFile', blob, clipName+".mp3");
		
		$.ajax({
			type:"post",
			url:"clovaSTT2",
			//dataType:'application/json;UTF-8',/*추가*/
			data: formData, // 폼 데이터 전송
			processData:false, //필수
			contentType:false, //필수
			success:function(result){
				/* chatBox에 보낸 메시지 추가 (동적 요소 추가) */ /* 넌 누구니? */
				//$('#messageArea').append('<div class="msgBox send"><span>' +
				//							result + '</span></div><br>');	
				sock.send(result);
				//챗봇에게 전달
				$('#message').val(result);	
				callAjax();		
				$('#message').val('');
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
			$('#messageArea').append('<div class="msgBox send"><span>' +
											$('#message').val() + '</span></div><br>');		
		}
		
		callAjax();
		/* 입력란 비우기 */
		$('#message').val('');
		
	}); //submit 끝
	
	///////////////////////////////////////////////////
	// 이미지/멀티링크 답변 포함된 답변 처리
		
	function callAjax(){
		$.ajax({
			type:"post",
			//dataType:'application/json;UTF-8',/*추가*/
			url:"chatbotCall",
			data:{message:$('#message').val()},
			success:function(result){	  //JSON  형식 그대로 받음
				result = JSON.parse(result);
				//alert(result);
				//console.log(result);
				var bubbles = result.bubbles;
				//alert(bubbles);
				for(var b in bubbles){
					//alert(bubbles[b]);
					console.log([b]);
					if(bubbles[b].type == 'text'){ //기본 답변인 경우
						/*chatBox에 받은 메시지 출력 (챗봇의 답변))*/
						$('#messageArea').append('<div class="msgBox receive"><br>챗봇<br><span>' +
											bubbles[b].data.description + '</span></div><br><br>');	
						//챗봇으로 부터 받은 텍스트 답변을 음성으로 변환하기 위해  TTS  호출
						callAjaxTTS(bubbles[b].data.description);		
						//alert(bubbles+", "+bubbles[b].data.description);			
					} else if(bubbles[b].type == 'template'){  //이미지 답변 또는 멀티링크 답변인 경우
						if(bubbles[b].data.cover.type == 'image'){ //이미지인 경우
							// 이미지 출력
							$('#messageArea').append("<img src='" +  bubbles[b].data.cover.data.imageUrl +  "'  alt=' 이미지 없음' >");	
							
							// 이미지만 있는 경우 / 이미지 + 텍스트 경우
							if(bubbles[b].data.contentTable == null){   //이미지만 있는 경우 url  추출
								$('#messageArea').append("<a href='" + bubbles[b].data.cover.data.url + "' target='_blank'> " +
								bubbles[b].data.cover.data.url + "</a><br>" );
								
							} else{  //이미지+ 텍스트인 경우 텍스트와  url 추출
								//텍스트만 추출하고 멀티링크와 공통되는 contentTable은 아래에서 다중 for문 사용해서  url 추출
								$('#messageArea').append("<p>" + bubbles[b].data.cover.data.description + "</p>");	
								//챗봇으로 부터 받은 텍스트 답변을 음성으로 변환하기 위해  TTS  호출
								callAjaxTTS(bubbles[b].data.cover.data.description);
							}
							
						} else if(bubbles[b].data.cover.type == 'text'){ //멀터링크인 경우
							$('#messageArea').append("<p>" + bubbles[b].data.cover.data.description + "</p>");	
								//챗봇으로 부터 받은 텍스트 답변을 음성으로 변환하기 위해  TTS  호출
								callAjaxTTS(bubbles[b].data.cover.data.description);
						}
						
						//이미지/멀티링크 답변 공통 (contentTable  포함)
						for(var ct in bubbles[b].data.contentTable){
							var ct_data = bubbles[b].data.contentTable[ct];
							for(var ct_d in ct_data){
								$('#messageArea').append("<a href='" + ct_data[ct_d].data.data.action.data.url + "' target='_blank'> " +
								ct_data[ct_d].data.data.action.data.url + "</a><br>" );
							}
						}						
					}
					
				} // bubbles for 문 종료
											
				/* 스크롤해서 올리기 */
				$('#messageArea').scrollTop($('#messageArea').prop("scrollHeight"));
				
				
			},
			error:function(e){
				alert("에러 발생 : " + e);
			}			
		});
	}
	
	///////////////////////////////////////////////////
	
	function callAjaxTTS(result){
		$.ajax({
			type:"post",
			//dataType:'application/json;UTF-8',/*추가*/
			url:"chatbotTTS",
			data:{message:result},
			success:function(result){				
				$('audio').prop("c", '/ai/' + result)[0].play();
				//$('audio').hide();
			},
			error:function(e){
				alert("에러 발생 : " + e);
			}			
		});
		
	}
	
}); // $(function()  끝
	
</script>
</html>