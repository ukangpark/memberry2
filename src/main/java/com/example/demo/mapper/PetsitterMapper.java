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
			(#{host.hostName}, #{host.phone}, #{host.idNumber}, #{host.si}, #{host.gu}, #{host.dong}, #{host.address}, #{host.houseType}, #{host.pet}, #{host.species}, #{host.experience}, #{profile})
			""")
	Integer insertHost(Host host, String profile);

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
				Detail.id detail ,
				profile
			FROM Host LEFT JOIN Detail ON Host.id = Detail.hostId;
			""")
	List<Host> selectHostAll();

	@Update("""
			UPDATE Host
			SET
				hostName = #{host.hostName},
				phone = #{host.phone},
				si = #{host.si},
				gu = #{host.gu},
				dong = #{host.dong},
				address = #{host.address},
				houseType = #{host.houseType},
				pet = #{host.pet},
				species = #{host.species},
				experience = #{host.experience},
				profile = #{profile}
			WHERE id = #{host.id}
			""")
	Integer modifyHostById(Host host, String profile);

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
	
	@Update("""
			UPDATE Detail
			SET
				title = #{title},
				body = #{body}
			WHERE hostId = #{hostId}
			""")
	Integer modifyDetail(Detail detail);
	
	@Delete("""
			DELETE FROM Detail WHERE hostId = #{hostId}
			""")
	Integer deleteDetailByHostId(Integer hostId);

	@Select("""
			SELECT * FROM HostHousePhoto WHERE detailId = #{detailId}
			""")
	List<HostHousePhoto> selectHostHousePhotoByHostId(Integer hostId);
	
	@Insert("""
			INSERT INTO HostHousePhoto
			(housePhoto, hostId)
			VALUES
			(#{housePhoto}, #{hostId})
			""")
	Integer insertHostHousePhoto(String housePhoto, Integer hostId);
	
	@Select("""
			SELECT count(*) FROM HostHousePhoto WHERE hostId = #{hostId};
			""")
	Integer housePhotoCount(Integer hostId);
	

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
