package com.example.demo.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class Registration {
	private Integer id;
	private String petName;
	private String type;
	private Double weight;
	private Date birth;
	private Date togeter;
	private String gender;
	private String neutered;
	private Integer registrationNum;
	private String photo;

}
