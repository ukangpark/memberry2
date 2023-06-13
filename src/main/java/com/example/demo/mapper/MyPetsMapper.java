package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.security.core.Authentication;

import com.example.demo.domain.Registration;

@Mapper
public interface MyPetsMapper {

	@Select("""
			SELECT * FROM Pet 
			WHERE memberId = #{memberId};
			""")
	List<Registration> selectAll(String memberId);

	@Select("""
			SELECT * FROM Pet JOIN Member 
			ON (Pet.memberId = Member.id)
			WHERE Pet.id = #{id}
			""")
	Registration selectById(Integer id);

	@Update("""
			<script>
			UPDATE Pet SET
				id = #{registration.id},
				petName = #{registration.petName},
				type = #{registration.type},
				birth = #{registration.birth},
				together = #{registration.together},
				gender = #{registration.gender},
				neutered = #{registration.neutered},
				registrationNum = #{registration.registrationNum},
				
				<if test="originalFilename neq ''">
				photo = #{originalFilename},
				</if>
				
				weight = #{registration.weight},
				memberId = #{registration.memberId}
			WHERE Id = #{registration.id}
			</script>
			""")
	Integer update(Registration registration, String originalFilename);

	@Delete("""
			DELETE FROM Pet
			WHERE id = #{id};
			""")
	Integer deleteById(Integer id);

	@Select("""
			SELECT photo FROM Pet
			WHERE id = #{id}
			""")
	List<String> selectPhotoById(Integer id);

	@Select("""
			SELECT * FROM Pet
			WHERE id = #{id}
			""")
	Registration thumbnailByMemberId(Integer id);

	@Update("""
			UPDATE Member SET
				defaultPetId = #{petId}
			WHERE id = #{userId};
			""")
	Integer updateProfileByMemberId(Integer petId,String userId);

	




}
