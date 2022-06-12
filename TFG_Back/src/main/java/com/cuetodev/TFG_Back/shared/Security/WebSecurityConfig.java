package com.cuetodev.TFG_Back.shared.Security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@EnableWebSecurity
@Configuration
public class WebSecurityConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry
                .addResourceHandler("/resources/**")
                .addResourceLocations("/resources/");
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.cors().and().csrf().disable()
                .addFilterAfter(new JWTAuthorizationFilter(), UsernamePasswordAuthenticationFilter.class)
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS).and().authorizeRequests()
                .antMatchers(HttpMethod.POST, "/api/v0/client").permitAll()
                .antMatchers(HttpMethod.POST, "/api/v0/appointment").permitAll()
                .antMatchers(HttpMethod.GET, "/api/v0/client/login").permitAll()
                .antMatchers(HttpMethod.GET, "/api/v0/client/token").permitAll()
                .antMatchers("images/**", "/resources/**","/resources/static/images/**").permitAll()
                .antMatchers("api/v0/**").hasAnyRole("USER", "WORKER", "ADMIN")
                .anyRequest().authenticated();

        return http.build();
    }
}
