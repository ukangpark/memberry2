package com.example.demo.domain;

import java.util.*;

import lombok.*;

//일정 자바빈
@Data
public class Schedule {
	private Integer id;
	private String memberId;
	private String title;
	private Date start;
	private Date end;
	
	
}
