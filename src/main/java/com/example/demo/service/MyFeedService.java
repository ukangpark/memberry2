package com.example.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.domain.Feed;
import com.example.demo.domain.File;
import com.example.demo.domain.Follow;
import com.example.demo.domain.Like;
import com.example.demo.domain.Registration;
import com.example.demo.domain.Tag;
import com.example.demo.mapper.CommentMapper;
import com.example.demo.mapper.FeedLikeMapper;
import com.example.demo.mapper.FollowMapper;
import com.example.demo.mapper.MyFeedMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
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

	@Autowired
	private FeedLikeMapper likeMapper;

	@Autowired
	private CommentMapper commentMapper;

	@Autowired
	private FollowMapper followMapper;

	public List<File> listMyFeed(String userName, Authentication authentication) {
		List<File> file = mapper.selectAll(userName);

		if (authentication != null) {
			Follow follow = followMapper.select(userName, authentication.getName());
			if (follow != null) {
				file.get(0).setFollowed(true);
			}
		}

		return file;
	}

	public boolean addFeed(Feed feed, MultipartFile[] files, Authentication authentication) throws Exception {
		// 게시물 insert

		int cnt = mapper.insert(feed);
		// int tagCnt = mapper.insertTag(feed);

		for (int i = 0; i < feed.getKeyword().size(); i++) {
			mapper.insertTag(feed.getKeyword().get(i), feed);
		}

		for (MultipartFile file : files) {
			if (file.getSize() > 0) {
				// S3 저장소 사용을 위한 키
				String objectKey = "membery/feed/" + feed.getId() + "/" + file.getOriginalFilename();
				PutObjectRequest por = PutObjectRequest.builder().bucket(bucketName).key(objectKey)
						.acl(ObjectCannedACL.PUBLIC_READ).build();
				RequestBody rb = RequestBody.fromInputStream(file.getInputStream(), file.getSize());

				s3.putObject(por, rb);

				// DB에 관련 정보 저장(insert)
				mapper.insertFileName(feed.getId(), file.getOriginalFilename(), authentication.getName());
			}
		}

		return cnt == 1;
	}

	public Feed getPost(Integer id, Authentication authentication) {
		Feed feed = mapper.selectById(id);

		// 현재 로그인 한 사람이 이 게시물에 좋아요 했는지 여부 쿼리로 가져오기
		if (authentication != null) {
			Like like = likeMapper.select(id, authentication.getName());
			if (like != null) {
				feed.setLiked(true);
			}
		}
		return feed;
	}

	public boolean modify(Feed feed, List<String> removeFileNames, MultipartFile[] addFiles, File file)
			throws Exception {

		// FileName 테이블 삭제
		if (removeFileNames != null && !removeFileNames.isEmpty()) {
			for (String fileName : removeFileNames) {
				// S3에서 파일(객체) 삭제
				String objectKey = "membery/feed/" + feed.getId() + "/" + fileName;
				DeleteObjectRequest dor = DeleteObjectRequest.builder().bucket(bucketName).key(objectKey).build();
				s3.deleteObject(dor);

				// 테이블에서 삭제
				mapper.deleteFileNameByFeedIdAndFileName(feed.getId(), fileName);
			}
		}

		// 새 파일 추가
		for (MultipartFile newFile : addFiles) {
			if (newFile.getSize() > 0) {
				// 테이블에 파일명 추가
				mapper.insertFileName(feed.getId(), newFile.getOriginalFilename(), file.getMemberId());
				System.out.println("피드:" +feed);
				// s3에 파일(객체) 업로드
				String objectKey = "membery/feed/" + feed.getId() + "/" + newFile.getOriginalFilename();
				PutObjectRequest por = PutObjectRequest.builder().acl(ObjectCannedACL.PUBLIC_READ).bucket(bucketName)
						.key(objectKey).build();

				RequestBody rb = RequestBody.fromInputStream(newFile.getInputStream(), newFile.getSize());
				s3.putObject(por, rb);
			}
		}

		// 새 태그 추가
//		for (String keyword : feed.getKeyword()) {
//
//			if (keyword.length() > 0) {
//				mapper.insertTag(keyword, feed);
//				System.out.println("태그:" +keyword);
//			}
//		}

		// 게시물(Feed) 테이블 수정
		int cnt = mapper.update(feed);
		return cnt == 1;
	}

	public boolean remove(Integer id) {

		// 태그 테이블 지우기
		mapper.deleteTagByFeedId(id);

		// 댓글 테이블 지우기
		commentMapper.deleteByFeedID(id);

		// 좋아요 테이블 지우기
		likeMapper.deleteByFeedId(id);

		// 파일명 조회(데이터 지울 때 필요하여 미리 조회)
		List<String> fileNames = mapper.selectFileNamesByFeedId(id);

		// File 테이블의 데이터 지우기(외래키 제약 사항 위배 안 되게 하려고)
		mapper.deleteFileNameByFeedId(id);

		// S3 bucket의 파일(객체) 지우기
		for (String fileName : fileNames) {
			String objectKey = "membery/feed/" + id + "/" + fileName;
			DeleteObjectRequest dor = DeleteObjectRequest.builder().bucket(bucketName).key(objectKey).build();
			s3.deleteObject(dor);
		}

		// 마이피드 테이블의 데이터 지우기
		int cnt = mapper.deleteById(id);
		return cnt == 1;
	}

	public Feed getPost(Integer feedId) {

		return getPost(feedId, null);
	}

	public void removeByWriter(String writer) {
		List<Integer> idList = mapper.selectIdByWriter(writer);

		for (Integer id : idList) {
			remove(id);
		}
	}

	public Registration listProfile(String userName, Authentication authentication) {
		return mapper.selectAllByProfile(userName, authentication);
	}

//	public List<Tag> tag(Integer feedId, String tagInput, Authentication auth) {
//		Integer insert = mapper.insertTag(feedId, tagInput, auth.getName());
//
//		List<Tag> tags = mapper.selectTag(feedId, auth.getName());
//		return tags;
//	}

	public Integer feedId(String userName, Authentication authentication) {
		Integer file = mapper.selectFeedId(userName);
		return file;
	}

	public void tagDelete(Integer feedId, String tagKeyword, Authentication auth) {
		mapper.deleteTag(feedId, tagKeyword);
	}

//	public List<Follow> listFollow(String userName, Authentication authentication) {
//		List<Follow> followResult = mapper.selectAllByFollow(userName, authentication.getName());
//
//		if (authentication != null) {
//			Follow follow = followMapper.select(userName, authentication.getName());
//			if (follow != null) {
//				follow.setFollowed(true);
//			}
//		}
//
//		return followResult;
//	}

}
