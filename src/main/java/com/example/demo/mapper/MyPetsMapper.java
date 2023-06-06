package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.domain.Registration;

@Mapper
public interface MyPetsMapper {

	@Select("""
			SELECT * FROM Pet
			""")
	List<Registration> selectAll();

	@Select("""
			SELECT * FROM Pet
			WHERE id = #{id}
			""")
	Registration selectById(Integer id);

}
