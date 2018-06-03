package CollectionFramework.Map_Interface.hashMap;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map.Entry;
import java.util.TreeMap;


public class HashMap_Sorting {

	public static void main(String[] args) {
		HashMap<Integer, String> hashMap = new HashMap<Integer, String>();
        hashMap.put(5, "A");
        hashMap.put(11, "C");
        hashMap.put(4, "Z");
        hashMap.put(77, "Y");
        hashMap.put(9, "P");
        hashMap.put(66, "Q");
        hashMap.put(0, "R");
        
        System.out.println("-------------------------------------------------------------------");
		System.out.println("HashMap");
		System.out.println("-------------------------------------------------------------------");
        
		System.out.println(hashMap);

        
		
        System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Sorting HashMap by keys using 'new TreeMap(HashMap)'");
		System.out.println("-------------------------------------------------------------------");
		
        TreeMap<Integer, String> treeMap = new TreeMap<Integer, String>(hashMap);
        System.out.println(treeMap);
        
        
        
        System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Sorting HashMap by values using LinedList, Comparator & LinkedHashMap");
		System.out.println("-------------------------------------------------------------------");
		
		hashMap = sortHashMapByValues_UsingComparator(hashMap);
		System.out.println(hashMap);
	}
	
	public static Comparator<Entry<Integer, String>> entrySetComparator = new Comparator<Entry<Integer, String>>() {
		public int compare(Entry<Integer, String> entry1, Entry<Integer, String> entry2) {
			String value1 	= entry1.getValue();
			String value2 	= entry2.getValue();
			
			int nameDiff 	= value1.compareTo(value2);
			
			return nameDiff;
		}
	};
	
	private static HashMap<Integer, String> sortHashMapByValues_UsingComparator(HashMap<Integer, String> hashMap) {
		LinkedHashMap<Integer, String> linkedHashMap 	= new LinkedHashMap<Integer, String>();
		List<Entry<Integer, String>> linkedList 		= new LinkedList<Entry<Integer, String>>(hashMap.entrySet());
		
		Collections.sort(linkedList, entrySetComparator);
		
		/* Using LinkedHashMap to preserve the insertion order */
		for(Entry<Integer, String> entry : linkedList) {
			Integer key 	= (Integer) entry.getKey();
			String value	= (String) entry.getValue();
			
			linkedHashMap.put(key, value);
		}
		
		return linkedHashMap;
	}

}
