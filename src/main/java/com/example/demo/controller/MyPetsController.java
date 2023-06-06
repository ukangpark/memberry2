package com.example.demo.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.domain.Registration;
import com.example.demo.service.MyPetsService;

@Controller
@RequestMapping("/")
public class MyPetsController {
	
	@Autowired
	private MyPetsService service;
	
	@GetMapping("myPetList")
	public void list (Model model) {
		
		Map<String, Object> list = service.petsList();
		
		System.out.println(list);
		
		model.addAllAttributes(list);
		
	}
	
	@GetMapping("/id/{id}")
	public String myPet (@PathVariable("id") Integer id, Model model) {
		Registration registration = service.getPet(id);
		System.out.println(registration);
		model.addAttribute("pet",registration);
		return "pet";
		
	}

}
