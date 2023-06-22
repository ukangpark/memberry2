package com.example.demo.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import com.example.demo.domain.*;
import com.example.demo.service.*;

@Controller
@RequestMapping("qnaComment")
public class QnACommentController {

	@Autowired
	private QnACommentService service;
	
//	@PostMapping("add")
//	@ResponseBody
//	public String add(@RequestBody QnAComment qnacomment) {
//		
//		service.add(qnacomment);
//		
//		return "ok";
//	}
	
	@GetMapping("list")
	@ResponseBody
	public List<QnAComment> list(@RequestParam("qna") Integer qnaId){
		
		return service.list(qnaId);
	}
}
