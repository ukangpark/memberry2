package com.example.demo.controller;

import java.util.*;

import org.apache.ibatis.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
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
	public ResponseEntity<Map<String, Object>> add(@RequestBody Comment comment) {
		Map<String, Object> res = service.add(comment);
		
		return ResponseEntity.ok().body(res);
	}
	
	@DeleteMapping("id/{id}")
	public ResponseEntity<Map<String, Object>> remove(@PathVariable("id") Integer id) {
		Map<String, Object> res = service.remove(id);
		return ResponseEntity.ok().body(res);
	}
	
	@PutMapping("update")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> update(Comment comment) {
		Map<String, Object> res = service.update(comment);
		return ResponseEntity.ok().body(res);
	}
}
