package com.example.demo.mapper;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface ScheduleMapper {

	@Insert("""
			INSERT INTO Schedule (start, content) 
			VALUES (#{start}, #{content})
			""")
	Integer insertScheduleByDate(Schedule schedule);

	@Delete("""
			DELETE FROM Schedule
			WHERE id = ${id}
			""")
	Integer deleteScheduleById(Schedule schedule);
	
}
