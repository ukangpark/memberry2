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

	@Select("""
			SELECT COUNT(*) 
			FROM FeedLike
			WHERE feedId = #{feedId}
			""")
	Integer countByFeedId(Integer feedId);

	@Select("""
			SELECT *
			FROM FeedLike
			WHERE feedId = #{feedId}
			  AND memberId = #{memberId}
			""")
	Like select(Integer feedId, String memberId);

	@Delete("""
			DELETE FROM FeedLike
			WHERE feedId = #{feedId}
			""")
	void deleteByFeedId(Integer feedId);

	@Delete("""
			DELETE FROM FeedLike
			WHERE memberId = #{memberId}
			""")
	void deleteByMemberId(String memberId);

}
