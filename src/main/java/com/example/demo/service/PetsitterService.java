package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.crypto.password.*;
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
	@Autowired
	private MemberMapper memberMapper;
	@Value("${aws.s3.bucketName}")
	private String bucketName;
	@Autowired
	private PasswordEncoder passwordEncoder;

	public Map<String, Object> selectAll() {
		// 전체 호스트 정보 탐색
		List<Host> host = petsitterMapper.selectHostAll();
		// 전체 상세페이지 정보 탐색
		List<Detail> detail = petsitterMapper.selectDetailAll();
		// 전체 집사진 정보 탐색
		List<HostHousePhoto> hostHousePhoto = petsitterMapper.selectHostHousePhotoAll();

		Map<String, Object> info = new HashMap<>();
		info.put("host", host);
		info.put("detail", detail);
		info.put("hostHousePhoto", hostHousePhoto);

		return info;
	}

	public Map<String, Object> selectByMemberId(String memberId) {
		// 호스트 아이디로 상세페이지와 호스트 정보탐색
		Map<String, Object> info = new HashMap<>();

		// 회원정보를 불러옴  
		Member member = memberMapper.selectById(memberId);
		
		// 호스트의 정보를 불러옴
		Host host = petsitterMapper.selectHostByMemberId(memberId);
		
		// 상세페이지 정보 불러옴
		Detail detail = petsitterMapper.selectDetailById(host.getId());
		
		// 호스트 집사진 정보를 불러옴
		if (detail != null) {
			// 등록된 상세페이지가 있다면 정보 조회
			List<HostHousePhoto> hostHousePhoto = petsitterMapper.selectHostHousePhotoByDetailId(detail.getId());
			info.put("hostHousePhoto", hostHousePhoto);

		}

		// map타입 변수 info에 넣음
		info.put("host", host);
		info.put("detail", detail);
		return info;
	}

	public Map<String, Object> selectByHostId(Integer hostId) {
		// 호스트 아이디로 상세페이지와 호스트 정보탐색
		Map<String, Object> info = new HashMap<>();

		// 호스트의 정보를 불러옴
		Host host = petsitterMapper.selectHostByHostId(hostId);
		
		// 상세페이지 정보 불러옴
		Detail detail = petsitterMapper.selectDetailById(hostId);
		
		// 호스트 집사진 정보를 불러옴
		if (detail != null) {
			// 등록된 상세페이지가 있다면 정보 조회
			List<HostHousePhoto> hostHousePhoto = petsitterMapper.selectHostHousePhotoByDetailId(detail.getId());
			info.put("hostHousePhoto", hostHousePhoto);

		}

		// map타입 변수 info에 넣음
		info.put("host", host);
		info.put("detail", detail);
		return info;
	}

	public Integer insertHost(Host host, MultipartFile file) throws Exception {
		Integer count = 0;

		// 호스트 정보 등록
		if (petsitterMapper.selectHostByMemberId(host.getMemberId()) == null) {
			// 호스트로 등록된 정보가 없으면 등록
			count = petsitterMapper.insertHost(host, file.getOriginalFilename());
			
			if(memberMapper.selectById(host.getMemberId()) == null) {
				// 호스트 등록하자마자 권한 등록
			petsitterMapper.insertHostAuthority(host.getId());	
			}
			
			System.out.println(host.getId());
			System.out.println(petsitterMapper.insertHostAuthority(host.getId()));
			// 호스트 프로필 사진 업로드
			if (file.getSize() > 0) {
				String key = "membery/hostProfile/" + host.getId() + "/" + file.getOriginalFilename();
				PutObjectRequest objectRequest = PutObjectRequest.builder().bucket(bucketName).key(key)
						.acl(ObjectCannedACL.PUBLIC_READ).build();

				s3.putObject(objectRequest, RequestBody.fromInputStream(file.getInputStream(), file.getSize()));
				System.out.println(key);
			}
		}

		return count;
	}

	public boolean modifyHostById(Host host, MultipartFile profile) throws Exception {
		Integer count = 0;

		// 호스트 수정페이지 프로필 사진 업로드
		if (profile.getSize() > 0) {
			String key = "membery/hostProfile/" + host.getId() + "/" + profile.getOriginalFilename();

			PutObjectRequest objectRequest = PutObjectRequest.builder().bucket(bucketName)
					.acl(ObjectCannedACL.PUBLIC_READ).key(key).build();

			s3.putObject(objectRequest, RequestBody.fromInputStream(profile.getInputStream(), profile.getSize()));
		}
		
		// 호스트 정보 수정
		count = petsitterMapper.modifyHostById(host, profile.getOriginalFilename());
		 
		return count == 1;
	}

	public boolean deleteHostById(Integer hostId, Member member) {
		Integer count = 0;
		
		Member memberInfo = memberMapper.selectById(member.getId());
		
		if (passwordEncoder.matches(member.getPassword(), memberInfo.getPassword())) {
			// 암호가 같으면 삭제 진행
			boolean ok = deleteDetailByHostId(hostId, member);
			
			if(ok) {
				// 호스트 정보 삭제
				count = petsitterMapper.deleteHostById(hostId);
				petsitterMapper.deleteHostAuthorityByMemberId(memberInfo.getId());
			}
		}
		// 암호가 다르면 삭제 안됨

		return count == 1;
	}

	public boolean insertDetail(Detail detail, String memberId) throws Exception {
		// 상세페이지 등록
		Integer count = 0;
		Integer hostId = petsitterMapper.selectHostByMemberId(memberId).getId();
		detail.setHostId(hostId);

		// 호스트 아이디로 상세페이지가 있는지 탐색
		if (selectByHostId(hostId).get("detail") == null) {
			// 없으면 상세페이지 추가
			count = petsitterMapper.insertDetail(detail);
		}

		return count == 1;
	}

	public Integer insertHousePhotos(MultipartFile[] housePhotos, Integer hostId, MultipartFile cover)
			throws Exception {
		int count = 0;

		// 상세페이지 아이디를 얻기 위한 메소드
		Detail detail = petsitterMapper.selectDetailById(hostId);
		
		// 대표 사진 추가
		if(cover.getSize() > 0) {
			String coverKey = "membery/cover/" + detail.getId() + "/" + cover.getOriginalFilename();
			PutObjectRequest objectRequestCover = PutObjectRequest.builder().bucket(bucketName).key(coverKey)
					.acl(ObjectCannedACL.PUBLIC_READ).build();
			s3.putObject(objectRequestCover, RequestBody.fromInputStream(cover.getInputStream(), cover.getSize()));
			// 대표 사진 테이블 추가
			
			petsitterMapper.insertCover(detail.getId(), cover.getOriginalFilename());
		}


		// 상세페이지 집사진 추가
		for (MultipartFile housePhoto : housePhotos) {
			if (housePhoto.getSize() > 0) {
				String key = "membery/hostHousePhoto/" + detail.getId() + "/" + housePhoto.getOriginalFilename();
				PutObjectRequest objectRequest = PutObjectRequest.builder().bucket(bucketName).key(key)
						.acl(ObjectCannedACL.PUBLIC_READ).build();
				s3.putObject(objectRequest,
						RequestBody.fromInputStream(housePhoto.getInputStream(), housePhoto.getSize()));

				// 상세페이지 집사진 이름 추가
				petsitterMapper.insertHostHousePhoto(housePhoto.getOriginalFilename(), detail.getId());

				count++;
			}
		}

		return count;
	}

	// 펫시터 전체목록
	public List<Host> listHost() {
		List<Host> list = petsitterMapper.selectAll();
		return list;
	}

	public boolean modifyDetailDescription(Detail detail) {
		// 내용 수정
		Integer count = petsitterMapper.modifyDetail(detail);

		return count == 1;
	}

	public Integer modifyDetailHousePhotos(
			MultipartFile addCover, 
			MultipartFile[] addPhotos, 
			List<String> removePhotos,
			Detail detail) throws Exception {
		
		Integer count = 0;
		// 커버사진 수정
		if (addCover.getSize() > 0) {
			// 새로운 커버 사진 aws 업로드
			String keyCover = "membery/cover/" + detail.getId() + "/" + addCover.getOriginalFilename();
			PutObjectRequest objectRequestCover = PutObjectRequest.builder().bucket(bucketName).key(keyCover)
					.acl(ObjectCannedACL.PUBLIC_READ).build();
			s3.putObject(objectRequestCover,
					RequestBody.fromInputStream(addCover.getInputStream(), addCover.getSize()));

			// 커버사진 테이블 추가
			petsitterMapper.insertCover(detail.getId(), addCover.getOriginalFilename());
		}

		// 집사진 수정
		// 추가할 사진은 추가하기
		for (MultipartFile addPhoto : addPhotos) {
			if (addPhoto.getSize() > 0) {
				// aws에 집사진 추가
				String keyDetail = "membery/hostHousePhoto/" + detail.getId() + "/" + addPhoto.getOriginalFilename();
				PutObjectRequest objectRequestDetail = PutObjectRequest.builder().bucket(bucketName).key(keyDetail)
						.acl(ObjectCannedACL.PUBLIC_READ).build();
				s3.putObject(objectRequestDetail,
						RequestBody.fromInputStream(addPhoto.getInputStream(), addPhoto.getSize()));

				// 집사진 테이블 추가
				petsitterMapper.insertHostHousePhoto(addPhoto.getOriginalFilename(), detail.getId());

				count++;
			}
		}

		// 삭제할 사진은 삭제하기
		if (removePhotos != null && !removePhotos.isEmpty()) {
			for (String removePhoto : removePhotos) {
				// aws에서 집사진 파일 삭제
				String keyDetail = "membery/hostHousePhoto/" + detail.getId() + "/" + removePhoto;
				DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder().bucket(bucketName)
						.key(keyDetail).build();

				s3.deleteObject(deleteObjectRequest);

				// 집사진 테이블 삭제
				Integer deletePhotocount = petsitterMapper.deleteHousePhotoByDetailIdAndPhotoName(detail.getId(),
						removePhoto);
				count--;
			}
		}

		return count;
	}

	public boolean deleteDetailByHostId(Integer hostId, Member member) {
		//비밀번호 일치/불일치 확인
		Integer count = 0;
		
		//기존의 정보 조회 
		Member oldMember = memberMapper.selectById(member.getId());
		
		if(passwordEncoder.matches(member.getPassword(), oldMember.getPassword())) {
			// 사용자가 입력한 비밀번호와 저장된 비밀번호가 같으면 작업 실행 
			
			// detailId 값을 가져옴
			Detail detail = petsitterMapper.selectDetailById(hostId);
			
			// 상세페이지 집사진 삭제
			// 집사진 이름 조회
			List<HostHousePhoto> hostHousePhotoes = petsitterMapper.selectHostHousePhotoByDetailId(detail.getId());
			
			for (HostHousePhoto hostHousePhoto : hostHousePhotoes) {
				// aws에서 집사진 삭제
				String key = "membery/hostHousePhoto/" + detail.getId() + "/" + hostHousePhoto.getHousePhoto();
				DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder().bucket(bucketName).key(key).build();
				
				s3.deleteObject(deleteObjectRequest);
				
			}
			
			// 집사진 테이블에서 정보 삭제
			Integer photoDeleteCount = petsitterMapper.deleteHostHousePhotoByDetailId(detail.getId());
			
			// aws에 커버사진 삭제
			String keyCover = "membery/cover/" + detail.getId() + "/" + detail.getCover();
			DeleteObjectRequest deleteObjectRequestCover = DeleteObjectRequest.builder().bucket(bucketName).key(keyCover)
					.build();
			
			s3.deleteObject(deleteObjectRequestCover);
			
			//petsitterComment 레코드 삭제 
			petsitterMapper.deleteCommentByDetailId(detail.getId());
			
			//book 레코드 삭제 
			petsitterMapper.deleteBookByDetailId(detail.getId());
			
			// 상세페이지 삭제
			count = petsitterMapper.deleteDetailByHostId(hostId);
		}
		

		return count == 1;
	}

	// 페이지네이션
	public Map<String, Object> listHost(Integer page, String search) {
		Integer rowPerPage = 8;

		Integer startIndex = (page - 1) * rowPerPage;

		Integer numOfRecords = petsitterMapper.countAll(search);

		Integer lastPageNumber = (numOfRecords - 1) / rowPerPage + 1;

		Integer leftPageNum = page - 5;

		leftPageNum = Math.max(leftPageNum, 1);

		Integer rightPageNum = leftPageNum + 9;

		rightPageNum = Math.min(rightPageNum, lastPageNumber);

		Map<String, Object> pageInfo = new HashMap<>();
		pageInfo.put("rightPageNum", rightPageNum);
		pageInfo.put("leftPageNum", leftPageNum);
		pageInfo.put("currentPageNum", page);
		pageInfo.put("lastPageNum", lastPageNumber);

		// 게시물 목록 넘겨주고
		List<Host> list = petsitterMapper.selectAllPaging(startIndex, rowPerPage, search);
		return Map.of("pageInfo", pageInfo, "petsitterList", list);

	}

	// 반려견 정보 가져오기
	public List<Registration> selectUserPet(String userId) {
		
		return petsitterMapper.selectUserPet(userId);
	}

}
