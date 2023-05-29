package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.domain.Registration;
import com.example.demo.service.RegistrationService;

@Controller
@RequestMapping("/")
public class RegistrationController {
	
	@Autowired
	private RegistrationService service;
	
	@GetMapping("registration")
	public void registrationForm() {
		
	}
	
	@PostMapping("registration")
	public void addRegistration(Registration registration) {
		Integer cnt = service.insert(registration);
		
	}

}
