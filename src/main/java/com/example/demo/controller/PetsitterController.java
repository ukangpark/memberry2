package com.example.demo.controller;

import org.springframework.web.bind.annotation.*;

@org.springframework.stereotype.Controller
@RequestMapping("/bery/petsitter")
public class PetsitterController {
	
	//메인페이지 (로고 & 서치바 & 이미지 슬라이더)
	@GetMapping("slider")
	public void slider() {
		
	}
	
	@RequestMapping("mapTest")
	public void map() {
		
	}
	
	@RequestMapping("main")
	public void main() {
		
	}
	
	@RequestMapping("petsitterDetail")
	public void petsitter() {
		
	}
	
	@RequestMapping("testCalendar")
	public void test() {
		 
	}
}
