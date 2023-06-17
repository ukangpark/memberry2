package com.example.demo.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.example.demo.domain.Follow;


@Mapper
public interface FollowMapper {
	
	@Insert("""
			INSERT INTO Follow
				VALUES (#{feedId}, #{memberId})
			""")
	Integer insert(Follow follow);



}
