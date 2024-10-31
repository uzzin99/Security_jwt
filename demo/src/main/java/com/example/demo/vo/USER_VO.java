package com.example.demo.vo;

import org.apache.ibatis.type.Alias;
import org.springframework.security.core.userdetails.UserDetailsService;

import com.example.demo.web.ReissueService;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Alias("USER_VO")
@Schema(description = "유저 VO")
@Data
@ToString
@RequiredArgsConstructor
public class USER_VO {
	private String USER_ID;
	private String USER_NM;
	private String TOP_AUTH_YN;
    private String PWD;
    private String TOKEN;
    private String EXPIRED_AT;
    
    public USER_VO(String userId, String token) {
        this.TOKEN = token;
        this.USER_ID = userId;
    }

	public USER_VO(String newAccessToken) {
		this.TOKEN = newAccessToken;
	}

}
