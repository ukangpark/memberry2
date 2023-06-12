package com.example.demo.controller;

import java.io.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.access.prepost.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.web.servlet.mvc.support.*;

import com.example.demo.domain.*;
import com.example.demo.service.*;

import software.amazon.awssdk.awscore.exception.*;
import software.amazon.awssdk.core.exception.*;
import software.amazon.awssdk.services.s3.model.*;

@Controller
@RequestMapping("petsitter")
public class PetsitterController {

	@Autowired
	private PetsitterService petsitterService;

	@GetMapping("main")
	public void main(Model model) {
		// main 페이지 포워드
		// 모든 정보를 읽음
		Map<String, Object> list = petsitterService.selectAll();
		model.addAllAttributes(list);
	}

	@GetMapping("detail")
	@PreAuthorize("isAuthenticated()")
	public void detail(@RequestParam("id") Integer hostId, Model model) {
		// detail로 포워드
		// 쿼리스트링으로 받은 id값을 받아서 해당 상세페이지를 읽음
		Map<String, Object> info = petsitterService.selectById(hostId);

		model.addAllAttributes(info);
	}

	@GetMapping("apply")
	@PreAuthorize("isAuthenticated()")
	public void applyForm() {
		// 호스트 등록 폼으로 포워드
	}

	@PostMapping("apply")
	public String applyProcess(Host host, RedirectAttributes rttr, @RequestParam("file") MultipartFile file)
			throws Exception {
		// host 정보 받아서 추가S3Exception
		int count = petsitterService.insertHost(host, file);
		rttr.addFlashAttribute("host", host);
		return "redirect:/petsitter/main";
	}

	@GetMapping("hostMyPage")
	@PreAuthorize("isAuthenticated()")
	public void hostMyPage(@RequestParam("id") Integer hostId, Model model) {
		// 호스트 마이페이지 포워드
		Map<String, Object> info = petsitterService.selectById(hostId);
		model.addAllAttributes(info);
	}

	@GetMapping("hostModify")
	@PreAuthorize("isAuthenticated()")
	public void hostModifyForm(@RequestParam("id") Integer hostId, Model model) {
		// 호스트 정보 수정폼 포워드
		Map<String, Object> info = petsitterService.selectById(hostId);
		model.addAllAttributes(info);
	}

	@PostMapping("hostModify")
	public String hostModifyProcess(Host host, @RequestParam(value =  "file", required = false) MultipartFile file) throws Exception {
		// 호스트 정보 수정 과정
		boolean ok = petsitterService.modifyHostById(host, file);
		System.out.println("controller working");
		return "redirect:/petsitter/hostMyPage?id=" + host.getId();
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
	public String hostDelete(Integer hostId, Member member) {
		// 호스트 정보 삭제 과정
		boolean ok = petsitterService.deleteHostById(hostId, member);
		return "redirect:/petsitter/hostList";
	}

	@GetMapping("addDetail")
	@PreAuthorize("isAuthenticated()")
	public void addDetailForm(Integer hostId) {
		// 상세페이지 등록폼 view 포워드
	}

	@PostMapping("addDetail")
	public String addDetailProcess(Detail detail, RedirectAttributes rttr) throws Exception {
		// 상세페이지 등록 과정
		boolean ok = petsitterService.insertDetail(detail);

		if (ok) {
			// 상세페이지 최초 등록
			rttr.addFlashAttribute("message", "게시물이 성공적으로 등록되었습니다.");
		} else {
			// 상세페이지 재등록
			rttr.addFlashAttribute("message", "게시물이 등록되지 않았습니다.");
		}

		return "redirect:/petsitter/addHousePhotos?hostId=" + detail.getHostId();
	}

	@GetMapping("addHousePhotos")
	@PreAuthorize("isAuthenticated()")
	public void addHousePhotosForm(@RequestParam("hostId") Integer hostId) {
		// 상세페이지에 집사진 등록하는 폼 포워드 
	}

	@PostMapping("addHousePhotos")
	public String addHousePhotosProgress(
			@RequestParam("cover") MultipartFile cover,
			@RequestParam(value = "housePhotos", required = false) MultipartFile[] housePhotos,
			@RequestParam("hostId") Integer hostId) throws Exception {
		// 상세페이지에 집사진 등록하는 과
		Integer count = petsitterService.insertHousePhotos(housePhotos, hostId, cover);

		return "redirect:/petsitter/detail?id=" + hostId;
	}

	@GetMapping("modifyDetail")
	@PreAuthorize("isAuthenticated()")
	public void modifyDetailForm(@RequestParam("hostId") Integer hostId, Model model) {
		// 상세페이지 수정폼 view 포워드

		// 기존 상세페이지 정보 탐색
		Map<String, Object> info = petsitterService.selectById(hostId);
		model.addAllAttributes(info);

	}

	@PostMapping("modifyDetail")
	public String modifyProcess(Detail detail) throws Exception {
		// 상세페이지 수정 process
		boolean ok = petsitterService.modifyDetailDescription(detail);
		return "redirect:/petsitter/modifyHousePhotos?hostId=" + detail.getHostId();
	}

	@GetMapping("modifyHousePhotos")
	@PreAuthorize("isAuthenticated()")
	public void modifuHousePhtosForm(@RequestParam("hostId") Integer hostId, Model model) {
		// 상세페이지 집사진 수정폼 view 포워드

		// 기존 상세페이지 집사진 정보 탐색
		Map<String, Object> info = petsitterService.selectById(hostId);
		model.addAllAttributes(info);
	}

	@PostMapping("modifyHousePhotos")
	public String modifyHousePhotosProcess(
			Detail detail,
			@RequestParam(value = "addCover", required = false) MultipartFile addCover,
			@RequestParam(value = "removePhotos", required = false) List<String> removePhotos,
			@RequestParam(value = "addPhotos", required = false) MultipartFile[] addPhotos) throws Exception {
		// 집사진 수정 process
		petsitterService.modifyDetailHousePhotos(addCover, addPhotos, removePhotos, detail);
		return "redirect:/petsitter/detail?id=" + detail.getHostId();
	}

	@GetMapping("deleteDetail")
	@PreAuthorize("isAuthenticated()")
	public String deleteDetail(@RequestParam("hostId") Integer hostId) {
		boolean ok = petsitterService.deleteDetailByHostId(hostId);
		return "redirect:/petsitter/hostMyPage?id=" + hostId;
	}

}
