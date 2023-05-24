package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.service.MapService;

@Controller
@RequestMapping("bery")
public class MapController {
	
	@Autowired
	public MapService mapService;
	
	@GetMapping("mapMain")
	public void mapMain(ModelMap model) {
		String apiKey = mapService.getKakao_javaScript_key();
		model.addAttribute("apiKey", apiKey);
	}
	
	@GetMapping("mapMypage")
	public String method1() {
		return "bery/mapMypage";
		
	}
}
