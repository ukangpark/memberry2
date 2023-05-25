package com.example.demo.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.web.servlet.mvc.support.*;

import com.example.demo.domain.*;
import com.example.demo.service.*;

@Controller
@RequestMapping("/")
public class MyFeedController {
	
	@Autowired
	private MyFeedService service;

	// 게시물 목록
	@GetMapping({"/", "myFeed"})
	public String myFeed(Model model) {
		List<Feed> myFeed = service.listMyFeed();
		model.addAttribute("myFeedList", myFeed);
		
		return "myFeed";
	}
	
	@GetMapping("feedAdd")
	public void addForm() {
		// 게시물 작성 form(view)로 포워드
	}
	
	@PostMapping("feedAdd")
	public String addProcess(@RequestParam("files") MultipartFile[] files,
			Feed feed, RedirectAttributes rttr) throws Exception {
		// 새 게시물 DB에 추가
		boolean ok = service.addFeed(feed, files);
		if (ok) {
			// 추가가 잘 되었으면 게시판으로 이동
			return "redirect:/myFeed";
		} else {
			return "redirect:/feedAdd";
		}
	}
	
	// 클릭한 게시물 보기
	@GetMapping("/id/{id}")
	public String feed(@PathVariable("id") Integer id, Model model) {
		Feed feed = service.getFeed(id);
		model.addAttribute("feed", feed);
		
		return "feedGet";
	}
	
}
