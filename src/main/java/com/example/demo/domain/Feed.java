package com.example.demo.domain;

import java.util.Date;
import java.util.List;

import com.example.demo.controller.FeedTime;

import lombok.Data;

@Data
public class Feed {
	private Integer id;
	private String title;
	private String content;
	private String writer;
	private String inserted;
	private String location;
	
	private List<String> fileName;
	private Integer likeCount;

	private Integer commentCount;
	private Boolean liked;
	
	private String profileImage;
	private String nickName;

	
	public void setInserted(Date date) {
		this.inserted = FeedTime.calculateTime(date); // 기존의 getter, setter에서 변경된 부분
	}
	

}

