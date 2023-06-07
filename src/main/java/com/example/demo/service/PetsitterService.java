package com.example.demo.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.domain.Detail;
import com.example.demo.domain.Host;
import com.example.demo.domain.HostHousePhoto;
import com.example.demo.mapper.PetsitterMapper;

import software.amazon.awssdk.awscore.exception.AwsServiceException;
import software.amazon.awssdk.core.exception.SdkClientException;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.S3Exception;

@Service
public class PetsitterService {

	@Autowired
	private S3Client s3;
	@Autowired
	private PetsitterMapper petsitterMapper;
	@Value("${aws.s3.bucketName}")
	private String bucketName;

	public List<Host> selectAll() {
		// 전체 호스트 정보 탐색
		List<Host> host = petsitterMapper.selectHostAll();

		return host;
	}

	public Map<String, Object> selectById(Integer hostId) {
		// 호스트 아이디로 상세페이지와 호스트 정보탐색
		Map<String, Object> info = new HashMap<>();

		// 호스트의 정보를 불러옴
		Host host = petsitterMapper.selectHostById(hostId);

		// 상세페이지 정보 불러옴
		Detail detail = petsitterMapper.selectDetailById(hostId);

		// 호스트 집사진 정보를 불러옴
		List<HostHousePhoto> hostHousePhoto = petsitterMapper.selectHostHousePhotoByHostId(hostId);

		// map타입 변수 info에 넣음
		info.put("host", host);
		info.put("detail", detail);
		info.put("hostHousePhoto", hostHousePhoto);
		return info;
	}

	public Integer insertHost(Host host, MultipartFile file) throws Exception {

		// 호스트 정보 등록
		Integer count = petsitterMapper.insertHost(host, file.getOriginalFilename());

		// 호스트 프로필 사진 업로드
		String key = "hostProfile/" + file.getOriginalFilename();

		PutObjectRequest objectRequest = PutObjectRequest.builder().bucket(bucketName).key(key)
				.acl(ObjectCannedACL.PUBLIC_READ).build();

		s3.putObject(objectRequest, RequestBody.fromInputStream(file.getInputStream(), file.getSize()));

		return count;
	}

	public boolean modifyHostById(Host host, MultipartFile file) throws Exception {
		// 호스트 수정페이지 프로필 사진 업로드
		String key = "hostProfile/" + file.getOriginalFilename();

		PutObjectRequest objectRequest = PutObjectRequest.builder().bucket(bucketName).acl(ObjectCannedACL.PUBLIC_READ)
				.key(key).build();

		s3.putObject(objectRequest, RequestBody.fromInputStream(file.getInputStream(), file.getSize()));

		// 호스트 정보 수정
		Integer count = petsitterMapper.modifyHostById(host, file.getOriginalFilename());
		return count == 1;
	}

	public boolean deleteHostById(Integer hostId) {
		// 해당 호스트 상세페이지 삭제
		petsitterMapper.deleteDetailByHostId(hostId);

		// 호스트 정보 삭제
		Integer count = petsitterMapper.deleteHostById(hostId);

		return count == 1;
	}

	public boolean insertDetail(Detail detail, MultipartFile[] housePhotoes) throws Exception {
		// 상세페이지 등록
		Integer count;
		// 호스트 아이디로 상세페이지가 있는지 탐색
		if (selectById(detail.getHostId()).get("detail") == null) {
			// 없으면 상세페이지 추가
			count = petsitterMapper.insertDetail(detail);

			// 상세페이지 집사진 추가
			for (MultipartFile housePhoto : housePhotoes) {
				String key = "hostHousePhoto/" + detail.getHostId() + "/" + housePhoto.getOriginalFilename();
				PutObjectRequest objectRequest = PutObjectRequest.builder().bucket(bucketName).key(key)
						.acl(ObjectCannedACL.PUBLIC_READ).build();
				s3.putObject(objectRequest,
						RequestBody.fromInputStream(housePhoto.getInputStream(), housePhoto.getSize()));

				// 상세페이지 집사진 이름 추가
				petsitterMapper.insertHostHousePhoto(housePhoto.getOriginalFilename(), detail.getHostId());
			}
		} else {
			// 있으면 추가 안됨
			count = 0;
		}
		return count == 1;
	}

	public List<Host> listHost() {
		List<Host> list = petsitterMapper.selectAll();
		return list;
	}

	public boolean modifyDetail(Detail detail, MultipartFile[] housePhotoes) throws Exception {
		// 상세페이지 수정
		Integer count = petsitterMapper.modifyDetail(detail);

		// 집사진 수정
		// hostId로 집사진이 있는지 탐색
		Integer housePhotoCount = petsitterMapper.housePhotoCount(detail.getHostId());

		if (housePhotoCount == 0) {
			// 집사진이 없는 상세페이지이면
			// 상세페이지 집사진 추가
			for (MultipartFile housePhoto : housePhotoes) {
				String key = "hostHousePhoto/" + detail.getHostId() + "/" + housePhoto.getOriginalFilename();
				PutObjectRequest objectRequest = PutObjectRequest.builder().bucket(bucketName).key(key)
						.acl(ObjectCannedACL.PUBLIC_READ).build();
				s3.putObject(objectRequest, RequestBody.fromInputStream(housePhoto.getInputStream(), housePhoto.getSize()));

				// 상세페이지 집사진 이름 추가
				petsitterMapper.insertHostHousePhoto(housePhoto.getOriginalFilename(), detail.getHostId());
			}

		} else {
			// 집사진이 있는 상세페이지라면 
			//원래 있던 집사진 삭제 후 추가
			
		}

		return count == 1;
	}

	public boolean deleteDetailByHostId(Integer hostId) {
		Integer count = petsitterMapper.deleteDetailByHostId(hostId);

		return count == 1;
	}

}
