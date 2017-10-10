/***************************************************
*Copyright (C) 2000 MIND
*All rights reserved.
*The information contained here in is confidential and proprietary to MIND and forms the part of the MIND 
*Created BY		:	Gurmeet Singh
*Date			:	28 Feb 2014
*Description	:	This class is used to check authentication/access for user/approver at different level.	
*Project		:	STARS
**********************************************************/ 

package src.connection;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;


public class SecurityUtilityMethods {	
	
	 
	 public SecurityUtilityMethods () {    
		 
	}
	 
	
	/*****************************************************************************************************************
	Method           	:validateAuthSiteUserAccess(String strUserId, String strSiteId, String strLevelVal)
	Return Values()		:String
	Parameter(s)		:String strUserId, String strSiteId, String strLevelVal
	Purpose				:Validate user access for authenticate site
	********************************************************************************************************************/
	public String validateAuthSiteUserAccess(String strUserId, String strSiteId, String strLevelVal)
	{
		ResultSet rs = null;
		DbConnectionBean dbConBean = null;
		String strUserAccessCheckFlag = "";
		String strSql = "";
		
		try
		{
			dbConBean = new DbConnectionBean();			
			strSql = "SELECT DBO.FN_AUTH_SITE_USER_ACCESS("+strUserId+", "+strSiteId+", "+strLevelVal+")";
		    rs = dbConBean.executeQuery(strSql);	 		    
			if(rs.next()){
				strUserAccessCheckFlag = rs.getString(1);		
			}	 			
		   rs.close();
		   
		}
		catch (Exception e) 
		{
		  System.out.println("Error in validateAuthSiteUserAccess() of SecurityUtilityMethods.java=============== "+e);
		  e.printStackTrace();
		}finally {
			try {				
				dbConBean.close();
			} catch (Exception e) {	}
		}
		return strUserAccessCheckFlag;
	}
		
	
	
	/*****************************************************************************************************************
	Method           	:validateAuthCostCenter(String strCostCentre, String strSiteId)
	Return Values()		:String
	Parameter(s)		:String strCostCentre, String strSiteId
	Purpose				:Validate user access for authenticate Cost Centere
	********************************************************************************************************************/
	public String validateAuthCostCenter(String strCostCentre, String strSiteId)
	{
		ResultSet rs = null;
		DbConnectionBean dbConBean = null;
		String strUserAccessCheckFlag = "";
		String strSql = "";
		
		try
		{
			dbConBean = new DbConnectionBean();			
			strSql = "SELECT DBO.FN_AUTH_COST_CENTER("+strCostCentre+", "+strSiteId+")";
		    rs = dbConBean.executeQuery(strSql);	 		    
			if(rs.next()){
				strUserAccessCheckFlag = rs.getString(1);		
			}	 			
		   rs.close();
		   
		}
		catch (Exception e) 
		{
		  System.out.println("Error in validateAuthCostCenter() of SecurityUtilityMethods.java=============== "+e);
		  e.printStackTrace();
		}finally {
			try {				
				dbConBean.close();
			} catch (Exception e) {	}
		}
		return strUserAccessCheckFlag;
	}
		
	
	
	/*****************************************************************************************************************
	Method           	:validateAuthCancelTravelReq(String strTravelId, String strTravelType, String strUserId)
	Return Values()		:String
	Parameter(s)		:String strTravelId, String strTravelType, String strUserId
	Purpose				:Validate user access for cancel and delete request
	********************************************************************************************************************/
	public String validateAuthCancelTravelReq(String strTravelId, String strTravelType, String strUserId){
		ResultSet rs = null;
		DbConnectionBean dbConBean = null;
		String strUserAccessCheckFlag = "";
		String strSql = "";
		
		try
		{
			dbConBean = new DbConnectionBean();			
			strSql = "SELECT DBO.FN_AUTH_CANCEL_TRAVEL_REQ("+strTravelId+", '"+strTravelType+"', "+strUserId+")";
			rs = dbConBean.executeQuery(strSql);	 		    
			if(rs.next()){
				strUserAccessCheckFlag = rs.getString(1);		
			}	 			
		   rs.close();
		   
		}
		catch (Exception e) 
		{
		  System.out.println("Error in validateAuthCancelTravelReq() of SecurityUtilityMethods.java=============== "+e);
		  e.printStackTrace();
		}finally {
			try {				
				dbConBean.close();
			} catch (Exception e) {	}
		}
		return strUserAccessCheckFlag;
	}
		
	
	
	/*****************************************************************************************************************
	Method           	:validateAuthEditTravelReq(String strTravelId, String strTravelType, String strUserId)
	Return Values()		:String
	Parameter(s)		:String strTravelId, String strTravelType, String strUserId
	Purpose				:Validate user access for edit request
	********************************************************************************************************************/
	public String validateAuthEditTravelReq(String strTravelId, String strTravelType, String strUserId){
		ResultSet rs = null;
		DbConnectionBean dbConBean = null;
		String strUserAccessCheckFlag = "";
		String strSql = "";
		
		try
		{
			dbConBean = new DbConnectionBean();			
			strSql = "SELECT DBO.FN_AUTH_EDIT_TRAVEL_REQ("+strTravelId+", '"+strTravelType+"', "+strUserId+")";
			rs = dbConBean.executeQuery(strSql);	 		    
			if(rs.next()){
				strUserAccessCheckFlag = rs.getString(1);		
			}	 			
		   rs.close();
		   
		}
		catch (Exception e) 
		{
		  System.out.println("Error in validateAuthEditTravelReq() of SecurityUtilityMethods.java=============== "+e);
		  e.printStackTrace();
		}finally {
			try {				
				dbConBean.close();
			} catch (Exception e) {	}
		}
		return strUserAccessCheckFlag;
	}
		
	
	
	/*****************************************************************************************************************
	Method           	:validateAuthCommentsTravelReq(String strTravelId, String strTravelType, String strUserId)
	Return Values()		:String
	Parameter(s)		:String strTravelId, String strTravelType, String strUserId
	Purpose				:Validate user/approver access for upload attachment and post comments
	********************************************************************************************************************/
	public String validateAuthCommentsTravelReq(String strTravelId, String strTravelType, String strUserId){
		ResultSet rs = null;
		DbConnectionBean dbConBean = null;
		String strUserAccessCheckFlag = "";
		String strSql = "";
		
		try
		{
			dbConBean = new DbConnectionBean();			
			strSql = "SELECT DBO.FN_AUTH_COMMENTS_TRAVEL_REQ("+strTravelId+", '"+strTravelType+"', "+strUserId+")";
			rs = dbConBean.executeQuery(strSql);	 		    
			if(rs.next()){
				strUserAccessCheckFlag = rs.getString(1);		
			}	 			
		   rs.close();
		   
		}
		catch (Exception e) 
		{
		  System.out.println("Error in validateAuthCommentsTravelReq() of SecurityUtilityMethods.java=============== "+e);
		  e.printStackTrace();
		}finally {
			try {				
				dbConBean.close();
			} catch (Exception e) {	}
		}
		return strUserAccessCheckFlag;
	}
		
	
	
	/*****************************************************************************************************************
	Method           	:validateAuthTravelApprovalAction(String strTravelId, String strTravelType, String strUserId)
	Return Values()		:String
	Parameter(s)		:String strTravelId, String strTravelType, String strUserId
	Purpose				:Validate approver access for travel request action
	********************************************************************************************************************/
	public String validateAuthTravelApprovalAction(String strTravelId, String strTravelType, String strUserId){
		ResultSet rs = null;
		DbConnectionBean dbConBean = null;
		String strUserAccessCheckFlag = "";
		String strSql = "";
		
		try
		{
			dbConBean = new DbConnectionBean();			
			strSql = "SELECT DBO.FN_AUTH_TRAVEL_APPROVAL_ACTION("+strTravelId+", '"+strTravelType+"', "+strUserId+")";
			rs = dbConBean.executeQuery(strSql);	 		    
			if(rs.next()){
				strUserAccessCheckFlag = rs.getString(1);		
			}	 			
		   rs.close();
		   
		}
		catch (Exception e) 
		{
		  System.out.println("Error in validateAuthTravelApprovalAction() of SecurityUtilityMethods.java=============== "+e);
		  e.printStackTrace();
		}finally {
			try {				
				dbConBean.close();
			} catch (Exception e) {	}
		}
		return strUserAccessCheckFlag;
	}
		
		
	
	/*****************************************************************************************************************
	Method           	:validateAuthTravelDetails(String strTravelId, String strTravelType, String strUserId)
	Return Values()		:String
	Parameter(s)		:String strTravelId, String strTravelType, String strUserId
	Purpose				:Validate user/approver access for travel details
	********************************************************************************************************************/
	public String validateAuthTravelDetails(String strTravelId, String strTravelType, String strUserId){
		ResultSet rs = null;
		DbConnectionBean dbConBean = null;
		String strUserAccessCheckFlag = "";
		String strSql = "";
		
		try
		{
			dbConBean = new DbConnectionBean();			
			strSql = "SELECT DBO.FN_AUTH_TRAVEL_DETAILS("+strTravelId+", '"+strTravelType+"', "+strUserId+")";
			rs = dbConBean.executeQuery(strSql);	 		    
			if(rs.next()){
				strUserAccessCheckFlag = rs.getString(1);		
			}	 			
		   rs.close();
		   
		}
		catch (Exception e) 
		{
		  System.out.println("Error in validateAuthTravelDetails() of SecurityUtilityMethods.java=============== "+e);
		  e.printStackTrace();
		}finally {
			try {				
				dbConBean.close();
			} catch (Exception e) {	}
		}
		return strUserAccessCheckFlag;
	}
	
	
	
	/*****************************************************************************************************************
	Method           	:validateAuthHandover(String strTravelId, String strTravelType, String strTravellerId, String strUserId)
	Return Values()		:String
	Parameter(s)		:String strTravelId, String strTravelType, String strTravellerId, String strUserId
	Purpose				:Validate approver access hand over travel request
	********************************************************************************************************************/
	public String validateAuthHandover(String strTravelId, String strTravelType, String strTravellerId, String strUserId){
		ResultSet rs = null;
		DbConnectionBean dbConBean = null;
		String strUserAccessCheckFlag = "";
		String strSql = "";
		
		try
		{
			dbConBean = new DbConnectionBean();			
			strSql = "SELECT DBO.FN_AUTH_HANDOVER("+strTravelId+", '"+strTravelType+"', "+strTravellerId+", "+strUserId+")";
			rs = dbConBean.executeQuery(strSql);	 		    
			if(rs.next()){
				strUserAccessCheckFlag = rs.getString(1);		
			}	 			
		   rs.close();
		   
		}
		catch (Exception e) 
		{
		  System.out.println("Error in validateAuthHandover() of SecurityUtilityMethods.java=============== "+e);
		  e.printStackTrace();
		}finally {
			try {				
				dbConBean.close();
			} catch (Exception e) {	}
		}
		return strUserAccessCheckFlag;
	}
	
	
	
	/*****************************************************************************************************************
	Method           	:registerUnauthAccessLog(String strUserId, String ipAddress, String strPageName, String strActionDesc)
	Return Values()		:void
	Parameter(s)		:String strUserId, String ipAddress, String strPageName, String strActionDesc
	Purpose				:register Unauthorized access log 
	********************************************************************************************************************/
	public static void registerUnauthAccessLog(String strUserId, String ipAddress, String strPageName, String strActionDesc){
	 	DbConnectionBean objCon=new DbConnectionBean();
	 	Connection con=null;
		con=objCon.getConnection();
		CallableStatement objCstmt= null;
		try{
			objCstmt  =  con.prepareCall("{?=call PROC_UNAUTH_ACCESS_LOG(?,?,?,?,?)}");
			objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			objCstmt.setString(2,strUserId);
			objCstmt.setString(3,ipAddress);
			objCstmt.setString(4,strPageName);
			objCstmt.setString(5,strActionDesc);
			objCstmt.registerOutParameter(6,java.sql.Types.INTEGER);
			objCstmt.executeUpdate();
			con.close();
		}catch(Exception e){
			System.out.println("Error in registerUnauthAccessLog() of SecurityUtilityMethods.java=============== "+e);
		}		
	}
	
}