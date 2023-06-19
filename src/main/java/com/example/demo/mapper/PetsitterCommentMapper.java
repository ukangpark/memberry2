package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface PetsitterCommentMapper {
	
	@Select("""
			SELECT pc.id, pc.detailId, pc.inserted, pc.memberId, m.defaultPetId, p.photo, pc.body
			FROM PetsitterComment pc LEFT JOIN Member m ON pc.memberId = m.id
									 LEFT JOIN Pet p ON m.defaultPetId = p.id
			WHERE detailId =  #{detailId}
			""")
	List<PetsitterComment> selectAllByDetailId(Integer detailId);
	
	@Insert("""
			INSERT INTO PetsitterComment 
				(detailId, body, memberId)
			VALUES
				(#{detailId}, #{body}, #{memberId})
			""")
	Integer add(PetsitterComment petsitterComment);
	
	@Delete("""
			DELETE FROM PetsitterComment WHERE id = #{commentId}
			""")
	Integer delete(Integer commentId);
	
	@Select("""
			SELECT * FROM PetsitterComment WHERE id = #{commentId}
			""")
	PetsitterComment selectCommentByCommentId(Integer commentId);
	
	@Update("""
			UPDATE PetsitterComment
			SET body = #{body}
			WHERE id = #{id}
			""")
	Integer updateComment(PetsitterComment petsitterComment);
	
}
