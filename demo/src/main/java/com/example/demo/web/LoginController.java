package com.example.demo.web;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@Controller
@SpringBootApplication(exclude = SecurityAutoConfiguration.class)
@Tag(name = "로그인", description = "로그인 컨트롤러에 대한 설명입니다.")
@Slf4j
public class LoginController {

	@GetMapping("/login")
	@Operation(summary = "로그인", description = "로그인페이지 조회")
    public String login() {
        return "login";
    }
	
	@GetMapping("/error")
	@Operation(summary = "에러", description = "에러페이지 조회")
	public String error() {
		return "error";
	}
	
}
