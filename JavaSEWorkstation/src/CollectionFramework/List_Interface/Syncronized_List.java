package CollectionFramework.List_Interface;

import java.util.Arrays;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

public class Syncronized_List {

	public static void main(String[] args) {
		
		System.out.println("Getting syncronized version of List object using Collections.synchronizedList(List)");
		System.out.println("------------------------------------------");
		
		List<Integer> syncList = Collections.synchronizedList(Arrays.asList(5,1,2,4,3));
		System.out.println(syncList+"\n");
		
		
		synchronized (syncList) {
			/* Iterator should be in synchronized block in this type of synchronization */
			
			System.out.println("Iterating syncronized List in syncronized block");
			System.out.println("------------------------------------------");
			
			Iterator<Integer> itr = syncList.iterator();
			while(itr.hasNext()) {
				System.out.println(itr.next());
			}
		}
		
		
		System.out.println("\nGetting syncronized version of List object using CopyOnWriteArrayList");
		System.out.println("------------------------------------------");
		
		CopyOnWriteArrayList<String> cowal = new CopyOnWriteArrayList<String>();
		cowal.add("Pen");
		cowal.add("Notebook");
		cowal.add("Ink");
		System.out.println(cowal+"\n");
		
		/* synchronized block is not required for iterating CopyOnWriteArrayList */
		System.out.println("Iterating CopyOnWriteArrayList (synchronized block is not required)");
		System.out.println("------------------------------------------");
		
		Iterator<String> itr = cowal.iterator();
		while(itr.hasNext()) {
			System.out.println(itr.next());
		}
		
	}
}
