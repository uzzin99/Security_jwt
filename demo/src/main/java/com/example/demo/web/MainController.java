package com.example.demo.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.jwt.JwtToken;
import com.example.demo.jwt.JwtTokenProvider;
import com.example.demo.mapper.bvsMapper;
import com.example.demo.security.MyUserDetails;
import com.example.demo.vo.USER_VO;
import com.fasterxml.jackson.databind.ObjectMapper;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
//@RestController
@RequiredArgsConstructor
@Tag(name = "메인", description = "컨트롤러에 대한 설명입니다.")
public class MainController {
	private final PasswordEncoder passwordEncoder;
	private final JwtTokenProvider jwtTokenProvider;

	@Autowired private bvsMapper mapper;

	@GetMapping("/main")
	public String main() throws Exception {
		return "/IPSI_A/Main";
	}
	
	@GetMapping("/index")
	public String index(){
		return "index.html";
	}
    
}
