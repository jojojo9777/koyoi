<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Inknut+Antiqua&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="/static/css/index2.css">
</head>
<body>

<!-- 전체 컨테이너 -->
<div class="container">
    <header class="header-bar">
        <!-- 로고 & 브랜드명 -->
        <div class="logo-container">
            <img class="logo-icon" src="/static/imgsource/logo.png" alt="KOYOI 로고">
        </div>

        <!-- 우측 상단 아이콘 -->
        <div class="header-icons">
            <button class="header-btn">
                <img src="/static/imgsource/chat.png" alt="채팅">
            </button>
            <button class="header-btn">
                <img src="/static/imgsource/settingss.png" alt="설정">
            </button>
            <button class="header-btn">
                <img src="/static/imgsource/logout.png" alt="로그아웃">
            </button>
            <img class="profile-img" src="/static/imgsource/testprofile.png" alt="프로필">
        </div>
    </header>

    <!-- 메인 콘텐츠 영역 -->
    <main class="content">
        <jsp:include page="${contentPage}" />
    </main>


</div>

</body>
</html>
