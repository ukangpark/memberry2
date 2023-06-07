package com.example.demo.domain;

import java.util.*;

import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

@Repository("calendarDao")
public class CalendarDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<Calendar> getCalendar() throws Exception {
		List<Calendar> calendar = null;
		calendar = sqlSession.selectList("Calendar.calendarList");
		return calendar;
	}

}
