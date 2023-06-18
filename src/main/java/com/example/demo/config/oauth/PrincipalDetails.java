package com.example.demo.config.oauth;

import java.util.*;

import org.springframework.security.core.*;
import org.springframework.security.core.userdetails.*;

import com.example.demo.domain.*;

import lombok.*;

@Data
public class PrincipalDetails implements UserDetails{
	
	
	private Member member;
	
	public PrincipalDetails(Member member) {
		this.member = member;
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
}
