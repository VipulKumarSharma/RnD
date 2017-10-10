 	
<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				     :Shiv sharma 
 *Date of Creation 	         :
 *Copyright Notice 		     :Copyright(C)2000 MIND.All rights reserved
 *Project	  			             :STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 		     	    : This is post page of  jsp file  for create the Travel Requsition
 *Modification 	    	    : //Code commented by shiv on 07 jan 2009 for not showing travel mode as requested by MATA
                            : added code for checking if approver is exits in defualt approver list on 19-01-2009 
							: Added on 28 may 2009 for stoping mail when use referesh the page  
							:added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma 
						             
 *Reason of Modification:
 *Date of Modification  :by vaibhav on sep 15 2010 to remove error in case of duplicate approvers
 						:Modified by vaibhav on 30 sep 201 to add constraint on per day expense.
 *Modified by Pankaj Dubey on 11 Nov 2010 to add 5 new fields to record budgetory figures.
 *Editor				:Editplus
 
 *Reason of Modification: modification in the 350 USD check for Group international request.
 *Date of modification	: 07 march 2011	
 *Modified by			: manoj chand
 
 *Reason of Modification  : Second approver level name comes twice in approver list although he is also in default approver for international group request.
 *Modified by	  : Manoj Chand	
 *Date of modification:16-march-2011
 
 *Reason of Modification	:for group request created by unit head, his name was not coming in the workflow
 *Modified by	  : Manoj Chand	
 *Date of Modification: 29-mar-2011
 
 *Reason of Modification	:modify the update query which was updating remarks
 *Modified by	  : Manoj Chand	
 *Date of Modification: 03-Oct-2011
 
 *Modification				:write procedure to save values of buying tickect from Non-MATA source.  
 *Modified by				:Manoj Chand
 *Date of Modification		:23 Nov 2011
 
 *Modification				:change message from notSave to Not Saved  
 *Modified by				:Manoj Chand
 *Date of Modification		:21 Feb 2012
 
 *Modification				:Add Board Member in t_traveldetailS_INT table for SMP  
 *Modified by				:Manoj Chand
 *Date of Modification		:28 Mar 2012
 
 *Modification				:Multilingual functionality added
 *Modified by				:Manoj Chand
 *Date of Modification		:24 May 2012
 
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
 *Date of Modification		:23 July 2013
 *Modification				:Mandatory selection of approval level 1 and 2 for mssl site. approver name will not repeated in approver list.
 *******************************************************/
%>
<%@ page import="java.net.URLEncoder" %>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; utf-8" />
	<title>Create Group/Guest Travel Request</title>
	<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	</head>
	
	<!-- all include files with sesstion variables -->
	
	<%-- Import Statements  --%>
	<%@ include file="importStatement.jsp"%>
	<%-- include remove cache  --%>
	<%@ include file="cacheInc.inc"%>
	<%-- include header  --%>
	<%@ include file="headerIncl.inc"%>
	<%-- include page with all application session variables --%>
	<%@ include file="application.jsp"%>
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page"
		class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page"
		class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean2" scope="page"
		class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbUtilityBean" scope="page"
		class="src.connection.DbUtilityMethods" />
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
	
	<%
	request.setCharacterEncoding("UTF-8");
			int intSuccess1 = 0;
			int intSuccess2 = 0;
			int intSuccess4 = 0;
			int intSuccess3 = 0;
			int intSuccess6 = 0;

			int intSuccess8 = 0;
			int intSuccess10 = 0;

			String url = "";
			String strInterimId = "";
			String strSql = null; // String for Sql String
			Connection objCon, con3 = null; //Object for Connection 
			Connection objCon1 = null; //Object for Connection 
			ResultSet rs, rs1, rs2, rs3 = null; // Object for ResultSet
			CallableStatement objCstmt = null; // Object for Callable Statement
			Statement stmt, st3 = null;
			src.connection.DbConnectionBean db11 = null;
			src.travelBean.TravelBean travelBean1 = null;
			String strTravelReqId = "";
			String strTravelId = "";
			String strTravelReqNo = "";
			String strDepCity = "";
			String strArrCity = "";
			String strDepDate = "";
			String strPreferTime = "";
			String strTravelMode = "";
			String strNameOfAirline = "";
			String strTravelClass = "";
			String strManagerId = "";
			String strHodId = "";
			String strBoardMemberId     	= "";
			String strHidAppFlag			= "";
			String strHidAppShowBMFlag		= "";
			String strReasonForSkip = "";
			String strReasonForTravel = "";
			String strBilling = "";
			String strBillingSMGSite = "";
			String strBillingSMGUser = "";
			String strCashBreakupRemarks = "";
			String strTravelType = "I";
			String strApproveStatus = "0";
			String strUserRole = "";
			String strTravellerId = Suser_id;
			int intCounter = 0;
			String strApproverId = "";
			String strApproverRole = "";
			String strApproverOrderId = "";
			String strBillClient = "";
			int intSuccess5 = 0;
			String strMessage = "";
			String strTravellerRole = "";
			String strApprove_Id = "";
			String strUnitHead = "0";
			String strOrignatorAge = "";
			String strOrignatorSex = "";
			String strWhatAction = "";
			String strPermanent_Req_No = ""; //Var for Permanent Requition No.  
			//String strMessage           ="";
			String strExpenditureRemarks = "";
			
			// below 5 fields added by Pankaj on 11 Nov 10
			String dbl_YTM_BUDGET = "";
			String dbl_YTD_ACTUAL = "";
			String dbl_AVAIL_BUDGET = "";
			String dbl_EST_EXP = "";
			String str_EXP_REMARKS = "";
			String strCancelledReqId		 ="0";
			
			
			String strTravllerSiteId = "";
			String strRemarks = "";
			String flag = "";

			//added by manoj chand on 22 nov 2011
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
					
			//end here
			
			ArrayList approverList = new ArrayList();
			ArrayList approverList1 = new ArrayList();

			String strSiteid=request.getParameter("hidsiteid")==null?strSiteIdSS:request.getParameter("hidsiteid");
			//System.out.println("group itinery post hidsiteid---->"+strSiteid);
			
			String strdateoffwdtravel = request.getParameter("whatAction");
			strWhatAction = request.getParameter("whatAction"); // from hidden field
			strTravelReqId = request.getParameter("travelReqId") == null ? ""
					: request.getParameter("travelReqId"); // from hidden field
			strTravelId = request.getParameter("travelId") == null ? ""
					: request.getParameter("travelId"); // from hidden field
			strTravelReqNo = request.getParameter("travelReqNo") == null ? ""
					: request.getParameter("travelReqNo"); // for hidden field
			strDepCity = request.getParameter("RetdepCity") == null ? ""
					: request.getParameter("RetdepCity");
			strArrCity = request.getParameter("RetarrCity") == null ? ""
					: request.getParameter("RetarrCity");
			strDepDate = request.getParameter("RetdepDate") == null ? ""
					: request.getParameter("RetdepDate");
			strPreferTime = request.getParameter("retpreferTime") == null ? ""
					: request.getParameter("retpreferTime");
			//Code commented by shiv on 07 jan 2009 for not showing travel mode as requested by MATA   
			strTravelMode = request.getParameter("RettravelMode") == null ? ""
					: request.getParameter("RettravelMode");
			strTravelMode = "1";
			strNameOfAirline = request.getParameter("RetnameOfAirline") == null ? ""
					: request.getParameter("RetnameOfAirline");
			strTravelClass = request.getParameter("rettravelClass") == null ? ""
					: request.getParameter("rettravelClass");
			strManagerId = request.getParameter("manager") == null ? ""
					: request.getParameter("manager");
			strHodId = request.getParameter("hod") == null ? "" : request
					.getParameter("hod");
			
			//added by manoj chand on 28 March 2012 to fetch board member
			strBoardMemberId		 =  request.getParameter("boardmember");
			strHidAppFlag			 =  request.getParameter("hidGrAppLvl3flg");
			strHidAppShowBMFlag		=	request.getParameter("hidAppLvl3showbmflg");
			//added by manoj chand on 27 nov 2012 to fetch total travel fare values.
			String strTotalFareCurrency		=  request.getParameter("TotalFareCurrency")==null?"":request.getParameter("TotalFareCurrency");
			String strTotalFareAmount		=  request.getParameter("TotalFareAmount")==null?"0":request.getParameter("TotalFareAmount");
			
			
			strReasonForSkip = request.getParameter("reasonForSkip") == null ? ""
					: request.getParameter("reasonForSkip");
			strReasonForTravel = request.getParameter("reasonForTravel") == null ? ""
					: request.getParameter("reasonForTravel");
			strBilling = request.getParameter("billing") == null ? "" : request
					.getParameter("billing");
			strBillingSMGSite = request.getParameter("billingSMGSite") == null ? ""
					: request.getParameter("billingSMGSite");
			strBillingSMGUser = request.getParameter("billingSMGUser") == null ? ""
					: request.getParameter("billingSMGUser");
			strBillClient = request.getParameter("billClient") == null ? ""
					: request.getParameter("billClient");
			strExpenditureRemarks = request.getParameter("expRemarks");
			

			dbl_YTM_BUDGET = request.getParameter("YtmBud")==null?"0.0":request.getParameter("YtmBud");
			dbl_YTD_ACTUAL = request.getParameter("YtmAct")==null?"0.0":request.getParameter("YtmAct");
			dbl_AVAIL_BUDGET = request.getParameter("AvailBud")==null?"0.0":request.getParameter("AvailBud");
			dbl_EST_EXP = request.getParameter("EstExp")==null?"0.0":request.getParameter("EstExp");
			str_EXP_REMARKS = request.getParameter("budgetRemarks")==null?"":request.getParameter("YtmBud");

			strCashBreakupRemarks = request.getParameter("cashBreakupRemarks") == null ? ""
					: request.getParameter("cashBreakupRemarks");
			strRemarks = request.getParameter("Remarks") == null ? "" : request
					.getParameter("Remarks");
			//added new on 07 jan 2009  
			String strSeatpreference = request
					.getParameter("retseatpreference") == null ? "" : request
					.getParameter("retseatpreference");

			String strDeptDate=request.getParameter("hiddeptDate")==null?"":request.getParameter("hiddeptDate");
			
			if (strBilling.equals("outSideSMG")) {
				strBillingSMGUser = strBillClient;
				strBillingSMGSite = "";
				flag = "2";
			}

			//If User has selected  billig site other than own site  with  approve person also
			//change manoj
			if (strBillingSMGSite.equals(strSiteid)) {
				flag = "2";
			}

			// if travelller is Chair man then user seleted from other site will not be added in workflow   
			strSql = "SELECT LTRIM(RTRIM(ISNULL(ROLE_ID,'OR'))) AS ROLE_ID  FROM M_USERINFO WHERE USERID="
					+ strTravellerId;
			
			
//System.out.println("-------1---strsql-->"+strSql);//role_id=OR
			
			
			rs = dbConBean1.executeQuery(strSql);
			if (rs.next()) {
				strTravellerRole = rs.getString("ROLE_ID");
				if (strTravellerRole.equalsIgnoreCase("CHAIRMAN")) {
					flag = "2";
				}
			}
			rs.close();
			
			rs = null;
			strSql = "SELECT TS.LINKED_TRAVEL_ID FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_INT TD (NOLOCK) ON TS.TRAVEL_ID=TD.TRAVEL_ID AND TS.TRAVEL_TYPE='I' WHERE TD.TRAVEL_ID="+strTravelId+" AND TD.APPLICATION_ID = 1 AND TD.STATUS_ID = 10"; 	
			rs = dbConBean1.executeQuery(strSql);
			if(rs.next()) {
				strCancelledReqId = rs.getString("LINKED_TRAVEL_ID");
			}
			rs.close();
			
//System.out.println("strManagerId------------>"+strManagerId);
//System.out.println("strHodId-------------->"+strHodId);			
			
			if (strManagerId != null && strManagerId.equalsIgnoreCase("S")) {
				strManagerId = null;
			}
			if (strHodId != null && strHodId.equalsIgnoreCase("S")) {
				strHodId = null;
			}
			if(strBoardMemberId!= null && strBoardMemberId.equalsIgnoreCase("B"))
			{
				strBoardMemberId = null;
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
			if(strBoardMemberId!= null && !strBoardMemberId.equalsIgnoreCase("B") && !strUserAccessCheckFlag.equals("420")){
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
				strUserAccessCheckFlag = securityUtilityBean.validateAuthEditTravelReq(strTravelId, "I", Suser_id);		
			}
			
		 	if(strUserAccessCheckFlag.equals("420")){	
				dbConBean.close();  
				dbConBean1.close();
				dbConBean2.close();
				securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "Group_itinerary_detailsPost.jsp", "Unauthorized Access");
				response.sendRedirect("UnauthorizedAccess.jsp");		
			} else {
			
			//PROCEDURE for INSERT data in T_APPROVERS ==============================open
			objCon = dbConBean.getConnection();

			//Get the new Approve_Id from the T_Travel_Mst Table
			strApprove_Id = dbUtilityBean.getNewGeneratedId("APPROVE_ID") + "";

			try {

				objCstmt = objCon
						.prepareCall("{?=call PROC_DELETE_FROM_INT_TABLE(?,?,?)}");

				objCstmt.registerOutParameter(1, java.sql.Types.INTEGER);
				objCstmt.setString(2, strTravelReqId);
				objCstmt.setString(3, strTravelId);
				objCstmt.setString(4, strTravelType);
				intSuccess1 = objCstmt.executeUpdate();
				objCstmt.close();

				//System.out.println("intSuccess1=====Approver deleted in table successfuly ============"+intSuccess1);

				//---------------unit  head will be added from ccreator site 
				strSql = "SELECT LTRIM(RTRIM(ISNULL(ROLE_ID,'OR'))) AS ROLE_ID, LTRIM(RTRIM(ISNULL(UNIT_HEAD,'0'))) AS UNIT_HEAD FROM M_USERINFO WHERE USERID="+ Suser_id;
				rs = dbConBean1.executeQuery(strSql);
				if (rs.next()) {
					strTravellerRole = rs.getString("ROLE_ID");
					// strUnitHead	  = rs.getString("UNIT_HEAD");	
					if (strTravellerRole.equalsIgnoreCase("CHAIRMAN")) {
						approverList.clear();
					}

				}
				rs.close();
				//-------------  for one UnitHead for multiple site---------------
				//change manoj
				strSql = "SELECT ISNULL(UNIT_HEAD,'0') AS UNIT_HEAD   FROM USER_MULTIPLE_ACCESS where userid="
						+ Suser_id
						+ " and site_id="
						+ strSiteid
						+ " and status_id=10 and unit_head=1";				
				rs = dbConBean1.executeQuery(strSql);
				if (rs.next()) {
					strUnitHead = rs.getString(1).trim();
				}
				rs.close();
				//-----------  for one UnitHead for multiple site---------------

				//added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma
				//change manoj
				if (strTravellerRole.equalsIgnoreCase("CHAIRMAN")) {
					strSql = "SELECT LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, APPROVER_ID, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="
							+ strSiteid
							+ " AND TRV_TYPE='I' AND sp_role="
							+ SSstrSplRole
							+ " AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4";

					rs = dbConBean1.executeQuery(strSql);
					while (rs.next()) {
						strUserRole = rs.getString("USERROLE");
						if (strUserRole != null
								&& strUserRole.equalsIgnoreCase("MATA")) {
							approverList.add(rs.getString("APPROVER_ID"));
							approverList.add(strUserRole);
						}
					}
					rs.close();
				} else {
					if (strManagerId != null) {
						approverList.add(strManagerId);	
						approverList.add("WORKFLOW");
					}
					if (strHodId != null) {
						//if condition added on 23 july 2013 by manoj chand to prevent addition of approval level 1 approver in level 2.
						if(!approverList.contains(strHodId)){
							approverList.add(strHodId);				//System.out.println("strHodid--->"+strHodId);
							approverList.add("WORKFLOW");
						}
					}
					//added by manoj chand on 22 mar 2013 to add board member after approver 1 and 2
					if(strHidAppFlag.equalsIgnoreCase("Y") && strHidAppShowBMFlag.equalsIgnoreCase("Y") && strBoardMemberId!=null && !strBoardMemberId.equalsIgnoreCase("B")){
						approverList.add(strBoardMemberId);				//System.out.println("strHodid--->"+strHodId);
						approverList.add("WORKFLOW");	
					}
					
					
					//change manoj
					strSql = "SELECT APPROVER_ID, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="
							+ strSiteid
							+ " AND TRV_TYPE='I' AND sp_role="
							+ SSstrSplRole
							+ " AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4";
					
					rs = dbConBean1.executeQuery(strSql);
					while (rs.next()) {
						String strTempApproverId = rs.getString("APPROVER_ID")
								.trim();
						strUserRole = rs.getString("USERROLE");
						//if traveller id is unit head of the site then it would not be appear in the approver list.	
						if (strUnitHead.equalsIgnoreCase("1")
								&& strTravellerId.equals(strTempApproverId)) {
						}
						//---------------For  Unit Heads belonging to the same site.
						//change manoj
						String strQuery = "Select Unit_Head from USER_MULTIPLE_ACCESS where USERID="
								+ strTempApproverId
								+ " and SITE_ID="
								+ strSiteid + " AND UNIT_HEAD=1 ORDER BY 1";

						rs1 = dbConBean2.executeQuery(strQuery);
						if (strUnitHead.equalsIgnoreCase("10000") && rs1.next()) {
						} else {
							//added code for checking if approver is exits in defualt approver list on 19-01-2009
//System.out.println("strTempApproverId--------->"+strTempApproverId);
//System.out.println("approverList------------>"+approverList);
							if (approverList.contains(strTempApproverId)) {
								int j = approverList.indexOf(strTempApproverId);
								//int k = approverList.indexOf("WORKFLOW");
								int k=j+1;	
								if (j == k - 1) {
									approverList.remove(j);
									approverList.remove(j);
									// approverList.remove(strTempApproverId); 
									// approverList.remove("WORKFLOW"); 
								}
							}
//System.out.println("strTempApproverId------>"+strTempApproverId);

							approverList.add(strTempApproverId);
							if (strUserRole != null
									&& strUserRole.equalsIgnoreCase("OR")) {
								strUserRole = "DEFAULT";
							}								
							approverList.add(strUserRole);

						}
						rs1.close();
					} //close of while loop 
					rs.close();//clode of connection 	 
				} //close of else

				///-----------------------------ADDE Approver in a T_approvers  table    

				
				
				
				
				
				try {
					
					
					//ADDED BY MANOJ CHAND ON 28 MARCH 2012 TO ADD BOARD MEMBER IN SECOND LAST POSITION IN APPROVER LIST
					   if(strHidAppFlag.equalsIgnoreCase("Y") && strHidAppShowBMFlag.equalsIgnoreCase("Y") && strBoardMemberId!=null && !strBoardMemberId.equalsIgnoreCase("B")){
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
					Iterator itr = approverList.iterator();

					while (itr.hasNext()) {
						intCounter++;
						//strApprove_Id       =  dbUtilityBean.getNewGeneratedId("APPROVE_ID")+"";  //NO NEED GENERATION OF THIS ID DUE TO FIELD IS AUTOGENERATED IN THE T_APPROVER TABLE
						strApproverId = (String) itr.next();
						strApproverRole = (String) itr.next();
						strApproverOrderId = intCounter + "";
	//System.out.println("strApproverId---"+intCounter+"-->"+strApproverId);
	//System.out.println("strApproverRole---"+intCounter+"--->"+strApproverRole);
	
						objCstmt = objCon
								.prepareCall("{?=call PROC_INSERT_T_APPROVERS(?,?,?,?,?,?,?,?,?,?)}");
						objCstmt
								.registerOutParameter(1, java.sql.Types.INTEGER);
						objCstmt.setString(2, strApprove_Id); //set the Approve Id      
						objCstmt.setString(3, strTravelId); //set the Travel Id    
						//change manoj
						objCstmt.setString(4, strSiteid); //set the Traveller Site Id  
						objCstmt.setString(5, Suser_id); //Set the Traveller Id
						objCstmt.setString(6, strTravelType); //Set the TravelType 
						objCstmt.setString(7, strApproverId); //Set the Approver Id
						objCstmt.setString(8, strApproveStatus); //Set the Approve Status(0-no approve, 10-approve, 3-return, 4-rejected)
						objCstmt.setString(9, strApproverOrderId); //Set the Approver Order Id in which  order approver approve the requsition
						objCstmt.setString(10, strApproverRole); //Set the Approver Role
						objCstmt.setString(11, Suser_id); //Set the Login user id 
						intSuccess5 = objCstmt.executeUpdate();

						//System.out.println("intSuccess5=aPPROVER aDDE IN t_APPROVER  SUCESSFULY ==="+intSuccess5+"approver id"+strApproverId);
						objCstmt.close();
						if (intSuccess5 == 0)
							break;
					}//Close of while for adding approver in T_approver 

					//--------------- if creator will select billing site other than his Own site then thsi code will execute 
					// ----------------and this code will add selcted aapprover in work flow of requisition 

					if (flag != "2") {

						int intTravelId = Integer.parseInt(strTravelId);
						int intBillingClient = Integer
								.parseInt(strBillingSMGUser);
						int intTravellerId = Integer.parseInt(strTravellerId);
						int intC_userid = Integer.parseInt(Suser_id);

						if (intBillingClient != -1) {
							objCstmt = objCon
									.prepareCall("{?=call PROC_APPROVER_OF_OTHERSITE(?,?,?,?,?)}");
							objCstmt.registerOutParameter(1,
									java.sql.Types.INTEGER);
							objCstmt.setInt(2, intTravelId);
							objCstmt.setString(3, "I");
							objCstmt.setInt(4, intBillingClient);
							objCstmt.setInt(5, intTravellerId);
							objCstmt.setInt(6, intC_userid);// new field added on 1/24/2008  by shiv  Sharma 
							intSuccess6 = objCstmt.executeUpdate();
							objCstmt.close();

							if (intSuccess5 > 0) {
								//System.out.println("Approver of other site  added  successfully in T_approver table ");
								strMessage = "save";
							} else {
								System.out
										.println("Error in  adding  apporver successfully in T_approver table ");

							}
						}
					} //close of if block for adding approver of biling site  

				} catch (Exception e) {
					System.out.println(e);
					objCon.rollback();
					strTravelId = null;
					//strMessage = dbLabelBean.getLabel("message.global.notsaved",strsesLanguage);
					strMessage = "notSave";
				}
			} catch (Exception e) {
				System.out.println("Error in page :Group _itinerary_detailsPost.jsp"+ e);
			}

			//PROCEDURE for INSERT data in T_APPROVERS ==============================End

			//procdeure to update values in t_travel_details_int ======================open

			try {

				strSql = "SELECT dbo.CalAge(DOB,GETDATE()), isnull(GENDER,'Male') as GENDER FROM M_USERINFO WHERE USERID="
						+ Suser_id;

				rs = dbConBean.executeQuery(strSql);
				while (rs.next()) {
					strOrignatorAge = rs.getString(1).trim();
					strOrignatorSex = rs.getString(2).trim();

					if (strOrignatorSex.equals("Male")) {
						strOrignatorSex = "1";
					} else {
						strOrignatorSex = "2";
					}
				}
				rs.close();

				/*
				objCstmt            =  objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_DETAIL_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,       ?)}"); 
				objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				objCstmt.setString(2, strTravelReqId);
				objCstmt.setString(3, strTravelId);
				objCstmt.setString(4, strTravelReqNo);
				objCstmt.setString(5, strSiteIdSS);             //set the Traveller Site Id
				objCstmt.setString(6, Suser_id);        //set the Traveller Id
				objCstmt.setString(7, strOrignatorAge);                //set the Traveller Age
				objCstmt.setString(8,strOrignatorSex);                //set the Traveller Sex
				objCstmt.setString(9, strDepDate);            //set the Traveller Departure Date
				objCstmt.setString(10, "");              //set the Traveller Meal
				objCstmt.setString(11, "");              //set the Traveller Visa Required
				objCstmt.setString(12, "");       //set the Traveller Visa Comment
				objCstmt.setString(13, "");         //set the Traveller Isurance Required
				objCstmt.setString(14, "");           //set the Traveller's Nominee
				objCstmt.setString(15, "");          //set the Traveller's Relation
				objCstmt.setString(16, "");  //set the Traveller's Insurance Comment
				objCstmt.setString(17, "");             //set the Traveller Hotel Required
				objCstmt.setString(18, "");       //set the Traveller Hotel Budget
				 objCstmt.setString(19, "");  
				objCstmt.setString(20, "");     //set the Traveller Hotel Budget Currency
				objCstmt.setString(21, strRemarks.trim());      //set the Traveller Remark(in table)
				objCstmt.setString(22, "");        //set the Traveller Return Type if(user fill the return date then Return Type is 2 otherwise 1
				objCstmt.setString(23, Suser_id);             //set the current user Login UserId
				objCstmt.setString(24, "manual");     //set the select Approver radio button (manual or automatic)
				  objCstmt.setString(25, strManagerId);             //set the select Approver radio button (manual or automatic)
				objCstmt.setString(26, strHodId);             //set the select Approver radio button (manual or automatic)
				objCstmt.setString(27, "");		// set credit card info
				  objCstmt.setString(28,"");
				objCstmt.setString(29, "");	//set credit card number1
				objCstmt.setString(30, "");	//set credit card number 2
				objCstmt.setString(31, "");	//set credit card number 3
				objCstmt.setString(32, "");	//set credit card number 4
				objCstmt.setString(33, "");	// set Expiry date
				objCstmt.setString(34, "");	 	//set CVV no
				objCstmt.setString(35, ""); 
				objCstmt.setString(36, ""); 
				objCstmt.setString(37, strReasonForTravel);      //set the Traveller Remark(in table)
				objCstmt.setString(38, strReasonForSkip);        //set the Reason for Skipping the Apprval Seleciton 1 and 2
				objCstmt.setString(39, "");                             //MODIFIED_FIELDS
				  intSuccess2   =  objCstmt.executeUpdate();
				objCstmt.close();
				
				 */

				/*strSql = " update T_travel_detail_INT  " + " set  MANAGER_ID="
						+ strManagerId + ",HOD_ID=" + strHodId + ",REMARKS='"
						+ strRemarks.trim() + "', " + " REASON_FOR_TRAVEL='"
						+ strReasonForTravel + "',REASON_FOR_SKIP='"
						+ strReasonForSkip + "' where TRAVEL_ID=" + strTravelId
						+ " and STATUS_ID='10'";*/
						/*strSql = " update T_travel_detail_INT  " + " set  MANAGER_ID="
						+ strManagerId + ",HOD_ID=" + strHodId + ",BOARD_MEMBER_ID= "+strBoardMemberId + ", REASON_FOR_TRAVEL=N'"
						+ strReasonForTravel + "',REASON_FOR_SKIP=N'"
						+ strReasonForSkip + "' where TRAVEL_ID=" + strTravelId
						+ " and STATUS_ID='10'";*/
						//int updaterow = dbConBean.executeUpdate(strSql);
				//new procedure added by manoj chand on 27 nov to resolve  error coming when single quotes in reason for travel
						objCstmt            =  objCon.prepareCall("{?=call PROC_UPDATE_GROUP_T_TRAVEL_DETAIL_INT(?,?,?,?,?,?)}"); 
						objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2, strTravelId);
						objCstmt.setString(3, strManagerId);
						objCstmt.setString(4, strHodId);
						objCstmt.setString(5, strReasonForTravel);     
						objCstmt.setString(6, strReasonForSkip);
						objCstmt.setString(7, strBoardMemberId);
						int updaterow=  objCstmt.executeUpdate();
						objCstmt.close();
				

				//PROCEDEURE TO UPDATE BILLING INFO=======================OPEN 

				objCstmt = objCon
						.prepareCall("{?=call PROC_UPDATE_BILLING_INFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?)}");

				objCstmt.registerOutParameter(1, java.sql.Types.INTEGER);
				objCstmt.setString(2, strTravelId);
				objCstmt.setString(3, strBillingSMGSite);
				objCstmt.setString(4, strBillingSMGUser); //set the billing client
				objCstmt.setString(5, "");
				objCstmt.setString(6, "");
				objCstmt.setString(7, "");
				objCstmt.setString(8, "");
				objCstmt.setString(9, "");
				objCstmt.setString(10, "");
				objCstmt.setString(11, "");
				objCstmt.setString(12, "");
				objCstmt.setString(13, "");
				objCstmt.setString(14, strExpenditureRemarks);
				objCstmt.setString(15, ""); //FOREX_MODIFIED_FIELDS
				objCstmt.setString(16, Suser_id);
				//below 5 parameters added by Pankaj on 11 Nov 10			
				objCstmt.setString(17, dbl_YTM_BUDGET);
				objCstmt.setString(18, dbl_YTD_ACTUAL);
				objCstmt.setString(19, dbl_AVAIL_BUDGET);
				objCstmt.setString(20, dbl_EST_EXP);
				objCstmt.setString(21, str_EXP_REMARKS);
				objCstmt.setString(22,strTotalFareCurrency);
				objCstmt.setInt(23,Integer.parseInt(strTotalFareAmount));
				intSuccess3 = objCstmt.executeUpdate();
				objCstmt.close();

				//System.out.println("intSuccess3====Data for Billing info updated Successfuly  ========"+intSuccess3);
				//procedeure to update billing info=======================close 
				//procdure  to insert  upadate  journey details in T_JOURNEY_DETAILS_INT  table  

				String strRecord = "";
				strSql = "SELECT  1  FROM   T_RET_JOURNEY_DETAILS_INT t1 INNER JOIN T_TRAVEL_DETAIL_INT t2  "
						+ " ON t1.TRAVEL_ID = t2.TRAVEL_ID  WHERE  (t1.TRAVEL_ID = "
						+ strTravelId
						+ ") AND (t1.APPLICATION_ID = 1) "
						+ " AND (t2.STATUS_ID = 10) ";

				rs = dbConBean.executeQuery(strSql);
				while (rs.next()) {
					strRecord = rs.getString(1);
				}

				if (!strRecord.equals("1")) {

					objCstmt = objCon
							.prepareCall("{?=call PROC_INSERT_T_RET_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					objCstmt.registerOutParameter(1, java.sql.Types.INTEGER);
					objCstmt.setString(2, strTravelId);
					objCstmt.setString(3, strDepCity); //set the Traveller Return Departure City Name(TRAVEL_FROM)
					objCstmt.setString(4, strArrCity); //set the Traveller Return Arrival City Name(TRAVEL_TO)
					objCstmt.setString(5, strDepDate); //set the Traveller Departure Date
					objCstmt.setString(6, "1"); //set the Order of Traveller intrim journey(it is 1 for the actual from and to
					objCstmt.setString(7, strTravelMode); //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
					objCstmt.setString(8, strNameOfAirline); //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
					objCstmt.setString(9, strTravelClass); //set the Travel Class Name(in int value), e.g. First class, Business class 
					objCstmt.setString(10, strPreferTime); //set the Travel Preferred Time e.g. Morning,evening etc.
					objCstmt.setString(11, Suser_id); //set the current user Login UserId
					objCstmt.setString(12, strSeatpreference); //set the seat prefferene on 09-jan-2009 by  shiv  
					objCstmt.setString(13, "1");
				    objCstmt.setInt(14, 0);
					intSuccess4 = objCstmt.executeUpdate();
					objCstmt.close();
				} else {
					objCstmt = objCon
							.prepareCall("{?=call PROC_UPDATE_T_RET_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					objCstmt.registerOutParameter(1, java.sql.Types.INTEGER);
					objCstmt.setString(2, strTravelId);
					objCstmt.setString(3, strDepCity); //set the Traveller Return Departure City Name(TRAVEL_FROM)
					objCstmt.setString(4, strArrCity); //set the Traveller Return Arrival City Name(TRAVEL_TO)
					objCstmt.setString(5, strDepDate); //set the Traveller Departure Date
					objCstmt.setString(6, "1"); //set the Order of Traveller intrim journey(it is 1 for the actual from and to
					objCstmt.setString(7, strTravelMode); //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
					objCstmt.setString(8, strNameOfAirline); //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
					objCstmt.setString(9, strTravelClass); //set the Travel Class Name(in int value), e.g. First class, Business class 
					objCstmt.setString(10, strPreferTime); //set the Travel Preferred Time e.g. Morning,evening etc.
					objCstmt.setString(11, ""); //set the Travel Preferred Time e.g. Morning,evening etc.
					objCstmt.setString(12, Suser_id); //set the current user Login UserId
					objCstmt.setString(13, strSeatpreference); //set the seat prefferene on 09-jan-2009 by  shiv
					objCstmt.setString(14, "1");
					objCstmt.setInt(15, 0);
					intSuccess4 = objCstmt.executeUpdate();
					objCstmt.close();

				}


				// added by manoj chand on 23 nov 2011 to add MATA Initial and MATA Final when Pricing desicion will take place
	             
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
				
	
				
				//   code added for if travel details found blank then it will not allow to submit the requsition in workflow        
				String strRecordFoundBlankField = "";
				strSql = "select 1 from T_JOURNEY_DETAILS_INT where travel_id='"
						+ strTravelId+ "'"+ " and (travel_from ='' or travel_to='' or year(travel_date)=1900) ";

				rs = dbConBean.executeQuery(strSql);
				while (rs.next()) {
					strRecordFoundBlankField = rs.getString(1);
				}
//System.out.println("strRecordFoundBlankField======"+ strRecordFoundBlankField);

				if (!strRecordFoundBlankField.equals("1")) {

					////Procedure to Change Status _id of requisition  to Permanent Requisition
					
					if(!strSiteid.trim().equalsIgnoreCase(strSiteIdSS)){
						String strsiteName="";
						strSql="select site_name from m_site where site_id="+strSiteid;
						 rs = dbConBean.executeQuery(strSql);
							while(rs.next()){  
								strsiteName = rs.getString("site_name");	 		
							 }
						strPermanent_Req_No = "GR/" + strsiteName.trim()+ "/INT/" + strTravelId;
						rs.close();
					}else{					
					strPermanent_Req_No = "GR/" + strSiteFullName.trim()+ "/INT/" + strTravelId;
					}
					//  Added on 28 may 2009 for stoping mail when use referesh the page 
					session.setAttribute("strSetFlage", "1");

					//strMessage = dbLabelBean.getLabel("message.global.save",strsesLanguage);
					strMessage = "save";

					if (strWhatAction != null
							&& strWhatAction.equals("saveProceed")) {

						//code added by vaibhav on sep 30 2010 to add constraints on perday expense.
						con3 = dbConBean.getConnection();
						st3 = con3.createStatement();

						/*String strQuery = " select 1 as LimitNotExceeding "
								+ "from (select TTEI.G_userid ,TTDI.travel_id, exp_id,currency, total_tour_days, TTDI.travel_date formdate, isnull(TRJDI.travel_date, TTDI.travel_date) retdate  "
								+ "	,(select sum(total_exp_id) from T_TRAVEL_EXPENDITURE_INT where travel_id=TTDI.travel_id and G_userid =TTEI.g_userid ) TotalExpence "
								+ "	 from T_TRAVEL_DETAIL_INT TTDI left join  "
								+ "	 T_TRAVEL_EXPENDITURE_INT TTEI on TTEI.travel_id = TTDI.travel_id left join  "
								+ "	 T_RET_JOURNEY_DETAILS_INT TRJDI on TRJDI.travel_id = TTDI.travel_id "
								+ "  where TTDI.travel_id='"
								+ strTravelId
								+ "') drv inner join  "
								+ " m_currency c on c.currency = drv.currency inner join  "
								+ " EXCHANGE_RATE e on c.CUR_ID = e.CUR_ID and e.rate_month = month(getdate()) and e.rate_year = year(getdate()) "
								+ " where exp_id = case (select total_tour_days from T_TRAVEL_EXPENDITURE_INT where travel_id=drv.travel_id and G_userid = drv.G_userid and exp_id=2) "
								+ " when 0 then 1 else 2 end "
								+ " and (TotalExpence / case TOTAL_TOUR_DAYS when 0 then case when DATEDIFF(day,formdate,retdate) = 0 then 1 else DATEDIFF(day,formdate,retdate) end else TOTAL_TOUR_DAYS  end ) "
								+ " * conversion_rate / (select conversion_rate from EXCHANGE_RATE where rate_month = month(getdate()) and rate_year = year(getdate()) and cur_id=2) "
								+ " > 350 ";*/
						/*		String strQuery=" select 1 as LimitNotExceeding "+
								"from( select TTEI.G_userid ,TTDI.travel_id, currency,  TTDI.travel_date formdate, CASE WHEN TRJDI.TRAVEL_DATE IS NULL OR YEAR(TRJDI.TRAVEL_DATE) = 1900 THEN TTDI.TRAVEL_DATE ELSE TRJDI.TRAVEL_DATE END retdate, TRJDI.travel_date return_date "+
								       ",(select sum(total_exp_id) from T_TRAVEL_EXPENDITURE_INT where travel_id=TTDI.travel_id and G_userid =TTEI.g_userid ) TotalExpence "+
								      " ,(select total_tour_days from T_TRAVEL_EXPENDITURE_INT where travel_id = TTDI.travel_id and G_userid =TTEI.g_userid and exp_id = 1) Exp_tour_days "+
								      " ,(select total_tour_days from T_TRAVEL_EXPENDITURE_INT where travel_id = TTDI.travel_id and G_userid =TTEI.g_userid and exp_id = 2) Hotel_tour_days "+
								       "from T_TRAVEL_DETAIL_INT TTDI left join  "+
								        "T_TRAVEL_EXPENDITURE_INT TTEI on TTEI.travel_id = TTDI.travel_id left join  "+
								        "T_RET_JOURNEY_DETAILS_INT TRJDI on TRJDI.travel_id = TTDI.travel_id "+
								       "where TTDI.travel_id = '"+strTravelId+"' ) drv inner join  "+
								      " m_currency c on c.currency = drv.currency inner join  "+
								      " EXCHANGE_RATE e on c.CUR_ID = e.CUR_ID and e.rate_month = month(getdate()) and e.rate_year = year(getdate()) "+
								"where 	(TotalExpence / case when return_date is null or year(return_date) = 1900 "+
								"then  case when Hotel_tour_days >0  then Hotel_tour_days "+
								" else case when Exp_tour_days >0 then Exp_tour_days "+ 
					             " else DATEDIFF(day,formdate,retdate)+1 end end "+
								"else DATEDIFF(day,formdate,retdate)+1 end "+
								" ) * conversion_rate / (select conversion_rate from EXCHANGE_RATE where rate_month = month(getdate()) and rate_year = year(getdate()) and cur_id=2) > 350 ";*/
								
				//added by manoj chand on 31 oct 2012 to make check for 350$
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
							String url2 = "Group_itinerary_details.jsp?message="
									+ strMessage
									+ "&travelId="
									+ strTravelId
									+ "&travelReqId="
									+ strTravelReqId
									+ "&travellerId="
									+ strTravellerId
									+ "&site="
									+ strSiteid
									+ "&travelReqNo=" + strTravelReqNo+"&depDate="+strDeptDate;

							RequestDispatcher rd = request.getRequestDispatcher(url2);
							rd.forward(request, response);
							return;
						}
						
						//System.out.println("--->   After check");
						rs3.close();
						st3.close();
						//con3.close();
						//modification by vaibhav ends

						//System.out.println("strWhatAction=====  in side new block of save and procced =============");
						objCstmt = objCon
								.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_STATUS(?,?,?,?,?,?)}");
						//PROCEDURE to insert the row in T_TRAVEL_MST  Table
						objCstmt
								.registerOutParameter(1, java.sql.Types.INTEGER);
						objCstmt.setString(2, strTravelId);
						objCstmt.setString(3, strTravelReqId);
						objCstmt.setString(4, "2"); //SET THE  TRAVEL_STATUS_ID 2 AS A PERMANENT REQUEST FOR THE WORKFLOW
						objCstmt.setString(5, strTravelType);
						objCstmt.setString(6, strPermanent_Req_No);
						objCstmt.setString(7, strCancelledReqId);
						intSuccess5 = objCstmt.executeUpdate();
						objCstmt.close();
						//strMessage = dbLabelBean.getLabel("message.global.save",strsesLanguage);
						strMessage = "save";
						
					}

					//PROCEDURE TO UPDATE EXPENDITURE IN T_TRAVEL_DETAILS_INT TABLE
//System.out.println("================================================= 1 ");

					objCstmt = objCon
							.prepareCall("{?=call PROC_T_TRAVEL_EXPENDITURE_INT_UPDATE_GROUP(?)}");
					objCstmt.registerOutParameter(1, java.sql.Types.INTEGER);
					objCstmt.setString(2, strTravelId);
					intSuccess10 = objCstmt.executeUpdate();
					objCstmt.close();

					dbConBean.close();
					objCon.close();
				} else {
					strMessage = dbLabelBean.getLabel("message.createrequestforwardjourneydetailsnotsavedpleasecheck",strsesLanguage);
					//System.out.println("================================================= 2 ");
				}

			} catch (Exception e) {
				System.out.println("Error in Group_itinary_detailsPost.jsp===="+ e);
				//strMessage =dbLabelBean.getLabel("message.global.notsaved",strsesLanguage);
				strMessage ="notSave";
			}

			//after inserting all data to all tables  set the responce  

			if (strMessage != null && strMessage.equals("save")) {
				if (strWhatAction != null && strWhatAction.equals("save")) {
					url = "Group_itinerary_details.jsp?message=" + URLEncoder.encode(strMessage,"UTF-8")
							+ "&travelId=" + strTravelId + "&travelReqId="
							+ strTravelReqId + "&travellerId=" + strTravellerId
							+ "&site=" + strSiteid
							+ "&travelReqNo=" + strTravelReqNo+"&depDate="+strDeptDate;
				} else if (strWhatAction != null
						&& strWhatAction.equals("saveandexit")) {
					url = "T_TravelRequisitionList.jsp?travel_type=INT";
				} else if (strWhatAction != null
						&& strWhatAction.equals("saveProceed")) {
					if (intSuccess5 > 0)
					//  if(true)
					{ 
						url = "T_TravelRequisitionList.jsp?travel_type=INT";
						//System.out.println("----------------------------------------in Finally submit block==================== ");
//change manoj
							String	strReq	=	"";
							if(strTravelType.equalsIgnoreCase("I")) {
								strReq	=	"International Travel";
							} else {
								strReq	=	"Domestic Travel";
							}
							mailDaoImpl.sendRequisitionMailOnOriginating(strTravelId, strReq, Suser_id, strsesLanguage, strCurrentYear);
							
						url = "FinallySubmitted.jsp?travelId=" + strTravelId
								+ "&travelReqId=" + strTravelReqId
								+ "&travellerId=" + strTravellerId
								+ "&travellerSiteId=" + strSiteid
								+ "&travelReqNo=" + strPermanent_Req_No
								+ "&ReqTyp=I&interimId=" + strInterimId
								+ "&strGroupflag=yes";
					} else {
						url = "";
					}
				} 
			} else {
				url = "Group_itinerary_details.jsp?message=" + URLEncoder.encode(strMessage,"UTF-8")
						+ "&travelId=" + strTravelId + "&travelReqId="
						+ strTravelReqId + "&travellerId=" + strTravellerId	+ "&site=" + strSiteid
						+ "&travelReqNo=" + strTravelReqNo+"&depDate="+strDeptDate;
			}

//System.out.println("url======1111========="+url);
			response.sendRedirect(url);
		}%>
