package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface MyFeedMapper {
	
	@Select("""
			SELECT feedId, fileName FROM File
			GROUP BY FeedId ORDER BY id DESC
			""")
	List<File> selectAll();

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
				(SELECT COUNT(*) 
				 FROM FeedLike 
				 WHERE feedId = fd.id) likeCount
			FROM Feed fd LEFT JOIN File fl ON fd.id = fl.feedId
			WHERE fd.id = #{id}
			""")
	@ResultMap("feedResultMap")
	Feed selectById(Integer id);
	
	@Insert("""
			INSERT INTO File (feedId, fileName)
			VALUES (#{feedId}, #{fileName})
			""")
	Integer insertFileName(Integer feedId, String fileName);

	@Update(""" 
			UPDATE Feed
			SET
				title = #{title},
				content = #{content},
				writer = #{writer},
				location = #{location}
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


}
