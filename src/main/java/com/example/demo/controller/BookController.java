package com.example.demo.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.core.*;
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

	// 사용자가 보는 예약목록(마이페이지완성되면 이동예정), 페이지네이션
	@GetMapping("list")
	public String bookList(Model model,  Authentication authentication,
			@RequestParam(value = "page", defaultValue = "1") Integer page) {
		 String userId = authentication.getName(); //인증서에 저장된 아이디 값 가져오기

		Map<String, Object> result = service.bookList(page,userId);

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

		if (ok) {

			rttr.addAttribute("success", "success");
			return "redirect:/num/" + book.getNum();

		} else {

			rttr.addAttribute("fail", "fail");
			return "redirect:/regiFormModify/" + book.getNum();

		}
	}

	// 호스트가 보는 예약목록, 페이지네이션
	@GetMapping("list/host")
	public String bookListHost(Model model, Authentication authentication,
			@RequestParam(value = "page", defaultValue = "1") Integer page) {

		 String userId = authentication.getName();
		Map<String, Object> result = service.bookList(page,userId);

		model.addAllAttributes(result);
		return "book/regiListHost";
	}
	
	// 호스트 예약 승인
	@PostMapping("accept")
	@ResponseBody
	public void bookAccept(@RequestBody int num) {
		service.bookAccept(num);
	}
	
	// 예약신청서 
	@GetMapping("regiForm/{id}")
	public String addRegi(@PathVariable("id") Integer id, Model model, Authentication authentication) {
		String userId = authentication.getName();
		Registration pet = service.getPet(userId);
		model.addAttribute("pet", pet);
		return "book/regiForm";
	
	}
	


	// 예약추가
	@PostMapping("bookAdd")
	public String addRegi(Book book, RedirectAttributes rttr) {

		
		// db에 추가
//		boolean ok = service.addRegi(book);
//		if(ok) {
//			return "redirect:/list";
//		} else {
			return "redirect:/book/regiForm";
//		}
	}

}
