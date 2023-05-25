package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.domain.Feed;
import com.example.demo.mapper.MyFeedMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectAclRequest;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
@Transactional(rollbackFor = Exception.class)
public class MyFeedService {

	@Autowired
	private S3Client s3;
	
	@Value("${aws.s3.bucketName}")
	private String bucketName;
	
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
				String objectKey = "membery/" + feed.getId() + "/" + file.getOriginalFilename();
				PutObjectRequest por = PutObjectRequest.builder()
						.bucket(bucketName)
						.key(objectKey)
						.acl(ObjectCannedACL.PUBLIC_READ)
						.build();
				RequestBody rb = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
				
				s3.putObject(por, rb);
				
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
