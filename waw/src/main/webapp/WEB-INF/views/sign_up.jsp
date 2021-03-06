<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원 가입 페이지</title>
  <link rel="stylesheet" href="resources/css/sign_up.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic:wght@700&display=swap" rel="stylesheet">
</head>
<body>
  <div class="sign-up">
    <div class="main-body">
      <div class="login_container">
        <div class="form_container">
            <form name="login_form" action="${contextPath}/member/addMember.do" method="post">
                <div class="form_title_div">
                    <p class="form_title_p">WAW 회원 가입창</p>
                </div>
                <div>
                    <div class="form_text_alert_padding">
                        <div id="alert_username" class="form_text_alert"></div>
                    </div>
                </div>
                <div>
                    <div>
                        <input type="text" name="name" placeholder="이름" class="form_input"/>
                    </div>
                    <div class="form_text_alert_padding">
                        <div id="alert_email" class="form_text_alert"></div>
                    </div>
                </div>
                <div>
                    <div>
                        <input type="text" name="id" placeholder="이메일" class="form_input"/>
                    </div>
                    <div class="form_text_alert_padding">
                        <div id="alert_email" class="form_text_alert"></div>
                    </div>
                </div>
                <div>
                    <div>
                        <input type="password" name="pwd" placeholder="비밀번호" class="form_input" />
                    </div>
                    <div class="form_text_alert_padding">
                        <div id="alert_password" class="form_text_alert"></div>
                    </div>
                </div>
                <div>
                </div>
                <div style="height: 10px;"></div>
                <div>
                    <button type="submit" class="form_submit_button">가입</button>
                </div>
            </form>
        </div>
    </div>
    <div class="sign-in">
      <div class="desc">
        계정이 있으신가요? &nbsp;
        <a href="/waw">로그인</a>
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