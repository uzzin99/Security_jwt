package com.example.demo.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.jwt.JwtToken;
import com.example.demo.jwt.JwtTokenProvider;
import com.example.demo.mapper.bvsMapper;
import com.example.demo.security.MyUserDetails;
import com.example.demo.vo.USER_VO;
import com.fasterxml.jackson.databind.ObjectMapper;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.parameters.RequestBody;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class ApiController {
	private final PasswordEncoder passwordEncoder;
	private final JwtTokenProvider jwtTokenProvider;

	@Autowired private bvsMapper mapper;

	@GetMapping("/hello")
    public String helloWorld() {
        return "hello!";
    }
	
	@GetMapping("/info")
	@Operation(summary = "유저 리스트", description = "유저리스트 조회")
	@CrossOrigin(origins = "http://127.0.0.1:8081")
    public List<USER_VO> info() throws Exception{
        List<USER_VO> list = mapper.getUserList();

        return list;

    }

    @PostMapping("/login.do")
	public JwtToken login(@RequestParam Map<String, Object> param) {
        String username = (String) param.get("username");
        String password = (String) param.get("password");
        
        USER_VO member = mapper.findByUser(username)
                .orElseThrow(() -> new IllegalArgumentException("가입되지 않은 아이디 입니다."));
        if (!passwordEncoder.matches(password, member.getPWD())) {
            throw new IllegalArgumentException("잘못된 비밀번호입니다.");
        }
        
        String role = member.getTOP_AUTH_YN().toString().equals("Y") ? "ROLE_ADMIN" : "ROLE_USER";
        
        return jwtTokenProvider.createToken(username, role);
        
    }
    
    @PostMapping("/test")
    public String test() {
        return "success";
    }
    
    @PostMapping("/user/test")
    public Map<String, String> userResponseTest() {
        Map<String, String> result = new HashMap<>();
        result.put("result","user ok");
        return result;
    }

    @PostMapping("/admin/test")
    public Map<String, String> adminResponseTest() {
        Map<String, String> result = new HashMap<>();
        result.put("result","admin ok");
        return result;
    }
    
    @Value("${jwt.secret}")
    String key;
    
    private long accessTokenValidTime = 60 * 60 * 1000L;
    
    @PostMapping("/guest-token")
    public ResponseEntity<String> getToken() {
        Map<String, Object> claims = new HashMap<>();
        
        claims.put("userId", "guest"); //익명 사용자 ID
        claims.put("roles", "ROLE_GUEST");
        
        String jwt = Jwts.builder()
			.setClaims(claims)
			.setExpiration(new Date(System.currentTimeMillis() + accessTokenValidTime))
			.signWith(SignatureAlgorithm.HS256, key)
			.compact();
        
        return ResponseEntity.ok(jwt);
    }
}
