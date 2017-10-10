package com.mind.cla;

public class AvgCLA 
{
	short len;
	int i_sum;
	float fl_avg;
	
	public AvgCLA() 
	{	i_sum = len = 0;
		fl_avg = 0;
	}
	
	public void find_avg(String[] cla)
	{	len = (short)cla.length;
		
		for(short cnt=0; cnt < cla.length;cnt++)
		{	System.out.println("cla["+cnt+"]: "+cla[cnt]);
			i_sum += Integer.parseInt(cla[cnt]);
		}
		
		fl_avg =(float)i_sum/(float)len;
		System.out.println("\nAverage of Array Elements : "+fl_avg);
	}
}
