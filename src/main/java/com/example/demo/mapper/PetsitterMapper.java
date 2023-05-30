package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.domain.Detail;
import com.example.demo.domain.Host;

@Mapper
public interface PetsitterMapper {
	
	@Select("""
			SELECT * FROM host WHERE id = #{hostId}
			""")
	Host selectHostById(Integer hostId);
	
	@Select("""
			SELECT * FROM detail WHERE id = #{boardId}
			""")
	Detail selectDetailById(Integer boardId);

	// 외래키 설정하면 쿼리 변경해야함 
	@Select("""
			SELECT 
				si,
				gu,
				dong,
				Detail.title,
				photo
				
			FROM Host, Detail
			ORDER BY Detail.inserted DESC
			""")
	List<Host> selectAll();

}
