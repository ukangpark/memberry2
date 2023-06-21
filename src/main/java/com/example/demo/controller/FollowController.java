package com.example.demo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.domain.Follow;
import com.example.demo.security.LoginAuthenticationSuccessHandler;
import com.example.demo.service.FollowService;
import com.example.demo.service.MemberService;

import jakarta.servlet.http.HttpSession;

@Controller
public class FollowController {

	@Autowired
	private FollowService followService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
    private LoginAuthenticationSuccessHandler loginSuccessHandler;
	


	// follow
	@PostMapping("/follow/{userName}")
	public ResponseEntity<Map<String, Object>> follow(@RequestBody Follow follow,
			Authentication auth/* , HttpSession session */) {
		/*
		 * loginSuccessHandler.updateMemberInSession(memberService.get(follow.
		 * getFeedOwner()), session);
		 */
		return ResponseEntity.ok().body(followService.follow(follow, auth));
	}
	
	//followerList
	@GetMapping("/follower/list/{feedOwner}")
	@ResponseBody
	public List<Follow> followerList(@PathVariable("feedOwner") String feedOwner, Authentication authentication) {
		return followService.followerlist(feedOwner, authentication);
	}
	
	//followingList
	@GetMapping("/following/list/{feedOwner}")
	@ResponseBody
	public List<Follow> followingList(@PathVariable("feedOwner") String feedOwner, Authentication authentication) {
		return followService.followinglist(feedOwner, authentication);
	}
	
	

}
