package com.koyoi.main.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "TEST_CHAT")
@Getter
@Setter
//@NoArgsConstructor
@AllArgsConstructor
//public class ChatSummary {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    @Column(name = "chat_id")
//    private Long chatId;
//
//    @Column(name = "user_id", nullable = false)
//    private String userId;
//
//    @Lob
//    @Column(name = "chat_summary", nullable = false)
//    private String chatSummary;
//
////    @Column(name = "create_at", insertable = false, updatable = false)
////    private LocalDateTime createAt;
//
//
//    @Column(name = "chat_title", length = 200)
//    private String chatTitle;
//
//    @Column(name = "create_at", nullable = false, columnDefinition = "DATE DEFAULT SYSDATE")
//    private LocalDateTime createAt;
//
//
//
//}

public class ChatSummary {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "chat_id")
    private Long chatId;

    @Column(name = "chat_title")
    private String chatTitle;

    @Column(name = "user_id")
    private String userId;

    @Column(name = "chat_summary")
    private String chatSummary;

    @Column(name = "create_at", nullable = false)
    private LocalDateTime createAt;

    // 자동으로 날짜 삽입
    @PrePersist
    protected void onCreate() {
        if (this.createAt == null) {
            this.createAt = LocalDateTime.now();
        }
    }

    // 기본 생성자 + Getter/Setter 필수
    public ChatSummary() {}

}

