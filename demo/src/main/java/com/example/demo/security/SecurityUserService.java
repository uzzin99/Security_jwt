package com.example.demo.security;

import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.mapper.bvsMapper;
import com.example.demo.vo.USER_VO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class SecurityUserService implements UserDetailsService {
	private final bvsMapper mapper;
	
    @Override
    public UserDetails loadUserByUsername(String username)  throws UsernameNotFoundException {
    	USER_VO user = mapper.findByUser(username)
                .orElseThrow(() -> new IllegalArgumentException("사용자를 찾을 수 없습니다."));

         // 권한 설정 (SimpleGrantedAuthority를 사용)
         String role = user.getTOP_AUTH_YN().toString().equals("Y") ? "ROLE_ADMIN" : "ROLE_USER";
         
         Collection<SimpleGrantedAuthority> authorities = Collections.singletonList(new SimpleGrantedAuthority(role));

         MyUserDetails result = MyUserDetails.builder()
                 .USER_ID(user.getUSER_ID().toString())
                 .PWD(user.getPWD().toString())
                 .role(authorities)
                 .build();

         return result;
    }

}