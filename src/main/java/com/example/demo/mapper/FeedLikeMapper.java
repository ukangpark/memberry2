package com.example.demo.mapper;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface FeedLikeMapper {
	@Insert("""
			INSERT INTO FeedLike
			VALUES (#{feedId}, #{memberId})
			""")
	Integer insert(Like like);

	@Delete("""
			DELETE FROM FeedLike
			WHERE feedId = #{feedId}
			  AND memberId = #{memberId}
			""")
	Integer delete(Like like);
}
