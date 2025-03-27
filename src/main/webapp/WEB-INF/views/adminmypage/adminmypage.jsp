<%@ page import="com.koyoi.main.vo.AdminMypageVO" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    AdminMypageVO user = (AdminMypageVO) request.getAttribute("user");
    String imgPath = (user != null && user.getUser_img() != null)
            ? user.getUser_img()
            : "/imgsource/usermypage_profiletest.jpg"; // 기본 이미지
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>KOYOI</title>
    <link href="https://fonts.googleapis.com/css2?family=Inknut+Antiqua&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/static/css/adminmypage/adminmypage.css">
    <script src="/static/js/adminmypage/adminmypage.js"></script>
</head>
<body
        data-user-total="${userTotal}" data-user-page="${userPage}"
        data-counselor-total="${counselorTotal}" data-counselor-page="${counselorPage}"
        data-announcement-total="${announcementTotal}" data-announcement-page="${announcementPage}">

<div class="container">

    <div class="left-container">
        <aside class="sidebar">
            <nav class="sidebar-menu">
                <button class="sidebar-btn" id="user">
                    <img src="/static/imgsource/profile/user.png" alt="user">
                </button>
                <button class="sidebar-btn" id="counselor">
                    <img src="/static/imgsource/profile/counselor.png" alt="counselor">
                </button>
                <button class="sidebar-btn" id="announcement">
                    <img src="/static/imgsource/announcements.png" alt="announcement">
                </button>
            </nav>
        </aside>
    </div>

    <div class="right-container">
        <header class="header-bar">
            <div class="brand-title">
                <a href="/main"> <img class="logo-icon" src="/static/imgsource/layout/logo.png" alt="KOYOI"> </a>
            </div>

            <div class="header-icons">
                <button class="header-btn">
                    <a href="/logout"> <img src="/static/imgsource/layout/logout.png" alt="logout"> </a>
                </button>
                <img class="profile-img" src="/static<%=imgPath%>" alt="profile">
            </div>
        </header>

        <main class="content">
            <h2 id="table-title" class="table-title"> 会員一覧 </h2>
            <p id="memberTypeLabel" class="sub-title"> "ユーザー" </p>

            <%-- 회원 목록 --%>
            <div id="userTable" class="user-board">
                <div class="user-board-header">
                    <div class="col col-num"> 番号 </div>
                    <div class="col col-id"> アイディー </div>
                    <div class="col col-name"> 氏名 </div>
                    <div class="col col-nickname"> ニックネーム </div>
                    <div class="col col-email"> メール </div>
                    <div class="col col-date"> 登録日 </div>
                </div>
                <c:forEach var="user" items="${users}" varStatus="status">
                    <div class="user-row user-detail-btn" data-user-id="${user.user_id}">
                        <div class="cell col-num">${userTotal - ((userPage - 1) * 5 + status.index)}</div>
                        <div class="cell col-id">${user.user_id}</div>
                        <div class="cell col-name">${user.user_name}</div>
                        <div class="cell col-nickname">${user.user_nickname}</div>
                        <div class="cell col-email">${user.user_email}</div>
                        <div class="cell col-date">${user.formattedCreatedAt}</div>
                    </div>
                </c:forEach>
              <%--  <c:set var="totalUsers" value="${fn:length(users)}" />
                <c:forEach var="user" items="${users}" varStatus="status">
                    <div class="user-row user-detail-btn" data-user-id="${user.user_id}">
                        <div class="cell col-num">${totalUsers - status.index}</div>
                        <div class="cell col-id">${user.user_id}</div>
                        <div class="cell col-name">${user.user_name}</div>
                        <div class="cell col-nickname">${user.user_nickname}</div>
                        <div class="cell col-email">${user.user_email}</div>
                        <div class="cell col-date">${user.formattedCreatedAt}</div>
                    </div>
                </c:forEach>--%>
            </div>

            <%-- 상담사 목록 --%>
            <div id="counselorTable" class="user-board" style="display: none;">
                <div class="user-board-header">
                    <div class="col col-num"> 番号 </div>
                    <div class="col col-id"> ID </div>
                    <div class="col col-name"> 氏名 </div>
                    <div class="col col-nickname"> ニックネーム </div>
                    <div class="col col-email"> メール </div>
                    <div class="col col-date"> 登録日 </div>
                </div>
                <c:forEach var="counselor" items="${counselors}" varStatus="status">
                    <div class="user-row user-detail-btn" data-user-id="${counselor.user_id}">
                        <div class="cell col-num">${counselorTotal - ((counselorPage - 1) * 5 + status.index)}</div>
                        <div class="cell col-id">${counselor.user_id}</div>
                        <div class="cell col-name">${counselor.user_name}</div>
                        <div class="cell col-nickname">${counselor.user_nickname}</div>
                        <div class="cell col-email">${counselor.user_email}</div>
                        <div class="cell col-date">${counselor.formattedCreatedAt}</div>
                    </div>
                </c:forEach>
                <%--<c:set var="totalCounselors" value="${fn:length(counselors)}" />
                <c:forEach var="counselor" items="${counselors}" varStatus="status">
                    <div class="user-row user-detail-btn" data-user-id="${counselor.user_id}" data-type="counselor">
                        <div class="cell col-num">${totalCounselors - status.index}</div>
                        <div class="cell col-id">${counselor.user_id}</div>
                        <div class="cell col-name">${counselor.user_name}</div>
                        <div class="cell col-nickname">${counselor.user_nickname}</div>
                        <div class="cell col-email">${counselor.user_email}</div>
                        <div class="cell col-date">${counselor.formattedCreatedAt}</div>
                    </div>
                </c:forEach>--%>
            </div>

            <%-- 상세 데이터 모달 --%>
            <div id="userDetailModal" class="modal" style="display: none;">
                <div class="modal-content">
                    <span class="close">&times;</span>
                    <h2 id="modalTitle" class="modalTitle"> 詳細情報 </h2>

                    <div class="profile-container">
                        <img id="modalUserImg" alt="profile">
                    </div>

                    <div class="user-info-grid scrollable">
                        <div class="field">
                            <label> ID </label>
                            <div id="modalUserId" class="value"></div>
                        </div>
                        <div class="field">
                            <label> パスワード </label>
                            <div class="input-wrap">
                                <div class="input-inner">
                                    <input type="password" id="modalUserPassword">
                                    <i class="fa-solid fa-eye password-toggle" id="passwordToggleIcon"></i>
                                </div>
                            </div>
                        </div>
                        <div class="field">
                            <label> 氏名 </label>
                            <div id="modalUserName" class="value"></div>
                        </div>
                        <div class="field">
                            <label> ニックネーム </label>
                            <input type="text" id="modalUserNickname">
                        </div>
                        <div class="field">
                            <label> メール </label>
                            <input type="email" id="modalUserEmail">
                        </div>
                        <div class="field">
                            <label> 種類 </label>
                            <div id="modalUserType" class="value"></div>
                        </div>
                        <div class="field">
                            <label> 登録日 </label>
                            <div id="modalCreatedAt" class="value"></div>
                        </div>
                    </div>

                    <div class="modal-buttons">
                        <button id="updateUser"> 更新 </button>
                        <button id="deleteUser"> 削除 </button>
                    </div>
                </div>
            </div>

            <%-- 공지사항 목록 --%>
            <div id="announcementTable" class="announcement-board" style="display: none;">
                <button class="announcement-create-btn"> 新規作成 </button>
                <div class="announcement-board-header">
                    <div class="col col-announcement-num"> 番号 </div>
                    <div class="col col-announcement-id"> 管理者ID </div>
                    <div class="col col-announcement-title"> タイトル </div>
                    <div class="col col-announcement-created"> 作成日 </div>
                </div>
                <c:forEach var="announcement" items="${announcements}" varStatus="status">
                    <div class="announcement-row announcement-detail-btn" data-user-id="${announcement.announcement_id}">
                        <div class="cell col-announcement-num">${announcementTotal - ((announcementPage - 1) * 5 + status.index)}</div>
                        <div class="cell col-announcement-id">${announcement.admin_id}</div>
                        <div class="cell col-announcement-title">${announcement.title}</div>
                        <div class="cell col-announcement-created">${announcement.formattedCreatedAt}</div>
                    </div>
                </c:forEach>
                <%--<c:set var="totalAnnouncements" value="${fn:length(announcements)}" />
                <c:forEach var="announcement" items="${announcements}" varStatus="status">
                <div class="announcement-row announcement-detail-btn" data-user-id="${announcement.announcement_id}">
                    <div class="cell col-announcement-num">${totalAnnouncements - status.index}</div>
                    <div class="cell col-announcement-id">${announcement.admin_id}</div>
                    <div class="cell col-announcement-title">${announcement.title}</div>
                    <div class="cell col-announcement-created">${announcement.formattedCreatedAt}</div>
                </div>
                </c:forEach>--%>
            </div>

            <%-- 공지사항 상세 모달 --%>
            <div id="announcementModal" class="modal">
                <div class="modal-content">
                    <span class="modal-close-btn">&times;</span>
                    <div class="modalTitle"> お知らせ詳細 </div>
                    <div class="announcement-modal scrollable">
                        <div class="announcement-info-grid">
                            <div class="field">
                                <label> タイトル </label>
                                <input type="text" id="modalAnnouncementTitle" class="value" />
                            </div>
                            <div class="field">
                                <label> 管理者ID </label>
                                <div id="modalAnnouncementAdminId" class="value"></div>
                            </div>
                            <div class="field">
                                <label> 作成日 </label>
                                <div id="modalAnnouncementCreated" class="value"></div>
                            </div>
                            <div class="field">
                                <label> 内容 </label>
                                <textarea id="modalAnnouncementContent" class="value" rows="8"></textarea>
                            </div>
                        </div>
                    </div>

                    <div class="modal-buttons">
                        <button id="updateAnnouncement" data-announcement-id=""> 更新 </button>
                        <button id="deleteAnnouncement" data-announcement-id=""> 削除 </button>
                    </div>
                </div>
            </div>

            <%-- 공지사항 작성 모달 --%>
            <div id="announcementCreateModal" class="modal">
                <div class="modal-content">
                    <span class="modal-close-btn create-close">&times;</span>
                    <div class="modalTitle"> お知らせを作成 </div>
                    <div class="announcement-modal scrollable">
                        <div class="announcement-info-grid">
                            <div class="field">
                                <label> タイトル </label>
                                <input type="text" id="createAnnouncementTitle" class="value" />
                            </div>
                            <div class="field">
                                <label> 内容 </label>
                                <textarea id="createAnnouncementContent" class="value" rows="8"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-buttons">
                        <button id="submitAnnouncement"> 登録 </button>
                    </div>
                </div>
            </div>
            <div id="commonPagination" class="pagination"></div>

        </main>
    </div>
</div>


</body>
</html>