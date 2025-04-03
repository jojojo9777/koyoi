<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<%--<html lang="ko">--%>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>KOYOI - ログイン</title>
    <!-- CSS 연결-->
    <link rel="stylesheet" href="/static/css/login/login.css">
    <!-- js 연결 -->
    <script src="/static/js/login/login.js"></script>
    <!-- Swiper CSS Lib -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
</head>
<body>

<!-- 전체 컨테이너 -->
<!-- 실패 여부를 data 속성으로 전달 -->
<div class="container" data-login-failed="${loginFailed}">

    <header class="header-bar">
        <div class="header-logo-center">
            <img src="/static/imgsource/layout/koyoi_name.png" alt="KOYOI 로고" class="header-logo">
        </div>
        <img class="innercontentmoon" src="/static/imgsource/layout/koyoi_moon.png">

    </header>

    <!-- 메인 콘텐츠 영역 -->
    <main class="content">

        <div class="login-wrapper">

            <!-- 왼쪽 슬라이드 -->
            <div class="login-left">
                <div class="swiper mySwiper">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide"><img src="/static/imgsource/login/mainbanner4.jpg" alt="슬라이드1"/></div>
                        <div class="swiper-slide"><img src="/static/imgsource/login/mainbanner5.jpg" alt="슬라이드2"/></div>
                        <div class="swiper-slide"><img src="/static/imgsource/login/mainbanner06.png" alt="슬라이드3"/></div>
                        <div class="swiper-slide"><img src="/static/imgsource/login/mainbanner2.jpg" alt="슬라이드4"/></div>
                    </div>

                    <!-- 페이지네이션 -->
                    <div class="swiper-pagination"></div>

                    <!-- 이전/다음 버튼 -->
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>
                </div>
            </div>

            <!-- 오른쪽 로그인 -->
            <div class="login-right">
                <div class="title">KOYOI</div>
                <p class="subtitle"> ログイン </p>
                <p class="login-cont">こよいもお会いできて嬉しいです</p>

                <form action="/login" method="post" class="login-form" onsubmit="return validateForm()">
                    <%--                    <form action="/login" method="post" class="login-form">--%>
                    <label for="user_id">ユーザー名</label>
                    <input type="text" id="user_id" name="user_id" placeholder="ユーザー名を入力">
                    <span id="id-error" class="error-message"></span>

                    <label for="user_pw">パスワード</label>
                    <input type="password" id="user_pw" name="user_pw" placeholder="パスワードを入力">
                    <span id="pw-error" class="error-message"></span>

                    <button type="submit" class="login-btn">ログイン</button>

                    <div class="signup-option">
                        <p>アカウントをお持ちでない場合はこちら <a href="/signup">会員登録</a></p>
                    </div>
                </form>

            </div>

        </div>

    </main>

    <!-- 파도 영역 -->
    <div class="wave-container"></div>
</div>

<div id="loginFailModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <p> ユーザー名またはパスワードを正しく入力してください</p>
    </div>
</div>

<!-- Swiper JS -->
<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
<!-- Login JS -->
<script src="/static/js/login/login.js"></script>

</body>
</html>
