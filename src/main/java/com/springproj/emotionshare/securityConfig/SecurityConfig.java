package com.springproj.emotionshare.securityConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Autowired
	AuthenticationFailureHandler authenticationFailureHandler;
	
	@Bean
	public BCryptPasswordEncoder bCryptPasswordEncoder() {
		return new BCryptPasswordEncoder(); // 패스워드 암호화
	}

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
		http.csrf(AbstractHttpConfigurer::disable)
				.authorizeHttpRequests((auth) ->auth //람다식으로 작성
			//★★★★ 2024.01.30 추가할부분
			//★★★★ 여기부분은 role값따라 접근할수있는 페이지 지정해야함
					.requestMatchers("/login","loginProc").permitAll()
					.requestMatchers("/admin").hasRole("ADMIN")
					.requestMatchers("/mainpage","/mypage","checkpwd").hasAnyRole("ADMIN","USER")
					.anyRequest().permitAll()
					)
			//★★★★ 2024.01.30 추가할부분	
			//★★★★ role값에따라 (admin페이지) 따로 만들어서 로그인 하여 모든 유저정보 , 다이어리내용,등 뽑아볼수있게 -> db저장된내용 페이지에서볼수있게
			//★★★★ CustomAuthenticationSuccessHandler 클래스 생성해서 role값따라 로그인시 넘어가는 페이지 다르게 지정할수있음
			.formLogin(login ->login
		        .loginPage("/login")
		        .loginProcessingUrl("/j_spring_security_check")
		        .failureHandler(authenticationFailureHandler)
		    	.usernameParameter("username")
				.passwordParameter("password")
		        .defaultSuccessUrl("/mainpage")
		        .permitAll()
		        )
		        .logout(logout ->logout
						.logoutUrl("/logout")
						.logoutSuccessUrl("/login")
						.permitAll()
						
				)
				.rememberMe(Customizer.withDefaults());

		
		http //중복로그인 설정
			.sessionManagement((auth)-> auth
					.maximumSessions(1)
					.maxSessionsPreventsLogin(true)); //1중복 초과시 새로운 로그인 차단
		http
				.sessionManagement((auth)-> auth
					.sessionFixation().changeSessionId());//보안 세션 보호
		
		
		
		
		
		return http.build();
	}

}
