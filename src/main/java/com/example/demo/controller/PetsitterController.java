package com.example.demo.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.access.prepost.*;
import org.springframework.security.config.annotation.method.configuration.*;
import org.springframework.security.core.*;
import org.springframework.security.core.context.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.web.servlet.mvc.support.*;

import com.example.demo.domain.*;
import com.example.demo.service.*;

import jakarta.servlet.http.*;

@Controller
@RequestMapping("petsitter")
public class PetsitterController {

	@Autowired
	private PetsitterService petsitterService;
	@Autowired
	private MapService mapService;
	@Autowired
	private AlarmService alarmService;

	@GetMapping("main")
	public String main(Model model, @RequestParam(value = "page", defaultValue = "1") Integer page,
			@RequestParam(value = "search", defaultValue = "") String search) {
		Map<String, Object> result = petsitterService.listHost(page, search);
		model.addAllAttributes(result);
		return "petsitter/main";
	}

	@GetMapping("detail")
	public void detail(
			@RequestParam("id") Integer hostId, 
			Model model, 
			HttpSession session) {
		// detail로 포워드
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		//로그인한 사용자의 로그인 정보 불러오는 객체
		
		// 쿼리스트링으로 받은 id값을 받아서 해당 상세페이지를 읽음
		Map<String, Object> info = petsitterService.selectByHostId(hostId, authentication); 

		// 지도 정보
		String apiKey = mapService.getKakao_javaScript_key();
		info.put("apiKey", apiKey);

		model.addAllAttributes(info);

		List<Registration> pet = new ArrayList<>();

		// 사용자 반려견 정보 가져오기
		if (authentication != null) {
			String userId = authentication.getName();
			pet = petsitterService.selectUserPet(userId);
			//알림창 업데이트
			List<Alarm> alarms = alarmService.list(authentication.getName());
			session.setAttribute("alarms", alarms);

		}

		model.addAttribute("pet", pet);

	}

	@GetMapping("apply")
	@PreAuthorize("isAuthenticated() and !hasAuthority('host') and !hasAuthority('admin')")
	public void applyForm(Model model, Authentication authentication) {
		// 호스트 등록 폼으로 포워드
		Map<String, Object> info = petsitterService.selectByMemberId(authentication.getName());
		model.addAllAttributes(info);
	}

	@PostMapping("apply")
	@PreAuthorize("isAuthenticated() and !hasAuthority('host') and !hasAuthority('admin')")
	public String applyProcess(
			Host host, 
			RedirectAttributes rttr, 
			@RequestParam("file") MultipartFile file,
			Authentication authentication,
			HttpServletRequest request) throws Exception {
		host.setMemberId(authentication.getName());

		// host 정보 받아서 추가
		int count = petsitterService.insertHost(host, file);

		rttr.addFlashAttribute("host", host);
		
		if (count == 1) {
			rttr.addFlashAttribute("message", "호스트 등록이 완료되었습니다. 다시 로그인해주세요.");
			
			request.logout();
			return "redirect:/member/login";
		} else {
			rttr.addFlashAttribute("message", "이미 호스트 등록이 되어있습니다.");
			return "redirect:/petsitter/hostMyPage";
		}

	}

	@GetMapping("hostMyPage")
	@PreAuthorize("isAuthenticated() or hasAuthority('admin')")
	public void hostMyPage(
			Authentication authentication, 
			Model model,
			@RequestParam(value = "hostId", required = false) Integer hostId) {
		// 호스트 마이페이지 포워드
		if(hostId == null) {
			//호스트가 네브바에서 호스트 마이페이지 접근 시
			Map<String, Object> info = petsitterService.selectByMemberId(authentication.getName());			
			model.addAllAttributes(info);
		} else {
			//관리자가 호스트리스트에서 해당 호스트 마이페이지 접근 시
			Map<String, Object> info = petsitterService.selectByHostId(hostId, authentication);
			model.addAllAttributes(info);
		}		
	}

	@GetMapping("hostModify")
	@PreAuthorize("(isAuthenticated() and @customSecurityChecker.checkPetsitterWriter(authentication, #hostId)) or hasAuthority('admin')")
	public void hostModifyForm(
			Authentication authentication, 
			Model model,
			@RequestParam("hostId") Integer hostId) {
		// 호스트 정보 수정폼 포워드
		if(hostId != null) {
			Map<String, Object> info = petsitterService.selectByHostId(hostId, authentication);
			model.addAllAttributes(info);			
		} else {
			Map<String, Object> info = petsitterService.selectByMemberId(authentication.getName());
			model.addAllAttributes(info);			
		}
	}

	@PostMapping("hostModify")
	@PreAuthorize("(isAuthenticated() and @customSecurityChecker.checkPetsitterWriter(authentication, #host.id)) or hasAuthority('admin')")
	public String hostModifyProcess(
			Host host, 
			@RequestParam(value = "file", required = false) MultipartFile file,
			RedirectAttributes rttr) throws Exception {
		//redirect 경로
		String redirect = "redirect:/petsitter/hostMyPage";
		
		//관리자인지 확인하기 위한 코드
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		
		for(GrantedAuthority grantedAuthority : authentication.getAuthorities()) {
			boolean check = grantedAuthority.getAuthority().equals("admin");
			if(check) {
				redirect = "redirect:/petsitter/hostList";				
			}
		}
		
		// 호스트 정보 수정 과정
		boolean ok = petsitterService.modifyHostById(host, file);

		if (ok) {
			rttr.addFlashAttribute("message", "정보를 수정하였습니다.");
		} else {
			rttr.addFlashAttribute("message", "정보를 수정하지 못했습니다.");
		}
	
		return redirect;
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
	@PreAuthorize("hasAuthority('admin')")
	public void hostList(Model model, @RequestParam(value = "page", defaultValue = "1") Integer page) {
		// 호스트 리스트 포워드
		Map<String, Object> info = petsitterService.selectAll(page);
		model.addAllAttributes(info);
	}

	@PostMapping("hostDelete")
	@PreAuthorize("(isAuthenticated() and @customSecurityChecker.checkPetsitterWriter(authentication, #hostId)) or hasAuthority('admin')")
	public String hostDelete(
			Integer hostId, 
			Member member, 
			Authentication authentication, 
			RedirectAttributes rttr) {
		
		//redirect 경로
		String redirect = "redirect:/petsitter/main";
		
		//관리자인지 확인 
		for(GrantedAuthority grantedAuthority : authentication.getAuthorities()) {
			boolean check = grantedAuthority.getAuthority().equals("admin");
			
			if(check) {
				redirect = "redirect:/petsitter/hostList";
			}
		}
		
		// 호스트 정보 삭제 과정
		// member자바빈에 인증 아이디 넣어줌
		member.setId(authentication.getName());
		System.out.println(member);

		boolean ok = petsitterService.deleteHostById(hostId, member, authentication);
		System.out.println(ok);

		if (ok) {
			rttr.addFlashAttribute("message", "호스트 정보를 삭제하였습니다.");
		} else {
			rttr.addFlashAttribute("message", "호스트 정보를 삭제하지 못했습니다.");
		}

		return redirect;
	}

	@GetMapping("addDetail")
	@PreAuthorize("hasAuthority('host')")
	public void addDetailForm(Authentication authentication, Model model) {
		// 상세페이지 등록폼 view 포워드
		Map<String, Object> info = petsitterService.selectByMemberId(authentication.getName());
		model.addAllAttributes(info);
	}

	@PostMapping("addDetail")
	@PreAuthorize("hasAuthority('host')")
	public String addDetailProcess(Detail detail, Authentication authentication) throws Exception {
		// 상세페이지 등록 과정
		boolean ok = petsitterService.insertDetail(detail, authentication);
		System.out.println(ok);
		return "redirect:/petsitter/addHousePhotos";
	}

	@GetMapping("addHousePhotos")
	@PreAuthorize("hasAuthority('host')")
	public void addHousePhotosForm(Authentication authentication, Model model) {
		// 상세페이지에 집사진 등록하는 폼 포워드
		Map<String, Object> info = petsitterService.selectByMemberId(authentication.getName());
		model.addAllAttributes(info);
	}

	@PostMapping("addHousePhotos")
	@PreAuthorize("hasAuthority('host')")
	public String addHousePhotosProgress(@RequestParam("cover") MultipartFile cover,
			@RequestParam(value = "housePhotos", required = false) MultipartFile[] housePhotos, Integer hostId,
			RedirectAttributes rttr) throws Exception {
		// 상세페이지에 집사진 등록하는 과정
		Integer count = petsitterService.insertHousePhotos(housePhotos, hostId, cover);

		if (count != null) {
			// 상세페이지 최초 등록
			rttr.addFlashAttribute("message", "게시물이 성공적으로 등록되었습니다.");
		} else {
			// 상세페이지 재등록
			rttr.addFlashAttribute("message", "게시물이 등록되지 않았습니다.");
		}

		return "redirect:/petsitter/detail?id=" + hostId;
	}

	@GetMapping("modifyDetail")
	@PreAuthorize("hasAuthority('host')")
	public void modifyDetailForm(Authentication authentication, Model model) {
		// 상세페이지 수정폼 view 포워드

		// 기존 상세페이지 정보 탐색
		Map<String, Object> info = petsitterService.selectByMemberId(authentication.getName());
		model.addAllAttributes(info);

	}

	@PostMapping("modifyDetail")
	@PreAuthorize("hasAuthority('host')")
	public String modifyProcess(Detail detail) throws Exception {
		// 상세페이지 수정 process
		boolean ok = petsitterService.modifyDetailDescription(detail);
		System.out.println("modify detail : " + detail);
		return "redirect:/petsitter/modifyHousePhotos";
	}

	@GetMapping("modifyHousePhotos")
	@PreAuthorize("hasAuthority('host')")
	public void modifuHousePhtosForm(Authentication authentication, Model model) {
		// 상세페이지 집사진 수정폼 view 포워드

		// 기존 상세페이지 집사진 정보 탐색
		Map<String, Object> info = petsitterService.selectByMemberId(authentication.getName());
		System.out.println(info.get("detail"));
		model.addAllAttributes(info);
	}

	@PostMapping("modifyHousePhotos")
	@PreAuthorize("hasAuthority('host')")
	public String modifyHousePhotosProcess(Detail detail,
			@RequestParam(value = "addCover", required = false) MultipartFile addCover,
			@RequestParam(value = "removePhotos", required = false) List<String> removePhotos,
			@RequestParam(value = "addPhotos", required = false) MultipartFile[] addPhotos, RedirectAttributes rttr)
			throws Exception {
		// detailId 필요

		// 집사진 수정 process
		Integer count = petsitterService.modifyDetailHousePhotos(addCover, addPhotos, removePhotos, detail);
		if (count != null) {
			rttr.addFlashAttribute("message", "상세페이지를 수정하였습니다.");
		} else {
			rttr.addFlashAttribute("message", "상세페이지를 수정하지 못했습니다.");
		}

		return "redirect:/petsitter/detail?id=" + detail.getHostId();
	}

	@PostMapping("deleteDetail")
	@PreAuthorize("hasAuthority('host')")
	public String deleteDetail(Integer hostId, Member member, Authentication authentication, RedirectAttributes rttr) {
		// 상세페이지 삭제
		member.setId(authentication.getName());
		boolean ok = petsitterService.deleteDetailByHostId(hostId, member);

		if (ok) {
			rttr.addFlashAttribute("message", "상세페이지가 삭제되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "상세페이지가 삭제되지 않았습니다.");
		}

		return "redirect:/petsitter/hostMyPage";
	}

}
