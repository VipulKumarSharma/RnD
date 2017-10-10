package com.mind.test;

import com.mind.ArrList.Student;
import com.mind.ArrList.StudentWorkbook;

public class testWorkbook extends Student
{
	public static void main(String[] args) 
	{	Student obj1 = new Student((short)11,"Abhinash","11th Boulevard Road");
		Student obj2 = new Student((short)12,"Saurabh","12th Boulevard Road");
		Student obj3 = new Student((short)13,"Mohit","13th Boulevard Road");
		Student obj4 = new Student((short)14,"Kanchan","14th Boulevard Road");
		Student obj5 = new Student((short)15,"Aaftab","15th Boulevard Road");
		Student obj6 = new Student((short)16,"Richa","16th Boulevard Road");
		Student obj7 = new Student((short)17,"Robert","17th Boulevard Road");
		Student obj8 = new Student((short)18,"Sukhwinder","18th Boulevard Road");
		Student obj9 = new Student((short)19,"Ruchi","19th Boulevard Road");
		Student obj10 = new Student((short)20,"Divya","20th Boulevard Road");
					
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
				
		//Print Elements of ArrayList
		print_ArrList();
		
		StudentWorkbook sw = new StudentWorkbook();
		sw.generateSimpleExcelReport();
	
	}

}
