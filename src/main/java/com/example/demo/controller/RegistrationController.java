package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.domain.Registration;
import com.example.demo.service.RegistrationService;

@Controller
@RequestMapping("/")
public class RegistrationController {
	
	@Autowired
	private RegistrationService service;
	
	@GetMapping("/registration")
	public void registrationForm(Authentication auth, Model model) {
		model.addAttribute("auth", auth);
		
	}
	

	@PostMapping("/registration")
	public String addRegistration(@RequestParam("file") MultipartFile file, 
								Registration registration, RedirectAttributes rttr) throws Exception {
		System.out.println(registration);
		boolean ok = service.insert(registration, file);
		if (ok) {
			rttr.addFlashAttribute("message", registration.getPetName() + " 친구가 등록되었습니다.");
			rttr.addFlashAttribute("registration", registration);
			return "redirect:/petList";
		} else {
			rttr.addFlashAttribute("registration", registration);
			rttr.addFlashAttribute("message", "반려동물 등록에 실패하였습니다.");
			return "redirect:/registration";
		}
		
		
		
	}


}
