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
	  <link rel="stylesheet" href="resources/css/chatbot.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@700&display=swap" rel="stylesheet">
   <script>
   	alert("환연합니다. :) admin 님") 
   </script>

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
        <span>@ 2021. WAW from NAVER CLOVA Cabot</span>
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
      
      음성 메시지 : <button id="record">녹음</button> 
      <button id="stop">정지</button>
      <div id="sound-clips"></div>		
      
      <!-- <div>
        <audio preload="auto" controls></audio>
      </div> -->
      <br><br>
    </div>
    <div class="sub_wrap">
    </div>
  </div>
</body>
</html>