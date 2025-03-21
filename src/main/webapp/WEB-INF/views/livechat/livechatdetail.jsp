<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%  // 세션 체크 추가 부분 시작
    HttpSession session1 = request.getSession(false); // 기존 세션 가져오기
    String userId = null;

    if (session1 != null) {
        userId = (String) session1.getAttribute("userId"); // 세션에 저장된 userId 값
    }

    if (userId == null) {
        response.sendRedirect("/login"); // 세션 없거나 만료 시 로그인 페이지로 이동
        return;
    }
%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/static/css/livechat/livechatdetail.css">
</head>
<body>

<!-- 전체 컨테이너 -->
<div class="container">
    <!-- 사이드바 -->
    <div class="left-container">
        <aside class="sidebar">
            <nav class="sidebar-menu">
                <button class="sidebar-btn"><img src="/static/imgsource/home.png" alt="홈"></button>
                <button class="sidebar-btn"><img src="/static/imgsource/calandar.png" alt="목록"></button>
                <button class="sidebar-btn"><img src="/static/imgsource/pencil.png" alt="채팅"></button>
                <button class="sidebar-btn"><img src="/static/imgsource/chat.png" alt="공유"></button>
                <button class="sidebar-btn"><img src="/static/imgsource/settingss.png" alt="설정"></button>
                <div class="bbiyak"><img src="/static/imgsource/bbiyak.png"></div>
            </nav>
        </aside>
    </div>

    <!-- 우측 컨텐츠 -->
    <div class="right-container">
        <header class="header-bar">
            <div class="brand-title"><img src="/static/imgsource/logo.png" alt="KOYOI 로고"></div>
            <div class="header-icons">
                <img class="myprofile-img" src="/static/imgsource/testprofile.png" alt="프로필">
            </div>
        </header>
        <!--나중에 유저 생기면 userid는 userid로 교체-->
        <main class="content">
            <div class="chat-container"
                 data-session-id="${counseling.session_id}"
                 data-counseling-id="${counseling.counseling_id}"
                 data-category="${counseling.category}"
                 data-counseling-date="${counseling.counseling_date}"
                 data-counseling-time="${counseling.counseling_time}"
                 data-user-id="user5"

                 data-user-type="USER"
                 data-is-completed="${isCompleted}">

                <div class="chat-box" id="chatBox">
                    <c:choose>
                        <c:when test="${not empty chatLogs}">
                            <c:forEach var="chat" items="${chatLogs}">
                                <div class="chat-message ${chat.user_type eq 'USER' ? 'user-msg' : 'counselor-msg'}">
                                    <strong>${chat.sender}:</strong> ${chat.message}
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="no-messages">대화 내용이 없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>


            <c:if test="${counseling.status ne '완료'}">
            <button id="enterButton" class="enter-chat-btn">상담 시작하기</button>
            <div class="chat-input">
                <input type="text" id="chatInput" placeholder="메시지를 입력하세요">
                <button onclick="sendMessage()">전송</button>
            </div>
            </c:if>
            <button id="exitButton" class="end-chat-btn"
                    onclick="${counseling.status eq '완료' ? 'goBack()' : 'confirmExit()'}">
                ${counseling.status eq '완료' ? '돌아가기' : '나가기'}
            </button>

    </div>
    </main>
</div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="/static/js/livechat/livechatdetail.js"></script>

</body>
</html>