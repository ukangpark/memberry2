package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;

import com.example.demo.domain.Feed;

@Mapper
public interface SearchMapper {

	@Select("""
			SELECT 
				fi.feedId,
				fi.fileName
			FROM Feed fd LEFT JOIN File fi ON fd.id = fi.feedId
						LEFT JOIN Tags t ON fd.id = t.feedId
			WHERE t.keyword LIKE '%' #{search} '%'
			ORDER BY fd.id DESC;
						""")
	//@ResultMap("searchResultMap")
	List<Feed> selectAllBySearch(String search);

}
