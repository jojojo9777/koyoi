
// 오늘 날짜 반환
function getTodayDateStr() {
  const today = new Date();
  const year = today.getFullYear();
  const month = ("0" + (today.getMonth() + 1)).slice(-2);
  const day = ("0" + today.getDate()).slice(-2);
  return `${year}-${month}-${day}`;
}

// 전역 변수
let selectedDate = null;
let currentMonth = new Date().getMonth();
let currentYear = new Date().getFullYear();

// 날짜 하이라이트
function highlightSelectedDate(dateStr) {
  const calendarCells = document.querySelectorAll(".calendar-day");
  calendarCells.forEach(cell => {
    if (cell.dataset.date === dateStr) {
      cell.classList.add("selected");
    } else {
      cell.classList.remove("selected");
    }
  });
}

// 체크박스 상태 불러오기
function loadTrackingStatus(retry = 0) {
  console.log("🧪 loadTrackingStatus 진입!", retry, "회차");
  console.log("📆 selectedDate:", selectedDate);
  if (!selectedDate) return;

  const checkboxes = document.querySelectorAll('input[type="checkbox"]');
  console.log("📦 체크박스 수:", checkboxes.length);

  if (checkboxes.length === 0 && retry < 5) {
    console.warn(`⏳ 체크박스 없음 → ${retry + 1}회 재시도`);
    return setTimeout(() => loadTrackingStatus(retry + 1), 100);
  }

  fetch(`/habit/tracking/status?date=${selectedDate}`)
      .then(res => res.json())
      .then(result => {
        const tracked = Array.isArray(result) ? result : result.data;
        console.log("✅ 불러온 tracked 상태:", tracked);

        checkboxes.forEach(cb => {
          const habitId = parseInt(cb.id.split("-")[1]);
          cb.checked = tracked.includes(habitId);
        });

        attachCheckboxEvents();
      });
}

// 체크박스 이벤트 연결
function attachCheckboxEvents() {
  document.querySelectorAll('input[type="checkbox"]').forEach(oldCb => {
    const newCb = oldCb.cloneNode(true);
    oldCb.replaceWith(newCb);
  });

  document.querySelectorAll('input[type="checkbox"]').forEach(cb => {
    cb.addEventListener("change", function () {
      const habitId = parseInt(this.id.split("-")[1]);
      const isChecked = this.checked ? 1 : 0;

      if (!selectedDate) {
        alert("先に日付を選択してください！");
        this.checked = !this.checked;
        return;
      }

      const payload = {
        habit_id: habitId,
        completed: isChecked,
        tracking_date: selectedDate,
        user_id: "user1"
      };

      fetch("/habit/tracking", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload)
      }).then((response) => {
        if (!response.ok) {
          alert("状態の保存に失敗しました");
          this.checked = !isChecked;
        } else {
          loadWeeklySummary();
        }
      }).catch(err => {
        console.error("保存エラー:", err);
        this.checked = !isChecked;
      });
    });
  });
}

// 습관 삭제
function deleteHabit(habit_id) {
  if (confirm("本当に削除していいですか?")) {
    fetch("/habit/delete/" + habit_id, {
      method: "DELETE",
      headers: { "Content-Type": "application/json" },
    })
        .then((response) => {
          if (response.ok) {
            // ✅ UI에서 삭제
            document.getElementById("habit-box-" + habit_id).remove();

            // ✅ 주간 이력 요약도 즉시 갱신!
            loadWeeklySummary();
          } else {
            alert("削除失敗");
          }
        })
        .catch((error) => {
          console.error("Error:", error);
          alert("서버 오류로 삭제 실패");
        });
  }
}


// 습관 직접 추가
function addHabit() {
  const habitName = document.getElementById("habitInput").value.trim();
  if (!habitName) {
    alert("習慣名を入力してください！");
    return;
  }

  const data = { habit_name: habitName, user_id: "user1" };

  fetch("/habit/add", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data)
  })
      .then(res => res.json())
      .then(data => {
        if (data.habit_id || data.status === "success") {
          alert("習慣を追加しました！");
          location.reload();
        } else {
          alert("習慣の追加に失敗しました: " + data.message);
        }
      })
      .catch(err => {
        console.error("追加エラー:", err);
        alert("サーバーエラーが発生しました");
      });
}



function addHabitToDatabase(habitName) {
  const data = { habit_name: habitName, user_id: "user1" };

  fetch("/habit/add", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data)
  })
      .then(res => {
        if (!res.ok) {
          return res.text().then(errorText => {
            if (!errorText) {
              // ✅ 응답 본문이 아예 없을 경우 (진짜 빈 응답)
              alert("サーバーからの応答がありません（空のレスポンス）");
              throw new Error("빈 응답");
            }

            let errorData = {};
            try {
              errorData = JSON.parse(errorText);
            } catch (e) {
              console.warn("⚠️ JSON 파싱 실패. 원문:", errorText);
            }

            const msg = errorData.message || "";

            const isDuplicate =
                msg.includes("이미") ||
                msg.includes("すでに") ||
                msg.includes("存在") ||
                msg.includes("등록") ||
                errorData.status === "duplicate";

            if (isDuplicate) {
              alert("すでに追加された習慣です！");
            } else {
              alert("習慣の追加に失敗しました（サーバーエラー）");
            }

            throw new Error("サーバー응답 에러");
          });
        }

        return res.json();
      })
      .then(data => {
        alert("おすすめ習慣を追加しました！");
        location.reload();
      })
      .catch(err => {
        console.error("おすすめ追加エラー:", err);
      });
}


//이번주만 메모 가능하게
function isEditableWeek(dateStr) {
  const selected = new Date(dateStr);
  const today = new Date();

  // 선택한 날짜의 일요일 (주 시작일)
  const selectedWeekStart = new Date(selected);
  selectedWeekStart.setDate(selected.getDate() - selected.getDay());

  // 오늘 날짜의 일요일 (현재 주 시작일)
  const currentWeekStart = new Date(today);
  currentWeekStart.setDate(today.getDate() - today.getDay());

  return selectedWeekStart.getFullYear() === currentWeekStart.getFullYear()
      && selectedWeekStart.getMonth() === currentWeekStart.getMonth()
      && selectedWeekStart.getDate() === currentWeekStart.getDate();
}


// 주간 통계
function loadWeeklySummary() {
  fetch(`/habit/week/status?date=${selectedDate}`)
      .then(res => res.json())
      .then(data => {
        renderWeeklyMemo(data);
        renderEncouragement(data);
      });
}

function renderWeeklyMemo(data) {
  const tbody = document.getElementById("weeklyHabitBody");
  tbody.innerHTML = "";
  data.forEach(habit => {
    const tracking = habit.tracking;
    let row = `<tr><td>${habit.habit_name}</td>`;
    // const dayOrder = [6, 0, 1, 2, 3, 4, 5];
      const dayOrder = [0, 1, 2, 3, 4, 5, 6]; // 순서대로 일~토
    dayOrder.forEach(i => {
      row += `<td>${tracking[i] ? "🅾️" : "❎"}</td>`;
    });
    row += "</tr>";
    tbody.innerHTML += row;
  });
}

function renderEncouragement(data) {
  const list = document.getElementById("encouragementList");
  list.innerHTML = "";
  data.forEach(habit => {
    list.innerHTML += `<li><strong>${habit.habit_name}</strong>: ${habit.encouragement}</li>`;
  });
}

// 캘린더 생성
function generateCalendar(month, year) {
  const calendarBody = document.getElementById("calendarBody");
  calendarBody.innerHTML = "";

  const monthYear = document.getElementById("monthYear");
  monthYear.textContent = `${year}年 ${month + 1}月`;

  const firstDay = new Date(year, month, 1).getDay();
  const daysInMonth = new Date(year, month + 1, 0).getDate();

  for (let i = 0; i < firstDay; i++) {
    const empty = document.createElement("div");
    empty.classList.add("calendar-day");
    empty.innerHTML = "&nbsp;";
    calendarBody.appendChild(empty);
  }

  for (let day = 1; day <= daysInMonth; day++) {
    const cell = document.createElement("div");
    cell.classList.add("calendar-day");
    cell.textContent = day;

    const m = String(month + 1).padStart(2, "0");
    const d = String(day).padStart(2, "0");
    const dateStr = `${year}-${m}-${d}`;
    cell.dataset.date = dateStr;

    cell.addEventListener("click", function () {
      selectedDate = this.dataset.date;
      highlightSelectedDate(selectedDate);
      document.getElementById("selectedDateDisplay").textContent = `選択した日付：${selectedDate}`;
      loadTrackingStatus();
      loadWeeklySummary();
    });

    calendarBody.appendChild(cell);
  }
}

// 탭 전환
function habitShowTab(tab) {
  const allTabs = document.querySelectorAll(".habit-content");
  const allTabButtons = document.querySelectorAll(".habit-tab");

  allTabs.forEach(content => content.classList.add("habit-hidden"));
  allTabButtons.forEach(button => button.classList.remove("habit-active"));

  const targetTab = document.getElementById("habit-" + tab);
  const targetBtn = document.getElementById("habit-tab-" + tab);

  if (targetTab) targetTab.classList.remove("habit-hidden");
  if (targetBtn) targetBtn.classList.add("habit-active");
}
//메모불러오기


function loadWeeklyMemo() {
  if (!selectedDate) return;

  fetch(`/habit/memo?date=${selectedDate}&user_id=${sessionUserId}`)
      .then(res => res.text())
      .then(memo => {
        const memoBox = document.getElementById("weeklyMemoText");
        const saveBtn = document.getElementById("saveMemoBtn");

        memoBox.value = memo || "";

        const editable = isEditableWeek(selectedDate);

        memoBox.readOnly = !editable;
        saveBtn.disabled = !editable;
        saveBtn.style.opacity = editable ? "1" : "0.5";
        saveBtn.title = editable ? "" : "この週は編集できません";
      })
      .catch(err => {
        console.error("メモ 불러오기 실패:", err);
      });
}


//메모저장
function saveWeeklyMemo() {
  if (!selectedDate) {
    alert("日付を選択してください！");
    return;
  }

  const feedback = document.getElementById("weeklyMemoText").value.trim();

  const payload = {
    tracking_date: selectedDate,
    feedback: feedback,
    user_id: sessionUserId  // 🔹 여기 추가!
  };

  fetch("/habit/memo", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(payload)
  })
      .then(res => {
        if (!res.ok) throw new Error("保存失敗");
        return res.text();
      })
      .then(result => {
        console.log("💾 저장 결과:", result);
        alert("メモが保存されました！");
      })
      .catch(err => {
        console.error("メモ 저장 실패:", err);
        alert("メモ保存に失敗しました。");
      });
}



// 초기 실행
document.addEventListener("DOMContentLoaded", function () {
  console.log("🌱 DOMContentLoaded 진입");

  generateCalendar(currentMonth, currentYear);

  selectedDate = getTodayDateStr();
  console.log("📌 오늘 날짜:", selectedDate);

  highlightSelectedDate(selectedDate);
  document.getElementById("selectedDateDisplay").textContent = `選択した日付：${selectedDate}`;

  setTimeout(() => {
    console.log("🚀 loadTrackingStatus 지연 실행");
    loadTrackingStatus();
  }, 100);

  loadWeeklySummary();
  habitShowTab("신체건강");
  loadWeeklyMemo(); // 초기 오늘 날짜에 대한 메모 로딩
  const saveMemoBtn = document.getElementById("saveMemoBtn");
  if (saveMemoBtn) {
    saveMemoBtn.addEventListener("click", saveWeeklyMemo);
  }

  const recommendItems = document.querySelectorAll(".habit-recommend p");
  recommendItems.forEach(item => {
    item.addEventListener("click", function () {
      const habitName = this.innerText;
      addHabitToDatabase(habitName);
    });
  });

  const addBtn = document.getElementById("addHabitBtn");
  if (addBtn && !addBtn.dataset.listenerAttached) {
    addBtn.setAttribute("type", "button");
    addBtn.addEventListener("click", addHabit);
    addBtn.dataset.listenerAttached = "true";
  }

  document.getElementById("prevMonth").addEventListener("click", function () {
    currentMonth--;
    if (currentMonth < 0) {
      currentMonth = 11;
      currentYear--;
    }
    generateCalendar(currentMonth, currentYear);
  });

  document.getElementById("nextMonth").addEventListener("click", function () {
    currentMonth++;
    if (currentMonth > 11) {
      currentMonth = 0;
      currentYear++;
    }
    generateCalendar(currentMonth, currentYear);
  });
});
