package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.Comment;

@Mapper
public interface CommentMapper {

	
//	 @Select(""" 
//	 	SELECT c.*, m.nickName, m.defaultPetId
//	 	FROM Comment c LEFT JOIN Member m ON c.memberId = m.id
//	 	WHERE feedId = #{feedId} 
//	 	ORDER BY id DESC
//	 		""")
//	 List<Comment> selectAllByFeedId(Integer feedId);
	
	@Select("""
		SELECT 
			c.*, 
			m.nickName, 
			m.defaultPetId, 
			CONCAT('/', p.id, '/', p.photo) profileImage
		FROM Comment c LEFT JOIN Member m ON c.memberId = m.id
				LEFT JOIN Pet p ON m.defaultPetId = p.id
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
