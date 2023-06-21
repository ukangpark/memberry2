package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.core.*;
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

	public QnA getQnA(String writer, Authentication authentication) {
		QnA qna = mapper.selectById(writer);
		return qna;
	}

	public boolean modify(QnA qna) {
		int cnt = mapper.update(qna);
		
		return cnt == 1;
	}

	public boolean remove(Integer id) {
		int cnt = mapper.deleteById(id);
		return cnt == 1;
	}

	public boolean addQnA(QnA qna) throws Exception{
		int cnt = mapper.insert(qna);
		return cnt == 1;
	}

	public QnA getQnA(String writer) {
		
		return getQnA(writer, null);
	}
	
}
