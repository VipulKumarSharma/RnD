
/***************************************************
*Copyright (C) 2000 MIND 
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
 
*CREATED BY	:Manoj Chnad
*Date		:03 May 2013

*Project :STARS
*Operating environment:Tomcat 6.0 ,Sql server 2008

*DESCRIPTION : This class is used  for date related conversions etc.
**********************************************************/

package src.connection;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;

public class Bn_date_utility
{

	
// current date 
int int_ar_days[]={1,2,3,4,5,6,7,8,9,10,11,12};
String str_months[]={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
Calendar cal= Calendar.getInstance();

String str_return_date	=	null;
	/* This is a public function which will  increase days acc. to user's value and return the date in user's specified format*/
	public String getDays(int i,String str_date_format)
	{

		try{
				cal= Calendar.getInstance();
				str_return_date		=	null;
				int int_temp		=	0;
				int int_day			=	0;
				int int_mdays		=	0;
				String str_month	=	null;
				String str_year		=	null; 
				str_date_format=str_date_format.trim();			
				cal.add(Calendar.DATE,i);
			    int_temp = cal.get(Calendar.DATE);
				int_day = int_temp;
				int_temp = cal.get(Calendar.MONTH)+1;
				int_mdays=int_ar_days[int_temp-1];

				str_month=str_months[int_temp-1];
				int_temp = cal.get(Calendar.YEAR);
				str_year = ""+int_temp;
				String str_month_concat	=	"";
				String str_day_concat	=	"";
				if(int_day<10)
				{
					str_day_concat	=	"0";
				}
				if(int_mdays<10)
				{
					str_month_concat	=	"0";
				}
				
				if(str_date_format.equals("DD/MM/YYYY"))
				{
					 str_return_date=str_day_concat+int_day+"/"+str_month_concat+int_mdays+"/"+str_year;	
				}
				
				if(str_date_format.equals("MM/DD/YYYY"))
				{
					 str_return_date=str_month_concat+int_mdays+"/"+str_day_concat+int_day+"/"+str_year;	
				}
				if(str_date_format.equals("YYYY/MM/DD"))
				{
					 str_return_date=str_year+"/"+str_month_concat+int_mdays+"/"+str_day_concat+int_day;	
				}
				if(str_date_format.equals("DD/MON/YYYY"))
				{
					 str_return_date=str_day_concat+int_day+"/"+str_month.substring(0,3)+"/"+str_year;	
				}
				if(str_date_format.equals("MON/DD/YYYY"))
				{
					 str_return_date=str_month.substring(0,3)+"/"+str_day_concat+int_day+"/"+str_year;	
				}
				if(str_date_format.equals("YYYY/MON/DD"))
				{
					 str_return_date=str_year+"/"+str_month.substring(0,3)+"/"+str_day_concat+int_day;	
				}
				if(str_date_format.equals("YYYY-MM-DD"))
				{
					 str_return_date=str_year+"-"+str_month_concat+int_mdays+"-"+str_day_concat+int_day;	
				}

			} //end of try
			catch(Exception se)
			{
				System.out.println("error in date");
			}
			return str_return_date;

	}//end of function

		/* This is a public function which will  increase month acc. to user's value and return the date in user's specified format*/

public String getMonth(int i,String str_date_format)
	{

		try{
				cal= Calendar.getInstance();
				str_return_date		=	null;			
				str_date_format=str_date_format.trim();					
				int int_temp = cal.get(Calendar.DATE);
				int int_day = int_temp;
				cal.add(Calendar.MONTH,i);
				int_temp = cal.get(Calendar.MONTH)+1;
				int int_mdays=int_ar_days[int_temp-1];
				String str_month=str_months[int_temp-1];
				int_temp = cal.get(Calendar.YEAR);
				String str_year = ""+int_temp;
				String str_month_concat	=	"";
				String str_day_concat	=	"";
				if(int_day<10)
				{
					str_day_concat	=	"0";
				}
				if(int_mdays<10)
				{
					str_month_concat	=	"0";
				}
				
				if(str_date_format.equals("DD/MM/YYYY"))
				{
					 str_return_date=str_day_concat+int_day+"/"+str_month_concat+int_mdays+"/"+str_year;	
				}
				
				if(str_date_format.equals("MM/DD/YYYY"))
				{
					 str_return_date=str_month_concat+int_mdays+"/"+str_day_concat+int_day+"/"+str_year;	
				}
				if(str_date_format.equals("YYYY/MM/DD"))
				{
					 str_return_date=str_year+"/"+str_month_concat+int_mdays+"/"+str_day_concat+int_day;	
				}
				if(str_date_format.equals("DD/MON/YYYY"))
				{
					 str_return_date=str_day_concat+int_day+"/"+str_month.substring(0,3)+"/"+str_year;	
				}
				if(str_date_format.equals("MON/DD/YYYY"))
				{
					 str_return_date=str_month.substring(0,3)+"/"+str_day_concat+int_day+"/"+str_year;	
				}
				if(str_date_format.equals("YYYY/MON/DD"))
				{
					 str_return_date=str_year+"/"+str_month.substring(0,3)+"/"+str_day_concat+int_day;	
				}
				if(str_date_format.equals("YYYY-MM-DD"))
				{
					 str_return_date=str_year+"-"+str_month_concat+int_mdays+"-"+str_day_concat+int_day;	
				}
			} //end of try
			catch(Exception se)
			{
				System.out.println("error in date");
			}
			return str_return_date;

	}//end of function

/* This is a public function which will  increase year acc. to user's value and return the date in user's specified format*/

public String getYear(int i,String str_date_format)
	{

		try{
				cal= Calendar.getInstance();
				str_return_date		=	null;
				str_date_format=str_date_format.trim();			
				int int_temp = cal.get(Calendar.DATE);
				int int_day = int_temp;				
				int_temp = cal.get(Calendar.MONTH)+1;
				int int_mdays=int_ar_days[int_temp-1];
				String str_month=str_months[int_temp-1];
				cal.add(Calendar.YEAR,i);
				int_temp = cal.get(Calendar.YEAR);
				String str_year = ""+int_temp;
				String str_month_concat	=	"";
				String str_day_concat	=	"";
				if(int_day<10)
				{
					str_day_concat	=	"0";
				}
				if(int_mdays<10)
				{
					str_month_concat	=	"0";
				}
			
				if(str_date_format.equals("DD/MM/YYYY"))
				{
					 str_return_date=str_day_concat+int_day+"/"+str_month_concat+int_mdays+"/"+str_year;	
				}
				
				if(str_date_format.equals("MM/DD/YYYY"))
				{
					 str_return_date=str_month_concat+int_mdays+"/"+str_day_concat+int_day+"/"+str_year;	
				}
				if(str_date_format.equals("YYYY/MM/DD"))
				{
					 str_return_date=str_year+"/"+str_month_concat+int_mdays+"/"+str_day_concat+int_day;	
				}
				if(str_date_format.equals("DD/MON/YYYY"))
				{
					 str_return_date=str_day_concat+int_day+"/"+str_month.substring(0,3)+"/"+str_year;	
				}
				if(str_date_format.equals("MON/DD/YYYY"))
				{
					 str_return_date=str_month.substring(0,3)+"/"+str_day_concat+int_day+"/"+str_year;	
				}
				if(str_date_format.equals("YYYY/MON/DD"))
				{
					 str_return_date=str_year+"/"+str_month.substring(0,3)+"/"+str_day_concat+int_day;	
				}
				if(str_date_format.equals("YYYY-MM-DD"))
				{
					 str_return_date=str_year+"-"+str_month_concat+int_mdays+"-"+str_day_concat+int_day;	
				}
			} //end of try
			catch(Exception se)
			{
				System.out.println("error in date");
			}
			return str_return_date;
	}//end of function
	/* This is a public function which will  return today's date to user*/
	public  String getTodayDate(String str_date_format)
	{

		try{

				cal= Calendar.getInstance();
				str_return_date		=	null;
				int int_temp = cal.get(Calendar.DATE);
				int int_day = int_temp;	
				int_temp = cal.get(Calendar.MONTH)+1;
				int int_mdays=int_ar_days[int_temp-1];
				String str_month=str_months[int_temp-1];
				int_temp = cal.get(Calendar.YEAR);
				String str_year = ""+int_temp;
				String str_month_concat	=	"";
				String str_day_concat	=	"";
				if(int_day<10)
				{
					str_day_concat	=	"0";
				}
				if(int_mdays<10)
				{
					str_month_concat	=	"0";
				}

				
				if(str_date_format.equals("DD/MM/YYYY"))
				{
					 str_return_date=str_day_concat+int_day+"/"+str_month_concat+int_mdays+"/"+str_year;	
				}
				if(str_date_format.equals("MM/DD/YYYY"))
				{
					 str_return_date=str_month_concat+int_mdays+"/"+str_day_concat+int_day+"/"+str_year;	
				}
				if(str_date_format.equals("YYYY/MM/DD"))
				{
					 str_return_date=str_year+"/"+str_month_concat+int_mdays+"/"+str_day_concat+int_day;	
				}
				if(str_date_format.equals("DD/MON/YYYY"))
				{
					 str_return_date=str_day_concat+int_day+"/"+str_month.substring(0,3)+"/"+str_year;	
				}
				if(str_date_format.equals("MON/DD/YYYY"))
				{
					 str_return_date=str_month.substring(0,3)+"/"+str_day_concat+int_day+"/"+str_year;	
				}
				if(str_date_format.equals("YYYY/MON/DD"))
				{
					 str_return_date=str_year+"/"+str_month.substring(0,3)+"/"+str_day_concat+int_day;	
				}
				if(str_date_format.equals("YYYY-MM-DD"))
				{
					 str_return_date=str_year+"-"+str_month_concat+int_mdays+"-"+str_day_concat+int_day;	
				}
			} //end of try
			catch(Exception se)
			{
				System.out.println("error in date");
			}
			return str_return_date;

	}//end of function
	/**************************************************************
 
Method                      :getDateDiff
 
Return Values()				:String
 
Parameter(s)				:str_date_format  - date_format
							:sch_end_date- schedule end date
							:time- tells the time of mail
						
Author						:Vikram
Date						:16 th. oct. 2002
 
Purpose						:This method will return the required date acc. to time
 
**************************************************************/
 

	public String getDateDiff(String str_date_format,String sch_end_date,String time)
	{
		boolean	check_date	=	false;
		try
		{
				str_return_date		=	null;
				if(time.equals("53"))//for day
				{							

					str_return_date=getDays(1,str_date_format);

				}

				if(time.equals("54"))//for week
				{
					str_return_date=getDays(7,str_date_format);

				}
				if(time.equals("55"))//foe month
				{
					str_return_date=getMonth(1,str_date_format);
				}
				if(time.equals("56"))//for year
				{
					str_return_date=getYear(1,str_date_format);
				}

				check_date=(new Date(str_return_date)).before(new Date(sch_end_date));	

				
			} //end of try
			catch(Exception se)
			{
				System.out.println("error in date");
			}
			if(check_date==false)
			{
				return str_return_date;

			}
			else
			{
				return sch_end_date;
			}

	}//end of function


/**************************************************************
 
Method                      :formatDate
Return Values()				:Date
Parameter(s)				:str_date  - date
							:str_date_format  - date_format
Author						:Surinder
Date						:17 th. oct. 2002
Purpose						:This method will return the required date object.
 
**************************************************************/
	public java.sql.Date formatDate(String str_date,String str_date_format)
	{
							 					 

		str_date_format=str_date_format.trim();
		int i_date=0;
		int i_month=0;
		int i_year=0;
		try
		{
			if(str_date==null || str_date.trim().equals(""))
			{

			}
			else
			{
				if(str_date_format.equals("DD/MM/YYYY"))
				{
					 i_date=Integer.parseInt(str_date.substring(0,2));
					 i_month=Integer.parseInt(str_date.substring(3,5));
					 i_year=Integer.parseInt(str_date.substring(6,10));
				}
				if(str_date_format.equals("MM/DD/YYYY"))
				{
					 i_month=Integer.parseInt(str_date.substring(0,2));
					 i_date=Integer.parseInt(str_date.substring(3,5));
					 i_year=Integer.parseInt(str_date.substring(6,10));
				}
				if(str_date_format.equals("YYYY/MM/DD"))
				{
					 i_month=Integer.parseInt(str_date.substring(5,7));
					 i_date=Integer.parseInt(str_date.substring(8,10));
					 i_year=Integer.parseInt(str_date.substring(0,4));

				}
			}//end of if

		} //end of try
		catch(Exception se)
		{
			System.out.println("error in formatting the date>>"+se);
		}

		if(str_date==null || str_date.trim().equals(""))
		{
			java.sql.Date d_date=null;			
			return d_date;
		}
		else
		{			
			return new java.sql.Date(i_year-1900,i_month-1,i_date);
			
		}
	}//end of function

	/**************************************************************
 
Method                      :formatDate
Return Values()				:Date
Parameter(s)				:str_date  - date
							:str_date_format  - date_format
Author						:vikram vohra
Date						:5 dec. 2002
Purpose						:This method will return the required date string
 
**************************************************************/
	public String formatDate(String str_date,String str_date_format,String str_db_date_format)
	{
		int i_date=0;
		int i_month=0;
		int i_year=0;
		String return_date	=	null;
		try
		{
			String str_day_concat	=	"";
			String str_month_concat	=	"";
			if(str_date==null || str_date.trim().equals(""))
			{
				return "";
			}
			else
			{
				if(str_date_format.equals("DD/MM/YYYY"))
				{
					 i_date=Integer.parseInt(str_date.substring(0,2));
					 i_month=Integer.parseInt(str_date.substring(3,5));
					 i_year=Integer.parseInt(str_date.substring(6,10));
				}
				else if(str_date_format.equals("MM/DD/YYYY"))
				{
					 i_month=Integer.parseInt(str_date.substring(0,2));
					 i_date=Integer.parseInt(str_date.substring(3,5));
					 i_year=Integer.parseInt(str_date.substring(6,10));
				}
				else if(str_date_format.equals("YYYY/MM/DD"))
				{
					 i_month=Integer.parseInt(str_date.substring(5,7));
					 i_date=Integer.parseInt(str_date.substring(8,10));
					 i_year=Integer.parseInt(str_date.substring(0,4));
				}				
				else if(str_date_format.equals("YYYY-MM-DD"))
				{
					 i_month=Integer.parseInt(str_date.substring(5,7));
					 i_date=Integer.parseInt(str_date.substring(8,10));
					 i_year=Integer.parseInt(str_date.substring(0,4));
				}				
				else {
					
					return str_date;
					
				}
				
				if(i_date<10)
				{
					str_day_concat	=	"0";
				}
				if(i_month<10)
				{
					
						str_month_concat	=	"0";
				}

				
				if(str_db_date_format.equals("DD/MM/YYYY"))
				{
						
					 return_date	=	str_day_concat+i_date+"/"+str_month_concat+i_month+"/"+i_year;
				}
				//@Gaurav on 7 Jan 2008
				else if(str_db_date_format.equals("MON DD, YYYY"))
				{								
					return_date	=convertMonthInWords(i_month)+" "+i_date+", "+i_year;	//str_day_concat+i_date+"-"+convertMonthInWords(i_month)+"-"+i_year;
					
				}
				else if(str_db_date_format.equals("MM/DD/YYYY"))
				{
					 return_date	=	str_month_concat+i_month+"/"+str_day_concat+i_date+"/"+i_year;

				}
				else if(str_db_date_format.equals("YYYY/MM/DD"))
				{
					 return_date	=	i_year+"/"+str_month_concat+i_month+"/"+str_day_concat+i_date;

				}
				/*if(str_db_date_format.equals("DD/MON/YYYY"))
				{
					return_date	=	i_year+"/"+i_month+"/"+i_date;
				}
				if(str_db_date_format.equals("MON/DD/YYYY"))
				{
					 i_month=Integer.parseInt(str_date.substring(0,3));
					 i_date=Integer.parseInt(str_date.substring(4,6));
					 i_year=Integer.parseInt(str_date.substring(7,11));
				}
				if(str_db_date_format.equals("YYYY/MON/DD"))
				{
					 i_month=Integer.parseInt(str_date.substring(5,8));
					 i_date=Integer.parseInt(str_date.substring(9,11));
					 i_year=Integer.parseInt(str_date.substring(0,4));
				}*/
				else if(str_db_date_format.equals("YYYY-MM-DD"))
				{
					 return_date	=	i_year+"-"+str_month_concat+i_month+"-"+str_day_concat+i_date;
				}
				else {
					
					return str_date;
					
				}
			
			}//end of if

		} //end of try
		catch(Exception se)
		{
			System.out.println("error in formatting the date>>"+se);
		}

		return return_date;
	}//end of function
	

	/**************************************************************
	 
	Method                      :convertMonthInWords
	Return Values()				:Date
	Parameter(s)				:month starts from 0 to 11								
	Author						:Gaurav
	Date						:7th Jan 2008
	Purpose						:This method will return the month in word
	 
	**************************************************************/
	public String convertMonthInWords(int month){
		String monthInWord[]={"Jan","Feb","Mar","Apr","May","Jun","July","Aug","Sep","Oct","Nov","Dec"};
		
		return monthInWord[month-1];
		
	}


/**************************************************************
 
Method                      :formatDate
Return Values()				:Date
Parameter(s)				:str_date  - date
							:str_date_format  - date_format
Author						:Surinder
Date						:17 th. oct. 2002
Purpose						:This method will return the required date object.
 
**************************************************************/
	public String convertDate(Date d_date,String str_date_format)
	{
		String str_date=null;
		if (d_date==null)
		{

		}
		else
		{
		str_date=d_date.toString();
		}
		StringBuffer sb_formatted_date=new StringBuffer();
		try{
				if(str_date==null || str_date.trim().equals(""))
				{
				}
				else
				{
					if(str_date_format.equals("DD/MM/YYYY"))
					{
						 sb_formatted_date.append(str_date.substring(8,10)).append("/").append(str_date.substring(5,7)).append("/").append(str_date.substring(0,4));
					}
					if(str_date_format.equals("MM/DD/YYYY"))
					{
						 sb_formatted_date.append(str_date.substring(5,7)).append("/").append(str_date.substring(8,10)).append("/").append(str_date.substring(0,4));
					}
					if(str_date_format.equals("YYYY/MM/DD"))
					{
						 sb_formatted_date.append(str_date.substring(0,4)).append("/").append(str_date.substring(5,7)).append("/").append(str_date.substring(8,10));
					}
					if(str_date_format.equals("YYYY-MM-DD"))
					{
						 sb_formatted_date.append(str_date.substring(0,4)).append("-").append(str_date.substring(5,7)).append("-").append(str_date.substring(8,10));
					}
					

				}
			} //end of try
			catch(Exception se)
			{
				System.out.println("error in formatting the date>>"+se);
			}
			if(str_date==null || str_date.trim().equals(""))
			{
				String s_date ="";
				return s_date;
			}
			else
			{
			return sb_formatted_date.toString();
			}

	}//end of function
	/**************************************************************
 
Method                      :formatDate
Return Values()				:Date
Parameter(s)				:str_date  - date
							:str_date_format  - date_format
Author						:Vikram
Date						:25 th. feb. 2003
Purpose						:This method will return the required date string for display.
 
**************************************************************/
	public String convertDate(String d_date,String str_date_format)
	{
		String str_date=null;
		if (d_date==null)
		{

		}
		else
		{
		str_date=d_date;
		}
		StringBuffer sb_formatted_date=new StringBuffer();
		try{
				if(str_date==null || str_date.trim().equals(""))
				{
				}
				else
				{
					if(str_date_format.equals("DD/MM/YYYY"))
					{
						 sb_formatted_date.append(str_date.substring(8,10)).append("/").append(str_date.substring(5,7)).append("/").append(str_date.substring(0,4));
					}
					if(str_date_format.equals("MM/DD/YYYY"))
					{
						 sb_formatted_date.append(str_date.substring(5,7)).append("/").append(str_date.substring(8,10)).append("/").append(str_date.substring(0,4));
					}
					if(str_date_format.equals("YYYY/MM/DD"))
					{
						 sb_formatted_date.append(str_date.substring(0,4)).append("/").append(str_date.substring(5,7)).append("/").append(str_date.substring(8,10));
					}
					if(str_date_format.equals("YYYY-MM-DD"))
					{
						 sb_formatted_date.append(str_date.substring(6,10)).append("-").append(str_date.substring(0,2)).append("-").append(str_date.substring(3,5));
					}
				}
			} //end of try
			catch(Exception se)
			{
				System.out.println("error in formatting the date>>"+se);
			}
			if(str_date==null || str_date.trim().equals(""))
			{
				String s_date ="";
				return s_date;
			}
			else
			{
			return sb_formatted_date.toString();
			}

	}//end of function


	public java.sql.Date getTodayDate()
	{

		Calendar cal1=Calendar.getInstance();
		return new java.sql.Date(cal1.get(Calendar.YEAR)-1900,cal1.get(Calendar.MONTH),cal1.get(Calendar.DAY_OF_MONTH));
	}
/**************************************************************
 
Method                      :getDayDiff
Return Values()				:Date
Parameter(s)				:date  - from_date
							:date  - to_date
Author						:Vikram
Date						:8/4/2003
Purpose						:This method will return the no of days between two dates
 
**************************************************************/
	public long getDayDiff(Date from_date,Date to_date)
	{
		long days	=0;
		try{
			//first method
//Date date1 = new Date(2000 - 1900, 9, 10);
//Date date2 = new Date(2032 - 1900, 9, 11);

//2. Calculate difference in milliseconds with:
//long ms = date2.getTime() - date1.getTime();

//3. Turn milliseconds into days by dividing 24 * 60 * 60 * 1000:
//long days = ms / (24 * 60 * 60 * 1000);

//this is second method

				long fromTime = from_date.getTime();

				long toTime = to_date.getTime();

				long difference = toTime - fromTime;

				days = (difference/(1000*60*60*24)); // no. of days between the two dates

			} //end of try
			catch(Exception se)
			{
				System.out.println("error in formatting the date>>"+se);
			}
			
	return days;
	}//end of function
	
	
public String ConvertDateTo(String d_date) throws IOException
	{
		String lang_Path	=	new String(getClass().getResource("../../resource/MessageResources.properties").getPath());
		lang_Path = lang_Path.replaceAll("%20", " ");
		String str_date=null;
		
		if(d_date==null){
			
		}else{
			str_date=d_date;
		}
		StringBuffer strdateFromsb = new StringBuffer();
		try
		{
			FileInputStream propfile = new FileInputStream(lang_Path);
			Properties gasprop = new Properties();
			gasprop.load(propfile);
			String dateflag=gasprop.getProperty("date.flag");
			if(dateflag.equalsIgnoreCase("NO"))
			{
				return str_date;
			}
			else if(dateflag.equalsIgnoreCase("YES"))
			{
                strdateFromsb.append(str_date.substring(0,4)).append("/").append(str_date.substring(8,10)).append("/").append(str_date.substring(5,7));
				//strdateFromsb.append(str_date.substring(8,10)).append("/").append(str_date.substring(5,7)).append("/").append(str_date.substring(0,4));
			}
			
		} catch (FileNotFoundException e)
		{
			e.printStackTrace();
		}
	//	System.out.println("strdateFromsb   "+strdateFromsb);
		 return strdateFromsb.toString();
	}
	
	
}//end of class

