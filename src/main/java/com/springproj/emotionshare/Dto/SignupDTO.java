package com.springproj.emotionshare.Dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
@AllArgsConstructor
public class SignupDTO {
	
	private String username;
	private String password;
	private String nick;
	private String name;
	private String tel;
	private String birth;
	private String gender;
	private String useremail;
	private String edomain;
	
	
	private String confirmPassword;
	
	
}
