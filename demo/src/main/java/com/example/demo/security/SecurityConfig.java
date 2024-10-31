package com.example.demo.security;

import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.handler.HandlerMappingIntrospector;

import com.example.demo.jwt.JwtAccessDeniedHandler;
import com.example.demo.jwt.JwtAuthenticationEntryPoint;
import com.example.demo.jwt.JwtAuthenticationFilter;
import com.example.demo.jwt.JwtTokenProvider;

import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
@EnableWebSecurity
public class SecurityConfig{

	private final JwtTokenProvider jwtTokenProvider;
	private final JwtAccessDeniedHandler jwtAccessDeniedHandler;
	private final JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;

	@Bean
	SecurityFilterChain filterChain(HttpSecurity http, HandlerMappingIntrospector introspector) throws Exception {

        http.authorizeHttpRequests(authorize -> authorize
//        		.requestMatchers("/api", "/api/**","/mainApi","/mainApi/**").permitAll()
        		.requestMatchers("/api/**").permitAll()
        		.requestMatchers("common.js").permitAll()
        		.requestMatchers("sgu_ipsi/**").permitAll()
        		.requestMatchers("attach/**").permitAll()
        		.requestMatchers("/swagger", "/swagger-ui.html", "/swagger-ui/**", "/api-docs", "/api-docs/**", "/v3/api-docs/**").permitAll()
                .requestMatchers("/login","/","/loginin","/api/login.do","/favicon.ico", "/main").permitAll()
                .requestMatchers("/apiToken/refresh").permitAll()
                .requestMatchers("/api/admin/**").hasRole("ADMIN")
                .requestMatchers("/api/user/**").hasRole("USER")
                .anyRequest().authenticated() // 그 외 요청 체크
        );
        http.formLogin(AbstractHttpConfigurer::disable);
        http.logout(AbstractHttpConfigurer::disable);
        http.csrf(AbstractHttpConfigurer::disable);
        http.sessionManagement(session -> session
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS) // 세션 미사용
        );

        http.addFilterBefore(new JwtAuthenticationFilter(jwtTokenProvider), UsernamePasswordAuthenticationFilter.class);

        http.exceptionHandling(conf -> conf
                .authenticationEntryPoint(jwtAuthenticationEntryPoint)
                .accessDeniedHandler(jwtAccessDeniedHandler)
        );
		return http.build();
	}

	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
   
}