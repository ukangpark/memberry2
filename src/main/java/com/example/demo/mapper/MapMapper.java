package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface MapMapper {

	// 찜 장소 중복확인
	@Select("""
			SELECT COUNT (*) FROM Maplist
			WHERE memberId = #{userId}
			AND address = #{address}
			""")
	int selectMapList(String userId, String address);

	// 찜 장소 추가
	@Insert("""
			INSERT INTO Maplist (name, address, phone, url, memberId)
			VALUES(#{name}, #{address}, #{phone}, #{url}, #{memberId})
			""")
	void insertMapList(Place place);

	//찜 목록 가져오기
	@Select("""
			SELECT * FROM Maplist
			WHERE memberId = #{userId}
			""")
	List<Place> selectLikePlace(String userId);


	

}
