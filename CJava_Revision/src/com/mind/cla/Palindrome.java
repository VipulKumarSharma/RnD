package com.mind.cla;

public class Palindrome 
{	
	byte flag=1;
	
	public void check_Palindrome(String arr)
	{			
		for(int cnt1=0,cnt2=arr.length()-1; cnt1<(arr.length()-1)/2; ++cnt1,--cnt2)
			if((arr.charAt(cnt2))!=(arr.charAt(cnt1)))
				flag = 0;	
		
		if(flag==1)
			System.out.println("\n["+arr+"]"+ " is a palindrome");
		else if(flag == 0) 
			System.out.println("\n["+arr+"]"+ " is not a palindrome");
	}
	
}
