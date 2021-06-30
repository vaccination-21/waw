<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="resources/css/room.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@700&display=swap" rel="stylesheet">
  <title>취미 분야 채팅방</title>
</head>
<body>
     	<div class="user_login" style="	color: #fff;
									    position: absolute;
									    bottom: 20%;
									    left: 0px;
									    width: 300px;
									    height: 100px;
									    margin-left: 2%;
									    background-color: #0d2230;
									    text-align: center;
									    padding: 20px;">
									    🤗 ${userId}님  현재 로그인 상태입니다.<br><br><span style="color: #2ed7be;font-size:40px;font-weight: bolder;">👫 이용 가능<span></div>
  <div class="main_intro">
    <div class="title">
      <div class="main_title">
         취미 분야 <br> 다같이 소통 해요!
      </div>
      <div class="sub_title">
        다른 분야로 이동하고 싶으면 챗봇을 이용해주세요 :) <br><br>
        🤖 <a href="chatbot">챗봇으로 이동하기</a>
      </div>
    </div>
    <div class="img">
      <br>
       👨🏼‍🤝‍👨🏻
    </div>
  </div>
  <div class="middle">
    <div class="middle_room">
      <div class="room first">
        <div class="title">
          <a href="chat.do">채팅방 1</a>
        </div>
      </div>
      <div class="room second">
        <div class="title">
          <a href="chat.do">채팅방 2</a>
       </div>
      </div>
      <div class="room thrid">
        <div class="title">
          <a href="chat.do">채팅방 3</a>
       </div>
      </div>
    </div>
  </div>
  <footer>
    <div class="team-intro">
      © 2021 WAW 팀 | 맹동현, 이승준, 장현호, 최민석
    </div>
  </footer>
</body>
</html>