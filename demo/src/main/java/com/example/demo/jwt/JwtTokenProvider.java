package com.example.demo.jwt;

import java.util.Date;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Component;

import com.example.demo.vo.USER_VO;
import com.example.demo.web.ReissueService;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.SignatureException;
import io.jsonwebtoken.UnsupportedJwtException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class JwtTokenProvider {

    private String secretKey = "webfirewood";

    // 토큰 유효시간 하루
    private long accessTokenValidTime = 60 * 60 * 1000L; //1시간 (60 * 1000L == 1분)
    private long refreshTokenValidTime = 24 * 60 * 60 * 1000L; //하루

    private final UserDetailsService userDetailsService;
    private final ReissueService reissueService;
    
    
    // JWT 토큰 생성
    public JwtToken createToken(String userPk, String roles) {
        Claims claims = Jwts.claims().setSubject(userPk); // JWT payload 에 저장되는 정보단위
        claims.put("roles", roles); // 정보는 key / value 쌍으로 저장된다.
        
        Date now = new Date();
        
        //Access Token 생성
        String accessToken = Jwts.builder()
                .setClaims(claims) // 정보 저장
                .setIssuedAt(now) // 토큰 발행 시간 정보
                .setExpiration(new Date(now.getTime() + accessTokenValidTime)) // set Expire Time
                .signWith(SignatureAlgorithm.HS256, secretKey) 
                .compact();

        //Refresh Token 생성
        String refreshToken =  Jwts.builder()
        		.setClaims(claims)
                .setIssuedAt(now) // 토큰 발행 시간 정보
                .setExpiration(new Date(now.getTime() + refreshTokenValidTime)) // set Expire Time
                .signWith(SignatureAlgorithm.HS256, secretKey) 
                .compact();
        
        //Refresh Token db저장
        reissueService.saveRefreshToken(new USER_VO(userPk, refreshToken));
        
        return JwtToken.builder()
        		.grantType("Bearer")
        		.accessToken(accessToken)
        		.refreshToken(refreshToken)
        		.build();
    }
    
    // JWT 토큰에서 인증 정보 조회
    public Authentication getAuthentication(String token) {
    	
    	Claims claims = parseClaims(token);
    	
    	UserDetails userDetails = userDetailsService.loadUserByUsername(claims.getSubject());
    	return new UsernamePasswordAuthenticationToken(userDetails, "", userDetails.getAuthorities());
    	
        
    }
    
    // Jwt 토큰 복호화해서 가져오기
    private Claims parseClaims(String token) {
        try {
            return Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token).getBody();
        } catch (ExpiredJwtException e) {
            return e.getClaims();
        }
    }
	
    public boolean validateRefreshToken(String refreshToken) {
		try {
			Jwts.parser()
				.setSigningKey(secretKey)
				.parseClaimsJws(refreshToken);
			return true;
		} catch (SignatureException e) {
			log.error("=====================================Invalid JWT signature.=====================================");
		} catch (MalformedJwtException e) {
			log.error("=====================================Invalid JWT token.=====================================");
		} catch (ExpiredJwtException e) {
			log.error("=====================================Expired JWT token.=====================================");
		} catch (UnsupportedJwtException e) {
			log.error("=====================================Unsupported JWT token.=====================================");
		} catch (IllegalArgumentException e) {
			log.error("=====================================JWT claims string is empty.=====================================");
		} catch (NullPointerException e) {
			log.error("=====================================JWT Token is empty.=====================================");
		}
		return false;
	}
    
    public String createAccessToken(String username, String role) {
    	Claims claims = Jwts.claims().setSubject(username); 
    	claims.put("roles", role);
    	
        Date now = new Date();
        
        return Jwts.builder()
            .setClaims(claims)
            .setIssuedAt(now)
            .setExpiration(new Date(now.getTime() + accessTokenValidTime))
            .signWith(SignatureAlgorithm.HS256, secretKey)
            .compact();
    }
}
