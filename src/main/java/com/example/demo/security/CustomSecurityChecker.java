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
	
	@Autowired
	private QnACommentMapper qnacommentMapper;
	
	@Autowired
	private PetsitterMapper petsitterMapper;
	
	public boolean checkFeedWriter(Authentication authentication, Integer feedId) {
		Feed feed = mapper.selectById(feedId);
		
		String username = authentication.getName();
		String writer = feed.getWriter();
		
		return username.equals(writer);
	}
	
	public boolean checkQnAWriter(Authentication authentication, Integer qnaId) {
		QnA qna = qnaMapper.selectById(qnaId);
		return qna.getWriter().equals(authentication.getName());
	}
	
	public boolean checkQnACommentWriter(Authentication authentication, Integer qnacommentId) {
		QnAComment qnacomment = qnacommentMapper.selectById(qnacommentId);
		return qnacomment.getMemberId().equals(authentication.getName());
	}
	
	public boolean checkCommentWriter(Authentication authentication, Integer commentId) {
		Comment comment = commentMapper.selectById(commentId);
		return comment.getMemberId().equals(authentication.getName());
	}
	
	public boolean checkPetsitterWriter(Authentication authentication, Integer hostId) {
		Host host = petsitterMapper.selectHostByHostId(hostId);
		return host.getMemberId().equals(authentication.getName());
	}
	
	
}
