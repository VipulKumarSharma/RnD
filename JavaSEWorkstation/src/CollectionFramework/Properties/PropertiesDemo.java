package CollectionFramework.Properties;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

public class PropertiesDemo {

	public static void main(String[] args) throws IOException {
		
		StringBuilder filePath	= new StringBuilder("src\\CollectionFramework\\Properties\\config.prop");
		FileInputStream fis 	= new FileInputStream(filePath.toString());
		Properties p 			= new Properties();
		
		p.load(fis);
		System.out.println(p);
		
		System.out.println("dbName="+p.getProperty("dbName"));
		System.out.println("Old Value : key="+p.setProperty("key", "OldValue"));
		System.out.println("Removed key : key="+p.remove("key "));				// Hashtable method
		
		System.out.println("Old Value : key="+p.setProperty("key", "NewValue"));
		System.out.println("Old Value : dbName="+p.setProperty("dbName", "MSAdventureWorks"));
		
		FileOutputStream fos 	= new FileOutputStream(filePath.toString());
		p.store(fos, "Changes done by VKS");
		
	}

}
