package com.example.demo.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.domain.Chat;
import com.example.demo.service.ChatService;

@Controller
@RequestMapping("/")
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
	// 대화 내용 가져오기
	@GetMapping("chat/chatRoom")
	public ArrayList<Chat> chatRoom() {
		ArrayList<Chat> chatList = chatService.getChatList();
		
		return chatList;
	}
	
	// 최근 대화 내용 가져오기
	@GetMapping("chat/recentChat")
	public ArrayList<Chat> recentChat() {
		ArrayList<Chat> chatList = chatService.getRecentChatList();
		
		return chatList;
	}
	
	
}
