package com.example.demo.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.domain.Chat;

@Mapper
public interface ChatMapper {

	@Select("""
			SELECT * 
			FROM Chat
			WHERE ((fromId = #{formId} AND toId = #{toId}) 
					OR (fromId = #{toId} AND toId = #{fromId}))
					AND chatId > #{chatId} ORDER BY chatTime
			""")
	ArrayList<Chat> selectById();

	@Select("""
			SELECT * 
			FROM Chat
			WHERE ((fromId = #{formId} AND toId = #{toId}) 
					OR (fromId = #{toId} AND toId = #{fromId}))
					AND chatId > (SELECT MAX(chatId) - #{chatId})
			ORDER BY chatTime
			""")
	ArrayList<Chat> selectByRecent();
	
}
