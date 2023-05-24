package com.example.demo.controller;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/")
public class HomeController {

	@GetMapping("/home")
	public String home() {
		return "home";
	}
	@GetMapping("schedule")
	public String getSchedule() {
		return "schedule";
	}
}
