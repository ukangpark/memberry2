package com.example.demo.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.domain.Chat;
import com.example.demo.mapper.ChatMapper;

import software.amazon.awssdk.services.s3.S3Client;

@Service
@Transactional(rollbackFor = Exception.class)
public class ChatService {
	@Autowired
	private S3Client s3;
	
	@Autowired
	private ChatMapper chatMapper;

	public ArrayList<Chat> getChatList() {
		ArrayList<Chat> arrList = chatMapper.selectById();
		
		return arrList;
	}

	public ArrayList<Chat> getRecentChatList() {
		ArrayList<Chat> recentList = chatMapper.selectByRecent();
		
		return recentList;
	}
}
