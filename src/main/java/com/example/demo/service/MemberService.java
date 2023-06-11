package com.example.demo.service;


import java.util.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;



import org.springframework.beans.factory.annotation.*;
import org.springframework.security.crypto.password.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;


import com.example.demo.domain.Member;

import com.example.demo.mapper.*;

import com.example.demo.mapper.CommentMapper;
import com.example.demo.mapper.FeedLikeMapper;
import com.example.demo.mapper.MemberMapper;

import com.example.demo.domain.*;




@Service
@Transactional(rollbackFor = Exception.class)
public class MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
	@Autowired
	private FeedLikeMapper likeMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private CommentMapper commentMapper;
	
	public boolean signup(Member member) {
		
		//암호 암호화 
		String secret = member.getPassword();
		member.setPassword(passwordEncoder.encode(secret)); 
		 int cnt = mapper.insert(member);
		 return cnt == 1;
	}

	public List<Member> listMember() {
		
		return mapper.selectAll();
	}

	public Member get(String id) {
		return mapper.selectById(id);
	}

	public boolean remove(Member member) {
		Member eachMemberId = mapper.selectById(member.getId());
		int cnt = 0;
		if(passwordEncoder.matches(member.getPassword(), eachMemberId.getPassword())) {
			// 암호가 같으면?
			
			//회원이 작성한 댓글 삭제
			commentMapper.deleteByMemberId(member.getId());
			
			cnt = mapper.deleteById(member.getId());			
		
			// 이 회원이 좋아요한 레코드 삭제
			likeMapper.deleteByMemberId(member.getId());
		} 
		
		return cnt == 1;
		
	}

	public boolean modify(Member member, String oldPassword) {
		// password를 바꾸기 위해 입력한 경우(not empty)
		if (!member.getPassword().isBlank()) {
			
			// 입력된 패스워드를 암호화
			String secret = member.getPassword();
			member.setPassword(passwordEncoder.encode(secret));
		}
		
		Member eachMemberId = mapper.selectById(member.getId());
		
		int cnt = 0;
		if(passwordEncoder.matches(oldPassword, eachMemberId.getPassword())) {			
			// 기존 암호와 같으면 
			cnt = mapper.update(member);
		}
		
		return cnt == 1;
	}

	public Map<String, Object> listMember(Integer page) {
		
		// 한 페이지에 보여줄 레코드 개수
		Integer recordsInPage = 10;
		
		// query LIMIT절에 사용할 시작 인덱스
		Integer startIndex = (page -1) * recordsInPage;
		
		// 페이지네이션이 필요한 정보 가져와서 보여주기
		// 전체 레코드 수
		Integer countAllRecords = mapper.countAll();
		
		// 마지막 페이지 번호
		Integer lastPageNum = (countAllRecords - 1) / recordsInPage + 1;
		
		// 페이지네이션 왼쪽 번호
		Integer leftPageNum = page - 3;
		// 1보다 작을 수 없음
		leftPageNum = Math.max(leftPageNum, 1);
		
		// 페이지네이션 오른쪽 번호
		Integer rightPageNum = page + 2;
		// 마지막페이지보다 클 수 없음
		rightPageNum = Math.min(rightPageNum, lastPageNum);
		
		Map<String, Object> pageInfo = new HashMap<>();
		pageInfo.put("leftPageNum", leftPageNum);
		pageInfo.put("rightPageNum", rightPageNum);
		pageInfo.put("currentPageNum", page);
		pageInfo.put("lastPageNum", lastPageNum);
		
		// 회원 목록 가져와서 보여주기
		List<Member> list = mapper.selectAllPage(startIndex, recordsInPage);
		
		return Map.of("pageInfo", pageInfo, 
					  "memberList", list);
	}
	 
}
 
 