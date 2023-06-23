package com.example.demo.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.access.prepost.*;
import org.springframework.security.core.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.*;

import com.example.demo.domain.*;
import com.example.demo.service.*;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("qna")
public class QnAController {

	@Autowired
	private QnAService service;
	@Autowired
	private AlarmService alarmService;
	
	@GetMapping("")
	public String list(Model model,
					   @RequestParam(value="page", defaultValue = "1") Integer page,
					   @RequestParam(value = "search", defaultValue = "") String search) {
		
		Map<String, Object> result = service.qnaList(page, search);
		model.addAllAttributes(result);

		return "qna";
	}
	
	@GetMapping("/id/{id}")
	public String qna(@PathVariable("id") Integer id, 
					  Model model,
					  Authentication authentication, HttpSession session) {
		QnA qna = service.getQnA(id, authentication);
		model.addAttribute("qna", qna);
		
		if (authentication != null) {
			List<Alarm> alarms = alarmService.list(authentication.getName());
			session.setAttribute("alarms", alarms);
			
		}
		return "qnaforwhat";
	}
	
	@GetMapping("/modify/{id}")
	@PreAuthorize("isAuthenticated() and @customSecurityChecker.checkQnAWriter(authentication, #id)")
	public String modifyForm(
							 @PathVariable("id") Integer id, Model model) {
		model.addAttribute("qna", service.getQnA(id));
		return "qnaModify";
	}
	
	@PostMapping("/modify/{id}")
	@PreAuthorize("isAuthenticated() and @customSecurityChecker.checkQnAWriter(authentication, #qna.id)")
	public String modifyProcess(QnA qna, 
								RedirectAttributes rttr) throws Exception{

		boolean ok = service.modify(qna);
		
		if(ok) {
			rttr.addFlashAttribute("message", qna.getId() + "번 QnA가 수정되었습니다.");
			return "redirect:/qna/id/" + qna.getId();
		} else {
			rttr.addFlashAttribute("message", qna.getId() + "번 QnA가 수정되지 않았습니다.");
			return "redirect:/qna/modify/" + qna.getId();		
		}
	}
	
	@PostMapping("remove")
	@PreAuthorize("(isAuthenticated() and @customSecurityChecker.checkQnAWriter(authentication, #id)) or hasAuthority('admin')")
	public String remove(@RequestParam Integer id, RedirectAttributes rttr) {
		boolean ok = service.remove(id);
		
		if(ok) {
			rttr.addFlashAttribute("message", id + "번 QnA가 삭제되었습니다.");
			return "redirect:/qna";
		} else {
			return "redirect:/qna/id/" + id;
		}
	}
	
	@GetMapping("add")
	@PreAuthorize("isAuthenticated()")
	public void addForm() {
		
	}
	
	@PostMapping("add")
	@PreAuthorize("isAuthenticated()")
	public String addProcess(QnA qna, RedirectAttributes rttr,
							Authentication auth) throws Exception{
		qna.setWriter(auth.getName());	
		System.out.println(qna);
	    boolean ok = service.addQnA(qna);
		
		if(ok) {
			rttr.addFlashAttribute("message", qna.getWriter() + "의 QnA가 등록되었습니다.");
			return "redirect:/qna/id/" + qna.getId();
		} else {
			rttr.addFlashAttribute("message", "QnA 등록 중 문제가 발생하였습니다.");
			rttr.addFlashAttribute("qna", qna);
			return "redirect:/qna/add";
		}
	}

}
