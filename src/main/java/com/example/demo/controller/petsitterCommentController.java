package com.example.demo.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.access.prepost.*;
import org.springframework.security.core.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import com.example.demo.domain.*;
import com.example.demo.service.*;

@RestController
@RequestMapping("petsitterComment")
public class petsitterCommentController {
	
	@Autowired
	private PetsitterCommentService petsitterCommentService;
	
	@GetMapping("list")
	public List<PetsitterComment> list(@RequestParam("detailId") Integer detailId) {
		//해당 상세페이지의 후기를 조회함 
		return petsitterCommentService.list(detailId);
	}
	
	@PostMapping("add")
	@PreAuthorize("isAuthenticated()")
	public String add(@RequestBody PetsitterComment petsitterComment, Authentication authentication) {
		//후기 등록
		petsitterCommentService.add(petsitterComment, authentication);
		System.out.println("add controller : " + petsitterComment);
		return "ok";
	}
	
	@DeleteMapping("delete/{id}")
	@PreAuthorize("isAuthenticated()")
	public String delete(@PathVariable("id") Integer commentId) {
		//후기 삭제 
		petsitterCommentService.delete(commentId);
		
		return "ok";
	}
	
	@GetMapping("get/{id}")
	public PetsitterComment modify(@PathVariable("id") Integer commentId) {
		PetsitterComment petsitterComment = petsitterCommentService.selectComment(commentId);
		System.out.println(petsitterComment);
		return petsitterComment;
	}
	
	@PutMapping("modify")
	@PreAuthorize("isAuthenticated()")
	public String modify(@RequestBody PetsitterComment petsitterComment, Authentication authentication) {
		petsitterCommentService.modifyComment(petsitterComment, authentication);
		System.out.println("controller : " + petsitterComment);
		return "ok";
	}
} 
