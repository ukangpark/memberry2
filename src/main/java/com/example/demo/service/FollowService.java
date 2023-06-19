package com.example.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import com.example.demo.domain.Follow;
import com.example.demo.mapper.FollowMapper;

@Service
public class FollowService {

	@Autowired
	private FollowMapper followMapper;

	public Map<String, Object> follow(Follow follow, Authentication auth) {
		Map<String, Object> result = new HashMap<>();

		result.put("follow", false);

		Integer deleteCnt = followMapper.delete(follow);

		if (deleteCnt != 1) {
			Integer insertCnt = followMapper.insert(follow);
			result.put("follow", true);
		}

		// 팔로우 개수 넘겨줌
		Integer followerCount = followMapper.followerCountByfeedOwner(follow);
		result.put("followerNum", followerCount);

		// 팔로잉 개수 넘겨줌
		Integer followingCount = followMapper.followingCountBymemberId(follow);
		result.put("followingNum", followingCount);

		return result;
	}

	public List<Follow> followerlist(String feedOwner, Authentication authentication) {
		List<Follow> follower = followMapper.selectAllByFollower(feedOwner, authentication.getName());
		return follower;

	}
}
