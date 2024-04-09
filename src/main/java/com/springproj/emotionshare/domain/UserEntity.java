package com.springproj.emotionshare.domain;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCrypt;

import io.micrometer.common.util.StringUtils;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class UserEntity implements UserDetails{

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;//발급순서

	@Column(unique = true)
	private String username;//아이디
	private String password;
	private String nick;
	private String name;//이름
	private String tel;
	private String birth;
	private String gender;
	private String useremail;
	

	private String role;//user admin
	//유저 정보 수정!
	public void updateUserInfo(UserEntity updatedUser) {
		this.nick = updatedUser.getNick();
		this.name = updatedUser.getName();
		this.tel = updatedUser.getTel();
		this.birth = updatedUser.getBirth();
		this.gender = updatedUser.getGender();
		this.useremail = updatedUser.getUseremail();
		
		//회원변경 필요한 비밀번호암호화
		if (StringUtils.isNotBlank(updatedUser.getPassword())) {
		
			this.password = BCrypt.hashpw(updatedUser.getPassword(), BCrypt.gensalt());
		}

	}


	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return false;
	}
}
