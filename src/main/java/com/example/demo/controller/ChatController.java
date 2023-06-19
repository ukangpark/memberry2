package com.example.demo.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ChatController {
	
	@RequestMapping("/chat/chatRoom")
	public ModelAndView chatRoom() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("chat/chatRoom");
		return mv;
	}
}
