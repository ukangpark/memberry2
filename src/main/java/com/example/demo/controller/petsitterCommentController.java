package com.example.demo.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.security.access.prepost.*;
import org.springframework.security.core.*;
import org.springframework.web.bind.annotation.*;

import com.example.demo.domain.*;
import com.example.demo.service.*;

@RestController
@RequestMapping("petsitterComment")
public class petsitterCommentController {

	@Autowired
	private PetsitterCommentService petsitterCommentService;

	@GetMapping("list")
	public List<PetsitterComment> list(@RequestParam("detailId") Integer detailId, Authentication authentication) {
		// 해당 상세페이지의 후기를 조회함
		List<PetsitterComment> list = petsitterCommentService.list(detailId, authentication);
		System.out.println("list controller working");
		return list;
	}

	@PostMapping("add")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<Map<String, Object>> add(@RequestBody PetsitterComment petsitterComment,
			Authentication authentication) {
		
		System.out.println("add conttoller : " + petsitterComment);

		if (authentication == null) {
			Map<String, Object> res = Map.of("message", "로그인 후 댓글을 작성해주세요.");
			return ResponseEntity.status(401).body(res);
		} else {
			// 후기 등록
			Map<String, Object> res = petsitterCommentService.add(petsitterComment, authentication);

			return ResponseEntity.ok().body(res);
		}

		
	}

	@DeleteMapping("delete/{id}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<Map<String, Object>> delete(@PathVariable("id") Integer commentId) {
		// 후기 삭제
		Map<String, Object> res = petsitterCommentService.delete(commentId);
		System.out.println("delete controller : " + res + ", " + commentId);
		return ResponseEntity.ok().body(res);
	}

	@GetMapping("get/{id}")
	public PetsitterComment modify(@PathVariable("id") Integer commentId) {
		PetsitterComment petsitterComment = petsitterCommentService.selectComment(commentId);
		System.out.println("get controller : " + petsitterComment);
		return petsitterComment;
	}

	@PutMapping("modify/{id}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<Map<String, Object>> modify(
			@RequestBody PetsitterComment petsitterComment, 
			Authentication authentication) {

		Map<String, Object> res = petsitterCommentService.modifyComment(petsitterComment, authentication);

		System.out.println("modify controller : " + petsitterComment);

		return ResponseEntity.ok().body(res);
	}
}
