package com.example.demo.controller;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("comment")
public class CommentController {
	
	
		@GetMapping("")
		public String comment () {
			return "comment";
		}

}
