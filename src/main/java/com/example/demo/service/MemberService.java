package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.crypto.password.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;
import org.springframework.web.servlet.mvc.support.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Service
@Transactional(rollbackFor = Exception.class)
public class MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
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
			cnt = mapper.deleteById(member.getId());			
		
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

	public List<Member> listMember(Integer page) {
		
		// 한 페이지에 10개씩 보여주기
		Integer startIndex = (page -1) * 10;
		
		// 회원 목록 가져와서 보여주기
		return mapper.selectAllPage(startIndex);
		
		// 페이지네이션이 필요한 정보 가져와서 보여주기
		
	}
	
}

