package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;

import com.example.demo.domain.Feed;
import com.example.demo.mapper.MyFeedMapper;

@Controller
@RequestMapping("myFeed")
public class MyFeedController {

	@Autowired
	private MyFeedMapper mapper;
	
	@GetMapping("")
	
	// 나의 피드
	@PostMapping({""})
	public String list(@RequestParam("file") MultipartFile myfile) {
		
		List<Feed> list = mapper.selectAll();
		model.addAttribute("feedList", list);
		System.out.println(list.size());
		return "list";
	}
}
