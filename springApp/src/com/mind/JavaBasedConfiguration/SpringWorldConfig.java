package com.mind.JavaBasedConfiguration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.mind.SpringWorld;

@Configuration
public class SpringWorldConfig {

	@Bean 
	public SpringWorld springWorld(){
		return new SpringWorld();
	}
}
