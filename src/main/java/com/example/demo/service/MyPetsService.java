package com.example.demo.service;

import java.time.LocalDate;
import java.time.Period;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.domain.Registration;
import com.example.demo.mapper.MyPetsMapper;

@Service
public class MyPetsService {
	
	@Autowired
	private MyPetsMapper mapper;

	public Map<String, Object> petsList() {
		List<Registration> list = mapper.selectAll();
		
		var now = LocalDate.now();
		var together = LocalDate.of(2017, 7, 20);
		
		Period diff = Period.between(together, now);
		
		var yearDiff = diff.getYears();
		var monthDiff = diff.getMonths();
		
		System.out.printf("%d년 %d개월째", diff.getYears(), diff.getMonths());
		
		
		return Map.of("petsList", list, "yearDiff", yearDiff, "monthDiff", monthDiff );
	}

	public Registration getPet(Integer id) {
		return mapper.selectById(id);
	}
	
	

}
