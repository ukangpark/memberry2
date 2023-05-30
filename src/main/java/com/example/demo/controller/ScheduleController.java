package com.example.demo.controller;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("")
public class ScheduleController {
	@GetMapping("schedule")
	public String get() {
		return "schedule";
	}
	
	@PostMapping("schedule/addSchedule")
	public String addSchedule() {
		return "addSchedule";
	}
	
	@GetMapping("toDoList")
	public String toDoList() {
		return "toDoList";
	}
}
