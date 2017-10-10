package com.mind.test;

import java.io.File;
import java.io.IOException;

import com.mind.javaIO.List_dirRec;
import com.mind.javaIO.ReadDiskFile;

public class testReadFile 
{
	public static void main(String[] args) throws IOException 
	{	File currentDir = new File("."); 		// current directory
		ReadDiskFile rdf = new ReadDiskFile();
		List_dirRec ldr = new List_dirRec();
		
		rdf.read_file();
		rdf.append_text("\nIt is a Nice Poem!");
		rdf.read_file();
		
		System.out.println("==============================\n"
				+ "#List contents of a Directory:\n"
				+ "==============================");
		rdf.list_dirfiles(currentDir);
	
		System.out.println("==============================\n"
				+ "#List contents of a Directory(Recursively):\n"
				+ "==============================");
		ldr.list_dirfiles(currentDir);
	}

}
