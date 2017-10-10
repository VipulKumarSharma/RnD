package com.mind.EventHandling;

import org.springframework.context.ApplicationEvent;

public class CustomEvent extends ApplicationEvent {

	private static final long serialVersionUID = 6814755864033958247L;

	public CustomEvent(Object source) {
		super(source);
	}
	
	public String toString() {
	    return "Custom Event";
	}
}
