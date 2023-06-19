package com.example.demo.domain;

import java.time.*;
import java.util.*;

import org.springframework.boot.autoconfigure.domain.*;

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
	private String profileImage;
	private List<String> authority;
	private String provider;
	private String providerId;
}