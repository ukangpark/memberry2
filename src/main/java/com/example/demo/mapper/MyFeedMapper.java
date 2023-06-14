package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;
import org.springframework.security.core.*;

import com.example.demo.domain.*;

@Mapper
public interface MyFeedMapper {
	
	@Select("""
			SELECT feedId, fileName FROM File
			WHERE memberId = #{memberId}
			GROUP BY FeedId ORDER BY id DESC
			""")
	List<File> selectAll(String memberId);

	@Insert("""
			INSERT INTO Feed (title, content, writer, location)
			VALUES(#{title}, #{content}, #{writer}, #{location})
			""")
	@Options(useGeneratedKeys = true, keyProperty = "id")
	int insert(Feed feed);

	@Select("""
			SELECT 
				fd.id,
				fd.title,
				fd.content,
				fd.writer,
				fd.inserted,
				fd.location,
				fl.fileName,
				m.nickName,
				CONCAT('/', p.id, '/', p.photo) profileImage,
				(SELECT COUNT(*) 
				 FROM FeedLike 
				 WHERE feedId = fd.id) likeCount,
				 (SELECT COUNT(*) FROM Comment WHERE feedId = fd.id) commentCount
			FROM Feed fd LEFT JOIN File fl ON fd.id = fl.feedId
						LEFT JOIN Member m ON m.id = fd.writer
				LEFT JOIN Pet p ON m.defaultPetId = p.id
			WHERE fd.id = #{id}
			""")
	@ResultMap("feedResultMap")
	Feed selectById(Integer id);
	
	@Insert("""
			INSERT INTO File (feedId, fileName, memberId)
			VALUES (#{feedId}, #{fileName}, #{memberId})
			""")
	Integer insertFileName(Integer feedId, String fileName, String memberId);

	@Update(""" 
			UPDATE Feed
			SET
				title = #{title},
				content = #{content}
			WHERE 
				id = #{id}
			""")
	int update(Feed feed);

	@Delete("""
			DELETE FROM Feed
			WHERE id = #{id}
			""")
	int deleteById(Integer id);

	@Select("""
			SELECT fileName FROM File
			WHERE feedId = #{feedId}
			""")
	List<String> selectFileNamesByFeedId(Integer feedId);

	@Delete("""
			DELETE FROM File
			WHERE feedId = #{feedId}
			""")
	void deleteFileNameByFeedId(Integer feedId);

	@Delete("""
			DELETE FROM File
			WHERE feedId = #{feedId}
				AND fileName = #{fileName}
			""")
	void deleteFileNameByFeedIdAndFileName(Integer feedId, String fileName);

	@Select("""
			SELECT id 
			FROM Feed
			WHERE writer = #{writer}
			""")
	List<Integer> selectIdByWriter(String writer);
	
	


}
