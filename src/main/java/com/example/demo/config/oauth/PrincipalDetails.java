package com.example.demo.config.oauth;

import java.util.*;

import org.springframework.security.core.*;
import org.springframework.security.core.userdetails.*;
import org.springframework.security.oauth2.core.user.*;

import com.example.demo.domain.*;

import lombok.*;

@Data
public class PrincipalDetails implements UserDetails, OAuth2User{
	
	
	private Member member;
	
	private Map<String, Object> attributes;
	
	// 일반 로그인에 사용하는 생성자
	public PrincipalDetails(Member member) {
		this.member = member;
	}
	
	// OAuth2 로그인에 사용하는 생성자
	public PrincipalDetails(Member member, Map<String, Object> attributes) {
		this.member = member;
		this.attributes = attributes;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
	    List<GrantedAuthority> authorities = new ArrayList<>();
	    for (String auth : member.getAuthority()) {
            authorities.add(new CustomGrantedAuthority(auth));
        }
        return authorities;
	}

	@Override
	public String getPassword() {
		
		return member.getPassword();
	}

	@Override
	public String getUsername() {
		
		return member.getId();
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}

	@Override
	public Map<String, Object> getAttributes() {
		return attributes;
	}

	@Override
	public String getName() {
		return null;
	}
}
