package com.example.demo.service;

import java.time.LocalDate;
import java.time.Period;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.domain.Registration;
import com.example.demo.mapper.MyPetsMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class MyPetsService {

	@Autowired
	private MyPetsMapper mapper;

	@Autowired
	private S3Client s3;

	@Value("${aws.s3.bucketName}")
	private String bucketName;

	public Map<String, Object> petsList(Authentication auth) {

		List<Registration> list = mapper.selectAll(auth.getName());

		// 날짜계산
		var now = LocalDate.now();
		for (Registration r : list) {
			r.setDiff(Period.between(r.getTogether(), now));
		}

		return Map.of("petsList", list);
	}

	public Registration getPet(Integer id) {
		return mapper.selectById(id);
	}

	public boolean modify(Registration registration, MultipartFile addFile) throws Exception {

		// 새 파일 추가
		// aws s3에 업로드
		if (addFile.getSize() > 0) {
			String objectKey = "membery/" + registration.getId() + "/" + addFile.getOriginalFilename();
			PutObjectRequest por = PutObjectRequest.builder().bucket(bucketName).key(objectKey)
					.acl(ObjectCannedACL.PUBLIC_READ).build();
			RequestBody rb = RequestBody.fromInputStream(addFile.getInputStream(), addFile.getSize());
			s3.putObject(por, rb);
			
		}

		// 테이블에 새로운 파일 추가, 수정
		int cnt = mapper.update(registration, addFile.getOriginalFilename());
		return cnt == 1;
	}

	public boolean remove(Integer id) {

		// 파일명 조회
		List<String> fileName = mapper.selectPhotoById(id);

		// s3에서 삭제
		String objectKey = "membery/" + id + "/" + fileName;
		DeleteObjectRequest dor = DeleteObjectRequest.builder().bucket(bucketName).key(objectKey).build();
		s3.deleteObject(dor);

		int cnt = mapper.deleteById(id);

		return cnt == 1;
	}

	public boolean profileImage(String profileImageName, Authentication auth) {
		
		int cnt = mapper.updateProfileByMemberId(profileImageName,auth.getName());
		
		return cnt == 1;
				
	}

}
