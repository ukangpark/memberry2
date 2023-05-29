package com.example.demo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.domain.Detail;
import com.example.demo.domain.Host;
import com.example.demo.service.PetsitterService;

@Controller
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
	
	@GetMapping("list")
	public String petsitterList(Model model) {
		List<Host> list = petsitterService.listHost();
		model.addAttribute("petsitterList", list);
		
		return "petsitter/list";
	}
	
	
	@PostMapping("regiForm")
	public String regiForm() {
		return "petsitter/regiForm";
	}
	
	
}
