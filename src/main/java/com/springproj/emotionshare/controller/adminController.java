package com.springproj.emotionshare.controller;

import org.springframework.web.bind.annotation.GetMapping;

public class adminController {

	@GetMapping("/admin")
	public String adminP() {
		return "admin";

	}
}