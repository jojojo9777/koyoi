<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Inknut+Antiqua&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Sawarabi+Maru&family=M+PLUS+Rounded+1c:wght@100;300;400;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="/static/css/livechat/livechatreservation.css">
</head>
<body>

<div class="container">

    <div class="left-container">
        <aside class="sidebar">
            <nav class="sidebar-menu">
                <button class="sidebar-btn">
                    <img src="/static/imgsource/home.png" alt="홈">
                </button>
                <button class="sidebar-btn"><img src="/static/imgsource/calandar.png" alt="목록"></button>
                <button class="sidebar-btn"><img src="/static/imgsource/pencil.png" alt="채팅"></button>
                <button class="sidebar-btn"><img src="/static/imgsource/chat.png" alt="공유"></button>
                <button class="sidebar-btn"><img src="/static/imgsource/settingss.png" alt="설정"></button>
                <div class="bbiyak">
                    <img src="/static/imgsource/bbiyak.png">
                </div>
            </nav>
        </aside>
    </div>

    <div class="right-container">
        <header class="header-bar">
            <div class="brand-title">
                <img src="/static/imgsource/logo.png" alt="KOYOI 로고">
            </div>

            <div class="header-icons">
                <img class="myprofile-img" src="/static/imgsource/testprofile.png" alt="프로필">
            </div>
        </header>

        <main class="content">

            <div class="top-section">
                <div class="livechat_table">
                    <div> LIVE CHAT </div>
                    <div class="livechat_info">

                        <div id="livechat_step1" class="show">
                            <div class="livechat_list"> 상담하고 싶은 일정을 선택해주세요. </div>
                            <input type="date" id="livechat_reserve_date" onchange="showNext('step2')">
                        </div>

                        <div id="step2">
                            <div class="livechat_list"> 해당 일자에 가장 코요이한 시간을 선택해주세요. </div>
                            <select id="livechat_reserve_time" onchange="showNext('step3')">
                                <option value="">시간 선택</option>
                                <option value="10:00">10:00</option>
                                <option value="11:00">11:00</option>
                                <option value="12:00">12:00</option>
                                <option value="13:00">13:00</option>
                                <option value="14:00">14:00</option>
                                <option value="15:00">15:00</option>
                                <option value="16:00">16:00</option>
                                <option value="17:00">17:00</option>
                                <option value="18:00">18:00</option>
                                <option value="19:00">19:00</option>
                                <option value="20:00">20:00</option>
                                <option value="21:00">21:00</option>
                                <option value="22:00">22:00</option>
                            </select>


                        </div>


                        <div id="step3">
                            <div class="livechat_list"> 상담하고 싶은 분야를 선택해주세요. </div>
                            <select id="livechat_reserve_category" onchange="showNext('reserveSection')">
                                <option value="">카테고리 선택</option>
                                <option value="건강멘탈"> 건강/멘탈</option>
                                <option value="학업진로"> 학업/진로 </option>
                                <option value="인간관계"> 인간관계 </option>
                            </select>
                        </div>

                        <div id="reserveSection">
                            <button id="livechat_reserve_btn"> 예약하기 </button>
                        </div>

                        <div id="conformation">
                            <div class="livechat_list"> 해당 문의를 조합해 적합한 상담사님을 배정해드렸어요. </div>
                            <button id="livechat_exit_btn" onclick="location.href='/usermypage'"> 나가기 </button>
                        </div>

                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="/static/js/livechat/livechatreservation.js"></script>

</body>
</html>