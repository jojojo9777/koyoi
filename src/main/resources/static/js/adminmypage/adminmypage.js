document.addEventListener("DOMContentLoaded", function () {

    // 유저, 상담사 목록 토글
    const userBtn = document.getElementById("user");
    const counselorBtn = document.getElementById("counselor");
    const userTable = document.getElementById("userTable");
    const counselorTable = document.getElementById("counselorTable");

    const lastView = sessionStorage.getItem("lastView") || "user";

    if (lastView === "counselor") {
        userTable.style.display = "none";
        counselorTable.style.display = "table";
        sessionStorage.setItem("lastView", "user");
    } else {
        userTable.style.display = "table";
        counselorTable.style.display = "none";
        sessionStorage.setItem("lastView", "counselor");
    }


    userBtn.addEventListener("click", function () {
        userTable.style.display = "table";
        counselorTable.style.display = "none";
    });

    counselorBtn.addEventListener("click", function () {
        userTable.style.display = "none";
        counselorTable.style.display = "table";
    });


    // 상세 정보 모달
    const userDetailButtons = document.querySelectorAll(".user-detail-btn");
    const modal = document.getElementById("userDetailModal");
    const closeBtn = document.querySelector(".close");

    const passwordInput = document.getElementById("modalUserPassword");
    const toggleIcon = document.querySelector(".password-toggle");

    toggleIcon.addEventListener("click", function () {
        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            toggleIcon.classList.remove("fa-eye");
            toggleIcon.classList.add("fa-eye-slash"); // 눈 감은 아이콘
        } else {
            passwordInput.type = "password";
            toggleIcon.classList.remove("fa-eye-slash");
            toggleIcon.classList.add("fa-eye"); // 눈 뜬 아이콘
        }
    });

    // 모달 내부 요소
    const modalUserId = document.getElementById("modalUserId");
    const modalUserPassword = document.getElementById("modalUserPassword");
    const modalUserName = document.getElementById("modalUserName");
    const modalUserEmail = document.getElementById("modalUserEmail");
    const modalUserType = document.getElementById("modalUserType");
    const modalCreatedAt = document.getElementById("modalCreatedAt");

    const saveUserChanges = document.getElementById("saveUserChanges"); // 수정 버튼
    const deleteUser = document.getElementById("deleteUser"); // 삭제 버튼

    // 유저 상세 정보 클릭 이벤트 추가
    userDetailButtons.forEach(button => {
        button.addEventListener("click", function () {
            const userId = this.getAttribute("data-user-id");
            const userType = this.getAttribute("data-type") || "user"; // 기본값은 'user'

            document.getElementById("userDetailModal").setAttribute("data-user-id", userId);

            // API 호출하여 사용자 상세 정보 가져오기
            fetch(`/admin/userDetail?userId=${userId}`)
                .then(response => response.json())
                .then(data => {
                    console.log("불러온 이미지 경로:", data.user_img); // 경로 확인용
                    if (data.user_img) {
                        modalUserImg.src = `/static/${data.user_img}`;
                    } else {
                        modalUserImg.src = "/static/imgsource/testprofile.png"; // 기본 이미지
                    }

                    if (data) {
                        modalUserId.textContent = data.user_id || "";
                        modalUserPassword.value = data.user_password || "";
                        modalUserName.textContent = data.user_name || "";
                        modalUserNickname.value = data.user_nickname || "";
                        modalUserEmail.value = data.user_email || "";
                        modalUserType.textContent = (data.user_type === 2 ) ? "상담사" : "회원";
                        modalCreatedAt.textContent = data.formattedCreatedAt || "";

                        modal.style.display = "block";
                    }
                })
                .catch(error => console.error("Error fetching user details:", error));
        });
    });

    // 모달 창 닫기 (X 버튼, 모달 창 바깥 클릭)
    closeBtn.addEventListener("click", function () {
        modal.style.display = "none";
    });

    window.addEventListener("click", function (event) {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    });

});

// 유저 정보 삭제
document.addEventListener("click", function (event) {
    // 클릭된 요소가 deleteUser 버튼인지 확인
    if (event.target && event.target.id === "deleteUser") {
        const userId = document.getElementById("modalUserId").textContent;

        if (!confirm("정말로 삭제하시겠습니까?")) {
            return;
        }

        fetch(`/admin/deleteUser?userId=${userId}`, {
            method: "DELETE"
        })
            .then(response => {
                return response.text();
            })
            .then(result => {
                if (result === "1") {
                    alert("삭제 성공했습니다.");
                    if (userType === "상담사") {
                        sessionStorage.setItem("lastView", "counselor");
                    } else {
                        sessionStorage.setItem("lastView", "user");
                    }
                    document.getElementById("userDetailModal").style.display = "none";
                    location.reload();
                } else {
                    alert("삭제에 실패했습니다. 다시 시도해주세요.");
                }
            })
            .catch(error => console.error("삭제 요청 실패:", error));
    }
});

// 유저 정보 수정
document.addEventListener("click", function (event) {
    if (event.target && event.target.id === "updateUser") {
        const userId = document.getElementById("modalUserId").textContent;
        const updatedPassword = document.getElementById("modalUserPassword").value;
        const updatedNickname = document.getElementById("modalUserNickname").value;
        const updatedEmail = document.getElementById("modalUserEmail").value;
        const userType = document.getElementById("modalUserType").textContent.trim();

        if (!confirm("정말로 수정하시겠습니까?")) {
            return;
        }

        const userData = {
            user_id: userId,
            user_password: updatedPassword,
            user_nickname: updatedNickname,
            user_email: updatedEmail
        };

        fetch(`/admin/updateUser`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(userData)
        })
            .then(response => response.text())
            .then(result => {
                if (result === "1") {
                    alert("수정했습니다.");
                    if (userType === "상담사") {
                        sessionStorage.setItem("lastView", "counselor");
                    } else {
                        sessionStorage.setItem("lastView", "user");
                    }
                    document.getElementById("userDetailModal").style.display = "none";
                    location.reload();
                } else {
                    alert("수정에 실패했습니다. 다시 시도해주세요.");
                }
            })
            .catch(error => console.error("수정 요청 실패:", error));
    }
});


