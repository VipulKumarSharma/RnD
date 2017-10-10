package com.mind.UserException;

public class Voter 
{
	String name = null,address = null;
	short age = 0;
	
	public  Voter(String name, short age,String addr)throws InvalidAgeException
	{	if(age<18)  
	      	throw new InvalidAgeException("\n!! Person NOT allowed to VOTE !!");  
	    else  
	    {	System.out.println("\nPerson Allowed to VOTE");
	    	this.name=name;
	    	this.age=age;
	    	this.address=addr;
	    	System.out.println(this.name+" Age:["+this.age+"]"+" Addr:["+this.address+"]");
		}
	}
}
