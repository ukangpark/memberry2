package com.example.demo.service;

import java.io.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;
import org.springframework.web.multipart.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Service
@Transactional(rollbackFor = Exception.class)
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
				// S3 저장소 사용을 위한 키
				String objectKey = "feed/" + feed.getId() + "/" + file.getOriginalFilename();
				
				// 파일 저장 (파일 시스템에)
				// 폴더 만들기
				String folder = "C:\\study\\upload\\" + feed.getId();
				File targetFolder = new File(folder);
				if (!targetFolder.exists()) {
					targetFolder.mkdir();
				}
				
				String path = folder + "\\" + file.getOriginalFilename();
				File target = new File(path);
				file.transferTo(target);
				// DB에 관련 정보 저장(insert)
				mapper.insertFileName(feed.getId(),file.getOriginalFilename());
			}
		}
		
		return cnt == 1;
	}

	public Feed getFeed(Integer id) {
		return mapper.selectById(id);
	}
	
	
}
