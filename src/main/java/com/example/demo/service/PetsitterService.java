package com.example.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.domain.Detail;
import com.example.demo.domain.Host;
import com.example.demo.mapper.PetsitterMapper;

@Service
public class PetsitterService {
	
	@Autowired
	PetsitterMapper petsitterMapper;
	
	public List<Host> selectAll() {
		
		List<Host> host = petsitterMapper.selectHostAll();
		
		
		return host;
	}
	
	public Map<String, Object> selectById(Integer hostId) {
		Map<String, Object> info = new HashMap<>();
		
		// 상세페이지 정보 불러옴 
		Detail detail = petsitterMapper.selectDetailById(hostId);
		
		// 호스트의 정보를 불러옴 
		Host host = petsitterMapper.selectHostById(hostId);
		
		// map타입 변수 info에 넣음 
		info.put("host", host);
		info.put("detail", detail);
		return info;
	}
	
	public Integer insertHost(Host host) {
		int count = petsitterMapper.insertHost(host);
		
		return count;
	}


}
