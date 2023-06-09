package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.core.*;
import org.springframework.stereotype.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Service
public class HomeService {

	@Autowired
	private HomeMapper mapper;
	
	@Autowired
	private FeedLikeMapper likeMapper;
	
	public List<Feed> listFeed(Authentication authentication) {
		List<Feed> list = mapper.selectAll();
			
		// 현재 로그인 한 사람이 이 게시물에 좋아요 했는지 여부 쿼리로 가져오기
		if (authentication != null) {
			List<Like> like = mapper.select(authentication.getName());
			
			for (Feed feed : list) {
				for (Like l : like) {
					if (feed.getId().equals(l.getFeedId())) {
						feed.setLiked(true);
					}
				}
			}
		}
		return list;
	}
	
}
