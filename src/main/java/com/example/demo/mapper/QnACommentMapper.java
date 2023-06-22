package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface QnACommentMapper {

	@Select("""
			SELECT *
			FROM QnA
			WHERE id = #{id}
			""")
	List<QnAComment> selectAllByQnAId(Integer id);

	@Insert("""
			INSERT INTO QnAComment(qnaId, content, memberId)
			VALUES(#{qnaId}, #{content}, #{memberId})
			""")
	Integer insert(QnAComment qnacomment);
	
	
	
}
