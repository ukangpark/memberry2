package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.domain.Comment;
import com.example.demo.service.CommentService;

@Controller
@RequestMapping("comment")
public class CommentController {
	
	@Autowired
	private CommentService service;
	
	
	@GetMapping("")
	public String comment () {
		return "comment";
	}
		
	@GetMapping("list")
	@ResponseBody
	public List<Comment> list(@RequestParam("feed") Integer feedId) {
		return service.list(feedId);
	}
	
	@PostMapping("add")
	@ResponseBody
	public String add(@RequestBody Comment comment) {
		service.add(comment);
		
		return "ok";
	}

}
