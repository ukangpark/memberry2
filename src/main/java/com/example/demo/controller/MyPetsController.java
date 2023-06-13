package com.example.demo.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.domain.Like;
import com.example.demo.domain.Member;
import com.example.demo.domain.Registration;
import com.example.demo.service.MemberService;
import com.example.demo.service.MyPetsService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/")
public class MyPetsController {

	@Autowired
	private MyPetsService service;
	
	@Autowired
	private MemberService memberService;

	// 나의반려동물 리스트 보기
	@GetMapping("myPets/petList")
	@PreAuthorize("isAuthenticated()")
	public void list(Model model, Authentication auth) {

		Map<String, Object> list = service.petsList(auth);

		model.addAllAttributes(list);

	}

	// 펫 정보 보기
	@GetMapping("/id/{id}")
	public String myPet(@PathVariable("id") Integer id, Model model) {
		Registration registration = service.getPet(id);
		model.addAttribute("pet", registration);
		return "myPets/pet";

	}

	// 펫 정보 수정 전 조회
	@GetMapping("/petModify/{id}")
	public String modify(@PathVariable("id") Integer id, Model model) {
		model.addAttribute("pet", service.getPet(id));
		return "myPets/petModify";

	}

	// 펫 정보 수정
	@PostMapping("/petModify/{id}")
	// @PreAuthorize("isAuthenticated() and
	// @customSecurityChecker.checkBoardWriter(authentication, #id)")
	public String modifyProcess(Registration registration,
			@RequestParam(value = "file", required = false) MultipartFile addFile, RedirectAttributes rttr)
			throws Exception {
		boolean ok = service.modify(registration, addFile);// 서비스에게 넘김

		// DB가 수정되고 만약 잘 수정되었다면(true)이면 다음 실행흐름을 이어가라
		if (ok) {
			// 해당 펫정보보기로 돌아가게 만들래 (리다이렉션)
			rttr.addFlashAttribute("message", registration.getPetName() + " 정보가 수정되었습니다.");
			return "redirect:/id/" + registration.getId();
		} else {
			// 잘못수정이 되었을 때는 수정페이지로 돌아가게 만들래
			rttr.addFlashAttribute("message", registration.getPetName() + " 정보가 수정되지 못했습니다.");
			// rttr.addAttribute("fail", "fail");
			return "redirect:/modify/" + registration.getId();
		}

	}

	// 펫 정보 삭제
	@PostMapping("petRemove")
	public String delete(Integer id, RedirectAttributes rttr) {
		boolean ok = service.remove(id);
		if (ok) {

			// 모델에 추가
			rttr.addFlashAttribute("message", "등록된 반려동물이 삭제되었습니다.");
			return "redirect:/myPets/petList";
		} else {
			// 남아있게 할래
			rttr.addFlashAttribute("message", "등록된 반려동물 삭제를 실패하였습니다.");
			return "redirect:/id/" + id;
		}
	}

	// 선택한 펫id를 member테이블에 등록
	@PostMapping("/thumbnail/{id}")
	@ResponseBody
	public void profileImage(@PathVariable("id") Integer id,
							@RequestBody Registration reg,
							Authentication auth,
							HttpSession session,
							RedirectAttributes rttr) {
		
		boolean result = service.profileImage(id, auth, reg.getChecked());
		
		Member member = memberService.get(auth.getName());
		
		session.setAttribute("logedInMember", member);
	}
	
	
	
//	
//	//네브바 닉네임 가져오기
//	@GetMapping("/")
//	public void navBarNickName(Authentication auth, Model model) {
//		System.out.println(auth);
//		String userNickName = service.navBarNickName(auth);
//		model.addAttribute("userNickName", userNickName);
//		System.out.println(userNickName);
//		
//	}

}
