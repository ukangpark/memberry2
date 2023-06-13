package com.example.demo.controller;

import java.time.LocalDate;
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

	//달력으로 이동
	@GetMapping("fullCalendar")
	public String getTest() {
		return "calendar";
	}
	
	@PostMapping("getAll")
	public void getall() {
		Map<String, Calendar> cal = new HashMap<>();
		
		LocalDate date1 = LocalDate.of(2023, 05, 01);
		LocalDate date2 = LocalDate.of(2023, 05, 26);
		
		Calendar calender = new Calendar();
		calender.setTitle("event1");
		calender.setStart(date1);
		calender.setEnd(date2);
		cal.put("ev1", calender);
		
		
	}
	


	

	
	
}
