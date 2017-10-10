package com.mind.javaIO;

import java.io.File;
import java.io.IOException;

public class List_dirRec extends ReadDiskFile
{	
	public void list_dirfiles(File dir)
	{	try 
		{	File[] files = dir.listFiles();
			
			for (File file : files) 
			{	if(files.length == 0)
					System.out.println("\nThe directory is empty\n");
			
				else if (file.isDirectory()) 
				{	System.out.println("@Dir: [" + file.getName()+
						"] ["+file.getCanonicalPath()+"]\n");
					
					list_dirfiles(file);
				} 
				else if (file.isFile())
					System.out.println("File: (" + file.getName()+
				    		")  Size: ("+file.length()+") bytes"+
							"  ("+file.getCanonicalPath()+")\n");
			}
		} 
		catch (IOException e) 
		{	e.printStackTrace();
		}
	}
	
}
