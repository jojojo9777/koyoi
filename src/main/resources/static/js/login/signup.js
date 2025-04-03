// 전역 변수로 선언 (모든 함수에서 접근 가능)
let pwInput, pwConfirmInput, pwError;
let userImgInput, imgPreview;
let isIdChecked = false; // 중복체크 무조건 하도록

console.log("📌 스크립트 로딩 시작됨");

document.addEventListener("DOMContentLoaded", function () {
    console.log("📌 DOMContentLoaded 실행됨");

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
    console.log("✅ Swiper 초기화 완료");

    // 패스워드 인풋 초기화
    pwInput = document.getElementById("user_pw");
    pwConfirmInput = document.getElementById("user_pw_confirm");
    pwError = document.getElementById("pw-error");
    console.log("✅ 패스워드 인풋 초기화 완료");

    // 패스워드 실시간 검증 연결
    pwInput.addEventListener("input", checkPasswordMatch);
    pwConfirmInput.addEventListener("input", checkPasswordMatch);
    console.log("🔄 패스워드 검증 이벤트 바인딩 완료");

    // 중복 체크 버튼 이벤트 연결
    document.getElementById("checkIdBtn").addEventListener("click", function () {
        checkDuplicate("id", document.getElementById("user_id").value);
    });

    document.getElementById("checkEmailBtn").addEventListener("click", function () {
        checkDuplicate("email", document.getElementById("user_email").value);
    });

    document.getElementById("checkNicknameBtn").addEventListener("click", function () {
        checkDuplicate("nickname", document.getElementById("user_nickname").value);
    });

    // 입력값 변경 시 각 중복 플래그 초기화
    document.getElementById("user_id").addEventListener("input", () => isIdChecked = false);
    document.getElementById("user_email").addEventListener("input", () => isEmailChecked = false);
    document.getElementById("user_nickname").addEventListener("input", () => isNicknameChecked = false);


    // user_id 값 변경 시 중복체크 초기화
    document.getElementById("user_id").addEventListener("input", function () {
        isIdChecked = false;
        console.log("✏️ ID 입력 변경됨 → 중복 체크 플래그 초기화");
    });

    // 이미지 업로드 초기화
    userImgInput = document.getElementById("user_img");
    imgPreview = document.getElementById("img-preview");

    // 이미지 업로드 및 미리보기
    userImgInput.addEventListener("change", handleImagePreview);
    console.log("🖼️ 이미지 업로드 이벤트 연결 완료");

    // 폼 제출 시 검증
    const signupForm = document.querySelector('.signup-form');
    signupForm.addEventListener('submit', function (event) {
        console.log("📨 회원가입 폼 제출 시도됨");
        if (!validateSignupForm()) {
            event.preventDefault(); // 검증 실패 시 폼 전송 막기
            console.warn("🚫 폼 검증 실패로 제출 중단됨");
        }
    });

    // User Type 선택 버튼 로직 추가
    const userTypeButtons = document.querySelectorAll('.user-type-btn');
    const userTypeInput = document.getElementById('user_type');

    userTypeButtons.forEach(button => {
        button.addEventListener('click', function () {
            console.log("👆 User Type 버튼 클릭됨", this);

            // 기존 선택 해제
            userTypeButtons.forEach(btn => btn.classList.remove('selected'));

            // 선택한 버튼 스타일 적용
            this.classList.add('selected');

            // 선택 값 hidden input에 저장
            const selectedType = this.getAttribute('data-type');
            userTypeInput.value = selectedType;

            console.log("✅ 선택한 user_type 값:", selectedType);
        });
    });

    console.log("✅ 모든 이벤트 바인딩 완료");
});

// 중복 체크 함수 (id, name, nickname)
function checkDuplicate(type, value) {
    if (!value.trim()) {
        alert(`${type}を入力してください`);
        return;
    }

    fetch(`/check?type=${type}&value=${encodeURIComponent(value)}`)
        .then(response => response.json())
        .then(data => {
            if (data.exists) {
                alert(`既に登録されている${type} です`);
                if (type === "id") isIdChecked = false;
                if (type === "email") isEmailChecked = false;
                if (type === "nickname") isNicknameChecked = false;
            } else {
                alert(`この${type}使用可能です！`);
                if (type === "id") isIdChecked = true;
                if (type === "email") isEmailChecked = true;
                if (type === "nickname") isNicknameChecked = true;
            }
        })
        .catch(error => {
            console.error(`Error checking ${type}:`, error);
            alert(`${type}のチェックに失敗しました`);
        });
}


// 패스워드 실시간 검증 함수
function checkPasswordMatch() {
    const pw = pwInput.value.trim();
    const pwConfirm = pwConfirmInput.value.trim();

    if (!pw || !pwConfirm) {
        pwError.textContent = "";
        return;
    }

    if (pw !== pwConfirm) {
        pwError.textContent = "パスワードが一致していません";
        pwError.style.color = "red";
    } else {
        pwError.textContent = "パスワードが一致しました！";
        pwError.style.color = "green";
    }
}


// 이미지 업로드 및 미리보기 함수
function handleImagePreview(event) {
    const file = event.target.files[0];

    if (!file) {
        imgPreview.src = "#";
        imgPreview.style.display = "none";
        return;
    }

    // 파일 크기 제한 (5MB)
    if (file.size > 5 * 1024 * 1024) {
        alert("File size must be less than 5MB");
        userImgInput.value = ""; // 파일 초기화
        imgPreview.src = "#";
        imgPreview.style.display = "none";
        return;
    }

    const reader = new FileReader();

    reader.onload = function (e) {
        imgPreview.src = e.target.result;
        imgPreview.style.display = "block";
    };

    reader.readAsDataURL(file);
}


// 폼 최종 검증 함수
function validateSignupForm() {

    console.log("🔍 폼 검증 시작!");

    let isValid = true;

    const userId = document.getElementById("user_id").value.trim();
    const userPw = pwInput.value.trim();
    const userPwConfirm = pwConfirmInput.value.trim();
    const userName = document.getElementById("user_name").value.trim();
    const userNickname = document.getElementById("user_nickname").value.trim();
    const userEmail = document.getElementById("user_email").value.trim();
    const userType = document.getElementById("user_type").value;

    console.log("✅ user_type 값:", userType);

    // 에러 초기화
    document.getElementById("id-error").textContent = "";
    pwError.textContent = "";
    document.getElementById("pw-confirm-error").textContent = "";
    document.getElementById("name-error").textContent = "";
    document.getElementById("nickname-error").textContent = "";
    document.getElementById("email-error").textContent = "";
    document.getElementById("user-type-error").textContent = "";

    // 필수 항목 미입력 시 에러 처리
    if (!userType) {
        alert("ユーザータイプを選んでください");
        document.getElementById("user-type-error").textContent = "ユーザータイプを選んでください";
        console.warn("❌ user_type 미선택");

        // 선택 버튼 영역 강조 (선택 사항)
        document.querySelectorAll('.user-type-btn').forEach(btn => {
            btn.style.borderColor = "red";
        });

        // 자동 포커스 이동은 hidden input에는 안 먹히기 때문에
        // 스크롤만 이동하거나 위에 메시지 보여주는 걸로 대신할 수 있음
        window.scrollTo({ top: 0, behavior: 'smooth' });

        return false;
    }
    if (!isIdChecked) {
        alert("ユーザー名のチェックを行ってください");
        document.getElementById("user_id").focus();
        console.warn("❌ ID 중복 체크 미완료");
        return false;
    }

    if (!userId) {
        document.getElementById("id-error").textContent = "ユーザー名を入力してください";
        document.getElementById("user_id").focus();
        console.warn("❌ ID 미입력");
        return false;
    }

    if (!userPw) {
        pwError.textContent = "パスワードを入力してください";
        pwError.style.color = "red";
        pwInput.focus();
        console.warn("❌ 비밀번호 미입력");
        return false;
    }

    if (userPw !== userPwConfirm) {
        pwError.textContent = "パスワードが一致していません";
        pwError.style.color = "red";
        pwConfirmInput.focus();
        console.warn("❌ 비밀번호 불일치");
        return false;
    }

    if (!userName) {
        document.getElementById("name-error").textContent = "お名前を入力してください";
        document.getElementById("user_name").focus();
        console.warn("❌ 이름 미입력");
        return false;
    }

    if (!userNickname) {
        document.getElementById("nickname-error").textContent = "ニックネームを入力してください";
        document.getElementById("user_nickname").focus();
        console.warn("❌ 닉네임 미입력");
        return false;
    }

    if (!userEmail) {
        document.getElementById("email-error").textContent = "メールアドレスを入力してください";
        document.getElementById("user_email").focus();
        console.warn("❌ 이메일 미입력");
        return false;
    }

    const file = userImgInput.files[0];
    if (file && file.size > 5 * 1024 * 1024) {
        alert("File size must be less than 5MB");
        userImgInput.focus();
        console.warn("❌ 이미지 용량 초과");
        return false;
    }

    console.log("✅ 모든 검증 통과, 폼 제출 허용");
    return true;
}
