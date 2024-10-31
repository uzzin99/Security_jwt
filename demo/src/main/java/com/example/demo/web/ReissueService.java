package com.example.demo.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.bvsMapper;
import com.example.demo.vo.USER_VO;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Tag(name = "재발급", description = "재발급 컨트롤러에 대한 설명입니다.")
public class ReissueService {
	
	@Autowired
    private bvsMapper bvsMapper;

    public void saveRefreshToken(USER_VO refreshToken) {
    	bvsMapper.insertRefreshToken(refreshToken);
    }
}
