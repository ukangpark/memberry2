package com.example.demo.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import com.example.demo.domain.Book;
import com.example.demo.service.*;


@Controller
@RequestMapping("book")
public class BookController {
	
	@Autowired
	private BookService service;
	

	//예약목록(마이페이지완성되면 이동예정)
	@GetMapping("list")
	public String bookList(Model model) {
		List<Book> list = service.bookList();
		model.addAttribute("bookList", list);
		return "book/myPageTest";
	}
	
	// 예약페이지 뜨게
	@GetMapping("/num/{num}")
	public String bookList(@PathVariable("num") Integer id, Model model) {
		Book book = service.getBook(id);
		model.addAttribute("book", book);
		return "book/getBook";
	}
	
	
	// 예약수정
	@GetMapping("/modify/{num}")
	public String modifyForm(@PathVariable("id") Integer id, Model model) {
		model.addAttribute("book", service.getBook(id));
		return "book/regiFormModify";
	}

}
