package com.example.demo.domain;

import java.time.LocalDate;

import lombok.Data;

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
	private Integer houseType; 
	private String pet; 
	private String species; 
	private String experience; 
	private LocalDate inserted;
	private String photo;
}
