package com.koyoi.main.mapper;

import com.koyoi.main.vo.AdminMypageVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface AdminMypageMapper {

    @Select("select * from test_user where user_type = 1 order by created_at DESC")
    List<AdminMypageVO> getAllUsers();

    @Select("select * from test_user where user_type = 2 order by created_at DESC")
    List<AdminMypageVO> getAllCounselors();

    @Select("select * from test_user where user_id = #{userId}")
    AdminMypageVO getUserById(@Param("userId") String userId);

    @Update("update test_user set user_name = #{user_name}, user_email = #{user_email}, user_password = #{user_password} where user_id = #{user_id}")
    int updateUser(AdminMypageVO user);
}
