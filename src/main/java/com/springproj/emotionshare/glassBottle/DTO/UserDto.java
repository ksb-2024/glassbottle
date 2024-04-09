package com.springproj.emotionshare.glassBottle.DTO;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@Builder
public class UserDto {
	private Long id;
    private String username;
    private String nick;
    private String name;
    private String tel;
    private String birth;
    private String gender;
    private String useremail;
    private String role;
    
 // 전체 필드를 매개변수로 받는 생성자 추가
    public UserDto(Long id, String username, String nick, String name, String tel, String birth, String gender, String useremail, String role) {
        this.id = id;
        this.username = username;
        this.nick = nick;
        this.name = name;
        this.tel = tel;
        this.birth = birth;
        this.gender = gender;
        this.useremail = useremail;
        this.role = role;
    }
}
