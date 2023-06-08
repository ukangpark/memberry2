package com.example.demo.controller;

import java.util.List;

import org.apache.ibatis.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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
	
	@DeleteMapping("id/{id}")
	public String remove(@PathVariable("id") Integer id) {
		service.remove(id);
		return "ok";
	}
}
