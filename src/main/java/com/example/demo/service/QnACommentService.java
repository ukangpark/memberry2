package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Service
public class QnACommentService {

	@Autowired
	private QnACommentMapper mapper;
	
	public List<QnAComment> list(Integer qnaId) {
		return mapper.selectAllByQnAId(qnaId);
	}

	public void add(QnAComment qnacomment) {
		qnacomment.setMemberId("star");
		mapper.insert(qnacomment);
	}
	
}
