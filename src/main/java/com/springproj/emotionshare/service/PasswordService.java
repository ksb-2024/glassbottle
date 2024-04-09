package com.springproj.emotionshare.service;

import org.springframework.security.crypto.bcrypt.BCrypt;


//평문 패스워드와 암호화된 패스워드 비교 
public class PasswordService {

	public static boolean equals(String plaintext, String hashed) {
		
		if(plaintext ==null || plaintext.length()<1) {
			return false;
		}
		
		if(hashed ==null || hashed.length()<1) {
			
		}
	return BCrypt.checkpw(plaintext, hashed);
	
	}
	
	public static String encPassword(String plaintext) {
		
		if(plaintext == null || plaintext.length()<1) {
			return "";
		}
	return BCrypt.hashpw(plaintext,BCrypt.gensalt()); 
	}
	
	
}
