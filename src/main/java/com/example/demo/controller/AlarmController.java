package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.domain.Member;
import com.example.demo.service.AlarmService;
import com.example.demo.service.MemberService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("alarm")
public class AlarmController {
	@Autowired
	private AlarmService service;
	@Autowired
	private MemberService memberService;
	
	@GetMapping("check")
	@ResponseBody
	public void checked(@RequestParam("id") Integer id, 
			Authentication authentication, HttpSession session) {
		Integer cnt = service.checked(id);
		if (cnt == 1 ) {
			//알림 확인시 개수 새로고침
			Member member = memberService.get(authentication.getName());		
			session.setAttribute("logedInMember", member);
		}
		
	}
}
