package com.example.demo.controller;

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

import com.example.demo.domain.Feed;
import com.example.demo.domain.File;
import com.example.demo.domain.Like;
import com.example.demo.service.MyFeedService;

@Controller
@RequestMapping("/")
public class MyFeedController {
	
	@Autowired
	private MyFeedService service;

	// 게시물 목록
	@GetMapping("feed/myFeed")
	@PreAuthorize("isAuthenticated()")
	public String myFeed(Model model,
			Authentication authentication) {
		List<File> list = service.listMyFeed(authentication);
		model.addAttribute("fileList", list);
		
		return "feed/myFeed";
		
	}
	
	@GetMapping("feed/feedAdd")
	public void addForm(Model model, Authentication authentication) {
		// 게시물 작성 form(view)로 포워드
		model.addAttribute("authentication", authentication);
	}
	
	// 게시물 추가하기
	@PostMapping("feed/feedAdd")
	public String addProcess(@RequestParam("files") MultipartFile[] files,
			Feed feed, Authentication authentication,  RedirectAttributes rttr) throws Exception {
		// 새 게시물 DB에 추가
		boolean ok = service.addFeed(feed, files, authentication);
		if (ok) {
			// 추가가 잘 되었으면 게시판으로 이동
			rttr.addFlashAttribute("message", feed.getTitle() + "피드에 등록되었습니다.");
			rttr.addFlashAttribute("feed", feed);
			return "redirect:/feed/myFeed";
		} else {
			rttr.addFlashAttribute("feed", feed);
			rttr.addFlashAttribute("message", "피드 등록에 실패하였습니다.");
			return "redirect:/feed/feedAdd";
		}
	}
	
	// 클릭한 게시물 보기
	@GetMapping("/feedId/{feedId}")
	public String post(
			@PathVariable("feedId") Integer feedId, 
			Model model,
			Authentication authentication) {
		Feed feed = service.getPost(feedId, authentication);
		model.addAttribute("feed", feed);
		
		return "feed/feedGet";
	}
	
	// 게시물 수정하는 폼 보여주기
	@GetMapping("/modify/{feedId}")
	public String modifyForm(@PathVariable("feedId") Integer feedId, Model model) {
		model.addAttribute("feed", service.getPost(feedId));
		return "feed/feedModify";
	}
	
	// 게시물 수정한 값 업로드
	@PostMapping("/modify/{feedId}")
	public String modifyProcess(Feed feed, 
			File file, 
			@RequestParam(value="removeFiles", required = false) List<String> removeFileNames,
			@RequestParam(value="files", required = false) MultipartFile[] addFiles,
			RedirectAttributes rttr) throws Exception {
		
		boolean ok = service.modify(feed, removeFileNames, addFiles);
		
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
			return "redirect:/feed/myFeed";
		} else {
			return "redirect:/id/" + id;
		}
	}

}
