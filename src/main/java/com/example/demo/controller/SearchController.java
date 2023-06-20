package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.domain.Feed;
import com.example.demo.service.SearchService;

@Controller
public class SearchController {

	@Autowired
	private SearchService service;
	
	@GetMapping("/search")
	public void searchForm() {
		
	}
	
	@PostMapping("/search")
	public void searchProcess(@RequestParam("search") String search, 
							@RequestParam("title") String title,
							Model model) {
		//System.out.println(search + title);
		List<Feed> searchResult = service.search(search, title);
	}
}
