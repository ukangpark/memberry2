package com.example.demo.controller;

import java.io.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.web.servlet.mvc.support.*;

import com.example.demo.domain.*;
import com.example.demo.domain.File;
import com.example.demo.service.*;

@Controller
@RequestMapping("/")
public class MyFeedController {
	
	@Autowired
	private MyFeedService service;

	// 게시물 목록
	@GetMapping("myFeed")
	public String myFeed(Model model) {
		List<File> list = service.listMyFeed();
		model.addAttribute("fileList", list);
		
		return "myFeed";
		
	}
	
	@GetMapping("feedAdd")
	public void addForm() {
		// 게시물 작성 form(view)로 포워드
	}
	
	// 게시물 추가하기
	@PostMapping("feedAdd")
	public String addProcess(@RequestParam("files") MultipartFile[] files,
			Feed feed, RedirectAttributes rttr) throws Exception {
		// 새 게시물 DB에 추가
		boolean ok = service.addFeed(feed, files);
		if (ok) {
			// 추가가 잘 되었으면 게시판으로 이동
			return "redirect:/myFeed";
		} else {
			rttr.addFlashAttribute("feed", feed);
			return "redirect:/feedAdd";
		}
	}
	
	// 클릭한 게시물 보기
	@GetMapping("/feedId/{feedId}")
	public String post(@PathVariable("feedId") Integer feedId, Model model) {
		Feed feed = service.getPost(feedId);
		model.addAttribute("feed", feed);
		
		return "feedGet";
	}
	
	// 게시물 수정하는 폼 보여주기
	@GetMapping("/modify/{feedId}")
	public String modifyForm(@PathVariable("feedId") Integer feedId, Model model) {
		model.addAttribute("feed", service.getPost(feedId));
		return "feedModify";
	}
	
	// 게시물 수정한 값 업로드
	@PostMapping("/modify/{feedId}")
	public String modifyProcess(Feed feed, File file, RedirectAttributes rttr) {
		
		boolean ok = service.modify(feed);
		
		if (ok) { 
			// 수정이 잘 되면 작성한 게시물로 리디렉션
			rttr.addAttribute("success", "modify"); 
			return "redirect:/feedId/" + file.getFeedId();
		} else {
			// 수정이 안 되면 수정하기 양식으로 리디렉션
			rttr.addAttribute("fail", "fail"); 
			return "redirect:/modify/" + file.getFeedId();
		}
	}
	
	@PostMapping("remove")
	public String remove(Integer id, RedirectAttributes rttr) {
		boolean ok = service.remove(id);
		if (ok) {
			rttr.addFlashAttribute("message", "게시물이 삭제되었습니다!");
			return "redirect:/myFeed";
		} else {
			return "redirect:/id/" + id;
		}
	}
}
