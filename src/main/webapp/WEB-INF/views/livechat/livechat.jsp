<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Inknut+Antiqua&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Sawarabi+Maru&family=M+PLUS+Rounded+1c:wght@100;300;400;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="/static/css/livechat/livechat.css">
    <script src="/static/js/livechat.js"></script>
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
                    <!--foreach로 정보구현-->
                    <div> LIVE CHAT </div>
                    <div class="livechat_info">
                        <div class="livechat_list"> 상담하고 싶은 일정을 선택해주세요. </div>
                        <div class="livechat_list"> 해당 일자에 가장 코요이한 시간을 선택해주세요. </div>
                        <div class="livechat_list"> 상담하고 싶은 분야를 선택해주세요. </div>
                        <div class="livechat_list"> 해당 문의를 조합해 적합한 상담사님을 배정해드렸어요. </div>
                    </div>
                </div>

