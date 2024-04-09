package com.springproj.emotionshare.glassBottle.DTO;

import java.time.LocalDate;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FriendListDto {
	 private Long userId;
	 private String email;
	 private String phoneNumber;
	 private LocalDate birthDate;
	 private List<Long> friendIds; 
}
