package com.example.demo.domain;

import java.time.*;

import lombok.*;

@Data
public class PetsitterComment {
	private Integer id;
	private Integer detailId;
	private String memherId;
	private LocalDateTime inserted;
	private String body;
}
