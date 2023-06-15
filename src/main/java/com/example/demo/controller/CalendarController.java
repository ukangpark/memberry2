package com.example.demo.controller;

import java.lang.reflect.Array;
import java.time.LocalDate;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import com.example.demo.domain.Calendar;
import com.example.demo.service.*;

import lombok.*;

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
	public Arrays getall(Authentication authentication) {
		 return service.getAllSchedule(authentication);
		
	}
	


	

	
	
}
