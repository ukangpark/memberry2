package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.Comment;

@Mapper
public interface CommentMapper {

	
	 @Select(""" 
	 	SELECT * 
	 	FROM Comment 
	 	WHERE feedId = #{feedId} 
	 	ORDER BY id DESC
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
	 Integer deleteById(Integer id);
	 
	 @Select(""" 
	 		SELECT * 
	 		FROM Comment 
	 		WHERE id = #{id} 
	 		""") 
	 Comment selectById(Integer id);
	 
	 @Update("""
	 		 UPDATE Comment 
	 		 SET 
	 		 	content = #{content}
	 		 WHERE id = #{id}
	 		  """)
	 Integer updateById(Comment comment);

	 @Delete("""
	 		DELETE FROM Comment
	 		WHERE feedId = #{feedId}
	 		""")
	Integer deleteByFeedID(Integer feedId);

	 @Delete("""
	 		DELETE FROM Comment
	 		WHERE memberId = #{memberId}
	 		""")
	Integer deleteByMemberID(String memberId);
	  
	  
	 
}
