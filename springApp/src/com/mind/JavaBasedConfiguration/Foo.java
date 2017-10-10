package com.mind.JavaBasedConfiguration;

public class Foo {
	public void init() {
		System.out.println("Initializing bean ....");
	}
	
	public void destroy() {
		System.out.println("Destroying bean ...");
	}
	
	public void fooFunc() {
		System.out.println("Inside Foo's function.");
	}
}