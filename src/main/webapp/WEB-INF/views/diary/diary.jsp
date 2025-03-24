<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link href="https://fonts.googleapis.com/css2?family=Inknut+Antiqua&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="/static/css/finalindex.css">
    <link rel="stylesheet" href="/static/css/diary/diary.css">
    <script src="/static/js/diary/diary.js" defer></script>
    <script>
        window.selectedDate = "${selectedDate}"; // 서버에서 내려준 값
        console.log("✅ 서버에서 받은 selectedDate:", selectedDate);
    </script>

</head>
<body>
<!-- 전체 컨테이너 -->
<div class="container">
    <!-- 🟠 왼쪽 컨테이너 (사이드바) -->
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

    <!-- 🟣 오른쪽 컨테이너 -->
    <div class="right-container">
        <header class="header-bar">
            <div class="brand-title"><img src="/static/imgsource/logo.png" alt="KOYOI 로고"></div>
            <div class="header-icons"><img class="profile-img" src="/static/imgsource/testprofile.png" alt="프로필"></div>
        </header>

        <!-- 📌 메인 콘텐츠 (달력 & 일기 작성) -->
        <main class="content">
            <div class="calendar-container">
                <!-- 📅 달력 -->
                <div id="calendar"></div>

                <div class="weekly-summary">
                    <div class="weekly-summary-title">이번주 감정 요약</div>
                    <ul>
                        <li><span class="emoji">😊</span> 2025-03-09 예시~~</li>
                        <li><span class="emoji">😢</span> 2025-03-10 예시~~</li>
                        <li><span class="emoji">😡</span> 2025-03-11 예시~~</li>
                        <li><span class="emoji">😆</span> 2025-03-12 예시~~</li>
                        <li><span class="emoji">😡</span> 2025-03-13 예시~~</li>
                        <li><span class="emoji">😆</span> 2025-03-14 예시~~</li>
                        <li><span class="emoji">🥰</span> 2025-03-15 예시~~</li>
                    </ul>
                </div>
            </div>

            <div class="diary-section-container">
                <div class="diary-wrapper">
                <!-- ✅ 일기 작성 뷰 -->
                <div id="diaryWriteSection" style="display: block;">
                    <!-- 날짜 -->
                    <p><strong>TODAY:</strong> <span id="diaryDate"></span></p>

                    <!-- 이모지 선택 -->
                    <div>
                        <span id="write-🙂" class="emoji-option" onclick="selectEmoji('🙂')">🙂</span>
                        <span id="write-😢" class="emoji-option" onclick="selectEmoji('😢')">😢</span>
                        <span id="write-😡" class="emoji-option" onclick="selectEmoji('😡')">😡</span>
                        <span id="write-😆" class="emoji-option" onclick="selectEmoji('😆')">😆</span>
                        <span id="write-🥰" class="emoji-option" onclick="selectEmoji('🥰')">🥰</span>
                    </div>

                    <!-- 타이틀 입력 -->
                    <input type="text" id="diaryTitle" placeholder="오늘 하루를 한 줄로 표현해 보세요!">

                    <!-- 일기 내용 입력 -->
                    <textarea id="diaryContent" placeholder="오늘 있었던 일이나 감정을 적어보세요 :)"></textarea><br>

                    <!-- 버튼 -->
                    <button id="saveBtn" onclick="saveDiary()">일기 등록하기</button>
                    <button id="updateBtn" onclick="updateDiary()" style="display: none;">일기 수정 완료</button>
                </div>

                <!-- 상세 조회 뷰 -->
                <div id="diaryViewSection" style="display: none;">
                    <!-- 날짜 -->
                    <p><strong>TODAY:</strong> <span id="viewDiaryDate"></span></p>


                    <!-- 이모지 선택 (비활성화 모드) -->
                    <div>
                        <span id="view-🙂" class="emoji-option readonly" onclick="selectEmoji('🙂')">🙂</span>
                        <span id="view-😢" class="emoji-option readonly" onclick="selectEmoji('😢')">😢</span>
                        <span id="view-😡" class="emoji-option readonly" onclick="selectEmoji('😡')">😡</span>
                        <span id="view-😆" class="emoji-option readonly" onclick="selectEmoji('😆')">😆</span>
                        <span id="view-🥰" class="emoji-option readonly" onclick="selectEmoji('🥰')">🥰</span>
                    </div>
                    <!-- 타이틀 출력 -->
                    <div id="viewDiaryTitle">오늘의 타이틀</div>

                    <!-- 일기 내용 출력 -->
                    <div id="viewDiaryContent" class="diary-content-view"></div>

                    <!-- 수정/삭제 버튼 -->
                    <button id="editBtn" class="btn-edit" onclick="switchToEditMode()">일기 수정하기</button>
                    <button id="deleteBtn" class="btn-delete" onclick="deleteDiary()">일기 삭제하기</button>
                </div>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- ✅ 오늘의 감정 점수 모달 -->
<div id="emotionScoreModal" class="modal-overlay" style="display: none;">
    <div class="modal-container">
        <h2>오늘 하루는 어땠나요?</h2>
        <p>점수를 입력해 주세요! (10점 ~ 100점)</p>
        <div class="score-slider-container">
            <input type="range" id="emotionScoreInput" min="10" max="100" value="50" step="10" oninput="updateScoreValue(this.value)">
            <div class="score-value"><span id="scoreDisplay">50</span> 점</div>
        </div>
        <div class="modal-buttons">
            <button id="confirmBtn" class="btn-confirm" onclick="saveEmotionScore()">저장하기</button>
            <button id="cancelBtn" class="btn-cancel" onclick="closeEmotionModal()">취소</button>
        </div>
    </div>
</div>
</body>
</html>
