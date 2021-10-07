package com.minejava.apigatewayservice;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.reactive.EnableWebFluxSecurity;
import org.springframework.security.config.web.server.ServerHttpSecurity;
import org.springframework.security.web.server.SecurityWebFilterChain;

import static org.springframework.security.config.Customizer.withDefaults;

// providing authentication for incoming requests to be authenticated
@Configuration
@EnableWebFluxSecurity
public class SecurityConfig {
    // to create spring security change using a bean
    // enable all incoming request to be configured by our auth2
    @Bean
    public SecurityWebFilterChain springSecurityFilterChain(ServerHttpSecurity http) {
        http.authorizeExchange(exchanges -> exchanges.anyExchange().authenticated()).oauth2Login(withDefaults());
        http.csrf().disable();
        return http.build();
    }

}
