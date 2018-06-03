package CollectionFramework.Map_Interface.hashMap;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;
import java.util.Set;

public class hashMap {

	public static void main(String[] args) {
		
		int intValue;
		Object obj;
		boolean bool;
		
		HashMap<Integer, String> hashMap = new HashMap<Integer, String>();

		hashMap.put(2, "Chaitanya");
		hashMap.put(5, "Rahul");
		hashMap.put(7, "Singh");
		hashMap.put(9, "Ajeet");
		hashMap.put(3, "Anuj");
		
		System.out.println(hashMap);
		
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Looping HashMap (Entry set) using ITERATOR");
		System.out.println("-------------------------------------------------------------------");
		
		Set<Entry<Integer, String>> entrySet = hashMap.entrySet();
		Iterator<Entry<Integer, String>> itr = entrySet.iterator();
		
		while(itr.hasNext()) {
			Entry<Integer, String> entry = (Entry<Integer, String> ) itr.next();
			System.out.println(entry.getKey()+" : "+entry.getValue());
		}
				
	}

}
