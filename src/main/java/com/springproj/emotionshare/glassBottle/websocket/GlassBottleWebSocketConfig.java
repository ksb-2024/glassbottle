package com.springproj.emotionshare.glassBottle.websocket;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class GlassBottleWebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // 클라이언트가 연결할 엔드포인트를 '/ws'로 설정
    	// GlassBottle 모듈을 위한 WebSocketConfig
    	registry.addEndpoint("/ws-glass").withSockJS();
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        // 메시지 브로커가 처리할 prefix 설정
        registry.enableSimpleBroker("/queue", "/topic");
        // 서버에서 클라이언트로의 메시지 라우팅 시 사용할 prefix 설정
        registry.setApplicationDestinationPrefixes("/app");
    }
}
