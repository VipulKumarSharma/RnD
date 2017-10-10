package com.mind.oops;

class parent
{	void sum(int i, int j)
	{	System.out.println("[Parent Class] Sum: "+(i+j));
	}
}
class child extends parent
{	void sum(int i, int j)
	{	System.out.println("[Child Class] Sum: "+(i+j));
	}
}
public class Polymorphism 
{
	public static void main(String[] args)
	{
		parent ref;
		parent p = new parent();
		child c = new child();
		
		ref = p ;
		ref.sum(45,39);
		
		ref = c ;
		ref.sum(56,91);
		
		parent pobj = new child();
		pobj.sum(37,83);
	}

}
