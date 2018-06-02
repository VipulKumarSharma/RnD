package CollectionFramework.List_Interface;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

public class arrayList {
	
	/*	ArrayList methods
	 * 	
	 * 	boolean -	add(Object o);
	 * 	void	- 	add(int index, Object o);
	 * 	Object	- 	set(int index, Object o);
	 * 	int 	-	indexOf(Object o);
	 * 	Object	- 	get(int index);
	 * 	int 	-	size();
	 *  boolean -	contains(Object o);
	 *  boolean	- 	remove(Object o);
	 * 	Object	- 	remove(int index);
	 *  void	-	clear();
	 */
	
	@SuppressWarnings({ "unused", "unlikely-arg-type" })
	public static void main(String[] args) {
		
		int intValue;
		Object obj;
		boolean bool;
		ArrayList<String> arrayList = new ArrayList<>(12);
		
		bool = arrayList.add("A");
		System.out.println(arrayList+" : "+bool+"\n");
		
		arrayList.add(1, "B");
		arrayList.add(2, "C");
		arrayList.add(2, "Value@2");
		System.out.println(arrayList+"\n");
		
		
		obj = arrayList.set(2, "Updated");
		System.out.println("Updated value = "+obj);
		System.out.println(arrayList+"\n");
		
		
		intValue = arrayList.indexOf(new Integer(515));
		System.out.println("Index of 515 = "+intValue);
		intValue = arrayList.indexOf("C");
		System.out.println("Index of 'C' = "+intValue+"\n");
		
		
		obj = arrayList.get(1);
		System.out.println("Object at index 1 = "+obj+"\n");
		
		
		intValue = arrayList.size();
		System.out.println("Size of list = "+intValue);
		System.out.println(arrayList+"\n");
		
		bool = arrayList.contains("C");
		System.out.println("List contains 'C' = "+bool+"\n");
		
		
		bool = arrayList.remove("A");
		System.out.println("Removed 'A' = "+bool);
		System.out.println(arrayList+"\n");
		
		
		obj = arrayList.remove(0);
		System.out.println("Removed Object at index 0 = "+obj);
		System.out.println(arrayList+"\n");
		
		
		arrayList.clear();
		System.out.println("Clearing ArrayList");
		System.out.println(arrayList+"\n");
		
		
		
		/**********************************************************************/
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Initialization using Arrays.asList(Object... obj)");
		System.out.println("-------------------------------------------------------------------");
		
		List<Integer> intList = Arrays.asList(5,1,2,4,3);
		ArrayList<Integer> numbers = new ArrayList<Integer>(intList);
		System.out.println(numbers+"\n");
		
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Initialization using Anonymous Inner Class");
		System.out.println("-------------------------------------------------------------------");
		
		ArrayList<String> cities = new ArrayList<String>(){
			private static final long serialVersionUID = 1850122397425468513L;
			{ 	add("Delhi");
			   	add("Agra");
			   	add("Chennai");
			   	add("Mumbai");
			   	add("Bangalore");
			}
		};
		System.out.println(cities+"\n");
		
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Initialization using Collections.nCopies(no_of_copies, element)");
		System.out.println("-------------------------------------------------------------------");
		
		ArrayList<Integer> numList = new ArrayList<Integer>(Collections.nCopies(5, 0));
		System.out.println(numList+"\n");
		
		
		
		/**********************************************************************/
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Looping ArrayList using normal FOR loop");
		System.out.println("-------------------------------------------------------------------");
		for(int i=0; i<numbers.size(); i++) {
			System.out.println(numbers.get(i));
		}
		
		
		
		/**********************************************************************/
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Looping ArrayList using ADVANCED FOR loop");
		System.out.println("-------------------------------------------------------------------");
		for(String city : cities) {
			System.out.println(city);
		}
		
		
		
		/**********************************************************************/
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Looping ArrayList using WHILE loop");
		System.out.println("-------------------------------------------------------------------");
		
		int count = 0;
		while(count < numbers.size()) {
			System.out.println(numbers.get(count));
			count++;
		}
		
		
		
		/**********************************************************************/
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Looping ArrayList using ITERATOR");
		System.out.println("-------------------------------------------------------------------");
		
		Iterator<String> itr = cities.iterator();
		while(itr.hasNext()) {
			System.out.println(itr.next());
		}
		
		
		
		/**********************************************************************/
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Looping ArrayList using ENUMERATION");
		System.out.println("-------------------------------------------------------------------");
		
		Enumeration<Integer> eNum = Collections.enumeration(numbers);
		while(eNum.hasMoreElements()) {
			System.out.println(eNum.nextElement());
		}
		
		
		
		/**********************************************************************/
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Sorting ArrayList using Collections.sort(List<T> list)");
		System.out.println("-------------------------------------------------------------------");
		
		Collections.sort(numbers);
		
		System.out.println(numbers+"\n");
		
		
		
		/**********************************************************************/
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Sorting ArrayList in descending order using Collections.sort(List<T> list, Comparator<T>)");
		System.out.println("-------------------------------------------------------------------");
		
		Collections.sort(numbers, Collections.reverseOrder());
		
		System.out.println(numbers+"\n");
		
		
		
		/**********************************************************************/
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Sorting ArrayList in descending order using Collections.sort() \nthen Collections.reverse()");
		System.out.println("-------------------------------------------------------------------");
		
		Collections.sort(numbers);
		Collections.reverse(numbers);
		
		System.out.println(numbers+"\n");
		
		
		/**********************************************************************/
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Add Collection to ArrayList using addAll(Collection)");
		System.out.println("-------------------------------------------------------------------");
		numbers.addAll(numList);
		System.out.println(numbers+"\n");
		
		
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Add Collection at specific index of ArrayList using addAll(index, Collection)");
		System.out.println("-------------------------------------------------------------------");
		
		numbers.addAll(2, numList);
		System.out.println(numbers+"\n");
		
		
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Check whether arraylist contains some Collection using containsAll(Collection)");
		System.out.println("-------------------------------------------------------------------");
		
		System.out.println(numbers.containsAll(numList));
		
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Get subList from ArrayList using subList(startIndex, endIndex)");
		System.out.println("-------------------------------------------------------------------");
		
		List<String> subCities = cities.subList(2, cities.size());
		System.out.println(cities);
		System.out.println(subCities);
		
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Swap Elements of list by indexes using Collections.swap(List, index1, index2);");
		System.out.println("-------------------------------------------------------------------");
		
		System.out.println(numbers);
		Collections.swap(numbers, 0, 3);
		System.out.println(numbers);
		
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Cloning ArrayList");
		System.out.println("-------------------------------------------------------------------");
		ArrayList<Integer> orgAL = new ArrayList<Integer>(Arrays.asList(5,1,2,4,3));
	    System.out.println(orgAL+" Original AL");

	    ArrayList<String> clonedAL = (ArrayList<String>)orgAL.clone();
	    System.out.println(clonedAL+" Shallow copy of AL\n");
	    
	    orgAL.remove(2);
	    orgAL.add(99);

	    System.out.println(orgAL+" Original AL");
	    System.out.println(clonedAL+" Shallow copy of AL");
		
		
	    System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Reduce the capacity of ArrayList to current size using trimToSize()");
		System.out.println("-------------------------------------------------------------------");
		orgAL.trimToSize();
		System.out.println(orgAL);
		
		
		/*	Consider a scenario when there is a need to add huge number of elements to an already full ArrayList,
		 *	in such case ArrayList has to be resized several number of times which would result in a poor performance.
		 *	For such scenarios ensureCapacity() method of ArrayList class is very useful
		 *  as it increases the size of the ArrayList by a specified capacity.
		 */
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Increasing ArrayList capacity to 15 using ensureCapacity(15)");
		System.out.println("-------------------------------------------------------------------");
		clonedAL.ensureCapacity(15);
		System.out.println(clonedAL);
		
		
		
		
		/**********************************************************************/
		
	    System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Sorting ArrayList using COMPARABLE Interface (by Age)");
		System.out.println("-------------------------------------------------------------------");
		
		ArrayList<Student> studentList = new ArrayList<Student>();
		studentList.add(new Student(222, "Chaitanya", 26));
		studentList.add(new Student(333, "Rahul", 24));
		studentList.add(new Student(444, "Ajeet", 32));

		System.out.println(studentList);
		Collections.sort(studentList);
		System.out.println(studentList+"\n");
		
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Sorting ArrayList using COMPARATOR Interface (by Name)");
		System.out.println("-------------------------------------------------------------------");
		Collections.sort(studentList, Student.studentNameComparator);
		System.out.println(studentList+"\n");
		
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Sorting ArrayList using COMPARATOR Interface (by RollNo)");
		System.out.println("-------------------------------------------------------------------");
		Collections.sort(studentList, Student.studentRollNoComparator);
		System.out.println(studentList+"\n");
		
		/**********************************************************************/
		
	}

}
