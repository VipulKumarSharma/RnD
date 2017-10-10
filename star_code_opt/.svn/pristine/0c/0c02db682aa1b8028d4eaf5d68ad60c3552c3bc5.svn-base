	
	<%/**********************************************************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:Abhinav Ratnawat
	 *Date of Creation 		:11 September 2006
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment	:Tomcat, sql server 2000 
	 *Description 			:This is first jsp file  for updating the SITE in the STAR Database
	 *Modification 			:1 Change the Billing Instruction(add three radio for self,SMG, and other SMG) and Add currency combo
	                                 3.Change the code for showing billing client in  different  cases by shiv  Sharma on 06-Nov-07    
									 4  Added new field on 1/24/2008 by shiv 
									 5 Added on 28 may 2009 for stoping mail when use referesh the page
									 6://added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma 
									 7:Change code for price analysis with mata and local travel agent on 23-Nov-09 byb shiv sharma 
									 8::added code for showing other currency in domestic group travel on 03-Mar-10 by shiv sharma
	 *Reason of Modification: change suggested by MATA
	 *Date of Modification  :2 Nov 2006 
	 *Modified By	        :SACHIN GUPTA
	 *Reason of Modification: Dear null mail is going in case if the final approver is not the MATA personal in any particular workflow and billing selected as self.
	 *Date of Modification  :12 May 2010 
	 *Modified By	        :PANKAJ DUBEY
	 :Modified by Pankaj Dubey on 11 Nov 2010 to add 5 new fields to record budgetory figures.
	 *Editor				:Editplus
	 
	 *Modification			:modify workflow as per selected site
	 *Date of modification  :12 Oct 2011
	 *Modified By     		:Manoj Chand
	 
	 *Modification				:Multilingual functionality added
	 *Modified by				:Manoj Chand
	 *Date of Modification		:24 May 2012
	 
	 *Modification				:Save Travel fare currency and fare amount
	 *Modified by				:Manoj Chand
	 *Date of Modification		:29 Nov 2012
	 ***************************************************************************************************/
	%>
	<%@ page buffer="5kb" language="java" import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*"%>
	<HTML>
	<HEAD>
	<%-- include remove cache  --%>
	<%@ include file="cacheInc.inc"%> 
	<%-- include header  --%>
	<%@ include file="headerIncl.inc"%>
	<%-- include page with all application session variables --%>
	<%@ include file="application.jsp"%>
	<%-- include page styles  --%>
	<%--<%@ include  file="systemStyle.jsp" %>--%>
	
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />
	
	<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<TITLE>Domestic Travel Section Detailed</TITLE>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css"></link>
	</HEAD>
	
	<%
	request.setCharacterEncoding("UTF-8");
	
	Connection objCon,con3						=  null;            //Object for Connection 
	ResultSet rs,rs1,rs2,rs3					=  null;            // Object for ResultSet
	CallableStatement objCstmt	    =  null;		    // Object for Callable Statement
	Statement st3 = null;
	
	
	int intSuccess1                          = 0;  
	int intSuccess10                         = 0;  
	
	String strUserID							=	Suser_id;
	String strTravelReqId					= "";
	String strTravelId		      				= "";
	String strTravellerId 					= "";
	
	
	String strTravellerSiteId 					= "";
	
	
	String strSite 								= "";
	String strSql  								= "";
	String strTotalAmount					  = "";
	String strTACurrency[]                    = null; 
	String strExpenditureRemarks	= "";
	
	// below 5 fields added by Pankaj on 11 Nov 10
	String dbl_YTM_BUDGET = "";
	String dbl_YTD_ACTUAL = "";
	String dbl_AVAIL_BUDGET = "";
	String dbl_EST_EXP = "";
	String str_EXP_REMARKS = "";
	  
	  
	String strBillingTo 						= "";	
	
	String strBillingSMGSite        = "";
	
	
	String strClientName					= "";
	String strFlag1								= "";	
	String strPermanent_Req_No	=	"";
	String strTravelType					= "D";
	String strInterimID						= "";
	
	String strEntPerDay[]					= null;
	String strTotalTourDay[]				= null;
	String strExpIdCount					= "";
	String strExpIdTotal[]					= null;
	String strExpConteng[]			    	= null;
	String strEntPerDay2[]	     		    =  null;
	String strContingecies2[]       		=  null;
	String strTotalTourDay2[]       		=  null;
	String strExRate[]        	  			=  null;
	String strTotalINR[]        	  		=  null;
	String strHiddenValue[]		  			=  null;
	String strBaseCurrency					=  null;
	
	
	String strApproverId            =  "";   
	String strApproveStatus         =  "0"; 
	String strApproverOrderId       =  "";   
	String strApproverRole          =  ""; 
	String strApprove_Id            =  "";
	
	String strMessage               =  "";  
	String strUrl                   =  "";  
	String strApprover_otherSite ="";//added  new for billing site approver 
	
	String flag =""; 
	
	
	
	String strTkAgent 		=""; 
	String strTkAirLine 	=""; 
	String strTkcurrency 	=""; 
	String strTklocalprice 	=""; 
	String strTkRemarks 	=""; 
	
	 String strmataprice =request.getParameter("matapricecomp"); 
	
//System.out.println("strmataprice==="+strmataprice);
	
	if(strmataprice.equalsIgnoreCase("y")){ 
		
	 strTkAgent 			=request.getParameter("tkflyes");
	 strTkAirLine 			=request.getParameter("airline");
	 strTkcurrency 			=request.getParameter("currency");
	 strTklocalprice 		=request.getParameter("localprice"); 
	 strTkRemarks 			=request.getParameter("pricingRemarks"); 
	 
	}
	 
	
	String strSiteid=request.getParameter("hiddsiteid")==null?strSiteIdSS:request.getParameter("hiddsiteid");
	String strSMPSiteFlag=request.getParameter("hdsmpsiteflag")==null?"":request.getParameter("hdsmpsiteflag");
	
	strTravelId					= request.getParameter("travelId");
	strTravelReqId				= request.getParameter("travelReqId");
	strTravellerId				= request.getParameter("travellerId");
	strTravellerSiteId         	= request.getParameter("travellerSiteId");
	
	//System.out.println("strTravellerSiteId====in Forex Post is===="+strTravellerSiteId);
	strEntPerDay				= request.getParameterValues("entitlement");     
	strTotalTourDay	 			= request.getParameterValues("tourDays");     
	strExpIdTotal				= request.getParameterValues("totalForex");
	strExpConteng				= request.getParameterValues("contingencies");
	//ADDED BY MANOJ CHAND ON 11 OCT 2012 TO GET VALUES 
	strEntPerDay2                   =  request.getParameterValues("entitlement2");     
	strTotalTourDay2                =  request.getParameterValues("tourDays2");     
	strContingecies2                =  request.getParameterValues("contingencies2");
	strExRate              		    =  request.getParameterValues("exRate");     
	strTotalINR						=  request.getParameterValues("totalInr");
	strHiddenValue					=  request.getParameterValues("hd");
	strBaseCurrency                 =  request.getParameter("basecur")==null?"INR":request.getParameter("basecur");
	String strPerDayAmtinUSD		=  request.getParameter("grandTotalForexUSD")==null?"0.00":request.getParameter("grandTotalForexUSD");
	String strTotalFareCurrency		=  request.getParameter("TotalFareCurrency")==null?"":request.getParameter("TotalFareCurrency");
	String strTotalFareAmount		=  request.getParameter("TotalFareAmount")==null?"0":request.getParameter("TotalFareAmount");
	String strTravelReqNo			=  request.getParameter("travelreqno")==null?"":request.getParameter("travelreqno");
	//END HERE
	
	
	strTotalAmount				= request.getParameter("grandTotalForex");    
	strTACurrency               = request.getParameterValues("expCurrency");    
	strExpenditureRemarks		= request.getParameter("expRemarks");
	
	dbl_YTM_BUDGET        		=  request.getParameter("YtmBud")==null?"0":request.getParameter("YtmBud");
	dbl_YTD_ACTUAL        		=  request.getParameter("YtmAct")==null?"0":request.getParameter("YtmAct");
	dbl_AVAIL_BUDGET        	=  request.getParameter("AvailBud")==null?"0":request.getParameter("AvailBud");
	dbl_EST_EXP        			=  request.getParameter("EstExp")==null?"0":request.getParameter("EstExp");
	str_EXP_REMARKS        		=  request.getParameter("budgetRemarks")==null?"":request.getParameter("budgetRemarks");  
	  
	strBillingTo				= request.getParameter("billingTo");
	strBillingSMGSite       	=  request.getParameter("billingSMGSite")==null ?"" :request.getParameter("billingSMGSite");  
    strClientName             	=  request.getParameter("billingSMGUser")==null?"0":request.getParameter("billingSMGUser");    
	  
	  if (strClientName.equals("0"))
	  {
		   flag ="no"; 
		  strClientName                 =  request.getParameter("clientName")==null?"0":request.getParameter("clientName");    
	  }
	strFlag1											= request.getParameter("flag1");
	strInterimID									= request.getParameter("interimId");
	
	//Added By Gurmeet Singh
	String strUserAccessCheckFlag = "";
	
	strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(Suser_id, strTravellerSiteId, "0");		  
	if(!strUserAccessCheckFlag.equals("420")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strTravellerId, strTravellerSiteId, "0");
	} 
	if(strBillingSMGSite.equals(strTravellerSiteId) && !strUserAccessCheckFlag.equals("420")){
		if(!strClientName.equals("-1")){
			strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strClientName, strBillingSMGSite, "4");
		} 
	} 	
 	if(!strBillingSMGSite.equals(strTravellerSiteId) && !strUserAccessCheckFlag.equals("420")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strClientName, strBillingSMGSite, "4");
	}	
 	if(!strUserAccessCheckFlag.equals("420")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthEditTravelReq(strTravelId, "D", Suser_id);		
	}
	
 	if(strUserAccessCheckFlag.equals("420")){	
		dbConBean.close();  
		dbConBean1.close();		
		securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_TravelDetail_Dom_Forex_Post.jsp", "Unauthorized Access");
		response.sendRedirect("UnauthorizedAccess.jsp");		
	} else {
	
	//System.out.println("strFlag1======"+strFlag1);
	
	//added new for new billing site approver  on 30-Oct-07
	
	String strTravellerRole  = "";
	
	strSql = "SELECT LTRIM(RTRIM(ISNULL(ROLE_ID,'OR'))) AS ROLE_ID  FROM M_USERINFO WHERE USERID="+strTravellerId; 	
	///this is cases  when requsition is created for Chaiman then  procedure will now run to add any approvers.
//System.out.println("strSql------1----------->"+strSql);	
	rs = dbConBean.executeQuery(strSql)	;   
			if(rs.next())
						{
							 strTravellerRole = rs.getString("ROLE_ID");
						if(strTravellerRole.equalsIgnoreCase("CHAIRMAN"))
							 {
								 flag ="no"; 
	                        }
						}
	
						 if (strClientName.equals("-1"))
						 {
							 flag ="no"; 
						 }
						 if(strClientName.equals("0"))
						 {
							flag ="no"; 
						 }
	  
	
	  
	
	
	  if(strBillingTo != null && strBillingTo.equals("self"))
	  {
	     strSite = "0";                //when Traveller will pay the travel charge
		 strClientName = "self";
	  }
	  else if(strBillingTo != null && strBillingTo.equals("SMG"))
	  {
		  strSite = strBillingSMGSite;                     //when traveller selected site will pay the travel charge
	  }
	  else if(strBillingTo != null && strBillingTo.equals("outSideSMG"))
	  {
	      strSite = "-1";             //when Other SMG Client will pay the travel charge   	 
	  }
	
	
	/*if  (strBillingTo.equals("self") ) {
		strSql = "SELECT SITE_ID AS SITE_ID FROM M_USERINFO WHERE USERID =" +strTravellerId;
		rs	=	dbConBean.executeQuery(strSql);
			if (rs.next()) {
				strSite = rs.getString(1);
			}
	
	} else if (strBillingTo.equals("site")) {
			strSite = strSiteIdSS;
	} */
	
	
	
	
	/*strSql ="SELECT  count(*) FROM M_EXPENDITURE WHERE TRAVEL_TYPE = 'D' AND STATUS_ID = 10 ORDER BY 1";
	//System.out.println("strsql-----------2----->"+strSql);
	rs = dbConBean.executeQuery(strSql)	;
	if (rs.next())	{
		strExpIdCount = rs.getString(1);
	}
	rs.close();		
	float intEntPerDay[]				= new float[Integer.parseInt(strExpIdCount)];
	float intTotalTourDay[]			= new float[Integer.parseInt(strExpIdCount)];
	float intTotalId[]						= new float[Integer.parseInt(strExpIdCount)]	;
	String[] strExpId					= new String[Integer.parseInt(strExpIdCount)];*/
	
	//commented by manoj chand on 16 oct 2012
	/*for (int k=0;k < strEntPerDay.length; k++) 
	{
		if(strEntPerDay[k] == null)
			strEntPerDay[k] = "0";
		else if(strEntPerDay[k].equals(""))
			strEntPerDay[k] = "0";
		
		intEntPerDay[k] = Float.parseFloat(strEntPerDay[k]);
	}
	for (int k=0;k < strTotalTourDay.length; k++) 
	{
		if(strTotalTourDay[k] == null)
			strTotalTourDay[k] = "0";
		else if(strTotalTourDay[k].equals(""))
			strTotalTourDay[k] = "0";
		
		intTotalTourDay[k] = Float.parseFloat(strTotalTourDay[k]);
	}
	for (int k=0;k < strExpIdTotal.length; k++) 
	{
		if(strExpIdTotal[k] == null)
			strExpIdTotal[k] = "0";
		else if(strExpIdTotal[k].equals(""))
			strExpIdTotal[k] = "0";
		
		intTotalId[k] = Float.parseFloat(strExpIdTotal[k]);
	}
	
	int z=2;
	for (int k=0;k < strExpConteng.length; k++) 
	{
		if(strExpConteng[k] == null)
			strExpConteng[k] = "0";
		else if(strExpConteng[k].equals(""))
			strExpConteng[k] = "0";
		
		intTotalId[z++] = Float.parseFloat(strExpConteng[k]);
	}*/
	
	//commented by manoj chand on 16 oct 2012
/*	strSql ="SELECT  EXP_ID FROM M_EXPENDITURE WHERE TRAVEL_TYPE = 'D' AND STATUS_ID = 10 ORDER BY 1";
	rs = dbConBean.executeQuery(strSql)	;
	int m = 0;
	while (rs.next())	{
		strExpId[m++] = rs.getString(1);
	}
	rs.close();	*/
	
	//flag variables
	int iSuccess1 = 0;
	int iSuccess2 = 0;
	int iSuccess3 = 0;
	int iSuccess4 = 0;
	%>
	
	<BODY>
	<form name="frm" method="post" >
	<% 
	try 
	{
		objCon               =  dbConBean.getConnection(); 
	
		//Procedure for delete the date from the T_TRAVEL_EXPENDITURE_INT 
		objCstmt             =  objCon.prepareCall("{?=call PROC_DELETE_FOREX_DETAIL_TABLES_DOM(?)}");
		objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		objCstmt.setString(2, strTravelId);
		iSuccess1   =  objCstmt.executeUpdate();
		objCstmt.close();
		
	
	 // System.out.println("strClientName==strClientName= before proc="+strClientName);
	
	
		//System.out.println("site to be entered is"+strSite);
		objCstmt             =  objCon.prepareCall("{?=call PROC_UPDATE_BILLING_INFO_DOM(?,?,?,?,?,?,?,? , ?,?,?,?,?,?,?)}");
		objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		objCstmt.setString(2, strTravelId);
		objCstmt.setString(3, strSite);             
		objCstmt.setString(4, strClientName);
		objCstmt.setString(5, strTotalAmount);
		objCstmt.setString(6, strBaseCurrency);//strTACurrency before, now INR add by manoj chand on 11 oct 2012
		objCstmt.setString(7, strExpenditureRemarks);
		objCstmt.setString(8, "");          //Forex_modified_fields
		objCstmt.setString(9, Suser_id); 
	
		//below 5 parameters added by Pankaj on 11 Nov 10			
		objCstmt.setString(10, dbl_YTM_BUDGET);
		objCstmt.setString(11, dbl_YTD_ACTUAL);
		objCstmt.setString(12, dbl_AVAIL_BUDGET);
		objCstmt.setString(13, dbl_EST_EXP);
		objCstmt.setString(14, str_EXP_REMARKS);
		objCstmt.setString(15,strTotalFareCurrency);
		objCstmt.setInt(16,Integer.parseInt(strTotalFareAmount));
		//System.out.print("dbl_YTD_ACTUAL = >>//////"+dbl_YTD_ACTUAL);
		iSuccess2   =  objCstmt.executeUpdate();
		objCstmt.close();
	
		 
		//	System.out.println("before procedure");	
			for ( int k =0; k < strEntPerDay.length ; k++ ) {
		//	  System.out.println("count is"+k);
			 // objCon.setAutoCommit(false);
			  objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_EXPENDITURE_DOM(?,?,?,?,?,?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST  Table
			  /*objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			  objCstmt.setString(2, strTravelId);
			  objCstmt.setString(3, strExpId[k]);             //set the current user Site Id
			  objCstmt.setFloat(4, intEntPerDay[k]);                //set the current user Login UserId 
			  objCstmt.setFloat(5, intTotalTourDay[k]);
			  objCstmt.setFloat(6, intTotalId[k]);
			  objCstmt.setString(7, strUserID);
			  objCstmt.setString(8, "0");
			  objCstmt.setString(9, strTACurrency);                //added on 03 march 2010 by shiv sharma 
			  iSuccess3   =  objCstmt.executeUpdate();*/
			  //changed by manoj chand on 01 nov 2012 to insert travel expenditure in multiple currency.
			  if(strEntPerDay[k]==null || strEntPerDay[k].equals(""))
				  strEntPerDay[k]="0";
			  if(strTotalTourDay[k]==null || strTotalTourDay[k].equals(""))
				  strTotalTourDay[k]="0";
			  if(strEntPerDay2[k]==null || strEntPerDay2[k].equals(""))
				  strEntPerDay2[k]="0";
			  if(strTotalTourDay2[k]==null || strTotalTourDay2[k].equals(""))
				  strTotalTourDay2[k]="0";
			  if(strExpConteng[k]==null || strExpConteng[k].equals(""))
				  strExpConteng[k]="0";
			  if(strContingecies2[k]==null || strContingecies2[k].equals(""))
				  strContingecies2[k]="0";
			  if(strExpIdTotal[k]==null || strExpIdTotal[k].equals(""))
				  strExpIdTotal[k]="0";
			  if(strTACurrency[k]!=null)
				strTACurrency[k]=strTACurrency[k].trim();
			  if(strTotalINR[k]==null || strTotalINR[k].equals(""))
				  strTotalINR[k]="0";
			  
			  
			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	          objCstmt.setString(2, strTravelId);
	          objCstmt.setString(3, strTACurrency[k]);
	          objCstmt.setDouble(4, Double.parseDouble(strEntPerDay[k]));                       //set the ExpId
	          objCstmt.setString(5, strTotalTourDay[k]);                //set the current user Login UserId
	          objCstmt.setDouble(6, Double.parseDouble(strEntPerDay2[k]));
			  objCstmt.setString(7, strTotalTourDay2[k]);
			  objCstmt.setDouble(8, Double.parseDouble(strExpConteng[k]));
			  objCstmt.setDouble(9, Double.parseDouble(strContingecies2[k]));
		      objCstmt.setDouble(10,Double.parseDouble(strExpIdTotal[k]));
			  objCstmt.setString(11, Suser_id); 
			  objCstmt.setString(12, "0");    //added new field   for chenge in Group travel Requsition  byu shiv  sharma 19-Feb-08
			  
			  if(strHiddenValue[k].equals("v") && Double.parseDouble(strTotalINR[k])>0){
				  iSuccess3   =  objCstmt.executeUpdate();
			  }
			  objCstmt.close();
			}
			
			
			//	 added MATA Initial and MATA Final when Pricing desicion will take place
			 
			//System.out.println("strmataprice====="+strmataprice); 
			
			//System.out.println("strTkAgent====="+strTkAgent);
			
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
			
			//System.out.println("strFlag1====in dom forex post ===="+strFlag1);
	
			if(strFlag1 != null && strFlag1.equals("Proceed"))
			{
				  
				 
				////added new  procedure that added approver of billing site. by shiv sharma on 06-Nov-07  
				 if(flag!="no") 
					{
						      int intTravelId =Integer.parseInt(strTravelId);
				              int intBillingClient =Integer.parseInt(strClientName);
				              int intTravellerId =Integer.parseInt(strTravellerId);
							  int intC_userID =Integer.parseInt(strUserID);
	
							  
								
							objCon               =  dbConBean.getConnection(); 
							objCstmt=objCon.prepareCall("{?=call PROC_APPROVER_OF_OTHERSITE(?,?,?,?,?)}");
							objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setInt(2,intTravelId);
							objCstmt.setString(3,"D");
							objCstmt.setInt(4,intBillingClient);
							objCstmt.setInt(5,intTravellerId);
							objCstmt.setInt(6,intC_userID);   //Added new field on 1/24/2008 by shiv 
						    objCstmt.executeUpdate();
					        objCstmt.close();
	                }
				
	//code added by manoj chand on 03 dec 2012 to make 350$ dcheck			
// 						if(!strPerDayAmtinUSD.equals("") && Double.parseDouble(strPerDayAmtinUSD)>350)
// 						{
// 							strMessage = "ExpenceCheck";
// 							String url2 = "T_TravelDetail_Dom_Forex.jsp?message="+strMessage+"&travelId="+strTravelId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&travellerSiteId="+strTravellerSiteId+"&travelReqNo="+strTravelReqNo+"&interimId="+strInterimID+"&flagSave=save&smpsiteflag="+strSMPSiteFlag;
// 							RequestDispatcher rd = request.getRequestDispatcher(url2);
// 							rd.forward(request,response);
// 							return;
							
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
											String url2 = "T_TravelDetail_Dom_Forex.jsp?message="+strMessage+"&travelId="+strTravelId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&travellerSiteId="+strTravellerSiteId+"&travelReqNo="+strTravelReqNo+"&interimId="+strInterimID+"&flagSave=save&smpsiteflag="+strSMPSiteFlag;
											RequestDispatcher rd = request.getRequestDispatcher(url2);
											rd.forward(request,response);
											return;
										}
										
										rs3.close();
										st3.close();
						
// 						}else{
				
				
				//added by manoj chand on 12 oct to show request number based on selected site
				 if(!strSiteid.trim().equalsIgnoreCase(strSiteIdSS.trim())){
						String strsiteName="";
						strSql="select site_name from m_site where site_id="+strSiteid;
						 rs = dbConBean.executeQuery(strSql);
							if(rs.next()){  
								strsiteName = rs.getString("site_name");	 		
							 }
						strPermanent_Req_No = strsiteName.trim()+"/DOM/"+strTravelId;
						rs.close();
					}else{				
			   strPermanent_Req_No = strSiteFullName.trim()+"/DOM/"+strTravelId;
					}
			  
			   //Added on 28 may 2009 for stoping mail when use referesh the page 
			   session.setAttribute("strSetFlage","1"); 
			   
			   objCstmt             =  objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_STATUS_DOM(?,?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST  Table
			   objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			   
			  
			   objCstmt.setString(2, strTravelId);
			   objCstmt.setString(3, strTravelReqId);
			   objCstmt.setString(4, "2");                        //SET THE  TRAVEL_STATUS_ID 2 AS A PERMANENT REQUEST FOR THE WORKFLOW
			   objCstmt.setString(5, strTravelType);
			   objCstmt.setString(6, strPermanent_Req_No);
	
			
	           try{
			   iSuccess4   =  objCstmt.executeUpdate();
			   }catch(Exception e){
				   System.out.println("e==========1234"+e);
			   }

			  // objCstmt.close();
			
			   if (strInterimID != null && !"".equals(strInterimID.trim()) && ! strInterimID.trim().equals("null")) 
			   {
				  
				   objCstmt             =  objCon.prepareCall("{?=call PROC_DELETE_INTERIM_JOURNEY(?,?)}");//PROCEDURE to delete the row in T_Interim_Journey temp  Table
				   objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				   objCstmt.setString(2, strInterimID);
				   objCstmt.setString(3, strTravelType);
				   iSuccess4   =  objCstmt.executeUpdate();
				   objCstmt.close();
			   }
	
		 
				// Procedure for inserting the version for T_TRAVEL_DETAIL_INT, T_JOURNEY_DETAIL_INT, T_RET_JOURNEY_DETAIL_INT in the audit table  
					objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_IN_ALL_AUDIT_DOM(?,?)}");
					objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					objCstmt.setString(2, strTravelReqId);
					objCstmt.setString(3, strTravelId);
					
					try{
					 iSuccess4   =  objCstmt.executeUpdate();
					 }catch(Exception e){
						 System.out.println("error =========5678"+e);
					 }
	
		
					objCstmt.close();  
	//System.out.println("ssflage====="+ssflage); 

				ArrayList aList_insertFinalApprvr = new ArrayList();
				int numColumns = 1;
				int updateCheck = 0;
				String	colLabb ="" ;
				String	colVals = "";

			   // when originator select the self option of Billing instruction, then we will make only one approver that must be MATA	
					if(strBillingTo != null && strBillingTo.equals("self"))
					{





					// Added by Pankaj to add the last approver to approver list if the final receiver is not having the MATA role with him.  STARTS
					//change manoj
				   strSql = " "+
								"select	1 "+
								"FROM	M_DEFAULT_APPROVERS AS DA INNER JOIN "+
								"M_USERINFO AS MA ON DA.APPROVER_ID = MA.USERID "+
								"WHERE	(DA.SITE_ID = "+strSiteid+") AND (DA.TRV_TYPE = 'D') AND (MA.sp_role = "+SSstrSplRole+") AND (MA.ROLE_ID = 'MATA') AND (DA.STATUS_ID = 10) AND "+
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
	
						// Insert Approver which have role of MATA in Domestic Travel
						//strSql = "SELECT USERID, ROLE_ID FROM M_USERINFO WHERE ROLE_ID='MATA'AND STATUS_ID=10 AND APPLICATION_ID=1";
						//added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma 
						
						//System.out.println("ssflage====="+ssflage); 
						



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





						//ssflage  ==1 means user is from SMR  query change by shiv for SMR user  
						//change manoj
						if(ssflage.equals("1")){
							 strSql  = "SELECT DISTINCT APPROVER_ID AS USERID, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS "+ 
		                	 " USERROLE, DA.SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS DA, M_USERINFO MA WHERE "+
                             "	DA.SITE_ID="+strSiteid+" AND DA.TRV_TYPE='D' AND 	DA.sp_role="+SSstrSplRole+"  AND MA.STATUS_ID=10 AND "+
                             " order_id=(select max(order_id) from M_DEFAULT_APPROVERS where site_id="+strSiteid+" and TRV_TYPE='D' and sp_role="+SSstrSplRole+")  and  "+
		                	 "MA.APPLICATION_ID=1 AND  DA.STATUS_ID=10 AND DA.APPLICATION_ID=1";  
						}else{
							//change manoj
							strSql =  "SELECT DISTINCT APPROVER_ID AS USERID, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE,"+
							" DA.SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS DA, M_USERINFO MA WHERE MA.USERID=DA.APPROVER_ID AND "+
							" DA.SITE_ID="+strSiteid+" AND DA.TRV_TYPE='D' AND MA.sp_role="+SSstrSplRole+" AND MA.ROLE_ID='MATA' "+    
							" AND DA.STATUS_ID=10 AND MA.STATUS_ID=10 AND MA.APPLICATION_ID=1 AND DA.APPLICATION_ID=1";   
							
						} 
						//System.out.println("strSql=Pankaj===="+strSql);
	//System.out.println("strsql-----------4----->"+strSql);
						rs     = dbConBean1.executeQuery(strSql); 
						
						if(rs.next())
						{
							strApproverId          =  rs.getString("USERID");
							strApproverRole        =  rs.getString("USERROLE");   
							//System.out.println("strApproverId====="+strApproverId+" strApproverRole  :: "+strApproverRole); 
						}else{
						}
						rs.close();	
						
						strApprove_Id       = dbUtilityBean.getNewId("T_APPROVERS","APPROVE_ID")+""; 
						strApproverOrderId  = "1";
	                   
						//System.out.println("strApprove_Id="+strApprove_Id+",strTravelId="+strTravelId+",strTravellerSiteId="+strTravellerSiteId+",strTravellerId="+strTravellerId+",strTravelType="+strTravelType+",strApproverId="+strApproverId+",strApproveStatus="+strApproveStatus+",strApproveStatus="+strApproveStatus+",strApproverOrderId="+strApproverOrderId+",strApproverRole="+strApproverRole+",Suser_id="+Suser_id);

						objCstmt             = objCon.prepareCall("{?=call PROC_INSERT_T_APPROVERS(?,?,?,?,?,?,?,?,?,?)}"); 
						objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2, strApprove_Id);            //set the Approve Id      
						objCstmt.setString(3, strTravelId);             //set the Travel Id    
						objCstmt.setString(4, strTravellerSiteId);                //set the Traveller Site Id  
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
						objCstmt.close();
					}
			//}
						//con3.close();
			}
		//strMessage = dbLabelBean.getLabel("message.global.save",strsesLanguage);
			strMessage = "save";
	}	
	catch(Exception e)
	{
	    //strMessage = dbLabelBean.getLabel("message.global.notsaved",strsesLanguage);
	    strMessage = "notSave";
		System.out.println("Error in T_Traveldetail_Dom_Forex_Post.jsp===="+e);
	}
	  /* if( iSuccess3 >  0)
	    {
		   System.out.println("Data updated  and inserted successfully");
		   objCon.commit();   
	    }
	    else
	    {
	       System.out.println("Data not updated"); 
		   objCon.rollback();
	    }*/
	
		
	dbConBean.close();  // CLOSE ALL CONNECTION
	
	//System.out.println("strMessage is======"+strMessage);
	
	
	
	
	//System.out.println("strFlag1 is======"+strFlag1);
	
	if(strMessage !=null && strMessage.equals("save"))
	{
		if (strFlag1.equals("Proceed"))
		{
			strUrl = "FinallySubmitted.jsp?travelId="+strTravelId+"&travellerSiteId="+strTravellerSiteId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&travelReqNo="+strPermanent_Req_No+"&ReqTyp=D";	   
	     //response.sendRedirect("FinallySubmitted.jsp?travelId="+strTravelId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&travelReqNo="+strPermanent_Req_No+"&ReqTyp=D");	   
		}
		else if (strFlag1.equals("Save"))
		{
			strUrl = "T_TravelDetail_Dom_Forex.jsp?message="+strMessage+"&travelId="+strTravelId+"&travellerSiteId="+strTravellerSiteId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&interimId="+strInterimID+"&flagSave=save&smpsiteflag="+strSMPSiteFlag;
		    //response.sendRedirect("T_TravelDetail_Dom_Forex.jsp?travelId="+strTravelId+"&travellerSiteId="+strTravellerSiteId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&interimId="+strInterimID+"&flagSave=save");		
		}
		else if (strFlag1.equals("Exit")) 
		{
			strUrl = "T_TravelRequisitionList_D.jsp?travel_type=DOM";
			//response.sendRedirect("T_TravelRequisitionList_D.jsp?travel_type=DOM");
		}
	}
	else
	{
		strUrl = "T_TravelDetail_Dom_Forex.jsp?message="+strMessage+"&travelId="+strTravelId+"&travellerSiteId="+strTravellerSiteId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&interimId="+strInterimID+"&flagSave=save&smpsiteflag="+strSMPSiteFlag;
	}
	response.sendRedirect(strUrl);
	
	}%>
	
	</form>
	</body>
	</html>