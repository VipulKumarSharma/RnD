package com.mind.JavaBasedConfiguration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;

@Configuration
public class LifecycleCallback {
	
	@Bean(initMethod = "init", destroyMethod = "destroy")
	@Scope("prototype")
	public Foo foo() {
	      return new Foo();
	}
}
