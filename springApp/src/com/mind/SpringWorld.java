package com.mind;

public class SpringWorld {

	private String message;

	   public void setMessage(String message) {
	      this.message  = message;
	   }

	   public void getMessage() {
	      System.out.println("Your Message : " + message);
	   }
	   
	   public void init() {
	      System.out.println("Bean initialization...");
	   }
	   
	   public void destroy() {
	      System.out.println("Bean destruction...");
	   }
}
