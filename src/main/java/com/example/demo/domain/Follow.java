package com.example.demo.domain;

import lombok.Data;

@Data
public class Follow {
	private String feedOwner;
	private String memberId;
	private String nickName;
	
	private String profileImage;
	
	private Integer followCount;
	private Integer followingCount;
	private Boolean followed;
}
