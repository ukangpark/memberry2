package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.domain.Calendar;
import com.example.demo.service.CalendarService;

import org.springframework.ui.*;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("fullCalendar")
public class CalendarController {
	
	@Autowired
	private CalendarService service;

	//달력으로 이동
	@GetMapping("")
	public String getTest() {
		return "calendar";
	}
	
	@PostMapping("getAll")
	public String getall(Authentication authentication, Model model) {
		List<Calendar> schedules = service.getAllSchedule(authentication);
		/* String aa = schedules.get(0).getTitle(); */
		model.addAttribute("schedules", schedules);
		/* model.addAttribute("title", aa); */
		System.out.println(schedules);
		return "calendar";
	}
	


	

	
	
}
