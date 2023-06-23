package com.example.demo.controller;

import java.time.LocalDate;
import java.time.Period;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.domain.Alarm;
import com.example.demo.domain.Feed;
import com.example.demo.domain.File;
import com.example.demo.domain.Follow;
import com.example.demo.domain.Registration;
import com.example.demo.domain.Tag;
import com.example.demo.service.AlarmService;
import com.example.demo.service.MyFeedService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/")
public class MyFeedController {

	@Autowired
	private MyFeedService service;
	
	@Autowired
	private AlarmService alarmService;

	// MyFeed 보기
	@GetMapping("feed/myFeed/{userName}")
	@PreAuthorize("isAuthenticated()")
	public String myFeed(Model model, @PathVariable("userName") String userName, Authentication authentication, HttpSession session) {
		List<File> list = service.listMyFeed(userName, authentication);
		Registration profileList = service.listProfile(userName, authentication);
		//List<Follow> follow = service.listFollow(userName, authentication);
		//System.out.println(follow);
		
		if(authentication != null) {
			List<Alarm> alarms = alarmService.list(authentication.getName());
			session.setAttribute("alarms", alarms);
		}
		

		// 태그 용
		Integer feedId = service.feedId(userName, authentication);
		//System.out.println(feedId);
		
		// 마이피드에 펫정보 가져오기 용
		String petName = profileList.getPetName();
		String type = profileList.getType();
		LocalDate together = profileList.getTogether();

		// 마이피드에 펫정보 중 함께한날 날짜 계산하기 용
		var now = LocalDate.now();
		Registration petList = new Registration();
		petList.setPetName(petName);
		petList.setType(type);
		petList.setDiff(Period.between(together, now));

		// 마이피드에 프로필이미지 가져오기 용
		String profileImage = profileList.getProfileImage();

		// 마이피드에 닉네임 보여주기 용
		String nickName = profileList.getNickName();

		model.addAttribute("fileList", list);
		model.addAttribute("profileImg", profileImage);
		model.addAttribute("nickName", nickName);
		model.addAttribute("petList", petList);
		model.addAttribute("userName", userName);
		model.addAttribute("authentication", authentication.getName());
		model.addAttribute("feedId", feedId);
		//model.addAttribute("follow", follow);
		return "feed/myFeed";
	}

	@GetMapping("feed/feedAdd/{feedId}")
	@PreAuthorize("isAuthenticated()")
	public String addForm(@PathVariable("feedId") int feedId, Model model, Authentication authentication) {
		// 게시물 작성 form(view)로 포워드
		model.addAttribute("authentication", authentication);
		model.addAttribute("feedId", feedId);
		
		return "feed/feedAdd";
	}

	// 게시물 추가하기
	@PostMapping("feed/feedAdd/{feedId}")
	@PreAuthorize("isAuthenticated()")
	public String addProcess(@RequestParam("files") MultipartFile[] files, Feed feed, Authentication authentication,
			RedirectAttributes rttr) throws Exception {
		// 새 게시물 DB에 추가
		feed.setWriter(authentication.getName());
		boolean ok = service.addFeed(feed, files, authentication);

		if (ok) {
			// 추가가 잘 되었으면 게시판으로 이동
			rttr.addFlashAttribute("message", feed.getTitle() + "피드에 등록되었습니다.");
			rttr.addFlashAttribute("feed", feed);
			return "redirect:/feed/myFeed/" + feed.getWriter();
		} else {
			rttr.addFlashAttribute("feed", feed);
			rttr.addFlashAttribute("message", "피드 등록에 실패하였습니다.");
			return "redirect:/feed/feedAdd/{feedId}";
		}
	}

	// 클릭한 게시물 보기
	@GetMapping("/feedId/{feedId}")
	public String post(@PathVariable("feedId") Integer feedId, Model model, Authentication authentication, HttpSession session) {
		Feed feed = service.getPost(feedId, authentication);
		model.addAttribute("feed", feed);
		
		if(authentication != null) {
			List<Alarm> alarms = alarmService.list(authentication.getName());
			session.setAttribute("alarms", alarms);
		}

		return "feed/feedGet";
	}

	// 게시물 수정하는 폼 보여주기
	@GetMapping("/modify/{feedId}")
	@PreAuthorize("isAuthenticated() and @customSecurityChecker.checkFeedWriter(authentication, #feedId)")
	public String modifyForm(@PathVariable("feedId") Integer feedId, Model model) {
		model.addAttribute("feed", service.getPost(feedId));
		return "feed/feedModify";
	}

	// 게시물 수정한 값 업로드
	@PostMapping("/modify/{feedId}")
	@PreAuthorize("isAuthenticated() and @customSecurityChecker.checkFeedWriter(authentication, #feed.id)")
	// 수정하려는 게시물의 id : feed.id
	public String modifyProcess(Feed feed, File file,
			@RequestParam(value = "removeFiles", required = false) List<String> removeFileNames,
			@RequestParam(value = "files", required = false) MultipartFile[] addFiles, RedirectAttributes rttr)
			throws Exception {

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
	@PreAuthorize("isAuthenticated() and @customSecurityChecker.checkFeedWriter(authentication, #id)")
	public String remove(Integer id, RedirectAttributes rttr, Authentication authentication) {
		boolean ok = service.remove(id);
		if (ok) {
			return "redirect:/feed/myFeed/" + authentication.getName();
		} else {
			return "redirect:/id/" + id;
		}
	}

	// 태그
	@GetMapping("/tag/list/{feedId}/{tagInput}")
	@ResponseBody
	public List<Tag> tag(@PathVariable("feedId") Integer feedId,
							@PathVariable("tagInput") String tagInput, 
							Authentication auth) {
		List<Tag> result = service.tag(feedId, tagInput, auth);
		System.out.println(result);
		return result;
				
	}
	
	// 태그 삭제
	@PostMapping("/tag/delete/{feedId}/{tagKeyword}")
	@ResponseBody
	public void tagDelete(@PathVariable("feedId")Integer feedId,
							@PathVariable("tagKeyword") String tagKeyword,
							Authentication auth) {
		service.tagDelete(feedId, tagKeyword, auth);
	}

}