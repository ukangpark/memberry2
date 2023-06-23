package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.domain.Feed;
import com.example.demo.domain.Search;
import com.example.demo.service.SearchService;

@Controller
@RequestMapping("/search")
public class SearchController {

	@Autowired
	private SearchService service;
	
	@GetMapping("")
	public void searchForm() {
		
	}
	
	@GetMapping("/text")
	public String searchProcess(@RequestParam("search") String search, Model model) {
		//System.out.println(search);
		List<Search> searchResult = service.search(search);
		//System.out.println(searchResult);
		
		model.addAttribute("search", searchResult);
		
		return "search";
	}
}
