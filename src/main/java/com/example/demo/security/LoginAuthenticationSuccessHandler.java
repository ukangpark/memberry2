package com.example.demo.security;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.example.demo.domain.Member;
import com.example.demo.domain.Registration;
import com.example.demo.mapper.MemberMapper;
import com.example.demo.mapper.MyPetsMapper;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class LoginAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
	
	@Autowired
	private MemberMapper mapper;
	
	@Autowired
	private MyPetsMapper myPetsMapper;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		HttpSession session = request.getSession();
		
		Member member = mapper.selectById(authentication.getName());
		
		updateMemberInSession(member, session);
		
		response.sendRedirect("/");

	}
	
	public void updateMemberInSession(Member member, HttpSession session) {
		session.setAttribute("logedInMember", member);
		
	}

}
