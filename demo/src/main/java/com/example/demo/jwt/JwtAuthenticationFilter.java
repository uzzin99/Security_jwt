package com.example.demo.jwt;

import java.io.IOException;
import java.util.List;

import org.springframework.http.HttpRequest;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.GenericFilterBean;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
public class JwtAuthenticationFilter extends GenericFilterBean    {

	private final JwtTokenProvider jwtTokenProvider;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
    	
    	// 헤더에서 JWT 를 받아옵니다.
    	String token = resolveToken((HttpServletRequest) request);
    	
        // 유효한 토큰인지 확인합니다.
        if (token != null && jwtTokenProvider.validateRefreshToken(token)) {
        	
            if(jwtTokenProvider.isGuestToken(token)) {
            	System.out.println("11111 - 게스트 토큰입니다.");
            	
            	Authentication guestAuthentication = new UsernamePasswordAuthenticationToken("guest", null, List.of(new SimpleGrantedAuthority("ROLE_GUEST")) );
               
            	// SecurityContext에 게스트 인증 정보 설정
                SecurityContextHolder.getContext().setAuthentication(guestAuthentication);
                    
            	chain.doFilter(request, response);
            	
            	return;
            }else {
            	System.out.println("22222 - 회원 토큰입니다.");
            	
	        	// 토큰이 유효하면 토큰으로부터 유저 정보를 받아옵니다.
	            Authentication authentication = jwtTokenProvider.getAuthentication(token);
	            
	            // SecurityContext 에 Authentication 객체를 저장합니다.
	            SecurityContextHolder.getContext().setAuthentication(authentication);
            }
            
        }
        chain.doFilter(request, response);
    }
    
    // Request Header에서 토큰 정보 추출
    private String resolveToken(HttpServletRequest request) {
        String bearerToken = request.getHeader("Authorization");
        
        if (StringUtils.hasText(bearerToken) && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7);
        }
        return null;
    }
    
}
