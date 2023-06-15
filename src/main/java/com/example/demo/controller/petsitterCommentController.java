package com.example.demo.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
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
		
		return petsitterCommentService.list(detailId);
	}
	
	@PostMapping("add")
	@ResponseBody
	public String add(@RequestBody PetsitterComment petsitterComment, Authentication authentication) {
		
		petsitterCommentService.add(petsitterComment, authentication);
		
		return "ok";
	}
} 
