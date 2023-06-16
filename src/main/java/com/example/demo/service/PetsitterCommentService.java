package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.core.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Service
@Transactional(rollbackFor = Exception.class)
public class PetsitterCommentService {

	@Autowired
	private PetsitterCommentMapper petsitterCommentMapper;

	public List<PetsitterComment> list(Integer detailId) {
		// 상세페이지id를 통해 후기 전체 조회
		return petsitterCommentMapper.selectAllByDetailId(detailId);
	}

	public boolean add(PetsitterComment petsitterComment, Authentication authentication) {
		// 후기 등록

		// 자바빈에 memberId 넣어줌
		petsitterComment.setMemberId(authentication.getName());
		System.out.println(petsitterComment);
		// mapper를 통해서 데이터를 넣어줌
		Integer count = petsitterCommentMapper.add(petsitterComment);

		return count == 1;
	}

	public void delete(Integer commentId, Authentication authentication) {
		// 후기 삭제 
		petsitterCommentMapper.delete(commentId);
	}
}
