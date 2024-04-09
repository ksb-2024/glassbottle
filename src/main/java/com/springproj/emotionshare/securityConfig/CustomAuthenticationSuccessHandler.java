package com.springproj.emotionshare.securityConfig;

import java.io.IOException;

import javax.naming.AuthenticationException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CustomAuthenticationSuccessHandler {

	//role값따라 로그인성공시 넘어가는 페이지 다르게 지정하기,
	
	public void onAuthenticationSuccess(HttpServletRequest requeet,
										HttpServletResponse response,
										AuthenticationException execption) 
	throws IOException, ServletException
	{

		
		
		
	}




}
