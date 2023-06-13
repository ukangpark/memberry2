package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface MapMapper {

	// 찜 장소 중복확인
	@Select("""
			SELECT COUNT (*) FROM MapList
			WHERE memberId = #{userId}
			AND address = #{address}
			""")
	int selectMapList(String userId, String address);

	// 찜 장소 추가
	@Insert("""
			INSERT INTO MapList (name, address, phone, url, memberId)
			VALUES(#{name}, #{address}, #{phone}, #{url}, #{memberId})
			""")
	void insertMapList(Place place);

	//찜 목록 가져오기
	@Select("""
			SELECT * FROM MapList
			WHERE memberId = #{userId}
			ORDER BY id DESC
			LIMIT #{startIndex}, #{rowPerPage}
			""")
	List<Place> selectLikePlace(Integer startIndex, Integer rowPerPage, String userId);

	@Select("""
			SELECT COUNT(*)
			FROM MapList
			WHERE memberId = #{userId}
			""")
	Integer countAll(String userId);


	

}
