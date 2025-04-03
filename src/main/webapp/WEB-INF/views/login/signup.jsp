<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<%--<html lang="ko">--%>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>KOYOI - 会員登録</title>
    <!-- CSS 연결-->
    <link rel="stylesheet" href="/static/css/login/signup.css">
    <!-- Swiper CSS Lib -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">

</head>
<body>

<!-- 전체 컨테이너 -->
<div class="container">

    <header class="header-bar">
        <div class="header-logo-center">
            <img src="/static/imgsource/layout/koyoi_name.png" alt="KOYOI 로고" class="header-logo">
        </div>
    </header>

    <!-- 메인 콘텐츠 -->
    <main class="content">
        <div class="signup-wrapper">

            <!-- 왼쪽 슬라이드 -->
            <div class="signup-left">
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

            <!-- 오른쪽 회원가입 폼 -->
            <div class="signup-right">
                <div class="title">会員登録</div>
                <p class="subtitle">こよい、あなたをお待ちしていました</p>

                <form action="/signup" method="post" enctype="multipart/form-data" class="signup-form">

                    <!-- ID -->
                    <div class="form-group">
                        <label for="user_id">ユーザー名</label>
                        <div class="check-wrapper">
                            <input type="text" id="user_id" name="user_id" placeholder="ユーザー名を入力" required>
                            <button type="button" id="checkIdBtn" class="check-btn small">チェック</button>
                        </div>
                        <div id="id-error" class="error-message"></div>
                    </div>

                    <!-- PW -->
                    <label for="user_pw">パスワード</label>
                    <input type="password" id="user_pw" name="user_pw" placeholder="パスワードを入力" required>

                    <label for="user_pw_confirm">パスワード再入力</label>
                    <input type="password" id="user_pw_confirm" name="user_pw_confirm"
                           placeholder="パスワードを再入力" required>
                    <div id="pw-error" class="error-message"></div>

                    <!-- User Type -->
                    <div class="form-group">
                        <label>ユーザータイプ</label>
                        <div class="user-type-selector">
                            <button type="button" class="user-type-btn" data-type="1">ユーザー</button>
                            <button type="button" class="user-type-btn" data-type="2">カウンセラー</button>
                        </div>
                        <!-- 실제 전송할 값 -->
                        <input type="hidden" name="user_type" id="user_type" value="" required>
                        <div id="user-type-error" class="error-message"></div>
                    </div>

                    <!-- Name -->
                    <div class="form-group">
                        <label for="user_name">お名前</label>
                        <input type="text" id="user_name" name="user_name" placeholder="お名前を入力" required>
                        <div id="name-error" class="error-message"></div>
                    </div>

                    <!-- Nickname -->
                    <div class="form-group">
                        <label for="user_nickname">ニックネーム</label>
                        <div class="check-wrapper">
                            <input type="text" id="user_nickname" name="user_nickname" placeholder="ニックネームを入力" required>
                            <button type="button" id="checkNicknameBtn" class="check-btn small">チェック</button>
                        </div>
                        <div id="nickname-error" class="error-message"></div>
                    </div>

                    <!-- Email -->
                    <div class="form-group">
                        <label for="user_email">メールアドレス</label>
                        <div class="check-wrapper">
                            <input type="email" id="user_email" name="user_email" placeholder="メールアドレスを入力" required>
                            <button type="button" id="checkEmailBtn" class="check-btn small">チェック</button>
                        </div>
                        <div id="email-error" class="error-message"></div>
                    </div>


                    <!-- Profile -->
                    <div class="form-group">
                        <label for="user_img">プロフィール画像</label>
                        <div class="file-upload-wrapper">
                            <input type="file" id="user_img" name="user_img" accept="image/*">
                            <!-- 썸네일 미리보기 -->
                            <div class="img-preview">
                                <img id="img-preview" src="#" alt="Image Preview" style="display: none;" />
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="signup-btn">会員登録</button>

                    <div class="login-option">
                        <p>アカウントをお持ちの方はこちら<a href="/login">ログイン</a></p>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <!-- 파도 영역 -->
    <div class="wave-container"></div>
</div>

<!-- Swiper JS -->
<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
<!-- 아이디 중복체크 & 비밀번호 일치 확인 JS -->
<script src="/static/js/login/signup.js"></script>

</body>
</html>
