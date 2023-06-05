package com.example.demo.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.*;

import com.example.demo.domain.*;
import com.example.demo.service.*;


@Controller
@RequestMapping("book")
public class BookController {
	
	@Autowired
	private BookService service;
	

	//예약목록(마이페이지완성되면 이동예정), 페이지네이션
	@GetMapping("list")
	public String bookList(Model model,
			@RequestParam(value="page", defaultValue="1") Integer page) {
		Map<String, Object> result = service.bookList(page);
		model.addAllAttributes(result);
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
	public String modifyForm(@PathVariable("num") Integer id, Model model) {
		model.addAttribute("book", service.getBook(id));
		return "book/regiFormModify";
	}
	
	// 수정되게
	@PostMapping("/modifiy/{num}")
	public String modifyProcess(Book book, RedirectAttributes rttr) {
		boolean ok = service.modify(book);
		
		if(ok) {
			
			rttr.addAttribute("success", "success");
			return "redirect:/num/" + book.getNum();
			
		} else {
			
			rttr.addAttribute("fail", "fail");
			return "redirect:/regiFormModify/" + book.getNum();
			
		}
	}
	
}
