package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.domain.Detail;
import com.example.demo.domain.Host;

@Mapper
public interface PetsitterMapper {
	
	@Select("""
			SELECT * FROM Host WHERE id = #{hostId}
			""")
	Host selectHostById(Integer hostId);
	
	@Select("""
			SELECT * FROM Detail WHERE id = #{boardId}
			""")
	Detail selectDetailById(Integer boardId);
	
	@Insert("""
			INSERT INTO Host 
			(hostName, phone, idNumber, si, gu, dong, address, houseType, pet, species, experience, photo)
			VALUES
			(#{hostName}, #{phone}, #{idNumber}, #{si}, #{gu}, #{dong}, #{address}, #{houseType}, #{pet}, #{species}, #{experience}, #{photo})
			""")
	Integer insertHost(Host host);
	
	@Select("""
			SELECT * FROM Detail
			""")
	List<Detail> selectDetailAll();

	@Select("""
			SELECT * FROM Host
			""")
	List<Host> selectHostAll();

}
