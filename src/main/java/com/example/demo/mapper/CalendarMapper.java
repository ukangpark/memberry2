package com.example.demo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface CalendarMapper {

	@Select("""
			SELECT 
				title,
				start,
				end,
				allDay
			FROM Calendar
			WHERE memberId = #{memberId}
			""")
	Map<String, Calendar> selectAllByMemberId(String memberId);


	
	
}
