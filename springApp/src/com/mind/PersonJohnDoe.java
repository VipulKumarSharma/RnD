package com.mind;

public class PersonJohnDoe {
	
	private PersonJane jane;
	
	public void setJane(PersonJane jane) {
		System.out.println("setting Jane's reference" );
		this.jane = jane;
	}

	public PersonJane getJane() {
		System.out.println("Providing Jane's reference" );
		return jane;
	}
	
	public void JohnDoeFunc() {
		jane.janeFunc();
	}
}
