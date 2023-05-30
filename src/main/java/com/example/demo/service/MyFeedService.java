package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;
import org.springframework.web.multipart.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

import software.amazon.awssdk.core.sync.*;
import software.amazon.awssdk.services.s3.*;
import software.amazon.awssdk.services.s3.model.*;

@Service
@Transactional(rollbackFor = Exception.class)
public class MyFeedService {

	@Autowired
	private S3Client s3;
	
	@Value("${aws.s3.bucketName}")
	private String bucketName;
	
	@Autowired
	private MyFeedMapper mapper;
	
	public List<File> listMyFeed() {
		List<File> file = mapper.selectAll();
		return file;
	}

	public boolean addFeed(Feed feed, MultipartFile[] files) throws Exception {
		// 게시물 insert
		int cnt = mapper.insert(feed);
		
		for (MultipartFile file : files) {
			if (file.getSize() > 0) {
				// S3 저장소 사용을 위한 키
				String objectKey = "membery/" + feed.getId() + "/" + file.getOriginalFilename();
				PutObjectRequest por = PutObjectRequest.builder()
						.bucket(bucketName)
						.key(objectKey)
						.acl(ObjectCannedACL.PUBLIC_READ)
						.build();
				RequestBody rb = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
				
				s3.putObject(por, rb);
				
				// DB에 관련 정보 저장(insert)
				mapper.insertFileName(feed.getId(), file.getOriginalFilename());
			}
		}
		
		return cnt == 1;
	}

	public Feed getPost(Integer id) {
		return mapper.selectById(id);
	}

	public boolean modify(Feed feed) {
		int cnt = mapper.update(feed);
		return cnt == 1;
	}

	public boolean remove(Integer id) {
		//파일명 조회(데이터 지울 때 필요하여 미리 조회)
		List<String> fileNames = mapper.selectFileNamesByFeedId(id);
		
		// File 테이블의 데이터 지우기(외래키 제약 사항 위배 안 되게 하려고)
		mapper.deleteFileNameByFeedId(id);
		
		// S3 bucket의 데이터 지우기
		for(String fileName : fileNames) {
			String objectKey = "membery/" + id + "/" + fileName;
			DeleteObjectRequest dor = DeleteObjectRequest.builder()
					.bucket(bucketName)
					.key(objectKey)
					.build();
			s3.deleteObject(dor);
		}
		
		// 마이피드 테이블의 데이터 지우기
		int cnt = mapper.deleteById(id);
		return cnt == 1;
	}

	
}
