package com.example.demo.domain;

import java.time.LocalDateTime;
import java.util.Date;

import com.example.demo.controller.FeedTime;

import lombok.Data;

@Data
public class Comment {

	private Integer id;
	private Integer feedId;
	private String memberId;
	private String content;
	private String inserted;
	private Boolean editable; 

	private String nickName;
	private String defaultPetId;
	private String profileImage;
	
	
	
	public void setInserted(Date date) {
		this.inserted = FeedTime.calculateTime(date); // 기존의 getter, setter에서 변경된 부분
	}	
}
