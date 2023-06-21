package com.example.demo.domain;

import java.time.*;

import lombok.*;

@Data
public class QnAComment {
	private Integer id;
	private Integer qnaId;
	private String content;
	private String memberId;
	private LocalDateTime inserted;
}
