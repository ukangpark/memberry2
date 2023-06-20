package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.domain.Alarm;
import com.example.demo.domain.Comment;
import com.example.demo.domain.Follow;
import com.example.demo.domain.Like;

@Mapper
public interface AlarmMapper {
	
	@Select("""
			SELECT 
			a.*,
			m.nickName
			FROM Alarm a LEFT JOIN Member m ON a.causedMemberId = m.id
			WHERE a.userId = #{memberId} AND a.userId <> a.causedMemberId  
			ORDER BY id DESC
			""")
	List<Alarm> selectAllByMemberId(String memberId);

	@Insert("""
			INSERT INTO Alarm (userId, causedMemberId, feedId, content, notiType, notiBody)
			VALUES ((SELECT writer FROM Feed WHERE id = #{feedId}), #{memberId}, #{feedId}, #{content}, 'comment',
			(#{memberId}'님이 회원님의 피드에 댓글을 달았습니다 : '#{content}))
			""")
	Integer commentAdd(Comment comment);

	@Insert("""
			INSERT INTO Alarm (userId, causedMemberId, feedId, notiType, notiBody)
			VALUES ((SELECT writer FROM Feed WHERE id = #{feedId}), #{memberId}, #{feedId}, 'like',
			(#{memberId}'님이 회원님의 피드를 좋아합니다.'))
			""")
	Integer likeAdd(Like like);


	@Update("""
			UPDATE Alarm
			SET 
				isChecked = true
			WHERE id = #{id}
			""")
	Integer UpdateCheckedById(Integer id);

	@Update("""
			INSERT INTO Alarm (userId, causedMemberId, notiType, notiBody)
			VALUES (#{feedOwner}, #{memberId}, 'follow', #{memberId}님이 #{feedOwner}'님을 팔로우하기 시작했습니다.')
			""")
	Integer followAdd(Follow follow);

}
