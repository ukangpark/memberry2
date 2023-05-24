package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.domain.Feed;

@Mapper
public interface MyFeedMapper {

	@Insert("""
			INSERT INTO Feed (title, content, writer, location)
			VALUES(#{title}, #{content}, #{writer}, #{location})
			""")
	int insert(Feed feed);
	
}
