<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:24 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is second jsp file  for updating the M_USERINFO in the STAR Database
 *Modification 			: Email  is not mendatory
 *Reason of Modification: 1.To refresh the Session Variable sGender with the current value
                           2. code added for updating the user those are in deactivated user List  by shiv sharma on 23-May-07
						   3. Code added by shiv for adding identity field  on 23-Oct-07 
						   4. Added  new fields for windows user id,domian id flag on 05-02-2009 by shiv sharma
 *Date of Modification  : 1. 3/23/2007 by shiv 
						  2. 15-May-2007 
 *Modification By  		: 1. Shiv Sharma
						  2. Gaurav Aggarwal  	
 *Editor				:Editplus
 
 *Modified By					:Manoj Chand
 *Date of Modification			:14 August 2012
 *Modification					:save workflow role to m_userinfo table.
 
 *Modified By					:Manoj Chand
 *Date of Modification			:19 Sept 2012
 *Modification					:showing alert regarding profile deactivation to user after that redirect to login screen.
 *******************************************************/
%>

<%@ include  file="importStatement.jsp" %>
<%@ page pageEncoding="UTF-8"%>

<%@page import="java.net.URLEncoder"%>
<html>
<head>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%@ include  file="systemStyle.jsp" %>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<!--Create the DbUtilityMethods object for utility methods-->
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
</head>


<%
request.setCharacterEncoding("UTF-8");
    // Global Variables declared and initialized
	Connection objCon				    = null;			    // Object for connection
    ResultSet objRs,rs		            = null;			    // Object for ResultSet
    CallableStatement objCstmt		    = null;			    // Object for Callable Statement
	int intSuccess                      = 0; 
	String strUrl                       = "";
	String strSql                       = "";
	String strMessage                   = "";  

    String strUserId                    = "";     //Get the User Id
	String strFirstName                 = "";
	String strLastName                  = "";
	//2/28/2007
	String strEmpcode                  = "";
	//2/28/2007
	String strEmail                     = "";
	String strDivId                     = "";
	String strSiteId                    = "";	
	String strDeptId                    = "";
	String strDesigId                   = "";

	String strReportTo                  = "";      // when user not select any new report to userid
	String strReportTo1                 = "";      //this use for new ReportTo userid
	String strDeptHead                  = "";      // when user not select any new report to userid
	String strSecretQuestion            = "";
	String strSecretAnswer              = "";
	String strPassportNo                = "";
	String strPassportIssuingCountry	= "";
	String strDateOfIssue               = "";
	String strEcnr                      = "";
	String strExpiryDate                = "";
	String strFfNo                      = "";
	String strFfNo1                     = "";
	String strFfNo2                     = "";
	String strGender					= "";
	String strLanguage					= "en_US";
	String strIpAddress = request.getRemoteAddr();
	
	strLanguage= request.getParameter("language")== null ? "en_US" : request.getParameter("language");
	if(strLanguage.equals("-1"))
		strLanguage="en_US";
	//new 16-02-2007
	String strCurrentAddress	=	request.getParameter("current_address")== null ? "" : request.getParameter("current_address");
	String strAirLineName		=	request.getParameter("airLineName")== null ? "" : request.getParameter("airLineName");
	String strAirLineName1		=	request.getParameter("airLineName1")== null ? "" : request.getParameter("airLineName1");
	String strAirLineName2		=	request.getParameter("airLineName2")== null ? "" : request.getParameter("airLineName2");

	//Added new for getting identity proof and is no 22-Oct-07
	String strIdentityProof = request.getParameter("identityProof")== null ? "" : request.getParameter("identityProof");
	String strIdentityProofNo = request.getParameter("identityproofno")== null ? "" : request.getParameter("identityproofno");

	//Added  new fields for windows user id,domian id flag on 05-02-2009 by shiv sharma
	String strWinUserID  = request.getParameter("winUserID")== null ? "" : request.getParameter("winUserID");
	String strDomainName = request.getParameter("domainname")== null ? "" : request.getParameter("domainname");
	
	String strPlaceOfIssue              = "";
	String strDob                       = "";
	String strAddress                   = "";
	String strContactNo                 = "";

	//New
	StringBuffer strModifiedFields      =  new StringBuffer();  
	String strFirstName_Old             = "";
	String strLastName_Old              = "";
	String strSiteId_Old                = "";	
	String strDeptId_Old                = "";
	String strDesigId_Old               = "";
	String strDob_Old                   = "";
	String strEmpcode_old               = "";
	String strmiddleName				="";
	String strSpRole					="0";

	String strStatusId                  = "10";   //Default Value

	//added  new code on 23-May-07 open  
	String strDeactiveflag  ="";
	
	String strCostCentre					=  "0"; 
	
    strDeactiveflag  = request.getParameter("Deactiveflag"); 
    //added  new code on 23-May-07 open 

	strUserId                           =  request.getParameter("userId"); 
	if(strUserId == null)
    {
       strUserId = Suser_id;    // Suser_id is login person userid
    }

	strFirstName                        =	request.getParameter("firstName");
	strmiddleName                        =	request.getParameter("middleName");
	
    strLastName                         =	request.getParameter("lastName");
     ///2/28/2007
	strEmpcode							=	request.getParameter("empcode")==null?"":request.getParameter("empcode").trim(); 
   ///2/28/2007  
	strEmail                            =	request.getParameter("email")==null?"":request.getParameter("email").trim();

	strGender							=	request.getParameter("gender");//add by vijay on 20/04/2007

    strDivId                            =	request.getParameter("division");
	strSiteId                           =	request.getParameter("site"); 
	strDeptId                           =	request.getParameter("department");
	strDesigId                          =	request.getParameter("designation");
	strReportTo                         =	request.getParameter("repTo");
	strDeptHead							=	request.getParameter("deptHeadUserId");

    strReportTo1                        =  request.getParameter("repToUserId");
	if(strReportTo1 == null || strReportTo1.equals("s1"))
	{
	}
	else
	{
		strReportTo = strReportTo1;
	}
	
		strSecretQuestion                   =  request.getParameter("quest_secret1").trim();

		//@ Vijay Singh 11/04/2007 for secret question 
		String	strHiddenQuest_secret=request.getParameter("question_other").trim();
		if(!strHiddenQuest_secret.equals("-"))
		{
			strSecretQuestion=strHiddenQuest_secret;
		}


	strSecretAnswer                     =  request.getParameter("secretAnswer");
	strPassportNo                       =  request.getParameter("passportNo");
	strPassportIssuingCountry			=  request.getParameter("pp_issu_Country")==null ? "0":request.getParameter("pp_issu_Country").trim();
	strDateOfIssue                      =  request.getParameter("dateOfIssue");
	strEcnr                             =  request.getParameter("ecnr");
	strExpiryDate                       =  request.getParameter("expireDate");
	strFfNo                             =  request.getParameter("ffNo");
	strFfNo1							=  request.getParameter("ffNo1");
	strFfNo2							=  request.getParameter("ffNo2");
	strPlaceOfIssue                     =  request.getParameter("placeOfIssue");
	strDob                              =  request.getParameter("dateOfBirth");
	strAddress                          =  request.getParameter("address")==null?"":request.getParameter("address").trim();
	strContactNo                        =  request.getParameter("contactNo");
	strSpRole							=  request.getParameter("sp_role")==null?"0":request.getParameter("sp_role");
	
	String nationality					=  request.getParameter("nationality")==null?"":request.getParameter("nationality").trim();
	strCostCentre 						=  request.getParameter("costcentre")==null?"0":request.getParameter("costcentre");
	//System.out.println("strSpRole--m_updateprofielpost--->"+strSpRole);

	if(strPassportNo != null && strPassportNo.equals("")) {
		strPassportIssuingCountry = null;
	}
	if(strDateOfIssue != null && strDateOfIssue.equals(""))
	{
		strDateOfIssue = null;
	}
	if(strPlaceOfIssue != null && strPlaceOfIssue.equals(""))
	{
		strPlaceOfIssue = null;
	}
	if(strDob != null && strDob.equals(""))
	{
		strDob = null;
	}
	
	if(strCostCentre.equals("")) {
		strCostCentre ="0"; 
    }
    //Mukesh Mishra
   String strFfNo3 =  request.getParameter("ffNo3")==null?"":request.getParameter("ffNo3");
   String strFfNo4 =  request.getParameter("ffNo4")==null?"":request.getParameter("ffNo4");
	String strAirLineName3		=	request.getParameter("airLineName3")== null ? "" : request.getParameter("airLineName3");
	String strAirLineName4		=	request.getParameter("airLineName4")== null ? "" : request.getParameter("airLineName4");
	String hotelChain				=request.getParameter("hotelChain")== null ? "" : request.getParameter("hotelChain");
	String hotelChain1				=request.getParameter("hotelChain1")== null ? "" : request.getParameter("hotelChain1");
	String hotelChain2				=request.getParameter("hotelChain2")== null ? "" : request.getParameter("hotelChain2");
	String hotelChain3				=request.getParameter("hotelChain3")== null ? "" : request.getParameter("hotelChain3");
	String hotelChain4				=request.getParameter("hotelChain4")== null ? "" : request.getParameter("hotelChain4");
	String hotelNumber				=request.getParameter("hotelNumber")== null ? "" : request.getParameter("hotelNumber");
	String hotelNumber1				=request.getParameter("hotelNumber1")== null ? "" : request.getParameter("hotelNumber1");
	String hotelNumber2				=request.getParameter("hotelNumber2")== null ? "" : request.getParameter("hotelNumber2");
	String hotelNumber3				=request.getParameter("hotelNumber3")== null ? "" : request.getParameter("hotelNumber3");
	String hotelNumber4				=request.getParameter("hotelNumber4")== null ? "" : request.getParameter("hotelNumber4");
	
	String travelAgencyId			= "";
	strSql = "select TRAVEL_AGENCY_ID from M_SITE where SITE_ID="+strSiteId;
	rs     = dbConBean.executeQuery(strSql);
	if(rs.next()) {
		travelAgencyId = rs.getString("TRAVEL_AGENCY_ID");
	}
	rs	   = null;
	strSql = "";
	
	//NEW
	if(!(SuserRoleOther.trim().equals("LA")) && !(SuserRole.trim().equals("AD")))
	{
		strSql = "SELECT RTRIM(LTRIM(FIRSTNAME)) AS FIRSTNAME, RTRIM(LTRIM(LASTNAME)) AS LASTNAME, SITE_ID,DEPT_ID, DESIG_ID,ISNULL(.DBO.CONVERTDATEDMY1(DOB),'') AS DOB, ISNULL(EMP_CODE,'') AS EMP_CODE,sp_role FROM M_USERINFO WHERE USERID="+strUserId+" AND STATUS_ID=10";
		rs     = dbConBean.executeQuery(strSql);
		if(rs.next())
		{
			strFirstName_Old             = rs.getString("FIRSTNAME");
			strLastName_Old              = rs.getString("LASTNAME");
			strSiteId_Old                = rs.getString("SITE_ID");	
			strDeptId_Old                = rs.getString("DEPT_ID");
			strDesigId_Old               = rs.getString("DESIG_ID");
			strDob_Old                   = rs.getString("DOB");

             //2/28/2007
			//strEmpcode              = rs.getString("EMP_CODE")			;
			strEmpcode_old              = rs.getString("EMP_CODE") ;
			strSpRole				= rs.getString("SP_ROLE");
			//System.out.println("strSpRole--m-update--->"+strSpRole);
			 // 2/28/2007

			if((strFirstName_Old != null && strFirstName !=null && !strFirstName_Old.equals(strFirstName))
							||(strFirstName_Old != null && strFirstName ==null)
							||(strFirstName_Old == null && strFirstName !=null)  )
			{
				strModifiedFields.append("FIRSTNAME;");		
				strStatusId = "30";
			}
			if((strLastName_Old != null && strLastName !=null && !strLastName_Old.equals(strLastName))
							||(strLastName_Old != null && strLastName ==null)
							||(strLastName_Old == null && strLastName !=null)  )
			{
				strModifiedFields.append("LASTNAME;");		
				strStatusId = "30";
			}
			if((strSiteId_Old != null && strSiteId !=null && !strSiteId_Old.equals(strSiteId))
							||(strSiteId_Old != null && strSiteId ==null)
							||(strSiteId_Old == null && strSiteId !=null)  )
			{
				strModifiedFields.append("SITE_ID;");		
				strStatusId = "30";
			}
			
			if(!travelAgencyId.equals("2")) {
				if((strDeptId_Old != null && strDeptId !=null && !strDeptId_Old.equals(strDeptId))
								||(strDeptId_Old != null && strDeptId ==null)
								||(strDeptId_Old == null && strDeptId !=null)  ) {
					strModifiedFields.append("DEPT_ID;");		
					strStatusId = "30";
				}
			}
             //2/28/2007
            
			if(strEmpcode_old.equals(""))
			{
			}
			else if((strEmpcode_old != null && strEmpcode !=null && !strEmpcode_old.equals(strEmpcode))
							||(strEmpcode_old != null && strEmpcode ==null)
							||(strEmpcode_old == null && strEmpcode !=null)  )
			{
				strModifiedFields.append("EMP_CODE;");		
				strStatusId = "30";
			}

			 /////

			if((strDesigId_Old != null && strDesigId !=null && !strDesigId_Old.equals(strDesigId))
							||(strDesigId_Old != null && strDesigId ==null)
							||(strDesigId_Old == null && strDesigId !=null)  )
			{
				strModifiedFields.append("DESIG_ID;");		
				strStatusId = "30";
			}
			if((strDob_Old != null && strDob !=null && !strDob_Old.equals(strDob))
							||(strDob_Old != null && strDob ==null)
							||(strDob_Old == null && strDob !=null)  )
			{
				strModifiedFields.append("DOB;");		
				strStatusId = "30";
			}
		}
		rs.close();
	}
//System.out.println("strModifiedFields on updateUserProfile==========="+strModifiedFields);
	//
   try
   {
	    boolean bProcFlag = true;
		String strOldEmailId = "";
		//String strOldEmpCode = "";

	    //this if block only for 'AD' and 'LA' because they have access to edit the email-id of the user
		if((SuserRoleOther.trim().equals("LA")) || (SuserRole.trim().equals("AD")))
	    {
			strSql = "SELECT RTRIM(LTRIM(EMAIL)) AS EMAIL, ISNULL(EMP_CODE,'') AS EMP_CODE FROM M_USERINFO WHERE USERID="+strUserId+" AND STATUS_ID=10";
			rs     = dbConBean.executeQuery(strSql);
			if(rs.next())
			{
				strOldEmailId = rs.getString("EMAIL");
				strEmpcode_old = rs.getString("EMP_CODE"); 
			}
			rs.close();

			if((strOldEmailId != null && strEmail !=null && !strOldEmailId.equals(strEmail))
							||(strOldEmailId != null && strEmail ==null)
							||(strOldEmailId == null && strEmail !=null)  )
			{
				//boolean chkEmail ;                                             
				//chkEmail = dbUtility.validateEmailID(strEmail);//remove by shiv on 3/23/2007
				/*if(chkEmail == false)
				{
					strMessage = "<Font color='red'>User Profile not updated. Email-Id already exist.</font>";
					bProcFlag = false;
				}*/
			}		
			
			//Check Emp Code
			if((strEmpcode_old != null && strEmpcode !=null && !strEmpcode_old.equals(strEmpcode))
							||(strEmpcode_old != null && strEmpcode ==null)
							||(strEmpcode_old == null && strEmpcode !=null)  )
			{
				String strEmpCodeFlag = "";
				strEmpCodeFlag = dbUtility.validateEmpcode(strEmpcode,strSiteId);
				if(strEmpCodeFlag.equals("exist"))
				{
					strMessage = dbLabelBean.getLabel("label.mylinks.userprofilenotupdated",strsesLanguage);
					bProcFlag = false;
				}
			}	
			
	    }
		//Create Connection    
		objCon               =  dbConBean.getConnection(); 
       
		  
        /// code added by shiv on 23-May-07 open--   
       if(strDeactiveflag.equals("1"))
	      {
          strStatusId="30";
	       }
      /// code added by shiv on 23-May-07 close-- 
      
		if(bProcFlag == true)
		{
			//System.out.println("**********inside if***********");
			//PARAMETER FOR UPDATING LANGUAGE IS ADDED BY MANOJ CHAND ON 22 MAY 2012
			objCstmt             =  objCon.prepareCall("{?=call PROC_UPDATE_USER_PROFILE(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");//PROCEDURE TO update THE M_UserInofo IN M_UserInfo TABLE
			objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			objCstmt.setString(2, strUserId);
			objCstmt.setString(3, Suser);
			objCstmt.setString(4, strFirstName);
			objCstmt.setString(5, strLastName);
			objCstmt.setString(6, strEmail);
			objCstmt.setString(7, strDivId);
			objCstmt.setString(8, strSiteId);
			objCstmt.setString(9, strDeptId);
			objCstmt.setString(10, strDesigId);
			objCstmt.setString(11, strReportTo);
			objCstmt.setString(12, strSecretQuestion);
			objCstmt.setString(13, strSecretAnswer);
			objCstmt.setString(14, strPassportNo);
			objCstmt.setString(15, strDateOfIssue);
			objCstmt.setString(16, strExpiryDate);
			objCstmt.setString(17, strFfNo); 
			objCstmt.setString(18, strFfNo1); 
			objCstmt.setString(19, strFfNo2); 
			objCstmt.setString(20, strEcnr);
			objCstmt.setString(21, strPlaceOfIssue);
			objCstmt.setString(22, strDob);
			objCstmt.setString(23, strAddress);
			objCstmt.setString(24, strContactNo);
			objCstmt.setString(25, Suser_id);                //set the current user Login UserId
			objCstmt.setString(26, strStatusId);                //set the login status id, if 10 for active and 30 for deactive


	//NEW 16-02-2007 SACHIN
			objCstmt.setString(27,strCurrentAddress.trim());
			objCstmt.setString(28,strAirLineName.trim());
			objCstmt.setString(29,strAirLineName1.trim());
			objCstmt.setString(30,strAirLineName2.trim());
				
            //           
	        ////2/28/2007 
            objCstmt.setString(31,strEmpcode.trim());
			////2/28/2007
			//@Vijay Singh add on 20/04/2007
			objCstmt.setString(32,strGender.trim());
          
		   // Added  new identity proof  No and ID on 10/18/2007 by shiv 
			objCstmt.setString(33,strIdentityProof.trim());
			objCstmt.setString(34,strIdentityProofNo.trim()); 
			objCstmt.setString(35,strmiddleName.trim()); // added new on 10 jan 2009 by shiv sharma 
			
			objCstmt.setString(36,strDomainName.trim()); // added new on 03 feb 2009 by shiv sharma
			objCstmt.setString(37,strWinUserID.trim()); // added new on 03 feb 2009 by shiv sharma 
			objCstmt.setString(38,strLanguage.trim());
			objCstmt.setInt(39,Integer.parseInt(strSpRole));
			objCstmt.setString(40,strIpAddress);
			objCstmt.setString(41, nationality);
			objCstmt.setString(42, strCostCentre);
			objCstmt.setString(43, strDeptHead);
			objCstmt.setString(44, strFfNo3); 
			objCstmt.setString(45, strFfNo4); 
			objCstmt.setString(46,strAirLineName3.trim());
			objCstmt.setString(47,strAirLineName4.trim());
			objCstmt.setString(48, hotelNumber);
			objCstmt.setString(49, hotelNumber1);
			objCstmt.setString(50, hotelNumber2);
			objCstmt.setString(51, hotelNumber3);
			objCstmt.setString(52, hotelNumber4);
			objCstmt.setString(53, hotelChain.trim());
			objCstmt.setString(54, hotelChain1.trim());
			objCstmt.setString(55, hotelChain2.trim());
			objCstmt.setString(56, hotelChain3.trim());
			objCstmt.setString(57, hotelChain4.trim());
			objCstmt.setString(58, strPassportIssuingCountry);

			//strWinUserID  
			//strDomainName 
			
			intSuccess =  objCstmt.executeUpdate();
			// @ Gaurav Aggarwal 15-May-2007 To refresh the Session Variable sGender with the current value
			if(intSuccess==1){
				hs.putValue("sGender",strGender);	
				Statement stmt = objCon.createStatement();
				stmt.executeUpdate("UPDATE M_USERINFO SET UPDATE_PROFILE_FLAG = 0 WHERE USERID="+strUserId);
			}
			//End of Code by Gaurav Aggarwal
			objCstmt.close();
		}
   }
   catch(Exception e)
   {
   	  strMessage = dbLabelBean.getLabel("label.mylinks.profilecouldnotbesaved",strsesLanguage);
	  System.out.println("Error in M_User_ProfileUpdate=="+e);
   }
  
   strUrl = "M_UpdateProfile.jsp?strMessage="+URLEncoder.encode(strMessage,"UTF-8") +"&userId="+strUserId;
   //System.out.println(">>>String URL>>>>"+strUrl);
   if(intSuccess > 0)
   {
	   strMessage = dbLabelBean.getLabel("label.mylinks.profilesuccessfullyupdated",strsesLanguage);
	   if(strStatusId != null && strStatusId.equals("10"))
	   {
		   strUrl = "M_UpdateProfile.jsp?strMessage="+URLEncoder.encode(strMessage,"UTF-8")+"&userId="+strUserId;
	   }
	   else if(strStatusId != null && strStatusId.equals("30") && !strDeactiveflag.equals("1"))
		   ///   changed by shiv adding strDeactiveflag on 23-May-07
	   {

		//Find the local admin userid of the site
			String strLocalAdminUserId = "";
			boolean bRoleFlag          = false;    
			String strSendStatus       = "no";  // for find when mail goes to Local admin or not
			strSql = "SELECT USERID FROM M_USERROLE WHERE SITE_ID="+strSiteId+" AND STATUS_ID=10";
			objRs = dbConBean.executeQuery(strSql);
			while(objRs.next())
			{
				strLocalAdminUserId = objRs.getString("USERID");	
				try
				{
					bRoleFlag = dbUtility.findUserRole(strLocalAdminUserId,"LA");//find user role From M_USERROLE table
					if(bRoleFlag == true)
					{
		%>			
						 <jsp:include page="T_MailOnUpdateProfile.jsp" >
							<jsp:param name="registerUserId" value="<%=strUserId%>"/>
							<jsp:param name="registerUserSiteId" value="<%=strSiteId%>"/>
							<jsp:param name="localAdminUserId" value="<%=strLocalAdminUserId%>"/>	    
							<jsp:param name="modifiedFields" value="<%=strModifiedFields%>"/>	    
						 </jsp:include>		
		<%		
						 bRoleFlag = false; 	
						 strSendStatus = "yes";
					}			
				}
				catch(Exception e)
				{
					System.out.println("Error in M_UpdateProfilePost.jsp  2 is======"+e);
				}
			}
			objRs.close();
		  		   //strUrl = "sessionExpired.jsp";
		  		   //change by manoj chand on 19 sept 2012 to show alert message before showing login screen.
             strUrl = "M_UpdateProfile.jsp?Message=deactivated&userId="+strUserId+"&Deactiveflag="+strDeactiveflag+"&siteid="+strSiteId;
		    }
	   else   ////code added by shiv on 23-May-07 open 
	   { 
	        strMessage = dbLabelBean.getLabel("label.mylinks.profilesuccessfullyupdated",strsesLanguage);
		  //strUrl = "M_UpdateProfile.jsp?strMessage="+strMessage+"&userId="+strUserId;
		   		   strUrl = "M_UpdateProfile.jsp?strMessage="+URLEncoder.encode(strMessage,"UTF-8")+"&userId="+strUserId+"&Deactiveflag="+strDeactiveflag;
	   }      ////code added by shiv on 23-May-07 close
   }  

   dbConBean.close();          //CLOSE ALL CONNECTIONS 
   response.sendRedirect(strUrl);    
   
%>

