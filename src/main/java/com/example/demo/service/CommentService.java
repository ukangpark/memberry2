package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Service
@Transactional(rollbackFor = Exception.class)
public class CommentService {

	
	  @Autowired 
	  private CommentMapper mapper;
	  
	  
	  public List<Comment> list(Integer feedId, Authentication authentication) {
		  List<Comment> comments = mapper.selectAllByFeedId(feedId);
		  if (authentication != null) {
			  for (Comment comment : comments) {
				  comment.setEditable(comment.getMemberId().equals(authentication.getName()));
			  }
		  }
		  return comments;
	  }

	public  Map<String, Object> add(Comment comment, Authentication authentication) {
		comment.setMemberId(authentication.getName());
		
		var res  = new HashMap<String, Object>();
		int cnt = mapper.insert(comment);
		
		if (cnt == 1) {
			res.put("message", "댓글 등록 완료");
		} else {
			res.put("message", "댓글 등록 실패");
		}
		return res;
	}
	
	 public Map<String, Object> delete(Integer id) { 
		 int cnt = mapper.deleteById(id);
		 var res = new HashMap<String, Object>();
		 
		 if(cnt == 1) {
			res.put("message", "댓글 삭제 완료");
		}else {
			res.put("message", "댓글 삭제 오류");
		}
		return res;
	}
	 
	 public Comment get(Integer id) {
		return mapper.selectById(id); 
	}
	
	 public Map<String, Object> update(Comment comment) { 
		int cnt =  mapper.updateById(comment);
		
		var res = new HashMap<String, Object>();
		
		if(cnt == 1) {
			res.put("message", "댓글 수정 완료");
		} else {
			res.put("message", "댓글 수정 오류");
		}
		return res;
	 }
	 
	  
	 
	
	 
	

	/*
	 * public Comment get(Integer id) { return mapper.selectById(id); }
	 * 
	 * public Map<String, Object> add(Comment comment, Authentication
	 * authentication) { comment.setMemberId(authentication.getName()); var res =
	 * new HashMap<String, Object>(); int cnt = mapper.insert(comment);
	 * 
	 * if(cnt == 1) { res.put("messgae", "댓글이 등록되었습니다."); } else {
	 * res.put("messgae", "댓글이 등록되지 않았습니다."); } return res; }
	 * 
	 * public Map<String, Object> remove(Integer id) { int cnt =
	 * mapper.deleteById(id); var res = new HashMap<String, Object>();
	 * 
	 * if(cnt == 1) { res.put("messgae", "댓글이 삭제되었습니다."); } else {
	 * res.put("messgae", "댓글이 삭제되지 않았습니다."); } return res;
	 * 
	 * }
	 * 
	 * public Map<String, Object> update(Comment comment) { int cnt =
	 * mapper.update(comment); var res = new HashMap<String, Object>(); if(cnt == 1)
	 * { res.put("messgae", "댓글이 수정되었습니다."); } else { res.put("messgae",
	 * "댓글이 수정되지 않았습니다."); } return res;
	 * 
	 * }
	 */

}
