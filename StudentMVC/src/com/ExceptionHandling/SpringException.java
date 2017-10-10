package com.ExceptionHandling;

public class SpringException extends RuntimeException {
	private static final long serialVersionUID = 6438710346445422151L;
	private String exceptionMsg;
   
	public SpringException(String exceptionMsg) {
		this.exceptionMsg = exceptionMsg;
	}
   
	public String getExceptionMsg(){
		return this.exceptionMsg;
	}
   
	public void setExceptionMsg(String exceptionMsg) {
		this.exceptionMsg = exceptionMsg;
	}
}
