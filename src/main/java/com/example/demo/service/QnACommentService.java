package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Service
@Transactional(rollbackFor = Exception.class)
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

	public void remove(Integer id) {
		mapper.deleteById(id);
	}

	public QnAComment get(Integer id) {
		
		return mapper.selectById(id);
	}

	public void update(QnAComment qnacomment) {
		mapper.update(qnacomment);
	} 
	
}
