package CollectionFramework.Map_Interface.hashMap;

import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

public class Synhcronized_Map {

	public static void main(String[] args) {
		
		HashMap<Integer, String> hashMap= new HashMap<Integer, String>();
        hashMap.put(2, "Anil");
        hashMap.put(44, "Ajit");
        hashMap.put(1, "Brad");
        hashMap.put(4, "Sachin");
        hashMap.put(88, "XYZ");
        
        System.out.println("Getting syncronized version of Map object using Collections.synchronizedMap(Map)");
		System.out.println("-----------------------------------------------------");
		
		
        Map<Integer, String> syncMap = Collections.synchronizedMap(hashMap);
        System.out.println(syncMap);

        Set<Entry<Integer, String>> entrySet = hashMap.entrySet();
		
		synchronized (syncMap) {
			/* Always Iterate the map in synchronized block */
			
			System.out.println("\n\nIterating synchronized Map in syncronized block");
			System.out.println("-----------------------------------------------------");
			
			Iterator<Entry<Integer, String>> itr = entrySet.iterator();
			while(itr.hasNext()) {
				Entry<Integer, String> entry = (Entry<Integer, String> ) itr.next();
				System.out.println(entry.getKey()+" : "+entry.getValue());
			}
		}
		
	}

}
