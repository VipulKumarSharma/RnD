package com.mind.basic;

import java.util.Scanner;

public class ArrayAvg 
{
	Scanner sc = null;
	
	int[] i_arr = null;
	int i_sum = 0;
	float fl_avg = 0;
	short shrt_len = 0;
	
	public ArrayAvg()
	{	sc = new Scanner(System.in);
		System.out.println("Enter Length of array: ");
		shrt_len = sc.nextShort();
		i_arr = new int[shrt_len];
	}

	public void input_arr() 
	{	for(int cnt=0; cnt < i_arr.length;cnt++)
		{	System.out.println("arr["+cnt+"]: ");
			i_arr[cnt] = sc.nextInt();
			i_sum += i_arr[cnt];
		}
	}
	
	public void display_avg()
	{	fl_avg = (float)i_sum/(float)shrt_len;
		System.out.println("\nAverage of Array Elements : "+fl_avg);
	}
}
