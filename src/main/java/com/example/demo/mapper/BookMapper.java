package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface BookMapper {
	
	@Select("""
			SELECT
			petName,
			checkIn,
			checkOut,
			hostName,
			accepted,
			Host.id,
			num
			
		FROM Book, Host, Pet
		ORDER BY Book.num DESC
			""")
	List<Book> selectAll();

	@Select("""
			SELECT *
			FROM Book
			WHERE num = #{num}
			""")
	Book selectById(Integer id);

	
	
}



