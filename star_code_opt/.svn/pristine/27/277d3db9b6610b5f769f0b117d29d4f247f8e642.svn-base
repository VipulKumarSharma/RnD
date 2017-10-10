/***************************************************
*Copyright (C) 2000 MIND
*All rights reserved.
*The information contained here in is confidential and proprietary to MIND and forms the part of the MIND 
*Created BY		:	Manoj Chand
*Date			:	11 March 2013
*Description	:	LOGGING WEB SERVICE REQUEST-RESPONSE
*Project		:	STARS
**********************************************************/ 

package wsclient.wslogging;

import java.sql.CallableStatement;
import java.sql.Connection;
import src.connection.DbConnectionBean;

public class WSLoggingUtility {
	//method to make a entry of request and response on every call
	 public static void logRequestResponse(String requestBeanResponse,String responseBeanResponse,String strReqAppName,String methodName,String strCallingStatus,String strSiteId){	   
		 	DbConnectionBean objCon=new DbConnectionBean();
		 	Connection con=null;
			con=objCon.getConnection();
			CallableStatement objCstmt= null;
			try{
				objCstmt  =  con.prepareCall("{?=call REQUEST_RESP_DATA(?,?,?,?,?,?,?)}"); //PROCEDURE TO get RESULT SET
				objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				objCstmt.setString(2,requestBeanResponse);		
				objCstmt.setString(3,responseBeanResponse);
				objCstmt.setString(4,methodName);
				objCstmt.setString(5,strSiteId);
				objCstmt.setString(6,strReqAppName);
				objCstmt.setString(7,strCallingStatus);
				objCstmt.setString(8,"NEW");
				objCstmt.executeUpdate();
				con.close();
			}catch(Exception e){
				System.out.println("ERROR in REQUEST_RESP_DATA insertion");
			}	
	  }
	 
	//method to make a entry of request and response on recall
	 public static void updateStatusOnRecall(String strLogId,String strWSResponse){	   
		 	DbConnectionBean objCon=new DbConnectionBean();
		 	Connection con=null;
			con=objCon.getConnection();
			CallableStatement objCstmt= null;
			try{
				objCstmt  =  con.prepareCall("{?=call PROC_UPDATE_REQUEST_RESP_DATA(?,?,?,?,?)}");
				objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				objCstmt.setString(2,strLogId);
				objCstmt.setString(3,strWSResponse);
				objCstmt.setString(4,"Success");
				objCstmt.setString(5,"SEND");
				objCstmt.registerOutParameter(6,java.sql.Types.INTEGER);
				objCstmt.executeUpdate();
				con.close();
			}catch(Exception e){
				System.out.println("ERROR in PROC_UPDATE_REQUEST_RESP_DATA UPDATION CALLING");
			}	
	  }	
}
