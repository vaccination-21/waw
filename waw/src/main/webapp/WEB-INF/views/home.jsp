<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<script src="<c:url value='resources/js/home.js'/>"></script>
  <link rel="stylesheet" href="resources/css/home.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@700&display=swap" rel="stylesheet">
  <title>메인 로그인 페이지</title>
	<c:if test='${not empty message }'>
	<script>
	window.onload=function()
	{
	  result();
	}
	
	function result(){
		alert("아이디나  비밀번호가 틀립니다. 다시 로그인해주세요");
	}
	</script>
	</c:if>
</head>
<body>
<c:choose>
	<c:when test="${not empty msg}">
		<div class="user_login" style="	font-family: 'Nanum Gothic';color: #fff;
									    position: absolute;
									    bottom: 20%;
									    left: 0px;
									    width: 300px;
									    height: 100px;
									    margin-left: 2%;
									    background-color: #0d2230;
									    text-align: center;
									    padding: 20px;">
									    🤗 로그인 정보를 확인 해주세요 <br><br><span style="padding-top:10px;color: red;font-size:40px;font-weight: bolder;">👫 이용 불가능<span></div>
	</c:when>
	<c:otherwise>
	<div class="user_login" style="	font-family: 'Nanum Gothic'; color: #fff;
									    position: absolute;
									    bottom: 20%;
									    left: 0px;
									    width: 300px;
									    height: 100px;
									    margin-left: 2%;
									    background-color: #0d2230;
									    text-align: center;
									    padding: 20px;">
									    🤗 로그인 해주세요. <br><br><span style="padding-top:10px;color: yellow;font-size:40px;font-weight: bolder;">👫 로그인 필요<span></div>
	</c:otherwise>
</c:choose>
  <div class="main-body">
    <div class="left-body">
      <div class="intro-name">
        👨🏼‍🤝‍👨🏻 WAW  
        <div class="intro-name-desc">
          We Are the World!!, Where Are We now!!
        </div>
        <div class="intro-project-desc">
        </div>
      </div>   
    </div>
    <div class="right-body">
      <div class="login_container">
        <div class="form_container">
            <form action="${contextPath}/member/login.do" method="post">
                <div class="form_title_div">
                    <p class="form_title_p">WAW</p>
                </div>
                <div>
                    <div class="form_text_alert_padding">
                        <div id="alert_username" class="form_text_alert"></div>
                    </div>
                </div>
                <div>
                    <div>
                        <input type="text" name="name" placeholder="이름" class="form_input" value="admin"/>
                    </div>
                    <div class="form_text_alert_padding">
                        <div id="alert_email" class="form_text_alert"></div>
                    </div>
                </div>
                <div>
                    <div>
                        <input type="password" name="pwd" placeholder="비밀번호" class="form_input" value="1234" />
                    </div>
                    <div class="form_text_alert_padding">
                        <div id="alert_password" class="form_text_alert"></div>
                    </div>
                </div>
                <div>
                </div>
                <div style="height: 10px;"></div>
                <div>
                    <button type="submit" class="form_submit_button">로그인</button>
                </div>
            </form>
        </div>
    </div>
    <div class="sign-up">
      <div class="desc">
        계정이 없으신가요? &nbsp;
        <a href="sign_up">가입하기</a>
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
