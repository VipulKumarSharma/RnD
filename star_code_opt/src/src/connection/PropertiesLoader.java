/***************************************************
*Copyright (C) 2000 MIND
*All rights reserved.
*The information contained here in is confidential and proprietary to MIND and forms the part of the MIND 
*Created BY		:	Manoj Chand
*Date			:	03 January 2013
*Description	:	To fetch STAR.properties path from system variables.
*Project		:	STARS
**********************************************************/ 

package src.connection;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;


public class PropertiesLoader  {
	private static final long serialVersionUID = 1L;
	public static final Properties config;
	static {
		
		String strPath	=System.getenv("STARS_HOME")+"\\config\\STAR_6_opt.properties";
		strPath = strPath.replaceAll("%20", " ");
		config = new Properties();
	  try {
		//System.out.println("In Property loader");
	    FileInputStream stream = new FileInputStream(strPath);
	    try {
	      config.load(stream);
	      if(config.size()<= 0){
	    	  System.out.println("STARS_HOME not set properly.");
	    	  throw new Exception();
	      }
	    }
	    finally {
	      stream.close();
	    }
	  }
	  catch (IOException ex) {
		  System.out.println("STARS_HOME not set properly.");
	    System.out.println("Error in loading Configration file --> "+ex.getMessage());
	  }catch(Exception ex){
		  System.out.println("STARS_HOME not set properly.");
		  System.out.println("Error in loading Configration file --> "+ex.getMessage());
	  }
	}

	public static void main(String[] args) {
		System.out.println("IN MAIn");
	}
  
}
