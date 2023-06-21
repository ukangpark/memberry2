package com.example.demo.security;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.core.*;
import org.springframework.stereotype.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Component
public class CustomSecurityChecker {
	
	@Autowired
	private MyFeedMapper mapper;
	
	@Autowired
	private CommentMapper commentMapper;
	
	@Autowired
	private QnAMapper qnaMapper;
	
	public boolean checkFeedWriter(Authentication authentication, Integer feedId) {
		Feed feed = mapper.selectById(feedId);
		
		String username = authentication.getName();
		String writer = feed.getWriter();
		
		return username.equals(writer);
	}
	
	public boolean checkQnAWriter(Authentication authentication, String qnaWriter) {
		QnA qna = qnaMapper.selectById(qnaWriter);
		return qna.getWriter().equals(authentication.getName());
	}
	
	public boolean checkCommentWriter(Authentication authentication, Integer commentId) {
		Comment comment = commentMapper.selectById(commentId);
		return comment.getMemberId().equals(authentication.getName());
	}
	
}
