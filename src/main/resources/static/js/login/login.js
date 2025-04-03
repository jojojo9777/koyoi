document.addEventListener("DOMContentLoaded", function () {
    // Swiper 초기화
    const swiper = new Swiper(".mySwiper", {
        loop: true,
        autoplay: {
            delay: 2500,
            disableOnInteraction: false
        },
        pagination: {
            el: ".swiper-pagination",
            clickable: true
        },
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev"
        },
        effect: 'fade',
        speed: 1000
    });

    // 로그인 실패 시 모달 띄우기
    const container = document.querySelector('.container');
    const loginFailed = container.getAttribute('data-login-failed');

    if (loginFailed === 'true') {
        const modal = document.getElementById("loginFailModal");
        const closeBtn = document.querySelector(".modal .close");

        modal.style.display = "block";

        // history에서 query 지우기
        window.history.replaceState({}, document.title, window.location.pathname);

        // 시간 조정
        setTimeout(() => {
            modal.style.display = "none";
        }, 3000); // 5000ms = 5초 → 원하면 숫자 더 키워도 됨 (예: 7000 = 7초)

        closeBtn.addEventListener("click", function () {
            modal.style.display = "none";
        });

        window.addEventListener("click", function (event) {
            if (event.target === modal) {
                modal.style.display = "none";
            }
        });
    }
});



function validateForm() {
    let isValid = true;

    const userIdInput = document.getElementById("user_id");
    const userPwInput = document.getElementById("user_pw");

    const idError = document.getElementById("id-error");
    const pwError = document.getElementById("pw-error");

    // 에러 초기화
    idError.textContent = "";
    pwError.textContent = "";

    // ID 검사
    if (userIdInput.value.trim() === "") {
        idError.textContent = "ユーザー名を入力してください";
        isValid = false;
    }

    // PW 검사
    if (userPwInput.value.trim() === "") {
        pwError.textContent = "パスワードを入力してください";
        isValid = false;
    }

    return isValid; // false면 form 전송 안 됨!
}
