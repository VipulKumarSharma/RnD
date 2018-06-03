package CollectionFramework.List_Interface.arrayList;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Vector;

public class ArrayList_Conversions {

	public static void main(String[] args) {
		
	    System.out.println("-------------------------------------------------------------------");
		System.out.println("Converting LinkedList to ArrayList");
		System.out.println("-------------------------------------------------------------------");
		
		LinkedList<String> linkedlist = new LinkedList<String>();
	    linkedlist.add("Harry");
	    linkedlist.add("Jack");
	    linkedlist.add("Tim");
	    linkedlist.add("Rick");
	    linkedlist.add("Rock");
	    
		System.out.println(linkedlist+" - LinkedList");
	    ArrayList<String> arrList = new ArrayList<String>(linkedlist);
	    System.out.println(arrList+" - ArrayList");

	    
	    
	    System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Converting Vector to ArrayList");
		System.out.println("-------------------------------------------------------------------");
		
		Vector<String> vector = new Vector<String>();
		vector.add("Rahul");
		vector.add("Steve");
		vector.add("Jude");
		vector.add("Locke");
		vector.add("Mike");
		    
		System.out.println(vector+" - Vector");
	    arrList = new ArrayList<String>(vector);
	    System.out.println(arrList+" - ArrayList");
	    
	    
	    
	    System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Converting ArrayList to String array using FOR loop");
		System.out.println("-------------------------------------------------------------------");
		
	    String strNamesArr[] = new String[arrList.size()];              
		for(int i =0; i<arrList.size();i++) {
			strNamesArr[i] = arrList.get(i);
			System.out.println(strNamesArr[i]);
		}
		System.out.println(strNamesArr.toString());
		
		
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Converting ArrayList to String array using arrList.toArray()");
		System.out.println("-------------------------------------------------------------------");
		
		strNamesArr = arrList.toArray(new String[arrList.size()]);
		for(String str : strNamesArr) {
			System.out.println(str);
		}
		System.out.println(strNamesArr.toString());
		
		
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Converting Array to ArrayList using FOR loop");
		System.out.println("-------------------------------------------------------------------");
		
		ArrayList<String> emptyList = new ArrayList<String>();
		for (int i = 0; i < strNamesArr.length; i++) {
			emptyList.add(strNamesArr[i]);
		}
		System.out.println(emptyList);
		
		

		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Converting Array to ArrayList using Arrays.asList()");
		System.out.println("-------------------------------------------------------------------");
		
		ArrayList<String> namesList = new ArrayList<String>(Arrays.asList(strNamesArr));
		System.out.println(namesList);
		
		
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Converting Array to ArrayList using Collections.addAll(arraylist, array) \n-Faster & Better performance");
		System.out.println("-------------------------------------------------------------------");
		
		emptyList.clear();
		Collections.addAll(emptyList, strNamesArr);
		Collections.addAll(emptyList, "Added Record 1", "Added Record 2");
		System.out.println(emptyList);
		
		
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Converting HashSet to ArrayList ");
		System.out.println("-------------------------------------------------------------------");
		
		HashSet<String> hashSet = new HashSet<String>();
	    hashSet.add("Steve");
	    hashSet.add("Matt");
	    hashSet.add("Govinda");
	    hashSet.add("John");
	    hashSet.add("Tommy");
		
	    System.out.println(hashSet+" - HashSet");
	    emptyList.clear();
	    emptyList = new ArrayList<String>(hashSet);
	    System.out.println(emptyList+" - ArrayList");
	    
		
	}

}
