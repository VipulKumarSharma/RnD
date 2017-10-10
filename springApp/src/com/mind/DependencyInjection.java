package com.mind;

public class DependencyInjection {
   
	int 	intVal;
	String 	strVal;
	String	strVal1;
	
	public DependencyInjection(String strVal, int intVal, String strVal1){
		this.intVal = intVal;
		this.strVal = strVal;
		this.strVal1 = strVal1;
		
		System.out.println("Inside DependencyInjection constructor.");
	}

	public void dependencyInjectionFunc() {
		System.out.println("Inside DependencyInjection Function : strVal="+ strVal+"  inVal="+intVal+"  strVal1="+strVal1);
	}
   
}