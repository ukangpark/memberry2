package com.example.demo.config;

import org.springframework.context.annotation.*;
import org.springframework.security.config.annotation.method.configuration.*;
import org.springframework.security.config.annotation.web.builders.*;
import org.springframework.security.web.*;

@Configuration
@EnableMethodSecurity
public class customConfig {
	
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http.csrf().disable(); 
		http.authorizeHttpRequests().anyRequest().permitAll();
		
		return http.build();
	}
	
}
