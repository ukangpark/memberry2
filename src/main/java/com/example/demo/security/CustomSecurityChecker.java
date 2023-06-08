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
	
	public boolean checkFeedWriter(Authentication authentication, Integer feedId) {
		Feed feed = mapper.selectById(feedId);
		
		String username = authentication.getName();
		String writer = feed.getWriter();
		
		return username.equals(writer);
	}
}
