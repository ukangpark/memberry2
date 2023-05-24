package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.domain.Feed;

@Mapper
public interface MyFeedMapper {

	@Select("""
			SELECT 
				id,
				title,
				content,
				writer,
				inserted
			FROM Feed
			ORDER BY id DESC
			""")
	List<Feed> selectAll();

	
}
