package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import com.example.demo.domain.Alarm;
import com.example.demo.mapper.AlarmMapper;

import jakarta.servlet.http.HttpSession;

@Service
public class AlarmService {
	
	@Autowired
	private AlarmMapper mapper;

	public List<Alarm> list(Authentication authentication, HttpSession session) {
		List<Alarm> alarms = mapper.selectAllByMemberId(authentication.getName());
		return alarms;
	}

	public Boolean checked(Integer id) {
		int cnt = mapper.UpdateCheckedById(id);
		System.out.println("확인");
		return cnt == 1;
	}


}
