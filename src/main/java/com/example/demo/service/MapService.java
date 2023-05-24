package com.example.demo.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;

@Service
public class MapService {
	
	@Value("${kakao-javaScript-key}")
	private String kakao_javaScript_key;

	public String getKakao_javaScript_key() {
		return kakao_javaScript_key;
	}

	public void setKakao_javaScript_key(String kakao_javaScript_key) {
		this.kakao_javaScript_key = kakao_javaScript_key;
	}
	
//	public String kakaoReady() {
//        HttpHeaders headers = new HttpHeaders();
//        headers.add("Authorization", "KakaoAK " + kakao_javaScript_key);
//        return headers.toString();
//    }

}
