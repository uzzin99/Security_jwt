package com.example.demo;

import javax.sql.DataSource;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityFilterAutoConfiguration;
import org.springframework.context.annotation.Bean;

@SpringBootApplication(exclude = {SecurityFilterAutoConfiguration.class})
//@SpringBootApplication(exclude = DataSourceAutoConfiguration.class)
@MapperScan(value={"com.example.demo.mapper"})
public class DemoApplication {

	private static final Logger logger = LoggerFactory.getLogger(DemoApplication.class);


	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

	@Bean
    CommandLineRunner testDatabaseConnection(DataSource dataSource) {
        return args -> {
            try {
                dataSource.getConnection().close();
                logger.info("데이터베이스 연결 성공!");
            } catch (Exception e) {
                logger.error("데이터베이스 연결 실패: ", e);
            }
        };
    }
}
