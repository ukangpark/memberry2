package com.example.demo.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.core.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import com.example.demo.domain.*;
import com.example.demo.service.*;

@Controller
@RequestMapping({"/", "home"})
public class HomeController {

	@Autowired
	private HomeService service;
	
	@GetMapping("")
	public String feed(Model model,
			Authentication authentication) {
		List<Feed> result = service.listFeed(authentication);
		/* System.out.println(result.get(0).getLastCommentInserted()); */
		model.addAttribute("feedList", result);
		return "home";
	}
	
}
