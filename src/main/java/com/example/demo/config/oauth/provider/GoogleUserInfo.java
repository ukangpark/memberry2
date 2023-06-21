package com.example.demo.config.oauth.provider;

import java.util.*;

public class GoogleUserInfo implements OAuth2UserInfo{

	private Map<String, Object> attributes; //이 attributes는 PrincipalOauth2UserService의 oauth2User.getAttributes()의 값
	
	public GoogleUserInfo(Map<String, Object> attributes) {
		this.attributes = attributes;
	}
	
	@Override
	public String getProviderId() {
		return attributes.get("sub").toString();
	}

	@Override
	public String getProvider() {
		return "google";
	}

	@Override
	public String getEmail() {
		return attributes.get("email").toString();
	}

	@Override
	public String getName() {
		return attributes.get("name").toString();
	}

}
