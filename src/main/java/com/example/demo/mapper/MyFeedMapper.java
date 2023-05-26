package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface MyFeedMapper {
	
	@Select("""
			SELECT feedId, fileName FROM File
			ORDER BY id DESC
			""")
	List<File> selectAll();

	@Insert("""
			INSERT INTO Feed (title, content, writer, location)
			VALUES(#{title}, #{content}, #{writer}, #{location})
			""")
	@Options(useGeneratedKeys = true, keyProperty = "id")
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
