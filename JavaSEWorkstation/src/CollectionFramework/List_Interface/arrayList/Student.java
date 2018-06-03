package CollectionFramework.List_Interface.arrayList;

import java.util.Comparator;

public class Student implements Comparable<Student> {

    private int 	rollno;
    private String 	name;
    private int 	age;
	
    /* Overridden method of Comparable Interface */
	@Override
	public int compareTo(Student anotherStudent) {
		int anotherStudentAge = anotherStudent.getAge();
		
		int ageDiff = this.age-anotherStudentAge;	// for descending use (-ageDiff)
		
		return ageDiff;
	}

	/* Custom Comparator */
	public static Comparator<Student> studentNameComparator = new Comparator<Student>() {
		
		public int compare(Student student1, Student student2) {
			String student1Name = student1.getName().toUpperCase();
			String student2Name = student2.getName().toUpperCase();
			
			int nameDiff = student1Name.compareTo(student2Name); 	// for descending order use student2Name.compareTo(student1Name)
			
			return nameDiff;
		}
	};
	
	/* Custom Comparator */
	public static Comparator<Student> studentRollNoComparator = new Comparator<Student>() {
		
		public int compare(Student student1, Student student2) {
			int student1RollNo = student1.getRollno();
			int student2RollNo = student2.getRollno();
			
			int rollNoDiff = student1RollNo - student2RollNo;
			
			return rollNoDiff;
		}
	};
	
	@Override
	public String toString() {
		return rollno+"-"+name+"("+age+")";
	}
	
	public int getRollno() {
		return rollno;
	}
	public void setRollno(int rollno) {
		this.rollno = rollno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}

	public Student(int rollno, String name, int age) {
		this.rollno = rollno;
		this.name = name;
		this.age = age;
	}

}
