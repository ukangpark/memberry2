package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.core.*;
import org.springframework.stereotype.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Service
public class HomeService {

	@Autowired
	private HomeMapper mapper;
	
	public List<Feed> listFeed() {
		List<Feed> list = mapper.selectAll();
		return list;
	}
	
}
