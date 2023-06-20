package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface QnAMapper {
	@Select("""
			SELECT id,
			       title,
			       writer,
			       inserted
			FROM QnA
			ORDER BY inserted DESC
			""")
	List<QnA> selectAll();

	@Select("""
			SELECT *
			FROM QnA
			WHERE id = #{id}
			""")
	QnA selectById(Integer id);

	@Update("""
			UPDATE QnA
			SET title = #{title},
			    body = #{body},
			    writer = #{writer}
			WHERE id = #{id}
			""")
	int update(QnA qna);
}
