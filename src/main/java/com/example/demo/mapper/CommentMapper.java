package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.Comment;

@Mapper
public interface CommentMapper {

	@Select("""
			SELECT *
			FROM Comment
			WHERE feedId = #{feedId}
			""")
	List<Comment> selectAllByFeedId(Integer feedId);

	@Insert("""
			INSERT INTO Comment (feedId, content, memberId)
			VALUES (#{feedId}, #{content}, #{memberId})
			""")
	Integer insert(Comment comment);

	@Delete("""
			DELETE FROM Comment
			WHERE id = #{id}
			""")
	Integer deleteById();

}
