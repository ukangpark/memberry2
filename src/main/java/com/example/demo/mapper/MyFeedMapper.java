package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;
import org.springframework.security.core.*;

import com.example.demo.domain.*;

@Mapper
public interface MyFeedMapper {

	@Select("""
			SELECT
				f.id,
				f.feedId,
				f.fileName,
				p.petName,
				p.type,
				p.together,
				f.memberId,
				m.nickName,
				t.keyword,
				CONCAT('/', p.id, '/', p.photo) profileImage
				
			FROM File f LEFT JOIN  Pet p ON f.memberId = p.memberId
						LEFT JOIN Member m ON m.id = f.memberId
						LEFT JOIN Tags t ON t.memberId = f.memberId
			WHERE f.memberId = #{memberId}
			GROUP BY f.feedId ORDER BY f.id DESC
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
				t.keyword,
				CONCAT('/', p.id, '/', p.photo) profileImage,
				(SELECT COUNT(*)
				 FROM FeedLike
				 WHERE feedId = fd.id) likeCount,
				 (SELECT COUNT(*) FROM Comment WHERE feedId = fd.id) commentCount
			FROM Feed fd LEFT JOIN File fl ON fd.id = fl.feedId
						 LEFT JOIN Member m ON m.id = fd.writer
				         LEFT JOIN Tags t ON t.memberId = m.id
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

	@Select("""
			SELECT p.*,
					m.defaultPetId,
					m.nickName,
					CONCAT('/', p.id, '/', p.photo) profileImage
			 FROM Pet p
					LEFT JOIN Member m ON m.defaultPetId = p.id
			WHERE m.id = #{userName}
			""")
	Registration selectAllByProfile(String userName, Authentication authentication);

	@Insert("""
			INSERT INTO Tags (memberId, keyword, feedId)
			VALUES (#{name}, #{tagInput}, #{feedId})
			""")
	Integer insertTag(Integer feedId, String tagInput, String name);

	@Select("""
			SELECT * FROM Tags
			WHERE feedId = #{feedId}
			""")
	List<Tag> selectTag(Integer feedId, String name);

	@Select("""
			SELECT auto_increment FROM information_schema.tables
			WHERE table_schema='membery' AND table_name='Feed';
			""")
	Integer selectFeedId(String memberId);

	@Select("""
			SELECT
				(SELECT COUNT(*) FROM Follow WHERE feedOwner = #{memberId}) followCount,
				(SELECT COUNT(*) FROM Follow WHERE memberId = #{user}) followingCount
			FROM Follow where feedOwner = #{memberId};
			""")
	List<Follow> selectAllByFollow(String memberId, String user);

}
