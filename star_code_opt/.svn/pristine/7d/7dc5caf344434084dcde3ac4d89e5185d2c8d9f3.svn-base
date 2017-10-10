/***************************************************
*Copyright (C) 2000 MIND
*All rights reserved.
*The information contained here in is confidential and *proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Sachin Gupta.
*Date			:	23/08/2006 (DD/MM/YYYY format)
*Description	:	General Connection Class For JSP and Action Classes
*Modification History :Introduce centralise scheme for accessing db settings by Gaurav Aggarwalon 06-Jun-2007 
		       Introduce centralise scheme for accessing application path by Sanjeet Kumar on 18-Jun-2007 
**Project		:	MATP
*
*Modified By			: Manoj Chand
*Modification 			: Create Database connection from stars.properties located outside STARS application.
*Modification Date		: 03 Jan 2013
**********************************************************/ 

package src.connection;

import java.sql.Connection;
import java.sql.SQLException;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;
import java.io.*;
import src.connection.PropertiesLoader;
/**
 * @author sachin gupta
 *
 * To change the template for this generated type comment go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */

public class DbConnectionBean 
{
     private Connection conn;
     private Statement stmt;
	 private PreparedStatement pstmt;
	 String dbdriver		="";
	 String dburl			="";
	 String dbuser			="";
     String dbpwd			="";
	 private String Path			="";
	 private String strReplaced		="";

		       //@Sanjeet Kumar on 18-Jun-2007  Introduce centralise scheme for accessing application path thus removing hardcoding of path
      public DbConnectionBean ()
	{
	   try{
	   		  DataSource ds;
	          Context ic = null;	
		      //Path=new String(getClass().getResource("STAR.properties").getPath());
		     // System.out.println("Before replaced Path is >>> "+Path);
	      /*    for(int i=0;i<Path.length();i++)
			 {
	         		strReplaced =Path.replace("%20"," ");
			 }*/

//@Gaurav on 06-Jun-2007 Introduce centralise scheme for accessing db settings

//			  FileInputStream propfile = new FileInputStream(getClass().getResource("STAR.properties").getPath());
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
			 //added by manoj chand on 03 jan 2013 to fetch star.properties located outside the application.
		    dbdriver=PropertiesLoader.config.getProperty("dbdriver")==null?"":PropertiesLoader.config.getProperty("dbdriver");
			dburl=PropertiesLoader.config.getProperty("dburl")==null?"":PropertiesLoader.config.getProperty("dburl");
			dbuser=PropertiesLoader.config.getProperty("dbuser")==null?"":PropertiesLoader.config.getProperty("dbuser");
			dbpwd=PropertiesLoader.config.getProperty("dbpwd")==null?"":PropertiesLoader.config.getProperty("dbpwd");
			 Class.forName(dbdriver);
             conn = DriverManager.getConnection(dburl,dbuser,dbpwd);
			 //End of Code by @Gaurav 
			     
			  //ic = new InitialContext();
              //ds = (javax.sql.DataSource)ic.lookup("java:comp/env/jdbc/star");
			  //conn = ds.getConnection();

              conn.setAutoCommit(true);
              stmt = conn.createStatement();
          }
		  catch (Exception e) 
	      {
			  System.out.println("Connection not Created !Error in c'tor of DbConnectionBean.java==="+e);
              e.printStackTrace();
          }
     }


    /**************************************************************
     Method             :executeQuery(String pSql) 
     Return Values()	:ResultSet
     Parameter(s)		:String pSql
     Purpose			:This method is for getting the ResultSet from the Statement.
     **************************************************************/
     public ResultSet executeQuery(String pSql) 
     {
       try 
       {
           return stmt.executeQuery(pSql);
       }
	   catch (SQLException e) 
	   {
		   System.out.println("Error in executeQuery(String pSql) of DbConnectionBean.java==="+e);
		   e.printStackTrace();
           return null;
       }
     }

	 /**************************************************************
     Method             :executeQuery(String pSql) 
     Return Values()	:ResultSet
     Parameter(s)		:String pSql
     Purpose			:This method is for getting the ResultSet from the Statement.
     **************************************************************/
     public Connection getConnection() 
     {
       try 
       {
           return conn;
       }
	   catch (Exception e) 
	   {
		   System.out.println("Error in getConnection() of DbConnectionBean.java==="+e);
		   e.printStackTrace();
           return null;
       }
     }
	

     /**************************************************************
     Method             :executeQuery1(String pSql) 
     Return Values()	:ResultSet
     Parameter(s)		:String pSql
     Purpose			:This method is for getting the ResultSet from the PrepareStatement.
     **************************************************************/
	 public ResultSet executeQuery1(String pSql) 
     {
       try 
       {
		   pstmt = conn.prepareStatement(pSql);
           return pstmt.executeQuery();
       }
	   catch (SQLException e) 
	   {
		   System.out.println("Error in executeQuery1(String pSql) of DbConnectionBean.java==="+e);
		   e.printStackTrace();
           return null;
       }
     }

   	 /**************************************************************
     Method             :closeStmt() 
     Return Values()	:
     Parameter(s)		:
     Purpose			:This method is for close the Statement.
     **************************************************************/
	 public void closeStmt() throws SQLException
	 {
		 stmt.close();
	 }

	 /**************************************************************
     Method             :closePstmt() 
     Return Values()	:
     Parameter(s)		:
     Purpose			:This method is for close the PrepareStatement.
     **************************************************************/
     public void closePstmt() throws SQLException
	 {
		 pstmt.close();
	 }

   	 /**************************************************************
     Method             :closeCon() 
     Return Values()	:
     Parameter(s)		:
     Purpose			:This method is for close the Connection.
     **************************************************************/
	 public void closeCon() throws SQLException
	 {
		 conn.close();
	 }

  	 /**************************************************************
     Method             :close() 
     Return Values()	:
     Parameter(s)		:
     Purpose			:This method is for close the Statement and Connetion.
     **************************************************************/
    public void close() throws SQLException
	{
		 stmt.close();
		 conn.close();
	}
    
	/*public static void main(String arg[])
    {
       try
       { 
         String sql = "select Div_id, Div_Name from M_Division order by 1";  
         DbConnectionBean aa = new DbConnectionBean();
         ResultSet rs = aa.executeQuery(sql); 
         while(rs.next())
         {
            System.out.println(rs.getString(1));
			System.out.println(rs.getString(2));		
         } 
        }
        catch(Exception e)
        {
           System.out.println("sssss");   
		} 
    } */


  /**************************************************************
     Method             :executeUpdate(String pSql) 
     Return Values()	:ResultSet
     Parameter(s)		:String pSql
     Purpose			:This method is for getting the ResultSet from the Statement.
     **************************************************************/
     public int executeUpdate(String pSql) 
     {
       try 
       {
           return stmt.executeUpdate(pSql);
       }
	   catch (SQLException e) 
	   {
		   System.out.println("Error in executeUpdate(String pSql) of DbConnectionBean.java==="+e);
		   e.printStackTrace();
           return 0;
       }
     }






}
