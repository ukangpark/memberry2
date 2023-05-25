package com.example.demo.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.domain.Detail;
import com.example.demo.domain.Host;
import com.example.demo.service.PetsitterService;

@org.springframework.stereotype.Controller
@RequestMapping("petsitter")
public class PetsitterController {
	
	@Autowired
	private PetsitterService petsitterService;
	
	@GetMapping("detail")
	public void detail(@RequestParam("id") Integer boardId, Model model) {
		// 서비스에서 map으로 반환한 것을 담았음 
		Map<String, Object> info = petsitterService.selectById(boardId);
		
		model.addAllAttributes(info);		
	}
	
	@GetMapping("apply")
	public void applyForm() {
		
	}
	
	@PostMapping("apply")
	public void applyProcess() {
		
	}
	
	
}
