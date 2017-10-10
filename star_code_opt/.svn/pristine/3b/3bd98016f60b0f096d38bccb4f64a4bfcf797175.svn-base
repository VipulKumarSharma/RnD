package src.connection;
/***************************************************
*Copyright (C) 2001 MIND
*All rights reserved.
*The information contained here in is confidential and
*proprietary to MIND and forms the part of the MIND

*CREATED BY		:Manoj Chand
*Date			:28-10-2013
*Project 		:STARS
*DESCRIPTION    :This class is used to keep the mapping of pages against url 
***********************************************************/
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Hashtable;
import java.util.Locale;
import java.util.ResourceBundle;

public class RolesResourceBinding {
	static String dbdriver="";
	static String dburl="";
	static String dbuser="";
	static String dbpswd="";
    Locale currentLocale = null;
    ResourceBundle messages = null;
	Connection con = null;				// Object for connection
	ResultSet rs = null;	
	public static RolesResourceBinding roleRes=null;
	Hashtable<String, String> pageRoleMapping=new Hashtable<String, String>();
	private RolesResourceBinding(){
		try{
			//System.out.println("creating hash table=====entry 2==========");
				String strReplaced="";
				String strRole="";
				String strUrl="";
				dbdriver=PropertiesLoader.config.getProperty("dbdriver")==null?"":PropertiesLoader.config.getProperty("dbdriver");
				dburl=PropertiesLoader.config.getProperty("dburl")==null?"":PropertiesLoader.config.getProperty("dburl");
				dbuser=PropertiesLoader.config.getProperty("dbuser")==null?"":PropertiesLoader.config.getProperty("dbuser");
				dbpswd=PropertiesLoader.config.getProperty("dbpwd")==null?"":PropertiesLoader.config.getProperty("dbpwd");			
				Class.forName(dbdriver);
				con=DriverManager.getConnection(dburl,dbuser,dbpswd);

				//String strSql	="select LINK,ACCESS from ROLES_RESOURCES union select LINK,ACCESS from LINK_ROLES_RESOURCES order by LINK";
				String strSql	="select JSP_LINK,ACCESS_ROLE from LINK_ROLES_RESOURCES order by JSP_LINK";
				Statement stmt 	= con.createStatement();
				rs 				= stmt.executeQuery(strSql);				
				//System.out.println("role  strSql-->"+strSql);
				while(rs.next())
				{
					strUrl=rs.getString("JSP_LINK").trim();
					strRole=rs.getString("ACCESS_ROLE").trim();						
					pageRoleMapping.put(strUrl, strRole);
				}
				//System.out.println("------->"+pageRoleMapping.size());
				//System.out.println("creating hash table=====exit2=========");
				rs.close();
				stmt.close();
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			try{
				con.close();
			}catch (Exception e) {
				e.printStackTrace();
				System.out.println("Exception in Roles page binding");
			}
			
		}
		
	}
	
	//Function to get the instance of RolesResourceBinding
	public static  RolesResourceBinding getInstance(){
			if(roleRes==null)
			{
				synchronized( RolesResourceBinding.class )
				{
					if(roleRes==null)
					{
						roleRes=new  RolesResourceBinding();
					return roleRes;
					}
				}
			}
			else
			{
				return roleRes;
			}
		return roleRes;	
	}
	
	/**************************************************************
	Method                     :getRole()
	Return Values()			   :String
	Parameter(s)			   :String url
	Author					   :Manoj Chand
	Date					   :28 OCT 2013
	Purpose					   :This method is for getting the roles against pages.

	**************************************************************/
		 public  String  getRole(String url)
		{
			String msg= null;			
	 		try
			{					
				msg=(String)pageRoleMapping.get(url);
				if(msg==null){
					msg="";
				}
			}
			catch(Exception e)
			{
				System.out.println("exception in reading hash table"+e);
			}
			
			return msg;
			
		}//end of function

	 /**************************************************************
		 * Method :getUpdatedRoles() Return Values() :String Parameter(s) 
		 * Author :Manoj Chand
		 * Date   :29 Oct 2013 
		 * Purpose:This method is for getting the roles name after new roles added or previous roles updated.
		 **************************************************************/
		public static RolesResourceBinding getUpdatedRoles() {
			synchronized (RolesResourceBinding.class) {
				roleRes = new RolesResourceBinding();
				return roleRes;
			}
		}	 
		 
}
