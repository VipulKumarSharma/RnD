package Mobile_Connection;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Properties;

public class Mobile_survey_Connnection 
{
    private Connection conn;
    private Statement stmt;
	String dbdriver			=	null;
	String dburl			=	null;
	String dbuser			=	null;
    String dbpswd			=	null;
	public Mobile_survey_Connnection()
	{

		try{
			String strPath	=	new String(getClass().getResource("Mobile_Survey_Resource.properties").getPath());
			strPath = strPath.replaceAll("%20", " ");
			FileInputStream propfile = new FileInputStream(strPath);
			if( propfile != null){
				Properties gasprop = new Properties();
				gasprop.load( propfile);
				dbdriver		=	gasprop.getProperty("dbdriver");// get the dbdriver 
				dburl			=	gasprop.getProperty("dburl");
				dbuser			=	gasprop.getProperty("dbuser");
				dbpswd			=	gasprop.getProperty("dbpwd");
				propfile.close();
		}	
		 	}catch(Exception e){
				System.out.println("Error in creating context");					
			}
     
	}
    public Connection getConnection() 
    {
      try 
      {	
    	 /* System.out.println("dbuser is-->>"+dbuser);
    	  System.out.println("dbdriver is-->>"+dbdriver);
    	  System.out.println("dburl is-->>"+dburl);
    	  System.out.println("dbpswd is-->>"+dbpswd);*/
   	   	  Class.forName(dbdriver);
          conn = DriverManager.getConnection(dburl,dbuser,dbpswd);
		  conn.setAutoCommit(true);
          stmt = conn.createStatement();
          return conn;		  	 	   
      }
	   catch (Exception e) 
	   {
		   System.out.println("Error in getConnection() of DbConnectionBean.java==="+e);
		   e.printStackTrace();
          return null;
      }
    }
}
