package com.example.demo.domain;

import java.time.LocalDate;

import lombok.Data;

@Data
public class Detail {
	private Integer id;
	private String oneline;
	private String body;
	private LocalDate inserted;
	private Integer hostId;
	
}
