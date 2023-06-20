package com.example.demo.config.oauth;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.oauth2.client.userinfo.*;
import org.springframework.security.oauth2.core.*;
import org.springframework.security.oauth2.core.user.*;
import org.springframework.stereotype.*;

import com.example.demo.config.oauth.provider.*;
import com.example.demo.domain.*;
import com.example.demo.mapper.*;
import jakarta.servlet.http.*;

@Service
public class PrincipalOauth2UserService extends DefaultOAuth2UserService {

	@Autowired
	private MemberMapper mapper;

		@Override
		public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

			// 회원가입 강제 진행
			OAuth2User oauth2User = super.loadUser(userRequest);
			System.out.println("getAttribute: " + oauth2User.getAttributes());

			OAuth2UserInfo oAuth2UserInfo = null;
			if(userRequest.getClientRegistration().getRegistrationId().equals("google")) {
				System.out.println("구글 로그인 요청");
				oAuth2UserInfo = new GoogleUserInfo(oauth2User.getAttributes());
			} else if(userRequest.getClientRegistration().getRegistrationId().equals("naver")) {
				System.out.println("네이버 로그인 요청");
				oAuth2UserInfo = new NaverUserInfo((Map)oauth2User.getAttributes().get("response"));
			} else {
				System.out.println("구글과 네이버 로그인만 지원합니다.");
			}
			
			String provider = oAuth2UserInfo.getProvider();
			String providerId = oAuth2UserInfo.getProviderId();
			String id = provider + "_" + providerId;
			String email = oAuth2UserInfo.getEmail();
			String name = oAuth2UserInfo.getName();
			String password = "1";
			String nickName = name + "1"; 
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