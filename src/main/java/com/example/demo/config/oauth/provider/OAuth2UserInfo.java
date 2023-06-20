package com.example.demo.config.oauth.provider;

public interface OAuth2UserInfo {
	String getProviderId(); //primary key
	String getProvider(); //google, naver
	String getEmail();
	String getName();
}
