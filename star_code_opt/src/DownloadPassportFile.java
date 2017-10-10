/*
 * Created By: Manoj Chand
 * Date of Creation : 20 June 2012
 * Description : this servlet is used to download passport.
 * Modified By	: Manoj Chand
 * Modification : Create Database connection from stars.properties located outside STARS application.
 * Modification Date: 03 Jan 2013
 * */


import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import src.connection.PropertiesLoader;

/**
 * Servlet implementation class DownloadPassportFile
 */
public class DownloadPassportFile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	ResultSet rs;
	String strSql="";
	String strUserId="";
	String strTravelType="";
	String strFileName="";
	String strUploadedOn="";
	byte[] FileBytes  = null;
	String contentType = ""; // set the content type
	String dbdriver		=null;
	String dburl		=null;
	String dbuser		=null;
	String dbpswd		=null;
	String user			=null;		// To hold the user
	String password		=null;		// To hold the password
	Connection conn		=null;
	Statement stmt		=null;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//ADDED BY MANOJ CHAND ON 03 JAN 2013 TO CREATE DB CONNECTION FROM OUTSIDE STARS.PROPERTIES

		 dbdriver 	    = PropertiesLoader.config.getProperty("dbdriver")==null?"":PropertiesLoader.config.getProperty("dbdriver");
		 dburl 		    = PropertiesLoader.config.getProperty("dburl")==null?"":PropertiesLoader.config.getProperty("dburl");
		 dbuser 		= PropertiesLoader.config.getProperty("dbuser")==null?"":PropertiesLoader.config.getProperty("dbuser");
		 dbpswd 		= PropertiesLoader.config.getProperty("dbpwd")==null?"":PropertiesLoader.config.getProperty("dbpwd"); 

	   try {
		Class.forName(dbdriver);
		conn = DriverManager.getConnection(dburl,dbuser,dbpswd);
		conn.setAutoCommit(true);
        stmt = conn.createStatement();
	} catch (ClassNotFoundException e2) {
		
		e2.printStackTrace();
	}
    catch (SQLException e2) {
		e2.printStackTrace();
	}
        

    	strUserId=request.getParameter("userid");
		strSql="SELECT P_FILENAME,P_FILE FROM M_USERINFO WHERE USERID= '"+strUserId+"' AND STATUS_ID=10 ";
		//System.out.println("strSql--------->"+strSql);
		
		try {
			rs=stmt.executeQuery(strSql);
		} catch (SQLException e1) {
			System.out.println("error in DownloadPassportFile >>>>>>");
			e1.printStackTrace();
		}
		
		 
		try {
			if(rs.next()){
			strFileName=rs.getString("P_FILENAME");
			FileBytes=rs.getBytes("P_FILE");
			}
			
			rs.close();
			//System.out.println("strFileName--1-->"+strFileName);
			//System.out.println("FileBytes---->"+FileBytes);
		} catch (SQLException e) {
			System.out.println("Error in fetching bytes");	
			e.printStackTrace();
		}
		 finally
	        {
	        	try
	        	{
	        		conn.close();
	        	}
	        	catch(Exception e)
	        	{
	        		System.out.println("error in closing connectins in DownloadPassportFile "+e);
	        	}
	        }
		
		 String strFileNameExtension=strFileName.substring(strFileName.lastIndexOf(".")+1, strFileName.length()).trim();
		 //System.out.println("strFileNameExtension--2-->"+strFileNameExtension);
	       if(strFileNameExtension.equalsIgnoreCase("pdf"))
	       {
	    	   contentType = "application/pdf";
	       }
	       else if(strFileNameExtension.equalsIgnoreCase("htm") || strFileNameExtension.equalsIgnoreCase("html"))
	       {
	    	   contentType = "text/html";
	       }
	       else if(strFileNameExtension.equalsIgnoreCase("tif") || strFileNameExtension.equalsIgnoreCase("tiff")) // Done by Ankoor 24/02/2009
	       {
	    	   contentType = "image/tiff";
	       }
	       else if(strFileNameExtension.equalsIgnoreCase("msg"))
	       {
	    	   contentType = "application/vnd.ms-outlook";				   
	       }
	       else if(strFileNameExtension.equalsIgnoreCase("gif")){
	    	   contentType = "image/gif";
	       }
	       else if(strFileNameExtension.equalsIgnoreCase("png")){
	    	   contentType = "image/x-png";
	       }
	       else if(strFileNameExtension.equalsIgnoreCase("jpg") || strFileNameExtension.equalsIgnoreCase("jpe") || strFileNameExtension.equalsIgnoreCase("jpeg")){
	    	   contentType = "image/jpeg";
	       }
	       else if(strFileNameExtension.equalsIgnoreCase("zip")){
	    	   contentType = "application/zip";
	       }
	       else if(strFileNameExtension.equalsIgnoreCase("ppt")){
	    	   contentType = "application/vnd.ms-powerpoint";
	       }
	       else
	       {
	    	   contentType = "application/octet-stream";
	       }
	       
	       response.setContentType(contentType);
	       response.setHeader("Content-Disposition","inline ;filename=" + strFileName + ";size=" + FileBytes.length + "");
	       //PrintWriter out=response.getWriter();
	       OutputStream outStream = response.getOutputStream();
	       outStream.write(FileBytes);
	       outStream.flush();
	       outStream.close();		 
	}
}
