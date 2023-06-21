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

	@Delete("""
			DELETE FROM QnA
			WHERE id = #{id}
			""")
	int deleteById(Integer id);

	@Insert("""
			INSERT INTO QnA (title, body, writer)
			VALUES (#{title}, #{body}, #{writer})
			""")
	@Options(useGeneratedKeys = true, keyProperty = "id")
	int insert(QnA qna);
}
