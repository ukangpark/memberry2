package com.example.demo.domain;

import java.time.*;

import lombok.*;

@Data
public class Host {
	private Integer id; 
	private String hostName; 
	private String phone;
	private String idNumber; 
	private String si;
	private String gu;
	private String dong;
	private String address; 
	private String houseType; 
	private String pet; 
	private String species; 
	private String experience; 
	private LocalDate inserted;
	private String profile;
	private String title;
	private boolean detail;
	private int commentCount;
	private String cover;
	private String memberId;

}
