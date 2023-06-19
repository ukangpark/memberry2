package com.example.demo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.security.core.Authentication;

import com.example.demo.domain.Follow;


@Mapper
public interface FollowMapper {
	
	@Insert("""
			INSERT INTO Follow
				VALUES (#{feedOwner}, #{memberId})
			""")
	Integer insert(Follow follow);

	@Delete("""
			DELETE FROM Follow
				WHERE feedOwner = #{feedOwner}
					AND memberId = #{memberId}
			""")
	Integer delete(Follow follow);

	@Select("""
			SELECT COUNT(*) FROM Follow
			WHERE feedOwner = #{feedOwner}
			""")
	Integer followerCountByfeedOwner(Follow follow);


	@Select("""
			SELECT * FROM Follow
			WHERE feedOwner = #{feedOwner}
					AND memberId = #{memberId}
			""")
	Follow select(String feedOwner, String memberId);

	@Select("""
			SELECT COUNT(*) FROM Follow
			WHERE memberId = #{memberId}
			""")
	Integer followingCountBymemberId(Follow follow);

	@Select("""
			SELECT 
				fw.*,
				CONCAT('/', m.defaultPetId, '/', p.photo) profileImage
			FROM Follow fw LEFT JOIN  Pet p ON fw.memberId = p.memberId
						LEFT JOIN Member m ON m.id = fw.memberId
			WHERE feedOwner = #{feedOwner}
			""")
	List<Follow> selectAllByFollower(String feedOwner, String memberId);



}
