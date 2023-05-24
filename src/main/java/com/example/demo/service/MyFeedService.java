package com.example.demo.service;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.example.demo.mapper.*;

@Component
public class MyFeedService {

	@Autowired
	private MyFeedMapper mapper;
	
	
}
