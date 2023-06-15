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
		
		return petsitterCommentMapper.selectAllByDetailId(detailId);
	}

	public void add(PetsitterComment petsitterComment, Authentication authentication) {
			// 후기 등록 
			
			//자바빈에 memberId 넣어줌 
			petsitterComment.setMemherId(authentication.getName());
			
			//mapper를 통해서 데이터를 넣어줌
			Integer count = petsitterCommentMapper.insert(petsitterComment);
		
		
	}
}
