package com.example.demo.controller;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping({"/", "home"})
public class HomeController {

	@GetMapping("")
	public String home() {
		return "home";
	}
	
}
