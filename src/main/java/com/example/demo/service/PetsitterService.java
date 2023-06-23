package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.core.*;
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
	@Autowired
	private BookMapper bookMapper;
	@Value("${aws.s3.bucketName}")
	private String bucketName;
	@Autowired
	private PasswordEncoder passwordEncoder;

	public Map<String, Object> selectAll(Integer page) {
		// 페이지네이션
		Integer rowPerPage = 10; // 페이지당 행의 수

		// 쿼리 LIMIT 절에 사용할 시작 인덱스
		Integer startIndex = (page - 1) * rowPerPage;

		// 페이지네이션이 필요한 정보
		// 전체 레코드 수
		Integer numOfRecords = petsitterMapper.countAllHost();
		// 마지막 페이지 번호
		Integer lastPageNumber = (numOfRecords - 1) / rowPerPage + 1;
		// 페이지네이션 왼쪽번호
		Integer leftPageNum = page - 5;
		// 1보다 작을 수 없음
		leftPageNum = Math.max(leftPageNum, 1);

		// 페이지네이션 오른쪽번호
		Integer rightPageNum = leftPageNum + 9;
		// 마지막페이지보다 클 수 없음
		rightPageNum = Math.min(rightPageNum, lastPageNumber);

		// 전체 호스트 정보 탐색
		List<Host> host = petsitterMapper.selectHostAll(startIndex, rowPerPage);
		// 전체 상세페이지 정보 탐색
		List<Detail> detail = petsitterMapper.selectDetailAll();
		// 전체 집사진 정보 탐색
		List<HostHousePhoto> hostHousePhoto = petsitterMapper.selectHostHousePhotoAll();

		Map<String, Object> info = new HashMap<>();
		info.put("host", host);
		info.put("detail", detail);
		info.put("hostHousePhoto", hostHousePhoto);
		info.put("rightPageNum", rightPageNum);
		info.put("leftPageNum", leftPageNum);
		info.put("currentPageNum", page);
		info.put("lastPageNum", lastPageNumber);

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
		if (host != null) {
			// 호스트로 등록이 되어있으면 상세페이지 조회
			Detail detail = petsitterMapper.selectDetailById(host.getId());
			info.put("detail", detail);

			// 호스트 집사진 정보를 불러옴
			if (detail != null) {
				// 등록된 상세페이지가 있다면 정보 조회
				List<HostHousePhoto> hostHousePhoto = petsitterMapper.selectHostHousePhotoByDetailId(detail.getId());
				info.put("hostHousePhoto", hostHousePhoto);

			}
		}

		// map타입 변수 info에 넣음
		info.put("host", host);
		info.put("member", member);
		return info;
	}

	public Map<String, Object> selectByHostId(Integer hostId, Authentication authentication) {
		// 호스트 아이디로 상세페이지와 호스트 정보탐색
		Map<String, Object> info = new HashMap<>();

		// 회원의 아이디로 회원 정보를 불러옴
		Member member = memberMapper.selectById(authentication.getName());

		// hostId로 호스트의 정보를 불러옴
		Host host = petsitterMapper.selectHostByHostId(hostId);

		// hostId로 상세페이지 정보 불러옴
		Detail detail = petsitterMapper.selectDetailById(hostId);

		// 호스트 집사진 정보를 불러옴
		if (detail != null) {
			// 등록된 상세페이지가 있다면 정보 조회
			List<HostHousePhoto> hostHousePhoto = petsitterMapper.selectHostHousePhotoByDetailId(detail.getId());
			info.put("hostHousePhoto", hostHousePhoto);

		}

		// 상세페이지의 예약 정보
		if (detail != null) {
			List<Book> book = bookMapper.selectByDetailId(detail.getId());
			System.out.println("예약정보 : " + book);
			System.out.println(detail.getId());

			info.put("book", book);
		}

		// map타입 변수 info에 넣음
		info.put("host", host);
		info.put("detail", detail);
		info.put("member", member);
		return info;
	}

	public Integer insertHost(Host host, MultipartFile file) throws Exception {
		Integer count = 0;

		// 호스트 정보 등록
		if (petsitterMapper.selectHostByMemberId(host.getMemberId()) == null) {
			// 호스트로 등록된 정보가 없으면 등록

			count = petsitterMapper.insertHost(host, file.getOriginalFilename());
			System.out.println("service : " + memberMapper.selectById(host.getMemberId()));

			if (memberMapper.selectById(host.getMemberId()) != null) {

				// 호스트 등록하자마자 권한 등록
				petsitterMapper.insertHostAuthority(host.getId());
			}

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

	public boolean deleteHostById(Integer hostId, Member member, Authentication authentication) {
		Integer count = 0;
		System.out.println("member 자바빈 : " + member);
		System.out.println(hostId);
		// 호스트가 본인의 정보를 삭제할 때

		// 회원의 권한을 조회함
		List<String> authorities = petsitterMapper.selectMemberAuthority(authentication.getName());

		// 권한을 모두 비교함
		for (String authorityCheck : authorities) {
			System.out.println("권한 확인 : " + authorityCheck + " " + authorityCheck.equals("admin"));
			if (authorityCheck.equals("host")) {
				System.out.println("호스트 조건문 실행  ");
				// 권한이 호스트라면

				// 호스트 회원 정보를 조회함
				Member hostMemberInfo = memberMapper.selectById(member.getId());
				System.out.println(hostMemberInfo);

				if (passwordEncoder.matches(member.getPassword(), hostMemberInfo.getPassword())) {
					// 암호가 같으면 삭제 진행

					if (selectByHostId(hostId, authentication).get("detail") != null) {
						// 등록된 상세페이지가 있으면
						// 등록된 상세페이지 삭제
						boolean ok = deleteDetailByHostId(hostId, member);

					} // 상세페이지 없으면 아무것도 진행 안함

					// 호스트 정보 삭제
					count = petsitterMapper.deleteHostById(hostId);
					// 권한 테이블에서 정보 삭제
					count += petsitterMapper.deleteHostAuthorityByMemberId(hostMemberInfo.getId());
					System.out.println("count : " + count);
				}

			} else if (authorityCheck.equals("admin")) {
				System.out.println("관리자 조건문 실행 ");
				// 권한이 admin이라면
				System.out.println("관리자 권한으로 호스트 삭제 중");
				// 관리자 회원 정보 조회
				Member adminMemberInfo = memberMapper.selectById(member.getId());
				System.out.println(adminMemberInfo);

				if (passwordEncoder.matches(member.getPassword(), adminMemberInfo.getPassword())) {
					// 관리자의 비밀번호를 입력해서 일치하면

					if (selectByHostId(hostId, authentication).get("detail") != null) {
						// 해당 호스트의
						// 등록된 상세페이지가 있으면
						// 등록된 상세페이지 삭제
						boolean ok = deleteDetailByHostId(hostId, member);

					} // 상세페이지 없으면 아무것도 진행 안함

					// 해당 호스트 정보 삭제
					count = petsitterMapper.deleteHostById(hostId);

					// 해당 호스트의 권한 삭제
					// 호스트 정보를 찾아서
					Host host = petsitterMapper.selectHostByHostId(hostId);
					// host 자바빈 안에 있는 memberId로 권한 삭제 진행
					count += petsitterMapper.deleteHostAuthorityByMemberId(host.getMemberId());
					System.out.println("count" + count);
				}
			}
		}
		// 암호가 다르면 삭제 안됨

		return count == 1;
	}

	public boolean insertDetail(Detail detail, Authentication authentication) throws Exception {
		System.out.println("add service detail : " + detail);
		// 상세페이지 등록
		Integer count = 0;
		// Integer hostId =
		// petsitterMapper.selectHostByMemberId(authentication.getName()).getId();
		Integer hostId = detail.getHostId();
		detail.setHostId(hostId);

		// 호스트 아이디로 상세페이지가 있는지 탐색
		if (selectByHostId(hostId, authentication).get("detail") == null) {
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
		if (cover.getSize() > 0) {
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

	public Integer modifyDetailHousePhotos(MultipartFile addCover, MultipartFile[] addPhotos, List<String> removePhotos,
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
		Integer count = 0;

		// 기존의 정보 조회
		Member oldMember = memberMapper.selectById(member.getId());

		if (passwordEncoder.matches(member.getPassword(), oldMember.getPassword())) {
			// 사용자가 입력한 비밀번호와 저장된 비밀번호가 같으면 작업 실행

			// detailId 값을 가져옴
			Detail detail = petsitterMapper.selectDetailById(hostId);

			// 상세페이지 집사진 삭제
			// 집사진 이름 조회
			List<HostHousePhoto> hostHousePhotoes = petsitterMapper.selectHostHousePhotoByDetailId(detail.getId());

			for (HostHousePhoto hostHousePhoto : hostHousePhotoes) {
				// aws에서 집사진 삭제
				String key = "membery/hostHousePhoto/" + detail.getId() + "/" + hostHousePhoto.getHousePhoto();
				DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder().bucket(bucketName).key(key)
						.build();

				s3.deleteObject(deleteObjectRequest);

			}

			// 집사진 테이블에서 정보 삭제
			Integer photoDeleteCount = petsitterMapper.deleteHostHousePhotoByDetailId(detail.getId());

			// aws에 커버사진 삭제
			String keyCover = "membery/cover/" + detail.getId() + "/" + detail.getCover();
			DeleteObjectRequest deleteObjectRequestCover = DeleteObjectRequest.builder().bucket(bucketName)
					.key(keyCover).build();

			s3.deleteObject(deleteObjectRequestCover);

			// 별점 삭제
			petsitterMapper.deleteStarByDetailId(detail.getId());

			// petsitterComment 레코드 삭제
			petsitterMapper.deleteCommentByDetailId(detail.getId());

			// book 레코드 삭제
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
