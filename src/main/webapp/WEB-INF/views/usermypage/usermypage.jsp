<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Inknut+Antiqua&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Sawarabi+Maru&family=M+PLUS+Rounded+1c:wght@100;300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/static/css/usermypage/usermypage.css">
</head>
<body>

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

        <main class="content">
            <div class="top-section">
                <div class="profile_table">
                    <div class="profile_content">
                        <div class="profile_img">
                            <img src="/static/${user.user_img}" alt="프로필 이미지">
                        </div>
                        <div class="profile_info">
                            <div class="profile_item">
                                <img src="/static/imgsource/personicon.png" alt="">
                                <span>ID: ${user.user_id}</span>
                            </div>

                            <input type="hidden" id="hiddenUserId" value="${user.user_id}"> <!-- 🔥 여기에 추가 -->

                            <div class="profile_item">
                                <img src="/static/imgsource/lockicon.png" alt="">
                                <span> PW: ******** </span>
                            </div>
                            <div class="profile_item">
                                <img src="/static/imgsource/personicon.png" alt="">
                                <span id="nicknameDisplay">닉네임: ${user.user_nickname} </span>
                            </div>
                            <button class="profile_edit_btn" id="openPasswordCheckModal">프로필 수정하기</button>
                        </div>

                    </div>
                </div>

                <div class="chatbot_table">
                    <div class="chatbot_title">챗봇과의 대화 내역</div>
                    <div class="chatbot_info">
                        <c:if test="${not empty chats}">
                            <c:forEach var="chat" items="${chats}">
                                <div class="chatbot_list">${chat.chat_summary}</div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty chats}">
                            <div class="chatbot_list"> 챗봇 이용 내역이 없습니다. </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <div class="bottom-section">
                <div class="diary_table">
                    <div class="diary_background_img">
                        <img src="/static/imgsource/calandarback.png" alt="달력 이미지">
                    </div>
                </div>

                <!-- 상담 영역 -->
                <div class="counseling_wrapper">
                    <!-- 상담 내역 없는 경우 -->

                    <c:if test="${empty reservations}">
                        <div class="counseling_no_reservation">
                            <div class="nonreserved_counseling_table">
                                <!-- 갈색 배경 안에 텍스트 포함 -->
                                <img src="/static/imgsource/padoo2.png">

                                <div class="nonreserved_counseling_table_comment">
                                    <div><img style="width: 70px" src="/static/imgsource/shining5.png"></div>
                                    <p>現在、予定されている相談はありません。<br>お話ししましょうか？</p>
                                    <button class="reservation_submit_btn" onclick="location.href='/livechatreservation'">상담 예약하기</button>
                                </div>
                            </div>
                        </div>
                    </c:if>



                    <!-- 상담 내역이 있는 경우 -->
                    <c:if test="${not empty reservations}">
                        <div class="counseling_table">
                            <div class="reserved_counseling_table_comment">
                                <ul>📅 予約された相談
                                    <button class="reservation_submit_btn" onclick="location.href='/livechatreservation'">상담 예약하기</button>
                                </ul>
                            </div>

                            <div class="reservation_slider">
                                <div class="reservation_list">
                                    <c:forEach var="reservation" items="${reservations}">
                                        <div class="reserved_reservation_box">
                                            <div><strong>[상담일시] </strong></div>${reservation.counseling_date} ${reservation.counseling_time}:00
                                            <div><strong>[상담 카테고리] </strong></div>${reservation.category}
                                            <div><strong>[상담사 ID] </strong>${reservation.counselor_id}</div>
                                            <div><strong>[상담 상태] </strong>${reservation.status}</div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:if>

                </div>
            </div>
        </main>
    </div>
</div>

<!-- 🔥 여기에 모달 추가 -->
<div id="passwordCheckModal" class="modal" style="display: none;">
    <div class="modal-content">
        <p>비밀번호를 입력하세요:</p>
        <input type="password" id="passwordCheck" autocomplete="off">
        <button id="checkPasswordBtn">확인</button>
        <button class="close">닫기</button>
        <p id="passwordErrorMsg" style="display: none; color: red;">비밀번호가 틀렸습니다.</p>
    </div>
</div>
<!-- 프로필 수정 모달 -->
<div id="profileModal" class="modal" style="display: none;">
    <div class="modal-content">
        <h3>프로필 수정</h3>
        <label>아이디 </label>
        <input type="text" id="editId" readonly>
        <br>


        <label>새 비밀번호</label>
        <input type="password" id="editPw" placeholder="새 비밀번호 입력" >
        <br>

        <label>닉네임</label>
        <input type="text" id="editNickname">
        <br>

        <button id="saveProfileBtn">저장</button>
        <button class="close">닫기</button>
    </div>
</div>


</body>
<script src="/static/js/usermypage/usermypage.js"></script>
</html>