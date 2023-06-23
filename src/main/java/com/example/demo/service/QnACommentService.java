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
public class QnACommentService {

	@Autowired
	private QnACommentMapper mapper;
	@Autowired
	private AlarmMapper alarmMapper;
	
	public List<QnAComment> list(Integer qnaId, Authentication auth) {
		List<QnAComment> comments = mapper.selectAllByQnAId(qnaId);
		
		if(auth != null) {
			for (QnAComment comment : comments) {
				comment.setEditable(comment.getMemberId().equals(auth.getName()));
			}
		}
		
		return comments;
	}


	public Map<String, Object> add(QnAComment qnacomment, Authentication auth) {
		qnacomment.setMemberId(auth.getName());
		
		var res = new HashMap<String, Object>();
		
		int cnt = mapper.insert(qnacomment);
		if (cnt == 1) {
			res.put("message", "댓글이 등록되었습니다.");
		} else {
			res.put("message", "댓글이 등록되지 않았습니다.");
		}
		
		return res; 

	}

	public Map<String, Object> remove(Integer id) {
		int cnt = mapper.deleteById(id);
	
		var res = new HashMap<String, Object>();
		
		if (cnt == 1) {
			res.put("message", "댓글이 삭제되었습니다.");
		} else {
			res.put("message", "댓글이 삭제되지 않았습니다.");
		}
		return res;
	}

	public QnAComment get(Integer id) {
		
		return mapper.selectById(id);
	}

	public Map<String, Object> update(QnAComment qnacomment) {
		int cnt = mapper.update(qnacomment);
		var res = new HashMap<String, Object>();
		if (cnt == 1) {
			res.put("message", "댓글이 수정되었습니다.");
		} else {
			res.put("message", "댓글이 수정되지 않았습니다.");
		}
		return res;
		
	} 
	
}
