package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.domain.Feed;
import com.example.demo.domain.Search;
import com.example.demo.mapper.SearchMapper;

@Service
public class SearchService {

	@Autowired
	private SearchMapper mapper;
	
	public List<Search> search(String search) {
		return mapper.selectAllBySearch(search);
	}

}
