package com.mind.oops;

public class Overloading 
{	void sum(int a,int b)
	{	System.out.println("Sum= "+(a+b));
	}

	void sum(int a,int b,int c)
	{	System.out.println("Sum= "+(a+b+c));
	}
	
	void sum(double a,double b)
	{	System.out.println("Sum= "+(a+b));
	}  

	public static void main(String args[])
	{  	Overloading obj=new Overloading();  

		obj.sum(20,20);
		obj.sum(15,97,68);
		obj.sum(10.5,10.5);  
	}  
}
