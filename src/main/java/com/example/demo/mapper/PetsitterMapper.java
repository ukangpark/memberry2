package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.domain.Detail;
import com.example.demo.domain.Host;

@Mapper
public interface PetsitterMapper {
	
	@Select("""
			SELECT * FROM Host WHERE id = #{id}
			""")
	Host selectHostById(Integer id);
	
	@Select("""
			SELECT * FROM Detail WHERE hostId = #{hostId}
			""")
	Detail selectDetailById(Integer hostId);
	
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

	@Update("""
			UPDATE Host
			SET 
				hostName = #{hostName},
				phone = #{phone},
				si = #{si},
				gu = #{gu},
				dong = #{dong},
				address = #{address},
				houseType = #{houseType},
				pet = #{pet},
				species = #{species},
				experience = #{experience}
			WHERE id = #{id}
			""")
	Integer modifyById(Host host);

}
