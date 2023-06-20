package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Service
public class QnAService {
	
	@Autowired
	private QnAMapper mapper;
	
	public List<QnA> qnaList(){
		List<QnA> list = mapper.selectAll();
		return list;
	}

	public QnA getQnA(Integer id) {
		return mapper.selectById(id);
	}

	public boolean modify(QnA qna) {
		int cnt = mapper.update(qna);
		
		return cnt == 1;
	}
	
}
