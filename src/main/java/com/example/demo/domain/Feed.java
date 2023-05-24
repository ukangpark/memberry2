package com.example.demo.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class Feed {
	private Integer id;
	private String title;
	private String content;
	private String writer;
	private LocalDateTime inserted;
	private String location;
}
