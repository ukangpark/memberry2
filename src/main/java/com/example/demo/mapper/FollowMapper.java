package com.example.demo.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.domain.Follow;


@Mapper
public interface FollowMapper {
	
	@Insert("""
			INSERT INTO Follow
				VALUES (#{feedOwner}, #{memberId})
			""")
	Integer insert(Follow follow);

	@Delete("""
			DELETE FROM Follow
				WHERE feedOwner = #{feedOwner}
					AND memberId = #{memberId}
			""")
	Integer delete(Follow follow);

	@Select("""
			SELECT COUNT(*) FROM Follow
			WHERE feedOwner = #{feedOwner}
					AND memberId = #{memberId}
			""")
	Integer countByfeedId(Follow follow);


	@Select("""
			SELECT * FROM Follow
			WHERE feedOwner = #{feedOwner}
					AND memberId = #{memberId}
			""")
	Follow select(String feedOwner, String memberId);



}
