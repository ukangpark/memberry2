package com.example.demo.config.oauth;

import org.springframework.security.oauth2.client.userinfo.*;
import org.springframework.security.oauth2.core.*;
import org.springframework.security.oauth2.core.user.*;
import org.springframework.stereotype.*;

@Service
public class PrincipalOauth2UserService extends DefaultOAuth2UserService{

	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

		System.out.println("userRequest: "+userRequest);
		
		return super.loadUser(userRequest);
	}
	
}
