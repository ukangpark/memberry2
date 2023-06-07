package com.example.demo.service;


import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.multipart.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

import software.amazon.awssdk.core.sync.*;
import software.amazon.awssdk.services.s3.*;
import software.amazon.awssdk.services.s3.model.*;

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
		List<HostHousePhoto> hostHousePhoto = petsitterMapper.selectHostHousePhotoByHostId(detail.getId());

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
				String key = "hostHousePhoto/" + detail.getId() + "/" + housePhoto.getOriginalFilename();
				System.out.println("상세페이지 아이디 mybatis : " + detail.getId());
				PutObjectRequest objectRequest = PutObjectRequest.builder().bucket(bucketName).key(key)
						.acl(ObjectCannedACL.PUBLIC_READ).build();
				s3.putObject(objectRequest,
						RequestBody.fromInputStream(housePhoto.getInputStream(), housePhoto.getSize()));

				// 상세페이지 집사진 이름 추가
				petsitterMapper.insertHostHousePhoto(housePhoto.getOriginalFilename(), detail.getId());
			}
		} else {
			// 있으면 추가 안됨
			count = 0;
		}
		return count == 1;
	}

	// 펫시터 전체목록
	public List<Host> listHost(){
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
				String key = "hostHousePhoto/" + detail.getId() + "/" + housePhoto.getOriginalFilename();
				PutObjectRequest objectRequest = PutObjectRequest.builder().bucket(bucketName).key(key)
						.acl(ObjectCannedACL.PUBLIC_READ).build();
				s3.putObject(objectRequest, RequestBody.fromInputStream(housePhoto.getInputStream(), housePhoto.getSize()));

				// 상세페이지 집사진 이름 추가
				petsitterMapper.insertHostHousePhoto(housePhoto.getOriginalFilename(), detail.getId());
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
