package com.example.demo.domain;

import java.time.LocalDate;

import lombok.Data;

@Data
public class Detail {
	private Integer id;
	private String title;
	private String body;
	private LocalDate inserted;
	private Integer hostId;
	private String cover;
	private String memberId;
	
}
