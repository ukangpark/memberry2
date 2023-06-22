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
	
	@PutMapping("update")
	@ResponseBody
	public String update(@RequestBody QnAComment qnacomment) {
		service.update(qnacomment);
		
		return "ok";
	}
	
	@GetMapping("id/{id}")
	@ResponseBody
	public QnAComment get(@PathVariable("id") Integer id) {
		return service.get(id);
	}
	
	@DeleteMapping("id/{id}")
	@ResponseBody
	public String remove(@PathVariable("id") Integer id) {
		service.remove(id);
		
		return "ok";
	}
	
	@PostMapping("add")
	@ResponseBody
	public String add(@RequestBody QnAComment qnacomment) {
		
		service.add(qnacomment);
		
		return "ok";
	}
	
	@GetMapping("list")
	@ResponseBody
	public List<QnAComment> list(@RequestParam("qna") Integer qnaId){
		
		return service.list(qnaId);
	}
}
