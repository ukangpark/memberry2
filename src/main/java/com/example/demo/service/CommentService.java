package com.example.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.domain.Comment;
import com.example.demo.domain.Member;
import com.example.demo.mapper.AlarmMapper;
import com.example.demo.mapper.CommentMapper;
import com.example.demo.mapper.MemberMapper;

import jakarta.servlet.http.HttpSession;

@Service
@Transactional(rollbackFor = Exception.class)
public class CommentService {

	
	  @Autowired 
	  private CommentMapper mapper;
	  
	  @Autowired
	  private AlarmMapper alarmMapper;
	  
	  @Autowired
	  private MemberMapper memberMapper;
	
	  
	  public List<Comment> list(Integer feedId, Authentication authentication) {
		  List<Comment> comments = mapper.selectAllByFeedId(feedId);
		  if (authentication != null) {
			  for (Comment comment : comments) {
				  comment.setEditable(comment.getMemberId().equals(authentication.getName()));
			  }
		  }
		  return comments;
	  }

	public  Map<String, Object> add(Comment comment, Authentication authentication, HttpSession session) {
		comment.setMemberId(authentication.getName());
		
		var res  = new HashMap<String, Object>();
		int cnt = mapper.insert(comment);
		
		if (cnt == 1) {
			res.put("message", "댓글 등록 완료");
			Integer alarmCnt = alarmMapper.commentAdd(comment);
			
			if (alarmCnt == 1) {
				Member member = memberMapper.selectById(authentication.getName());
				session.setAttribute("logedInMember", member);				
			}
			
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
	 
}
