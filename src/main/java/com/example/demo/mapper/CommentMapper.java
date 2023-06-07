package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

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

}
