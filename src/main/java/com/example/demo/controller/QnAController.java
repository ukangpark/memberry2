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
@RequestMapping("qna")
public class QnAController {

	@Autowired
	private QnAService service;
	
	@GetMapping("")
	public String list(Model model) {
		
		List<QnA> list = service.qnaList();
		model.addAttribute("qnaList", list);
		return "qna";
	}
	
	@GetMapping("/id/{id}")
	public String qna(@PathVariable("id") Integer id, Model model) {
		QnA qna = service.getQnA(id);
		model.addAttribute("qna", qna);
		return "qnaforwhat";
	}
	
	@GetMapping("/modify/{id}")
	public String modifyForm(
							 @PathVariable("id") Integer id, Model model) {
		model.addAttribute("qna", service.getQnA(id));
		return "qnaModify";
	}
	
	@PostMapping("/modify/{id}")
	public String modifyProcess(QnA qna, 
								RedirectAttributes rttr) {

		boolean ok = service.modify(qna);
		
		if(ok) {
			rttr.addFlashAttribute("message", qna.getId() + "번 QnA가 수정되었습니다.");
			return "redirect:/qna/id/" + qna.getId();
		} else {
			rttr.addFlashAttribute("message", qna.getId() + "번 QnA가 수정되지 않았습니다.");
			return "redirect:/qna/modify/" + qna.getId();		
		}
	}
	
}
