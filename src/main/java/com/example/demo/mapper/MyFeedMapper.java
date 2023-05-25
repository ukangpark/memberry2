package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.domain.Feed;

@Mapper
public interface MyFeedMapper {
	
	@Select("""
			SELECT 
				id,
				title
			FROM Feed
			ORDER BY id DESC
			""")
	List<Feed> selectAll();

	@Insert("""
			INSERT INTO Feed (title, content, writer, location)
			VALUES(#{title}, #{content}, #{writer}, #{location})
			""")
	int insert(Feed feed);

	@Select("""
			SELECT * 
			FROM Feed
			WHERE id = #{id}
			""")
	Feed selectById(Integer id);

	@Insert("""
			INSERT INTO File (feedId, fileName)
			VALUES (#{feedId}, #{fileName})
			""")
	Integer insertFileName(Integer feedId, String fileName);
	
}
