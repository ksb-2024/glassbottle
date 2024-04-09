package com.springproj.emotionshare.glassBottle.controller;

import static org.mockito.BDDMockito.given;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

import com.springproj.emotionshare.glassBottle.DTO.UserDto;
import com.springproj.emotionshare.glassBottle.service.FriendService;

@WebMvcTest(FriendController.class)
public class FriendControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private FriendService friendService;

    @Test
    public void testSearchFriendsByName() throws Exception {
        // Given
        String nameToSearch = "testUser";
        String jsonResponse = "[{\"id\":1,\"username\":\"testUser\",\"nick\":\"Test\",\"name\":\"Test User\",\"tel\":\"1234567890\",\"birth\":\"1990-01-01\",\"gender\":\"M\",\"useremail\":\"test@example.com\",\"role\":\"USER\"}]";

        // When
        given(friendService.searchFriendsByName(nameToSearch)).willReturn(createTestUsers());

        // Then
        mockMvc.perform(get("/api/friends/search")
                .param("name", nameToSearch))
                .andExpect(status().isOk())
                .andExpect(content().json(jsonResponse));
    }

    private List<UserDto> createTestUsers() {
        // Create and return a list of UserDto objects as per your requirement
        // This is just a placeholder to simulate the service layer response
        return List.of(new UserDto(1L, "testUser", "Test", "Test User", "1234567890", "1990-01-01", "M", "test@example.com", "USER"));
    }
}
