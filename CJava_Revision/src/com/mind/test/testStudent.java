package com.mind.test;
import com.mind.ArrList.Student;

public class testStudent extends Student
{
	public static void main(String[] args) 
	{	//10 objects of Student Class
		Student obj1 = new Student((short)1,"Rajat","1st Main Street");
		Student obj2 = new Student((short)2,"Aakash","2nd Main Street");
		Student obj3 = new Student((short)3,"Vishnu","3rd Main Street");
		Student obj4 = new Student((short)4,"Karan","4th Main Street");
		Student obj5 = new Student((short)5,"Atebal","5th Main Street");
		Student obj6 = new Student((short)6,"Rohit","6th Main Street");
		Student obj7 = new Student((short)7,"Rahul","7th Main Street");
		Student obj8 = new Student((short)8,"Gaurav","8th Main Street");
		Student obj9 = new Student((short)9,"Rakesh","9th Main Street");
		Student obj10 = new Student((short)10,"Sachin","10th Main Street");
				
		//10 objects added to ArrayList
		stu_al.add(obj1);
		stu_al.add(obj2);
		stu_al.add(obj3);
		stu_al.add(obj4);
		stu_al.add(obj5);
		stu_al.add(obj6);
		stu_al.add(obj7);
		stu_al.add(obj8);
		stu_al.add(obj9);
		stu_al.add(obj10);
		
		//Display ArrayList size
		System.out.println("ArrayList size : "+stu_al.size()+"\n");
	
		//Print Elements of ArrayList
		print_ArrList(); 
	}

}
