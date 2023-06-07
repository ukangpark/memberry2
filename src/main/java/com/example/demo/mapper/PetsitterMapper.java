package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

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
			(hostName, phone, idNumber, si, gu, dong, address, houseType, pet, species, experience, profile)
			VALUES
			(#{hostName}, #{phone}, #{idNumber}, #{si}, #{gu}, #{dong}, #{address}, #{houseType}, #{pet}, #{species}, #{experience}, #{profile})
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

	// 외래키 설정하면 쿼리 변경해야함 (펫시터 전체보기)
	@Select("""
			SELECT 
				si,
				gu,
				dong,
				Detail.title,
				profile,
				Host.id,
				pet,
				houseType,
				species
				
			FROM Host, Detail
			ORDER BY Detail.inserted DESC
			""")
	List<Host> selectAll();

	@Select("""
			<script>
			<bind name="pattern" value="'%' + search + '%'" />
			SELECT
			si,
			gu,
			dong,
			Detail.title,
			profile,
			Host.id,
			pet,
			houseType,
			species,
			 (select count(*) from PetsitterComment where detailId = Detail.id) commentCount 
		FROM Host, Detail
		WHERE
			Host.id = Detail.hostId
		AND
			(si LIKE #{pattern}
		OR  gu LIKE #{pattern}
		OR  dong LIKE #{pattern})
		ORDER BY Detail.inserted DESC
		LIMIT #{startIndex}, #{rowPerPage}
		</script>
			""")
	List<Host> selectAllPaging(Integer startIndex, Integer rowPerPage, String search);
	
	@Select("""
			<script>
			<bind name="pattern" value="'%' + search + '%'" />
			SELECT COUNT(*)
			FROM Host
			WHERE
			si LIKE #{pattern}
		OR  gu LIKE #{pattern}
		OR  dong LIKE #{pattern}
		</script>
			""")
	Integer countAll(String search);

	
	
	
}
