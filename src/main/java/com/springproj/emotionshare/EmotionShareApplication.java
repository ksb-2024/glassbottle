package com.springproj.emotionshare;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.springproj.emotionshare.mapper")
public class EmotionShareApplication {

	public static void main(String[] args) {
		SpringApplication.run(EmotionShareApplication.class, args);
	}

}
