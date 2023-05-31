package com.example.demo.domain;

import java.time.*;

import lombok.*;

@Data
public class Schedule {

	private Integer id;
	private LocalDate date;
	private String content;
}
