package CollectionFramework.Map_Interface.hashMap;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.HashMap;

public class HashMap_Serialization {

	@SuppressWarnings("unchecked")
	public static void main(String[] args) {
		
		FileOutputStream fos				= null;
		ObjectOutputStream oos				= null;
		HashMap<Integer, String> hashMap 	= new HashMap<Integer, String>();
        
		hashMap.put(11, "AB");
        hashMap.put(2, "CD");
        hashMap.put(33, "EF");
        hashMap.put(9, "GH");
        hashMap.put(3, "IJ");
        
        try {
        	fos = new FileOutputStream("serialized_HashMap_File");
			oos	= new ObjectOutputStream(fos);
			
			System.out.println("Serializing HashMap");
			System.out.println("------------------------------------------");
			
			oos.writeObject(hashMap);
			
        } catch(IOException e) {
        	System.out.println("Exception occurred while serializing object : "+e);
        	
        } finally {
        	try {
				oos.close();
				fos.close();
				
				System.out.println(hashMap);
				System.out.println("HashMap serialized successfully\n");
				System.out.println("------------------------------------------");
				
			} catch (Exception e) {
				System.out.println("Error occurred while closing streams : "+e);
			}
		}

        /**********************************************************************/
		
        HashMap<Integer, String> hashMap2 	= new HashMap<Integer, String>();
		FileInputStream	fis					= null;
		ObjectInputStream ois				= null;
		
		try {
			fis = new FileInputStream("serialized_HashMap_File");
			ois	= new ObjectInputStream(fis);
			
			System.out.println("De-Serializing HashMap");
			System.out.println("------------------------------------------");
			
			hashMap2 = (HashMap<Integer, String>) ois.readObject();
		
		} catch (IOException e) {
			System.out.println("Exception occurred while de-serializing object : "+e);
			
		} catch (ClassNotFoundException e) { 
			System.out.println("Class for de-serialized object not found : "+e);
			
		} finally {
			try {
				ois.close();
				fis.close();
				
				System.out.println("HashMap De-Serialized successfully");
				System.out.println(hashMap2);
				
			} catch (Exception e) {
				System.out.println("Error occurred while closing streams : "+e);
			}
		}
	}

}
