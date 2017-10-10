/************************************************************************
Copyright (C) 2006 *All rights reserved.
 * The information contained here in is confidential 
 * Name       : Register?User.java
 * Version    : 1.0
 * Project    : STAR
 * Department : Development dept.(MIND)
 * Created By : Abhinav Ratnawat(MIND)
 * Created On : 2006-Aug-28
 * DESCRIPTION: This program is a server side program which is used to validate registration details of user and 
 * 				                    inserting in database. 
 * Modification 			: Add a new field for userName 
                                : Added a new identity filed  on 22-Oct-07 by Shiv Sharma 
 * Reason of Modification   : Email-id not be an userid(login name ) for the login 
 * Date of Modification     : 07-12-2006
 * Modified By	            :SACHIN GUPTA
 * 
 *Modified By	        	:MANOJ CHAND
 *Date of Modification  	:19 August 2013
 *Description				:TRIM() call on strUserName variable to remove the leading and trailing white spaces.
******************************************************************************/


import java.io.*;
import java.net.URLEncoder;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.naming.*;
import javax.sql.*;
import java.util.*;
import src.connection.DbUtilityMethods;
import src.connection.DbConnectionBean;
	
public class  RegisterUser extends HttpServlet
{
	private  Connection conn,conn1;
	private  Statement stmt;
	private  ResultSet rs;
	private  DbConnectionBean dbConBean;
	String   strUrl   =  "";
	public void init(ServletConfig conf) throws ServletException {
		super.init(conf);
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response)
	throws ServletException, IOException {
 
 
		request.setCharacterEncoding("UTF-8");
		// added new on 03 Feb -2009 by shiv sharma for accepting domain name and windows user id 
		
		String strWinUserID  = request.getParameter("winUserID")== null ? "" : request.getParameter("winUserID");
		String strDomainName = request.getParameter("domainname")== null ? "" : request.getParameter("domainname");

		//System.out.println("strWinUserID=============in admin post page ========="+strWinUserID);
		//System.out.println("strDomainName========in admin post page =============="+strDomainName);
		
		// Retrieve all the parameter 	
	    String strCloseFlag = request.getParameter("closeFlag")==null?"outside":request.getParameter("closeFlag");

		

		String strFirstName = request.getParameter("firstName").trim() ;
		String strmiddleName = request.getParameter("middleName").trim();	
		String strLastName = request.getParameter("lastName").trim();	
		
     
        //2/28/2007
			//String strEmpCode = request.getParameter("empcode").trim();	
		String strEmpCode = (request.getParameter("empcode")==null)?"":request.getParameter("empcode");
		
        //2/28/2007  
 
           
		String strPassword = request.getParameter("password").trim();
		String strUserName = (request.getParameter("userName")==null)?"":request.getParameter("userName");
 
		String strEmail = request.getParameter("eMail").trim();
		String strDivision = request.getParameter("division");
		String strSite = request.getParameter("site");
		String strDepartment = request.getParameter("department");
		String strDesignation = request.getParameter("designation");
		String strReportTo =request.getParameter("repToUserId");
		
		// Added Department Head field on user profile on 17/08/2015 by Sandeep Malik
		String strDeptHead = request.getParameter("deptHeadUserId");

		//System.out.println("strReportTo------------------>>"+strReportTo );

		//String strQuest_secret = request.getParameter("quest_secret").equals(null)? request.getParameter("quest_secret"): request.getParameter("quest_secret").trim();
		String  strQuest_secret=request.getParameter("quest_secret1").trim();
		String	strHiddenQuest_secret=request.getParameter("question_other").trim();
		if(!strHiddenQuest_secret.equals("-"))
		{
			strQuest_secret=strHiddenQuest_secret;
		}
			
		
		
		String strAns_secret = request.getParameter("ans_secret").equals(null) ? request.getParameter("ans_secret"):request.getParameter("ans_secret").trim();
		String strPassport_No = request.getParameter("passport_No").equals(null)? request.getParameter("passport_No").trim(): request.getParameter("passport_No").trim();
		// Nationality Added for MATA GmbH by Sandeep Malik
		String strNationality = request.getParameter("nationality").equals(null)? request.getParameter("nationality").trim(): request.getParameter("nationality").trim();
		String strPassport_ECNR = request.getParameter("passport_ECNR").equals(null)?request.getParameter("passport_ECNR"):request.getParameter("passport_ECNR").trim();
		String strPassport_issue_date = request.getParameter("passport_issue_date").trim();
		String strPassport_flight_No = request.getParameter("passport_flight_No").equals(null)?request.getParameter("passport_flight_No"):request.getParameter("passport_flight_No").trim(); 
		String strPassport_flight_No1 = request.getParameter("passport_flight_No1").equals(null)?request.getParameter("passport_flight_No1"):request.getParameter("passport_flight_No1").trim(); 
		String strPassport_flight_No2 = request.getParameter("passport_flight_No2").equals(null)?request.getParameter("passport_flight_No2"):request.getParameter("passport_flight_No2").trim(); 
		
//new 16-02-2007
		String strCurrentAddress	=	request.getParameter("current_address")== null ? "" : request.getParameter("current_address");
		String strAirLineName		=	request.getParameter("airLineName")== null ? "" : request.getParameter("airLineName");
		String strAirLineName1		=	request.getParameter("airLineName1")== null ? "" : request.getParameter("airLineName1");
		String strAirLineName2		=	request.getParameter("airLineName2")== null ? "" : request.getParameter("airLineName2");
		
//NEW 20/04/2007  BY VIJAY SINGH
		String strGender			=	request.getParameter("gender")== null ? "" : request.getParameter("gender").trim();



		String strPassport_expire_date = request.getParameter("passport_expire_date").trim();
		String strPassport_DOB = request.getParameter("passport_DOB").trim();
		String strPassport_issue_place = request.getParameter("passport_issue_place").equals(null)? request.getParameter("passport_issue_place"): request.getParameter("passport_issue_place").trim();
		String strPassport_Contact_No = request.getParameter("passport_Contact_No").equals(null)? request.getParameter("passport_Contact_No"): request.getParameter("passport_Contact_No").trim();
		String strPassport_address = request.getParameter("passport_address") == null ? "" : request.getParameter("passport_address").trim();
		String strStatusID = request.getParameter("status_id");
		String strCUsesrId = (String)request.getSession().getAttribute("user_id");
//Added new on  18-Oct-2007  by shiv sharma  
		String strIdentityProof		= request.getParameter("identityProof").equals(null)? "": request.getParameter("identityProof").trim();
		String strIdentityProofNo = request.getParameter("identityProofno").equals(null)? "": request.getParameter("identityProofno").trim();
		String langselected = request.getParameter("langselected")==null?"en_US":request.getParameter("langselected");
		String strIpAddress = request.getRemoteAddr();
		//Added on 3-Dec-2015  by Mukesh Mishra
		String strAirLineName3		=	request.getParameter("airLineName3")== null ? "" : request.getParameter("airLineName3");
		String strAirLineName4		=	request.getParameter("airLineName4")== null ? "" : request.getParameter("airLineName4");
		String strPassport_flight_No3 = request.getParameter("passport_flight_No3").equals(null)?request.getParameter("passport_flight_No3"):request.getParameter("passport_flight_No3").trim(); 
		String strPassport_flight_No4 = request.getParameter("passport_flight_No4").equals(null)?request.getParameter("passport_flight_No4"):request.getParameter("passport_flight_No4").trim(); 
		String hotelChain=request.getParameter("hotelChain")== null ? "" : request.getParameter("hotelChain");
		String hotelChain1=request.getParameter("hotelChain1")== null ? "" : request.getParameter("hotelChain1");
		String hotelChain2=request.getParameter("hotelChain2")== null ? "" : request.getParameter("hotelChain2");
		String hotelChain3=request.getParameter("hotelChain3")== null ? "" : request.getParameter("hotelChain3");
		String hotelChain4=request.getParameter("hotelChain4")== null ? "" : request.getParameter("hotelChain4");
		String hotelNumber=request.getParameter("hotelNumber")== null ? "" : request.getParameter("hotelNumber");
		String hotelNumber1=request.getParameter("hotelNumber1")== null ? "" : request.getParameter("hotelNumber1");
		String hotelNumber2=request.getParameter("hotelNumber2")== null ? "" : request.getParameter("hotelNumber2");
		String hotelNumber3=request.getParameter("hotelNumber3")== null ? "" : request.getParameter("hotelNumber3");
		String hotelNumber4=request.getParameter("hotelNumber4")== null ? "" : request.getParameter("hotelNumber4");
		String strPassportIssuingCountry = request.getParameter("pp_issu_Country")==null?"0":request.getParameter("pp_issu_Country").trim();

		if(strPassport_No != null && strPassport_No.equals("")){
			strPassportIssuingCountry = null;
		}
		if (strIdentityProof==null || strIdentityProof==null)
		{
		strIdentityProof="";
		strIdentityProofNo="";
		}
		if (strIdentityProof.equals("-1"))
		{
		strIdentityProof="";
		strIdentityProofNo="";
		}


		String strLoginStatus = null;
		String strDisabledTime = null;
		String strRoleID = "OR";
		String strUUserID = null;
		String strUUserDate = null;
		String strApplicationID = "1";
		String strRecordType = "I";
		
		DbUtilityMethods DbId = new DbUtilityMethods(); 		
		
        strPassword  = DbId.decryptInDecimal(strPassword);     //decrypt the password in decimal without the random key
		String strDate ="";
		String strMonth = "";
		String strYear = "";

	//	 System.out.println("hi 3/2/2007");
                                     
		boolean chkUser=true;
		boolean chkUser1=false,chkUseremp1=false;
		//chkUser = validateEmailID(strEmail);                      //commented by shiv on 3/22/2007
		//trim() function added by manoj chand on 19 aug 2013 to remove left and right spaces.
		chkUser1 = validateUserName(strUserName.trim());
		chkUseremp1 = validateEmpcode(strEmpCode,strSite);
		//System.out.println("hi 3/2/2007"+ chkUseremp1);
		if (chkUser1 == false)
		{
			if(strCloseFlag != null && strCloseFlag.equalsIgnoreCase("inside"))
			{
				strUrl = "/M_UserRegisterByAdmin.jsp?flag=redundantUserName";
			}
			else
			{
				strUrl = "/M_UserRegister.jsp?flag=redundantUserName";
			}
			dispatch(request, response, strUrl);
		}
		else if(chkUser == false)
		{
			if(strCloseFlag != null && strCloseFlag.equalsIgnoreCase("inside"))
			{
				strUrl = "/M_UserRegisterByAdmin.jsp?flag=redundantEmail";
			}
			else
			{
				strUrl = "/M_UserRegister.jsp?flag=redundantEmail";
			}
			dispatch(request, response,strUrl);
		}

         // checking for empcode 3/2/2007
		 else if(chkUseremp1 == false)
		{
			if(strCloseFlag != null && strCloseFlag.equalsIgnoreCase("inside"))
			{
				strUrl = "/M_UserRegisterByAdmin.jsp?flag=redundantEmpcode";
			}
			else
			{
				strUrl = "/M_UserRegister.jsp?flag=redundantEmpcode";
			}
			dispatch(request, response,strUrl);
		}
	
		//
			 

		else 
		{
			if ("".equals(strPassport_issue_date) ) {
				strPassport_issue_date = null;			
			}			
			if ("".equals(strPassport_expire_date)) {
				 strPassport_expire_date = null;
			}

			if ("".equals(strPassport_DOB)) {
				 strPassport_DOB = null;
		}
		try
		{        

           DataSource ds;
	       Context ic = null;  
		   //Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		   //conn = DriverManager.getConnection("jdbc:odbc:star","wfp","#mind@pms9211");
		   dbConBean  = new DbConnectionBean();
		   conn  = dbConBean.getConnection();                      //Get the Connection
			

		   //ic = new InitialContext();
           //ds = (javax.sql.DataSource)ic.lookup("java:comp/env/jdbc/star");
		   //conn = ds.getConnection();     
		   conn.setAutoCommit(false);
           int  iUserID = DbId.getNewGeneratedId("USER_ID");              //Generate the new User_Id
		  	CallableStatement objCstmt = null;			    // Object for Callable Statement
			objCstmt  =  conn.prepareCall("{call PROC_USER_INSERT_PROFILE(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); //PROCEDURE TO insert user details
			objCstmt.setInt(1,iUserID);
			objCstmt.setString(2, strUserName);
		    objCstmt.setString(3, strPassword);
			objCstmt.setString(4, strQuest_secret);
			objCstmt.setString(5, strAns_secret);
			objCstmt.setString(6, strFirstName);	
			objCstmt.setString(7, strLastName);
 
			objCstmt.setString(8, strEmail); 
			objCstmt.setString(9, strDivision);
			objCstmt.setString(10, strSite);
			objCstmt.setString(11, strDepartment);
			objCstmt.setString(12, strDesignation);
			objCstmt.setString(13, strCUsesrId);
			objCstmt.setString(14, strReportTo);
			objCstmt.setString(15, strPassport_No);
			objCstmt.setString(16, strPassport_issue_date);
			objCstmt.setString(17, strPassport_expire_date);
			objCstmt.setString(18, strPassport_issue_place); 
			objCstmt.setString(19, strPassport_address);
			objCstmt.setString(20, strPassport_Contact_No);	
			objCstmt.setString(21, strPassport_flight_No);
			objCstmt.setString(22, strPassport_flight_No1);
			objCstmt.setString(23, strPassport_flight_No2);
			objCstmt.setString(24, strPassport_ECNR);
			objCstmt.setString(25, strPassport_DOB);
			

			//NEW 16-02-2007 SACHIN
			objCstmt.setString(26,strCurrentAddress.trim());
			objCstmt.setString(27,strAirLineName.trim());
			objCstmt.setString(28,strAirLineName1.trim());
			objCstmt.setString(29,strAirLineName2.trim());

			//2/28/2007
			objCstmt.setString(30,strEmpCode.trim());
             //2/28/2007
            //@Vijay on 20/04/2007
			objCstmt.setString(31,strGender.trim());

			//added on 18 -Oct -2007  by Shiv Sharma 
			objCstmt.setString(32,strIdentityProof.trim());
			objCstmt.setString(33,strIdentityProofNo.trim());
			// ADDED NEW ON ON 12 JAN 2009 FOR ADDING MIDDLE NAME BY SHIV SHARMA 
			objCstmt.setString(34,strmiddleName.trim());
			
			//ADDED NEW ON ON 12 JAN 2009 FOR window user id and Domain name NAME BY SHIV SHARMA
			objCstmt.setString(35,strDomainName.trim());
			objCstmt.setString(36,strWinUserID.trim());
			objCstmt.setString(37,strIpAddress);
			// Added Nationality fro MATA GmbH on 8th June,2015 by Sandeep Malik
			objCstmt.setString(38,strNationality);
			objCstmt.setString(39,strDeptHead);
			//Added on 3-Dec-2015  by Mukesh Mishra
			objCstmt.setString(40, strPassport_flight_No3);
			objCstmt.setString(41, strPassport_flight_No4);
			objCstmt.setString(42, strAirLineName3.trim());
			objCstmt.setString(43, strAirLineName4.trim());
			objCstmt.setString(44, hotelNumber);
			objCstmt.setString(45, hotelNumber1);
			objCstmt.setString(46, hotelNumber2);
			objCstmt.setString(47, hotelNumber3);
			objCstmt.setString(48, hotelNumber4);
			objCstmt.setString(49, hotelChain.trim());
			objCstmt.setString(50, hotelChain1.trim());
			objCstmt.setString(51, hotelChain2.trim());
			objCstmt.setString(52, hotelChain3.trim());
			objCstmt.setString(53, hotelChain4.trim());
			objCstmt.setString(54, strPassportIssuingCountry);
			
			//System.out.println("before execute update");	
			int intSuccess =  objCstmt.executeUpdate();
			//System.out.println("aftere execute update"+intSuccess);
			objCstmt.close();
			conn.commit();
		
			//System.out.println("language-->"+langselected);
            strUrl = "M_UserRegisterConfirmation.jsp?flag=success&ID="+URLEncoder.encode(strUserName, "UTF-8")+"&userId="+iUserID+"&siteId="+strSite+"&closeFlag="+strCloseFlag+"&langselected="+langselected;
		   //includeFile(request, response, "/T_MailOnUserRegistration.jsp?userId="+iUserID);
		   response.sendRedirect(strUrl);
		}
		catch (Exception e) 
		{
		  System.out.println("Insertion !Error in RegisterUser.java========0========= "+e);
		  e.printStackTrace();
			try 
			{
			   conn.rollback();
			}
			catch (Exception ex) 
			{
				System.out.println("Error in RegisterUser.java======1========="+ex);
			}
			if(strCloseFlag != null && strCloseFlag.equalsIgnoreCase("inside"))
			{
				strUrl = "M_UserRegisterByAdmin.jsp?flag=failure&closeFlag="+strCloseFlag;
			}
			else
			{
				strUrl = "M_UserRegister.jsp?flag=failure&closeFlag="+strCloseFlag;
			}
		    response.sendRedirect(strUrl);
		}
		finally 
		{
			try 
			{
				conn.close();
			} 
			catch (Exception e) 
			{
				System.out.println("Error in RegisterUser.java=====2=========="+e);
			}
		}
		}
		
	}

	public void doGet(HttpServletRequest request,HttpServletResponse response)
	throws ServletException, IOException {
		doPost(request , response);

	}

	// method for validating redundant EMailID	
/*					boolean validateEmailID (String strEmail )
					{
						//boolean mailFlag = false;
						boolean mailFlag = true;
						try
						{
							dbConBean  = new DbConnectionBean();
							conn = dbConBean.getConnection();              //Get the Connection
						   //Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
						   //conn = DriverManager.getConnection("jdbc:odbc:star","wfp","#mind@pms9211");
						   //conn.setAutoCommit(false);
						   //stmt = conn.createStatement();
						   //String sql = "Select [USERNAME] from M_USERINFO where APPLICATION_ID = 1 AND STATUS_ID=10";
						   //Check email_id, it should not be same as any previous email_id
						   String sql = "Select [EMAIL] from M_USERINFO where APPLICATION_ID = 1 AND STATUS_ID=10";
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
						  System.out.println("Insertion!Error in validateEmailID of RegisterUser.java=============== "+e);
						  e.printStackTrace();
						}finally {
							try {				
								conn.close();
							} catch (Exception e) {	}
						}   
						return mailFlag;
					}*/

     /// validation for emp code 
	  
	// method for validating redundant EMailID	
	boolean validateEmpcode(String strEmpCode,String strSiteId )
	{
		boolean empFlag = false;
		try
		{
			dbConBean  = new DbConnectionBean();
			conn = dbConBean.getConnection();              //Get the Connection
		   //Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		   //conn = DriverManager.getConnection("jdbc:odbc:star","wfp","#mind@pms9211");
		   //conn.setAutoCommit(false);
		   //stmt = conn.createStatement();
		   //String sql = "Select [USERNAME] from M_USERINFO where APPLICATION_ID = 1 AND STATUS_ID=10";
		   //Check email_id, it should not be same as any previous email_id
		   String sql = "Select ISNULL(EMP_CODE,'') AS EMP_CODE from M_USERINFO where SITE_ID="+strSiteId+" AND APPLICATION_ID = 1 AND STATUS_ID=10";
		   rs = dbConBean.executeQuery(sql);
		   while (rs.next()) 
		   {   
			  if (strEmpCode.equalsIgnoreCase(rs.getString(1)))
			  {    
				  return false;
			  }
		   } 
		   rs.close();

		   empFlag = true;
		}
		catch (Exception e) 
		{
		  System.out.println("Insertion!Error in validateEmpcode of RegisterUser.java=============== "+e);
		  e.printStackTrace();
		}finally {
			try {				
				conn.close();
			} catch (Exception e) {	}
		}
		return empFlag;
	}



       

	 ///


	// method for validating redundant USERNAME(LOGIN NAME)	
	boolean validateUserName(String strUserName )
	{
		boolean userNameFlag = false;
		try
		{
			dbConBean  = new DbConnectionBean();
			conn = dbConBean.getConnection();              //Get the Connection
		   //Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		   //conn = DriverManager.getConnection("jdbc:odbc:star","wfp","#mind@pms9211");
		   //conn.setAutoCommit(false);
		   //stmt = conn.createStatement();
		   //String sql = "Select [USERNAME] from M_USERINFO where APPLICATION_ID = 1 AND STATUS_ID=10";
		   //Check email_id, it should not be same as any previous email_id
		   String sql = "Select [USERNAME] from M_USERINFO where APPLICATION_ID = 1 AND STATUS_ID=10";
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
		  System.out.println("Insertion!Error in validateUserName() of  RegisterUser.java=============== "+e);
		  e.printStackTrace();
		}finally {
			try {				
				conn.close();
			} catch (Exception e) {	}
		}
		return userNameFlag;
	}



	// Dispatcher for forwarding request
	private void dispatch(HttpServletRequest req, HttpServletResponse res, String url)throws ServletException, IOException 
	{
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
		dispatcher.forward(req, res);
	}	

	// Dispatcher for Including request
	/*private void includeFile(HttpServletRequest req, HttpServletResponse res, String url)throws ServletException, IOException 
	{
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
		dispatcher.include(req, res);
	}*/	

}


