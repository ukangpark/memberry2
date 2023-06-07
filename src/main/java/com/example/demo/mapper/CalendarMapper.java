package com.example.demo.mapper;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface CalendarMapper {

	@Insert("""
			INSERT INTO Schedule (start, content) 
			VALUES (#{start}, #{content})
			""")
	Integer insertScheduleByDate(Calendar schedule);

	@Delete("""
			DELETE FROM Schedule
			WHERE id = ${id}
			""")
	Integer deleteScheduleById(Calendar schedule);

	
	
}
