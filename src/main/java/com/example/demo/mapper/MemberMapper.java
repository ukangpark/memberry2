package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface MemberMapper {

	@Insert("""
			INSERT INTO Member (id, name, password, nickName, email, phoneNumber)
			VALUES (#{id}, #{name}, #{password}, #{nickName}, #{email}, #{phoneNumber})
			""")
	int insert(Member member);

	
	@Select("""
			SELECT *
			FROM Member
			ORDER BY inserted DESC
			""")
	List<Member> selectAll();


	@Select("""
			SELECT m.*, ma.authority, CONCAT('/', p.id, '/', p.photo) profileImage
			FROM Member m LEFT JOIN Pet p ON m.defaultPetId = p.id
						  LEFT JOIN MemberAuthority ma ON m.id = ma.memberId
			WHERE m.id = #{id}
			""")
	@ResultMap("memberMap")
	Member selectById(String id);
	
	@Select("""
			SELECT *
			FROM Member
			WHERE nickName = #{nickName}
			""")
	Member selectByNickName(String nickName);

	@Select("""
			SELECT *
			FROM Member
			WHERE email = #{email}
			""")
	Member selectByEmail(String email);
	
	@Select("""
			SELECT *
			FROM Member
			WHERE phoneNumber = #{phoneNumber}
			""")
	Member selectByPhoneNumber(String phoneNumber);

	@Delete("""
			DELETE FROM Member
			WHERE id = #{id}
			""")
	Integer deleteById(String id);


	@Update("""
			<script>
			
			UPDATE Member
			SET 
				<if test="password neq null and password neq ''">
				password = #{password},
				</if>
				
				nickName = #{nickName},
				email = #{email},
				phoneNumber = #{phoneNumber}
			WHERE 
				id = #{id}
				
			</script>
			""")
	Integer update(Member member);


	@Select("""
			SELECT id,
				   name,
				   password,
				   nickName,
				   email,
				   phoneNumber,
				   inserted
			FROM Member
			ORDER BY inserted DESC
			LIMIT #{startIndex}, #{recordsInPage}
			""")
	List<Member> selectAllPage(Integer startIndex, Integer recordsInPage);

	
	@Select("""
			SELECT COUNT(*)
			FROM Member
			""")
	Integer countAll();


	
	
	
}
