package com.example.demo.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.security.core.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.*;

import com.example.demo.domain.*;
import com.example.demo.service.*;

@Controller
@RequestMapping("map")
public class MapController {
	
	@Autowired
	public MapService mapService;
	
	@GetMapping("mapMain")
	public void mapMain(ModelMap model) {
		String apiKey = mapService.getKakao_javaScript_key();
		model.addAttribute("apiKey", apiKey);
	}
	
	// 찜 목록
	@GetMapping("mapMypage")
	public void likePlace(Model model, Authentication authentication,
			@RequestParam(value = "page", defaultValue = "1") Integer page) {
		String apiKey = mapService.getKakao_javaScript_key();
		model.addAttribute("apiKey", apiKey);
		String userId = authentication.getName();
		Map<String, Object> result = mapService.likePlace(page,userId);
		model.addAllAttributes(result);
		
	}
	
	// 찜하기
	@PostMapping("addPlace")
	@ResponseBody
	public ResponseEntity<String> bookAccept(@RequestBody Place place, Authentication authentication) {
		if (authentication == null) {
			return ResponseEntity.ok()
					.body("로그인 후 이용하실 수 있습니다.");
		}else {
			String userId = authentication.getName();
			String address = place.getAddress();
			//테이블에 해당 찜 가게가 있는지 조회 service
			int check = mapService.selectMapList(userId,address);
			if(check != 0) {
				return ResponseEntity.ok()
						.body("이미 찜한 곳 입니다.");
			} else {
				place.setMemberId(userId);
				mapService.insertMapList(place);
				return ResponseEntity.ok()
						.body("찜 완료!"); 
			}
			
		}
	}
	
	// 찜 취소
	@PostMapping("remove/{id}")
	public String remove(@PathVariable(name = "id") int id, RedirectAttributes rttr) {
		boolean ok = mapService.remove(id);
		if(ok) {
			rttr.addFlashAttribute("message", "찜 취소되었습니다.");
			return "redirect:/map/mapMypage";
		} else {
			return "redirect:/map/mapMypage";
		}
		
	}
	
	
}
