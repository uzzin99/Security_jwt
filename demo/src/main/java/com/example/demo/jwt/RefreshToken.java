package com.example.demo.jwt;

import java.time.LocalDateTime;


import com.example.demo.vo.USER_VO;

import lombok.Data;
import nonapi.io.github.classgraph.json.Id;

@Data
public class RefreshToken {
    @Id
    private Long id;

    private String token;

    private Long userId; // 사용자 ID

    private LocalDateTime expiredAt; // 만료 시간
}
