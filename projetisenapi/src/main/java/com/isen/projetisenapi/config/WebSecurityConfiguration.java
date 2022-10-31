package com.isen.projetisenapi.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
public class WebSecurityConfiguration extends WebSecurityConfigurerAdapter {

    private static final String[] AUTH_WHITE_LIST = {
            "/swagger-ui/**",
            "/v3/api-docs/**",
    };

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers(AUTH_WHITE_LIST).permitAll()
                .anyRequest()
                .authenticated();

        http.oauth2ResourceServer()
                .jwt();
    }
}