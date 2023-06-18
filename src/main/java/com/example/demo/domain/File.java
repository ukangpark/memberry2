package com.example.demo.domain;

import java.time.LocalDate;

import lombok.*;

@Data
public class File {
	private Integer id;
	private Integer feedId;
	private String fileName;
	private String memberId;
	
	private String petName;
	private String type;
	private LocalDate together;
	
	private String profileImage;
	
	private Integer followCount;
	private Boolean followed;
}

