package com.example.demo.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.access.prepost.*;
import org.springframework.security.core.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.web.servlet.mvc.support.*;

import com.example.demo.domain.*;
import com.example.demo.service.*;

@Controller
@RequestMapping("petsitter")
public class PetsitterController {

	@Autowired
	private PetsitterService petsitterService;

	@GetMapping("main")
	public String main(Model model, @RequestParam(value = "page", defaultValue = "1") Integer page,
			@RequestParam(value = "search", defaultValue = "") String search) {
		Map<String, Object> result = petsitterService.listHost(page, search);
		model.addAllAttributes(result);
		return "petsitter/main";
	}

	@GetMapping("detail")
	public void detail(@RequestParam("id") Integer hostId , Model model, Authentication authentication) {
		// detail로 포워드
		// 쿼리스트링으로 받은 id값을 받아서 해당 상세페이지를 읽음
		Map<String, Object> info = petsitterService.selectByHostId(hostId, authentication);
		model.addAllAttributes(info);
		
		List<Registration> pet = new ArrayList<>();
		
		// 사용자 반려견 정보 가져오기
		if(authentication != null) {
			String userId = authentication.getName();
			pet = petsitterService.selectUserPet(userId);
		}
		
		model.addAttribute("pet", pet);
	}

	@GetMapping("apply")
	@PreAuthorize("isAuthenticated()")
	public void applyForm(Model model, Authentication authentication) {
		// 호스트 등록 폼으로 포워드
		Map<String, Object> info = petsitterService.selectByMemberId(authentication.getName());
		model.addAllAttributes(info);
	}

	@PostMapping("apply")
	@PreAuthorize("isAuthenticated()")
	public String applyProcess(
			Host host, 
			RedirectAttributes rttr, 
			@RequestParam("file") MultipartFile file,
			Authentication authentication)
			throws Exception {
		host.setMemberId(authentication.getName());

		// host 정보 받아서 추가 
		int count = petsitterService.insertHost(host, file);
		
		if(count == 1) {
			rttr.addFlashAttribute("message", "호스트 등록이 완료되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "이미 호스트 등록이 되어있습니다.");
		}
		rttr.addFlashAttribute("host", host);
		
		
		return "redirect:/petsitter/hostMyPage";
	}

	@GetMapping("hostMyPage")
	@PreAuthorize("isAuthenticated()")
	public void hostMyPage(Authentication authentication ,Model model) {
		// 호스트 마이페이지 포워드
		Map<String, Object> info = petsitterService.selectByMemberId(authentication.getName());
		model.addAllAttributes(info);
	}

	@GetMapping("hostModify")
	@PreAuthorize("isAuthenticated()")
	public void hostModifyForm(Authentication authentication, Model model) {
		// 호스트 정보 수정폼 포워드
		Map<String, Object> info = petsitterService.selectByMemberId(authentication.getName());
		model.addAllAttributes(info);
	}

	@PostMapping("hostModify")
	@PreAuthorize("isAuthenticated()")
	public String hostModifyProcess(
			Host host, 
			@RequestParam(value =  "file", required = false) MultipartFile file,
			RedirectAttributes rttr) throws Exception {
		// 호스트 정보 수정 과정
		boolean ok = petsitterService.modifyHostById(host, file);
		
		if(ok) {
			rttr.addFlashAttribute("message", "정보를 수정하였습니다.");
		} else {
			rttr.addFlashAttribute("message", "정보를 수정하지 못했습니다.");
		}
		return "redirect:/petsitter/hostMyPage";
	}

	// 펫시터 전체목록보기, 페이지네이션, 검색
	@GetMapping("list")
	public String petsitterList(Model model, @RequestParam(value = "page", defaultValue = "1") Integer page,
			@RequestParam(value = "search", defaultValue = "") String search) {
		Map<String, Object> result = petsitterService.listHost(page, search);
		model.addAllAttributes(result);
		return "petsitter/list";
	}

	@GetMapping("hostList")
	@PreAuthorize("isAuthenticated()")
	public void hostList(Model model) {
		// 호스트 리스트 포워드
		Map<String, Object> info = petsitterService.selectAll();
		model.addAllAttributes(info);
	} 

	@PostMapping("hostDelete")
	@PreAuthorize("isAuthenticated()")
	public String hostDelete(
			Integer hostId, 
			Member member,
			Authentication authentication,
			RedirectAttributes rttr) {
		// 호스트 정보 삭제 과정
		member.setId(authentication.getName());
		
		boolean ok = petsitterService.deleteHostById(hostId, member,  authentication);
		
		if(ok) {
			rttr.addFlashAttribute("message", "호스트 정보를 삭제하였습니다.");
		} else {
			rttr.addFlashAttribute("message", "호스트 정보를 삭제하지 못했습니다.");
		}

		return "redirect:/petsitter/main";
	}
	
	

	@GetMapping("addDetail")
	@PreAuthorize("isAuthenticated()")
	public void addDetailForm(Authentication authentication, Model model) {
		// 상세페이지 등록폼 view 포워드
		Map<String, Object> info =petsitterService.selectByMemberId(authentication.getName());
		model.addAllAttributes(info);
	}

	@PostMapping("addDetail")
	@PreAuthorize("isAuthenticated()")
	public String addDetailProcess(
			Detail detail, 
			Authentication authentication) throws Exception {
		// 상세페이지 등록 과정
		boolean ok = petsitterService.insertDetail(detail, authentication);
	
		return "redirect:/petsitter/addHousePhotos";
	}

	@GetMapping("addHousePhotos")
	@PreAuthorize("isAuthenticated()")
	public void addHousePhotosForm(Authentication authentication, Model model) {
		// 상세페이지에 집사진 등록하는 폼 포워드 
		Map<String, Object> info =petsitterService.selectByMemberId(authentication.getName());
		model.addAllAttributes(info);
	}

	@PostMapping("addHousePhotos")
	@PreAuthorize("isAuthenticated()")
	public String addHousePhotosProgress(
			@RequestParam("cover") MultipartFile cover,
			@RequestParam(value = "housePhotos", required = false) MultipartFile[] housePhotos,
			Integer hostId,
			RedirectAttributes rttr) throws Exception {
		// 상세페이지에 집사진 등록하는 과정 
		Integer count = petsitterService.insertHousePhotos(housePhotos, hostId, cover);
		
		if(count != null) {
			// 상세페이지 최초 등록
			rttr.addFlashAttribute("message", "게시물이 성공적으로 등록되었습니다.");
		} else {
			// 상세페이지 재등록
			rttr.addFlashAttribute("message", "게시물이 등록되지 않았습니다.");
		}
		
		return "redirect:/petsitter/detail?id=" + hostId;
	}

	@GetMapping("modifyDetail")
	@PreAuthorize("isAuthenticated()")
	public void modifyDetailForm(Authentication authentication, Model model) {
		// 상세페이지 수정폼 view 포워드

		// 기존 상세페이지 정보 탐색
		Map<String, Object> info = petsitterService.selectByMemberId(authentication.getName());
		model.addAllAttributes(info);

	}

	@PostMapping("modifyDetail")
	@PreAuthorize("isAuthenticated()")
	public String modifyProcess(Detail detail) throws Exception {
		// 상세페이지 수정 process
		boolean ok = petsitterService.modifyDetailDescription(detail);
		
		
		return "redirect:/petsitter/modifyHousePhotos";
	}

	@GetMapping("modifyHousePhotos")
	@PreAuthorize("isAuthenticated()")
	public void modifuHousePhtosForm(Authentication authentication, Model model) {
		// 상세페이지 집사진 수정폼 view 포워드

		// 기존 상세페이지 집사진 정보 탐색
		Map<String, Object> info = petsitterService.selectByMemberId(authentication.getName());
		System.out.println(info.get("detail"));
		model.addAllAttributes(info);
	}

	@PostMapping("modifyHousePhotos")
	@PreAuthorize("isAuthenticated()")
	public String modifyHousePhotosProcess(
			Detail detail,
			@RequestParam(value = "addCover", required = false) MultipartFile addCover,
			@RequestParam(value = "removePhotos", required = false) List<String> removePhotos,
			@RequestParam(value = "addPhotos", required = false) MultipartFile[] addPhotos,
			RedirectAttributes rttr) throws Exception {
		//detailId 필요 
		
		// 집사진 수정 process
		Integer count = petsitterService.modifyDetailHousePhotos(addCover, addPhotos, removePhotos, detail);
		if(count != null) {
			rttr.addFlashAttribute("message", "상세페이지를 수정하였습니다.");
		} else {
			rttr.addFlashAttribute("message", "상세페이지를 수정하지 못했습니다.");
		}
		
		return "redirect:/petsitter/detail?id=" + detail.getHostId();
	}

	@PostMapping("deleteDetail")
	@PreAuthorize("isAuthenticated()")
	public String deleteDetail(
			Integer hostId, 
			Member member,
			Authentication authentication,
			RedirectAttributes rttr) {
		//상세페이지 삭제 
		member.setId(authentication.getName());
		boolean ok = petsitterService.deleteDetailByHostId(hostId, member);
		
		if(ok) {
			rttr.addFlashAttribute("message", "상세페이지가 삭제되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "상세페이지가 삭제되지 않았습니다.");
		}
		
		return "redirect:/petsitter/hostMyPage";
	}

}
