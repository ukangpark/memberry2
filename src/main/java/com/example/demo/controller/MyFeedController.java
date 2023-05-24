package com.example.demo.controller;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/")
public class MyFeedController {

	@GetMapping("add")
	public void addForm() {
		// 게시물 작성 form(view)로 포워드
	}
	
	@PostMapping("add")
	public String addProcess() {
		
	}
	
}
