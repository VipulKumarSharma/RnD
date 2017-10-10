package com.mind.javaIO;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class ReadDiskFile 
{
	BufferedReader br = null;
	File file = null, dir = null;
	FileWriter fw = null ;
	BufferedWriter bw = null;

	public void read_file()
	{
		// try-with-resources[closes file automatically]
		try(BufferedReader br = new BufferedReader(new FileReader("DiskFile.txt"))) 
		{ 	String str;
			
			while ((str = br.readLine()) != null) 
			{	System.out.println(str);
			}
		} 
		catch(FileNotFoundException ex) 
		{	System.out.println("\n!! Unable to open file !!" );                
        }
        catch(IOException ex) 
		{	System.out.println("\n!! Error reading file !!");                
            // ex.printStackTrace();
        }
	}
	
	public void append_text(String str)
	{	try
		{	file =new File("DiskFile.txt");
			if(!file.exists())
			{	file.createNewFile();
			}

			fw = new FileWriter(file.getName(),true);
		    bw = new BufferedWriter(fw);
		    bw.write(str);
		    bw.close();
	    
		    System.out.println("\n==============================\n"
		    		+ "# Text Appended Successfully\n"
		    		+ "==============================\n");
		}
		catch(FileNotFoundException ex) 
		{	System.out.println("\n!! Unable to open file !!" );                
	    }
	    catch(IOException ex) 
		{	System.out.println("\n!! Error reading file !!");                
	        // ex.printStackTrace();
		}
	}

	public void list_dirfiles(File dir)
	{	File[] listOfFiles = dir.listFiles();
		
		for (int i = 0; i < listOfFiles.length; i++) 
		{	if(listOfFiles.length == 0)
				System.out.println("\nThe directory is empty\n");
			else if (listOfFiles[i].isFile()) 
		    	System.out.println("File: [" + listOfFiles[i].getName()+
		    		"]  Size: ["+listOfFiles[i].length()+"] bytes");
		    
		    else if (listOfFiles[i].isDirectory()) 
		    	System.out.println("@Dir: [" + listOfFiles[i].getName()+"]");
		}
	}
}
