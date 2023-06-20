package com.example.demo.config.oauth.provider;

import java.util.*;

public class KakaoUserInfo implements OAuth2UserInfo{

	private Map<String, Object> attributes; //이 attributes는 PrincipalOauth2UserService의 oauth2User.getAttributes()의 값
	
	public KakaoUserInfo(Map<String, Object> attributes) {
		this.attributes = attributes;
	}
	
	@Override
	public String getProviderId() {
		return attributes.get("id").toString();
	}

	@Override
	public String getProvider() {
		return "kakao";
	}

	@Override
	public String getEmail() {
		return ((Map)attributes.get("kakao_account")).get("email").toString();
	}

	@Override
	public String getName() {
		return ((Map)((Map)attributes.get("kakao_account")).get("profile")).get("nickname").toString();
	} 

}
 