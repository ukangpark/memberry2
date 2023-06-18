package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.core.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Service
@Transactional(rollbackFor = Exception.class)
public class FeedLikeService {
	
	@Autowired
	private FeedLikeMapper likeMapper;
	
	@Autowired
	private AlarmMapper alarmMapper;

	public Map<String, Object> like(Like like, Authentication authentication) {
		Map<String, Object> result = new HashMap<>();
		
		result.put("like", false);
		
		like.setMemberId(authentication.getName());
		Integer deleteCnt = likeMapper.delete(like);
		
		if (deleteCnt != 1) {
			Integer insertCnt = likeMapper.insert(like);
			result.put("like", true);
			alarmMapper.likeAdd(like);
		}
		
		// 게시물 번호 기준으로 좋아요 개수 읽어내기
		Integer count = likeMapper.countByFeedId(like.getFeedId());
		result.put("count", count);
		
		return result;
	}
}
