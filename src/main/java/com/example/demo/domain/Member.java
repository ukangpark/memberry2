package com.example.demo.domain;

import java.time.*;

import lombok.*;

@Data
public class Member {
	private String id;
	private String name;
	private String password;
	private String nickName;
	private String email;
	private String phoneNumber;
	private LocalDateTime inserted;
}
