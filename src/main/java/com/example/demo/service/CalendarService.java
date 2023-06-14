package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.*;

import com.example.demo.domain.*;
import com.example.demo.domain.Calendar;
import com.example.demo.mapper.*;

@Service("calenarService")
public class CalendarService {

	@Autowired 
	private CalendarMapper mapper;

	@Autowired
	private CalendarDao calendardao;
	
	public List<Calendar> getCalendar() throws Exception {
		return calendardao.getCalendar();
	}

	public Arrays getAllSchedule(Authentication authentication) {
		return mapper.selectAllByMemberId(authentication.getName());
		
	}
	

	
	


}
