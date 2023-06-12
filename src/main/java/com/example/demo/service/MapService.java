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

	// 찜 목록 가져오기, 페이지네이션
	public Map<String, Object> likePlace(Integer page, String userId) {
			
			Integer rowPerPage = 5;
			
			Integer startIndex = (page-1) * rowPerPage;
			
			Integer numOfRecords =mapper.countAll(userId);
			// 마지막 페이지 번호
			Integer lastPageNumber = (numOfRecords-1) / rowPerPage +1;
			
			// 페이지네이션 왼쪽 번호
			Integer leftPageNum = page - 5;
			// 1보다 작을 수 없음
			leftPageNum = Math.max(leftPageNum, 1);
			
			// 페이지네이션 오른쪽 번호
			Integer rightPageNum = leftPageNum +9;  
			// 마지막 페이지보다 클 수 없음
			rightPageNum = Math.min(rightPageNum, lastPageNumber);
			
			Map<String, Object> pageInfo = new HashMap<>();
			pageInfo.put("rightPageNum", rightPageNum);
			pageInfo.put("leftPageNum", leftPageNum);
			pageInfo.put("currentPageNum", page);
			pageInfo.put("lastPageNum", lastPageNumber);
			
		List<Place> list = mapper.selectLikePlace(startIndex, rowPerPage, userId);
		return Map.of("mapList", list,
					   "pageInfo", pageInfo);
	}
	


}
