package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.domain.Comment;
import com.example.demo.mapper.CommentMapper;

@Service
public class CommentService {
	
	@Autowired
	private CommentMapper mapper;

	public List<Comment> list(Integer feedId) {
		return mapper.selectAllByFeedId(feedId);
	}

	public void add(Comment comment) {
		comment.setMemberId("123");
		mapper.insert(comment);
		
	}

	
}
