package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Service
public class PetsitterService {
	
	@Autowired
	private PetsitterMapper petsitterMapper;
	
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
		Integer count = petsitterMapper.insertHost(host);
		
		return count;
	}

	public boolean modifyById(Host host) {
		Integer count = petsitterMapper.modifyById(host);
		return count == 1;
	}

	public boolean deleteHostById(Integer hostId) {
		Integer count = petsitterMapper.deleteHostById(hostId);
		
		return count == 1;
	}

	public boolean insertDetail(Detail detail) {
		Integer count = petsitterMapper.insertDetail(detail);
		return count == 1;
	}

	// 펫시터 전체목록
	public List<Host> listHost(){
		List<Host> list = petsitterMapper.selectAll();
		return list;
	}

	//페이지네이션
		public Map<String, Object> listHost(Integer page, String search) {
			Integer rowPerPage = 8;
			
			Integer startIndex = (page-1) * rowPerPage;
			
			Integer numOfRecords =petsitterMapper.countAll(search);
			
			Integer lastPageNumber = (numOfRecords-1) / rowPerPage +1;
			
			
			Integer leftPageNum = page - 5;
			
			leftPageNum = Math.max(leftPageNum, 1);
			
			
			Integer rightPageNum = leftPageNum +9;  
			
			rightPageNum = Math.min(rightPageNum, lastPageNumber);
			
			Map<String, Object> pageInfo = new HashMap<>();
			pageInfo.put("rightPageNum", rightPageNum);
			pageInfo.put("leftPageNum", leftPageNum);
			pageInfo.put("currentPageNum", page);
			pageInfo.put("lastPageNum", lastPageNumber);
			
			// 게시물 목록 넘겨주고
			List<Host> list = petsitterMapper.selectAllPaging(startIndex, rowPerPage, search);
					return Map.of("pageInfo", pageInfo,
								  "petsitterList", list);
			
		}

	
	
	
	
	

}
