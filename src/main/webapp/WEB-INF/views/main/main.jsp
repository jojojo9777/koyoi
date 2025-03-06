<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Title</title>
    <link href="https://fonts.googleapis.com/css2?family=Inknut+Antiqua&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/static/css/main.css">
  <%--  <script src="/resources/js/product.js"></script>--%>
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
    <main class="main-container">
        <!-- 명언 -->
        <div class="quotes-container">
            <div class="quotes-content">"Life is like riding a bicycle. To keep your balance you must keep moving" - Albert Einstein</div>
        </div>

        <!-- 달력 + 무드 통계 -->
        <div class="content-wrapper">
            <!-- 왼쪽 영역: 달력 + 챗봇 -->
            <div class="left-content">
                <div class="calendar-container"> 달력 </div>
                <div class="chat-connect"> 챗봇, 라이브챗 연결</div>
            </div>

            <!-- 오른쪽 영역: 무드 그래프 + 체크리스트 -->
            <div class="right-content">
                <div class="mood-graph"> 무드 통계 </div>
                <div class="checklists">
                    <div class="checklist"> 체크리스트1 </div>
                    <div class="checklist"> 체크리스트2 </div>
                </div>
            </div>
        </div>
    </main>


</body>
</html>