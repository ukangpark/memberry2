package com.example.demo.service;

import java.io.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.multipart.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Service
public class MyFeedService {

	@Autowired
	private MyFeedMapper mapper;
	
	public List<Feed> listMyFeed() {
		List<Feed> myFeed = mapper.selectAll();
		return myFeed;
	}

	public boolean addFeed(Feed feed, MultipartFile[] files) throws Exception {
		// 게시물 insert
		int cnt = mapper.insert(feed);
		
		for (MultipartFile file : files) {
			if (file.getSize() > 0) {
				// 파일 저장 (파일 시스템에)
				String folder = "C:\\study\\upload\\" + feed.getId();
				File targetFolder = new File(folder);
				if (!targetFolder.exists()) {
					targetFolder.mkdir();
				}
				
				String path = folder + "\\" + file.getOriginalFilename();
				File target = new File(path);
				file.transferTo(target);
				// DB에 관련 정보 저장(insert)
			}
		}
		
		return cnt == 1;
	}

	public Feed getFeed(Integer id) {
		return mapper.selectById(id);
	}
	
	
}
