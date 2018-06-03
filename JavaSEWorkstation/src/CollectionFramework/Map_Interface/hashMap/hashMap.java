package CollectionFramework.Map_Interface.hashMap;

import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;
import java.util.Set;

public class hashMap {
	
	/*	HashMap methods
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

	@SuppressWarnings("unchecked")
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
		
		
		bool= hashMap.containsKey(2);
		System.out.println("\nHashMap contains key(2) = "+bool);
		
		
		bool= hashMap.containsValue("Rahul");
		System.out.println("\nHashMap contains Value('Rahul') = "+bool);
		
		
		String value = hashMap.get(3);
		System.out.println("\nGet value with key(3) = "+value);
		
		
		bool= hashMap.isEmpty();
		System.out.println("\nIs Hashmap empty = "+bool);
		
		
		String enteredValue = hashMap.put(7, "OverriddenValue");
		System.out.println("\nOverriding key(7) value("+enteredValue+")");
		System.out.println(hashMap);
		
		
		intValue = hashMap.size();
		System.out.println("\nHashmap size = "+intValue);
		
		
		Set<Integer> keySet = hashMap.keySet();
		System.out.println("\nHashmap keySet = "+keySet);
		
		
		Collection<String> valuesCollection = hashMap.values();
		System.out.println("\nHashmap values collection = "+valuesCollection);
		
		
		String removedValue = hashMap.remove(2);
		System.out.println("\nRemove Hashmap entry with key(2)= "+removedValue);
		System.out.println(hashMap);
		
		bool = hashMap.remove(9, "Ajeet");
		System.out.println("\nRemoveed Hashmap with Entry(9, 'Ajeet') = "+bool);
		System.out.println(hashMap);
		
		
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Cloning HashMap");
		System.out.println("-------------------------------------------------------------------");
		
		HashMap<Integer, String> clonedMap = (HashMap<Integer, String>) hashMap.clone();
		System.out.println(clonedMap);
		
		
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Clearing HashMap");
		System.out.println("-------------------------------------------------------------------");
		
		hashMap.clear();
		System.out.println(hashMap);
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Copying Cloned HashMap into original HashMap using putAll(Map)");
		System.out.println("-------------------------------------------------------------------");
		
		hashMap.putAll(clonedMap);
		System.out.println(hashMap);
		
		
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Looping HashMap (Entry set) using FOR loop over Entry Set");
		System.out.println("-------------------------------------------------------------------");
		
		for(Entry<Integer, String> entry: hashMap.entrySet()) {
			System.out.println(entry.getKey()+" : "+entry.getValue());
		}
		
		
		System.out.println("\n\n-------------------------------------------------------------------");
		System.out.println("Looping HashMap (Entry set) using ITERATOR");
		System.out.println("-------------------------------------------------------------------");
		
		Set<Entry<Integer, String>> entrySet = hashMap.entrySet();
		System.out.println("Entry Set - "+entrySet+"\n");
		
		Iterator<Entry<Integer, String>> itr = entrySet.iterator();
		
		while(itr.hasNext()) {
			Entry<Integer, String> entry = (Entry<Integer, String> ) itr.next();
			System.out.println(entry.getKey()+" : "+entry.getValue());
		}
				
	}

}
