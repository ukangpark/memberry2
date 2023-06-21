package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.domain.Alarm;
import com.example.demo.domain.Book;
import com.example.demo.domain.Comment;
import com.example.demo.domain.Follow;
import com.example.demo.domain.Like;
import com.example.demo.domain.PetsitterComment;
import com.example.demo.domain.QnA;

@Mapper
public interface AlarmMapper {
	
	//알림목록
	@Select("""
			SELECT 
			a.*,
			m.nickName
			FROM Alarm a LEFT JOIN Member m ON a.causedMemberId = m.id
			WHERE a.userId = #{memberId} AND a.userId <> a.causedMemberId  
			ORDER BY id DESC
			""")
	List<Alarm> selectAllByMemberId(String memberId);
	//알림 확인시 
	@Update("""
			UPDATE Alarm
			SET 
			isChecked = true
			WHERE id = #{id}
			""")
	Integer UpdateCheckedById(Integer id);

	//댓글 알림
	@Insert("""
			INSERT INTO Alarm (userId, causedMemberId, feedId, content, notiType, notiBody)
			VALUES ((SELECT writer FROM Feed WHERE id = #{feedId}), #{memberId}, #{feedId}, #{content}, 'comment',
			(#{memberId}'님이 회원님의 피드에 댓글을 달았습니다 : '#{content}))
			""")
	Integer commentAdd(Comment comment);

	//좋아요 알림
	@Insert("""
			INSERT INTO Alarm (userId, causedMemberId, feedId, notiType, notiBody)
			VALUES ((SELECT writer FROM Feed WHERE id = #{feedId}), #{memberId}, #{feedId}, 'like',
			(#{memberId}'님이 회원님의 피드를 좋아합니다.'))
			""")
	Integer likeAdd(Like like);


	//팔로우 알림
	@Insert("""
			INSERT INTO Alarm (userId, causedMemberId, notiType, notiBody)
			VALUES (#{feedOwner}, #{memberId}, 'follow', #{memberId}'님이' #{feedOwner}'님을 팔로우하기 시작했습니다.')
			""")
	Integer followAdd(Follow follow);
	
	//펫시터 댓글 알림
	@Insert("""
			INSERT INTO Alarm (userId, causedMemberId, feedId, content, notiType, notiBody)
			VALUES ((SELECT hostId FROM Detail WHERE id = #{detailId}), #{memberId}, #{detailId}, #{body}, 'petsitterComment',
			(#{memberId}'님이 회원님의 펫시터 상세페이지에 후기가 달렸습니다 : '#{body}))
			""")
	Integer petsitterCommentAdd(PetsitterComment petsitterComment);

	//qna 알림
	@Insert("""
			INSERT INTO Alarm (userId, causedMemberId, feedId, notiType, notiBody)
			VALUES ('membow', #{writer}, #{id}, 'qna',
			(#{writer}'님이 QnA 게시판에 글을 등록하였습니다.'))
			""")
	Integer qnaAdd(QnA qna);
	
	//펫시터 예약요청 알림
	@Insert("""
			INSERT INTO Alarm (userId, causedMemberId, feedId, notiType, notiBody)
			VALUES (#{hostId}, #{memberId}, #{detailId}, 'bookRegi',
			'회원님께 펫시터 예약 요청이 왔습니다.')
			""")
	void bookRegiAdd(Book book);
	
	
	//펫시터 예약승인 알림
	@Insert("""
			INSERT INTO Alarm (userId, causedMemberId, feedId, notiType, notiBody)
			VALUES (
				( SELECT memberId FROM Book WHERE num = #{num} ), 
				( SELECT hostId FROM Book WHERE num = #{num} ), 
				( SELECT detailId FROM Book WHERE num = #{num} ), 
				'bookAccept',
				'회원님의 펫시터 예약이 승인되었습니다.')
			""")
	void bookAcceptAdd(int num);
	
	//펫시터 예약거절 알림
	@Insert("""
			INSERT INTO Alarm (userId, causedMemberId, feedId, notiType, notiBody)
			VALUES (#{memberId}, #{hostId}, #{detailId}, 'bookReject',
			'회원님의 펫시터 예약이 거절되었습니다.')
			""")
	void bookRejectAdd(Book book);
	
	

}
