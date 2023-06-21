package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface PetsitterCommentMapper {
	
	@Select("""
			SELECT pc.id, pc.detailId, pc.inserted, pc.memberId, m.defaultPetId, p.photo, pc.body, r.star
			FROM PetsitterComment pc LEFT JOIN Member m ON pc.memberId = m.id
									 LEFT JOIN Pet p ON m.defaultPetId = p.id
                                     LEFT JOIN Rating r ON r.commentId = pc.id
			WHERE pc.detailId =  #{detailId}
			""")
	List<PetsitterComment> selectAllByDetailId(Integer detailId);
	
	@Insert("""
			INSERT INTO PetsitterComment 
				(detailId, body, memberId)
			VALUES
				(#{detailId}, #{body}, #{memberId})
			""")
	@Options(useGeneratedKeys = true, keyProperty = "id")
	Integer add(PetsitterComment petsitterComment);
	
	@Delete("""
			DELETE FROM PetsitterComment WHERE id = #{commentId}
			""")
	Integer delete(Integer commentId);
	
	@Select("""
			SELECT pc.id, detailId, body, inserted, memberId, r.star 
			FROM PetsitterComment pc JOIN Rating r ON pc.id = r.commentId 
			WHERE pc.id = #{commentId};
			""")
	PetsitterComment selectCommentByCommentId(Integer commentId);
	
	@Update("""
			UPDATE PetsitterComment
			SET body = #{body}
			WHERE id = #{id}
			""")
	Integer updateComment(PetsitterComment petsitterComment);

	@Insert("""
			INSERT INTO Rating
				(star, commentId, detailId)
			VALUES
				(#{star}, #{commentId}, ${detailId})
			""")
	Integer addStar(Integer star, Integer commentId, Integer detailId);
	
	@Update("""
			UPDATE Rating
			SET star = #{star}
			WHERE commentId = #{id}
			""")
	Integer updateStar(PetsitterComment petsitterComment);
	
	@Delete("""
			DELETE FROM Rating WHERE commentId = #{commentId}
			""")
	int deleteStar(Integer commentId);
	
}
