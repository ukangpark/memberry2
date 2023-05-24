package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.domain.Feed;
import com.example.demo.service.MyFeedService;

@Controller
@RequestMapping("/")
public class MyFeedController {
	
	@Autowired
	private MyFeedService service;

	@GetMapping("feedAdd")
	public void addForm() {
		// 게시물 작성 form(view)로 포워드
	}
	
	@PostMapping("feedAdd")
	public void addProcess(Feed feed) {
		// 새 게시물 DB에 추가
		boolean ok = service.addFeed(feed);
		if (ok) {
			
		} else {
			
		}
	}
	
}
