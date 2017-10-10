package com.mind.ArrList;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Enumeration;
import java.util.Collections;

public class Student 
{
	public short shrt_rollNumber ;
	public String str_name ;
	public String str_address ;
	protected static ArrayList<Student> stu_al = new ArrayList<Student>();   
	
	public Student()
	{	shrt_rollNumber = 0 ;
		str_name = null ;
		str_address = null ;
	}
	
	public Student(short rn,String nm,String addr) 
	{	this.shrt_rollNumber = rn;
		this.str_name = nm;
		this.str_address = addr;
	}
	
	@Override
	public String toString()
	{	return (this.shrt_rollNumber+" "+this.str_name+" ["+this.str_address+"]");
	}
	
	protected static void print_ArrList()
	{	//Print ArrayList elements using for loop
	    System.out.println("\n# (i)For Loop: \n");
	    
	    for (int counter = 0; counter < stu_al.size(); counter++) 
	    {   System.out.println(stu_al.get(counter)); 		
	    }   		
		
	    //Print ArrayList elements using Advanced for loop
	    System.out.println("\n# (ii)Advanced For Loop: \n"); 		
	    
	    for (Student obj : stu_al) 
	     	System.out.println(obj); 		
	    
	    //Print ArrayList elements using while loop
        System.out.println("\n# (iii)While Loop: \n"); 		
        int count = 0; 		
        
        while (stu_al.size() > count) 
        {	System.out.println(stu_al.get(count));
	        count++;
	    }
        
        //Print ArrayList elements using Iterator
        System.out.println("\n# (iv)ArrayList elements[Iterator(while)]: \n");
		Iterator<Student> itr=stu_al.iterator();  
		
		while(itr.hasNext())
		{	Student st=(Student)itr.next();  
		    System.out.println(st.shrt_rollNumber+" "+st.str_name+" ["+st.str_address+"]");  
		}
		
		//Print ArrayList elements using Enumeration Interface
		Enumeration<Student> e = Collections.enumeration(stu_al);
		System.out.println("\n# (v)ArrayList elements[Enumeration]: \n");
	    
		while(e.hasMoreElements())
	    	System.out.println(e.nextElement());
	}

}
