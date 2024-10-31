package com.example.demo.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.jwt.JwtTokenProvider;
import com.example.demo.mapper.bvsMapper;
import com.example.demo.vo.USER_VO;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/apiToken")
@Tag(name = "재발급", description = "재발급 컨트롤러에 대한 설명입니다.")
public class ReissueController {
	
	private final JwtTokenProvider jwtTokenProvider;

	@Autowired 
	private bvsMapper mapper;
	
    @PostMapping("/refresh")
    public ResponseEntity<?> refreshToken(@RequestHeader("Authorization") String authorizationHeader) {
    	String refreshToken = authorizationHeader.substring("Bearer ".length());
    	
    	// 리프레시 토큰 검증 (데이터베이스 또는 Redis에서 검증)
        if (!jwtTokenProvider.validateRefreshToken(refreshToken)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid refresh token");
        }

        // 새로운 액세스 토큰 생성
        USER_VO user = mapper.findUserByRefreshToken(refreshToken);
        
        if(user == null) {
        	throw new RuntimeException("유저 정보가 없습니다");
        }
        
        if(!refreshToken.equals(user.getTOKEN())) {
        	throw new RuntimeException("토큰의 유저 정보가 일치하지 않습니다.");
        }

        String role = user.getTOP_AUTH_YN().toString().equals("Y") ? "ROLE_ADMIN" : "ROLE_USER";
        
        String newAccessToken = jwtTokenProvider.createAccessToken(user.getUSER_ID(), role);
    	
    	return ResponseEntity.ok(new USER_VO(newAccessToken));
    }
    
}
