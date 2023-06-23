package com.example.demo.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.security.core.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import com.example.demo.domain.*;
import com.example.demo.service.*;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/")
public class FeedLikeController {

	@Autowired
	private FeedLikeService likeService;
	
	@PostMapping("/like")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> like(
			@RequestBody Like like,
			Authentication authentication) {
		
		if (authentication == null) {
			return ResponseEntity
					.status(403)
					.body(Map.of("message", "로그인 후 좋아요 클릭 가능합니다."));
		} else {
			
			return ResponseEntity
					.ok()
					.body(likeService.like(like, authentication));
		}
		
	}
}
