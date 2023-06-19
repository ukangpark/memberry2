package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.domain.Alarm;
import com.example.demo.domain.Comment;
import com.example.demo.domain.Like;

@Mapper
public interface AlarmMapper {


	@Insert("""
			INSERT INTO Alarm (userId, causedMemberId, feedId, content, notiType)
			VALUES ((SELECT writer FROM Feed WHERE id = #{feedId}), #{memberId}, #{feedId}, #{content}, 'comment')
			""")
	Integer commentAdd(Comment comment);

	@Insert("""
			INSERT INTO Alarm (userId, causedMemberId, feedId, notiType)
			VALUES ((SELECT writer FROM Feed WHERE id = #{feedId}), #{memberId}, #{feedId}, 'like')
			""")
	Integer likeAdd(Like like);

	@Select("""
			SELECT 
				a.*,
				m.nickName,
				(SELECT COUNT(*) FROM Alarm 
				WHERE a.userId = #{memberId} AND isChecked = false) alarmCount 
			FROM Alarm a LEFT JOIN Member m ON a.causedMemberId = m.id
			WHERE a.userId = #{memberId} AND a.userId <> a.causedMemberId  
			ORDER BY id DESC
			""")
	List<Alarm> selectAllByMemberId(String memberId);

	@Update("""
			UPDATE Alarm
			SET 
				isChecked = true
			WHERE id = #{id}
			""")
	Integer UpdateCheckedById(Integer id);

}
