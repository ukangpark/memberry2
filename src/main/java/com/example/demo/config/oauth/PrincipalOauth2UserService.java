package com.example.demo.config.oauth;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.oauth2.client.userinfo.*;
import org.springframework.security.oauth2.core.*;
import org.springframework.security.oauth2.core.user.*;
import org.springframework.stereotype.*;
import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Service
public class PrincipalOauth2UserService extends DefaultOAuth2UserService{
	
	@Autowired
	private MemberMapper mapper;


import jakarta.servlet.http.*;

@Service
public class PrincipalOauth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User>{

	private final UserRepository userRepository;
	private final HttpSession httpSession;
	
	public PrincipalOauth2UserService(UserRepository userRepository, HttpSession httpSession) {
		this.userRepository = userRepository;
		this.httpSession = httpSession;
	}
	
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

		OAuth2UserService<OAuth2UserRequest, OAuth2User> delegate = new DefaultOAuth2UserService();
		OAuth2User oAuthUser = delegate.loadUser(userRequest);
		
		String registrationId = userRequest.getClientRegistration().getRegistrationId();
		String userNameAttributeName = userRequest.getClientRegistration().getProviderDetails().getUserInfoEndpoint().getUserNameAttributeName();
		
		OAuthAttributes attributes = OAuthAttributes.of(registrationId, userNameAttributeName, oAuth2User.getAttributes());
		
		// 회원가입 강제 진행
		OAuth2User oauth2User = super.loadUser(userRequest);
		System.out.println("getAttributes: "+ super.loadUser(userRequest).getAttributes());	

		String provider = userRequest.getClientRegistration().getRegistrationId(); //google
		String providerId = oauth2User.getAttribute("sub");
		String id = provider + "_" + providerId;
		String email = oauth2User.getAttribute("email");
		String name = oauth2User.getAttribute("name");
		String password = "";
		String nickName = "";
		String phoneNumber = "";
		
		Member oldMember = mapper.selectById(id);
		
		if (oldMember == null) {
			Member member = new Member();
			member.setEmail(email);
			member.setId(id);
			member.setName(name);
			member.setNickName(nickName);
			member.setPassword(password);
			member.setPhoneNumber(phoneNumber);
			
			mapper.insert(member);
			
			return new PrincipalDetails(member);
		}
		
		return new PrincipalDetails(oldMember);
		
//		return super.loadUser(userRequest);

	}
	 
}
}