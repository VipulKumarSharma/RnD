	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:SACHIN GUPTA
	 *Date of Creation 		:12 September 2006
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:This is second jsp file  for create the Forex Details
	 *Modification 			:1 .Change the Billing Instruction(add three radio for self,SMG, and other SMG). Add two new entry for travel Cheque and one 										new   entry for Other Currency. 
							3. Change the code for showing billing client in  different  cases by shiv  Sharma on 06-Nov-07   
							4   new field added on 1/24/2008  by shiv  Sharma    
							5: Added on 28 may 2009 for stoping mail when use referesh the page
							6: added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma 
							7: changed code for Showing price details for comaparion on 17 Nov 2009 
							8: Query adde by shiv for SMR USER for Case of self billing on 23-Feb-10
	 *Reason of Modification: change suggested by MATA
	 *Date of Modification  :2 Nov 2006 
	 *Modified By	        :SACHIN GUPTA
	 *Reason of Modification: Dear null mail is going in case if the final approver is not the MATA personal in any particular workflow and billing selected as self.
	 *Date of Modification  :12 May 2010 
	 *Modified By	        :PANKAJ DUBEY	 
	 *Editor				:Editplus
	:Modified by vaibhav on 30 sep 2010 to add constraint on per day expense.
	:Modified by Pankaj Dubey on 11 Nov 2010 to add 5 new fields to record budgetory figures.
	
	 *Reason of Modification: modification in the 350 USD check for international request.
	 *Date of modification	: 07 march 2011	
	 *Modified by			: manoj chand
	 
	 *Modification			:modify workflow as per selected site
	 *Date of modification  :12 Oct 2011
	 *Modified By     		:Manoj Chand
	 
	 *Modification			:Save expenditure in multiple currency
	 *Date of modification  :16 Oct 2012
	 *Modified By     		:Manoj Chand
	 *******************************************************/
	%>
	
<%@page import="java.net.URLEncoder" pageEncoding="UTF-8"%><html>
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
	<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
	<%
	//Global Variables declared and initialized
	  request.setCharacterEncoding("UTF-8");
	  String strSql                   =  null;              // String for Sql String
	  Connection objCon , con3              =  null;            //Object for Connection 
	  Connection objCon1              =  null;            //Object for Connection 
	  ResultSet rs,rs1,rs2 ,rs3           =  null;            // Object for ResultSet
	  CallableStatement objCstmt	    =  null;		    // Object for Callable Statement
	  Statement st3 = null;
	  src.connection.DbConnectionBean db11 = null;
	  
	  int intSuccess1                 = 0;
	  int intSuccess2                 = 0;
	  int intSuccess3                 = 0;
	  int intSuccess4                 = 0;
	  int intSuccess5                 = 0;
	  int intSuccess6                 = 0;
	  int intSuccess7                 = 0;
	  int intSuccess8                 = 0;
	  int intSuccess9                 = 0;
	  int intSuccess10                = 0;
	//Fields For T_Travel_Detail_Int Table
	  String strBillingSite           =  "";  
	  String strBillingSMGSite        =  "";   
	  String strBillingClient         =  "";  
	  String strTotalAmount           =  "";  
	  String[] strTACurrency            = null;  
	  
	  String strTravellerCheque       =  "";
	  String strTravellerCheque1      =  "";
	  String strTravellerCheque2      =  "";
	
	  String strTCCurrency            =  "";
	  String strTCCurrency1           =  "";
	  String strTCCurrency2           =  "";
	
	  String strExpenditureRemarks    =  "";
	  String strCashBreakupRemarks    =  "";
	  
	  // below 5 fields added by Pankaj on 11 Nov 10
	  String dbl_YTM_BUDGET = "";
	  String dbl_YTD_ACTUAL = "";
	  String dbl_AVAIL_BUDGET = "";
	  String dbl_EST_EXP = "";
	  String str_EXP_REMARKS = "";
	  
	  String strInterimId 		      =  "";
	  strInterimId 					  =	request.getParameter("interimId")== null ? "" : request.getParameter("interimId");
		  
	
	//Fields for T_Travel_Expenditure_Int Table 
	  String strExpID[]               =  {"1","2","3","4"};
	  String strEntPerDay[]           =  null;
	  String strTotalTourDay[]        =  null;
	  String strTotalForex[]          =  null; 
	  String strContingecies[]        =  null;
	  String strEntPerDay2[]	      =  null;
	  String strContingecies2[]       =  null;
	  String strTotalTourDay2[]       =  null;
	  String strExRate[]        	  =  null;
	  String strTotalINR[]        	  =  null;
	  String strHiddenValue[]		  =  null;
	  String strBaseCurrency		  =  "";
	
	//Fields for T_Cash_BreakUp_Int Table
	  String strCashAmount1           =  "";
	  String strCashAmount2           =  "";
	  String strCashAmount3           =  "";
	  String strCashAmount4           =  "";
	
	  String strCashCurrency1         =  "";
	  String strCashCurrency2         =  "";
	  String strCashCurrency3         =  "";
	  String strCashCurrency4         =  "";  
	
	//Travel Id and other common fields
	  String strTravelReqId           =  "";
	  String strTravelId		      =  "";
	  String strTravelReqNo           =  "";
	  String strTravelType            =  "I";  
	  String strTravllerSiteId        =  ""; 
	  String strTravellerId		      =  "";
	  String strActionFlag            =  "";
	  String strWhatAction            =  "";    
	  String url                      =  ""; 
	  String strPermanent_Req_No      =  "";        //Var for Permanent Requition No.  
	  String strMessage               =  "";
	
	
	  String strApproverId            =  "";   
	  String strApproveStatus         =  "0"; 
	  String strApproverOrderId       =  "";   
	  String strApproverRole          =  ""; 
	  String strApprove_Id            =  "";
	
	  String strApprover_otherSite="";
	  String flag =""; 
	  String strSetFlage ="";
	  
	  
	  String strLAprice     ="";
	  String strLAAirLine   ="";
	  String strLACurrency  ="";
	  String strLAPrice     ="";
	  String strLARemarks   ="";
	  
	  String strTkAgent 		=""; 
	  String strTkAirLine 	=""; 
	  String strTkcurrency 	=""; 
	  String strTklocalprice 	=""; 
	  String strTkRemarks 	=""; 
	  
	//Added By Gurmeet Singh
	String strUserAccessCheckFlag = "";
	  
	  String strmataprice =request.getParameter("matapricecomp");
	  if(strmataprice.equalsIgnoreCase("y")){ 	
		 strTkAgent 			=request.getParameter("tkflyes");
		 strTkAirLine 			=request.getParameter("airline");
		 strTkcurrency 			=request.getParameter("currency");
		 strTklocalprice 		=request.getParameter("localprice"); 
		 strTkRemarks 			=request.getParameter("pricingRemarks"); 
	  }	 
	  
	  strTravelReqId                  =  request.getParameter("travelReqId");    // from hidden field
	  strTravelId                     =  request.getParameter("travelId");       // from hidden field
	  strWhatAction                   =  request.getParameter("whatAction");     //from hidden field                                 
	  strTravelReqNo                  =  request.getParameter("travelReqNo");    // for hidden field
	  //modified by manoj
	  strTravllerSiteId               =  request.getParameter("travellerSiteId")==null?strSiteIdSS:request.getParameter("travellerSiteId");    // for hidden field
	  strTravellerId	        	  =  request.getParameter("travellerId");    
	  strBillingSite                  =  request.getParameter("billing");    
	  
	  //added by manoj begin
	 
	  
	  
	  
	//end
	  strBillingSMGSite               =  request.getParameter("billingSMGSite")==null ?"" :request.getParameter("billingSMGSite");          
	  strBillingClient                 =  request.getParameter("billingSMGUser")==null?"0":request.getParameter("billingSMGUser")	 ;    
  
		if (strBillingClient.equals("0"))
		{
		 flag ="no"; 
	     strBillingClient                 =  request.getParameter("billClient")==null?"0":request.getParameter("billClient");    
		}
	//change manoj
	   if(strBillingSMGSite.equals(strTravllerSiteId))
		{
		 flag ="no"; 
	   }
	 
	  strTotalAmount                	 =  request.getParameter("grandTotalForex");    
	  strTACurrency                      =  request.getParameterValues("expCurrency");    
	  strTravellerCheque                 =  request.getParameter("travelCheque");    
	
	  strTravellerCheque1                =  request.getParameter("travelCheque1");    
	  strTravellerCheque2                =  request.getParameter("travelCheque2");  
	  strTCCurrency                      =  request.getParameter("chequeCurrency");    
	  strTCCurrency1                     =  request.getParameter("chequeCurrency1");    
	  strTCCurrency2                     =  request.getParameter("chequeCurrency2");
	  strExpenditureRemarks          	 =  request.getParameter("expRemarks");    
	  strCashBreakupRemarks        		 =  request.getParameter("cashBreakupRemarks");
	  
	  dbl_YTM_BUDGET        		   	 =  request.getParameter("YtmBud")==null?"0":request.getParameter("YtmBud");
	  dbl_YTD_ACTUAL        		     =  request.getParameter("YtmAct")==null?"0":request.getParameter("YtmAct");
	  dbl_AVAIL_BUDGET        		     =  request.getParameter("AvailBud")==null?"0":request.getParameter("AvailBud");
	  dbl_EST_EXP        		 	     =  request.getParameter("EstExp")==null?"0":request.getParameter("EstExp");
	  str_EXP_REMARKS        		     =  request.getParameter("budgetRemarks")==null?"":request.getParameter("budgetRemarks");
	  
	  strEntPerDay                     =  request.getParameterValues("entitlement");     
	  strTotalTourDay                  =  request.getParameterValues("tourDays");     
	  strTotalForex                    =  request.getParameterValues("totalForex");      
	  strContingecies                  =  request.getParameterValues("contingencies");
	  //ADDED BY MANOJ CHAND ON 08 OCT 2012 TO GET VALUES 
	  strEntPerDay2                     =  request.getParameterValues("entitlement2");     
	  strTotalTourDay2                  =  request.getParameterValues("tourDays2");     
	  strContingecies2                  =  request.getParameterValues("contingencies2");
	  strExRate              		    =  request.getParameterValues("exRate");     
	  strTotalINR						=  request.getParameterValues("totalInr");
	  strHiddenValue					=  request.getParameterValues("hd");
	  strBaseCurrency                   =  request.getParameter("basecur")==null?"INR":request.getParameter("basecur");
	  String strPerDayAmtinUSD			=  request.getParameter("grandTotalForexUSD")==null?"0.00":request.getParameter("grandTotalForexUSD");
	  String strTotalFareCurrency		=  request.getParameter("TotalFareCurrency")==null?"":request.getParameter("TotalFareCurrency");
	  String strTotalFareAmount			=  request.getParameter("TotalFareAmount")==null?"0":request.getParameter("TotalFareAmount");
	  //END HERE
	  strCashAmount1                   =  request.getParameter("specifyAmount1");     
	  strCashAmount2                   =  request.getParameter("specifyAmount2");     
	  strCashAmount3                   =  request.getParameter("specifyAmount3");     
	  strCashAmount4                   =  request.getParameter("specifyAmount4");     
	  strCashCurrency1                 =  request.getParameter("breakupCurrency1");     
	  strCashCurrency2                 =  request.getParameter("breakupCurrency2");     
	  strCashCurrency3                 =  request.getParameter("breakupCurrency3");     
	  strCashCurrency4                 =  request.getParameter("breakupCurrency4");     
	
	  
	//Added By Gurmeet Singh
	strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(Suser_id, strTravllerSiteId, "0");		  
	if(!strUserAccessCheckFlag.equals("420")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strTravellerId, strTravllerSiteId, "0");
	} 
	if(strBillingSMGSite.equals(strTravllerSiteId) && !strUserAccessCheckFlag.equals("420")){
		if(!strBillingClient.equals("-1")){
			strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strBillingClient, strBillingSMGSite, "4");
		} 
	} 	
 	if(!strBillingSMGSite.equals(strTravllerSiteId) && !strUserAccessCheckFlag.equals("420")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strBillingClient, strBillingSMGSite, "4");
	}	
 	if(!strUserAccessCheckFlag.equals("420")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthEditTravelReq(strTravelId, "I", Suser_id);		
	}
 	
	if(strUserAccessCheckFlag.equals("420")){
		dbConBean.close();  
		dbConBean1.close();	
		securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_IntForex_Details_Post.jsp", "Unauthorized Access");
		response.sendRedirect("UnauthorizedAccess.jsp");	
	} else {
	
	///added new by shiv on 05-Nov-07 
	String strTravellerRole  = "";
	strSql = "SELECT LTRIM(RTRIM(ISNULL(ROLE_ID,'OR'))) AS ROLE_ID  FROM M_USERINFO WHERE USERID="+strTravellerId; 	
	
	rs     = dbConBean1.executeQuery(strSql);
	
			if(rs.next())
						{
							 strTravellerRole = rs.getString("ROLE_ID");
						if(strTravellerRole.equalsIgnoreCase("CHAIRMAN"))
							 {
								 flag ="no"; 
	
	                        }
						}
					   
 	 if (strBillingClient.equals("-1") )
	 {
		 flag ="no"; 
	 }
	 if(strBillingClient.equals("0") )
	 {
		flag ="no"; 
	 }
	
	
	  if(strBillingSite != null && strBillingSite.equals("self"))
	  {
	     strBillingSite   = "0";                //when Traveller will pay the travel charge
		 strBillingClient = "self";
	  }
	  else if(strBillingSite != null && strBillingSite.equals("SMG"))
	  {
		  strBillingSite = strBillingSMGSite;                     //when traveller selected site will pay the travel charge
	  }
	  else if(strBillingSite != null && strBillingSite.equals("outSideSMG"))
	  {
	      strBillingSite = "-1";             //when Other SMG Client will pay the travel charge   	 
	  }
	
	
	    try
		{
			objCon               =  dbConBean.getConnection(); 
	        //objCon.setAutoCommit(false);
	        
			//Procedure for delete the date from the T_TRAVEL_EXPENDITURE_INT AND T_CASH_BREAKUP_INT
			objCstmt             =  objCon.prepareCall("{?=call PROC_DELETE_FOREX_DETAIL_TABLES(?)}");//PROCEDURE to insert the row in T_TRAVEL_MST  Table
	        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	        objCstmt.setString(2, strTravelId);
	        intSuccess1   =  objCstmt.executeUpdate();
	        objCstmt.close();
			//Procedure for update the billing info and travel cheque info in T_Travel_Detail_Int Table
			// 5 new parameters added in end by Pankaj on 11 Nov 2010 to update Budged details in "T_TRAVEL_DETAIL_INT" table 
			//2 parameter added by manoj chand on 28 nov 2012 to save travel fare currency and amount
	        objCstmt             =  objCon.prepareCall("{?=call PROC_UPDATE_BILLING_INFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST  Table
	        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	        objCstmt.setString(2, strTravelId);
	        objCstmt.setString(3, strBillingSite);             
	        objCstmt.setString(4, strBillingClient);                //set the billing client
	        objCstmt.setString(5, strTotalAmount);
			objCstmt.setString(6, strBaseCurrency);//strTACurrency before, now INR add by manoj chand on 11 oct 2012
			
			objCstmt.setString(7, strTravellerCheque);
			objCstmt.setString(8, strTravellerCheque1);
			objCstmt.setString(9, strTravellerCheque2);
	
			objCstmt.setString(10, strTCCurrency);
			objCstmt.setString(11, strTCCurrency1);
			objCstmt.setString(12, strTCCurrency2);
	
			objCstmt.setString(13, strExpenditureRemarks);
			objCstmt.setString(14, strCashBreakupRemarks);
	
			objCstmt.setString(15, "");  //FOREX_MODIFIED_FIELDS
	
			objCstmt.setString(16, Suser_id);
			
//below 5 parameters added by Pankaj on 11 Nov 10			
			objCstmt.setString(17, dbl_YTM_BUDGET);
			objCstmt.setString(18, dbl_YTD_ACTUAL);
			objCstmt.setString(19, dbl_AVAIL_BUDGET);
			objCstmt.setString(20, dbl_EST_EXP);
			objCstmt.setString(21, str_EXP_REMARKS);
			objCstmt.setString(22,strTotalFareCurrency);
			objCstmt.setInt(23,Integer.parseInt(strTotalFareAmount));
			
	        intSuccess2   =  objCstmt.executeUpdate();
	        objCstmt.close();
	
			  
	
			//Procedure for insert the expenditure data into the T_Travel_Expenditure_Int
			//commented by manoj chand on 09 oct 2012
			/*for(int i=0; i<strEntPerDay.length; i++)
			{
	          objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_EXPENDITURE_INT(?,?,?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST  Table        
	          objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	          objCstmt.setString(2, strTravelId);
	          objCstmt.setString(3, strExpID[i]);                       //set the ExpId
	          objCstmt.setString(4, strTACurrency);                //set the current user Login UserId
	          objCstmt.setString(5, strEntPerDay[i]);
			  objCstmt.setString(6, strTotalTourDay[i]);
		      objCstmt.setString(7, strTotalForex[i]);
			  objCstmt.setString(8, Suser_id); 
			  objCstmt.setString(9, "0");    //added new field   for chenge in Group travel Requsition  byu shiv  sharma 19-Feb-08
			  intSuccess3   =  objCstmt.executeUpdate();
	          objCstmt.close();   		  
			}
			int j = 0;
			for(int i=2; i<strExpID.length; i++)
			{          
	          objCstmt =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_EXPENDITURE_INT(?,?,?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST  Table
	          objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	          objCstmt.setString(2, strTravelId);
	          objCstmt.setString(3, strExpID[i]);                     //set the ExpId
	          objCstmt.setString(4, strTACurrency);                //set the current user Login UserId
	          objCstmt.setString(5, "0");
			  objCstmt.setString(6, "0");
	          objCstmt.setString(7, strContingecies[j++]);
			  objCstmt.setString(8, Suser_id);
			   objCstmt.setString(9, "0");    //added new field   for chenge in Group travel Requsition   by shiv sharma on 19-Feb-08
			  intSuccess4   =  objCstmt.executeUpdate();
	          objCstmt.close();		  
			}*/
	
			//added by manoj chand on 09 oct 2012 to insert expenditure details.
			for(int i=0; i<strEntPerDay.length; i++)
			{
			  if(strEntPerDay[i]==null || strEntPerDay[i].equals(""))
				  strEntPerDay[i]="0";
			  if(strTotalTourDay[i]==null || strTotalTourDay[i].equals(""))
				  strTotalTourDay[i]="0";
			  if(strEntPerDay2[i]==null || strEntPerDay2[i].equals(""))
				  strEntPerDay2[i]="0";
			  if(strTotalTourDay2[i]==null || strTotalTourDay2[i].equals(""))
				  strTotalTourDay2[i]="0";
			  if(strContingecies[i]==null || strContingecies[i].equals(""))
				  strContingecies[i]="0";
			  if(strContingecies2[i]==null || strContingecies2[i].equals(""))
				  strContingecies2[i]="0";
			  if(strTotalForex[i]==null || strTotalForex[i].equals(""))
				  strTotalForex[i]="0";
			  if(strTACurrency[i]!=null)
					strTACurrency[i]=strTACurrency[i].trim();
			  if(strTotalINR[i]==null || strTotalINR[i].equals(""))
				  strTotalINR[i]="0";
  
	          objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_EXPENDITURE_INT(?,?,?,?,?,?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST  Table        
	          objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	          objCstmt.setString(2, strTravelId);
	          objCstmt.setString(3, strTACurrency[i]);
	          objCstmt.setDouble(4, Double.parseDouble(strEntPerDay[i]));                       //set the ExpId
	          objCstmt.setString(5, strTotalTourDay[i]);                //set the current user Login UserId
	          objCstmt.setDouble(6, Double.parseDouble(strEntPerDay2[i]));
			  objCstmt.setString(7, strTotalTourDay2[i]);
			  objCstmt.setDouble(8, Double.parseDouble(strContingecies[i]));
			  objCstmt.setDouble(9, Double.parseDouble(strContingecies2[i]));
		      objCstmt.setDouble(10,Double.parseDouble(strTotalForex[i]));
			  objCstmt.setString(11, Suser_id); 
			  objCstmt.setString(12, "0");    //added new field   for chenge in Group travel Requsition  byu shiv  sharma 19-Feb-08
			  if(strHiddenValue[i].equals("v") && Double.parseDouble(strTotalINR[i])>0){
				  intSuccess3   =  objCstmt.executeUpdate();
			  }
			  
	          objCstmt.close();
			}
			
			//Procedure for insert the Cash BereakUp data into the T_Cash_Breakup_Int
			if(strCashAmount1!=null && !strCashAmount1.equals(""))
	        {
	          objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_CASH_BREAKUP_INT(?,?,?,?)}");//PROCEDURE to insert the row in T_CASH_BREAKUP_INT  Table
	          objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	          objCstmt.setString(2, strTravelId);
	          objCstmt.setString(3, strCashAmount1);                     //set the Cash Break up Amount
	          objCstmt.setString(4, strCashCurrency1);                //set the Cash Break up Currency
	          
			  objCstmt.setString(5, "n");                //set the OtherCurrency Flag n
	
			  intSuccess5   =  objCstmt.executeUpdate();
	          objCstmt.close();
			}
	 
	
			if(strCashAmount2!=null && !strCashAmount2.equals(""))
	        {
	          objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_CASH_BREAKUP_INT(?,?,?,?)}");//PROCEDURE to insert the row in T_CASH_BREAKUP_INT  Table
	          objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	          objCstmt.setString(2, strTravelId);
	          objCstmt.setString(3, strCashAmount2);                    //set the Cash Break up Amount
	          objCstmt.setString(4, strCashCurrency2);                //set the Cash Break up Currency
			  objCstmt.setString(5, "n");                //set the OtherCurrency Flag n
			  intSuccess6   =  objCstmt.executeUpdate();
	          objCstmt.close();
			}
			if(strCashAmount3!=null && !strCashAmount3.equals(""))
	        {
	          objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_CASH_BREAKUP_INT(?,?,?,?)}");//PROCEDURE to insert the row in T_CASH_BREAKUP_INT  Table
	          objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	          objCstmt.setString(2, strTravelId);
	          objCstmt.setString(3, strCashAmount3);                     //set the Cash Break up Amount
	          objCstmt.setString(4, strCashCurrency3);                //set the Cash Break up Currency
	
			  objCstmt.setString(5, "n");                //set the OtherCurrency Flag n
			  
			  intSuccess7   =  objCstmt.executeUpdate();
	          objCstmt.close();
			}
			if(strCashAmount4!=null && strCashCurrency4!=null && !strCashAmount4.equals("") && !strCashCurrency4.equals(""))
	        {
	          objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_CASH_BREAKUP_INT(?,?,?,?)}");//PROCEDURE to insert the row in T_CASH_BREAKUP_INT  Table
	          objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	          objCstmt.setString(2, strTravelId);
	          objCstmt.setString(3, strCashAmount4);                     //set the Cash Break up Amount
	          objCstmt.setString(4, strCashCurrency4);                 //set the Cash Break up Currency
	
	
			  objCstmt.setString(5, "y");                //set the OtherCurrency Flag y
	
			  intSuccess7   =  objCstmt.executeUpdate();
	          objCstmt.close();
			}
			
			
		 	// added MATA Initial and MATA Final when Pricing desicion will take place
             
			if(strmataprice.equalsIgnoreCase("y")){  		
				 if(strTkAgent.equalsIgnoreCase("n")){ 
				objCstmt=objCon.prepareCall("{?=call PROC_UPDATE_TRAVEL_TICKET_DETAIL(?,?,?,?,?,?,?,?)}");
				objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				objCstmt.setString(2,strTravelId);
				objCstmt.setString(3,"I");
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
	
					objCstmt=objCon.prepareCall("{?=call PROC_UPDATE_TRAVEL_TICKET_DETAIL(?,?,?,?,?,?,?,?)}");
					objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					objCstmt.setString(2,strTravelId);
					objCstmt.setString(3,"I");
					objCstmt.setString(4,strTkAgent);
					objCstmt.setString(5,"");
					objCstmt.setString(6,"USD");
					objCstmt.setInt(7,0);
					objCstmt.setString(8,"");
					objCstmt.setString(9,Suser_id); 
				    objCstmt.executeUpdate();
			        objCstmt.close(); 
				}
			}	 
			
	        //Call this block when user want to submit the requisition in workflow
			if(strWhatAction != null && strWhatAction.equals("saveProceed"))
	        {
	          //// added new 
				 if(flag!="no") 
					{
							 int intTravelId =Integer.parseInt(strTravelId);
				             int intBillingClient =Integer.parseInt(strBillingClient);
				             int intTravellerId =Integer.parseInt(strTravellerId);
							 int intC_userid= Integer.parseInt(Suser_id);
			 
								
							objCon               =  dbConBean.getConnection(); 
							objCstmt=objCon.prepareCall("{?=call PROC_APPROVER_OF_OTHERSITE(?,?,?,?,?)}");
							objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setInt(2,intTravelId);
							objCstmt.setString(3,"I");
							objCstmt.setInt(4,intBillingClient);
							objCstmt.setInt(5,intTravellerId);
							objCstmt.setInt(6,intC_userid);// new field added on 1/24/2008  by shiv  Sharma 
						    objCstmt.executeUpdate();
					        objCstmt.close();
	                }
	          
//added by manoj chand on 03 dec 2012 to make 350$ check
			//if(!strPerDayAmtinUSD.equals("") && Double.parseDouble(strPerDayAmtinUSD)>350)
			//{
// 				strMessage = "ExpenceCheck";
// 				String url2 = "T_IntForex_Details.jsp?message="+strMessage+"&travelId="+strTravelId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&travellerSiteId="+strTravllerSiteId+"&travelReqNo="+strTravelReqNo+"&interimId="+strInterimId;
// 				RequestDispatcher rd = request.getRequestDispatcher(url2);
// 				rd.include(request,response);
// 				return;

				con3 = dbConBean.getConnection();
				st3 = con3.createStatement();
				String strQuery="SELECT DISTINCT 1 FROM (SELECT *,DBO.FN_CURRENCY_CONVERTOR(TOTALEXPENCE,CURRENCY,'USD',CONVERT(VARCHAR(10),GETDATE(),103)) AS TOTAL_EXP"+
						" FROM (SELECT TTEI.G_USERID ,TDI.TRAVEL_ID, TDI.TRAVEL_DATE FORMDATE, CASE WHEN TRJDI.TRAVEL_DATE IS NULL OR YEAR(TRJDI.TRAVEL_DATE) = 1900"+ 
						" THEN TDI.TRAVEL_DATE ELSE TRJDI.TRAVEL_DATE END RETDATE,"+ 
						" TRJDI.TRAVEL_DATE RETURN_DATE ,MS.CURRENCY,"+
						" SUM(DBO.FN_CURRENCY_CONVERTOR(TTEI.TOTAL_EXP_ID,RTRIM(LTRIM(TTEI.CURRENCY)),MS.CURRENCY,CONVERT(VARCHAR(10),GETDATE(),103))) AS TOTALEXPENCE,"+
						" (SELECT SUM(TOTAL_TOUR_DAYS) FROM T_TRAVEL_EXPENDITURE_INT"+ 
						" WHERE TRAVEL_ID = TDI.TRAVEL_ID AND G_USERID =TTEI.G_USERID AND EXP_ID = 1) EXP_TOUR_DAYS,"+
						" (SELECT SUM(TOTAL_TOUR_DAYS) FROM T_TRAVEL_EXPENDITURE_INT WHERE TRAVEL_ID = TDI.TRAVEL_ID"+ 
						" AND G_USERID =TTEI.G_USERID AND EXP_ID = 2) HOTEL_TOUR_DAYS "+
						" FROM T_TRAVEL_EXPENDITURE_INT TTEI "+
						" INNER JOIN T_TRAVEL_STATUS TTDI ON TTEI.TRAVEL_ID=TTDI.TRAVEL_ID"+
						" INNER JOIN [M_EXPENDITURE] ME ON TTEI.EXP_ID=ME.EXP_ID AND ME.TRAVEL_TYPE='I'"+
						" LEFT JOIN T_TRAVEL_DETAIL_INT TDI ON TDI.TRAVEL_ID=TTEI.TRAVEL_ID"+
						" LEFT JOIN  T_RET_JOURNEY_DETAILS_INT TRJDI ON TRJDI.TRAVEL_ID = TDI.TRAVEL_ID"+ 
						" LEFT JOIN M_SITE MS ON TDI.SITE_ID=MS.SITE_ID"+
						" LEFT OUTER JOIN M_USERINFO UIM ON TDI.TRAVELLER_ID=UIM.USERID     "+
						" LEFT OUTER JOIN T_GROUP_USERINFO UIM1 ON TTEI.G_USERID=UIM1.G_USERID AND UIM1.TRAVEL_TYPE= 'I'"+
						" AND UIM1.TRAVEL_ID= TTEI.TRAVEL_ID AND UIM1.STATUS_ID=10"+
						" WHERE TTEI.TRAVEL_ID='"+strTravelId+"' AND TTEI.APPLICATION_ID=1 AND TTDI.TRAVEL_TYPE='I' "+
						" GROUP BY TDI.TRAVEL_ID,TTEI.G_USERID,TRJDI.TRAVEL_DATE,TDI.TRAVEL_DATE,MS.CURRENCY)DRV)DRV_MST"+
						" WHERE (TOTAL_EXP/CASE WHEN RETURN_DATE IS NULL OR YEAR(RETURN_DATE) = 1900 THEN"+  
						" CASE WHEN HOTEL_TOUR_DAYS >0 THEN HOTEL_TOUR_DAYS ELSE"+
						" CASE WHEN EXP_TOUR_DAYS >0 THEN EXP_TOUR_DAYS ELSE DATEDIFF(DAY,FORMDATE,RETDATE)+1 END END"+ 
						" ELSE DATEDIFF(DAY,FORMDATE,RETDATE)+1 END)>350";							
//System.out.println("strQuery:::::::::::::::::" + strQuery);
				rs3 = st3.executeQuery(strQuery);
				if (rs3.next()) {
					strMessage = "ExpenceCheck";
					String url2 = "T_IntForex_Details.jsp?message="+strMessage+"&travelId="+strTravelId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&travellerSiteId="+strTravllerSiteId+"&travelReqNo="+strTravelReqNo+"&interimId="+strInterimId;
					RequestDispatcher rd = request.getRequestDispatcher(url2);
					rd.include(request,response);
					return;
				}
				
				//System.out.println("--->   After check");
				rs3.close();
				st3.close();
				
				
			//}
			//else
			//{	
			//con3.close();
			//modification by vaibhav ends
			//added by manoj chand on 12 oct 2011 to show requesition number as per site selected for creating request
				if(!strTravllerSiteId.trim().equalsIgnoreCase(strSiteIdSS)){
					String strsiteName="";
					strSql="select site_name from m_site where site_id="+strTravllerSiteId;
					 rs = dbConBean.executeQuery(strSql);
						while(rs.next()){  
							strsiteName = rs.getString("site_name");	 		
						 }
					strPermanent_Req_No = strsiteName.trim()+ "/INT/" + strTravelId;
					rs.close();
				}else{			
	           strPermanent_Req_No = strSiteFullName.trim()+"/INT/"+strTravelId;
				}
	
	
	          // Added on 28 may 2009 for stoping mail when use referesh the page   
			   session.setAttribute("strSetFlage","1"); 
	
	            
	           objCstmt             =  objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_STATUS(?,?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST  Table
	           objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	           objCstmt.setString(2, strTravelId);
	           objCstmt.setString(3, strTravelReqId);
	           objCstmt.setString(4, "2");                        //SET THE  TRAVEL_STATUS_ID 2 AS A PERMANENT REQUEST FOR THE WORKFLOW
			   objCstmt.setString(5, strTravelType);
			   objCstmt.setString(6, strPermanent_Req_No);
	           intSuccess8   =  objCstmt.executeUpdate();
	           
	           objCstmt.close();
	
			   if ( strInterimId!= null && !"".equals(strInterimId)) 
				{
				   //Procedure for delete the all temp detail from T_INTRIM_JOURNEY
				   objCstmt             =  objCon.prepareCall("{?=call PROC_DELETE_INTERIM_JOURNEY(?,?)}");
				   objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				   objCstmt.setString(2, strInterimId);
				   objCstmt.setString(3, strTravelType);
				   int iSuccess4   =  objCstmt.executeUpdate();
				   objCstmt.close();
			   }
	
				// Procedure for inserting the version for T_TRAVEL_DETAIL_INT, T_JOURNEY_DETAIL_INT, T_RET_JOURNEY_DETAIL_INT in the audit table  
	            objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_IN_ALL_AUDIT_INT(?,?)}");
	 		    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				objCstmt.setString(2, strTravelReqId);
				objCstmt.setString(3, strTravelId);
				//System.out.println("aaaaa::abbbbb:;;3.3");
				int iSuccess4   =  objCstmt.executeUpdate();
				//System.out.println("aaaaa::abbbbb:;;3");
				objCstmt.close();  
	
			  //System.out.println("-----------------------------5----------------------------------------");
		    
				ArrayList aList_insertFinalApprvr = new ArrayList();
				int numColumns = 1;
				int updateCheck = 0;
				String	colLabb ="" ;
				String	colVals = "";

				// when originator select the self option of Billing instruction, then we will make only one approver that must be MATA	
				if(strBillingClient != null && strBillingClient.equals("self"))
				{
					// Added by Pankaj to add the last approver to approver list if the final receiver is not having the MATA role with him.  STARTS
				   strSql = " "+
								"select	1 "+
								"FROM	M_DEFAULT_APPROVERS AS DA INNER JOIN "+
								"M_USERINFO AS MA ON DA.APPROVER_ID = MA.USERID "+
								"WHERE	(DA.SITE_ID = "+strTravllerSiteId+") AND (DA.TRV_TYPE = 'I') AND (MA.sp_role = "+SSstrSplRole+") AND (MA.ROLE_ID = 'MATA') AND (DA.STATUS_ID = 10) AND "+
								"(MA.STATUS_ID = 10) AND (MA.APPLICATION_ID = 1) AND (DA.APPLICATION_ID = 1) ";
					   rs       =   dbConBean1.executeQuery(strSql);  
					   if (rs.next()==true){
					   }else{
							strSql = "SELECT *  FROM T_APPROVERS WHERE TRAVEL_ID="+strTravelId+" AND  ORDER_ID = (SELECT MAX(ORDER_ID) FROM T_APPROVERS WHERE TRAVEL_ID="+strTravelId+" ) ";
							//System.out.println(strSql);
							rs=null;
							rs     = dbConBean1.executeQuery(strSql);
							ResultSetMetaData rsmd = rs.getMetaData();
							numColumns = rsmd.getColumnCount();
							if(rs.next()){
								for (int i_i = 2;    i_i <=numColumns;    i_i++) {
									colLabb = 	rsmd.getColumnLabel(i_i);
									colVals = rs.getString(colLabb);
									//System.out.println("colVals================"+colVals);
									if(colVals == null){
										colVals ="' ' ";
										aList_insertFinalApprvr.add(colVals);
									}else{
										aList_insertFinalApprvr.add("'"+colVals+"'");
									}


								}
								updateCheck = 1;
							}
							//rs.close();	
							//System.out.println("aList_insertFinalApprvr ===========>>>>>>>>"+aList_insertFinalApprvr);
					   }
					   rs.close();
						// Added by Pankaj to add the last approver to approver list if the final receiver is not having the MATA role with him.  ENdS

					//PROCEDURE for DELETE DATA FROM THE T_APPROVERS
				   //objCon.setAutoCommit(false);
					objCstmt             = objCon.prepareCall("{?=call PROC_DELETE_APPROVERS_CORRESPONDS_TRAVEL_ID(?,?,?)}"); 
					objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					objCstmt.setString(2, strTravelReqId);
					objCstmt.setString(3, strTravelId);
					objCstmt.setString(4, strTravelType); 
					intSuccess1   =  objCstmt.executeUpdate();
					objCstmt.close();
	
						// Added by Pankaj to add the last approver to approver list if the final receiver is not having the MATA role with him.  STARTS
							if(updateCheck == 1){
								Iterator itr =  aList_insertFinalApprvr.iterator();
								strSql = "insert into T_APPROVERS values ( ";
								while(itr.hasNext())
								{
									strSql += (String) itr.next() + " , ";
								}
								strSql=strSql.substring(0,strSql.length()-2);
								strSql += " ) ";

								updateCheck = dbConBean1.executeUpdate(strSql);
								//System.out.println("strSql -----gh--------       "+strSql+"    updateCheck   ==>>  "+updateCheck);
							}
						// Added by Pankaj to add the last approver to approver list if the final receiver is not having the MATA role with him.  ENDS

					// Insert Approver which have role of MATA FOR INTERNATIONAL
					//strSql = "SELECT USERID, ROLE_ID FROM M_USERINFO WHERE ROLE_ID='MATA'AND STATUS_ID=10 AND APPLICATION_ID=1";
	
					//added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma 
					//Query adde by shiv for SMR USER for Case of self billing on 23-Feb-10
	             	//change manoj
	                if(ssflage.equals("1")){ 
		                strSql  = "SELECT DISTINCT APPROVER_ID AS USERID, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS "+
		                	 " USERROLE, DA.SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS DA, M_USERINFO MA WHERE "+
                             "	DA.SITE_ID="+strTravllerSiteId+" AND DA.TRV_TYPE='I' AND 	DA.sp_role="+SSstrSplRole+"  AND MA.STATUS_ID=10 AND "+
                             " order_id=(select max(order_id) from M_DEFAULT_APPROVERS where site_id="+strTravllerSiteId+" and TRV_TYPE='I' and sp_role="+SSstrSplRole+")  and  "+
		                	 "MA.APPLICATION_ID=1 AND  DA.STATUS_ID=10 AND DA.APPLICATION_ID=1";  
	                }else{
	                	//change manoj
		                strSql  = "SELECT DISTINCT APPROVER_ID AS USERID, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, DA.SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS DA, M_USERINFO MA WHERE MA.USERID=DA.APPROVER_ID AND DA.SITE_ID="+strTravllerSiteId+" AND DA.TRV_TYPE='I' AND DA.sp_role="+SSstrSplRole+"  AND MA.ROLE_ID='MATA' AND MA.STATUS_ID=10 AND MA.APPLICATION_ID=1 AND  DA.STATUS_ID=10 AND DA.APPLICATION_ID=1"; 
	                } 
					
	               // System.out.println("strSql==============="+strSql); 
	                
					rs     = dbConBean1.executeQuery(strSql);
					if(rs.next())
					{
						strApproverId          =  rs.getString("USERID");
						strApproverRole        =  rs.getString("USERROLE");  
					}
					rs.close();	
					strApprove_Id       = dbUtilityBean.getNewId("T_APPROVERS","APPROVE_ID")+""; 
					strApproverOrderId  = "1";
	
	
					objCstmt             = objCon.prepareCall("{?=call PROC_INSERT_T_APPROVERS(?,?,?,?,?,?,?,?,?,?)}"); 
					objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					objCstmt.setString(2, strApprove_Id);            //set the Approve Id      
					objCstmt.setString(3, strTravelId);             //set the Travel Id    
					objCstmt.setString(4, strTravllerSiteId);                //set the Traveller Site Id  
					objCstmt.setString(5, strTravellerId);           //Set the Traveller Id
					objCstmt.setString(6, strTravelType);            //Set the TravelType 
			 
					objCstmt.setString(7, strApproverId);            //Set the Approver Id
					objCstmt.setString(8, strApproveStatus);         //Set the Approve Status(0-no approve, 10-approve, 3-return, 4-rejected)
					objCstmt.setString(9, strApproverOrderId);       //Set the Approver Order Id in which  order approver approve the requsition
					objCstmt.setString(10, strApproverRole);         //Set the Approver Role
					objCstmt.setString(11, Suser_id);                //Set the Login user id 
			   
				   if(updateCheck == 0){		//  if(updateCheck == 0) -  added by Pankaj Dubey on 11-May-10			 
						intSuccess10   =  objCstmt.executeUpdate();
				   }

					//intSuccess10   =  objCstmt.executeUpdate();
					objCstmt.close();
					//System.out.println("intsuccess is=============="+intSuccess10);
				}
			//}
			  //System.out.println("-----------------------------6----------------------------------------");
			//strMessage = dbLabelBean.getLabel("message.global.save",strsesLanguage);
			strMessage = "save";
			//con3.close();
		}else if(strWhatAction != null && strWhatAction.equals("saveExit")){
			strMessage = "save";
			
		}
		}
		catch(Exception e)
		{
			System.out.println("Error in T_IntForex_Details_Post.jsp===="+e);
			strMessage = "notSave";
		}
	    if(intSuccess1 > 0 )
	    {
		   //objCon.commit();   
	    }
	    else
	    {
		   //objCon.rollback();
	    }
	%>
	
	
	
	
	
	<%
	   dbConBean.close();  // CLOSE ALL CONNECTION
	   
	//System.out.println("strWhatAction========================="+strWhatAction);
	//System.out.println("strMessage========================="+strMessage);
	if(strMessage != null && strMessage.equals("save"))
	{
		if(strWhatAction != null && strWhatAction.equals("save"))
		{
		  url = "T_IntForex_Details.jsp?message="+strMessage+"&travelId="+strTravelId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&travellerSiteId="+strTravllerSiteId+"&travelReqNo="+strTravelReqNo+"&interimId="+strInterimId;
		}
		else if(strWhatAction != null && strWhatAction.equals("saveExit"))
		{
			url = "T_TravelRequisitionList.jsp?travel_type=INT";
		}
		else if(strWhatAction != null && strWhatAction.equals("saveProceed"))
		{
		  if(intSuccess8 > 0)
		  {
	
			url = "FinallySubmitted.jsp?travelId="+strTravelId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&travellerSiteId="+strTravllerSiteId+"&travelReqNo="+strPermanent_Req_No+"&ReqTyp=I&interimId="+strInterimId+"&flag="+strSetFlage; 
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
		url = "T_IntForex_Details.jsp?message="+strMessage+"&travelId="+strTravelId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&travellerSiteId="+strTravllerSiteId+"&travelReqNo="+strTravelReqNo+"&interimId="+strInterimId;
	}
	   response.sendRedirect(url);
	}%>
	
