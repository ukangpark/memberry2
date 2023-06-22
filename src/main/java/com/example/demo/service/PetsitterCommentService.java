package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.core.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Service
@Transactional(rollbackFor = Exception.class)
public class PetsitterCommentService {

	@Autowired
	private PetsitterCommentMapper petsitterCommentMapper;
	
	@Autowired
	private AlarmMapper alarmMapper;

	public List<PetsitterComment> list(Integer detailId, Authentication authentication) {
		// 상세페이지id를 통해 후기 전체 조회
		List<PetsitterComment> comments = petsitterCommentMapper.selectAllByDetailId(detailId);

		// editable에 값 설정
		for (PetsitterComment comment : comments) {
			comment.setEditable(comment.getMemberId().equals(authentication.getName()));
			// 로그인한 아이디와 후기의 아이디가 같으면 ture 다르면 false;
		}
		
		System.out.println("list service working");
		return comments;
	}

	public Map<String, Object> add(PetsitterComment petsitterComment, Authentication authentication) {

		var res = new HashMap<String, Object>();

		// 후기 등록

		// 자바빈에 memberId 넣어줌
		petsitterComment.setMemberId(authentication.getName());

		// mapper를 통해서 데이터를 넣어줌(후기)
		Integer countComment = petsitterCommentMapper.add(petsitterComment);

		// 별점 넣기
		Integer countStar = petsitterCommentMapper.addStar(petsitterComment.getStar(), petsitterComment.getId(), petsitterComment.getDetailId());

		System.out.println("add service : " + petsitterComment);

		if (countComment == 1 && countStar == 1) {
			res.put("message", "댓글이 등록되었습니다.");
		} else {
			res.put("message", "댓글이 등록되지 않았습니다.");
		}
		return res;
	}

	public Map<String, Object> delete(Integer commentId) {
		// 후기 삭제
		int countStar = petsitterCommentMapper.deleteStar(commentId);
		int countComment = petsitterCommentMapper.delete(commentId);

		var res = new HashMap<String, Object>();

		if (countComment == 1 && countStar == 1) {
			res.put("message", "댓글이 삭제되었습니다.");

		} else { 
			res.put("message", "댓글이 삭제 되지 않았습니다.");

		}
		
		System.out.println("delete service : " + countComment + ", " +  countStar + ", " + res);
		return res;

	}

	public PetsitterComment selectCommentByCommentId(Integer commentId) {
		PetsitterComment petsitterComment = petsitterCommentMapper.selectCommentByCommentId(commentId);
		
		System.out.println("selectCommnet service : " + petsitterComment);
		return petsitterComment;
	}

	public Map<String, Object> modifyComment(PetsitterComment petsitterComment, Authentication authentication) {

		petsitterComment.setMemberId(authentication.getName());
		System.out.println("modift service : " + petsitterComment);
		var res = new HashMap<String, Object>();
		
		// 별점 수정
		int countStar = petsitterCommentMapper.updateStar(petsitterComment);

		// 후기 수정
		int countComment = petsitterCommentMapper.updateComment(petsitterComment);
		


		if (countComment == 1 && countStar == 1) {
			res.put("message", "댓글이 수정되었습니다.");
		} else {
			res.put("message", "댓글이 수정되지 않았습니다.");
		}

		return res;
	}
}
