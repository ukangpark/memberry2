package com.example.demo.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import com.example.demo.domain.*;
import com.example.demo.service.*;

@Controller
@RequestMapping("home")
public class HomeController {

	@Autowired
	private HomeService service;
	
	@GetMapping("")
	public String feed(Model model) {
		List<Feed> result = service.listFeed();
		model.addAttribute("feedList", result);
		return "home";
	}
	
	
	
	
}
