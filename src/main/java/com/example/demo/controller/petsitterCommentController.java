package com.example.demo.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.access.prepost.*;
import org.springframework.security.core.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import com.example.demo.domain.*;
import com.example.demo.service.*;

@Controller
@RequestMapping("petsitterComment")
public class petsitterCommentController {
	
	@Autowired
	private PetsitterCommentService petsitterCommentService;
	
	@GetMapping("list")
	@ResponseBody
	public List<PetsitterComment> list(@RequestParam("detailId") Integer detailId) {
		//해당 상세페이지의 후기를 조회함 
		return petsitterCommentService.list(detailId);
	}
	
	@PostMapping("add")
	@ResponseBody
	@PreAuthorize("isAuthenticated()")
	public String add(@RequestBody PetsitterComment petsitterComment, Authentication authentication) {
		//후기 등록
		petsitterCommentService.add(petsitterComment, authentication);
		
		return "ok";
	}
	
	@DeleteMapping("delete/{id}")
	@PreAuthorize("isAuthenticated()")
	public String delete(@PathVariable("id") Integer commentId, Authentication authentication) {
		//후기 삭제 
		petsitterCommentService.delete(commentId, authentication);
		
		return "ok";
	}
	
} 
