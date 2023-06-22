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
	
	@Autowired
	private AlarmMapper alarmMapper;
	
	public List<QnA> qnaList(){
		List<QnA> list = mapper.selectAll();
		return list;
	}

	public QnA getQnA(Integer id, Authentication authentication) {
		QnA qna = mapper.selectById(id);
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
		if (cnt == 1) {
			alarmMapper.qnaAdd(qna);
		}
		return cnt == 1;
	}

	public QnA getQnA(Integer id) {
		
		return getQnA(id, null);
	}
	
}
