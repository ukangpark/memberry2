package com.example.demo.controller;

import java.util.*;
import java.util.stream.*;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import com.example.demo.domain.*;

@Controller
public class ChatController {
	
	List<ChatRoom> roomList = new ArrayList<ChatRoom>();
	static int roomNumber = 0;
	
	@RequestMapping("/chat/chat")
	public ModelAndView chat() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("chat/chat");
		return mv;
	}
	
/*
	// 채팅방 페이지
	@RequestMapping("/chat/chatRoom")
	public ModelAndView chatroom() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("chat/chatRoom");
		return mv;
	}
	
	// 채팅방 생성
	@RequestMapping("/createChatRoom")
	public @ResponseBody List<ChatRoom> createChatRoom(
			@RequestParam HashMap<Object, Object> params){
		String roomName = (String) params.get("roomName");
		if(roomName != null && !roomName.trim().equals("")) {
			ChatRoom room = new ChatRoom();
			room.setRoomNumber(++roomNumber);
			room.setRoomName(roomName);
			roomList.add(room);
		}
		return roomList;
	}
	
	// 채팅방 정보 가져오기
	@RequestMapping("/getChatRoom")
	public @ResponseBody List<ChatRoom> getChatRoom(@RequestParam HashMap<Object, Object> params){
		return roomList;
	}
	
	// 채팅방
	@RequestMapping("/moveChating")
	public ModelAndView chating(@RequestParam HashMap<Object, Object> params) {
		ModelAndView mv = new ModelAndView();
		int roomNumber = Integer.parseInt((String) params.get("roomNumber"));
		
		List<ChatRoom> new_list = roomList.stream().filter(o->o.getRoomNumber()==roomNumber).collect(Collectors.toList());
		if(new_list != null && new_list.size() > 0) {
			mv.addObject("roomName", params.get("roomName"));
			mv.addObject("roomNumber", params.get("roomNumber"));
			mv.setViewName("chat/chat");
		}else {
			mv.setViewName("chat/chatRoom");
		}
		return mv;
	}
*/
	
}
