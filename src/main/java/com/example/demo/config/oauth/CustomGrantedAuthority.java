package com.example.demo.config.oauth;

import java.util.*;

import org.springframework.security.core.*;

public class CustomGrantedAuthority implements GrantedAuthority {

	 private String authority;

	    public CustomGrantedAuthority(String authority) {
	        this.authority = authority;
	    }

	    @Override
	    public String getAuthority() {
	        return authority;
	    }
}
