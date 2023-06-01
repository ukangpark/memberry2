package com.example.demo.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import com.example.demo.domain.Calendar;
import com.example.demo.service.*;

import lombok.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("")
public class CalendarController {
	
	@Autowired
	private CalendarService service;
	

	

	//일정 관리 달력으로 이동
	@GetMapping("schedule")
	public String get() {
		return "schedule";
	}
	//테스트 일정 관리 달력으로 이동
	@GetMapping("fullCalendar")
	public String getTest() {
		return "calendar";
	}
	// to do list로 이동
	@GetMapping("toDoList")
	public String toDoList() {
		return "toDoList";
	}
	
	@PostMapping(value = "/schedule/add")
	public String addSchedule() {
		Map<String, Calendar> map = new HashMap<>();
		
		map.put("event1", ("db이벤트1", "2023-12-11", "2023-12-12"));
		map.put("event2", new Calendar());
	}
	

	
	
}
