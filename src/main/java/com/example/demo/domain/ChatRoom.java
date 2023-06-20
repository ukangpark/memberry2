package com.example.demo.domain;

public class ChatRoom {
	int roomNumber;
	String roomName;
	
	public int getRoomNumber() {
		return roomNumber;
	}
	public void setRoomNumber(int roomNumber) {
		this.roomNumber = roomNumber;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	
	@Override
	public String toString() {
		return "ChatRoom [roomNumber=" + roomNumber + ", roomName=" + roomName + "]";
	}
}
