package CollectionFramework.Map_Interface.hashMap;

import java.awt.Color;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.PriorityQueue;
import java.util.concurrent.ThreadLocalRandom;

class Hashing {
	int hashCode;
	int min;
	int max;
	int indexLimit;
	int index;
	
	public Hashing(int min, int max, int indexLimit) {
		this.min 		= min;
		this.max 		= max;
		this.indexLimit = indexLimit;
	}
	
	@Override
	public int hashCode() {
		/*hashCode 	= (int) (Math.random() * max + min);
		index 		= hashCode % indexLimit;*/
		
		hashCode 	= ThreadLocalRandom.current().nextInt(min, max + 1);
		index 		= hashCode & indexLimit;
		
		return index;
	}
	
	@Override
	public void finalize() {
		System.out.println("\nHashing object is getting destroyed by GC ...\n");
	}
}

public class HashMapDemo extends Hashing {
	
	public HashMapDemo(int min, int max, int indexLimit) {
		super(min, max, indexLimit);
	}

	@SuppressWarnings("unchecked")
	public static void main(String[] args) {
		int maxIndex = 20;
		HashMapDemo hd 	= new HashMapDemo(100000, 999999, maxIndex-1);
		
		System.out.println("Calculated Index= "+hd.hashCode()+"\nCalculated Hash = "+ hd.hashCode);
		
		hd = null;
		//Runtime.getRuntime().gc();
		System.gc();
		
		PriorityQueue<Integer> pq	= new PriorityQueue<Integer>();
		pq.offer(9560789);
		pq.offer(1111111);
		
		ArrayList<String> al 		= new ArrayList<String>();
		al.add("MIND");
		al.add("Software");
		
		HashMap<String, Object> map = new HashMap<String, Object>(maxIndex, 0.95f);
		map.put("1", pq);
		map.put("2", al);
		
		HashMap<String, Object> mapClone = (HashMap<String, Object>) map.clone();		
		mapClone.put("4", "UP");
		mapClone.remove("2");
		mapClone.replace("4", Color.GREEN);
		
		map.put("3", "C-26, Noida");
		
		System.out.println("Class 	 	: "+map.getClass().getName());
		System.out.println("Map hash 	: "+map.hashCode());
		System.out.println("HashMap	 	: "+map);
		
		System.out.println();
		
		System.out.println("EntrySet 	: "+map.entrySet());
		System.out.println("KeySet 	 	: "+map.keySet());
		System.out.println("Values 	 	: "+map.values());
		
		System.out.println();
		
		System.out.println("Clone hash 	: "+mapClone.hashCode());
		System.out.println("Clone	 	: "+mapClone);
	}
}
