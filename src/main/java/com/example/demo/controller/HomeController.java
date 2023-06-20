package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.domain.Alarm;
import com.example.demo.domain.Feed;
import com.example.demo.service.AlarmService;
import com.example.demo.service.HomeService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping({"/", "home"})
public class HomeController {

	@Autowired
	private HomeService service;
	
	@Autowired 
	private AlarmService alarmService;
	
	@GetMapping("")
	public String feed(Model model,
			Authentication authentication, HttpSession session) {
		List<Feed> result = service.listFeed(authentication);
		model.addAttribute("feedList", result);
		
		if (authentication != null) {
			List<Alarm> alarms = alarmService.list(authentication.getName());
			session.setAttribute("alarms", alarms);
		}
		return "home";
	}
	
	
	
}
