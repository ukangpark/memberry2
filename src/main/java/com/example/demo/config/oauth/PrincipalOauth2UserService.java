package com.example.demo.config.oauth;

import org.springframework.security.oauth2.client.userinfo.*;
import org.springframework.security.oauth2.core.*;
import org.springframework.security.oauth2.core.user.*;
import org.springframework.stereotype.*;

@Service
public class PrincipalOauth2UserService extends DefaultOAuth2UserService{

	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

		System.out.println("getClientRegistration: "+ userRequest.getClientRegistration());
		System.out.println("getAccessToken: "+ userRequest.getAccessToken());
		
		// 회원가입 강제 진행
		OAuth2User oauth2User = super.loadUser(userRequest);
		System.out.println("getAttributes: "+ super.loadUser(userRequest).getAttributes());

//		String provider = userRequest.getClientRegistration().getRegistrationId(); //google
//		String providerId = oauth2User.getAttribute("sub");
//		String username = provider + "_" + providerId;
//		String password = passwordEncoder.encode("hellogoogle");
//		String email = oauth2User.getAttribute("email");
		
		return super.loadUser(userRequest);
	}
	 
}
