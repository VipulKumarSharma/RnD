package com.mind.test;

import com.mind.UserException.Voter;

public class testVoter 
{
	@SuppressWarnings("unused")
	public static void main(String[] args) 
	{	//Voter vt1,vt2,vt3,vt4 = null;
		try
		{  	Voter vt1 = new Voter("Vikas",(short)45,"21st Main Street,NY");
			Voter vt2 = new Voter("Rohit",(short)11,"3rd Boulevard Road,LA");
	    }
		catch(Exception ex)
		{	System.out.println("\nException occured: "+ ex);
		}
		
		finally
		{	try 
			{	Voter vt3 = new Voter("Rajesh",(short)91,"221b St.Louis,London");
				Voter vt4 = new Voter("Akhil",(short)17,"11 St.PetersBurg,CA");
			}
			catch (Exception ex) 
			{	System.out.println("\nException occured: "+ ex);
			}	
		}
	}
}
