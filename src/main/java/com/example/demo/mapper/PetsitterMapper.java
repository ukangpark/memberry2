package com.example.demo.mapper;

import org.apache.ibatis.annotations.Insert;
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
	
	@Insert("""
			INSERT INTO host 
			(hostName, phone, idNumber, si, gu, dong, address, houseType, pet, species, experience, photo)
			VALUES
			(#{hostName}, #{phone}, #{idNumber}, #{si}, #{gu}, #{dong}, #{address}, #{houseType}, #{pet}, #{species}, #{experience}, #{photo})
			""")
	Integer insertHost(Host host);

}
