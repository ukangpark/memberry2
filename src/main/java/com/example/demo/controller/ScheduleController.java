package com.example.demo.controller;

import java.util.*;

import org.mybatis.logging.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import com.example.demo.domain.*;
import com.example.demo.service.*;
import com.fasterxml.jackson.databind.util.*;

import lombok.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("")
public class ScheduleController {
	
	@Autowired
	private ScheduleService service;
	
	private static final Logger log = LoggerFactory.getLogger(ScheduleController.class);
	

	//일정 관리 달력으로 이동
	@GetMapping("schedule")
	public String get() {
		return "schedule";
	}
	//테스트 일정 관리 달력으로 이동
	@GetMapping("fullCalendar")
	public String getTest() {
		return "testCalendar";
	}
	// to do list로 이동
	@GetMapping("toDoList")
	public String toDoList() {
		return "toDoList";
	}
	
	@PostMapping("schedule/addSchedule")
	@ResponseBody
	public String addSchedule(Schedule schedule) {
		service.addSchedule(schedule);
		return "ok";
	}
	
	
}
