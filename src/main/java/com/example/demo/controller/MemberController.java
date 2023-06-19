package com.example.demo.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.*;
import org.springframework.security.core.annotation.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.config.oauth.*;
import com.example.demo.domain.Member;
import com.example.demo.repository.*;
import com.example.demo.security.*;
import com.example.demo.service.MemberService;

import jakarta.servlet.http.*;

@Controller
@RequestMapping("member")
public class MemberController {

	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private MemberService service;
	
	@Autowired
    private LoginAuthenticationSuccessHandler loginSuccessHandler;

    @Autowired
    private UserLoginFailHandler userLoginFailHandler;

    @GetMapping("/test/login")
    public @ResponseBody String testLogin(
    		Authentication authentication,
    		@AuthenticationPrincipal PrincipalDetails userDetails) {
    	System.out.println("/test/login---------------");
    	PrincipalDetails principalDetails = (PrincipalDetails) authentication.getPrincipal();
    	System.out.println("authentication: " + principalDetails.getMember());
    	System.out.println("userDetails: " + userDetails.getMember());
    	return "세션 정보 확인하기";
    }

	@GetMapping("checkId/{id}")
	@ResponseBody
	public Map<String, Object> checkId(@PathVariable("id") String id){
		
		return service.checkId(id);
	}
	
	@GetMapping("checkNickName/{nickName}")
	@ResponseBody
	public Map<String, Object> checkNickName(@PathVariable("nickName") String nickName){
		
		return service.checkNickName(nickName);
	}
	
	@GetMapping("checkEmail/{email}")
	@ResponseBody
	public Map<String, Object> checkEmail(@PathVariable("email") String email){
		
		return service.checkEmail(email);
	}
	
	@GetMapping("checkPhoneNumber/{phoneNumber}")
	@ResponseBody
	public Map<String, Object> checkPhoneNumber(@PathVariable("phoneNumber") String phoneNumber){
		
		return service.checkPhoneNumber(phoneNumber);
	}
	
	@GetMapping("login")
	public String loginForm(@RequestParam(value = "error", required = false) String error,
							@RequestParam(value = "exception", required = false) String exception,
							Model model) {
		model.addAttribute("error", error);
		model.addAttribute("exception", exception);
		return "member/login";
	}
	
	
	@GetMapping("signup")
	@PreAuthorize("isAnonymous()")
	public void signupForm() {

	}

	@PostMapping("signup")
	@PreAuthorize("isAnonymous()")
	public String signupProcess(Member member, RedirectAttributes rttr) {

		try {
			service.signup(member);
			rttr.addFlashAttribute("message", "회원 가입되었습니다.");
			return "redirect:/member/login";
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("member", member);
			rttr.addFlashAttribute("message", "회원 가입 중 문제가 발생했습니다.");
			return "redirect:/member/signup";
		}
	}

	// 경로: http://localhost:8080/member/list?page=3
	@GetMapping("list")
	@PreAuthorize("hasAuthority('admin')")
	public String list(Model model, 
					 @RequestParam(value="page", defaultValue="1") Integer page) {
//		List<Member> list = service.listMember(); // 페이지 처리 전
		Map<String, Object> result = service.listMember(page); // 페이지 처리 이후
		
//		model.addAttribute("pageInfo", result.get("pageInfo"));
//		model.addAttribute("memberList", result.get("memberList"));
		model.addAllAttributes(result);
		
		
		return "member/list";
	}

	@GetMapping("info")
	@PreAuthorize("(isAuthenticated() and (authentication.name eq #id)) or hasAuthority('admin')")
	public void info(String id, Model model) {

		Member member = service.get(id);
		model.addAttribute("member", member);
	}

	@PostMapping("remove")
	@PreAuthorize("isAuthenticated() and (authentication.name eq #member.id)")
	public String remove(Member member, 
						 RedirectAttributes rttr,
						 HttpServletRequest request) throws Exception {

		boolean ok = service.remove(member);

		if (ok) {
			rttr.addFlashAttribute("message", "회원 탈퇴하였습니다.");
			
			// 탈퇴되었으면 로그아웃되도록
			request.logout();
			
			return "redirect:/home";
		} else {
			rttr.addFlashAttribute("message", "회원 탈퇴시 문제가 발생했습니다.");
			return "redirect:/member/info?id=" + member.getId();
		}
	}

	@GetMapping("modify")
	@PreAuthorize("isAuthenticated() and (authentication.name eq #id)")
	public void modifyForm(String id, Model model) {
		Member member = service.get(id);
		model.addAttribute("member", member);
	}
 
	@PostMapping("modify")
	@PreAuthorize("isAuthenticated() and (authentication.name eq #member.id)")
	public String modifyProcess(Member member, String oldPassword, RedirectAttributes rttr) {
		boolean ok = service.modify(member, oldPassword);
		if (ok) {
			rttr.addFlashAttribute("message", "회원 정보가 수정되었습니다.");
			return "redirect:/member/info?id=" + member.getId();
		} else {
			rttr.addFlashAttribute("message", "회원 정보 수정 중 문제가 발생했습니다.");
			return "redirect:/member/modify?id=" + member.getId();
		}
	}
	
}
