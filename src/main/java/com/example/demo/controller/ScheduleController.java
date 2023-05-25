package com.example.demo.controller;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("schedule")
public class ScheduleController {
	@GetMapping("")
	public String get() {
		return "schedule";
	}
}
