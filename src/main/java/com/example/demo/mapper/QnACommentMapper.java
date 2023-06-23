package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface QnACommentMapper {

	@Select("""
			SELECT *
			FROM QnAComment
			WHERE qnaId = #{qnaId}
			ORDER BY id
			""")
	List<QnAComment> selectAllByQnAId(Integer qnaId);

	@Insert("""
			INSERT INTO QnAComment(qnaId, content, memberId)
			VALUES(#{qnaId}, #{content}, #{memberId})
			""")
	Integer insert(QnAComment qnacomment);

	@Delete("""
			DELETE FROM QnAComment
			WHERE id = #{id}
			""")
	Integer deleteById(Integer id);

	@Select("""
			SELECT *
			FROM QnAComment
			WHERE id = #{id}
			""")
	QnAComment selectById(Integer id);

	@Update("""
			UPDATE QnAComment 
			SET content = #{content}
			WHERE id = #{id} 
			""")
	Integer update(QnAComment qnacomment);

	
	@Delete("""
			DELETE FROM QnAComment
			WHERE qnaId = #{qnaId}
			""")
	Integer deleteByQnAId(Integer qnaId);
	
	
	
}
