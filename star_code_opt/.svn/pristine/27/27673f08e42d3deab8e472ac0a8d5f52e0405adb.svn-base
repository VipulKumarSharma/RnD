
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import src.connection.PropertiesLoader;

public class DownloadVISAFile extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		byte[] FileBytes  		= null;
		Connection conn			= null;
		Statement stmt			= null;
		ResultSet rs			= null;
		String strSql			= "";
		String strUserId		= "";
		String strFileName		= "";
		String strVisaCountry	= "";
		
		String contentType 		= ""; 	
		String dbdriver			= null;
		String dburl			= null;
		String dbuser			= null;
		String dbpswd			= null;
		
		dbdriver	= PropertiesLoader.config.getProperty("dbdriver")==null?"":PropertiesLoader.config.getProperty("dbdriver");
		dburl 		= PropertiesLoader.config.getProperty("dburl")==null?"":PropertiesLoader.config.getProperty("dburl");
		dbuser 		= PropertiesLoader.config.getProperty("dbuser")==null?"":PropertiesLoader.config.getProperty("dbuser");
		dbpswd 		= PropertiesLoader.config.getProperty("dbpwd")==null?"":PropertiesLoader.config.getProperty("dbpwd"); 

		try {
			Class.forName(dbdriver);
			conn = DriverManager.getConnection(dburl,dbuser,dbpswd);
			conn.setAutoCommit(true);
			stmt = conn.createStatement();
		} catch (ClassNotFoundException e2) {
			e2.printStackTrace();
		} catch (SQLException e2) {
			e2.printStackTrace();
		}

   		strUserId 		= request.getParameter("userid")==null 		? "" :request.getParameter("userid").trim();
   		strVisaCountry  = request.getParameter("visaCountry")==null	? "" :request.getParameter("visaCountry").trim();
   		
		strSql    		= "SELECT VISA_FILENAME,VISA_FILE FROM M_USERVISA WHERE USERID= "+strUserId+" AND VISA_COUNTRY="+strVisaCountry;
		
		try {
			rs = stmt.executeQuery(strSql);
		} catch (SQLException e1) {
			System.out.println("error in DownloadVISAFile >>>>>>");
			e1.printStackTrace();
		}
		 
		try {
			if(rs.next()) {
				strFileName = rs.getString("VISA_FILENAME");
				FileBytes	= rs.getBytes("VISA_FILE");
			}
			rs.close();
			//System.out.println("strFileName--1-->"+strFileName);
			//System.out.println("FileBytes---->"+FileBytes);
		} catch (SQLException e) {
			System.out.println("Error in fetching bytes");	
			e.printStackTrace();
		} finally {
        	try {
        		conn.close();
        	} catch(Exception e) {
        		System.out.println("error in closing connectins in DownloadVISAFile "+e);
        	}
	    }
		
		String strFileNameExtension = strFileName.substring(strFileName.lastIndexOf(".")+1, strFileName.length()).trim();
		//System.out.println("strFileNameExtension--2-->"+strFileNameExtension);
       
		if(strFileNameExtension.equalsIgnoreCase("pdf")) {
			contentType = "application/pdf";
		
		} else if(strFileNameExtension.equalsIgnoreCase("htm") || strFileNameExtension.equalsIgnoreCase("html")) {
    	    contentType = "text/html";
		
		} else if(strFileNameExtension.equalsIgnoreCase("tif") || strFileNameExtension.equalsIgnoreCase("tiff")) {
			contentType = "image/tiff";
		
		} else if(strFileNameExtension.equalsIgnoreCase("msg")) {
			contentType = "application/vnd.ms-outlook";				   
       
		} else if(strFileNameExtension.equalsIgnoreCase("gif")) {
			contentType = "image/gif";
		
		} else if(strFileNameExtension.equalsIgnoreCase("png")) {
			contentType = "image/x-png";
       
		} else if(strFileNameExtension.equalsIgnoreCase("jpg") || strFileNameExtension.equalsIgnoreCase("jpe") || strFileNameExtension.equalsIgnoreCase("jpeg")) {
			contentType = "image/jpeg";
       
		} else if(strFileNameExtension.equalsIgnoreCase("zip")) {
    	    contentType = "application/zip";
       
		} else if(strFileNameExtension.equalsIgnoreCase("ppt")) {
    	    contentType = "application/vnd.ms-powerpoint";
       
		} else {
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
