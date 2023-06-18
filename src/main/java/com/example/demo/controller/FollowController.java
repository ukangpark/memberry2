package com.example.demo.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.domain.Follow;
import com.example.demo.service.FollowService;

@Controller
public class FollowController {
	
	@Autowired
	private FollowService followService;
	
	// follow
		@PostMapping("/follow/{userName}")
		public ResponseEntity <Map<String,Object>> follow(@RequestBody Follow follow, Authentication auth) {
			
			return ResponseEntity
					.ok()
					.body(followService.follow(follow, auth));
			
		}

}
