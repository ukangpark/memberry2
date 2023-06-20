package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.domain.Feed;

@Mapper
public interface SearchMapper {

	@Select("""
			SELECT * FROM Pet p 
				LEFT JOIN Feed f ON p.memberId = f.writer
				WHERE type LIKE '#{search}'
			""")
	List<Feed> selectAllBySearch(String search, String title);

}
