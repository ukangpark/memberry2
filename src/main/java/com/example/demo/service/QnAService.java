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
	private QnACommentMapper cmapper;
	
	@Autowired
	private AlarmMapper alarmMapper;
	
	public Map<String, Object> qnaList(Integer page, String search){
		Integer recordsInQnA = 10;
		
		Integer startIndex = (page -1) * recordsInQnA;
		
		Integer countAllQnA = mapper.countAll();
		
		Integer lastPageNum = (countAllQnA - 1) / recordsInQnA + 1;
		
		Integer leftPageNum = page - 3;
		leftPageNum = Math.max(leftPageNum, 1);
		
		Integer rightPageNum = page + 2;
		rightPageNum = Math.min(rightPageNum, lastPageNum);
		
		Map<String, Object> pageInfo = new HashMap<>();
		pageInfo.put("leftPageNum", leftPageNum);
		pageInfo.put("rightPageNum", rightPageNum);
		pageInfo.put("currentPageNum", page);
		pageInfo.put("lastPageNum", lastPageNum);
		
		List<QnA> list = mapper.selectAllPage(startIndex, recordsInQnA, search);
		return Map.of("pageInfo", pageInfo,
					  "qnaList", list);
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
		
		// 댓글 테이블 지우기
		cmapper.deleteByQnAId(id);
		
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
