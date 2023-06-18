package com.example.demo.domain;

import lombok.Data;

@Data
public class Chat {
	int chatId;
	String fromId;
	String toId;
	String chatContent;
	String chatTime;
}
