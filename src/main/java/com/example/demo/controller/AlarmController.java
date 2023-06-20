package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.domain.Alarm;
import com.example.demo.service.AlarmService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("alarm")
public class AlarmController {
	@Autowired
	private AlarmService service;
	
	
	@GetMapping("check/{id}")
	@ResponseBody
	public Boolean checked(@PathVariable("id") Integer id) {
		System.out.println("컨트롤러로 요청옴");
		return service.checked(id);
	}
}
