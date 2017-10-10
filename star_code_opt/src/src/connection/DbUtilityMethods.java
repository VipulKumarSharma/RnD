/***************************************************
*Copyright (C) 2000 MIND
*All rights reserved.
*The information contained here in is confidential and *proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Sachin Gupta.
*Date			:	23/08/2006 (DD/MM/YYYY format)
*Description	:	General Connection Class For JSP and Action Classes
*Project		:	STAR
*Date of Modification  : 1.  10 may 2007 
*Rivision History: 1. findReportAccessInMainMenu() method changed by sachin on 10 May for showing the Report menu to Unit head. 
					and also add distinct cluase in	
				   2. Introduce centralise scheme for accessing db settings by Gaurav Aggarwalon 06-Jun-2007 	
							query of  findReportSiteListForUser() method
				   3.@Sanjeet Kumar 17-July-2007 defined a constructor for using resource path globally
                   4 :   Added new code for Adding new role for  showing reports for New role SM  open on 30-Apr-08 by shiv Sharma 
				   5.  Added a new role for Corporate persone for giving new report Access on 05-Jun-08 by shiv sharma   
				   6. Modified by vaibhav on jul 19 2010 to add new method sSSOUrlByMailid()
 *Modified By			:Manoj Chand
 *Date of Modification	:13 feb 2011
 *Modification			:Add findSearchSiteListForUser method for search report
 
 *Modified By			:Manoj Chand
 *Date of Modification	:17 May 2011
 *Modification			:Sort unit name in dropdown for mata
 *
 *Modified By			:Manoj Chand
 *Date of Modification	:03 Jan 2013
 *Modification			:commented constructor and fetch connection through star.properties located outside application.
 *
 *Modified By			:Manoj Chand
 *Date of Modification	:21 Oct 2013
 *Modification			:https is used instead of http in application name
**********************************************************/ 

package src.connection;

import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;
import java.util.TreeMap;

import javax.naming.Context;
import javax.sql.DataSource;

import src.mail.MailBean;
import src.connection.LabelRepository;
import src.connection.PropertiesLoader;
/**
 * @author sachin gupta
 *
 * To change the template for this generated type comment go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */

public class DbUtilityMethods 
{
     private Connection conn;
     private Statement stmt;
	 private PreparedStatement pstmt;
	 private CallableStatement cstmt;
	 private ArrayList ApproversList = new ArrayList();
	 private String dbdriver		="";
	 private String dburl			="";
	 private String dbuser			="";
     private String dbpwd			="";
	 private String Path			="";
	 private String strReplaced		="";
	 LabelRepository LableMst=new LabelRepository();
	 //create cunstructor by Sanjeet Kumar o 17-July-07 for using global path
	 public DbUtilityMethods ()
	{
      //Path=new String(getClass().getResource("STAR.properties").getPath());
     // System.out.println("Before replaced Path is >>> "+Path);
	    /*      for(int i=0;i<Path.length();i++)
			 {
	         strReplaced =Path.replace("%20"," ");
			 }*/

			
	}
    //End constructor here
 
    /**************************************************************
     Method             :getNewId(String tableName) 
     Return Values()	:int 
     Parameter(s)		:String tableName
     Purpose			:This method is for generating the new unique id.
     **************************************************************/
     public int getNewId(String tableName)    
	 {
		 int id = 1;
		 int tempId = 1;
		 String sql = "Select * from "+tableName+" order by 1";
		 DbConnectionBean dbCon = new DbConnectionBean();
		 try
		 {
           ResultSet rs = dbCon.executeQuery(sql);
		   while(rs.next())
		   {
               tempId = rs.getInt(1);  
			   if(id == tempId)
			   {
				   id++;
			   }
			   else
               {
                  break;    
               }
			   //System.out.println("inside rs"+tempId);
		   }
		   rs.close();
		   dbCon.close();
		 }
		 catch(Exception e)
		 {
			 System.out.println("Error in getNewId(String tableName) of DbUtilityMethods==="+e);
		 }
		 return id;
	 }

/**************************************************************
     Method             :getNewId(String tableName,String ColomnName) 
     Return Values()	:int 
     Parameter(s)		:String tableName
     Purpose			:This method is for generating the new unique id.
**************************************************************/
     public int getNewId(String tableName,String columnName)    
	 {
		 int id = 1;
		 int tempId = 1;
		 String sql = "Select "+columnName+" from "+tableName+" order by 1";
		 DbConnectionBean dbCon = new DbConnectionBean();
		 try
		 {
           ResultSet rs = dbCon.executeQuery(sql);
		   while(rs.next())
		   {
               tempId = rs.getInt(columnName);  
			   if(id == tempId)
			   {
				   id++;
			   }
			   else
               {
                  break;    
               }
			   //System.out.println("inside rs"+tempId);
		   }
		   rs.close();
		   dbCon.close();
		 }
		 catch(Exception e)
		 {
			 System.out.println("Error in getNewId(String tableName, String columnName) of DbUtilityMethods==="+e);
		 }
		 return id;
	 }

/**************************************************************
     Method             :getNewGeneratedId() 
     Return Values()	:int 
     Parameter(s)		:String columnName
     Purpose			:This method is for generating the new unique Travel_Req_Id.
**************************************************************/
     public int getNewGeneratedId(String columnName)    
	 {
		 int id = 0;
		 int intSuccess = 0;
		 try
		 {
		   DataSource ds;
	       Context ic = null;
		   //@Gaurav on 06-Jun-2007 Centralise scheme for accessing db properties
  		   //System.out.println("String replaced"+strReplaced);
	       //commented by manoj on 03 jan 2013
   		   /*FileInputStream propfile = new FileInputStream(strReplaced);			
		   	  if ( propfile != null)
				{
					Properties pmsprop = new Properties();
					pmsprop.load( propfile);
					propfile.close();
					dbdriver=pmsprop.getProperty("dbdriver")==null?"":pmsprop.getProperty("dbdriver");
					dburl=pmsprop.getProperty("dburl")==null?"":pmsprop.getProperty("dburl");
					dbuser=pmsprop.getProperty("dbuser")==null?"":pmsprop.getProperty("dbuser");
					dbpwd=pmsprop.getProperty("dbpwd")==null?"":pmsprop.getProperty("dbpwd");
				}*/
		   	  //added by manoj chand on 03 jan 2013
		   	dbdriver=PropertiesLoader.config.getProperty("dbdriver")==null?"":PropertiesLoader.config.getProperty("dbdriver");
			dburl=PropertiesLoader.config.getProperty("dburl")==null?"":PropertiesLoader.config.getProperty("dburl");
			dbuser=PropertiesLoader.config.getProperty("dbuser")==null?"":PropertiesLoader.config.getProperty("dbuser");
			dbpwd=PropertiesLoader.config.getProperty("dbpwd")==null?"":PropertiesLoader.config.getProperty("dbpwd");
		   	  
		   	  
		   	  
           //Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
           //conn = DriverManager.getConnection("jdbc:odbc:star","wfp","#mind@pms9211");
			 Class.forName(dbdriver);
             conn = DriverManager.getConnection(dburl,dbuser,dbpwd);
			 //End of Code @Gaurav

		   //ic = new InitialContext();
           //ds = (javax.sql.DataSource)ic.lookup("java:comp/env/jdbc/star");
		   //conn = ds.getConnection();           
		   cstmt = conn.prepareCall("{?=call proc_generatetid(?,?)}");//PROCEDURE to insert AND the row in T_TRAVEL_REQID_GENERATE 
		   cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
           cstmt.setString(2, columnName);    
           cstmt.registerOutParameter(3,java.sql.Types.INTEGER);
		   intSuccess    =  cstmt.executeUpdate();
		   id            =  cstmt.getInt(3);  
		   //System.out.println("New id is=="+id);
           conn.close();
		 }
		 catch(Exception e)
		 {
			 System.out.println("Error in getNewTravelId(?) of DbUtilityMethods==="+e);
		 }
		 return id;
	 }

/**************************************************************
     Method             :findApprovers(int userId) 
     Return Values()	:ArrayList
     Parameter(s)		:int userId
     Purpose			:This method is for finding approvers hierarchy corresponding to userid.
**************************************************************/

	 public ArrayList findApprovers(int  userId, String strTravelType)
	 {	

			String strMApprover = "";	
			String strTravelType1 = "";
			strTravelType1 = strTravelType;
			DbConnectionBean dbCon = new DbConnectionBean();

			 try
			 {
			   String sql = "SELECT REPORT_TO FROM M_USERINFO WHERE USERID ="+userId+" AND STATUS_ID = 10 AND APPLICATION_ID = 1";
			   ResultSet rs = dbCon.executeQuery(sql);
			   if(rs.next())
			   {									   
				   strMApprover = rs.getString("REPORT_TO");
//System.out.println("strMApprover====Report to============"+strMApprover);
				   sql = "SELECT APPROVER_ID FROM M_DEFAULT_APPROVERS WHERE APPROVER_ID ="+strMApprover+" AND TRV_TYPE='"+strTravelType+"' AND STATUS_ID = 10 AND APPLICATION_ID = 1"  ;
//				   System.out.println("query is"+sql);
				   ResultSet rs1 = dbCon.executeQuery(sql);
					if (ApproversList.contains(strMApprover))
					{
						return ApproversList;
					}
				   
				   
				   if(!rs1.next())
				   {
//						System.out.println("inside if"+strMApprover);
						sql = "SELECT USERID FROM M_USERINFO WHERE USERID ="+strMApprover+"AND ROLE_ID = 'HR' AND STATUS_ID = 10 AND APPLICATION_ID = 1";	
						ResultSet rs2 = dbCon.executeQuery(sql);
					    if(!rs2.next())
						{
//							System.out.println("inside if"+strMApprover);
							sql = "SELECT USERID FROM M_USERINFO WHERE USERID ="+strMApprover+"AND ROLE_ID = 'CHAIRMAN' AND STATUS_ID = 10 AND APPLICATION_ID = 1";	
							ResultSet rs3 = dbCon.executeQuery(sql);
							if(!rs3.next())
							{
//								System.out.println("inside if"+strMApprover);
								sql = "SELECT USERID FROM M_USERINFO WHERE USERID ="+strMApprover+"AND ROLE_ID = 'MATA' AND STATUS_ID = 10 AND APPLICATION_ID = 1";	
								ResultSet rs4 = dbCon.executeQuery(sql);
								if(!rs4.next())
								{
									if (strMApprover != null && !"".equals(strMApprover) && !strMApprover.equals("0"))
									{
										ApproversList.add(new String(strMApprover));
									}		
								}	
							 }
						  }					
					}		
			   }
			   dbCon.close();
			   if (strMApprover!= null && !"".equals(strMApprover))
			   {
					findApprovers(Integer.parseInt(strMApprover),strTravelType1);

				}
			 }
			 catch(Exception e)
			 {
				 System.out.println("Error in FIND APPROVERS of DbUtilityMethods==="+e);
			 }
			return ApproversList;			
		}

/**************************************************************
     Method             :encrypt(String oldPassword) 
     Return Values()	:void
     Parameter(s)		:String oldPassword
     Purpose			:This method is for encrypt the string value
	 Developed by       :Luxmi Nagda
**************************************************************/
        public String encrypt(String oldPassword)
		{
		  int len=oldPassword.length();
		  String newPassword="";
		  int temp[]=new int[len];
		  int i=0;
		  int ran=(int)(Math.floor(Math.random()*256)+1);
		  //System.out.println("random no is =="+ran);
		  int ch;
		  for(i=0;i<len;i++)
		  {
		  ch=oldPassword.charAt(i);
		  temp[i]=Integer.parseInt(""+ch);
		  if((temp[i]>=0) && (temp[i]<64)) temp[i] +=128;
		  else if((temp[i]>=64) && (temp[i]<128)) temp[i] +=128;
		  else if((temp[i]>=128) && (temp[i]<192)) temp[i] -=128;
		  else if((temp[i]>=192) && (temp[i]<256)) temp[i] -=128;
		  else ;
		  temp[i] +=ran;
		  newPassword +=convertToBoolean(temp[i]);   
		 }
		 newPassword +=convertToBoolean(ran);
		 //System.out.println("New Password After Encryption is::"+newPassword);
		 //System.out.println("New Password length After Encryption is::"+newPassword.length());		 
		 return newPassword;
		}


/**************************************************************
     Method             :decryptInDecimal(String password) 
     Return Values()	:void
     Parameter(s)		:String password
     Purpose			:This method is for decrypt the encrypted boolean value into decimalvalue without the random no.
 	 Developed by       :Luxmi Nagda
**************************************************************/
        public String decryptInDecimal(String password)
        {
			int len=password.length();
			String oldPassword="";
			int pwdLen=((len/9)-1);
			int temp[]=new int[pwdLen];
			int k=0;
			int i=0;
			int ran;
			
  
			String strbooleantemp="";
			String strbooleanRan=password.substring(len-9);
			ran=convertToDecimal(strbooleanRan);
	
			for(k=0;k<(pwdLen);k++)
			{
			    strbooleantemp=password.substring((9*k),9*(k+1));
				//System.out.println("strbooleantemp in decimal=="+convertToDecimal(strbooleantemp));
			    temp[k]=(convertToDecimal(strbooleantemp)-ran);
			    //System.out.println("temp[k]==="+temp[k]); 
				oldPassword +=temp[k]+"";
				//System.out.println("characters=="+oldPassword);
			}
			return oldPassword;
		}


/**************************************************************
     Method             :decryptFromDecimalToString(String password) 
     Return Values()	:void
     Parameter(s)		:String password
     Purpose			:This method decrypt the decimal value(that is stored in database without random no) into actual string value
 	 Developed by       :Luxmi Nagda
**************************************************************/
       public String decryptFromDecimalToString(String password)
       {
			int len=password.length();
			String oldPassword="";
			int pwdLen=(len/3);
			int temp[]=new int[pwdLen];
			int k=0;
			int i=0;
			char p;  
			String strbooleantemp="";
			for(k=0;k<(pwdLen);k++)
			{
				strbooleantemp=password.substring((3*k),3*(k+1));
				temp[k]=Integer.parseInt(strbooleantemp);
		
				if((temp[k]>=0) && (temp[k]<64))         { temp[k] +=128;}
				else if((temp[k]>=64) && (temp[k]<128))  { temp[k] +=128;}
				else if((temp[k]>=128) && (temp[k]<192)) { temp[k] -=128;}
				else if((temp[k]>=192) && (temp[k]<256)) { temp[k] -=128;}
				else ;
		  
				p=(char)temp[k];
				oldPassword +=p;
				//System.out.println("characters=="+oldPassword);
			}
			return oldPassword;
		}


/**************************************************************
     Method             :convertToDecimal(String password) 
     Return Values()	:void
     Parameter(s)		:String strbooleancode
     Purpose			:This method is for converting the boolean value to decimal value.
	 Developed by       :Luxmi Nagda
**************************************************************/
		public int convertToDecimal(String strbooleancode)
		{
		     int i      = 0;
			 int j      = 0; 
		     int result = 0;
		     int base   = 2;
		     char temp   = '-';
		     for(i=0,j=8; i<9; i++,j--)
		     {
		        temp=strbooleancode.charAt(i);
		        result += Math.pow(base,j)*Integer.parseInt(""+temp);
		     }     
			// System.out.println("value is =="+result);
		     return result;
		}
/**************************************************************
     Method             :convertToBoolean(String password) 
     Return Values()	:void
     Parameter(s)		:int intcode
     Purpose			:This method is for converting the decimal value to boolean value.
	 Developed by       :Luxmi Nagda
**************************************************************/
		public String convertToBoolean(int intcode)
		{
		    int num=intcode;
		    int quot;
		    int div=2;
		    int rem;
		    int temp[]=new int[9];
			int temp2[]=new int[9];
			int len=temp.length;
		    String str="";
		    int k=0;
			for(k=0;num!=0;k++)
		    {
				 quot=num/div;
			     rem=num%div;
			     temp[k]=rem;
			     num=quot;     
			}
			// for suffixing zeros to make it 9bit.
			for(int i=k;i<len;i++)
			    temp[i]=0;
			// For storing valuesreversing array
			for(int i=len-1,j=0;i>=0;i--,j++)
			{
				temp2[j]=temp[i];
			}
		    // for converting array to string value.
			for(int i=0;i<len;i++)
		    str +=temp2[i];
		    return str;
		}


/**************************************************************
     Method             :decrypt(String password) 
     Return Values()	:void
     Parameter(s)		:int intcode
     Purpose			:This method is for converting the  boolean value to String.
	 Developed by       :Sachin Gupta
**************************************************************/

public String decrypt(String password)
{
  int len=password.length();
  String oldPassword="";
  int pwdLen=((len/9)-1);
  int temp[]=new int[pwdLen];
  int k=0;
  int i=0;
  int ran;
  char p;
  String strbooleantemp="";
  String strbooleanRan=password.substring(len-9);
  ran=convertToDecimal(strbooleanRan);
  
  for(k=0;k<(pwdLen);k++)
  {
    strbooleantemp=password.substring((9*k),9*(k+1));
    temp[k]=(convertToDecimal(strbooleantemp)-ran);
    
    if((temp[k]>=0) && (temp[k]<64)) 
	{ 
		//System.out.println("Inside Quad1"); 
		temp[k] +=128;
	}
    else if((temp[k]>=64) && (temp[k]<128)) 
	{ 
		//System.out.println("Inside Quad2"); 
		temp[k] +=128;
	}
    else if((temp[k]>=128) && (temp[k]<192)) 
	{
		//System.out.println("Inside Quad3"); 
		temp[k] -=128;
	}
    else if((temp[k]>=192) && (temp[k]<256)) 
	{ 
		//System.out.println("Inside Quad4"); 
		temp[k] -=128;
	} 

    else ;
  
    p=(char)temp[k];
	oldPassword +=p;
	//System.out.println("characters=="+oldPassword);
  }
  //System.out.println("Decrypted oldPassword="+oldPassword);
return oldPassword;
}

/**************************************************************
     Method             :findApprovers(int userId) 
     Return Values()	:ArrayList
     Parameter(s)		:int userId
     Purpose			:This method is for finding approvers hierarchy corresponding to userid.
**************************************************************/

	 public ArrayList findApproversNew(int  userId, String siteId, String strTravelType)
	 {
			String strMApprover = "";	
			String strTravelType1 = "";
			strTravelType1 = strTravelType;
			DbConnectionBean dbCon = new DbConnectionBean();

			 try
			 {
			   String sql = "SELECT REPORT_TO FROM M_USERINFO WHERE USERID ="+userId+" AND STATUS_ID = 10 AND APPLICATION_ID = 1";
			   ResultSet rs = dbCon.executeQuery(sql);
			   if(rs.next())
			   {									   
				   strMApprover = rs.getString("REPORT_TO");
//System.out.println("strMApprover====Report to============"+strMApprover);
				   sql = "SELECT APPROVER_ID FROM M_DEFAULT_APPROVERS WHERE APPROVER_ID ="+strMApprover+" AND SITE_ID="+siteId+" AND TRV_TYPE='"+strTravelType+"' AND STATUS_ID = 10 AND APPLICATION_ID = 1"  ;
//				   System.out.println("query is"+sql);
				   ResultSet rs1 = dbCon.executeQuery(sql);
					if (ApproversList.contains(strMApprover))
					{
						return ApproversList;
					}
				   
				   
				   if(!rs1.next())
				   {
//						System.out.println("inside if"+strMApprover);
						sql = "SELECT USERID FROM M_USERINFO WHERE USERID ="+strMApprover+"AND ROLE_ID = 'HR' AND STATUS_ID = 10 AND APPLICATION_ID = 1";	
						ResultSet rs2 = dbCon.executeQuery(sql);
					    if(!rs2.next())
						{
//							System.out.println("inside if"+strMApprover);
							sql = "SELECT USERID FROM M_USERINFO WHERE USERID ="+strMApprover+"AND ROLE_ID = 'CHAIRMAN' AND STATUS_ID = 10 AND APPLICATION_ID = 1";	
							ResultSet rs3 = dbCon.executeQuery(sql);
							if(!rs3.next())
							{
//								System.out.println("inside if"+strMApprover);
								sql = "SELECT USERID FROM M_USERINFO WHERE USERID ="+strMApprover+"AND ROLE_ID = 'MATA' AND STATUS_ID = 10 AND APPLICATION_ID = 1";	
								ResultSet rs4 = dbCon.executeQuery(sql);
								if(!rs4.next())
								{
									if (strMApprover != null && !"".equals(strMApprover) && !strMApprover.equals("0"))
									{
										ApproversList.add(new String(strMApprover));
									}		
								}	
							 }
						  }					
					}		
			   }
			   dbCon.close();
			   if (strMApprover!= null && !"".equals(strMApprover))
			   {
					findApproversNew(Integer.parseInt(strMApprover), siteId, strTravelType1);

				}
			 }
			 catch(Exception e)
			 {
				 System.out.println("Error in FIND APPROVERS of DbUtilityMethods==="+e);
			 }
			return ApproversList;			
		}


/**************************************************************
     Method             :getApproverAccoringToRole(String strUserId, String strSiteId) 
     Return Values()	:ArrayList
     Parameter(s)		:int userId
     Purpose			:This method is for finding persons according to the role_id who will get mail 
**************************************************************/
   public ArrayList getApproverAccoringToRole(String strUserId, String strSiteId) 
   {
	   ArrayList aList = new ArrayList();
	   String strRoleId = "";
	   ResultSet rs     = null;
	   String strSql = "SELECT ROLE_ID, EMAIL FROM M_USERINFO WHERE USERID="+strUserId+" AND SITE_ID="+strSiteId+" AND STATUS_ID=10 AND APPLICATION_ID=1";
	   try
	   {
   			DbConnectionBean dbCon = new DbConnectionBean();
			rs = dbCon.executeQuery(strSql);
			if(rs.next())
		    {
				strRoleId    = rs.getString("ROLE_ID");
		    }
			rs.close();

            //code commented by shiv sharma on 18-Mar-08----------------------------------    
			/*if(strRoleId != null && strRoleId.equals("HR"))
		    {
			strSql = "SELECT USERID,.DBO.user_name(USERID) AS USERNAME,EMAIL FROM M_USERINFO WHERE SITE_ID="+strSiteId+" AND ROLE_ID='HR' AND STATUS_ID=10 AND APPLICATION_ID=1";
			rs = dbCon.executeQuery(strSql);
				while(rs.next())
				{
					//aList.add(rs.getString("USERID"));
					aList.add(rs.getString("USERNAME"));
					aList.add(rs.getString("EMAIL"));
				}
				rs.close();
		    }
			else*/
		    {
				strSql = "SELECT USERID,.DBO.user_name(USERID) AS USERNAME,EMAIL FROM M_USERINFO WHERE USERID="+strUserId+" AND STATUS_ID=10 AND APPLICATION_ID=1";
				rs = dbCon.executeQuery(strSql);
				if(rs.next())
				{
					//aList.add(rs.getString("USERID"));
					aList.add(rs.getString("USERNAME"));
					aList.add(rs.getString("EMAIL"));
				}
				rs.close();				
		    }
	   }
	   catch(Exception e)
	   {
		   System.out.println("Error in getApproverAccoringToRole(int userId)=========="+e);
	   }
	   return aList;
   }


/**************************************************************
     Method             :getApproverOnTravelDateChange(String strTrvelId,  String strTravelType, String SuserRole) 
     Return Values()	:TreeMap
     Parameter(s)		:String strTrvelId
     Purpose			:This method is for finding persons when travel date change after submission of the requisition
						 ans who will get mail about the changes
**************************************************************/
    public TreeMap getApproverOnTravelDateChange(String strRequisitionId, String strTravelType, String SuserRole)
    {
        ArrayList aList = new ArrayList();
		TreeMap tm   = new TreeMap();
		String strMailUserId = "";
		ResultSet rs     = null;
	    String sSqlStr = "";
		try
		{
			DbConnectionBean dbConBean = new DbConnectionBean();
			//this query used for finding that no one approver approve the requisition and  when originator change that requisition then mail goes to only the first approver not to mata		  
			String  strFlag1 = "no";
			sSqlStr = "SELECT APPROVER_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND APPROVE_STATUS=10 AND APPLICATION_ID=1 AND STATUS_ID=10";
			rs = dbConBean.executeQuery(sSqlStr);         //get the result set
			if(rs.next())
			{
				strFlag1 = "yes";  //It means no one approve this requisition and originator change the requisition then mail goes to                        first approver. 
			}
			rs.close();
			if(strFlag1!=null && strFlag1.equals("no") && !SuserRole.equals("MATA"))
			{
				sSqlStr = "SELECT APPROVER_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND STATUS_ID=10 AND APPLICATION_ID=1 AND ORDER_ID=1";
				rs = dbConBean.executeQuery(sSqlStr);         //get the result set
				if(rs.next())
				{
					strMailUserId    =     rs.getString("APPROVER_ID"); 
					//aList.add(strMailUserId);
					tm.put(strMailUserId,strMailUserId);
				}
				rs.close();
			}
			else
			{
				//query for all approver who approve the requisition( approve_status = 10 and role != mata)
				sSqlStr = "SELECT APPROVER_ID, ROLE FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND ROLE<>'MATA' AND APPROVE_STATUS=10 AND APPLICATION_ID=1 AND STATUS_ID=10";
				//System.out.println("sqlStr====="+sSqlStr);
				rs = dbConBean.executeQuery(sSqlStr);         //get the result set
				while(rs.next())
				{
					strMailUserId    =     rs.getString("APPROVER_ID"); 
					//System.out.println("9Approver Id is============="+strMailUserId);
					//aList.add(strMailUserId);
					tm.put(strMailUserId,strMailUserId);
				}
				rs.close();

				/*if(SuserRole!=null && SuserRole.equals("MATA")) // IF BLOCK FOR THE MATA WHEN MATA CANCEL THE REQUSITION
				{*/
				    //GET THE ORIGINATOR WHO CREATED THIS REQUISITION
					sSqlStr = "SELECT DISTINCT C_USER_ID AS ORIGINATOR_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND  STATUS_ID=10 AND APPLICATION_ID=1";
					rs = dbConBean.executeQuery(sSqlStr);         //get the result set
					while(rs.next())
					{
						strMailUserId  = rs.getString("ORIGINATOR_ID"); 
						System.out.println("8Originator id ============"+strMailUserId);
						//aList.add(strMailUserId);
						tm.put(strMailUserId,strMailUserId);
					}
					rs.close();
				/*}
				else    // ELSE BLOCK FOR THE OTHERS(ROLE NOT BE MATA) WHEN OTHERS CHANGE THE REQUSITION
				{*/
					// Get the present approver that has not approve the requisition
					sSqlStr = "SELECT APPROVER_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND STATUS_ID=10 AND APPLICATION_ID=1 AND ORDER_ID=(SELECT MIN(ORDER_ID) FROM T_APPROVERS  WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"'AND APPROVE_STATUS=0 AND ROLE NOT IN('MATA')  AND STATUS_ID=10 AND APPLICATION_ID=1)";
					System.out.println("sqlStr 2====="+sSqlStr);
					rs = dbConBean.executeQuery(sSqlStr);         //get the result set
					while(rs.next())
					{
						strMailUserId    =     rs.getString("APPROVER_ID"); 
						//System.out.println("7Approver Id is============="+strMailUserId);
						//aList.add(strMailUserId);
						tm.put(strMailUserId,strMailUserId);
					}
					rs.close();
					
					//get the approver whose role is MATA
					sSqlStr = "SELECT DISTINCT APPROVER_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND ROLE='MATA' AND  STATUS_ID=10 AND APPLICATION_ID=1";
					rs = dbConBean.executeQuery(sSqlStr);         //get the result set
					while(rs.next())
					{
						strMailUserId    =     rs.getString("APPROVER_ID"); 
						//System.out.println("6Approver Id is============="+strMailUserId);
						//aList.add(strMailUserId);
						tm.put(strMailUserId,strMailUserId);
					}
					rs.close();
				//}//END OF ELSE
			}//end of  else
			dbConBean.close();
		}
		catch(Exception e)
		{
			System.out.println("Error in getApproverOnTravelDateChange() method of DbUtilityMethods.java====== "+e);
		}
		return tm;
	}

/**************************************************************
     Method             :findUserRole(String strUserId,  String strFindRole) 
     Return Values()	:boolean
     Parameter(s)		:String strUserId,  String strFindRole
     Purpose			:This method is for finding the role of user from M_USERROLE table. Parameter strFindRole is a finding role(eg:                     LA etc) that we are find for this userId, if this userid has this role then this method return true otherwise                     false.
**************************************************************/
public boolean findUserRole(String strUserId,  String strFindRole) 
{
	ResultSet rs				 =  null;
    String sSqlStr				 =  "";
	boolean	flag				 =  false; 	  
	String strRoles				 =  "";
	String []strUserRoles		 =  null;
	try
	{
		DbConnectionBean dbConBean = new DbConnectionBean();
		sSqlStr = "SELECT LTRIM(RTRIM(ISNULL(ROLE_ID,''))) AS ROLE_ID FROM M_USERROLE WHERE USERID="+strUserId+" AND STATUS_ID=10";
		rs      = dbConBean.executeQuery(sSqlStr);
		if(rs.next())
		{
			strRoles		=  rs.getString("ROLE_ID");	   //get role eg: LA;--;		
			if(!strRoles.equals(""))
			{
				strUserRoles	=  strRoles.split(";");
				for(int i=0; i<strUserRoles.length; i++)
				{
					if(strUserRoles[i].equalsIgnoreCase(strFindRole))
					{					
						flag = true;
					}
				}
			}
		}
	}
	catch(Exception e)
	{
		System.out.println("Error in findUserRole() of DbUtilityMethods.java======="+e);
	}
	return flag;
}


/*****************************************************************************************************************
   Method           :validateEmailIDAnd (String strEmail )
   Return Values()	:boolean
   Parameter(s)		:String strEmail
   Purpose			:Validate the EmailId, if email id already exist in active user list then return false otherwise return true.
*****************************************************************************************************************/
// method for validating redundant EMailID	
	public boolean validateEmailID (String strEmail)
	{
		ResultSet rs     = null;
		boolean mailFlag = false;
		String sql       = "";
		
		try
		{
			DbConnectionBean dbConBean = new DbConnectionBean();
			
		   //Check email_id, it should not be same as any previous email_id
		   sql = "Select [EMAIL] from M_USERINFO where APPLICATION_ID = 1 AND STATUS_ID=10";
		   rs = dbConBean.executeQuery(sql);
		   while (rs.next()) 
		   {
			  if (strEmail.equalsIgnoreCase(rs.getString(1)))
			  {
				   return false;
			  }
		   } 
		   rs.close();

		   mailFlag = true;
		}
		catch (Exception e) 
		{
		  System.out.println("Error in validateEmailID() of DbUtilityMethods.java=============== "+e);
		  e.printStackTrace();
		}finally {
			try {				
				conn.close();
			} catch (Exception e) {	}
		}
		return mailFlag;
	}


/*****************************************************************************************************************
   Method           :validateUserName(String strUserName )
   Return Values()	:boolean
   Parameter(s)		:String strUserName
   Purpose			:Validate the USERNAME(LOGIN NAME), if LOGIN ID already exist in active user then return false otherwise return true.
********************************************************************************************************************/
	// method for validating redundant USERNAME(LOGIN NAME)	
	public boolean validateUserName(String strUserName )
	{
		ResultSet rs     = null;
		String sql       = "";
		boolean userNameFlag = false;
		try
		{
		   DbConnectionBean dbConBean = new DbConnectionBean();
		   sql = "Select [USERNAME] from M_USERINFO where APPLICATION_ID = 1 AND STATUS_ID=10";
		   rs = dbConBean.executeQuery(sql);
		   while (rs.next()) 
		   {
			  if (strUserName.equalsIgnoreCase(rs.getString(1)))
			  {
				   return false;
			  }
		   } 
		   rs.close();
		   userNameFlag = true;
		}
		catch (Exception e) 
		{
		  System.out.println("Error in validateUserName() of  DbUtilityMethods.java=============== "+e);
		  e.printStackTrace();
		}
		return userNameFlag;
	}


/*****************************************************************************************************************
   Method           :validateEmpcode(String strEmpCode,String strSiteId)
   Return Values()	:boolean
   Parameter(s)		:String strUserName
   Purpose			:Validate the validateEmpcode(String strEmpCode,String strSiteId ), if Emp Code already exist in active user then return false otherwise return true.
********************************************************************************************************************/
	// method for validating redundant EMPCODE
	public String validateEmpcode(String strEmpCode, String strSiteId)
	{
		ResultSet rs     = null;
		String strEmpFlag = "true";
		DbConnectionBean dbConBean = null;
		String strEmpCode1  = "";
		try
		{
			dbConBean = new DbConnectionBean();
 		    String sql = "Select ISNULL(EMP_CODE,'') AS EMP_CODE from M_USERINFO where SITE_ID="+strSiteId+" AND APPLICATION_ID = 1 AND STATUS_ID=10";
		   rs = dbConBean.executeQuery(sql);
		   while (rs.next()) 
		   {   
			  strEmpCode1 = rs.getString(1).trim();	

			  if(strEmpCode.equals(""))
			  {    
				  strEmpFlag="blank";
				  return strEmpFlag;
			  }
			  else if(strEmpCode.equalsIgnoreCase(strEmpCode1))
			  {
				  strEmpFlag="exist";
				  return strEmpFlag;
			  }

		   } 
		   rs.close();
		   
		}
		catch (Exception e) 
		{
		  System.out.println("Insertion!Error in validateEmpcode of RegisterUser.java=============== "+e);
		  e.printStackTrace();
		}finally {
			try {				
				dbConBean.close();
			} catch (Exception e) {	}
		}
		return strEmpFlag;
	}



/*****************************************************************************************************************
   Method           :getApproverLevelNameFromNo(String strApprovalLevelNo )
   Return Values()	:String
   Parameter(s)		:String strApprovalLevelNo
   Purpose			:Return the label according the no of strApprovalLevelNo(eg. this will be 0,1,2,or 3) .
********************************************************************************************************************/
public String getApproverLevelNameFromNo(String strApprovalLevel )
{
	String strLabelName = "";
	try
	{
	   if(strApprovalLevel.equals("1"))
		{
			strLabelName = "Approver Level 1";
		}
		else if(strApprovalLevel.equals("2"))
		{
			strLabelName = "Approver Level 2";
		}
		else if(strApprovalLevel.equals("3"))
		{
			strLabelName = "Global Approver";
		}
		else 
		{
			strLabelName = "None";
		}
	}
	catch (Exception e) 
	{
	  System.out.println("Error in getApproverLevelNameFromNo() of  DbUtilityMethods.java=============== "+e);
	  e.printStackTrace();
	}
	return strLabelName;
}

/*****************************************************************************************************************
   Method           :findReportAccessInMainMenu(String SuserRole,String SuserRoleOther,  String strSiteIdSS, String Suser_id)
   Return Values()	:String
   Parameter(s)		:
   Purpose			:Find the user accessibility for report accessing
********************************************************************************************************************/
public String findReportAccessInMainMenu(String SuserRole,String SuserRoleOther,  String strSiteIdSS, String Suser_id)
{
	String strFlag   = "no";
	ResultSet rs     = null;
	String strSql    = "";
	try
	{
		DbConnectionBean dbConBean = null;
				
			dbConBean = new DbConnectionBean();
			strSql = "SELECT APPROVER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+strSiteIdSS+" AND APPROVER_ID="+Suser_id+" AND STATUS_ID=10 AND APPLICATION_ID=1 ";
			rs = dbConBean.executeQuery(strSql);
			if(rs.next())
			{				
				strFlag = "oneSite";			
			}
			rs.close();

			/*strSql = "SELECT FIRSTNAME,USERID FROM M_USERINFO WHERE USERID="+Suser_id+" AND (APPROVER_LEVEL='1' OR APPROVER_LEVEL='2') AND STATUS_ID=10 ";
			rs = dbConBean.executeQuery(strSql);
			if(rs.next())
			{				
				strFlag = "oneSite";			
			}
			rs.close();*/
			//for Unit Head
			//QUERY CHANGED BY MANOJ CHAND ON 11 NOV 2013
			//strSql = "select userid from user_multiple_access where userid="+Suser_id+"  and status_id=10";
			strSql = "select userid from user_multiple_access where userid="+Suser_id+"  and status_id=10 and (user_multiple_access.ROLE_ID='LA' or user_multiple_access.UNIT_HEAD=1)";
			rs = dbConBean.executeQuery(strSql);
			if(rs.next())
			{				
				strFlag = "oneSite";			
			}
			rs.close();


			if(SuserRoleOther != null && SuserRoleOther.trim().equals("LA")  )
			{
				strFlag = "oneSite";			
			}

			strSql = "SELECT APPROVER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+strSiteIdSS+" AND APPROVER_ID="+Suser_id+" AND STATUS_ID=10 AND APPLICATION_ID=1 ";
			rs = dbConBean.executeQuery(strSql);
			if(rs.next())
			{				
				strFlag = "oneSite";			
			}
			rs.close();

			//Added by sachin on 11 May 2007 to show report link to HR role.	
			if(SuserRole != null && (SuserRole.trim().equals("HR")))
			{
				strFlag = "oneSite";				
			}
			
			//Added by Gurmeet Singh on 29 Jan 2014 to show report link to OR role.	
			if(SuserRole != null && (SuserRole.trim().equals("OR")))
			{
				strFlag = "oneSite";				
			}
			
			//Added by Gurmeet Singh on 06 May 2014 to show report link to AC role.	
			if(SuserRole != null && (SuserRole.trim().equals("AC")))
			{
				strFlag = "oneSite";				
			}

			
			strSql = "SELECT FIRSTNAME,USERID FROM M_USERINFO WHERE USERID="+Suser_id+" AND APPROVER_LEVEL='3' AND STATUS_ID=10 ";
			rs = dbConBean.executeQuery(strSql);
			if(rs.next())
			{				
				strFlag = "allSite";			
			}
			rs.close();
			dbConBean.close();			
             
			 // Added a new role for Corporate persone for giving new report Access on 05-Jun-08 by shiv sharma   
			if(SuserRole != null && (SuserRole.trim().equals("AD") || SuserRole.trim().equals("CHAIRMAN") || SuserRole.trim().equals("SM") || SuserRole.trim().equals("CORP") || SuserRole.trim().equals("MATA")))
			{
				strFlag = "allSite";				
			}	

	}
	catch(Exception e)
	{
		System.out.println("Error in findReportAccessInMainMenu(...) of  DbUtilityMethods.java=============== "+e);
	}
	return strFlag;
}



/*****************************************************************************************************************
   Method           :findReportSiteListForUser(String SuserRole,String SuserRoleOther,  String strSiteIdSS, String Suser_id)
   Return Values()	:ArrayList
   Parameter(s)		:
   Purpose			:Find the user accessibility for report accessing
********************************************************************************************************************/
public ArrayList findReportSiteListForUser(String SuserRole,String SuserRoleOther,  String strSiteIdSS, String Suser_id,String strLanguage)
{
	ArrayList aList = null;
	String strGolbalApproverFlag = "0";
	String strFlag   = "no";
	ResultSet rs, rs2   = null;
	String strSql    = "";
	String strTempSiteId = "";
	String strTempSiteName = "";

	try
	{
		aList = new ArrayList();
		DbConnectionBean dbConBean = null;
		dbConBean = new DbConnectionBean();
		//find user is global approver or not
		strSql = "SELECT FIRSTNAME,USERID FROM M_USERINFO WHERE USERID="+Suser_id+" AND APPROVER_LEVEL='3' AND STATUS_ID=10 ";
	//System.out.println("strSQL--1-->"+strSql);
		rs = dbConBean.executeQuery(strSql);
		if(rs.next())
		{				
			strGolbalApproverFlag = "1";			
		}
		rs.close();

		if(SuserRole != null && (SuserRole.trim().equals("AD") || SuserRole.trim().equals("CHAIRMAN") || strGolbalApproverFlag.equals("1")))
		{

			aList.add("0");
			aList.add(LableMst.getLabel("label.search.all", strLanguage));
			strSql = "select distinct site_id,site_name from m_site where status_id=10 and application_id=1 ORDER BY 2";
			//System.out.println("strSQL---2->"+strSql);
 		    rs = dbConBean.executeQuery(strSql); 
			while(rs.next())
			{
				strTempSiteId = rs.getString("site_id").trim();
				strTempSiteName = rs.getString("site_name").trim();
				aList.add(strTempSiteId);
				aList.add(strTempSiteName);
			}
			rs.close();
		}
		else if(SuserRoleOther != null && SuserRoleOther.trim().equals("LA")  )
		{
			strSql = "select distinct site_id, dbo.sitename(site_id) as site_name from m_userrole where userid="+Suser_id+" and status_id=10 ORDER BY 2	";
	//System.out.println("strSQL---3->"+strSql);
 		    rs = dbConBean.executeQuery(strSql); 
			while(rs.next())
			{
				strTempSiteId = rs.getString("site_id").trim();
				strTempSiteName = rs.getString("site_name").trim();
				aList.add(strTempSiteId);
				aList.add(strTempSiteName);
			}
			rs.close();			
		}
		
//Added by sachin on 11 May to show site  to HR Role start
		if(SuserRole.equals("HR"))
		{
			strSql = "select distinct site_id, dbo.sitename(site_id) as site_name from m_userinfo where userid="+Suser_id+" and  status_id=10 and role_id='HR' ORDER BY 2";
	//System.out.println("strSQL---4->"+strSql);
 		    rs = dbConBean.executeQuery(strSql); 
			if(rs.next())
			{
				strTempSiteId = rs.getString("site_id").trim();
				strTempSiteName = rs.getString("site_name").trim();
				if(aList.contains(strTempSiteId))
				{
					//nothing add
				}
				else
				{
					aList.add(strTempSiteId);
					aList.add(strTempSiteName);
				}
			}
			rs.close();		
		}
//Added by sachin on 11 May to show site to HR Role end


   //Added new code for Adding new role for  showing reports for New role SM  open on 30-Apr-08 by shiv Sharma 
		if(SuserRole.equals("SM"))
		{
			//System.out.println("working   working working working working working working working ");
			strSql = "select distinct site_id, dbo.sitename(site_id) as site_name from m_userinfo where userid="+Suser_id+" and  status_id=10 and role_id='SM' ORDER BY 2";
	//System.out.println("strSQL---5->"+strSql);
 		    rs = dbConBean.executeQuery(strSql); 
			if(rs.next())
			{
				strTempSiteId = rs.getString("site_id").trim();
				strTempSiteName = rs.getString("site_name").trim();
				if(aList.contains(strTempSiteId))
				{
					//nothing add
				}
				else
				{
					aList.add(strTempSiteId);
					aList.add(strTempSiteName);
				}
			}
			rs.close();		
		}
//Added new code for Adding new role for  showing reports for New role SM  open on 30-Apr-08 by shiv Sharma  ----------------close-------------


 // Added a new role for Corporate persone for giving new report Access on 05-Jun-08 by shiv sharma   
 
		if(SuserRole.equals("CORP"))
		{
			//System.out.println("working   working working working working working working working ");
			aList.add("0");
			aList.add("All");
			strSql = "select distinct site_id,site_name from m_site where status_id=10 and application_id=1 ORDER BY 2";
	//System.out.println("strSQL---6->"+strSql);
 		    rs = dbConBean.executeQuery(strSql); 
			while(rs.next())
			{
				strTempSiteId = rs.getString("site_id").trim();
				strTempSiteName = rs.getString("site_name").trim();
				aList.add(strTempSiteId);
				aList.add(strTempSiteName);
			}
			rs.close();	
		}
		
		//Added by Gurmeet Singh on 29 Jan 2014 to show report link to OR role.
		if(SuserRole.equals("OR"))
		{
			strSql = "select distinct site_id, dbo.sitename(site_id) as site_name from m_userinfo where userid="+Suser_id+" and  status_id=10 and role_id='OR' ORDER BY 2";
	//System.out.println("strSQL---4->"+strSql);
 		    rs = dbConBean.executeQuery(strSql); 
			if(rs.next())
			{
				strTempSiteId = rs.getString("site_id").trim();
				strTempSiteName = rs.getString("site_name").trim();
				if(aList.contains(strTempSiteId))
				{
					//nothing add
				}
				else
				{
					aList.add(strTempSiteId);
					aList.add(strTempSiteName);
				}
			}
			rs.close();		
		}
		
		//Added by Gurmeet Singh on 06 MAy 2014 to show report link to AC role.
		if(SuserRole.equals("AC"))
		{
			strSql = "select distinct site_id, dbo.sitename(site_id) as site_name from m_userinfo where userid="+Suser_id+" and  status_id=10 and role_id='AC' ORDER BY 2";
	//System.out.println("strSQL---4->"+strSql);
 		    rs = dbConBean.executeQuery(strSql); 
			if(rs.next())
			{
				strTempSiteId = rs.getString("site_id").trim();
				strTempSiteName = rs.getString("site_name").trim();
				if(aList.contains(strTempSiteId))
				{
					//nothing add
				}
				else
				{
					aList.add(strTempSiteId);
					aList.add(strTempSiteName);
				}
			}
			rs.close();		
		}
		
		//Added by Gurmeet Singh on 06 MAy 2014 to show report link to AC role.
		if(SuserRole.equals("MATA")) {
			
			//SITE ID FOR MATA GMBH TRAVEL MANAGER
			strSql = " SELECT 1 FROM M_USERINFO WHERE USERID = "+Suser_id+" AND (ROLE_ID IN ('MATA')) AND STATUS_ID=10 AND " +
					" SITE_ID =(SELECT FUNCTION_VALUE FROM functional_ctl WHERE FUNCTION_KEY='@MataGmbHSite')";

			rs2 = dbConBean.executeQuery(strSql);
			if(rs2.next()) 
			{				
				strSql = " SELECT distinct site_id, site_name FROM M_SITE WHERE STATUS_ID=10 AND APPLICATION_ID=1 AND TRAVEL_AGENCY_ID=2 ORDER BY 2";				
			}
			else
			{
				strSql = " SELECT distinct site_id, site_name FROM M_SITE WHERE STATUS_ID=10 AND APPLICATION_ID=1 AND TRAVEL_AGENCY_ID=1 ORDER BY 2";	
			}				
			rs2.close();
			
 		    rs = dbConBean.executeQuery(strSql); 
 		    while(rs.next()) {
				strTempSiteId = rs.getString("site_id").trim();
				strTempSiteName = rs.getString("site_name").trim();
				aList.add(strTempSiteId);
				aList.add(strTempSiteName);
			}			
			rs.close();		
		}
				
//Added new code for Adding new role for  showing reports for New role Corporate Access  open on 04-Jun-08 by shiv Sharma  close


		
		//checking for unit head site  if user have also a role of unit head 
		strSql = "select distinct site_id, dbo.sitename(site_id) as site_name from user_multiple_access where userid="+Suser_id+" and status_id=10 and Unit_head=1  ORDER BY 2";
//System.out.println("strSQL---7->"+strSql);
		rs = dbConBean.executeQuery(strSql); 
		while(rs.next())
		{
			strTempSiteId = rs.getString("site_id").trim();
			strTempSiteName = rs.getString("site_name").trim();
			if(aList.contains(strTempSiteId))
			{
				//nothing add
			}
			else
			{
				aList.add(strTempSiteId);
				aList.add(strTempSiteName);
			}
		}
		rs.close();

		//When user is a default approver for some site (Add on 15 may 2007)
		strSql = "SELECT distinct site_id, dbo.sitename(site_id) as site_name FROM M_DEFAULT_APPROVERS WHERE  APPROVER_ID="+Suser_id+" AND STATUS_ID=10 AND APPLICATION_ID=1 order by site_name ";
//System.out.println("strSQL---8->"+strSql);
		rs = dbConBean.executeQuery(strSql); 
		while(rs.next())
		{
			strTempSiteId = rs.getString("site_id").trim();
			strTempSiteName = rs.getString("site_name").trim();
			if(aList.contains(strTempSiteId))
			{
				//nothing add
			}
			else
			{
				aList.add(strTempSiteId);
				aList.add(strTempSiteName);
			}
		}
		rs.close();
		
		// show sites for which AC role has been given to user
		strSql = "select distinct site_id, dbo.sitename(site_id) as site_name from M_USERROLE where userid="+Suser_id+" and ROLE_ID='AC'";
	    rs = dbConBean.executeQuery(strSql); 
		while(rs.next()) {
			strTempSiteId = rs.getString("site_id").trim();
			strTempSiteName = rs.getString("site_name").trim();
			
			if(!aList.contains(strTempSiteId)) {
				aList.add(strTempSiteId);
				aList.add(strTempSiteName);
			}
		}
		rs.close();
	
		//add user own site from m_userinfo
		/*strSql = "select site_id, dbo.sitename(site_id) as site_name from M_USERINFO where userid="+Suser_id+" and status_id=10 ORDER BY 2";
		rs = dbConBean.executeQuery(strSql); 
		while(rs.next())
		{
			strTempSiteId = rs.getString("site_id");
			strTempSiteName = rs.getString("site_name");
			if(aList.contains(strTempSiteId))
			{
				//nothing add
			}
			else
			{
				aList.add(strTempSiteId);
				aList.add(strTempSiteName);
			}
		}
		rs.close();*/
	}
	catch(Exception e)
	{
		System.out.println("Error in findReportSiteListForUser(...) of  DbUtilityMethods.java=============== "+e);
	}
	return aList;
}



/*****************************************************************************************************************
Method           :findSearchSiteListForUser(String SuserRole,String SuserRoleOther,  String strSiteIdSS, String Suser_id, String strLanguage)
Return Values()	:ArrayList
Parameter(s)		:
Purpose			:Find the user accessibility for Search accessing
********************************************************************************************************************/
public ArrayList findSearchSiteListForUser(String SuserRole,String SuserRoleOther,  String strSiteIdSS, String Suser_id, String strLanguage)
{
	ArrayList aList = null;
	String strGolbalApproverFlag = "0";
	String strFlag   = "no";
	ResultSet rs     = null;
	String strSql    = "";
	String strTempSiteId = "";
	String strTempSiteName = "";

	try
	{
		aList = new ArrayList();
		DbConnectionBean dbConBean = null;
		dbConBean = new DbConnectionBean();
		//find user is global approver or not
		strSql = "SELECT FIRSTNAME,USERID FROM M_USERINFO WHERE USERID="+Suser_id+" AND APPROVER_LEVEL='3' AND STATUS_ID=10 ";
//System.out.println("strSQL--1-->"+strSql);
//System.out.println("SuserRole---->"+SuserRole);
		rs = dbConBean.executeQuery(strSql);
		if(rs.next())
		{				
			strGolbalApproverFlag = "1";			
		}
		rs.close();

		aList.add("0");
		aList.add(LableMst.getLabel("label.search.all",strLanguage));
		
		if(SuserRole != null && (SuserRole.trim().equals("AD") || SuserRole.trim().equals("CHAIRMAN") || strGolbalApproverFlag.equals("1")))
		{

			//aList.add("0");
			//aList.add("All");
			strSql = "select distinct site_id,site_name from m_site where status_id=10 and application_id=1 ORDER BY 2";
//System.out.println("strSQL---2->"+strSql);
		    rs = dbConBean.executeQuery(strSql); 
			while(rs.next())
			{
				strTempSiteId = rs.getString("site_id");
				strTempSiteName = rs.getString("site_name");
				aList.add(strTempSiteId);
				aList.add(strTempSiteName);
			}
			rs.close();
		}
		else if(SuserRoleOther != null && SuserRoleOther.trim().equals("LA")  )
		{
			//aList.add("0");
			//aList.add("All");
			strSql = "select distinct site_id, dbo.sitename(site_id) as site_name from m_userrole where userid="+Suser_id+" and status_id=10 ORDER BY 2	";
//System.out.println("strSQL---3->"+strSql);
		    rs = dbConBean.executeQuery(strSql); 
			while(rs.next())
			{
				strTempSiteId = rs.getString("site_id");
				strTempSiteName = rs.getString("site_name");
				aList.add(strTempSiteId);
				aList.add(strTempSiteName);
			}
			rs.close();			
		}
		
//Added by sachin on 11 May to show site  to HR Role start
		if(SuserRole.equals("HR"))
		{
			strSql = "select distinct site_id, dbo.sitename(site_id) as site_name from m_userinfo where userid="+Suser_id+" and  status_id=10 and role_id='HR' ORDER BY 2";
//System.out.println("strSQL---4->"+strSql);
		    rs = dbConBean.executeQuery(strSql); 
			if(rs.next())
			{
				strTempSiteId = rs.getString("site_id");
				strTempSiteName = rs.getString("site_name");
				if(aList.contains(strTempSiteId))
				{
					//nothing add
				}
				else
				{
					aList.add(strTempSiteId);
					aList.add(strTempSiteName);
				}
			}
			rs.close();		
		}
//Added by sachin on 11 May to show site to HR Role end


//Added new code for Adding new role for  showing reports for New role SM  open on 30-Apr-08 by shiv Sharma 
		if(SuserRole.equals("SM"))
		{
			//System.out.println("working   working working working working working working working ");
			strSql = "select distinct site_id, dbo.sitename(site_id) as site_name from m_userinfo where userid="+Suser_id+" and  status_id=10 and role_id='SM' ORDER BY 2";
//System.out.println("strSQL---5->"+strSql);
		    rs = dbConBean.executeQuery(strSql); 
			if(rs.next())
			{
				strTempSiteId = rs.getString("site_id");
				strTempSiteName = rs.getString("site_name");
				if(aList.contains(strTempSiteId))
				{
					//nothing add
				}
				else
				{
					aList.add(strTempSiteId);
					aList.add(strTempSiteName);
				}
			}
			rs.close();		
		}
//Added new code for Adding new role for  showing reports for New role SM  open on 30-Apr-08 by shiv Sharma  ----------------close-------------


// Added a new role for Corporate persone for giving new report Access on 05-Jun-08 by shiv sharma   

		if(SuserRole.equals("CORP"))
		{
			//System.out.println("working   working working working working working working working ");
			//aList.add("0");
			//aList.add("All");
			strSql = "select distinct site_id,site_name from m_site where status_id=10 and application_id=1 ORDER BY 2";
//System.out.println("strSQL---6->"+strSql);
		    rs = dbConBean.executeQuery(strSql); 
			while(rs.next())
			{
				strTempSiteId = rs.getString("site_id");
				strTempSiteName = rs.getString("site_name");
				aList.add(strTempSiteId);
				aList.add(strTempSiteName);
			}
			rs.close();	
		}
//Added new code for Adding new role for  showing reports for New role Corporate Access  open on 04-Jun-08 by shiv Sharma  close


		
		//checking for unit head site  if user have also a role of unit head 
		strSql = "select distinct site_id, dbo.sitename(site_id) as site_name from user_multiple_access where userid="+Suser_id+" and status_id=10 and Unit_head=1  ORDER BY 2";
//System.out.println("strSQL---7->"+strSql);
		rs = dbConBean.executeQuery(strSql); 
		while(rs.next())
		{
			strTempSiteId = rs.getString("site_id");
			strTempSiteName = rs.getString("site_name");
			if(aList.contains(strTempSiteId))
			{
				//nothing add
			}
			else
			{
				aList.add(strTempSiteId);
				aList.add(strTempSiteName);
			}
		}
		rs.close();

		//When user is a default approver for some site (Add on 15 may 2007)
		strSql = "SELECT distinct site_id, dbo.sitename(site_id) as site_name FROM M_DEFAULT_APPROVERS WHERE  APPROVER_ID="+Suser_id+" AND STATUS_ID=10 AND APPLICATION_ID=1 order by 2";
//System.out.println("strSQL---8->"+strSql);
		rs = dbConBean.executeQuery(strSql); 
		while(rs.next())
		{
			strTempSiteId = rs.getString("site_id");
			strTempSiteName = rs.getString("site_name");
			if(aList.contains(strTempSiteId))
			{
				//nothing add
			}
			else
			{
				aList.add(strTempSiteId);
				aList.add(strTempSiteName);
			}
		}
		rs.close();

		//add user own site from m_userinfo
		strSql = "select site_id, dbo.sitename(site_id) as site_name from M_USERINFO where userid="+Suser_id+" and status_id=10 ORDER BY 2";
//System.out.println("strsql-=-=-=-=-=-===>"+strSql);
		rs = dbConBean.executeQuery(strSql); 
		while(rs.next())
		{	
			strTempSiteId = rs.getString("site_id");
			strTempSiteName = rs.getString("site_name");
			if(aList.contains(strTempSiteId))
			{
				//nothing add
			}
			else
			{
				aList.add(strTempSiteId);
				aList.add(strTempSiteName);
			}
		}
		rs.close();
	}
	catch(Exception e)
	{
		System.out.println("Error in findReportSiteListForUser(...) of  DbUtilityMethods.java=============== "+e);
	}
	return aList;
}

/*****************************************************************************************************************
   Method           :appendToLog(String strApprovalLevelNo )
   Return Values()	:String 
   Parameter(s)		:String strLogInfo
   Purpose			:Write all error of application in Security/logInfo.log file
********************************************************************************************************************/
 public void appendToLog (String strLogInfo) 
 {
	 BufferedWriter bw = null;
     try 
	 {
         bw = new BufferedWriter(new FileWriter(strReplaced+"/"+"logInfo.txt", true));
		 //System.out.println("bw>>>>>"+bw);

		 bw.write(strLogInfo);
		 bw.newLine();
		 bw.newLine();
		 bw.flush();
     }
	 catch (IOException ioe)
	 {
		 ioe.printStackTrace();
     } 
	 finally 
	 {                       // always close the file
		 if (bw != null) 
		 try 
		 {
			  bw.close();
		 }
		 catch (IOException ioe2) 
		 {
			System.out.println("Error in (String strLogInfo) Method ===="+ioe2); 
		 }
     } // end try/catch/finally

 } // end test()


/*****************************************************************************************************************
   Method           :checkforString(String str)   
   Return Values()	:String 
   Parameter(s)		:String strLogInfo
   Purpose			:This function check whether string  passed is string llitreals or int litrals by shiv sharma  
********************************************************************************************************************/
 public int checkforString(String str)  
			{	
			int ii =0;  int flag =0;   
				try
					{
						ii=Integer.parseInt(str);
						return 0; 	
					}
				catch (Exception e)
					{ 
						flag=1;	
						return flag;
					}
			}


/**************************************************************************************************
   Method           :getMaiRefNo()   
   Return Values()	:String 
   Parameter(s)		:
   Purpose			:This function return Mail Reference No. form Req_MailBox table 
 *****************************************************************************************************/
 public String getMailRefNo(){
	DbConnectionBean dbConBean		=	null;
	ResultSet rs     				=	null;
	String strMailRefNo				= 	"";
	String strSql					=	"";
	try{						
		dbConBean 			= new DbConnectionBean();
		strSql		= "SELECT ISNULL(MAX(MAIL_ID),'999')+1 FROM REQ_MAILBOX";			
		rs					= dbConBean.executeQuery(strSql);
		if(rs.next())
		{
			strMailRefNo		=	rs.getString(1);//Mail Reference Number
		}
		rs.close();
		dbConBean.close();			
	}catch(Exception e){
		System.out.println("Error in getMailRefNo() of DbUtilityMethods.java");
	}
	return strMailRefNo;
}
 /**************************************************************************************************
 Method           :saveMailInDB()   
 Return Values()	:String 
 Parameter(s)		:
 Purpose			:This function save mail in Req_MailBox table 
*****************************************************************************************************/
 public void saveMailInDB(MailBean mailBean){
	DbConnectionBean dbConBean			=	null;
	Connection con						=	null;
	ResultSet rs     					=	null;
	CallableStatement cstmt_mail		=	null;			// Object for Callable Statement
	try{
		dbConBean								=	new DbConnectionBean();
		con 									=	dbConBean.getConnection();
		String strRequistionId					=	mailBean.getTravelId();
		String strRequistionNumber				=	mailBean.getTravelNumber();
		String strRequistionCreatorMail			=	mailBean.getReceipentTo();
		String strstrRequistionApproverEmail	=	mailBean.getReceipentFrom();
		String strMailID_OrignalApprover		=	mailBean.getReceipentCC();
		String Suser_id							=	mailBean.getMailCreaterUserId();   
		String strMailSubject					=	mailBean.getMailSubject();
		String strMailMsg						=	mailBean.getMailMessage();
		String strSourcePage					=	mailBean.getSourcePage();
		
		//	Procedure for inserting Mail Data
		cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
		cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
		cstmt_mail.setString(2, strRequistionId);
		cstmt_mail.setString(3, strRequistionNumber);
		cstmt_mail.setString(4, strRequistionCreatorMail);//To
		cstmt_mail.setString(5, strstrRequistionApproverEmail);//From
		cstmt_mail.setString(6, strMailID_OrignalApprover);//CC  Mail Address is remove By  shar sharma on 03-Apr-08
		cstmt_mail.setString(7, strMailSubject);
		cstmt_mail.setString(8, strMailMsg.toString());
		cstmt_mail.setInt(9, 0);
		cstmt_mail.setString(10, "NEW");
		cstmt_mail.setString(11, Suser_id);
		cstmt_mail.setString(12, "New");
		cstmt_mail.setString(13, "User Submitting the Req");  //"SourcePage" column enly
		cstmt_mail.execute();
		cstmt_mail.close();			
	}catch(Exception e){
		System.out.println("Error in saveMailInDB() of MailFormat.java=="+e);
	}		
}
 /**************************************************************************************************
 Method           	:sSSOUrlByMailid(String strMailId)   
 Return Values()	:String 
 Parameter(s)		:String strMailId
 Purpose			:To return SSOMailUrl of the user to whom the mail has to be sent
 Author				:Vaibhav Paliwal
*****************************************************************************************************/
public String sSSOUrlByMailid(String strEmailId)
{
	String strSSOUrl="";
	DbConnectionBean dbConBean		=	null;
	ResultSet rs     				=	null;
	try{						
		dbConBean 			= new DbConnectionBean();
		String strSql		= "Select SSO_MAIL_URL from M_SITE s, M_USERINFO u  where ltrim(rtrim(email)) = '"+strEmailId.trim()+"' and loginstatus in ('active' , 'enable') and s.site_id = u.site_id";			
		rs					= dbConBean.executeQuery(strSql);
		if(rs.next())
		{
			strSSOUrl		=	rs.getString(1);
		}
		rs.close();
		dbConBean.close();			
	}catch(Exception e){
		System.out.println("Error in sSSOUrlByMailid() of DbUtilityMethods.java");
	}
	if(strSSOUrl.equalsIgnoreCase(""))
	{
		strSSOUrl="https://stars.mindeservices.com";
		return strSSOUrl;
	}
	else
		return strSSOUrl;
		
}
 
 /**************************************************************************************************
 Method           	:checkMobileNoAvailability(String strUserId, String strMobileNo)   
 Return Values()	:String 
 Parameter(s)		:
 Purpose			:This function save mail in Req_MailBox table 
*****************************************************************************************************/
 public String isMobileNoAvailable(String strUserId, String strMobileNo){
		DbConnectionBean dbConBean			=	null;		
		ResultSet rs     					=	null;
		String strSql						=	"Select LTRIM(RTRIM(ISNULL(CONTACT_NUMBER,''))) as CONTACT_NUMBER from M_USERINFO where Status_id=10 and userid<>"+strUserId+" And CONTACT_NUMBER='"+strMobileNo+"'";
		//System.out.println(strSql);
		String strExistenceFlag				=	"Yes";
		try{
			dbConBean						=	new DbConnectionBean();
			rs 								=	dbConBean.executeQuery(strSql);
			if(rs.next()){
				strExistenceFlag	=	"No";
			}			
			rs.close();
			dbConBean.close();
		}catch(Exception e){
			System.out.println("Error in isMobileNoAvailable() of MailFormat.java=="+e);
			strExistenceFlag	=	"Error";
		}		
		return strExistenceFlag;
	}
	public static void main(String arg[])
    {
       try
       { 
          DbUtilityMethods  mm = new DbUtilityMethods();
//		  ArrayList id = mm.findApproversNew(10,1,"D");
//		  ArrayList id = mm.findApprovers(10,"I");
          //TreeMap tm = mm.getApproverOnTravelDateChange("19","I","or");

		  //System.out.println(mm.findUserRole("1134","LA"));
		  //System.out.println(mm.validateUserName("sachin.gupta"));
//		  System.out.println("generated id is =="+tm);
		  //System.out.println(mm.getMailRefNo());
          System.out.println(mm.isMobileNoAvailable("3256", "9818099395"));
		  	
		}
        catch(Exception e)
        {
           System.out.println("sssss");   
		} 
    } 
	
	//Added By GURMEET SINGH on 17-Feb-14 for get unit access list of user
	public ArrayList findReportSiteAccessListForUser(String SuserRole,String SuserRoleOther,  String strSiteIdSS, String Suser_id,String strLanguage)
	{
		ArrayList aList = null;
		String strGolbalApproverFlag = "0";
		String strFlag   = "no";
		ResultSet rs     = null;
		String strSql    = "";
		String strTempSiteId = "";
		String strTempSiteName = "";

		try
		{
			aList = new ArrayList();
			DbConnectionBean dbConBean = null;
			dbConBean = new DbConnectionBean();
			//find user is global approver or not
			strSql = "SELECT FIRSTNAME,USERID FROM M_USERINFO WHERE USERID="+Suser_id+" AND APPROVER_LEVEL='3' AND STATUS_ID=10 ";
		//System.out.println("strSQL--1-->"+strSql);
			rs = dbConBean.executeQuery(strSql);
			if(rs.next())
			{				
				strGolbalApproverFlag = "1";			
			}
			rs.close();


			
			if(SuserRole != null && (SuserRole.trim().equals("AD") || SuserRole.trim().equals("CHAIRMAN") || strGolbalApproverFlag.equals("1")))
			{

				aList.add("0");
				strSql = "select distinct site_id from m_site where status_id=10 and application_id=1 ORDER BY 1";
				//System.out.println("strSQL---2->"+strSql);
	 		    rs = dbConBean.executeQuery(strSql); 
				while(rs.next())
				{
					strTempSiteId = rs.getString("site_id");
					aList.add(strTempSiteId);
				}
				rs.close();
			}
			else if(SuserRoleOther != null && SuserRoleOther.trim().equals("LA")  )
			{
				strSql = "select distinct site_id from m_userrole where userid="+Suser_id+" and status_id=10 ORDER BY 1	";
		//System.out.println("strSQL---3->"+strSql);
	 		    rs = dbConBean.executeQuery(strSql); 
				while(rs.next())
				{
					strTempSiteId = rs.getString("site_id");
					aList.add(strTempSiteId);
				}
				rs.close();			
			}
			
	//Added by sachin on 11 May to show site  to HR Role start
			if(SuserRole.equals("HR"))
			{
				strSql = "select distinct site_id from m_userinfo where userid="+Suser_id+" and  status_id=10 and role_id='HR' ORDER BY 1";
		//System.out.println("strSQL---4->"+strSql);
	 		    rs = dbConBean.executeQuery(strSql); 
				if(rs.next())
				{
					strTempSiteId = rs.getString("site_id");
					if(aList.contains(strTempSiteId))
					{
						//nothing add
					}
					else
					{
						aList.add(strTempSiteId);						
					}
				}
				rs.close();		
			}
	//Added by sachin on 11 May to show site to HR Role end


	   //Added new code for Adding new role for  showing reports for New role SM  open on 30-Apr-08 by shiv Sharma 
			if(SuserRole.equals("SM"))
			{
				//System.out.println("working   working working working working working working working ");
				strSql = "select distinct site_id from m_userinfo where userid="+Suser_id+" and  status_id=10 and role_id='SM' ORDER BY 1";
		//System.out.println("strSQL---5->"+strSql);
	 		    rs = dbConBean.executeQuery(strSql); 
				if(rs.next())
				{
					strTempSiteId = rs.getString("site_id");
					if(aList.contains(strTempSiteId))
					{
						//nothing add
					}
					else
					{
						aList.add(strTempSiteId);					
					}
				}
				rs.close();		
			}
	//Added new code for Adding new role for  showing reports for New role SM  open on 30-Apr-08 by shiv Sharma  ----------------close-------------


	 // Added a new role for Corporate persone for giving new report Access on 05-Jun-08 by shiv sharma   
	 
			if(SuserRole.equals("CORP"))
			{
				//System.out.println("working   working working working working working working working ");
				aList.add("0");
				aList.add("All");
				strSql = "select distinct site_id from m_site where status_id=10 and application_id=1 ORDER BY 1";
		//System.out.println("strSQL---6->"+strSql);
	 		    rs = dbConBean.executeQuery(strSql); 
				while(rs.next())
				{
					strTempSiteId = rs.getString("site_id");
					aList.add(strTempSiteId);					
				}
				rs.close();	
			}
			
			//Added by Gurmeet Singh on 29 Jan 2014 to show report link to OR role.
			if(SuserRole.equals("OR"))
			{
				strSql = "select distinct site_id from m_userinfo where userid="+Suser_id+" and  status_id=10 and role_id='OR' ORDER BY 1";
		//System.out.println("strSQL---4->"+strSql);
	 		    rs = dbConBean.executeQuery(strSql); 
				if(rs.next())
				{
					strTempSiteId = rs.getString("site_id");
					if(aList.contains(strTempSiteId))
					{
						//nothing add
					}
					else
					{
						aList.add(strTempSiteId);						
					}
				}
				rs.close();		
			}
	//Added new code for Adding new role for  showing reports for New role Corporate Access  open on 04-Jun-08 by shiv Sharma  close


			
			//checking for unit head site  if user have also a role of unit head 
			strSql = "select distinct site_id from user_multiple_access where userid="+Suser_id+" and status_id=10 and Unit_head=1  ORDER BY 1";
	//System.out.println("strSQL---7->"+strSql);
			rs = dbConBean.executeQuery(strSql); 
			while(rs.next())
			{
				strTempSiteId = rs.getString("site_id");				
				if(aList.contains(strTempSiteId))
				{
					//nothing add
				}
				else
				{
					aList.add(strTempSiteId);
				}
			}
			rs.close();

			//When user is a default approver for some site (Add on 15 may 2007)
			strSql = "SELECT distinct site_id FROM M_DEFAULT_APPROVERS WHERE  APPROVER_ID="+Suser_id+" AND STATUS_ID=10 AND APPLICATION_ID=1 order by 1 ";
	//System.out.println("strSQL---8->"+strSql);
			rs = dbConBean.executeQuery(strSql); 
			while(rs.next())
			{
				strTempSiteId = rs.getString("site_id");
				if(aList.contains(strTempSiteId))
				{
					//nothing add
				}
				else
				{
					aList.add(strTempSiteId);					
				}
			}
			rs.close();

			//add user own site from m_userinfo
			/*strSql = "select site_id, dbo.sitename(site_id) as site_name from M_USERINFO where userid="+Suser_id+" and status_id=10 ORDER BY 2";
			rs = dbConBean.executeQuery(strSql); 
			while(rs.next())
			{
				strTempSiteId = rs.getString("site_id");
				strTempSiteName = rs.getString("site_name");
				if(aList.contains(strTempSiteId))
				{
					//nothing add
				}
				else
				{
					aList.add(strTempSiteId);
					aList.add(strTempSiteName);
				}
			}
			rs.close();*/
		}
		catch(Exception e)
		{
			System.out.println("Error in findReportSiteAccessListForUser(...) of  DbUtilityMethods.java=============== "+e);
		}
		return aList;
	}
	
	
		//Added By GURMEET SINGH on 17-Feb-14 to get Approval Level One List for User
		public ArrayList findApprovalLevelOneListForUser(String strSiteId, String strManagerId)
		{
			ArrayList aList = null;		
			ResultSet rs     = null;
			String strSql    = "";
			String strUserId = "";

			try
			{
				aList = new ArrayList();
				DbConnectionBean dbConBean = null;
				dbConBean = new DbConnectionBean();
				
				strSql = "SELECT USERID FROM M_USERINFO MUI (NOLOCK) WHERE APPROVER_LEVEL=1 AND SITE_ID="+strSiteId+" AND STATUS_ID=10 AND APPLICATION_ID=1 AND USERID = "+strManagerId+" UNION SELECT UAM.USERID FROM USER_MULTIPLE_ACCESS UAM WHERE SITE_ID="+strSiteId+" AND UAM.USERID = "+strManagerId+" AND APPROVAL_LVL1='Y' AND STATUS_ID=10 ORDER BY 1";
			
				rs = dbConBean.executeQuery(strSql);

				if(rs.next())
					{
						strUserId = rs.getString("USERID");
						aList.add(strUserId);
					}
					rs.close();	
			}
			catch(Exception e)
			{
				System.out.println("Error in findApprovalLevelOneListForUser(...) of  DbUtilityMethods.java=============== "+e);
			}
			return aList;
		}


		//Added By GURMEET SINGH on 17-Feb-14 to get Approval Level Two List for User
		public ArrayList findApprovalLevelTwoListForUser(String strSiteId, String strHodId)
		{
			ArrayList aList = null;		
			ResultSet rs     = null;
			String strSql    = "";
			String strUserId = "";

			try
			{
				aList = new ArrayList();
				DbConnectionBean dbConBean = null;
				dbConBean = new DbConnectionBean();
				
				strSql = "SELECT USERID FROM M_USERINFO (NOLOCK) WHERE ((APPROVER_LEVEL=2 AND SITE_ID="+strSiteId+" AND USERID = "+strHodId+") or (APPROVER_LEVEL=3 AND USERID = "+strHodId+")) AND STATUS_ID=10 AND APPLICATION_ID=1 UNION SELECT UAM.USERID  FROM USER_MULTIPLE_ACCESS UAM WHERE SITE_ID="+strSiteId+" AND UAM.USERID = "+strHodId+" AND APPROVAL_LVL2='Y' AND STATUS_ID=10 ORDER BY 1";
			
				rs = dbConBean.executeQuery(strSql);

				if(rs.next())
					{
						strUserId = rs.getString("USERID");
						aList.add(strUserId);
					}
					rs.close();	
			}
			catch(Exception e)
			{
				System.out.println("Error in findApprovalLevelTwoListForUser(...) of  DbUtilityMethods.java=============== "+e);
			}
			return aList;
		}
		

		//Added By GURMEET SINGH on 17-Feb-14 to get Approval Level Three List for User
		public ArrayList findApprovalLevelThreeListForUser(String strSiteId, String strBoardMemberId)
		{
			ArrayList aList = null;		
			ResultSet rs     = null;
			String strSql    = "";
			String strUserId = "";

			try
			{
				aList = new ArrayList();
				DbConnectionBean dbConBean = null;
				dbConBean = new DbConnectionBean();
				
				strSql = "SELECT USERID FROM M_BOARD_MEMBER WHERE M_BOARD_MEMBER.SITE_ID="+strSiteId+" AND USERID = "+strBoardMemberId+" AND M_BOARD_MEMBER.STATUS_ID=10";
			
				rs = dbConBean.executeQuery(strSql);

				if(rs.next())
					{
						strUserId = rs.getString("USERID");
						aList.add(strUserId);
					}
					rs.close();	
			}
			catch(Exception e)
			{
				System.out.println("Error in findApprovalLevelThreeListForUser(...) of  DbUtilityMethods.java=============== "+e);
			}
			return aList;
		}
		
		
		//Added By GURMEET SINGH 
		public ArrayList findUserOfBillingUnitForApproval(String strBillingSite)
		{
			ArrayList aList = null;		
			ResultSet rs     = null;
			String strSql    = "";
			String strUserId = "";

			try
			{
				aList = new ArrayList();
				DbConnectionBean dbConBean = null;
				dbConBean = new DbConnectionBean();
				
				strSql = "SELECT 1 FROM M_BILLING_APPROVER BA INNER JOIN M_USERINFO UI ON UI.USERID = BA.APPROVER_ID  WHERE BA.SITE_ID= " + strBillingSite	+ " AND STATUS_ID=10";
				rs = dbConBean.executeQuery(strSql);
				
					if (!rs.next()) {
						rs.close();
						strSql = "SELECT DISTINCT USERID FROM M_USERINFO WHERE (SITE_ID="+ strBillingSite +" AND STATUS_ID=10 AND  ISNULL(APPROVER_LEVEL,0) IN (1,2) ) OR ( STATUS_ID=10 AND  ISNULL(APPROVER_LEVEL,0) IN (3) ) ORDER BY 1";
						rs = dbConBean.executeQuery(strSql);
						while (rs.next()) {
							strUserId = rs.getString("USERID");
							aList.add(strUserId);
						}
						rs.close();
					}
					else {
						strSql = "SELECT DISTINCT APPROVER_ID AS USERID FROM M_BILLING_APPROVER BA INNER JOIN M_USERINFO UI ON UI.USERID = BA.APPROVER_ID WHERE BA.SITE_ID= "+ strBillingSite +" AND STATUS_ID =10";
						rs = dbConBean.executeQuery(strSql);
						while (rs.next()) {
							strUserId = rs.getString("USERID");
							aList.add(strUserId);
						}
						rs.close();
						}
					
			}
			catch(Exception e)
			{
				System.out.println("Error in findUserOfBillingUnitForApproval(...) of  DbUtilityMethods.java=============== "+e);
			}
			return aList;
		}
		
		
		//Added By GURMEET SINGH 
		public ArrayList findApproversListForWorkFlowReq(String strTravelId, String strTravellerId, String Suser_id, String strTravelType)
		{
			ArrayList aList = null;		
			ResultSet rs     = null;
			String strSql    = "";
			String strUserId = "";

			try
			{
				aList = new ArrayList();
				DbConnectionBean dbConBean = null;
				dbConBean = new DbConnectionBean();
				
				if(strTravelType.equals("I")) {				
					strSql = "SELECT APPROVER_ID FROM T_APPROVERS TA WHERE TRAVEL_ID = "+strTravelId+" AND TRAVELLER_ID ="+strTravellerId+" AND APPROVER_ID = "+Suser_id+" AND TRAVEL_TYPE='I' AND TA.STATUS_ID=10 ORDER BY 1";
				}
				else if(strTravelType.equals("D")) {
					strSql = "SELECT APPROVER_ID FROM T_APPROVERS TA WHERE TRAVEL_ID = "+strTravelId+" AND TRAVELLER_ID = "+strTravellerId+" AND APPROVER_ID = "+Suser_id+" AND TRAVEL_TYPE='D' AND TA.STATUS_ID=10 ORDER BY 1";
				}
				rs = dbConBean.executeQuery(strSql);

				if(rs.next())
					{
						strUserId = rs.getString("APPROVER_ID");
						aList.add(strUserId);
					}
					rs.close();	
			}
			catch(Exception e)
			{
				System.out.println("Error in findApproversListForWorkFlowReq(...) of  DbUtilityMethods.java=============== "+e);
			}
			return aList;
		}	
		public ResultSet getReportType()    
		{
			 ResultSet rs = null;
			 String sql = "Select report_code,report_desc from m_booking_report ";
			 DbConnectionBean dbCon = new DbConnectionBean();
			 try
			 {
			   rs = dbCon.executeQuery(sql);
			  
			 }
			 catch(Exception e)
			 {
				 System.out.println("Error in getNewId(String tableName) of DbUtilityMethods==="+e);
			 }
			 return rs;
		}
		public ResultSet getTravelStatus()    
		{
			 ResultSet rs = null;
			 String sql = "select TRAVEL_STATUS_ID,TRAVEL_STATUS_NAME from M_TRAVEL_STATUS_INFO where TRAVEL_STATUS_ID not in(1) order by TRAVEL_STATUS_ID desc";
			 DbConnectionBean dbCon = new DbConnectionBean();
			 try {
			   rs = dbCon.executeQuery(sql);
			 }
			 catch(Exception e) {
				 System.out.println("Error in getTravelStatus() of DbUtilityMethods==="+e);
			 }
			 return rs;
		}
}
