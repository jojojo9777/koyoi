package com.koyoi.main.mapper;

import com.koyoi.main.vo.DiaryVO;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

@Mapper
public interface DiaryMapper {
    // 캘린더 조회 (Emotion과 join)
    @Select("SELECT D.diary_id, " +
            "TO_CHAR(D.created_at, 'YYYY-MM-DD') AS DIARY_DATE, " +
            "E.emotion_emoji AS EMOTION_EMOJI " +
            "FROM TEST_DIARY D " +
            "LEFT JOIN TEST_EMOTION E ON D.diary_id = E.diary_id " +
            "WHERE D.user_id = #{userId} " +
            "ORDER BY D.created_at DESC")
    List<Map<String, Object>> getDiaryEmojisForCalendar(@Param("userId") String userId);

    // 일기 상세 조회 (diaryid 기준)
    @Select("SELECT D.diary_id, D.user_id, D.title, D.diary_content, D.created_at, " +
            "E.emotion_emoji, E.emotion_score " +
            "FROM TEST_DIARY D " +
            "LEFT JOIN TEST_EMOTION E ON D.diary_id = E.diary_id " +
            "WHERE D.diary_id = #{diaryId}")
    DiaryVO getDiaryById(@Param("diaryId") int diaryId);

    // 일기 등록
    @Insert("INSERT INTO TEST_DIARY (user_id, title, diary_content, created_at) " +
            "VALUES (#{user_id}, #{title}, #{diary_content}, SYSDATE)")
    int addDiary(DiaryVO diaryVO);

    // 일기 수정
    @Update("UPDATE TEST_DIARY " +
            "SET title = #{title}, " +
            "    diary_content = #{diary_content} " +
            "WHERE diary_id = #{diary_id}")
    int updateDiary(DiaryVO diaryVO);

    // 일기 삭제
    @Delete("DELETE FROM TEST_DIARY " +
            "WHERE diary_id = #{diaryId}")
    int deleteDiary(@Param("diaryId") int diaryId);

}
