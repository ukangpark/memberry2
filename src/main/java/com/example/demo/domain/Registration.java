package com.example.demo.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class Registration {
	private Integer id;
	private String petName;
	private String type;
	private String weight;
	private Date birth;
	private Date together;
	private String gender;
	private String neutered;
	private Integer registrationNum;
	private List<String> photo;

}
