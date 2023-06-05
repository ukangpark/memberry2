package com.example.demo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.domain.Detail;
import com.example.demo.domain.Host;
import com.example.demo.service.PetsitterService;
import com.fasterxml.jackson.annotation.JsonCreator.Mode;

@Controller
@RequestMapping("petsitter")
public class PetsitterController {
	
	@Autowired
	private PetsitterService petsitterService;
	
	@GetMapping("main")
	public void main(Model model) {
		//main 페이지 포워드
		//모든 정보를 읽음
		List<Host> list = petsitterService.selectAll();
		model.addAttribute("host", list);
	}
	
	@GetMapping("detail")
	public void detail(@RequestParam("id") Integer hostId, Model model) {
		//detail로 포워드
		// 쿼리스트링으로 받은 id값을 받아서 해당 상세페이지를 읽음
		Map<String, Object> info = petsitterService.selectById(hostId);
		
		model.addAllAttributes(info);		
	}
	
	@GetMapping("apply")
	public void applyForm() {
		//호스트 등록 폼으로 포워드
	}
	
	@PostMapping("apply")
	public String applyProcess(Host host, RedirectAttributes rttr) {
		//host 정보 받아서 추가
		int count = petsitterService.insertHost(host);
		rttr.addFlashAttribute("host", host);
		return "redirect:/petsitter/main2";
	}
	
	@GetMapping("hostMyPage")
	public void hostMyPage(@RequestParam("id") Integer hostId, Model model) {
		//호스트 마이페이지 포워드
		Map<String, Object> info = petsitterService.selectById(hostId);
		model.addAllAttributes(info);
	}
	
	@GetMapping("hostModify")
	public void hostModifyForm(@RequestParam("id") Integer hostId, Model model) {
		//호스트 정보 수정폼 포워드
		Map<String, Object> info = petsitterService.selectById(hostId);
		model.addAllAttributes(info);
		
	}
	
	@PostMapping("hostModify")
	public String hostModifyProcess(Host host) {
		//호스트 정보 수정 과정
		boolean ok = petsitterService.modifyById(host);
		
		return "redirect:/petsitter/hostMyPage?id=" + host.getId();
	}
	@GetMapping("list")
	public String petsitterList(Model model) {
		List<Host> list = petsitterService.listHost();
		model.addAttribute("petsitterList", list);
		
		return "petsitter/list";
	}
	
	
	@GetMapping("regiForm")
	public String regiForm() {
		return "petsitter/regiForm";
	}
	
	
	@GetMapping("hostList")
	public void hostList(Model model) {
		//호스트 리스트 포워드
		List<Host> list = petsitterService.selectAll();
		model.addAttribute("host", list);
	}
	
	@PostMapping("hostDelete")
	public String hostDelete(Integer hostId) {
		// 호스트 정보 삭제 과정
		boolean ok = petsitterService.deleteHostById(hostId);
		return "redirect:/petsitter/hostList";
	}
	
	@GetMapping("addDetail")
	public void detailForm(Integer hostId) {
		// 상세페이지 view 포워드
	}
	
	@PostMapping("addDetail")
	public String addDetailProcess(Detail detail) {
		boolean ok = petsitterService.insertDetail(detail);
		
		return "redirect:/petsitter/detail?id=" + detail.getHostId();
	}
}
