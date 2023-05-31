package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.domain.Detail;
import com.example.demo.domain.Host;

@Mapper
public interface PetsitterMapper {

	@Select("""
			SELECT * FROM Host WHERE id = #{hostId}
			""")
	Host selectHostById(Integer hostId);

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
			SELECT 
				Host.id, 
				hostName, 
				address, 
				phone, 
				Host.inserted, 
				idNumber, 
				houseType, 
				pet, 
				species, 
				experience, 
				si, 
				gu, 
				dong, 
				Host.title, 
				Detail.id detail 
			FROM Host LEFT JOIN Detail ON Host.id = Detail.hostId;
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
	Integer modifyHostById(Host host);

	@Delete("""
			DELETE FROM Host WHERE id = #{hostId}
			""")
	Integer deleteHostById(Integer hostId);

	@Insert("""
			INSERT INTO Detail
			(title, body, hostId)
			VALUES
			(#{title}, #{body}, #{hostId})
			""")
	Integer insertDetail(Detail detail);

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
	
	@Update("""
			UPDATE Detail
			SET
				title = #{title},
				body = #{body}
			WHERE hostId = #{hostId}
			""")
	Integer modifyDetail(Detail detail);

}
