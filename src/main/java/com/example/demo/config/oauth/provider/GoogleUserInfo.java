package com.example.demo.config.oauth.provider;

import java.util.*;

public class GoogleUserInfo implements OAuth2UserInfo{

	private Map<String, Object> attributes; //이 attributes는 PrincipalOauth2UserService의 oauth2User.getAttributes()의 값
	
	public GoogleUserInfo(Map<String, Object> attributes) {
		this.attributes = attributes;
	}
	
	@Override
	public String getProviderId() {
		return (String)attributes.get("sub");
	}

	@Override
	public String getProvider() {
		return "google";
	}

	@Override
	public String getEmail() {
		return (String)attributes.get("email");
	}

	@Override
	public String getName() {
		return (String)attributes.get("name");
	}

}
