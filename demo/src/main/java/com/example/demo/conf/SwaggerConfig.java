package com.example.demo.conf;

import java.lang.module.ModuleDescriptor.Version;
import java.util.Arrays;
import java.util.function.Predicate;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

//import io.swagger.annotations.Contact;
//import io.swagger.models.SecurityRequirement;
import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityScheme;
//import springfox.documentation.builders.ApiInfoBuilder;
//import springfox.documentation.builders.PathSelectors;
//import springfox.documentation.builders.RequestHandlerSelectors;
//import springfox.documentation.service.ApiInfo;
//import springfox.documentation.spi.DocumentationType;
//import springfox.documentation.spring.web.plugins.Docket;

@Configuration // 스프링 실행시 설정파일 읽어드리기 위한 어노테이션
public class SwaggerConfig {

//    @Bean
//    OpenAPI openAPI() {
//        return new OpenAPI()
//                .components(new Components())
//                .info(apiInfo());
//    }
//
//    private Info apiInfo() {
//        return new Info()
//                .title("CodeArena Swagger")
//                .description("CodeArena 유저 및 인증 , ps, 알림에 관한 REST API")
//                .version("1.0.0");
//    }
	
	@Bean
	OpenAPI openAPI(){
		 SecurityScheme securityScheme = new SecurityScheme()
			 	.type(SecurityScheme.Type.HTTP).scheme("bearer").bearerFormat("JWT")
		 		.in(SecurityScheme.In.HEADER).name("Authorization");
		 io.swagger.v3.oas.models.security.SecurityRequirement securityRequirement = new io.swagger.v3.oas.models.security.SecurityRequirement().addList("bearerAuth");

		 return new OpenAPI()
		 	.components(new Components().addSecuritySchemes("bearerAuth", securityScheme))
		 	.security(Arrays.asList(securityRequirement));
	}
}
