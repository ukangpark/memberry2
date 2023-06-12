package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Service
public class MapService {
	
	@Autowired 
	private MapMapper mapper;
	
	@Value("${kakao-javaScript-key}")
	private String kakao_javaScript_key;

	public String getKakao_javaScript_key() {
		return kakao_javaScript_key;
	}

	public void setKakao_javaScript_key(String kakao_javaScript_key) {
		this.kakao_javaScript_key = kakao_javaScript_key;
	}

	// 찜한 장소 중복확인
	public int selectMapList(String userId, String address) {
		return mapper.selectMapList(userId, address);
	}

	// 찜한 장소 추가
	public void insertMapList(Place place) {
		mapper.insertMapList(place);
	}

	// 찜 목록 가져오기
	public Map<String, Object> likePlace(String userId) {
		List<Place> list = mapper.selectLikePlace(userId);
		return Map.of("mapList", list);
	}
	


}
