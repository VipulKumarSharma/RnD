package com.mind.oops;

abstract class parent_cls
{	abstract void meth1();
	void meth2()
	{	System.out.println("Method of Abstract Class");
	}
}

class derived_cls extends parent_cls
{	void meth1()
	{	System.out.println("Method of Derived Class");
	}
}

interface employee
{	public void salary();
	int increment = 1000;
}

interface director
{	public void salary();
	int increment = 10000;
}

public class Abst_Interface implements employee,director
{	@Override
	public void salary() 
	{	System.out.println("\nSalary of Employee: "+(employee.increment+7000));
		System.out.println("\nSalary of Director: "+(director.increment+110000));
	}

	public static void main(String[] args)
	{	derived_cls dc = new derived_cls();
		dc.meth1();
		dc.meth2();
		
		Abst_Interface ai = new Abst_Interface();
		ai.salary();
	}

}
