	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				             :Shiv sharma 
	 *Date of Creation 	         :
	 *Copyright Notice 		     :Copyright(C)2000 MIND.All rights reserved
	 *Project	  			             :STARS
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 		     	    : This is post page of  jsp file  for create the Travel Requsition
	 *Modification 	    	    :  added code for checking if appro ver is exits in defualt approver list on 19-01-2009 
								  1 . Added on 28 may 2009 for stoping mail when use referesh the page  
								  2://added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma 
							             
	 *Reason of Modification:
	 *Date of Modification  :
	 *Modified By	  :			:by vaibhav on sep 15 2010 to remove error in case of duplicate approvers
	 *Modified By	  :			Pankaj Dubey on 11 Nov 2010 to add 5 new fields to record budgetory figures.
	 
	 *Editor				:Editplus
	 
	 *Modified by	  : Manoj Chand	
	 *Date of Modification: 16-mar-2011
	 *Reason of Modification	:Second approver level name comes twice in approver list although he is also in default approver for domestic group request.
	 
	 *Modified by	  : Manoj Chand	
	 *Date of Modification: 29-mar-2011
	 *Reason of Modification	:for group request created by unit head, his name was not coming in the workflow
	 
	 *Modified by	  : Manoj Chand	
	 *Date of Modification: 05-Oct-2011
	 *Reason of Modification	:remove remarks from this page
	 
	 *Modified by	  : Manoj Chand	
	 *Date of Modification: 22-Nov-2011
	 *Reason of Modification	:change label notSave to Not Saved
	 
	 *Modification				:Add Board Member for SMP in Group/Guest domestic requests  
	 *Modified by				:Manoj Chand
	 *Date of Modification		:29 Mar 2012
	 
	 *Modified By	        	:MANOJ CHAND
	 *Date of Modification  	:19 OCT 2012
	 *Description				:IMPLEMENT SITE WISE FLAG TO SHOW BOARD MEMBER IN SMP
	 
	 *Modified By	        	:MANOJ CHAND
	 *Date of Modification  	:29 NOV 2012
	 *Description				:IMPLEMENT TOTAL TRAVEL FARE FOR SMP SITE
	 
	 *Modified By	        	:MANOJ CHAND
	 *Date of Modification  	:22 Mar 2013
	 *Description				:change position of board member from second last to after approver 1 and 2 in approver list
	 
	 *Modified By				:Manoj Chand
	 *Date of Modification		:24 July 2013
	 *Modification				:Mandatory seletion of approval level 1 and 2 for mssl site. duplicate approver name will not come in approver list
	 *******************************************************/
	 
	%>
	<%@ page  import="java.net.URLEncoder" %>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Create Group/Guest Travel Request</title>
	<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	</head>
	
	<!-- all include files with sesstion variables -->
	
	<%-- Import Statements  --%>
	<%@ include  file="importStatement.jsp" %>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %>
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean2" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />
	<jsp:useBean id="mailDaoImpl" scope="page" class="src.dao.MailDaoImpl"/>
	<!-- script used in files  -->
	
	<script language="JavaScript" src="style/pupdate.js?buildstamp=2_0_0"></script>
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
	<script language="JavaScript" src="scripts/BackSpaceDisable.js?buildstamp=2_0_0"></script>
	<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
	<!-- <SCRIPT language="JavaScript" src="LocalScript/M_InsertProfile.js?buildstamp=2_0_0"></SCRIPT> -->
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<%--@ include file="M_InsertProfile.jsp"  --%>
	<%
	
	request.setCharacterEncoding("UTF-8");
	
	 int intSuccess1				   =0;
	 int intSuccess2                 =0;		
	 int intSuccess4                 =0;
	 int intSuccess3                 =0;  
	 int intSuccess6                 =0;
	
	 int intSuccess8                 =0;
	 int intSuccess10				=0;
	
	   String url                          =  ""; 
	
	   String strInterimId            ="";
	
	
	String strSql                        =  null;            // String for Sql String
	Connection objCon               =  null;            //Object for Connection 
	Connection objCon1,con3              =  null;            //Object for Connection 
	ResultSet rs,rs1,rs2,rs3            =  null;            // Object for ResultSet
	CallableStatement objCstmt	    =  null;		    // Object for Callable Statement
	Statement stmt,st3					=  null;
	src.connection.DbConnectionBean db11 = null;
	src.travelBean.TravelBean travelBean1      =  null;  
	
	 
	String strTravelReqId            ="";
	String strTravelId			     ="";
	String strTravelReqNo		 	 ="";	
	String strDepCity		         ="";
	String strArrCity		         ="";
	String strDepDate		         ="";
	String strPreferTime             ="";
	String strTravelMode             ="";
	String strNameOfAirline          ="";
	String strTravelClass            ="";
	String strManagerId              ="";
	String  strHodId                 ="";
	String strBoardMemberId     	 ="";
	String strHidAppFlag			 ="";
	String strHidAppShowBMFlag		 ="";
	String strDeptDate				 ="";
	String strReasonForSkip          ="";
	String strReasonForTravel        ="";	
	String  strBilling				 =""; 
	String strBillingSMGSite         ="";
	String strBillingSMGUser	     ="";	
	String strCashBreakupRemarks     ="";
	
	// below 5 fields added by Pankaj on 11 Nov 10
	String dbl_YTM_BUDGET = "";
	String dbl_YTD_ACTUAL = "";
	String dbl_AVAIL_BUDGET = "";
	String dbl_EST_EXP = "";
	String str_EXP_REMARKS = "";
	
	
	String strTravelType             ="D";
	String strApproveStatus          ="0"; 
	String strUserRole				 ="";
	String strTravellerId			 =Suser_id;
	 
	int  intCounter					 =0;
	String strApproverId			 ="";
	String strApproverRole			 ="";
	String strApproverOrderId        ="";
	String strBillClient		     ="";
	int  intSuccess5			     =0;
	String strMessage			     ="";	
	String strTravellerRole	     	 ="";		
	String strApprove_Id			 ="";
	String strUnitHead			     ="0";
	String strOrignatorAge			 ="";
	String  strOrignatorSex			 ="";
	String strWhatAction			 ="";
	String strPermanent_Req_No       ="";        //Var for Permanent Requition No.  
	String strExpenditureRemarks     ="";
	String strTravllerSiteId         ="";
	String strForTatkaalRequired	 ="";
	String strForCoupanRequired		 ="";
	String strfwdForTatkaalRequired	 ="";
	String strfwdForCoupanRequired	 =""; 
	String strCancelledReqId		 ="0";
	
	
	
	String flag								="1";
	ArrayList approverList            =  new ArrayList();
	ArrayList approverList1          =  new ArrayList();
	
	
//added by manoj chand on 22 Nov 2011 to fetch non-mata resource parameter	
	
	String strTkAgent 		=""; 
	String strTkAirLine 	=""; 
	String strTkcurrency 	=""; 
	String strTklocalprice 	=""; 
	String strTkRemarks 	=""; 
	
	 String strmataprice =request.getParameter("matapricecomp"); 

	if(strmataprice.equalsIgnoreCase("y")){ 
		
	 strTkAgent 			=request.getParameter("tkflyes");
	 strTkAirLine 			=request.getParameter("airline");
	 strTkcurrency 			=request.getParameter("currency");
	 strTklocalprice 		=request.getParameter("localprice"); 
	 strTkRemarks 			=request.getParameter("pricingRemarks"); 
	 
	}
	
	
	
	
	
	
	//rettravelMode
	//added by manoj
	String strSiteid=request.getParameter("hiddsiteid")==null?strSiteIdSS:request.getParameter("hiddsiteid");
	//System.out.println("group itinery post hidsiteid---->"+strSiteid);
	  
	strWhatAction				=  request.getParameter("whatAction");   // from hidden field
	strTravelReqId				=  request.getParameter("travelReqId")==null ?"" :request.getParameter("travelReqId");    // from hidden field
	strTravelId					=  request.getParameter("travelId")==null ?"" :request.getParameter("travelId");                 // from hidden field
	strTravelReqNo				=  request.getParameter("travelReqNo")==null ?"" :request.getParameter("travelReqNo") ;    // for hidden field
	strDepCity					=  request.getParameter("depCity")==null ?"" :request.getParameter("depCity").trim();       
	strArrCity					=  request.getParameter("arrCity")==null ?"" :request.getParameter("arrCity").trim();        
	strDepDate					=  request.getParameter("depDate")==null ?"" :request.getParameter("depDate").trim();       
	strPreferTime               =  request.getParameter("preferTime")==null ?"" :request.getParameter("preferTime").trim();        
	strTravelMode               =  request.getParameter("rettravelMode")==null ?"" :request.getParameter("rettravelMode").trim();      
	strNameOfAirline            =  request.getParameter("nameOfAirline")==null ?"" :request.getParameter("nameOfAirline").trim();       
	strTravelClass              =  request.getParameter("travelClass")==null ?"" :request.getParameter("travelClass").trim();     
	strManagerId                =  request.getParameter("manager")==null ?"" :request.getParameter("manager").trim();       
	strHodId                    =  request.getParameter("hod")==null ?"" :request.getParameter("hod");
	//added by manoj chand on 28 March 2012 to fetch board member
	strBoardMemberId		 =  request.getParameter("boardmember");
	strHidAppFlag			 =  request.getParameter("hidGrAppLvl3flg");
	strHidAppShowBMFlag		=	request.getParameter("hidAppLvl3showbmflg");
	strDeptDate=request.getParameter("hiddeptDate")==null?"":request.getParameter("hiddeptDate");
	//added by manoj chand on 27 Nov 2012 to fetch Total Travel Fare Data
	String strTotalFareCurrency		=  request.getParameter("TotalFareCurrency")==null?"":request.getParameter("TotalFareCurrency");
	String strTotalFareAmount		=  request.getParameter("TotalFareAmount")==null?"0":request.getParameter("TotalFareAmount");
			
	strReasonForSkip            =  request.getParameter("reasonForSkip")==null ?"" :request.getParameter("reasonForSkip").trim();      
	strReasonForTravel          =  request.getParameter("reasonForTravel")==null ?"" :request.getParameter("reasonForTravel").trim();       
	strBilling					=  request.getParameter("billing")==null ?"":request.getParameter("billing");      
	//strBilling  may be outSideSMG or  SMG
	
	strBillingSMGSite			=  request.getParameter("billingSMGSite")==null ?"" :request.getParameter("billingSMGSite");        
	strBillingSMGUser           =  request.getParameter("billingSMGUser")==null ?"" :request.getParameter("billingSMGUser");
	//System.out.println("strBillingSMGSite------->"+strBillingSMGSite);
	//System.out.println("strBillingSMGUser------->"+strBillingSMGUser);
	
	strExpenditureRemarks       =  request.getParameter("expRemarks");  
	strCashBreakupRemarks       =  request.getParameter("cashBreakupRemarks")==null ?"" :request.getParameter("cashBreakupRemarks");   
    
	dbl_YTM_BUDGET        		=  request.getParameter("YtmBud")==null?"0":request.getParameter("YtmBud");
	dbl_YTD_ACTUAL        		=  request.getParameter("YtmAct")==null?"0":request.getParameter("YtmAct");
	dbl_AVAIL_BUDGET        	=  request.getParameter("AvailBud")==null?"0":request.getParameter("AvailBud");
	dbl_EST_EXP        			=  request.getParameter("EstExp")==null?"0":request.getParameter("EstExp");
	str_EXP_REMARKS        		=  request.getParameter("budgetRemarks")==null?"":request.getParameter("budgetRemarks");
	
	//For forward 
	strfwdForTatkaalRequired    =  request.getParameter("fwdforTatkaalRequired")==null ?"" :request.getParameter("fwdforTatkaalRequired");   
	strfwdForCoupanRequired     =  request.getParameter("fwdforCoupanRequired")==null ?"" :request.getParameter("fwdforCoupanRequired");   
	//for return 
	strForTatkaalRequired   	=  request.getParameter("forTatkaalRequired")==null ?"" :request.getParameter("forTatkaalRequired");   
	strForCoupanRequired   		=  request.getParameter("forCoupanRequired")==null ?"" :request.getParameter("forCoupanRequired");   
	//String strRemarks 			=  request.getParameter("Remarks")==null ?"" :request.getParameter("Remarks");    
	
	//added new on 09-jan 2009 
	String strSeatprefferd			="";
	String strticketrefundable		="";
	 // from seat  prefference  
	strticketrefundable                 =  request.getParameter("ticketrefund");   // from ticket prefference 
	strSeatprefferd						=  request.getParameter("seatpreffered");

//System.out.println("strManagerId---->"+strManagerId);
//System.out.println("strHodId------>"+strHodId);
	
	
	
	if (strBilling.equals("outSideSMG")) 
	  {
		   strBillClient=request.getParameter("billClient")==null ?"" :request.getParameter("billClient");   
		   strBillingSMGUser =strBillClient;
		  strBillingSMGSite="";
		  	flag ="2";
	  }
	
	//If User has selected  billig site other than own site  with  approve person also
	//change by manoj
	if (strBillingSMGSite.equals(strSiteid))
		{
		flag ="2";
		strBillingSMGUser="-1";
	   }
	
	// If Travelller Is Chair Man Then User Seleted From Other Site Will Not Be Added In Workflow      
	strSql = "SELECT LTRIM(RTRIM(ISNULL(ROLE_ID,'OR'))) AS ROLE_ID  FROM M_USERINFO WHERE USERID="+strTravellerId; 	
	rs     = dbConBean1.executeQuery(strSql);
		if(rs.next())
						{
						 strTravellerRole = rs.getString("ROLE_ID");
						if(strTravellerRole.equalsIgnoreCase("CHAIRMAN"))
							 {
								  flag ="2";    
	                        }
						}
			rs.close();
	
	rs = null;
	strSql = "SELECT TS.LINKED_TRAVEL_ID FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_DOM TD (NOLOCK) ON TS.TRAVEL_ID=TD.TRAVEL_ID AND TS.TRAVEL_TYPE='D' WHERE TD.TRAVEL_ID="+strTravelId+" AND TD.APPLICATION_ID = 1 AND TD.STATUS_ID = 10"; 	
	rs = dbConBean1.executeQuery(strSql);
	if(rs.next()) {
		strCancelledReqId = rs.getString("LINKED_TRAVEL_ID");
	}
	rs.close();
		
	
	if(strManagerId != null && strManagerId.equalsIgnoreCase("S"))
	{
		strManagerId = null;
	}
	if(strHodId != null && strHodId.equalsIgnoreCase("S"))
	{
		strHodId = null;
	}
	
	//Added By Gurmeet Singh
	String strUserAccessCheckFlag = "";
	
	strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(Suser_id, strSiteid, "0");		
	
	if(strManagerId != null && !strManagerId.equalsIgnoreCase("S") && !strUserAccessCheckFlag.equals("420")){
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strManagerId, strSiteid, "1");
	} 
	if(strHodId != null && !strHodId.equalsIgnoreCase("S") && !strUserAccessCheckFlag.equals("420")){
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strHodId, strSiteid, "2");
	} 
	if(strBoardMemberId!= null && !strBoardMemberId.equalsIgnoreCase("B") && !strBoardMemberId.equalsIgnoreCase("-2") && !strUserAccessCheckFlag.equals("420")){
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strBoardMemberId, strSiteid, "3");
	}
	if(strBillingSMGSite.equals(strSiteid) && !strUserAccessCheckFlag.equals("420")){
		if(!strBillingSMGUser.equals("-1")){
			strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strBillingSMGUser, strBillingSMGSite, "4");
		} 
	} 	
 	if(!strBillingSMGSite.equals(strSiteid) && !strUserAccessCheckFlag.equals("420")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strBillingSMGUser, strBillingSMGSite, "4");
	}	
 	if(!strUserAccessCheckFlag.equals("420")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthEditTravelReq(strTravelId, "D", Suser_id);		
	}
	
 	if(strUserAccessCheckFlag.equals("420")){	
		dbConBean.close();  
		dbConBean1.close();
		dbConBean2.close();
		securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "Group_itinerary_details_DOM_Post.jsp", "Unauthorized Access");
		response.sendRedirect("UnauthorizedAccess.jsp");		
	} else {
	
	 String [] strUsertoReturn         =request.getParameterValues("userids"); 
		
  	String strtext			="-1";  
  	int intTotleid			=0; 
  	String strUserids       ="-1";      
  	 
  		if (strUsertoReturn!=null){ 
  				 intTotleid=strUsertoReturn.length ;  
  				 for(int i=0;i<intTotleid;i++)
  				 {
  				      strUserids=strUsertoReturn[i];  
  				      if(intTotleid>1){
  				    	  strtext=strtext+","+strUserids.trim();    
  				      }else{ 
  				    	  strtext=strUserids.trim();   
  				      }
  				 }  
  				 objCon		=dbConBean.getConnection();
  		         objCstmt             =  objCon.prepareCall("{?=call PROC_GROUP_RETURN_JOURNEY(?,?)}");
  		 	     objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
  		 	     objCstmt.setString(2, strtext.trim()); 
  		 	     objCstmt.setInt(3, Integer.parseInt(strTravelId.trim()));   
  		  	     intSuccess10  =  objCstmt.executeUpdate();   
  		 	    objCstmt.close();
  				
  		   }
     	
		 //PROCEDURE for INSERT data in T_APPROVERS ==============================open
		  objCon		=dbConBean.getConnection();
		        
		 //Get the new Approve_Id from the T_Travel_Mst Table
	      strApprove_Id  =  dbUtilityBean.getNewGeneratedId("APPROVE_ID")+"";
	  	try  
			{
			  //code delete the approver of given travel id and travel type  if exist in table 
	          //PROCEDURE for DELETE DATA FROM THE  T_APPROVERS
		      //objCon.setAutoCommit(false);
	
		      objCstmt             = objCon.prepareCall("{?=call PROC_DELETE_FROM_INT_TABLE(?,?,?)}"); 
			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			  objCstmt.setString(2, strTravelReqId);
			  objCstmt.setString(3, strTravelId);
			  objCstmt.setString(4, strTravelType); 
			  intSuccess1   =  objCstmt.executeUpdate();
			  objCstmt.close();
			  
  		       //---------------unit  head will be added from ccreator site 
				     strSql = "SELECT LTRIM(RTRIM(ISNULL(ROLE_ID,'OR'))) AS ROLE_ID, LTRIM(RTRIM(ISNULL(UNIT_HEAD,'0'))) AS UNIT_HEAD FROM M_USERINFO WHERE USERID="+Suser_id; 	
//System.out.println("strsql-------1---->"+strSql);
				     rs     = dbConBean1.executeQuery(strSql);
						if(rs.next())
						{
							 strTravellerRole = rs.getString("ROLE_ID");
								// strUnitHead	  = rs.getString("UNIT_HEAD");	
								 if(strTravellerRole.equalsIgnoreCase("CHAIRMAN"))
									 {
									approverList.clear();
									}								
						   }
				       rs.close();	
	                //-------------  for one UnitHead for multiple site---------------
	                //change by manoj
			     	strSql = "SELECT ISNULL(UNIT_HEAD,'0') AS UNIT_HEAD   FROM USER_MULTIPLE_ACCESS where userid="+Suser_id+" and site_id="+strSiteid+" and status_id=10 and unit_head=1";
//System.out.println("strsql-------2---->"+strSql);
			     	rs = dbConBean1.executeQuery(strSql);
						if(rs.next())
						{
							strUnitHead			=	rs.getString(1).trim();			
						}
				     rs.close();
	                //-----------  for one UnitHead for multiple site---------------
				
				   //added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma 
				   if(strTravellerRole.equalsIgnoreCase("CHAIRMAN"))
			       	{
					   //change by manoj
						strSql = "SELECT LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, APPROVER_ID, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+strSiteid+" AND TRV_TYPE='D' AND sp_role="+SSstrSplRole+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4"; 
					    rs     = dbConBean1.executeQuery(strSql);
				 	   while(rs.next())
					      {
						  strUserRole = rs.getString("USERROLE");
							 if(strUserRole != null && strUserRole.equalsIgnoreCase("MATA"))
							 {
								approverList.add(rs.getString("APPROVER_ID"));	
								approverList.add(strUserRole);  
							 }				 
					    }
					rs.close();	
				   }
				else
				   {
						  if(strManagerId != null)
							  {
								approverList.add(strManagerId);
								approverList.add("WORKFLOW");
							  }
						  if(strHodId != null)
							  {
								//if condition added on 23 july 2013 by manoj chand to prevent addition of approval level 1 approver in level 2.
								if(!approverList.contains(strHodId)){
									approverList.add(strHodId);
									approverList.add("WORKFLOW");
								}
							  }
						//added by manoj chand on 22 mar 2013 to add board member after approver 1 and 2
						  if(strHidAppFlag.equalsIgnoreCase("Y") && strHidAppShowBMFlag.equalsIgnoreCase("Y") && strBoardMemberId!=null && !strBoardMemberId.equalsIgnoreCase("-2") && !strBoardMemberId.equalsIgnoreCase("B")){
							  approverList.add(strBoardMemberId);
							  approverList.add("WORKFLOW");
						  }
						  
						  
						  //getting value of default approvers from database.
						  //change by manoj
							  strSql = "SELECT APPROVER_ID, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+strSiteid+" AND TRV_TYPE='D' AND sp_role="+SSstrSplRole+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4";
//System.out.println("strsql-------3---->"+strSql);
							  rs     = dbConBean1.executeQuery(strSql);
							  while(rs.next())
								  {
											String strTempApproverId =  rs.getString("APPROVER_ID").trim();
											 strUserRole = rs.getString("USERROLE");
											 //if traveller id is unit head of the site then it would not be appear in the approver list.	
											 if(strUnitHead.equalsIgnoreCase("1") && strTravellerId.equals(strTempApproverId))	
											 {
											 }
											 //---------------For  Unit Heads belonging to the same site.
											 //change by manoj
											   String strQuery="Select Unit_Head from USER_MULTIPLE_ACCESS where USERID="+strTempApproverId+" and SITE_ID="+strSiteid+" AND UNIT_HEAD=1 ORDER BY 1";
											   rs1     = dbConBean2.executeQuery(strQuery);
											   if(strUnitHead.equalsIgnoreCase("10000") && rs1.next()) {	}
											  else
												 {
										   //	 added code for checking if appro ver is exits in defualt approver list on 19-01-2009 
										   /* Commented by vaibhav on sep 15 2010 to remove error in case of duplicate approvers
												   if(approverList.contains(strTempApproverId)){  
													  approverList.remove(strTempApproverId); 
													  approverList.remove("WORKFLOW"); 
													  }
										   */
										   
				//System.out.println("strTempApproverId------->"+strTempApproverId);
				//System.out.println(approverList);        //1270,workflow
												   if(approverList.contains(strTempApproverId)){
														  int j = approverList.indexOf(strTempApproverId);
														  
														 // ArrayList tempApproverArrayList = new ArrayList();
														//  tempApproverArrayList.addAll(j,approverList);
														 // int k = tempApproverArrayList.indexOf("WORKFLOW");
														  //added by manoj
														  int k = j+1;//approverList.indexOf("WORKFLOW");
														  if(j==k-1)
														  {
															  approverList.remove(j);
															  approverList.remove(j);
															 // approverList.remove(strTempApproverId); 
															 // approverList.remove("WORKFLOW"); 
														  }
													  }
												         approverList.add(strTempApproverId);
														 if(strUserRole != null && strUserRole.equalsIgnoreCase("OR"))
															{
															   strUserRole = "DEFAULT";
															}
												          approverList.add(strUserRole);  
												    
											}
											rs1.close();
								   }  //close of while loop 
							 rs.close();//clode of connection 	 
			      	}  //close of else
	
			       ///-----------------------------ADDE Approver in a T_approvers  table   
			       
				    
	                try{
	                	//ADDED BY MANOJ CHAND ON 28 MARCH 2012 TO ADD BOARD MEMBER IN SECOND LAST POSITION IN APPROVER LIST
						   if(strHidAppFlag.equalsIgnoreCase("Y") && strHidAppShowBMFlag.equalsIgnoreCase("Y") && strBoardMemberId!=null && !strBoardMemberId.equalsIgnoreCase("-2") && !strBoardMemberId.equalsIgnoreCase("B")){
							  /* int s=approverList.size();
							   String x= (String) approverList.get(s-1);
								String y= (String) approverList.get(s-2);
								approverList.remove(s-1);
								approverList.remove(s-2);
								approverList.add(strBoardMemberId);
								approverList.add("WORKFLOW");
								approverList.add(y);
								approverList.add(x);*/
						   }
	                	
							Iterator itr =  approverList.iterator();
	      					while(itr.hasNext())
								{
								intCounter++;  
								//NO NEED GENERATION OF THIS ID DUE TO FIELD IS AUTOGENERATED IN THE T_APPROVER TABLE
								//strApprove_Id       =  dbUtilityBean.getNewGeneratedId("APPROVE_ID")+"";  
								
								strApproverId       = (String) itr.next();
								strApproverRole     = (String)itr.next(); 
					 			strApproverOrderId  = intCounter+"";

								objCstmt             = objCon.prepareCall("{?=call PROC_INSERT_T_APPROVERS(?,?,?,?,?,?,?,?,?,?)}"); 
								objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
								objCstmt.setString(2, strApprove_Id);            //set the Approve Id      
								objCstmt.setString(3, strTravelId);             //set the Travel Id    
								//change by manoj
								objCstmt.setString(4, strSiteid);                //set the Traveller Site Id  
								objCstmt.setString(5, Suser_id);           //Set the Traveller Id
								objCstmt.setString(6, strTravelType);            //Set the TravelType 
								objCstmt.setString(7, strApproverId);            //Set the Approver Id
								objCstmt.setString(8, strApproveStatus);         //Set the Approve Status(0-no approve, 10-approve, 3-return, 4-rejected)
								objCstmt.setString(9, strApproverOrderId);       //Set the Approver Order Id in which  order approver approve the requsition
								objCstmt.setString(10, strApproverRole);         //Set the Approver Role
								objCstmt.setString(11, Suser_id);                //Set the Login user id 
								intSuccess5   =  objCstmt.executeUpdate();
			 
						        objCstmt.close();
				 		     	if(intSuccess5 == 0)
						         break;
					            }//Close of while for adding approver in T_approver 
									 
	                              //--------------- if creator will select billing site other than his Own site then this code will execute  
								  // ----------------and this code will add selcted aapprover in work flow of requisition 
		
							  if (flag!="2")  // 
						          {
	                                
	  									 int intTravelId           =Integer.parseInt(strTravelId);
										 int intBillingClient     =Integer.parseInt(strBillingSMGUser);
										 int intTravellerId       =Integer.parseInt(strTravellerId);
										 int intC_userid         = Integer.parseInt(Suser_id);
								 
										   if(intBillingClient!=-1){  	 							  	 
													    objCstmt             = objCon.prepareCall("{?=call PROC_APPROVER_OF_OTHERSITE(?,?,?,?,?)}");
														objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
														objCstmt.setInt(2,intTravelId);
														objCstmt.setString(3,"D");
														objCstmt.setInt(4,intBillingClient);
														objCstmt.setInt(5,intTravellerId);
														objCstmt.setInt(6,intC_userid);// new field added on 1/24/2008  by shiv  Sharma 
														intSuccess6=objCstmt.executeUpdate();
														objCstmt.close();
					
														 if (intSuccess5>0){ 
													     //System.out.println("Approver of other site  added  successfully in T_approver table ");
														   strMessage = "save";
														 }
														 else{
															System.out.println("Error in  adding  apporver of billing site successfully in T_approver table in Group_itinary_details_dom_post.jsp");
														 } 
										} 
					                 }  //close of if block for adding approver of biling site  
	
			                  }  ///close of if block for adding approver of in table T_Approvers
							catch(Exception e)
								  {
								  System.out.println(e);
								  objCon.rollback();
								  strTravelId = null;
								  //strMessage = dbLabelBean.getLabel("message.global.notsaved",strsesLanguage);
								  //strMessage = "notSave";
								  strMessage=dbLabelBean.getLabel("message.createreqeust.detailshasnotbeensaved",strsesLanguage);
							}	                  
		}
	catch(Exception e)
		{
		   System.out.println("Error in page :Group _itinerary_details_DOM_Post.jsp--LINE 573-->"+e);
		}
	
	 //PROCEDURE for INSERT data in T_APPROVERS ==============================End
	 //procdeure to update values in t_travel_details_int ======================open
	try
	  	{
	          
				strSql="SELECT dbo.CalAge(DOB,GETDATE()), isnull(GENDER,'Male') as GENDER FROM M_USERINFO WHERE USERID="+Suser_id;
								rs       =   dbConBean.executeQuery(strSql);  
					              while(rs.next()){
						  		 				 strOrignatorAge= rs.getString(1).trim();
											     strOrignatorSex= rs.getString(2).trim();
	
									      if(strOrignatorSex.equals("Male")) {
										   strOrignatorSex="1";
									       }
										   else {  strOrignatorSex="2";}
	          	                           }
	                           rs.close();  
	              try{
	             
				/*	strSql=" update T_travel_detail_dom  "+  
						   " set  MANAGER_ID="+strManagerId+" ,HOD_ID="+strHodId+",RETURN_TATKAAL='"+strForTatkaalRequired+"',RETURN_COUPAN='"+strForCoupanRequired+"', REMARKS='"+strRemarks.trim()+"',"+
						   " REASON_FOR_TRAVEL='"+strReasonForTravel+"',REASON_FOR_SKIP='"+strReasonForSkip+"'  where TRAVEL_ID="+strTravelId+" and STATUS_ID='10'"; */
					/*	   strSql=" update T_travel_detail_dom  "+  
						   " set  MANAGER_ID="+strManagerId+" ,HOD_ID="+strHodId+",BOARD_MEMBER_ID= "+strBoardMemberId + ",RETURN_TATKAAL='"+strForTatkaalRequired+"',RETURN_COUPAN='"+strForCoupanRequired+"',"+
						   " REASON_FOR_TRAVEL=N'"+strReasonForTravel+"',REASON_FOR_SKIP=N'"+strReasonForSkip+"'  where TRAVEL_ID="+strTravelId+" and STATUS_ID='10'";*/
					//int updaterow=   dbConBean.executeUpdate(strSql);
	//new procedure added by manoj chand on 27 nov to resolve  error coming when single quotes in reason for travel
	            	  objCstmt            =  objCon.prepareCall("{?=call PROC_UPDATE_GROUP_T_TRAVEL_DETAIL_DOM(?,?,?,?,?,?,?,?)}"); 
						objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2, strTravelId);
						objCstmt.setString(3, strManagerId);
						objCstmt.setString(4, strHodId);
						objCstmt.setString(5, strReasonForTravel);     
						objCstmt.setString(6, strReasonForSkip);
						objCstmt.setString(7, strBoardMemberId);
						objCstmt.setString(8, strForTatkaalRequired);
						objCstmt.setString(9, strForCoupanRequired);
						int updaterow=  objCstmt.executeUpdate();
						objCstmt.close();
						   
						   
						   
				   }catch(Exception e)
						{
					   System.out.println("Error in PROC_UPDATE_T_TRAVEL_DETAIL_DOM in Group _details_dom_post"+e);
				  }
	  //---------------------------------------procdeure to update values in t_travel_details_int ======================end 
	
	 	           //PROCEDEURE TO UPDATE BILLING INFO=======================OPEN                  
				   objCstmt             =  objCon.prepareCall("{?=call PROC_UPDATE_BILLING_INFO_DOM(?,?,?,?,?,?,?,? , ?,?,?,?,?,?,?)}");
					objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					objCstmt.setString(2, strTravelId);
					objCstmt.setString(3, strBillingSMGSite);             
					objCstmt.setString(4, strBillingSMGUser);
					objCstmt.setString(5, "");
					objCstmt.setString(6, "");
					objCstmt.setString(7, "");
					objCstmt.setString(8, "");
					objCstmt.setString(9, "");
					//below 5 parameters added by Pankaj on 11 Nov 10			
					objCstmt.setString(10, dbl_YTM_BUDGET);
					objCstmt.setString(11, dbl_YTD_ACTUAL);
					objCstmt.setString(12, dbl_AVAIL_BUDGET);
					objCstmt.setString(13, dbl_EST_EXP);
					objCstmt.setString(14, str_EXP_REMARKS);
					objCstmt.setString(15,strTotalFareCurrency);
					objCstmt.setInt(16,Integer.parseInt(strTotalFareAmount));
					intSuccess3   =  objCstmt.executeUpdate();
					objCstmt.close();
	
		            
	      
		           //procedeure to update billing info=======================close 
		           
					 String strRecord="";
		 	           	strSql="SELECT  1  FROM   T_RET_JOURNEY_DETAILS_DOM t1 INNER JOIN T_TRAVEL_DETAIL_DOM t2  "+
		 	           		  " ON t1.TRAVEL_ID = t2.TRAVEL_ID  WHERE  (t1.TRAVEL_ID = "+strTravelId+") AND (t1.APPLICATION_ID = 1) "+ 
		 	           	      " AND (t2.STATUS_ID = 10) "; 
		 	        
		
									rs       =   dbConBean.executeQuery(strSql);   
						              while(rs.next()){
						            	  strRecord= rs.getString(1);      	  
						              }
						              
                   if(!strRecord.equals("1")){   
                	   
	                 //procdure  to insert  update  journey details in T_JOURNEY_DETAILS_INT  table 
				      objCstmt             = objCon.prepareCall("{?=call PROC_INSERT_T_RET_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
					  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					  objCstmt.setString(2, strTravelId);//strTravelId
					  objCstmt.setString(3, strDepCity);             //set the Traveller Return Departure City Name(RETURN_FROM)
					  objCstmt.setString(4, strArrCity);             //set the Traveller Return Arrival City Name(RETURN_TO)
					  objCstmt.setString(5, strDepDate);             //set the Traveller Departure Date
					  objCstmt.setString(6, "1");       			 //set the Order of Traveller intrim journey(it is 1 for the actual from and to
					  objCstmt.setString(7, strTravelMode);         //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
					  objCstmt.setString(8, strNameOfAirline);      //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
					  objCstmt.setString(9, strTravelClass);        //set the Travel Class Name(in int value), e.g. First class, Business class 
					  objCstmt.setString(10, strPreferTime);          //set the Travel Preferred Time e.g. Morning,evening etc.
					  objCstmt.setString(11, Suser_id);              //set the current user Login UserId
					  objCstmt.setString(12, strSeatprefferd);       //set the Seat prefference 
					  objCstmt.setString(13, strticketrefundable);   //set the Seat ticket 
					  objCstmt.setString(14, "1");
					  objCstmt.setInt(15, 0);
					  intSuccess3   =  objCstmt.executeUpdate(); 
					  objCstmt.close();
                   }else{ 
                	   //procdure  to insert  update  journey details in T_JOURNEY_DETAILS_INT  table 
 
 				      objCstmt             = objCon.prepareCall("{?=call PROC_UPDATE_T_RET_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
 					  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
 					  objCstmt.setString(2, strTravelId);//strTravelId
 					  objCstmt.setString(3, strDepCity);             //set the Traveller Return Departure City Name(RETURN_FROM)
 					  objCstmt.setString(4, strArrCity);             //set the Traveller Return Arrival City Name(RETURN_TO)
 					  objCstmt.setString(5, strDepDate);             //set the Traveller Departure Date
 					  objCstmt.setString(6, "1");        			//set the Order of Traveller intrim journey(it is 1 for the actual from and to
 					  objCstmt.setString(7, strTravelMode);         //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
 					  objCstmt.setString(8, strNameOfAirline);      //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
 					  objCstmt.setString(9, strTravelClass);        //set the Travel Class Name(in int value), e.g. First class, Business class 
 					  objCstmt.setString(10, strPreferTime);          //set the Travel Preferred Time e.g. Morning,evening etc.
 					  objCstmt.setString(11, "");                    //set the Modified columns  
 					  objCstmt.setString(12, Suser_id);              //set the current user Login UserId
 					  objCstmt.setString(13, strSeatprefferd);       //set the Seat prefference 
 					  objCstmt.setString(14, strticketrefundable);   //set the Seat ticket 
 					  objCstmt.setString(15, "1");
					  objCstmt.setInt(16, 0);
 					  intSuccess3   =  objCstmt.executeUpdate(); 
 					  objCstmt.close();
                	   
                   }             
         //added by manoj chand on 22 nov 2011 to save info related to buying ticket from non-mata source 
                   if(strmataprice.equalsIgnoreCase("y")){  	
           			
          			 if(strTkAgent.equalsIgnoreCase("n")){ 
          				   //	objCon               =  dbConBean.getConnection(); 
          				objCstmt=objCon.prepareCall("{?=call PROC_UPDATE_TRAVEL_TICKET_DETAIL(?,?,?,?,?,?,?,?)}");
          				objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
          				objCstmt.setString(2,strTravelId);
          				objCstmt.setString(3,"D");
          				objCstmt.setString(4,strTkAgent);
          				objCstmt.setString(5,strTkAirLine);
          				objCstmt.setString(6,strTkcurrency);
          				objCstmt.setString(7,strTklocalprice);
          				objCstmt.setString(8,strTkRemarks);
          				objCstmt.setString(9,Suser_id);
          			    objCstmt.executeUpdate();
          		        objCstmt.close();
          				}	 
          				else{
             
          					try{ 
          					objCstmt=objCon.prepareCall("{?=call PROC_UPDATE_TRAVEL_TICKET_DETAIL(?,?,?,?,?,?,?,?)}");
          					objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
          					objCstmt.setString(2,strTravelId);
          					objCstmt.setString(3,"D"); 
          					objCstmt.setString(4,strTkAgent);
          					objCstmt.setString(5,"");
          					objCstmt.setString(6,"USD");
          					objCstmt.setInt(7,0);
          					objCstmt.setString(8,"");
          					objCstmt.setString(9,Suser_id); 
          				    objCstmt.executeUpdate();
          			        objCstmt.close(); 
          					}catch(Exception e) {
          						System.out.println("ee====in dom forex post ===="+e);
          					}
          				} 
          	        
          			}
                   //end here
                   
                   
            //code added for if travel details found blank then it will not allow to submit the requsition in workflow       
			String strRecordFoundBlankField="";
			strSql="select 1 from T_JOURNEY_DETAILS_DOM where travel_id='"+strTravelId+"'"+
			" and (travel_from ='' or travel_to='' or year(travel_date)=1900) ";  
			
			
			rs       =   dbConBean.executeQuery(strSql);   
			if(rs.next()){
				strRecordFoundBlankField= rs.getString(1);       	  
			}  
			
			if(!strRecordFoundBlankField.equals("1")){	 
					//Procedure to Change Status _id of requisition  to Permanent Requisition 
					//added by manoj to show requisition no. as per selected site
				if(!strSiteid.trim().equalsIgnoreCase(strSiteIdSS.trim())){
					String strsiteName="";
					strSql="select site_name from m_site where site_id="+strSiteid;
					
					 rs = dbConBean.executeQuery(strSql);
						if(rs.next()){  
							strsiteName = rs.getString("site_name");	 		
						 }
					strPermanent_Req_No = "GR/" + strsiteName.trim()+ "/DOM/" + strTravelId;
					
					rs.close();
				}else{					
	                   strPermanent_Req_No = "GR/"+strSiteFullName.trim()+"/DOM/"+strTravelId;
				}
					//end here
		        	   // Added on 28 may 2009 for stoping mail when use referesh the page 
	        		   session.setAttribute("strSetFlage","1"); 
		               strMessage = "save";       
						if(strWhatAction != null && strWhatAction.equals("saveProceed"))
	                         {
				//added by manoj chand on 31 oct 2012 to make check for 350$ in domestic also.
							con3= dbConBean.getConnection();
							st3 = con3.createStatement();
			String strQuery="SELECT DISTINCT 1 FROM (SELECT *,DBO.FN_CURRENCY_CONVERTOR(TOTALEXPENCE,CURRENCY,'USD',CONVERT(VARCHAR(10),GETDATE(),103)) AS TOTAL_EXP"+
							" FROM (SELECT TTED.G_USERID ,TDD.TRAVEL_ID, TDD.TRAVEL_DATE FORMDATE, "+
							" CASE WHEN TRJDI.TRAVEL_DATE IS NULL OR YEAR(TRJDI.TRAVEL_DATE) = 1900 "+
							" THEN TDD.TRAVEL_DATE "+
							" ELSE TRJDI.TRAVEL_DATE "+
							" END RETDATE, "+
							" TRJDI.TRAVEL_DATE RETURN_DATE ,MS.CURRENCY,"+
							" SUM(DBO.FN_CURRENCY_CONVERTOR(TTED.TOTAL_EXP_ID,RTRIM(LTRIM(TTED.CURRENCY)),MS.CURRENCY,CONVERT(VARCHAR(10),GETDATE(),103))) AS TOTALEXPENCE,"+
							" (SELECT SUM(TOTAL_TOUR_DAYS) FROM T_TRAVEL_EXPENDITURE_DOM "+
							" WHERE TRAVEL_ID = TDD.TRAVEL_ID AND G_USERID =TTED.G_USERID AND EXP_ID = 5) EXP_TOUR_DAYS,"+
							" (SELECT SUM(TOTAL_TOUR_DAYS) FROM T_TRAVEL_EXPENDITURE_DOM WHERE TRAVEL_ID = TDD.TRAVEL_ID "+
							" AND G_USERID =TTED.G_USERID AND EXP_ID = 6) HOTEL_TOUR_DAYS "+
							" FROM T_TRAVEL_EXPENDITURE_DOM TTED "+
							" INNER JOIN T_TRAVEL_STATUS TTDD ON TTED.TRAVEL_ID=TTDD.TRAVEL_ID"+
							" INNER JOIN [M_EXPENDITURE] ME ON TTED.EXP_ID=ME.EXP_ID AND ME.TRAVEL_TYPE='D'"+
							" LEFT JOIN T_TRAVEL_DETAIL_DOM TDD ON TDD.TRAVEL_ID=TTED.TRAVEL_ID"+
							" LEFT JOIN  T_RET_JOURNEY_DETAILS_DOM TRJDI ON TRJDI.TRAVEL_ID = TDD.TRAVEL_ID"+ 
							" LEFT JOIN M_SITE MS ON TDD.SITE_ID=MS.SITE_ID"+
							" LEFT OUTER JOIN M_USERINFO UIM ON TDD.TRAVELLER_ID=UIM.USERID"+     
							" LEFT OUTER JOIN T_GROUP_USERINFO UIM1 ON TTED.G_USERID=UIM1.G_USERID AND UIM1.TRAVEL_TYPE= 'D'"+
							" AND UIM1.TRAVEL_ID= TTED.TRAVEL_ID AND UIM1.STATUS_ID=10"+
							" WHERE TTED.TRAVEL_ID='"+strTravelId+"' AND TTED.APPLICATION_ID=1 AND TTDD.TRAVEL_TYPE='D'"+ 
							" GROUP BY TDD.TRAVEL_ID,TTED.G_USERID,TRJDI.TRAVEL_DATE,TDD.TRAVEL_DATE,MS.CURRENCY)DRV)DRV_MST"+
							" WHERE (TOTAL_EXP/CASE WHEN RETURN_DATE IS NULL OR YEAR(RETURN_DATE) = 1900"+ 
							" THEN CASE WHEN HOTEL_TOUR_DAYS >0 THEN HOTEL_TOUR_DAYS ELSE CASE WHEN EXP_TOUR_DAYS >0 THEN EXP_TOUR_DAYS"+  
							" ELSE DATEDIFF(DAY,FORMDATE,RETDATE)+1 END END ELSE DATEDIFF(DAY,FORMDATE,RETDATE)+1 END)>350";


						//System.out.println("strQuery::::::::>>"+strQuery);				   
						rs3 = st3.executeQuery(strQuery);
						if (rs3.next()) {
									strMessage = "ExpenceCheck";
									String url2 = "Group_itinerary_details_DOM.jsp?message1="+strMessage+"&travelId="+strTravelId
											+ "&travelReqId="+ strTravelReqId+ "&travellerId="+ strTravellerId+ "&site="+ strSiteid+ "&travelReqNo=" + strTravelReqNo+"&fwddepDate="+strDeptDate;
									RequestDispatcher rd = request.getRequestDispatcher(url2);
									rd.forward(request, response);
									return;
								}
							
							//end here!
							
							
							//PROCEDURE to insert the row in T_TRAVEL_MST  Table
		 	                   objCstmt   =  objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_STATUS_DOM(?,?,?,?,?,?)}");
							   objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							   objCstmt.setString(2, strTravelId);
							   objCstmt.setString(3, strTravelReqId);
							   objCstmt.setString(4, "2");      //SET THE  TRAVEL_STATUS_ID 2 AS A PERMANENT REQUEST FOR THE WORKFLOW
							   objCstmt.setString(5, strTravelType);
							   objCstmt.setString(6, strPermanent_Req_No);
							   objCstmt.setString(7, strCancelledReqId);
							   intSuccess5   =  objCstmt.executeUpdate();
							   //System.out.println("intSuccess5----------->"+intSuccess5);
							   objCstmt.close();
	                           strMessage = "save";
				 			}
	 
	                   //PROCEDURE TO UPDATE EXPENDITURE IN T_TRAVEL_DETAILS_INT TABLE
					   
					  objCstmt  =  objCon.prepareCall("{?=call PROC_T_TRAVEL_EXPENDITURE_DOM_UPDATE_GROUP(?)}");
					  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					  objCstmt.setString(2, strTravelId);
					  intSuccess10   =  objCstmt.executeUpdate();
					  objCstmt.close();		  
	
			}else{ 
				strMessage = dbLabelBean.getLabel("message.createrequestforwardjourneydetailsnotsavedpleasecheck",strsesLanguage); 
			}
					  
		}
			catch(Exception e)
		{
			System.out.println("Error in Group_itinary_details_DOM_Post.jsp LINE 852===="+e);
			//strMessage = "notSave";
			strMessage=dbLabelBean.getLabel("message.createreqeust.detailshasnotbeensaved",strsesLanguage);
		}
	//after inserting all data to all tables  set the responce  
	if(strMessage != null && strMessage.equals("save"))
	{
	    	if(strWhatAction != null && strWhatAction.equals("save"))
		     {
	       	url = "Group_itinerary_details_DOM.jsp?message="+URLEncoder.encode(strMessage,"UTF-8")+"&travelId="+strTravelId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&site="+strSiteid+"&travelReqNo="+strTravelReqNo+"&fwddepDate="+strDeptDate;
		     }
	    	else if(strWhatAction != null && strWhatAction.equals("saveandexit"))
		        {
				url = "T_TravelRequisitionList_D.jsp?travel_type=DOM";
		        }
		   else if(strWhatAction != null && strWhatAction.equals("saveProceed"))
		        {
			   
		       if(intSuccess5 > 0)
	              {
	     //	         url = "T_TravelRequisitionList.jsp?travel_type=DOM";
		  	    //change by manoj
		  	    String	strReq	=	"";
				if(strTravelType.equalsIgnoreCase("I")) {
					strReq	=	"International Travel";
				} else {
					strReq	=	"Domestic Travel";
				}
				mailDaoImpl.sendRequisitionMailOnOriginating(strTravelId, strReq, Suser_id, strsesLanguage, strCurrentYear);
				
	                  url = "FinallySubmitted.jsp?travelId="+strTravelId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&travellerSiteId="+strSiteid+"&travelReqNo="+strPermanent_Req_No+"&ReqTyp=D&interimId="+strInterimId+"&strGroupflag=yes";
		          }
				  else
				  {
					  url = "";
				  }
				}
		else
		{
		}
	}
	else
	{
		//change by manoj chand on 23 feb 2012 to resolve issue of user request site change
		//url = "Group_itinerary_details_DOM.jsp?message="+strMessage+"&travelId="+strTravelId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&travellerSiteId="+strTravllerSiteId+"&travelReqNo="+strTravelReqNo;
		url = "Group_itinerary_details_DOM.jsp?message="+URLEncoder.encode(strMessage,"UTF-8")+"&travelId="+strTravelId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&site="+strSiteid+"&travelReqNo="+strTravelReqNo+"&fwddepDate="+strDeptDate;
	
	}
	/*url = "Group_itinerary_details_DOM.jsp?message="+strMessage+"&travelId="+strTravelId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&travellerSiteId="+strTravllerSiteId+"&travelReqNo="+strTravelReqNo;
	*/
	
	//System.out.println("--->>>  "+response.isCommitted());
	  response.sendRedirect(url);    
		
	}%>