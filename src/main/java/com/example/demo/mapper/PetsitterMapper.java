package com.example.demo.mapper;

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

}
