package CollectionFramework.List_Interface;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.Arrays;

public class Arraylist_Serialization {
	
	public static void main(String[] args) {
		
		ArrayList<Integer> arrList1 	= new ArrayList<Integer>(Arrays.asList(5,1,2,4,3));
		FileOutputStream fos		= null;
		ObjectOutputStream oos		= null;
		
		try {
			fos = new FileOutputStream("serialized_ArrayList_File");
			oos	= new ObjectOutputStream(fos);
			
			System.out.println("Serializing ArrayList");
			System.out.println("------------------------------------------");
			
			oos.writeObject(arrList1);
		
		} catch (IOException e) {
			System.out.println("Exception occurred while serializing object : "+e);
			
		} finally {
			try {
				oos.close();
				fos.close();
				
				System.out.println(arrList1);
				System.out.println("ArrayList serialized successfully\n");
				System.out.println("------------------------------------------");
				
			} catch (Exception e) {
				System.out.println("Error occurred while closing streams : "+e);
			}
		}
		
		
		/**********************************************************************/
		
		ArrayList<Integer> arrList2 = new ArrayList<Integer>();
		FileInputStream	fis			= null;
		ObjectInputStream ois		= null;
		
		try {
			fis = new FileInputStream("serialized_ArrayList_File");
			ois	= new ObjectInputStream(fis);
			
			System.out.println("De-Serializing ArrayList");
			System.out.println("------------------------------------------");
			
			arrList2 = (ArrayList<Integer>) ois.readObject();
		
		} catch (IOException e) {
			System.out.println("Exception occurred while de-serializing object : "+e);
			
		} catch (ClassNotFoundException e) { 
			System.out.println("Class for de-serialized object not found : "+e);
			
		} finally {
			try {
				ois.close();
				fis.close();
				
				System.out.println("ArrayList De-Serialized successfully");
				System.out.println(arrList2);
				
			} catch (Exception e) {
				System.out.println("Error occurred while closing streams : "+e);
			}
		}
	}

}
