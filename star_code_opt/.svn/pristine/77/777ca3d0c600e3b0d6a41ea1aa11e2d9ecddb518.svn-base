<!DOCTYPE html>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.util.Map.Entry"%>
<%@ include file="application.jsp"%>
<%@ page import="java.sql.*" pageEncoding="UTF-8"%>
<%@ page import="src.enumTypes.TravelRequestEnums" %>
<%@ page import="src.dao.T_QuicktravelRequestDaoImpl" %>
<%-- include remove cache  --%>
<%@ include file="cacheInc.inc"%>
<%-- include header  --%>
<%@ include file="headerIncl.inc"%>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository" />
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<title>Create Group/Guest Travel Request</title>
<link href="style/quick-travel-style_gmbh.css?buildstamp=2_0_0" rel="stylesheet" media="all" type="text/css" />
<link href="style/jquery-ui-1.9.2.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<link href="jquery-datepicker/jquery.datepick.css?buildstamp=2_0_0" rel="stylesheet">
<script type="text/javascript" src="ScriptLibrary/FormCheckQuickTravelRequest.js?buildstamp=2_0_0"></script>
<script type="text/javascript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<script type="text/javascript" src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></script>
<script type="text/javascript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
<script type="text/javascript" src="ScriptLibrary/jquery-1.8.3.js?buildstamp=2_0_0"></script>
<script type="text/javascript" src="ScriptLibrary/jquery-ui-1.9.2.js?buildstamp=2_0_0"></script>
<script type="text/javascript" src="ScriptLibrary/jquery-ui-autocomplete.js?buildstamp=2_0_0"></script>
<script type="text/javascript" src="jquery-datepicker/jquery.plugin.js?buildstamp=2_0_0"></script>
<script type="text/javascript" src="jquery-datepicker/jquery.datepick.js?buildstamp=2_0_0"></script>
<script type="text/javascript">
	if (navigator.appVersion.indexOf("MSIE 10") !== -1) { document.write("<meta http-equiv='X-UA-Compatible' content='IE=EmulateIE9'>");}
</script>
<%
T_QuicktravelRequestDaoImpl dao = new T_QuicktravelRequestDaoImpl();
//Global Variables declared and initialized
request.setCharacterEncoding("UTF-8");
String strSql, strSql2=null;
ResultSet rs,rs1,rs2,rs3,rs4,rs5,rs6,rs7,rs8,rs9, rsItnr= null;
String strSiteId ="", strUserId="",  strProjectNo="", strReasonForTravel="";
String strTravelAgencyId = "2";
String strGroupTravelFlag = "Y";
//Group/Guest Trevller Details
String travellerUserId="", travellerFirstName="", travellerLastName="", travellerDOB="", travellerGender="-1", travellerMobileNo="", travellerFreqFlyer="", travellerMealPref="0", travellerPassportNo="", travellerNationality="", travellerIssuePlace="",	travellerIssueDate="", travellerExpiryDate="", travellerVisaExists="2", travellerReturnTravel="N", travellerAge="";
// Flight Details
String strTravelModeFlt="", strDepCityFwdFlt="", strArrCityFwdFlt="", strDepDateFwdFlt="", strTravelClassFwdFlt="", strPreferTimeModeFwdFlt="", strPreferTimeFwdFlt="", strPreferSeatFwdFlt="", strDepCityRetFlt="", strArrCityRetFlt="", strDepDateRetFlt="", strTravelClassRetFlt ="", strPreferTimeModeRetFlt="", strPreferTimeRetFlt="", strPreferSeatRetFlt="", strDepCityIntrmiFlt="", strArrCityIntrmiFlt="", strDepDateIntrmiFlt="", strTravelClassIntrmiFlt="", strPreferTimeModeIntrmiFlt="", strPreferTimeIntrmiFlt ="", strPreferSeatIntrmiFlt="", strRemarkFlt="", strChangeableAgainst="", strRefundableAgainst="", strCheckedBaggage="";
//Train Details
String strTravelModeTrn="", strDepCityFwdTrn="", strArrCityFwdTrn="", strDepDateFwdTrn="", strTravelClassFwdTrn="", strPreferTimeModeFwdTrn="", strPreferTimeFwdTrn="", strPreferSeatFwdTrn="", strDepCityRetTrn="", strArrCityRetTrn="", strDepDateRetTrn="", strTravelClassRetTrn="", strPreferTimeModeRetTrn="", strPreferTimeRetTrn="", strPreferSeatRetTrn="", strDepCityIntrmiTrn="", strArrCityIntrmiTrn="", strDepDateIntrmiTrn="", strTravelClassIntrmiTrn="", strPreferTimeModeIntrmiTrn="", strPreferTimeIntrmiTrn="", strPreferSeatIntrmiTrn="", strRemarkTrn="", strBahncard="", strBahncardNo="", strBahncardDiscnt="", strBahncardClass="", strBahncardValidityDate = "", strBahncardOnlineTkt="", strSpecialTrain="";
//Car Details
String strTravelCarId="", strStartDate="", strStartTime="", strStartCity="", strStartLocation="", strStartMobileNo="",strStartRouting="",strEndRouting="", strEndDate="", strEndTime="", strEndCity="", strEndLocation="", strEndMobileNo="", strNeedGps="", strCategory="", strCarRemarks="", strCarClass="";
//Accommodation Details
String strAccId="", strHotelRequired="", strPlace="", strCheckin="", strCheckout="", strRemarks="";
//Approver Details
String strBillingClient = "", strBillingApprover = "", strShowflag = "n";	
String strTravelReqId = "", strTravelId = "", strTravelReqNo="", strIntermiId="", strTravllerSiteId="", strTravellerId = "", strTravelType = "", strReturnType = "", srcFlag = "";
String msgFlag = "", strFlag = "";
String strMessage = "false", flightYNFlag = "false", trainYNFlag = "false", rentCarYNFlag = "false", accomYNFlag = "false"; 
String strApproverid = "", ApproverText = "", strname1 = "", strname2 = "";
strSiteId = strSiteIdSS;  
strUserId = Suser_id;
strMessage = request.getParameter("message");
strTravelId = request.getParameter("travelId");
strTravelReqNo = request.getParameter("travelReqNo");
strTravelReqId = request.getParameter("travelReqId");
strTravellerId = request.getParameter("travellerId");
strTravelType = request.getParameter("travel_type");
strIntermiId = request.getParameter("interimId")== null ? "" : request.getParameter("interimId");
srcFlag = request.getParameter("srcFlag")== null ? "innerpage" : request.getParameter("srcFlag");

Date currentDate = new Date();
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
String strCurrentDate = (sdf.format(currentDate)).trim();

if(strMessage != null && strMessage.equals("save")) {
	msgFlag	 = "true";
    strMessage = dbLabelBean.getLabel("message.global.infosavesuccessfully",strsesLanguage);
} else if(strMessage != null && strMessage.equals("not Save")) {
	msgFlag	 = "true";
    strMessage = dbLabelBean.getLabel("message.master.erroroccuredhencecouldnotbesaved",strsesLanguage);
} else if(strMessage != null && strMessage.equalsIgnoreCase("approvernotexists")) {
	msgFlag	 = "true";
    strMessage = "Could not Submit to Workflow, Please define Default workflow or Report To(Approver Level1)/Department Head(Approver Level2) in your profile.";
} else {
	msgFlag	 = "false";
    strMessage = ""; 
}


String strBaseCur="INR";
String baseCurr = dao.getBaseCurrency(strSiteId);
if(baseCurr != null) {
	strBaseCur = baseCurr;
}

strSql = "select top 1 approver_id  from T_approvers  where travel_id ="+ strTravelId + " and travel_type='i' and status_id=10 order by order_id ";
rs=null;
rs = dbConBean.executeQuery(strSql);
while (rs.next()) {
	strApproverid = rs.getString(1);
	strSql = "select dbo.user_name(" + strApproverid+ "),dbo.user_name(dbo.finalooo(" + strApproverid+ ",getdate(),'i'))";
	rs7=null;
	rs7 = dbConBean1.executeQuery(strSql);
	while (rs7.next()) {
		strname2 = rs7.getString(1);
		strname1 = rs7.getString(2).trim();
		if (!strname1.equals("-")) {
			ApproverText = ApproverText + strname2
					+ " "+dbLabelBean.getLabel("alert.createrequest.hasdelegatedhisauthorityto",strsesLanguage)+" " 
					+ strname1 + ".\n ";
		}
	}
	rs7.close();
}
rs.close();

if(strTravelId==null) {
	 strTravelReqId = "new";
	 strTravelId    = "new";
} else if(strTravelId !=null && strTravelId.equals("")) {
	 strTravelReqId = "new";
	 strTravelId    = "new";
} else if(strTravelId !=null && strTravelId.equals("new")) {
	 strTravelReqId = "new";
	 strTravelId    = "new";
} else if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
	if(strTravelType.equals("D")) {
		rsItnr=null;
		rsItnr = dao.getTravelRequestDetailDom(strTravelId);				
	}
	else if(strTravelType.equals("I")) {
		rsItnr=null;
		rsItnr = dao.getTravelRequestDetailInt(strTravelId);		
	}
	
	if(rsItnr.next()) {
			strTravelReqId       		= rsItnr.getString("TRAVEL_REQ_ID");
			strSiteId           	 	= rsItnr.getString("SITE_ID");
			strUserId            		= rsItnr.getString("TRAVELLER_ID");
		    strDepDateFwdFlt     		= rsItnr.getString("TRAVEL_DATE");
			strReasonForTravel   		= rsItnr.getString("REASON_FOR_TRAVEL");
			strRemarks           		= rsItnr.getString("REMARKS");
			strProjectNo				= rsItnr.getString("PROJECTNO");
			strChangeableAgainst  		= rsItnr.getString("FARE_CHANGEABLE_FLAG");
			strRefundableAgainst  		= rsItnr.getString("FARE_REFUNDABLE_FLAG");
			strCheckedBaggage     		= rsItnr.getString("NO_OF_BAGGAGE");
			strBahncardNo         		= rsItnr.getString("BAHNCARD_NUMBER");
			strBahncardValidityDate 	= rsItnr.getString("BAHNCARD_VALID_DATE");
			strBahncardDiscnt     		= rsItnr.getString("BAHNCARD_DISCOUNT");
			strBahncardClass      		= rsItnr.getString("BAHNCARD_CLASS");
			strBahncardOnlineTkt  		= rsItnr.getString("ONLINE_TICKET");
			strSpecialTrain       		= rsItnr.getString("SPECIAL_TRAIN");
			strRemarkFlt          		= rsItnr.getString("FLIGHT_REMARKS");
			strRemarkTrn          		= rsItnr.getString("TRAIN_REMARKS");
			strCarRemarks				= rsItnr.getString("CAR_REMARKS");
		}
    rsItnr.close();
	
	rs=null;
	rs = dao.getBillingInformation(strTravelId, strTravelType);
	if (rs.next()) {
		strBillingClient           = rs.getString("BILLING_SITE");
		strBillingApprover         = rs.getString("BILLING_CLIENT");
		strTravelReqId             = rs.getString("TRAVEL_REQ_ID");
		strTravllerSiteId          = rs.getString("SITE_ID");	
		if (strBillingApprover == null){
			strBillingApprover = "";
		}				
	}
	rs.close();	
	if (strBillingClient == null) {
	} else {
		strSql = "SELECT  1 AS yes FROM USER_SITE_ACCESS WHERE  (USERID = "+ strUserId+ ") AND (SITE_ID = "	+ strBillingClient+ ") and USER_SITE_ACCESS.STATUS_ID=10";
		rs=null;
		rs = dbConBean.executeQuery(strSql);
		while (rs.next()) {
			strFlag = rs.getString(1);
		}
		rs.close();
	}
}
if(strUserId == null) {
   strUserId = Suser_id;
} else if(strUserId.equals(Suser_id)) {	
}
if(strSiteId == null) {
   strSiteId = strSiteIdSS;	
}
if(strProjectNo==null) {
	strProjectNo="";
}
if(strReasonForTravel==null) {
	strReasonForTravel="";
}
if(strRemarkFlt == null || strRemarkFlt.trim().equals("-")) {
	strRemarkFlt="";
}
if(strRemarkTrn == null || strRemarkTrn.trim().equals("-")) {
	strRemarkTrn="";
}
if(strCarRemarks == null ||strCarRemarks.trim().equals("-")) {
	strCarRemarks="";
}
if(strRemarks == null || strRemarks.trim().equals("-")) {
	strRemarks="";
}
if(strTravllerSiteId==null || "".equals(strTravllerSiteId)) {
	strTravllerSiteId=strSiteId;
}
String TRAVELLERSITEID="", SITENAME="", TRAVELLERUSERID="", FIRSTNAME="", MIDDLENAME="", LASTNAME ="", DESIGNATION	= "", COST_CENTER= "0", COST_CENTER_NAME= "";	
			rs=null;
			rs = dao.getTravellerInfo(strUserId);
			if(rs.next()) {
				TRAVELLERSITEID		=  rs.getString("SITE_ID");
				SITENAME			=  rs.getString("SITENAME");
				TRAVELLERUSERID		=  rs.getString("USERID");
				FIRSTNAME       	=  rs.getString("FIRSTNAME");
				MIDDLENAME			=  rs.getString("MIDDLENAME");
				LASTNAME        	=  rs.getString("LASTNAME");
				DESIGNATION			=  rs.getString("DESIG");
				COST_CENTER			=  rs.getString("COST_CENTER");
				COST_CENTER_NAME	=  rs.getString("COST_CENTER_NAME");
				
				if(COST_CENTER==null) {
					COST_CENTER="0";
				}
				if(COST_CENTER_NAME==null || COST_CENTER_NAME.trim().equals("-")) {
					COST_CENTER_NAME="";
				}
			}
			
			String strShowflagFromDB = dao.getCostCentreFlag(strSiteId);
			if(strShowflagFromDB!=null){
				strShowflag = strShowflagFromDB;
			}
			
			if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
				rs=null;
				strSql = "SELECT SITE_ID, DBO.SITENAME(SITE_ID) AS SITENAME FROM M_SITE WHERE SITE_ID = "+strSiteId;
				rs = dbConBean.executeQuery(strSql);
				if(rs.next()) {
					TRAVELLERSITEID = rs.getString("SITE_ID");
					SITENAME = rs.getString("SITENAME");
				}
				rs.close();
			}
			
// 			if(strShowflag.equalsIgnoreCase("n")) {
// 				COST_CENTER_NAME = dbLabelBean.getLabel("alert.global.notapplicable",strsesLanguage);
// 			}
			
			Set entrySet = null; 
			Iterator it = null;
			
			Map specialMeal = dao.getSpecialMeal(strTravelAgencyId);
			Map preferredTimeList = dao.getPreferredTimeList();
			Map flightClassList = dao.getFlightClassList(strTravelAgencyId, strUserId, strTravelType, strGroupTravelFlag);
			Map flightWindowList = dao.getFlightWindowList(strTravelAgencyId);
			Map trainClassList = dao.getTrainClassList(strTravelAgencyId);
			Map carClassList = dao.getCarClassList(strTravelAgencyId);
			
			Map trainWindowType_1_List = new LinkedHashMap();
			Map trainWindowType_2_List = new LinkedHashMap();
			Map trainWindowType_3_List = new LinkedHashMap();
			
			trainWindowType_1_List.put("Window", "Window");
			trainWindowType_1_List.put("Aisle", "Aisle");
			trainWindowType_2_List.put("Grossraum", "Grossraum");
			trainWindowType_2_List.put("Abteil", "Abteil");
			trainWindowType_3_List.put("With Table", "With Table");
			trainWindowType_3_List.put("Without Table", "Without Table");
			
			List nonSpecificTimeList = new ArrayList();
			nonSpecificTimeList.add("2");
			nonSpecificTimeList.add("3");
			nonSpecificTimeList.add("4");
			nonSpecificTimeList.add("17");
			nonSpecificTimeList.add("29");
			nonSpecificTimeList.add("102");
			
			List excludeTrainTimeList = new ArrayList();
			excludeTrainTimeList.add("1");
			excludeTrainTimeList.add("2");
			excludeTrainTimeList.add("3");
			excludeTrainTimeList.add("4");
			excludeTrainTimeList.add("17");
			excludeTrainTimeList.add("29");	
		%>
		
  <!-- Added By Gurmeet Singh [START] -->
  <script type="text/javascript">
	var siteIdGlobal = '<%=strSiteIdSS%>';
	var userIdGlobal = '<%=Suser_id%>';	
  </script>
  <!-- Added By Gurmeet Singh [END] -->
</head>
<body>
	<div id="divBackground" style="position: absolute; z-index: 99; height: 100%; width: 100%; top: 0; left:0; background-color: Black; filter: alpha(opacity=60); opacity: 0.6; -moz-opacity: 0.8;display:none">
		<div id="waitingData" style="display: none;">
		<center>
			<img src="images/loader-circle.gif?buildstamp=2_0_0" width="50" height="50"/> 
			<br><br>
			<font color="#ffffff" style="font-size:14px;font-weight:bold;font-family:Verdana, Arial, Helvetica, sans-serif;">   
			<span id="pleaseWait">Please Wait...</span>
			</font>  
		</center>
		</div>
	</div>
	<form name="frm" id="frmId" action="T_Group_QuickTravel_Detail_GmbH_Post.jsp">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr><td class="hrSpace4Px"></td></tr>
			<tr>	
			<%
			if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
			%>
				<td><ul class="pagebullet"><li><%=dbLabelBean.getLabel("label.editrequest.guestTravelRequest",strsesLanguage)%>&nbsp;-&nbsp;<span style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; font-weight: bold;color: #0000ff;">[<%=strTravelReqNo %>]</span></li></ul></td>
			<%	} else {%>
				<td><ul class="pagebullet"><li><%=dbLabelBean.getLabel("label.createrequest.guestTravelRequest",strsesLanguage)%></li></ul></td>
			<% } %>
			</tr>
			<tr><td class="hrSpace4Px"></td></tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			style="border: 1px solid #dddddd;">
			<tr>
				<td style="border-width: 0 0 0 0;">
					<table width="100%" border="0" cellspacing="2" cellpadding="0">
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td>
											<table width="100%" border="0" cellspacing="0"
														cellpadding="0" align="center">
												<td style="width:88%; text-align: left;">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0" align="left">
														<tr valign="top">
															<% if(strTravelType !=null && strTravelType.equals("I")) { %>
															<td class="requestType" style="width:15%;">
																<table width="100%" border="0" cellspacing="0"
																	cellpadding="0">
																	<tr>
																		<td id="reqTypeBtn">
																			<table width="75%" border="0" cellspacing="0"
																				cellpadding="0" class="bt-RequestType" align="left">
																				<tr>
																					<td id="bt-Int">
																						<label class="Int"> <input type="radio"
																							name="travelType" value="I" id="rd_Int" checked="checked"><%=dbLabelBean.getLabel("label.global.intercont",strsesLanguage)%>
																					</label>
																					</td>
																				</tr>
																			</table>
																		</td>
																	</tr>
																</table>
															</td>
														<%} else if(strTravelType !=null && strTravelType.equals("D")) { %>
															<td class="requestType" style="width:16%;">
																<table width="100%" border="0" cellspacing="0"
																	cellpadding="0">
																	<tr>
																		<td id="reqTypeBtn">
																			<table width="75%" border="0" cellspacing="0"
																				cellpadding="0" class="bt-RequestType" align="left">
																				<tr>
																					<td id="bt-Dom"><label
																						class="Dom"> <input type="radio"
																							name="travelType" value="D" id="rd_Dom" checked="checked"><%=dbLabelBean.getLabel("label.global.domesticeurope",strsesLanguage)%>
																					</label></td>																					
																				</tr>
																			</table>
																		</td>
																	</tr>
																</table>
															</td>
														<%} else { %>
															<td class="requestType">
																<table width="100%" border="0" cellspacing="0"
																	cellpadding="0">
																	<tr>
																		<td id="reqTypeBtn">
																			<table width="75%" border="0" cellspacing="0"
																				cellpadding="0" class="bt-RequestType" align="left">
																				<tr>
																					<td id="bt-Dom"><label
																						class="Dom"> <input type="radio"
																							name="travelType" value="D" id="rd_Dom"
																							checked="checked"><%=dbLabelBean.getLabel("label.global.domesticeurope",strsesLanguage)%>
																					</label></td>
																					<td id="bt-Int">
																						<label class="Int"> <input type="radio"
																							name="travelType" value="I" id="rd_Int"><%=dbLabelBean.getLabel("label.global.intercont",strsesLanguage)%>
																					</label>
																					</td>
																				</tr>
																			</table>
																		</td>
																	</tr>
																</table>
															</td>						
															<% } %>
															<td id="siteNmLabel"><%=dbLabelBean.getLabel("label.mail.sitename",strsesLanguage)%></td>
															<td id="siteNm">
																<select name="siteNameCombo" class="comboBoxCss" id="siteNameCombo">
																
																<%
																	if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																		
																		strSql="select Site_id, Site_Name from M_Site (NOLOCK) where status_id=10 and application_id=1 and Site_id="+strSiteId;
																		rs = dbConBean.executeQuery(strSql);  
												                        while(rs.next()) {
																%>		
																		<option value="<%=rs.getString("Site_Id")%>"><%=rs.getString("Site_Name")%></option>
																		
																<% 		}
												                    } else { %>
								                           
										                          <option value="S" selected><%=dbLabelBean.getLabel("label.createrequest.selectunit",strsesLanguage) %></option>
																<%
										                          //For Population of Site Combo according to the Site
										                          //strSql =   "select site_id, site_Name from M_Site where status_id=10 and application_id=1 order by 2";
																  strSql = " select distinct site_id, rtrim(ltrim(dbo.sitename(site_id))) as Site_Name from USER_MULTIPLE_ACCESS (NOLOCK) where userid="+Suser_id+" and status_id=10 and (UNIT_HEAD=1 or ROLE_ID='LA') "+
										                          		   " union "+ 
																		   " select distinct site_id, rtrim(ltrim(dbo.sitename(site_id))) as Site_Name from M_USERROLE (NOLOCK) where userid="+Suser_id+" and status_id=10 and (ROLE_ID='TC') order by 2";
																  //System.out.println("strsql-=---=-=-=>"+strSql);
										                          rs       =   dbConBean.executeQuery(strSql);  
										                          while(rs.next()) {
																   
																%>       
										                            <option value="<%=rs.getString("Site_Id")%>"><%=rs.getString("Site_Name")%></option>
																<%
										                     	  }
										                          rs.close();	 
																 
																	
										
																  /*@Gaurav 26-Apr-2007 For Showing Primary site & 27-Apr-2007 it should appear only once */
																  strSql =   " select Site_id, rtrim(ltrim(Site_Name)) as Site_Name from M_Site (NOLOCK) where status_id=10 and application_id=1 and Site_id="+strSiteIdSS+" and Site_id Not IN (select distinct site_id from M_USERROLE (NOLOCK) where userid="+Suser_id+" and status_id=10 and (ROLE_ID='TC')) and "+ 
																  			 " Site_id Not IN (select distinct site_id from USER_MULTIPLE_ACCESS (NOLOCK) where userid="+Suser_id+" and status_id=10 and (UNIT_HEAD=1 or ROLE_ID='LA')) order by 2";	
																  
																  rs       =   dbConBean.executeQuery(strSql);
										                          while(rs.next()) {
																%>
										                             <option value="<%=rs.getString("Site_Id")%>"><%=rs.getString("Site_Name")%></option> 
																<%   
																	}
										                          rs.close();	
																  // End of Code
																}
																%>
										                        </select>
										                        <script language="javascript">
																  var siteIdVal =  "<%=strSiteId%>";																 
																  if(siteIdVal != null && (siteIdVal=="0" || siteIdVal=="")) {
																	  document.frm.siteNameCombo.value="S";   
																  } else {
																	  document.frm.siteNameCombo.value="<%=strSiteId%>"; 
																  }																  
										                        </script>
															</td>
															<td id="travelerNmLabel">&nbsp;</td>
															<td id="travelerNm">&nbsp;</td>													
														</tr>
													</table>
												</td>
												<td style="width:12%; text-align: right;">
													<table width="100%" border="0" cellspacing="0" cellpadding="0" align="right">
														<tr>
															<td id="mataEurope"><%=dbLabelBean.getLabel("label.global.mataeurope",strsesLanguage)%></td>
															<td style="width:3px;"></td>
														</tr>
													</table>
												</td>
											</table>
										</td>
									</tr>
									<tr>
										<td class="hrSpace4Px"></td>
									</tr>		
									<tr>
										<td>
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td id="left">
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td>
																	<table class="personalDetailHeaderTbl">																		
																		<tr>
																			<td class="perDetl"><%=dbLabelBean.getLabel("label.requestdetails.basicinformationoforiginator",strsesLanguage)%></td>																					
																		</tr>
																	</table>
																</td>
															</tr>
															<tr>
																<td>
																<table class="personalDetailInnerTbl">																	
																		<tr>
																			<td class="siteNamelabel"><%=dbLabelBean.getLabel("label.global.unitname",strsesLanguage)%></td>
																			<td class="lastNamelabel"><%=dbLabelBean.getLabel("label.global.firstname",strsesLanguage)%></td>
																			<td class="lastNamelabel"><%=dbLabelBean.getLabel("label.global.lastname",strsesLanguage)%></td>												
																		</tr>
																		<tr>
																		    
																			<td class="siteNameInput"><input type="text"
																				name="siteName" class="textBoxCss"
																				value="<%=SITENAME.trim()%>"
																				id="siteName" readonly="readonly">
																				</td>
																			<td class="firstNameInput"><input type="text"
																				name="firstName" class="textBoxCss"
																				value="<%=FIRSTNAME.trim()%> <%=MIDDLENAME.trim()%>"
																				id="firstName" readonly="readonly"></td>
																			<td class="lastNameInput"><input type="text"
																				name="lastName" class="textBoxCss"
																				value="<%=LASTNAME.trim()%>"
																				id="lastName" readonly="readonly"></td>
																		</tr>
																		<tr><td colspan="3" class="hrSpace4Px"></td></tr>																		
																		<tr>
																			<td class="designationlabel"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%></td>
																			<td class="costCenterLabel"><%=dbLabelBean.getLabel("label.createrequest.costcentre",strsesLanguage) %></td>
																			<td class="projectNoLabel"><%=dbLabelBean.getLabel("label.global.projectnumber",strsesLanguage) %></td>
																		</tr>
																		<tr>
																			<td class="designationInput"><input type="text"
																				name="designation" class="textBoxCss"
																				value="<%=DESIGNATION%>"
																				id="designation" readonly="readonly"></td>
																			<td class="costCenterInput">
																			<input type="hidden"
																				name="costCenter" class="textBoxCss" value="<%=COST_CENTER %>"
																				id="costCenter" readonly="readonly">
																			<input type="text"
																				name="costCenterName" class="textBoxCss" value="<%=COST_CENTER_NAME %>"
																				id="costCenterName" readonly="readonly"></td>
																			<td class="projectNoInput"><input type="text" 
																				name="projectNo" class="textBoxCss" value="<%=strProjectNo %>"
																				id="projectNo" onKeyUp="return test2(this, 50, 'cn')" maxlength="50"></td>													
																		</tr>
																		<tr><td colspan="3" class="hrSpace4Px"></td></tr>
																		<tr>
																			<td class="reasonForTrvLabel" colspan="3"><%=dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage) %></td>
																		</tr>
																		<tr>
																			<td class="reasonForTrvInput" colspan="3">
																				<table width="100%" border="0" cellspacing="0" cellpadding="0">	
																					<tr>
																						<td>
																							<textarea name="reasonForTravel" class="textAreaCss4" id="reasonForTravel" cols="" rows="2" onKeyUp="return test2(this, 1000, 'cn')" maxlength="1000"><%=strReasonForTravel %></textarea>
																						</td>
																					</tr>
																				</table>
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>															
														</table>
													</td>
													<td id="mid">&nbsp;</td>
													<td id="right">
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td>
																	<table class="personalDetailHeaderTbl">
																		<tr>
																			<td class="perDetl"><%=dbLabelBean.getLabel("label.requestdetails.approvers",strsesLanguage) %></td>
																		</tr>
																	</table>
																</td>
															</tr>
															<tr>
																<td>
																	<table width="95%" align="center" border="0" cellpadding="0" cellspacing="0">
																		 <tr>
															                <td align=center>
															                	<div id="workFlowApproverDiv" style="float:left; width:100%; height:82px; overflow-y:auto;"></div>
															                </td>															                
															             </tr>																		 
																	</table> 	
																</td>
															</tr>
															<tr><td  class="hrSpace4Px"></td></tr>
															<tr>
																<td>
																	<table class="personalDetailHeaderTbl">
																		<tr>
																			<td class="perDetl"><%=dbLabelBean.getLabel("label.global.billinginstructions",strsesLanguage) %></td>
																		</tr>
																	</table>
																</td>
															</tr>
															<tr>
																<td>
																	<table class="personalDetailInnerTbl">
																		<tr>
																			<td class="approverLabel" ><%=dbLabelBean.getLabel("label.requestdetails.billingclient",strsesLanguage) %></td>
																			<td class="approverLabel" ><%=dbLabelBean.getLabel("label.requestdetails.billingapprover",strsesLanguage) %></td>																			
																		</tr>
																		<tr>
																			<td class="approverInput"><select name="billingClient"
																				id="billingClient" class="comboBoxCss">
																					<% 
																					strSql = "SELECT SITE_ID,DBO.SITENAME(SITE_ID) AS SITE_NAME FROM M_SITE WHERE STATUS_ID=10 AND APPLICATION_ID=1 AND (M_SITE.CLOSED_UNIT_FLAG is null or M_SITE.CLOSED_UNIT_FLAG='') ORDER BY 2";
																					rs=null;
																					rs = dbConBean.executeQuery(strSql);
																				    while (rs.next()) {%>
																						<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
																						<%}
																						rs.close();
																					%>
																			</select>
																			<%
																				if (strBillingClient != null && !strBillingClient.equals("") && !strBillingClient.equals("-1")	&& !strBillingClient.equals("0")) {
																				%>
																				<script language="javascript">
																					document.frm.billingClient.value="<%=strBillingClient%>";
																				</script>
																				<% } else if (strBillingClient != null && (strBillingClient.equals("-1") || strBillingClient.equals("0"))) { %>
																				<script language="javascript">
																					document.frm.billingClient.value="<%=strTravllerSiteId%>";
																				</script>
																				<%} else if (strBillingClient == null || strBillingClient.equals("")) {
																				%>
																				<script language="javascript">      
																					document.frm.billingClient.value="<%=strTravllerSiteId%>";
																				</script>
																				<%
																				}
																								%>	
																			</td>
																			<td class="approverInput"><select name="billingApprover"
																					id="billingApprover" class="comboBoxCss">
																						<option  value='-1'><%=dbLabelBean.getLabel("label.createrequest.userfrombillingunit",strsesLanguage)%></option>
																							<%
																								if (strBillingClient != null && !strBillingClient.equals("") && !strBillingClient.equals("0") && !strBillingClient.equals("-1") && !strBillingClient.equals(strTravllerSiteId) && !strFlag.equals("1")) { 
																								strSql = "SELECT  1 "
																									+ "FROM M_BILLING_APPROVER BA inner join M_userInfo UI on UI.userid = BA.approver_id "
																									+ "WHERE BA.SITE_ID= " + strBillingClient
																									+ " and status_id =10";
																									
																									rs=null;
																									rs = dbConBean.executeQuery(strSql);
																									if (!rs.next()) {
																										rs.close();
																										strSql = "select distinct userid, dbo.user_name(userid) As UserName from M_userInfo "
																											+ "where (site_id="
																											+ strBillingClient
																											+ " and status_id=10 and  ISNULL(APPROVER_LEVEL,0) in (1,2) )"
																											+ "or (status_id=10 and  ISNULL(APPROVER_LEVEL,0) in (3) )"
																											+ "order by 2";
																											
																											rs=null;
																											rs = dbConBean.executeQuery(strSql);
																											while (rs.next()) {
																										%>
																										<option value="<%=rs.getString("UserId")%>"><%=rs.getString("UserName")%></option>
																										
																										<%
																										}
																										rs.close();
																										} else {
																										strSql = "SELECT distinct APPROVER_ID as userid, dbo.user_name(APPROVER_ID) As UserName "
																											+ "FROM M_BILLING_APPROVER BA inner join M_userInfo UI on UI.userid = BA.approver_id "
																											+ "WHERE BA.SITE_ID= "
																											+ strBillingClient
																											+ " and status_id =10";
																										
																											rs=null;
																											rs = dbConBean.executeQuery(strSql);
																											while (rs.next()) {
																										%>
																										<option value="<%=rs.getString("UserId")%>"><%=rs.getString("UserName")%></option>
																										<%
																										}
																										rs.close();
																										}
																										}
																									%>
																						</select>
																						<%
																						if (strBillingClient != null && !(strBillingClient.equals("-1") || strBillingClient.equals("0") || strBillingClient.equals(""))) {
																						%>
																						<script language="javascript">													
																							document.frm.billingApprover.value="<%=strBillingApprover%>";
																						</script>
																						<%
																							}
																						%>	
																				</td>					
																			</tr>
																	</table>
																</td>
															</tr>															
														</table>
													</td>
												</tr>
											</table>
										</td>										
									</tr>
									
									<!-- Group/Guest Detail section Start ***********************************-->
									<tr>
										<td>
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td>
														<table class="journyDetailHeaderTbl">
															<tr>
															<%
	
																	String groupGuestTravellerLabel = "";
																	if(ssflage.equals("3")){
																		groupGuestTravellerLabel = "label.global.guesttravelerdetail";
																	}else{
																		groupGuestTravellerLabel = "label.global.groupguesttravelerdetail";
																	}
																
																%>
																<td class="perDetl"><%=dbLabelBean.getLabel(groupGuestTravellerLabel,strsesLanguage) %></td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td>														
														<table width="100%" border="0" cellspacing="0" cellpadding="0" id="groupGuestDetailTbl">														
															<tbody>	
															
																<%
																if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																	int countVal = 1;
																	strSql = " SELECT G_USERID, SITE_ID, FIRST_NAME, LAST_NAME, GENDER, MOBILE_NO, ISNULL(FREQUENT_FLYER, '') AS FREQUENT_FLYER, MAEL_ID, PASSPORT_NO, NATIONALITY, PLACE_OF_ISSUE, ISNULL(DBO.CONVERTDATEDMY1(DATE_OF_ISSUE),'-') AS ISSUE_DATE, "+
																			 " ISNULL(DBO.CONVERTDATEDMY1(EXPIRY_DATE),'-') AS EXPIRY_DATE, ISNULL(DBO.CONVERTDATEDMY1(DOB),'-') AS DOB, VISA_REQUIRED "+
																			 " FROM T_GROUP_USERINFO  WHERE  TRAVEL_ID = "+strTravelId+" AND TRAVEL_TYPE = '"+strTravelType+"' AND STATUS_ID=10 ORDER BY G_USERID";
																	rs4 = null;			
																	rs4  =   dbConBean.executeQuery(strSql);  
																	if(rs4.next()) {
																		do {
																			travellerUserId			= rs4.getString("G_USERID");
																			travellerFirstName		= rs4.getString("FIRST_NAME");
																			travellerLastName		= rs4.getString("LAST_NAME");																			
																			travellerGender			= rs4.getString("GENDER");
																			travellerMobileNo		= rs4.getString("MOBILE_NO");
																			travellerFreqFlyer		= rs4.getString("FREQUENT_FLYER"); 
																			travellerMealPref		= rs4.getString("MAEL_ID");
																			travellerPassportNo		= rs4.getString("PASSPORT_NO");
																			travellerNationality	= rs4.getString("NATIONALITY");
																			travellerIssuePlace		= rs4.getString("PLACE_OF_ISSUE");
																			travellerIssueDate		= rs4.getString("ISSUE_DATE");
																			travellerExpiryDate		= rs4.getString("EXPIRY_DATE");
																			travellerDOB			= rs4.getString("DOB");
																			travellerVisaExists		= rs4.getString("VISA_REQUIRED");																
																
															%>	
																<tr class="groupGuestDetailDataRow">
																	<td style="padding-left:12px;">
																		<table width="99%" border="0" cellspacing="0" cellpadding="0" id="groupGuestDetailTblInner">
																			<%
																				if(countVal > 1) {
																			%>
																				<tr>
																					<td>
																						<table border="0" cellspacing="0" cellpadding="0" style="width: 99%;" class="hrTbl">
																							<tr><td style="padding:10px 0 0 0; border-bottom:2px dashed #4a473e;"></td></tr>
																							<tr><td class="hrSpace6Px"></td></tr>
																						</table>
																					</td>
																				</tr>
																			<%
																				}
																			%>
																			<tr>
																				<input type="hidden" name="grpUserID" id="grpUserID" value="<%=travellerUserId%>"/>																				
																				<td>
																					<table width="97.5%" border="0" cellspacing="0" cellpadding="0">
																						<tr>
																							<td class="grpSrNo"><div style="margin:0; padding:0; width:15px; float:left;"><span id="grpSrNoCount" class="grpSrNoCount"><%=countVal %></span><span class="grpSrNoHyphen">-</span></div></td>
																							<td class="grpFirstLastName">
																								<input type="text" name="fNameGroup" class="textBoxCss" id="fNameGroup" value="<%=travellerFirstName%>" onKeyUp="return test2(this, 100, 'c')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.firstnamesasperpassport",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.firstnamesasperpassport",strsesLanguage)%>">
																							</td>
																							<td class="grpFirstLastName">
																								<input type="text" name="lNameGroup" class="textBoxCss" id="lNameGroup" value="<%=travellerLastName%>" onKeyUp="return test2(this, 100, 'c')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.lastnamesasperpassport",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.lastnamesasperpassport",strsesLanguage)%>">
																							</td>
																							<td class="grpGender">
																								<select name="genderGroup" class="comboBoxCss" id="genderGroup" title="<%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%>">
																									<option value='-1'><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%></option>
					                          														<option value='1'><%=dbLabelBean.getLabel("label.global.male",strsesLanguage)%></option>
					                          														<option value='2'><%=dbLabelBean.getLabel("label.global.female",strsesLanguage)%></option>
																								</select>
																								<script language="javascript">
																							 		var genderId = '<%=travellerGender%>';
																							 		if(genderId=='') {
																										document.getElementsByName("genderGroup")[<%=countVal-1%>].value="-1";
																									 } else {
																									    document.getElementsByName("genderGroup")[<%=countVal-1%>].value="<%=travellerGender%>";
																									 }
																							 	</script>
																							</td>
																							<td class="grpMobileNo">
																								<input type="text" name="mobileNoGroup" class="textBoxCss" id="mobileNoGroup" value="<%=travellerMobileNo%>" onKeyUp="return test2(this, 19, 'phone')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.contactno",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.contactno",strsesLanguage)%>">
																							</td>
																							<td class="grpFrequentFlyer">
																								<input type="text" name="frequentFlyerGroup" class="textBoxCss" id="frequentFlyerGroup" value="<%=travellerFreqFlyer%>" onKeyUp="return test2(this, 20, 'cn')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.frequentflyer",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.frequentflyer",strsesLanguage)%>">
																							</td>
																							<td class="grpMealPref">
																							
																							<% if(strTravelType !=null && !strTravelType.equals("") && strTravelType.equals("I")) { %>
																								
																								<select name="specialMealGroup" class="comboBoxCss grpMealPrefCombo show" id="specialMealGroup" title="<%=dbLabelBean.getLabel("label.global.specialmeal",strsesLanguage) %>">		
																									<option value='-1'><%=dbLabelBean.getLabel("label.global.specialmeal",strsesLanguage)%></option>																		
																									<% 
																										entrySet = specialMeal.entrySet(); 
																										it = entrySet.iterator();
																										
																										while(it.hasNext()) {
																		                            	 Map.Entry entry = (Map.Entry)it.next();
																		                            	 
																		                            	 	if(!travellerMealPref.equals("") && entry.getKey().equals(travellerMealPref)) { %>
																				                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																									<% 		} else { %>
																				                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																									<%
																											}
																		                         	 	}
																		                         	%>
																								</select>
																							<% } else if(strTravelType !=null && !strTravelType.equals("") && strTravelType.equals("D")) { %>	
																								<img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0" class="btDelTravellerDom hide"
																									id="bt-Del-Traveller-Dom" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>" style="margin-top:2px;">
																							<% } %>
																							</td>
																						</tr>
																					</table>
																				</td>
																			</tr>
																			<% if(strTravelType !=null && !strTravelType.equals("") && strTravelType.equals("I")) { %>
																			<tr class="passportDetailRow">
																				<td>
																					<table width="100%" border="0" cellspacing="0" cellpadding="0">
																						<tr>
																							<td class="grpSrNo"><div style="margin:0; padding:0; width:15px; float:left;">&nbsp;</div></td>
																							<td class="grpPassportNo">
																								<input type="text" name="passportNoGroup" class="textBoxCss" id="passportNoGroup" value="<%=travellerPassportNo%>" onKeyUp="return test2(this, 49, 'cn')" maxlength="49" placeholder="<%=dbLabelBean.getLabel("label.global.passportnumber",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.passportnumber",strsesLanguage)%>">
																							</td>
																							<td class="grpNationality">
																								<input type="text" name="nationalityGroup" class="textBoxCss" id="nationalityGroup" value="<%=travellerNationality%>" onKeyUp="return test2(this, 29, 'c')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.user.nationalityasperpassport",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.user.nationalityasperpassport",strsesLanguage)%>">
																							</td>
																							<td class="grpIssuePlace">
																								<input type="text" name="placeOfIssueGroup" class="textBoxCss" id="placeOfIssueGroup" value="<%=travellerIssuePlace%>" onKeyUp="return test2(this, 99, 'c')" maxlength="99" placeholder="<%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%>">
																							</td>
																							<td class="grpIssueDate">
																								<input type="text" name="dateOfIssueGroup" class="textBoxCss" id="dateOfIssueGroup" onFocus="initializeDate(this);" value="<%=travellerIssueDate%>" placeholder="<%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%>">
																							</td>
																							<td class="grpExpiryDate">
																								<input type="text" name="dateOfExpiryGroup" class="textBoxCss" id="dateOfExpiryGroup" onFocus="initializeDate(this);" value="<%=travellerExpiryDate%>" placeholder="<%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage)%>">
																							</td>
																							<td class="grpDOB">
																								<input type="text" name="dobGroup" class="textBoxCss" id="dobGroup" value="<%=travellerDOB%>" onFocus="initializeDOBDate(this);" placeholder="<%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%>">
																							</td>																							
																							<td class="grpVisaAndDelBtn">
																								<table width="100%" border="0" cellspacing="0" cellpadding="0">
																									<tr>
																										<td class="grpVisaExists">
																											<select name="visaGroup" class="comboBoxCss" id="visaGroup" title="<%=dbLabelBean.getLabel("label.global.visaexists",strsesLanguage)%>">
								                          														<option value='1'><%=dbLabelBean.getLabel("label.global.visaexists",strsesLanguage)%>&nbsp;[<%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>]</option>
								                          														<option value='2' selected="selected"><%=dbLabelBean.getLabel("label.global.visaexists",strsesLanguage)%>&nbsp;[<%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>]</option>
																											</select>
																											<script language="javascript">
																											    document.getElementsByName("visaGroup")[<%=countVal-1%>].value="<%=travellerVisaExists%>";																					 
																									 		</script>
																										</td>
																										<td class="grpDelBtn">
																											<img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0" 
																												id="bt-Del-Traveller-Int" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>">
																										</td>
																									</tr>
																								</table>
																							</td>
																						</tr>
																					</table>
																				</td>
																			</tr>
																			<% } %>																		
																		</table>
																	</td>
																</tr>
															<%		countVal++;
																	} 
																	while(rs4.next());
																} else {
															%>
																<tr class="groupGuestDetailDataRow">
																	<td style="padding-left:12px;">
																		<table width="99%" border="0" cellspacing="0" cellpadding="0" id="groupGuestDetailTblInner">
																			<tr>
																				<input type="hidden" name="grpUserID" id="grpUserID" value=""/>																				
																				<td>
																					<table width="97.5%" border="0" cellspacing="0" cellpadding="0">
																						<tr>
																							<td class="grpSrNo"><div style="margin:0; padding:0; width:15px; float:left;"><span id="grpSrNoCount" class="grpSrNoCount">1</span><span class="grpSrNoHyphen">-</span></div></td>
																							<td class="grpFirstLastName">
																								<input type="text" name="fNameGroup" class="textBoxCss" id="fNameGroup" value="" onKeyUp="return test2(this, 100, 'c')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.firstnamesasperpassport",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.firstnamesasperpassport",strsesLanguage)%>">
																							</td>
																							<td class="grpFirstLastName">
																								<input type="text" name="lNameGroup" class="textBoxCss" id="lNameGroup" value="" onKeyUp="return test2(this, 100, 'c')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.lastnamesasperpassport",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.lastnamesasperpassport",strsesLanguage)%>">
																							</td>
																							<td class="grpGender">
																								<select name="genderGroup" class="comboBoxCss" id="genderGroup" title="<%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%>">
																									<option value='-1'><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%></option>
					                          														<option value='1'><%=dbLabelBean.getLabel("label.global.male",strsesLanguage)%></option>
					                          														<option value='2'><%=dbLabelBean.getLabel("label.global.female",strsesLanguage)%></option>
																								</select>
																							</td>
																							<td class="grpMobileNo">
																								<input type="text" name="mobileNoGroup" class="textBoxCss" id="mobileNoGroup" value="" onKeyUp="return test2(this, 19, 'phone')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.contactno",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.contactno",strsesLanguage)%>">
																							</td>
																							<td class="grpFrequentFlyer">
																								<input type="text" name="frequentFlyerGroup" class="textBoxCss" id="frequentFlyerGroup" value="" onKeyUp="return test2(this, 20, 'cn')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.frequentflyer",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.frequentflyer",strsesLanguage)%>">
																							</td>
																							<td class="grpMealPref">
																								<select name="specialMealGroup" class="comboBoxCss grpMealPrefCombo show" id="specialMealGroup" title="<%=dbLabelBean.getLabel("label.global.specialmeal",strsesLanguage) %>">		
																									<option value='-1'><%=dbLabelBean.getLabel("label.global.specialmeal",strsesLanguage)%></option>																		
																									<% 
																										entrySet = specialMeal.entrySet(); 
																										it = entrySet.iterator();
																										
																										while(it.hasNext()) {
																		                            	 Map.Entry entry = (Map.Entry)it.next();
																		                            %>
																				                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																									<%
																		                         	 	}
																		                         	 %>
																								</select>																								
																							</td>
																						</tr>
																					</table>
																				</td>
																			</tr>
																			<tr class="passportDetailRow hide">
																				<td>
																					<table width="100%" border="0" cellspacing="0" cellpadding="0">
																						<tr>
																							<td class="grpSrNo"><div style="margin:0; padding:0; width:15px; float:left;">&nbsp;</div></td>
																							<td class="grpPassportNo">
																								<input type="text" name="passportNoGroup" class="textBoxCss" id="passportNoGroup" value="" onKeyUp="return test2(this, 49, 'cn')" maxlength="49" placeholder="<%=dbLabelBean.getLabel("label.global.passportnumber",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.passportnumber",strsesLanguage)%>">
																							</td>
																							<td class="grpNationality">
																								<input type="text" name="nationalityGroup" class="textBoxCss" id="nationalityGroup" value="" onKeyUp="return test2(this, 29, 'c')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.user.nationalityasperpassport",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.user.nationalityasperpassport",strsesLanguage)%>">
																							</td>
																							<td class="grpIssuePlace">
																								<input type="text" name="placeOfIssueGroup" class="textBoxCss" id="placeOfIssueGroup" value="" onKeyUp="return test2(this, 99, 'c')" maxlength="99" placeholder="<%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%>">
																							</td>
																							<td class="grpIssueDate">
																								<input type="text" name="dateOfIssueGroup" class="textBoxCss" id="dateOfIssueGroup" onFocus="initializeDate(this);" value="" placeholder="<%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%>">
																							</td>
																							<td class="grpExpiryDate">
																								<input type="text" name="dateOfExpiryGroup" class="textBoxCss" id="dateOfExpiryGroup" onFocus="initializeDate(this);" value="" placeholder="<%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage)%>">
																							</td>
																							<td class="grpDOB">
																								<input type="text" name="dobGroup" class="textBoxCss" id="dobGroup" value="" onFocus="initializeDOBDate(this);" placeholder="<%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%>">
																							</td>																							
																							<td class="grpVisaAndDelBtn">
																								<table width="100%" border="0" cellspacing="0" cellpadding="0">
																									<tr>
																										<td class="grpVisaExists">
																											<select name="visaGroup" class="comboBoxCss" id="visaGroup" title="<%=dbLabelBean.getLabel("label.global.visaexists",strsesLanguage)%>">
								                          														<option value='1'><%=dbLabelBean.getLabel("label.global.visaexists",strsesLanguage)%>&nbsp;[<%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>]</option>
								                          														<option value='2' selected="selected"><%=dbLabelBean.getLabel("label.global.visaexists",strsesLanguage)%>&nbsp;[<%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>]</option>
																											</select>
																										</td>
																										<td class="grpDelBtn"></td>
																									</tr>
																								</table>
																							</td>
																						</tr>
																					</table>
																				</td>
																			</tr>																		
																		</table>
																	</td>
																</tr>
															<%		
																}
																rs4.close();
															} else {
														    %>														
																<tr class="groupGuestDetailDataRow">
																	<td style="padding-left:12px;">
																		<table width="99%" border="0" cellspacing="0" cellpadding="0" id="groupGuestDetailTblInner">
																			<tr>
																				<input type="hidden" name="grpUserID" id="grpUserID" value=""/>																				
																				<td>
																					<table width="97.5%" border="0" cellspacing="0" cellpadding="0">
																						<tr>
																							<td class="grpSrNo"><div style="margin:0; padding:0; width:15px; float:left;"><span id="grpSrNoCount" class="grpSrNoCount">1</span><span class="grpSrNoHyphen">-</span></div></td>
																							<td class="grpFirstLastName">
																								<input type="text" name="fNameGroup" class="textBoxCss" id="fNameGroup" value="" onKeyUp="return test2(this, 100, 'c')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.firstnamesasperpassport",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.firstnamesasperpassport",strsesLanguage)%>">
																							</td>
																							<td class="grpFirstLastName">
																								<input type="text" name="lNameGroup" class="textBoxCss" id="lNameGroup" value="" onKeyUp="return test2(this, 100, 'c')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.lastnamesasperpassport",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.lastnamesasperpassport",strsesLanguage)%>">
																							</td>
																							<td class="grpGender">
																								<select name="genderGroup" class="comboBoxCss" id="genderGroup" title="<%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%>">
																									<option value='-1'><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%></option>
					                          														<option value='1'><%=dbLabelBean.getLabel("label.global.male",strsesLanguage)%></option>
					                          														<option value='2'><%=dbLabelBean.getLabel("label.global.female",strsesLanguage)%></option>
																								</select>
																							</td>
																							<td class="grpMobileNo">
																								<input type="text" name="mobileNoGroup" class="textBoxCss" id="mobileNoGroup" value="" onKeyUp="return test2(this, 19, 'phone')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.contactno",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.contactno",strsesLanguage)%>">
																							</td>
																							<td class="grpFrequentFlyer">
																								<input type="text" name="frequentFlyerGroup" class="textBoxCss" id="frequentFlyerGroup" value="" onKeyUp="return test2(this, 20, 'cn')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.frequentflyer",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.frequentflyer",strsesLanguage)%>">
																							</td>
																							<td class="grpMealPref">
																								<select name="specialMealGroup" class="comboBoxCss grpMealPrefCombo show" id="specialMealGroup" title="<%=dbLabelBean.getLabel("label.global.specialmeal",strsesLanguage) %>">		
																									<option value='-1'><%=dbLabelBean.getLabel("label.global.specialmeal",strsesLanguage)%></option>																		
																									<% 
																										entrySet = specialMeal.entrySet(); 
																										it = entrySet.iterator();
																										
																										while(it.hasNext()) {
																		                            	 Map.Entry entry = (Map.Entry)it.next();
																		                            %>
																				                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																									<%
																		                         	 	}
																		                         	 %>
																								</select>																								
																							</td>
																						</tr>
																					</table>
																				</td>
																			</tr>
																			<tr class="passportDetailRow hide">
																				<td>
																					<table width="100%" border="0" cellspacing="0" cellpadding="0">
																						<tr>
																							<td class="grpSrNo"><div style="margin:0; padding:0; width:15px; float:left;">&nbsp;</div></td>
																							<td class="grpPassportNo">
																								<input type="text" name="passportNoGroup" class="textBoxCss" id="passportNoGroup" value="" onKeyUp="return test2(this, 49, 'cn')" maxlength="49" placeholder="<%=dbLabelBean.getLabel("label.global.passportnumber",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.passportnumber",strsesLanguage)%>">
																							</td>
																							<td class="grpNationality">
																								<input type="text" name="nationalityGroup" class="textBoxCss" id="nationalityGroup" value="" onKeyUp="return test2(this, 29, 'c')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.user.nationalityasperpassport",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.user.nationalityasperpassport",strsesLanguage)%>">
																							</td>
																							<td class="grpIssuePlace">
																								<input type="text" name="placeOfIssueGroup" class="textBoxCss" id="placeOfIssueGroup" value="" onKeyUp="return test2(this, 99, 'c')" maxlength="99" placeholder="<%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%>">
																							</td>
																							<td class="grpIssueDate">
																								<input type="text" name="dateOfIssueGroup" class="textBoxCss" id="dateOfIssueGroup" onFocus="initializeDate(this);" value="" placeholder="<%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%>">
																							</td>
																							<td class="grpExpiryDate">
																								<input type="text" name="dateOfExpiryGroup" class="textBoxCss" id="dateOfExpiryGroup" onFocus="initializeDate(this);" value="" placeholder="<%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage)%>">
																							</td>
																							<td class="grpDOB">
																								<input type="text" name="dobGroup" class="textBoxCss" id="dobGroup" value="" onFocus="initializeDOBDate(this);" placeholder="<%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%>">
																							</td>																							
																							<td class="grpVisaAndDelBtn">
																								<table width="100%" border="0" cellspacing="0" cellpadding="0">
																									<tr>
																										<td class="grpVisaExists">
																											<select name="visaGroup" class="comboBoxCss" id="visaGroup" title="<%=dbLabelBean.getLabel("label.global.visaexists",strsesLanguage)%>">
								                          														<option value='1'><%=dbLabelBean.getLabel("label.global.visaexists",strsesLanguage)%>&nbsp;[<%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>]</option>
								                          														<option value='2' selected="selected"><%=dbLabelBean.getLabel("label.global.visaexists",strsesLanguage)%>&nbsp;[<%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>]</option>
																											</select>
																										</td>
																										<td class="grpDelBtn"></td>
																									</tr>
																								</table>
																							</td>
																						</tr>
																					</table>
																				</td>
																			</tr>																		
																		</table>
																	</td>
																</tr>
															<%
																}
															%>																
																<tr class="innerRowGroupGuestDetail"></tr>
																<tr class="prototypeRowGroupGuestDetail">
																	<td style="padding-left:12px;">
																		<table width="99%" border="0" cellspacing="0" cellpadding="0" id="groupGuestDetailTblInner">
																			<tr>
																				<td>
																					<table border="0" cellspacing="0" cellpadding="0" style="width: 99%;" class="hrTbl">
																						<tr><td style="padding:10px 0 0 0; border-bottom:2px dashed #4a473e;"></td></tr>
																						<tr><td class="hrSpace6Px"></td></tr>
																					</table>
																				</td>
																			</tr>
																			
																			<tr>
																				<input type="hidden" name="grpUserIDPT" id="grpUserID" value=""/>
																				<td>
																					<table width="97.5%" border="0" cellspacing="0" cellpadding="0">
																						<tr>
																							<td class="grpSrNo"><div style="margin:0; padding:0; width:15px; float:left;"><span id="grpSrNoCount" class="grpSrNoCount"></span><span class="grpSrNoHyphen">-</span></div></td>
																							<td class="grpFirstLastName">
																								<input type="text" name="fNameGroupPT" class="textBoxCss" id="fNameGroup" value="" onKeyUp="return test2(this, 100, 'c')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.firstnamesasperpassport",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.firstnamesasperpassport",strsesLanguage)%>">
																							</td>
																							<td class="grpFirstLastName">
																								<input type="text" name="lNameGroupPT" class="textBoxCss" id="lNameGroup" value="" onKeyUp="return test2(this, 100, 'c')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.lastnamesasperpassport",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.lastnamesasperpassport",strsesLanguage)%>">
																							</td>
																							<td class="grpGender">
																								<select name="genderGroupPT" class="comboBoxCss" id="genderGroup" title="<%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%>">
																									<option value='-1'><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%></option>
					                          														<option value='1'><%=dbLabelBean.getLabel("label.global.male",strsesLanguage)%></option>
					                          														<option value='2'><%=dbLabelBean.getLabel("label.global.female",strsesLanguage)%></option>
																								</select>
																							</td>
																							<td class="grpMobileNo">
																								<input type="text" name="mobileNoGroupPT" class="textBoxCss" id="mobileNoGroup" value="" onKeyUp="return test2(this, 19, 'phone')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.contactno",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.contactno",strsesLanguage)%>">
																							</td>
																							<td class="grpFrequentFlyer">
																								<input type="text" name="frequentFlyerGroupPT" class="textBoxCss" id="frequentFlyerGroup" value="" onKeyUp="return test2(this, 20, 'cn')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.frequentflyer",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.frequentflyer",strsesLanguage)%>">
																							</td>
																							<td class="grpMealPref">
																								<select name="specialMealGroupPT" class="comboBoxCss grpMealPrefCombo show" id="specialMealGroup" title="<%=dbLabelBean.getLabel("label.global.specialmeal",strsesLanguage) %>">																				
																									<option value='-1'><%=dbLabelBean.getLabel("label.global.specialmeal",strsesLanguage)%></option>
																									<% 
																										entrySet = specialMeal.entrySet(); 
																										it = entrySet.iterator();
																										
																										while(it.hasNext()) {
																		                            	 Map.Entry entry = (Map.Entry)it.next();
																		                            %>
																				                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																									<%
																		                         	 	}
																		                         	 %>
																								</select>
																								<img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0" class="btDelTravellerDom hide"
																									id="bt-Del-Traveller-Dom" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>" style="margin-top:2px;">
																							</td>
																						</tr>
																					</table>
																				</td>																				
																			</tr>
																			<tr class="passportDetailRow hide">
																				<td>
																					<table width="100%" border="0" cellspacing="0" cellpadding="0">
																						<tr>
																							<td class="grpSrNo"><div style="margin:0; padding:0; width:15px; float:left;">&nbsp;</div></td>
																							<td class="grpPassportNo">
																								<input type="text" name="passportNoGroupPT" class="textBoxCss" id="passportNoGroup" value="" onKeyUp="return test2(this, 49, 'cn')" maxlength="49" placeholder="<%=dbLabelBean.getLabel("label.global.passportnumber",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.passportnumber",strsesLanguage)%>">
																							</td>
																							<td class="grpNationality">
																								<input type="text" name="nationalityGroupPT" class="textBoxCss" id="nationalityGroup" value="" onKeyUp="return test2(this, 29, 'c')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.user.nationalityasperpassport",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.user.nationalityasperpassport",strsesLanguage)%>">
																							</td>
																							<td class="grpIssuePlace">
																								<input type="text" name="placeOfIssueGroupPT" class="textBoxCss" id="placeOfIssueGroup" value="" onKeyUp="return test2(this, 99, 'c')" maxlength="99" placeholder="<%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%>">
																							</td>
																							<td class="grpIssueDate">
																								<input type="text" name="dateOfIssueGroupPT" class="textBoxCss" id="dateOfIssueGroup" onFocus="initializeDate(this);" value="" placeholder="<%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%>">
																							</td>
																							<td class="grpExpiryDate">
																								<input type="text" name="dateOfExpiryGroupPT" class="textBoxCss" id="dateOfExpiryGroup" onFocus="initializeDate(this);" value="" placeholder="<%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage)%>">
																							</td>
																							<td class="grpDOB">
																								<input type="text" name="dobGroupPT" class="textBoxCss" id="dobGroup" value="" onFocus="initializeDOBDate(this);" placeholder="<%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%>">
																							</td>																							
																							<td class="grpVisaAndDelBtn">
																								<table width="100%" border="0" cellspacing="0" cellpadding="0">
																									<tr>
																										<td class="grpVisaExists">
																											<select name="visaGroupPT" class="comboBoxCss" id="visaGroup" title="<%=dbLabelBean.getLabel("label.global.visaexists",strsesLanguage)%>">
								                          														<option value='1'><%=dbLabelBean.getLabel("label.global.visaexists",strsesLanguage)%>&nbsp;[<%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>]</option>
								                          														<option value='2' selected="selected"><%=dbLabelBean.getLabel("label.global.visaexists",strsesLanguage)%>&nbsp;[<%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>]</option>
																											</select>
																										</td>
																										<td class="grpDelBtn">
																											<img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0" 
																												id="bt-Del-Traveller-Int" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>">
																										</td>
																									</tr>
																								</table>
																							</td>
																						</tr>
																					</table>
																				</td>																				
																			</tr>																		
																		</table>
																	</td>
																</tr>																																	
															</tbody>															
															<tr>
																<td style="padding-left:28px;">
																	<input type="button" value="<%=dbLabelBean.getLabel("label.global.addtraveler",strsesLanguage)%>" class="bt-Add-Dom"
																	id="bt_Add_Traveller" title="<%=dbLabelBean.getLabel("label.global.addtraveler",strsesLanguage)%>" />
																</td>
															</tr>															
														</table>														
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<!-- Group/Guest Detail section End ***********************************-->
									
									<!-- Journy Detail section Start ***********************************-->
									<tr>
										<td>
											<table class="journyDetailMainTbl">
												<tr>
													<td>
														<table class="journyDetailHeaderTbl">
															<tr>
																<td class="perDetl"><%=dbLabelBean.getLabel("label.global.journeydetails",strsesLanguage) %></td>
															</tr>
														</table>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<!-- Journy Detail section End ***********************************-->
									
									<!-- Flight Detail Section Start ****************** -->
									<tr>
										<td class="journyType">
											<table class="journyDetailFltMainTbl">
												<tr>
													<td class="journyDetailLabel"><label
														class="requiredInput"><b><%=dbLabelBean.getLabel("label.global.flightdetails",strsesLanguage) %></b></label></td>
													<td class="journyDetailRadio">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="0" class="checkbox">
															<tr>
																<td class="labelTd"><label class="yes"
																	id="fltRequiredYes"> <input type="radio"
																		name="flight" value="1" id="fltRequired_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
																</label></td>
																<td class="labelTd"><label class="no"
																	id="fltRequiredNo"> <input type="radio"
																		name="flight" value="2" checked="checked"
																		id="fltRequired_N"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
																</label></td>
															</tr>
														</table>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr id="flightDetailDiv" class="hide">
										<td>
											<table class="journyDetailFltInner1Tbl" id="tblItineraryFltMain">
												<tr>
													<td class="journyInner"><label class="requiredInput"><b><%=dbLabelBean.getLabel("label.global.outwardleg",strsesLanguage)%></b></label></td>
												</tr>
												<tr class="flightDataRow">
													<td class="journyInner">
														<table class="journyDetailFltInner2Tbl" id="tblItineraryFltOutLeg">
															<tbody>
															<%
																if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																	if(strTravelType.equals("D")) {
																		strSql =" SELECT 'Forword' as JOURNEY,TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(ISNULL(TJDD.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																				" ISNULL(TRAVEL_CLASS,'1') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE "+
																				" FROM T_TRAVEL_DETAIL_DOM (nolock) AS TTDD INNER JOIN T_JOURNEY_DETAILS_DOM (nolock) AS TJDD ON TTDD.TRAVEL_ID = TJDD.TRAVEL_ID "+
																				" WHERE TTDD.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1 AND JOURNEY_ORDER =(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1 AND STATUS_ID=10)";
																	} else if(strTravelType.equals("I")) {
																		strSql =" SELECT 'Forword' as JOURNEY,TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(ISNULL(TJDI.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																				" ISNULL(TRAVEL_CLASS,'1') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE "+
																				" FROM T_TRAVEL_DETAIL_INT (nolock) AS TTDI INNER JOIN T_JOURNEY_DETAILS_INT (nolock) AS TJDI ON TTDI.TRAVEL_ID = TJDI.TRAVEL_ID "+
																				" WHERE TTDI.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1 AND JOURNEY_ORDER =(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1 AND STATUS_ID=10)";
																	}										
										
																	rs1=null;
																	rs1  =   dbConBean.executeQuery(strSql);  
																	if(rs1.next()) {
																		flightYNFlag 				= "true";
																		strDepCityFwdFlt           	= rs1.getString("TRAVEL_FROM"); 
																		strArrCityFwdFlt           	= rs1.getString("TRAVEL_TO");
																		strDepDateFwdFlt		 	= rs1.getString("TRAVEL_DATE");
																		strPreferTimeModeFwdFlt	  	= rs1.getString("PREF_TIME_TYPE");
																		strPreferTimeFwdFlt        	= rs1.getString("PREFERRED_TIME");
																		strTravelClassFwdFlt       	= rs1.getString("TRAVEL_CLASS");
																		strPreferSeatFwdFlt      	= rs1.getString("SEAT_PREFFERED");																
																	}
																	rs1.close();
																} 
															%>																
																<tr class="">
																	<td class="city"><input type="text" name="depCityFlt"
																		class="textBoxCss" value="<%=strDepCityFwdFlt %>" id="depCityFltTBFwd"
																		onFocus="initializeAirPortName(this);"
																		placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"
																		onKeyUp="return test2(this, 100, 'sector')" maxlength="100"
																		title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																	<td class="city"><input type="text" name="arrCityFlt"
																		class="textBoxCss" value="<%=strArrCityFwdFlt %>" id="arrCityFltTBFwd"
																		onFocus="initializeAirPortName(this);"
																		placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"
																		onKeyUp="return test2(this, 100, 'sector')" maxlength="100"
																		title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																	<td class="date"><input type="text" name="depDateFlt"
																		class="textBoxCss validDateFlt validDate" value="<%=strDepDateFwdFlt %>" id="depDateFltTBFwd"
																		onFocus="initializeJourneyDateFlt(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');"
																		placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																	<td class="timeMode"><select name="preferTimeModeFlt"
																		class="comboBoxCss" id="preferTimeModeFltSBFwd"
																		title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																			<%
																			TravelRequestEnums.PreferredTimeTypes [] types =   TravelRequestEnums.PreferredTimeTypes.values();
																			for(int i=0; i<types.length; i++){
																				if(!strPreferTimeModeFwdFlt.equals("") && types[i].getId().equals(strPreferTimeModeFwdFlt)) {
																			%>
														                              	<option value="<%=types[i].getId()%>" selected="selected"><%=types[i].getName()%></option>
																			<%
												                            	 } else {
												                            		 if((strPreferTimeModeFwdFlt == null || strPreferTimeModeFwdFlt.equals("")) && types[i].getId().equals("2")) {
												                            %>
														                              	<option value="<%=types[i].getId()%>" selected="selected"><%=types[i].getName()%></option>
																			<%
												                            		 } else {
												                            %>
												                            			<option value="<%=types[i].getId()%>"><%=types[i].getName()%></option>
												                            <%	 
												                            		 }
												                            	 }
																			}
																			%>
																	</select>
																	</td>
																	<td class="time"><select name="preferTimeFlt"
																		class="comboBoxCss" id="preferTimeFltSBFwd"
																		title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																		<option value="-1" selected="selected"><%=dbLabelBean.getLabel("label.createrequest.selectTime", strsesLanguage) %></option>
																			<%						                           
																					entrySet = preferredTimeList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
																					 	if(!entry.getKey().equals("102")){
														                            	 if(!strPreferTimeFwdFlt.equals("") && entry.getKey().equals(strPreferTimeFwdFlt)) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }}
														                         	 }
																			%>			
																	</select>
																	</td>																	
																	<td class="trClass"><select name="departClassFlt"
																		class="comboBoxCss comboDepartClassFlt"
																		id="departClassFltSBFwd" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																		
																			<%						                           
																					entrySet = flightClassList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 
														                            	 if(!strTravelClassFwdFlt.equals("") && entry.getKey().equals(strTravelClassFwdFlt)) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }else if((strTravelClassFwdFlt == null || strTravelClassFwdFlt.equals("")) && entry.getKey().equals("24")){
														                            		 %>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                            	 else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                         	 }
																				%>
																	</select>
																	</td>
																	<td class="seatFlt"><select name="seatPreffredFlt"
																		class="comboBoxCss comboPrefSeat" id="seatPreffredFltSBFwd"
																		title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																			<%						                           
																					entrySet = flightWindowList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 
														                            	 if(!strPreferSeatFwdFlt.equals("") && entry.getKey().equals(strPreferSeatFwdFlt)) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }else if((strPreferSeatFwdFlt == null || strPreferSeatFwdFlt.equals("")) && entry.getKey().equals("21")){
														                            		 %>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                         	 }
																				%>
																	</select>
																	</td>
																	<td class="del"></td>
																</tr>
																
															</tbody>
														</table>
													</td>
												</tr>
												<tr id="intermediateLableFlt" class="hide">
													<td class="journyInner"><label class="requiredInput"><b><%=dbLabelBean.getLabel("label.global.intermediateleg",strsesLanguage)%></b></label></td>
												</tr>

												<tr class="flightDataRow">
													<td class="journyInner">
														<table class="journyDetailFltInner2Tbl" id="tblItineraryFltInter">
															<tbody>
															<%
																int i = 0;
																String showLabelFlt = "false";
																if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																	if(strTravelType.equals("D")) {
																		strSql =" SELECT 'Intermediate' as JOURNEY,TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(ISNULL(TJDD.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																				" ISNULL(TRAVEL_CLASS,'1') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE "+
																				" FROM T_TRAVEL_DETAIL_DOM (nolock) AS TTDD INNER JOIN T_JOURNEY_DETAILS_DOM (nolock) AS TJDD ON TTDD.TRAVEL_ID = TJDD.TRAVEL_ID "+
																				" WHERE TTDD.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1 AND JOURNEY_ORDER >(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1 AND STATUS_ID=10)";
																	} else if(strTravelType.equals("I")) {
																		strSql =" SELECT 'Intermediate' as JOURNEY,TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(ISNULL(TJDI.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																				" ISNULL(TRAVEL_CLASS,'1') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE "+
																				" FROM T_TRAVEL_DETAIL_INT (nolock) AS TTDI INNER JOIN T_JOURNEY_DETAILS_INT (nolock) AS TJDI ON TTDI.TRAVEL_ID = TJDI.TRAVEL_ID  "+
																				" WHERE TTDI.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1 AND JOURNEY_ORDER >(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1 AND STATUS_ID=10)";
																	}		
																	
																	rs2 = null;
																	rs2  =   dbConBean.executeQuery(strSql);  
																while(rs2.next()) {
																	flightYNFlag 					= "true";
																	showLabelFlt 					= "true";
																	strDepCityIntrmiFlt           	= rs2.getString("TRAVEL_FROM"); 
																	strArrCityIntrmiFlt           	= rs2.getString("TRAVEL_TO");
																	strDepDateIntrmiFlt           	= rs2.getString("TRAVEL_DATE");
																	strPreferTimeModeIntrmiFlt	  	= rs2.getString("PREF_TIME_TYPE");
																	strPreferTimeIntrmiFlt        	= rs2.getString("PREFERRED_TIME");
																	strTravelClassIntrmiFlt       	= rs2.getString("TRAVEL_CLASS");
																	strPreferSeatIntrmiFlt      	= rs2.getString("SEAT_PREFFERED");	
																
																		if(!strDepCityIntrmiFlt.trim().equals("") || !strArrCityIntrmiFlt.trim().equals("")) {	
																		%>
																		<tr class="itineraryDataRowFlt">
																			<td class="city"><input type="text"
																				name="depCityFlt" class="textBoxCss" value="<%=strDepCityIntrmiFlt %>"
																				id="depCityFltTBIntrim" onFocus="initializeAirPortName(this);"
																				placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"
																				onKeyUp="return test2(this, 100, 'sector')" maxlength="100"
																				title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																			<td class="city"><input type="text"
																				name="arrCityFlt" class="textBoxCss" value="<%=strArrCityIntrmiFlt %>"
																				id="arrCityFltTBIntrim" onFocus="initializeAirPortName(this);"
																				placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"
																				onKeyUp="return test2(this, 100, 'sector')" maxlength="100"
																				title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																			<td class="date"><input type="text"
																				name="depDateFlt" class="textBoxCss validDateFlt validDate" value="<%=strDepDateIntrmiFlt %>"
																				id="depDateFltTBIntrim" onFocus="initializeJourneyDateFlt(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');"
																				placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																			<td class="timeMode"><select name="preferTimeModeFlt"
																				class="comboBoxCss" id="preferTimeModeFltSBIntrim"
																				title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																				
																				<%
																					types =   TravelRequestEnums.PreferredTimeTypes.values();
																					for(i=0; i<types.length; i++){
																						
																						if(!strPreferTimeModeIntrmiFlt.equals("") && types[i].getId().equals(strPreferTimeModeIntrmiFlt)) {
																							%>
																                              	<option value="<%=types[i].getId()%>" selected="selected"><%=types[i].getName()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=types[i].getId()%>"><%=types[i].getName()%></option>
																							<%
														                            	 }
																					}
																					%>
																			</select>
																			</td>
																			<td class="time"><select name="preferTimeFlt"
																				class="comboBoxCss" id="preferTimeFltSBIntrim"
																				title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																				<option value="-1" selected="selected"><%=dbLabelBean.getLabel("label.createrequest.selectTime", strsesLanguage) %></option>
																					
																					<%						                           
																					entrySet = preferredTimeList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	if(!entry.getKey().equals("102")){
														                            	 if(!strPreferTimeIntrmiFlt.equals("") && entry.getKey().equals(strPreferTimeIntrmiFlt)) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }}
														                         	 }
																					%>	
																			</select>
																			</td>
																			<td class="trClass"><select name="departClassFlt"
																				class="comboBoxCss comboDepartClassFlt"
																				id="departClassFltSBIntrim" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																					<%						                           
																					entrySet = flightClassList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 
														                            	 if(!strTravelClassIntrmiFlt.equals("") && entry.getKey().equals(strTravelClassIntrmiFlt)) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }else if((strTravelClassIntrmiFlt == null || strTravelClassIntrmiFlt.equals("")) && entry.getKey().equals("24")){
														                            		 %>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                         	 }
																					%>
																			</select>
																			</td>
																			<td class="seatFlt"><select name="seatPreffredFlt"
																				class="comboBoxCss comboPrefSeat" id="seatPreffredFltSBIntrim"
																				title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																					<%						                           
																					entrySet = flightWindowList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 
														                            	 if(!strPreferSeatIntrmiFlt.equals("") && entry.getKey().equals(strPreferSeatIntrmiFlt)) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }else if((strPreferSeatIntrmiFlt == null || strPreferSeatIntrmiFlt.equals("")) && entry.getKey().equals("21")){
														                            		 %>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                         	 }
																				%>
																			</select>
																			</td>
																			<td class="del"><img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0" 
																			id="bt-Del-ItInr_Flt" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"></td>
																		</tr>
																	<%
																		}
																		 i++;
																	}
																%>
																<script language="javascript">
																  var showLabelFltFlag = '<%=showLabelFlt%>';																  
																  if(showLabelFltFlag === "true") {																	  
																	  $("tr#intermediateLableFlt").removeClass("hide");
																	  $("tr#intermediateLableFlt").addClass("show");
																  } else {
																	  $("tr#intermediateLableFlt").removeClass("show");
																	  $("tr#intermediateLableFlt").addClass("hide");
																  }
										                        </script>
																<%
																rs2.close();
																}																
															%>
																<tr class="innerRowItineraryFlt"></tr>
																<tr class="prototypeRowItineraryFlt">
																	<td class="city"><input type="text"
																		name="depCityFltPT" class="textBoxCss" value=""
																		id="depCityFltTBIntrim" onFocus="initializeAirPortName(this);"
																		placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"
																		onKeyUp="return test2(this, 100, 'sector')" maxlength="100"
																		title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																	<td class="city"><input type="text"
																		name="arrCityFltPT" class="textBoxCss" value=""
																		id="arrCityFltTBIntrim" onFocus="initializeAirPortName(this);"
																		placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"
																		onKeyUp="return test2(this, 100, 'sector')" maxlength="100"
																		title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																	<td class="date"><input type="text"
																		name="depDateFltPT" class="textBoxCss validDateFlt validDate" value=""
																		id="depDateFltTBIntrim" onFocus="initializeJourneyDateFlt(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');"
																		placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																	<td class="timeMode"><select name="preferTimeModeFltPT"
																		class="comboBoxCss" id="preferTimeModeFltSBIntrim"
																		title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																			<%
																			types =   TravelRequestEnums.PreferredTimeTypes.values();
																			for(i=0; i<types.length; i++){																			
																			
																				if(types[i].getId().equals("1")) {
												                            %>
														                             <option value="<%=types[i].getId()%>" selected="selected"><%=types[i].getName()%></option>
																			<%
												                            	} else {
												                            %>
												                            		<option value="<%=types[i].getId()%>"><%=types[i].getName()%></option>
												                            <%	 
												                            	}																			
																			} 
																			%>
																	</select>
																	</td>
																	<td class="time"><select name="preferTimeFltPT"
																		class="comboBoxCss" id="preferTimeFltSBIntrim"
																		title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																		<option value="-1" selected="selected"><%=dbLabelBean.getLabel("label.createrequest.selectTime", strsesLanguage) %></option>
																			<%						                           
																					entrySet = preferredTimeList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            		if(!entry.getKey().equals("102")){
																					%>
														                              <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																					<%
														                         	 }}
																					%>
																	</select></td>																	
																	<td class="trClass"><select name="departClassFltPT"
																		class="comboBoxCss comboDepartClassFlt"
																		id="departClassFltSBIntrim" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																			<%						                           
																					entrySet = flightClassList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                             if(entry.getKey().equals("24")){
													                            		 %>
															                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																						<%
													                            	 }else{
																					%>
														                              <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																					<%
														                         	 }}
																					%>
																	</select></td>
																	<td class="seatFlt"><select name="seatPreffredFltPT"
																		class="comboBoxCss comboPrefSeat" id="seatPreffredFltSBIntrim"
																		title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																			<%						                           
																					entrySet = flightWindowList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                             if(entry.getKey().equals("21")){
													                            		 %>
															                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																						<%
													                            	 }else{
																					%>
														                              <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																					<%
														                         	 }}
																					%>
																	</select></td>
																	<td class="del"><img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0" 
																			id="bt-Del-ItInr_Flt" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"></td>
																</tr>
															</tbody>															
														</table>
													</td>
												</tr>
												<tr>
													<td class="journyInner"><label class="requiredInput"><b><%=dbLabelBean.getLabel("label.global.returnleg",strsesLanguage)%></b></label></td>
												</tr>
												<tr class="flightDataRow">
													<td class="journyInner">
														<table class="journyDetailFltInner2Tbl" id="tblItineraryFltReturnLeg">
															<tbody>
															<%
																if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																	if(strTravelType.equals("D")) {
																		  strSql = " SELECT 'Return' as Journey, RETURN_FROM, RETURN_TO, DBO.CONVERTDATEDMY1(ISNULL(TJRDD.TRAVEL_DATE, '')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																				   " ISNULL(TRAVEL_CLASS,'1') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE "+
																				   " FROM T_TRAVEL_DETAIL_DOM (nolock) AS TTDD INNER JOIN T_RET_JOURNEY_DETAILS_DOM (nolock) AS TJRDD ON TTDD.TRAVEL_ID = TJRDD.TRAVEL_ID WHERE TTDD.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1";
																	  } else if(strTravelType.equals("I")) {
																		  strSql = " SELECT 'Return' as Journey, RETURN_FROM, RETURN_TO, DBO.CONVERTDATEDMY1(ISNULL(TJRDI.TRAVEL_DATE, '')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																				   " ISNULL(TRAVEL_CLASS,'1') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE "+
																				   " FROM T_TRAVEL_DETAIL_INT (nolock) AS TTDI INNER JOIN T_RET_JOURNEY_DETAILS_INT (nolock) AS TJRDI ON TTDI.TRAVEL_ID = TJRDI.TRAVEL_ID WHERE TTDI.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1";
																	  }											
								
																	rs3=null;
																	rs3  =   dbConBean.executeQuery(strSql);  
																	if(rs3.next()) {
																		flightYNFlag 			   	= "true";
																		strDepCityRetFlt           	= rs3.getString("RETURN_FROM"); 
																		strArrCityRetFlt           	= rs3.getString("RETURN_TO");
																		strDepDateRetFlt           	= rs3.getString("TRAVEL_DATE");	
																		strPreferTimeModeRetFlt	  	= rs3.getString("PREF_TIME_TYPE");
																		strPreferTimeRetFlt        	= rs3.getString("PREFERRED_TIME");
																		strTravelClassRetFlt       	= rs3.getString("TRAVEL_CLASS");
																		strPreferSeatRetFlt      	= rs3.getString("SEAT_PREFFERED");																
																	}
																	rs3.close();
																} 
															%>	
																<tr class="">
																	<td class="city"><input type="text" name="depCityFlt"
																		class="textBoxCss" value="<%=strDepCityRetFlt %>" id="depCityFltTBRet"
																		onFocus="initializeAirPortName(this);"
																		placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"
																		onKeyUp="return test2(this, 100, 'sector')" maxlength="100"
																		title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																	<td class="city"><input type="text" name="arrCityFlt"
																		class="textBoxCss" value="<%=strArrCityRetFlt %>" id="arrCityFltTBRet"
																		onFocus="initializeAirPortName(this);"
																		placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"
																		onKeyUp="return test2(this, 100, 'sector')" maxlength="100"
																		title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																	<td class="date"><input type="text" name="depDateFlt"
																		class="textBoxCss validDateFlt validDate" value="<%=strDepDateRetFlt %>" id="depDateFltTBRet"
																		onFocus="initializeJourneyDateFlt(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');"
																		placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																	<td class="timeMode"><select name="preferTimeModeFlt"
																		class="comboBoxCss" id="preferTimeModeFltSBRet"
																		title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																			<%
																			types =   TravelRequestEnums.PreferredTimeTypes.values();
																			for(i=0; i<types.length; i++){
																				
																				if(!strPreferTimeModeRetFlt.equals("") && types[i].getId().equals(strPreferTimeModeRetFlt)) {
																			%>
														                              	<option value="<%=types[i].getId()%>" selected="selected"><%=types[i].getName()%></option>
																			<%
												                            	 } else {
												                            		 if((strPreferTimeModeRetFlt == null || strPreferTimeModeRetFlt.equals("")) && types[i].getId().equals("1")) {
												                            %>
														                              	<option value="<%=types[i].getId()%>" selected="selected"><%=types[i].getName()%></option>
																			<%
												                            		 } else {
												                            %>
												                            			<option value="<%=types[i].getId()%>"><%=types[i].getName()%></option>
												                            <%	 
												                            		 }
												                            	 }
																			} 
																			%>
																	</select>
																	</td>
																	<td class="time"><select name="preferTimeFlt"
																		class="comboBoxCss" id="preferTimeFltSBRet"
																		title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																		<option value="-1" selected="selected"><%=dbLabelBean.getLabel("label.createrequest.selectTime", strsesLanguage) %></option>
																			<%						                           
																					entrySet = preferredTimeList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 if(!entry.getKey().equals("102")){
														                            	 if(!strPreferTimeRetFlt.equals("") && entry.getKey().equals(strPreferTimeRetFlt)) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }}
														                         	 }
																					%>
																	</select>
																	</td>
																	<td class="trClass"><select name="departClassFlt"
																		class="comboBoxCss comboDepartClassFlt"
																		id="departClassFltSBRet" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																			<%						                           
																					entrySet = flightClassList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 
														                            	 if(!strTravelClassRetFlt.equals("") && entry.getKey().equals(strTravelClassRetFlt)) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }else if((strTravelClassRetFlt == null || strTravelClassRetFlt.equals("")) && entry.getKey().equals("24")){
														                            		 %>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                         	 }
																					%>
																	</select>
																	</td>
																	<td class="seatFlt"><select name="seatPreffredFlt"
																		class="comboBoxCss comboPrefSeat" id="seatPreffredFltSBRet"
																		title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																			<%						                           
																					entrySet = flightWindowList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 
														                            	 if(!strPreferSeatRetFlt.equals("") && entry.getKey().equals(strPreferSeatRetFlt)) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }else if((strPreferSeatRetFlt == null || strPreferSeatRetFlt.equals("")) && entry.getKey().equals("21")){
														                            		 %>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                         	 }
																					%>
																	</select>
																	</td>
																	<td class="del"></td>
																</tr>
															</tbody>
														</table>
													</td>
												</tr>
												<script language="javascript">
												 var flightDetailFlag = '<%=flightYNFlag%>';
												 if(flightDetailFlag === "true") {
													$("label#fltRequiredNo").removeClass("active");
													$("label#fltRequiredYes").addClass("active");
													$("input:radio#fltRequired_N").attr('checked', false);
													$("input:radio#fltRequired_Y").attr('checked', true);													
													$("tr#flightDetailDiv").removeClass("hide");
													$("tr#flightDetailDiv").addClass("show");
												 } else {
													 $("label#fltRequiredYes").removeClass("active");
													 $("label#fltRequiredNo").addClass("active");
													 $("input:radio#fltRequired_Y").attr('checked', false);
													 $("input:radio#fltRequired_N").attr('checked', true);
													 $("tr#flightDetailDiv").removeClass("show");
													 $("tr#flightDetailDiv").addClass("hide");
												 }
						                        </script>
												<tr valign="top">
													<td>
														<table class="journyDetailFltInner3Tbl">
															<tr>
																<td class="itenaryRemark"><textarea
																		name="remarksFlt" id="remarksFlt" class="textAreaCss4"
																		rows="" cols="" onKeyUp="return test2(this, 1000, 'cn')" maxlength="1000" placeholder="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>"><%=strRemarkFlt %></textarea></td>
																<td class="journyInner" style="vertical-align: middle;"><input type="button"
																	value="<%=dbLabelBean.getLabel("label.global.addintermediateleg",strsesLanguage)%>" class="bt-Add-Dom"
																	id="bt_Add_Flt" title="<%=dbLabelBean.getLabel("label.global.addintermediateleg",strsesLanguage)%>" /></td>
																</td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td class="journyInner"><label class="requiredInput"><b><%=dbLabelBean.getLabel("label.global.fares",strsesLanguage)%></b></label>
													</td>
												</tr>
												<tr>
													<td class="journyInner">
														<table class="journyDetailFltInner4Tbl">
															<tr>
																<td class="flightChangeableLabel"><%=dbLabelBean.getLabel("label.global.changeableagainstafee",strsesLanguage)%></td>
																<td class="flightRefundableLabel"><%=dbLabelBean.getLabel("label.global.refundableagainstafee",strsesLanguage)%></td>
																<td class="flightChkBaggagecLabel"><%=dbLabelBean.getLabel("label.global.checkedbaggage",strsesLanguage)%></td>
															</tr>
															<tr>
																<td class="flightChangeableInput">
																	<table style="width:22%;" border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td class="requiredRadioBoxDefault">
																				<table width="100%" border="0" cellspacing="0"
																					cellpadding="0" class="checkbox">
																					<tr>
																						<td class="labelTd"><label class="yes"
																							id="changeableRequiredYes"> <input
																								type="radio" name="changeable" value="1"
																								checked="checked" id="changeableRequired_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
																						</label></td>
																						<td class="labelTd"><label class="no"
																							id="changeableRequiredNo"> <input
																								type="radio" name="changeable" value="2"
																								id="changeableRequired_N"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
																						</label></td>
																					</tr>
																				</table>
																				<script language="javascript">
																				 var changeableAgainst = '<%=strChangeableAgainst%>';
																				 if(changeableAgainst == '1') {
																					 $("label#changeableRequiredNo").removeClass("active");
																					 $("label#changeableRequiredYes").addClass("active");																					 
																					 $("input#changeableRequired_N").attr('checked', false);
																					 $("input#changeableRequired_Y").attr('checked', true);
																				 } else {
																					 $("label#changeableRequiredYes").removeClass("active");
																					 $("label#changeableRequiredNo").addClass("active");
																					 $("input#changeableRequired_Y").attr('checked', false);
																					 $("input#changeableRequired_N").attr('checked', true);																					 
																				 }
														                        </script>
																			</td>
																		</tr>
																	</table>
																</td>
																<td class="flightRefundableInput">
																	<table style="width:22%;" border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td class="requiredRadioBoxDefault">
																				<table width="100%" border="0" cellspacing="0"
																					cellpadding="0" class="checkbox">
																					<tr>
																						<td class="labelTd"><label class="yes"
																							id="refundableRequiredYes"> <input
																								type="radio" name="refundable" value="1"
																								id="refundableRequired_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
																						</label></td>
																						<td class="labelTd"><label class="no"
																							id="refundableRequiredNo"> <input
																								type="radio" name="refundable" value="2"
																								checked="checked" id="refundableRequired_N"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
																						</label></td>
																					</tr>
																				</table>
																				<script language="javascript">
																				 var refundableAgainst = '<%=strRefundableAgainst%>';
																				 if(refundableAgainst == '1') {
																					 $("label#refundableRequiredNo").removeClass("active");
																					 $("label#refundableRequiredYes").addClass("active");																					 
																					 $("input#refundableRequired_N").attr('checked', false);
																					 $("input#refundableRequired_Y").attr('checked', true);
																				 } else {
																					 $("label#refundableRequiredYes").removeClass("active");
																					 $("label#refundableRequiredNo").addClass("active");
																					 $("input#refundableRequired_Y").attr('checked', false);
																					 $("input#refundableRequired_N").attr('checked', true);
																				 }
														                        </script>
																			</td>
																		</tr>
																	</table>
																</td>
																<td class="flightChkBaggagecInput"><select
																	name="baggageFlt" id="baggageFlt" class="comboBoxCss">
																		<option value="-1" selected="selected"><%=dbLabelBean.getLabel("label.createrequest.selectcheckedbaggage",strsesLanguage)%></option>
																		<option value="0">0</option>
																		<option value="1">1</option>
																		<option value="2">2</option>
																		<option value="3">3</option>
																</select>
																<%if(!strCheckedBaggage.equals("")){%>
																	<script language="javascript">
																	 document.getElementById("baggageFlt").value="<%=strCheckedBaggage%>";
											                        </script>
										                        <%} %>
																</td>
															</tr>
														</table>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<!-- Flight Detail Section End *********************************-->
									
									<!-- Train Detail Section Start ********************************-->
									<tr>
										<td class="hrSpace6Px"></td>
									</tr>
									<tr>
										<td style="border-bottom: 1px solid grey;"></td>
									</tr>
									<tr>
										<td class="hrSpace6Px"></td>
									</tr>
									<!-- Train Details Start -->
									<tr>
										<td class="journyType">
											<table class="journyDetailTrnMainTbl">
												<tr>
													<td class="journyDetailLabel"><label
														class="requiredInput"><b><%=dbLabelBean.getLabel("label.global.traindetails",strsesLanguage) %></b></label></td>
													<td class="journyDetailRadio">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="0" class="checkbox">
															<tr>
																<td class="labelTd"><label class="yes"
																	id="trnRequiredYes"> <input type="radio"
																		name="train" value="1" id="trnRequired_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
																</label></td>
																<td class="labelTd"><label class="no"
																	id="trnRequiredNo"> <input type="radio"
																		name="train" value="2" checked="checked"
																		id="trnRequired_N"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
																</label></td>
															</tr>
														</table>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr id="trainDetailDiv" class="hide">
										<td>
											<table class="journyDetailTrnInnerTbl" id="tblItineraryTrnMain">
												<tr>
													<td class="journyInner"><label class="requiredInput"><b><%=dbLabelBean.getLabel("label.global.outwardleg",strsesLanguage)%></b></label></td>
												</tr>
												<tr class="trainDataRow">
													<td class="journyInner">
														<table class="journyDetailTrnInner1Tbl" id="tblItineraryTrnOutLeg">
															<tbody>
															<%
																if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																	if(strTravelType.equals("D")) {
																		strSql =" SELECT 'Forword' as JOURNEY,TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(ISNULL(TJDD.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																				" ISNULL(TRAVEL_CLASS,'1') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE "+
																				" FROM T_TRAVEL_DETAIL_DOM (nolock) AS TTDD INNER JOIN T_JOURNEY_DETAILS_DOM (nolock) AS TJDD ON TTDD.TRAVEL_ID = TJDD.TRAVEL_ID "+
																				" WHERE TTDD.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2 AND JOURNEY_ORDER =(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2 AND STATUS_ID=10)";
																	} else if(strTravelType.equals("I")) {
																		strSql =" SELECT 'Forword' as JOURNEY,TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(ISNULL(TJDI.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																				" ISNULL(TRAVEL_CLASS,'1') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE "+
																				" FROM T_TRAVEL_DETAIL_INT (nolock) AS TTDI INNER JOIN T_JOURNEY_DETAILS_INT (nolock) AS TJDI ON TTDI.TRAVEL_ID = TJDI.TRAVEL_ID  "+
																				" WHERE TTDI.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2 AND JOURNEY_ORDER =(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2 AND STATUS_ID=10)";
																	}													
																	rs4=null;
																	rs4  =   dbConBean.executeQuery(strSql);  
																	if(rs4.next()) {
																	trainYNFlag 				= "true";
																	strDepCityFwdTrn           	= rs4.getString("TRAVEL_FROM"); 
																	strArrCityFwdTrn           	= rs4.getString("TRAVEL_TO");
																	strDepDateFwdTrn 		  	= rs4.getString("TRAVEL_DATE");
																	strPreferTimeModeFwdTrn	  	= rs4.getString("PREF_TIME_TYPE");
																	strPreferTimeFwdTrn        	= rs4.getString("PREFERRED_TIME");
																	strTravelClassFwdTrn       	= rs4.getString("TRAVEL_CLASS");
																	strPreferSeatFwdTrn      	= rs4.getString("SEAT_PREFFERED");															
																
																	}
																	rs4.close();
																} 
															%>	
															<tr class="">
																	<td class="city"><input type="text" name="depCityTrn"
																		class="textBoxCss" value="<%=strDepCityFwdTrn %>" id="depCityTrnTBFwd"
																		placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"
																		onKeyUp="return test2(this, 100, 'cn')" maxlength="100"
																		title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																	<td class="city"><input type="text" name="arrCityTrn"
																		class="textBoxCss" value="<%=strArrCityFwdTrn %>" id="arrCityTrnTBFwd"
																		placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"
																		onKeyUp="return test2(this, 100, 'cn')" maxlength="100"
																		title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																	<td class="date"><input type="text" name="depDateTrn"
																		class="textBoxCss validDateTrn validDate" value="<%=strDepDateFwdTrn %>" id="depDateTrnTBFwd"
																		onFocus="initializeJourneyDateTrn(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');"
																		placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																	<td class="timeMode"><select name="preferTimeModeTrn"
																		class="comboBoxCss" id="preferTimeModeTrnSBFwd"
																		title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																			<%
																			types =   TravelRequestEnums.PreferredTimeTypes.values();
																			for(i=0; i<types.length; i++){
																				
																				if(!strPreferTimeModeFwdTrn.equals("") && types[i].getId().equals(strPreferTimeModeFwdTrn)) {
																			%>
														                              	<option value="<%=types[i].getId()%>" selected="selected"><%=types[i].getName()%></option>
																			<%
												                            	 } else {
												                            		 if((strPreferTimeModeFwdTrn == null || strPreferTimeModeFwdTrn.equals("")) && types[i].getId().equals("2")) {
												                            %>
														                              	<option value="<%=types[i].getId()%>" selected="selected"><%=types[i].getName()%></option>
																			<%
												                            		 } else {
												                            %>
												                            			<option value="<%=types[i].getId()%>"><%=types[i].getName()%></option>
												                            <%	 
												                            		 }
												                            	 }
																			}
																			%>
																	</select>
																	</td>
																	<td class="time"><select name="preferTimeTrn"
																		class="comboBoxCss" id="preferTimeTrnSBFwd"
																		title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																		<option value="-1" selected="selected"><%=dbLabelBean.getLabel("label.createrequest.selectTime", strsesLanguage) %></option>
																			<%						                           
																					entrySet = preferredTimeList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 if(!nonSpecificTimeList.contains(entry.getKey())){
														                            	 if(!strPreferTimeFwdTrn.equals("") && entry.getKey().equals(strPreferTimeFwdTrn)) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                            	 }
														                         	 }
																					%>			
																	</select>
																	</td>
																	<td class="trClass2"><select name="departClassTrn"
																		class="comboBoxCss comboDepartClassTrn"
																		id="departClassTrnSBFwd" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																			<%						                           
																					entrySet = trainClassList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 
														                            	 if(!strTravelClassFwdTrn.equals("") && entry.getKey().equals(strTravelClassFwdTrn)) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }else if((strTravelClassFwdTrn == null || strTravelClassFwdTrn.equals("")) && entry.getKey().equals("23")){
														                            		 %>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                         	 }
																					%>
																	</select>
																	</td>
																	<td class="seatTrn1"><select name="seatPreffredTrnType1"
																		class="comboBoxCss comboPrefSeat" id="seatPreffredTrnType1SBFwd"
																		title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																			<%					
																					TravelRequestEnums.TrainSeatPreferredTypes strPrefSeatFwdTrnVal = TravelRequestEnums.TrainSeatPreferredTypes.fromId(strPreferSeatFwdTrn);
																					String[] strPrefSeatFwdTrnArr = strPrefSeatFwdTrnVal != null ? strPrefSeatFwdTrnVal.getName().split("-"): null;
																					entrySet = trainWindowType_1_List.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 
														                            	 if(strPrefSeatFwdTrnArr != null && entry.getKey().equals(strPrefSeatFwdTrnArr[0])) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }else if(strPrefSeatFwdTrnArr == null && entry.getKey().equals("Aisle")){
														                            		 %>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                         	 }
																					%>
																	</select>
																	</td>	
																	<td class="seatTrn2"><select name="seatPreffredTrnType2"
																		class="comboBoxCss comboPrefSeat" id="seatPreffredTrnType2SBFwd"
																		title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																			<%						                           
																					entrySet = trainWindowType_2_List.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 
														                            	 if(strPrefSeatFwdTrnArr != null && entry.getKey().equals(strPrefSeatFwdTrnArr[1])) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                         	 }
																					%>
																	</select>
																	</td>
																	<td class="seatTrn3"><select name="seatPreffredTrnType3"
																		class="comboBoxCss comboPrefSeat" id="seatPreffredTrnType3SBFwd"
																		title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																			<%						                           
																					entrySet = trainWindowType_3_List.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 
														                            	 if(strPrefSeatFwdTrnArr != null && entry.getKey().equals(strPrefSeatFwdTrnArr[2])) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }else if(strPrefSeatFwdTrnArr == null && entry.getKey().equals("Without Table")){
														                            		 %>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }  else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                         	 }
																					%>
																	</select>
																	</td>																
																	<td class="del"></td>
																</tr>
															</tbody>
														</table>
													</td>
												</tr>
												<tr id="intermediateLabelTrn" class="hide">
													<td class="journyInner"><label class="requiredInput"><b><%=dbLabelBean.getLabel("label.global.intermediateleg",strsesLanguage)%></b></label></td>
												</tr>
												<tr class="trainDataRow">
													<td class="journyInner">
														<table class="journyDetailTrnInner1Tbl" id="tblItineraryTrnInter">
															<tbody>
																<%
																int j = 0;
																String showLabelTrn = "false";
																if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																	if(strTravelType.equals("D")) {
																		strSql =" SELECT 'Intermediate' as JOURNEY,TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(ISNULL(TJDD.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																				" ISNULL(TRAVEL_CLASS,'1') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE "+
																				" FROM T_TRAVEL_DETAIL_DOM (nolock) AS TTDD INNER JOIN T_JOURNEY_DETAILS_DOM (nolock) AS TJDD ON TTDD.TRAVEL_ID = TJDD.TRAVEL_ID  "+
																				" WHERE TTDD.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2 AND JOURNEY_ORDER >(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2 AND STATUS_ID=10)";
																	} else if(strTravelType.equals("I")) {
																		strSql =" SELECT 'Intermediate' as JOURNEY,TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(ISNULL(TJDI.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																				" ISNULL(TRAVEL_CLASS,'1') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE "+
																				" FROM T_TRAVEL_DETAIL_INT (nolock) AS TTDI INNER JOIN T_JOURNEY_DETAILS_INT (nolock) AS TJDI ON TTDI.TRAVEL_ID = TJDI.TRAVEL_ID  "+
																				" WHERE TTDI.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2 AND JOURNEY_ORDER >(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2 AND STATUS_ID=10)";
																	}		
																	
																	rs5 = null;
																	rs5  =   dbConBean.executeQuery(strSql);  
																while(rs5.next()) {
																	trainYNFlag 					= "true";
																	showLabelTrn 					= "true";
																	strDepCityIntrmiTrn           	= rs5.getString("TRAVEL_FROM"); 
																	strArrCityIntrmiTrn           	= rs5.getString("TRAVEL_TO");
																	strDepDateIntrmiTrn           	= rs5.getString("TRAVEL_DATE");
																	strPreferTimeModeIntrmiTrn	  	= rs5.getString("PREF_TIME_TYPE");
																	strPreferTimeIntrmiTrn        	= rs5.getString("PREFERRED_TIME");
																	strTravelClassIntrmiTrn       	= rs5.getString("TRAVEL_CLASS");
																	strPreferSeatIntrmiTrn      	= rs5.getString("SEAT_PREFFERED");															
																
																		if(!strDepCityIntrmiTrn.trim().equals("") || !strArrCityIntrmiTrn.trim().equals("")) {	
																		%>
																		<tr class="itineraryDataRowTrn">
																			<td class="city"><input type="text"
																				name="depCityTrn" class="textBoxCss" value="<%=strDepCityIntrmiTrn %>"
																				id="depCityTrnTBIntrim" placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"
																				onKeyUp="return test2(this, 100, 'cn')" maxlength="100"
																				title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																			<td class="city"><input type="text"
																				name="arrCityTrn" class="textBoxCss" value="<%=strArrCityIntrmiTrn %>"
																				id="arrCityTrnTBIntrim" placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"
																				onKeyUp="return test2(this, 100, 'cn')" maxlength="100"
																				title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																			<td class="date"><input type="text"
																				name="depDateTrn" class="textBoxCss validDateTrn validDate" value="<%=strDepDateIntrmiTrn %>"
																				id="depDateTrnTBIntrim" onFocus="initializeJourneyDateTrn(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');"
																				placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																			<td class="timeMode"><select name="preferTimeModeTrn"
																				class="comboBoxCss" id="preferTimeModeTrnSBIntrim"
																				title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																					<%
																					types =   TravelRequestEnums.PreferredTimeTypes.values();
																					for(i=0; i<types.length; i++){
																						
																						if(!strPreferTimeModeIntrmiTrn.equals("") && types[i].getId().equals(strPreferTimeModeIntrmiTrn)) {
																							%>
																                              	<option value="<%=types[i].getId()%>" selected="selected"><%=types[i].getName()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=types[i].getId()%>"><%=types[i].getName()%></option>
																							<%
														                            	 }
																					} 
																					%>
																			</select>
																			</td>
																			<td class="time"><select name="preferTimeTrn"
																				class="comboBoxCss" id="preferTimeTrnSBIntrim"
																				title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																				<option value="-1" selected="selected"><%=dbLabelBean.getLabel("label.createrequest.selectTime", strsesLanguage) %></option>
																					<%						                           
																					entrySet = preferredTimeList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 if(!nonSpecificTimeList.contains(entry.getKey())){
														                            	 if(!strPreferTimeIntrmiTrn.equals("") && entry.getKey().equals(strPreferTimeIntrmiTrn)) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                            	 }
														                         	 }
																					%>
																			</select>
																			</td>
																			<td class="trClass2"><select name="departClassTrn"
																				class="comboBoxCss comboDepartClassTrn"
																				id="departClassTrnSBIntrim" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																					<%						                           
																					entrySet = trainClassList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 
														                            	 if(!strTravelClassIntrmiTrn.equals("") && entry.getKey().equals(strTravelClassIntrmiTrn)) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }else if((strTravelClassIntrmiTrn == null || strTravelClassIntrmiTrn.equals("")) && entry.getKey().equals("23")){
														                            		 %>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                         	 }
																					%>
																			</select>
																			</td>
																			<td class="seatTrn1"><select name="seatPreffredTrnType1"
																				class="comboBoxCss comboPrefSeat" id="seatPreffredTrnType1SBIntrim"
																				title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																					<%	
																					TravelRequestEnums.TrainSeatPreferredTypes strPrefSeatIntrmTrnVal = TravelRequestEnums.TrainSeatPreferredTypes.fromId(strPreferSeatIntrmiTrn);
																					String[] strPrefSeatIntrTrnArr = strPrefSeatIntrmTrnVal != null ? strPrefSeatIntrmTrnVal.getName().split("-"): null;
																					entrySet = trainWindowType_1_List.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 
														                            	 if(strPrefSeatIntrTrnArr != null && entry.getKey().equals(strPrefSeatIntrTrnArr[0])) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }else if(strPrefSeatIntrTrnArr == null && entry.getKey().equals("Aisle")){
														                            		 %>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }  else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                         	 }
																					%>
																			</select>
																			</td>	
																			<td class="seatTrn2"><select name="seatPreffredTrnType2"
																				class="comboBoxCss comboPrefSeat" id="seatPreffredTrnType2SBIntrim"
																				title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																					<%						                           
																					entrySet = trainWindowType_2_List.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 
														                            	 if(strPrefSeatIntrTrnArr != null && entry.getKey().equals(strPrefSeatIntrTrnArr[1])) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                         	 }
																					%>
																			</select>
																			</td>
																			<td class="seatTrn3"><select name="seatPreffredTrnType3"
																				class="comboBoxCss comboPrefSeat" id="seatPreffredTrnType3SBIntrim"
																				title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																					<%						                           
																					entrySet = trainWindowType_3_List.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 
														                            	 if(strPrefSeatIntrTrnArr != null && entry.getKey().equals(strPrefSeatIntrTrnArr[2])) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }else if(strPrefSeatIntrTrnArr == null && entry.getKey().equals("Without Table")){
														                            		 %>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }  else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                         	 }
																					%>
																			</select>
																			</td>																		
																			<td class="del"><img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0" 
																			id="bt-Del-ItInr_Trn" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"></td>
																		</tr>
																	<%
																		}
																		 j++;
																	}
																%>
																<script language="javascript">
																  var showLabelTrnFlag = '<%=showLabelTrn%>';
																  if(showLabelTrnFlag === "true") {
																	  $("tr#intermediateLabelTrn").removeClass("hide");
																	  $("tr#intermediateLabelTrn").addClass("show");
																  } else {
																	  $("tr#intermediateLabelTrn").removeClass("show");
																	  $("tr#intermediateLabelTrn").addClass("hide");
																  }
										                        </script>
																<%
																rs5.close();
																}
																
															%>
																<tr class="innerRowItineraryTrn"></tr>
																<tr class="prototypeRowItineraryTrn">
																	<td class="city"><input type="text"
																		name="depCityTrnPT" class="textBoxCss" value=""
																		id="depCityTrnTBIntrim" placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"
																		onKeyUp="return test2(this, 100, 'cn')" maxlength="100"
																		title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																	<td class="city"><input type="text"
																		name="arrCityTrnPT" class="textBoxCss" value=""
																		id="arrCityTrnTBIntrim" placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"
																		onKeyUp="return test2(this, 100, 'cn')" maxlength="100"
																		title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																	<td class="date"><input type="text"
																		name="depDateTrnPT" class="textBoxCss validDateTrn validDate" value=""
																		id="depDateTrnTBIntrim" onFocus="initializeJourneyDateTrn(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');"
																		placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																	<td class="timeMode"><select name="preferTimeModeTrnPT"
																		class="comboBoxCss" id="preferTimeModeTrnSBIntrim"
																		title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																		<%
																			types =   TravelRequestEnums.PreferredTimeTypes.values();
																			for(i=0; i<types.length; i++){
																				
																				if(types[i].getId().equals("1")) {
												                            %>
														                            <option value="<%=types[i].getId()%>" selected="selected"><%=types[i].getName()%></option>
																			<%
												                            	} else {
												                            %>
												                            		<option value="<%=types[i].getId()%>"><%=types[i].getName()%></option>
												                            <%	 
												                            	}
																			} %>
																	</select></td>
																	<td class="time"><select name="preferTimeTrnPT"
																		class="comboBoxCss" id="preferTimeTrnSBIntrim"
																		title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																		<option value="-1" selected="selected"><%=dbLabelBean.getLabel("label.createrequest.selectTime", strsesLanguage) %></option>
																			<%						                           
																					entrySet = preferredTimeList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 if(!nonSpecificTimeList.contains(entry.getKey())){
																					%>
														                              <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																					<%
														                         	 }
														                             }
																					%>
																	</select></td>
																	<td class="trClass2"><select name="departClassTrnPT"
																		class="comboBoxCss comboDepartClassTrn"
																		id="departClassTrnSBIntrim" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																			<%						                           
																					entrySet = trainClassList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                              if(entry.getKey().equals("23")){
													                            		 %>
															                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																						<%
													                            	 }else{
																					%>
														                              <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																					<%
														                         	 }}
																					%>
																	</select></td>
																	<td class="seatTrn1"><select name="seatPreffredTrnType1PT"
																		class="comboBoxCss comboPrefSeat" id="seatPreffredTrnType1SBIntrim"
																		title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																			<%			
																					entrySet = trainWindowType_1_List.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                              if(entry.getKey().equals("Aisle")){
													                            		 %>
															                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																						<%
													                            	 } else{
																					%>
														                              <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																					<%
														                         	 }}
																					%>
																	</select></td>		
																	<td class="seatTrn2"><select name="seatPreffredTrnType2PT"
																		class="comboBoxCss comboPrefSeat" id="seatPreffredTrnType2SBIntrim"
																		title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																			<%						                           
																					entrySet = trainWindowType_2_List.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
																					%>
														                              <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																					<%
														                         	 }
																					%>
																	</select></td>		
																	<td class="seatTrn3"><select name="seatPreffredTrnType3PT"
																		class="comboBoxCss comboPrefSeat" id="seatPreffredTrnType3SBIntrim"
																		title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																			<%						                           
																					entrySet = trainWindowType_3_List.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                             if(entry.getKey().equals("Without Table")){
													                            		 %>
															                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																						<%
													                            	 } else{
																					%>
														                              <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																					<%
														                         	 }}
																					%>
																	</select></td>																	
																	<td class="del"><img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0" 
																			id="bt-Del-ItInr_Trn" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"></td>
																</tr>
															</tbody>
														</table>
													</td>
												</tr>
												<tr>
													<td class="journyInner"><label class="requiredInput"><b><%=dbLabelBean.getLabel("label.global.returnleg",strsesLanguage)%></b></label></td>
												</tr>
												<tr class="trainDataRow">
													<td class="journyInner">
														<table class="journyDetailTrnInner1Tbl" id="tblItineraryTrnReturnLeg">
															<tbody>
																<%
																if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																	if(strTravelType.equals("D")) {
																		  strSql = " SELECT 'Return' as Journey, RETURN_FROM, RETURN_TO, DBO.CONVERTDATEDMY1(ISNULL(TJRDD.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																				   " ISNULL(TRAVEL_CLASS,'1') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE "+
																				   " FROM T_TRAVEL_DETAIL_DOM (nolock) AS TTDD INNER JOIN T_RET_JOURNEY_DETAILS_DOM (nolock) AS TJRDD ON TTDD.TRAVEL_ID = TJRDD.TRAVEL_ID WHERE TTDD.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2";
																	  } else if(strTravelType.equals("I")) {
																		  strSql = " SELECT 'Return' as Journey, RETURN_FROM, RETURN_TO, DBO.CONVERTDATEDMY1(ISNULL(TJRDI.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																				   " ISNULL(TRAVEL_CLASS,'1') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE "+
																				   " FROM T_TRAVEL_DETAIL_INT (nolock) AS TTDI INNER JOIN T_RET_JOURNEY_DETAILS_INT (nolock) AS TJRDI ON TTDI.TRAVEL_ID = TJRDI.TRAVEL_ID WHERE TTDI.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2";
																	  }											
																	rs6=null;
																	rs6  =   dbConBean.executeQuery(strSql);  
																	if(rs6.next()) {
																	trainYNFlag 			   	= "true";
																	strDepCityRetTrn           	= rs6.getString("RETURN_FROM"); 
																	strArrCityRetTrn           	= rs6.getString("RETURN_TO");
																	strDepDateRetTrn           	= rs6.getString("TRAVEL_DATE");	
																	strPreferTimeModeRetTrn	  	= rs6.getString("PREF_TIME_TYPE");
																	strPreferTimeRetTrn        	= rs6.getString("PREFERRED_TIME");
																	strTravelClassRetTrn       	= rs6.getString("TRAVEL_CLASS");
																	strPreferSeatRetTrn      	= rs6.getString("SEAT_PREFFERED");															
																
																	}
																	rs6.close();
																} 
															%>	
															<tr class="">
																	<td class="city"><input type="text" name="depCityTrn"
																		class="textBoxCss" value="<%=strDepCityRetTrn %>" id="depCityTrnTBRet"
																		placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"
																		onKeyUp="return test2(this, 100, 'cn')" maxlength="100"
																		title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																	<td class="city"><input type="text" name="arrCityTrn"
																		class="textBoxCss" value="<%=strArrCityRetTrn %>" id="arrCityTrnTBRet"
																		placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"
																		onKeyUp="return test2(this, 100, 'cn')" maxlength="100"
																		title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																	<td class="date"><input type="text" name="depDateTrn"
																		class="textBoxCss validDateTrn validDate" value="<%=strDepDateRetTrn %>" id="depDateTrnTBRet"
																		onFocus="initializeJourneyDateTrn(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');"
																		placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																	<td class="timeMode"><select name="preferTimeModeTrn"
																		class="comboBoxCss" id="preferTimeModeTrnSBRet"
																		title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																			<%
																			types =   TravelRequestEnums.PreferredTimeTypes.values();
																			for(i=0; i<types.length; i++){
																				
																				if(!strPreferTimeModeRetTrn.equals("") && types[i].getId().equals(strPreferTimeModeRetTrn)) {
																			%>
														                              <option value="<%=types[i].getId()%>" selected="selected"><%=types[i].getName()%></option>
																			<%
												                            	 } else {
												                            		 if((strPreferTimeModeRetTrn == null || strPreferTimeModeRetTrn.equals("")) && types[i].getId().equals("1")) {
												                            %>
														                              	<option value="<%=types[i].getId()%>" selected="selected"><%=types[i].getName()%></option>
																			<%
												                            		 } else {
												                            %>
												                            			<option value="<%=types[i].getId()%>"><%=types[i].getName()%></option>
												                            <%	 
												                            		 }
												                            	 }
																			}
																			%>
																	</select>
																	</td>
																	<td class="time"><select name="preferTimeTrn"
																		class="comboBoxCss" id="preferTimeTrnSBRet"
																		title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																		<option value="-1" selected="selected"><%=dbLabelBean.getLabel("label.createrequest.selectTime", strsesLanguage) %></option>
																			<%						                           
																					entrySet = preferredTimeList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 if(!nonSpecificTimeList.contains(entry.getKey())){
														                            	 if(!strPreferTimeRetTrn.equals("") && entry.getKey().equals(strPreferTimeRetTrn)) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                            	 }
														                         	 }
																					%>	
																	</select>
																	</td>
																	<td class="trClass2"><select name="departClassTrn"
																		class="comboBoxCss comboDepartClassTrn"
																		id="departClassTrnSBRet" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																			<%						                           
																					entrySet = trainClassList.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 
														                            	 if(!strTravelClassRetTrn.equals("") && entry.getKey().equals(strTravelClassRetTrn)) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }else if((strTravelClassRetTrn == null || strTravelClassRetTrn.equals("")) && entry.getKey().equals("23")){
														                            		 %>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                         	 }
																					%>
																	</select>
																	</td>
																	<td class="seatTrn1"><select name="seatPreffredTrnType1"
																		class="comboBoxCss comboPrefSeat" id="seatPreffredTrnType1SBRet"
																		title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																			<%																				
																					TravelRequestEnums.TrainSeatPreferredTypes strPrefSeatRtnTrnVal = TravelRequestEnums.TrainSeatPreferredTypes.fromId(strPreferSeatRetTrn);
																					String[] strPrefSeatRtnTrn = strPrefSeatRtnTrnVal != null ? strPrefSeatRtnTrnVal.getName().split("-"): null;
																					entrySet = trainWindowType_1_List.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 
														                            	 if(strPrefSeatRtnTrn != null && entry.getKey().equals(strPrefSeatRtnTrn[0])) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }else if(strPrefSeatRtnTrn == null && entry.getKey().equals("Aisle")){
														                            		 %>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }  else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                         	 }
																					%>
																	</select>
																	</td>		
																	<td class="seatTrn2"><select name="seatPreffredTrnType2"
																		class="comboBoxCss comboPrefSeat" id="seatPreffredTrnType2SBRet"
																		title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																			<%						                           
																					entrySet = trainWindowType_2_List.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 
														                            	 if(strPrefSeatRtnTrn != null && entry.getKey().equals(strPrefSeatRtnTrn[1])) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 } else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                         	 }
																					%>
																	</select>
																	</td>	
																	<td class="seatTrn3"><select name="seatPreffredTrnType3"
																		class="comboBoxCss comboPrefSeat" id="seatPreffredTrnType3SBRet"
																		title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																			<%						                           
																					entrySet = trainWindowType_3_List.entrySet();
																					it = entrySet.iterator();
														                             while(it.hasNext())
														                             {
														                            	 Map.Entry entry = (Map.Entry)it.next();
														                            	 
														                            	 if(strPrefSeatRtnTrn != null && entry.getKey().equals(strPrefSeatRtnTrn[2])) {
																							%>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }else if(strPrefSeatRtnTrn == null && entry.getKey().equals("Without Table")){
														                            		 %>
																                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																							<%
														                            	 }else {
														                            		 %>
																                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																							<%
														                            	 }
														                         	 }
																					%>
																	</select>
																	</td>																
																	<td class="del"></td>
																</tr>
															</tbody>
														</table>
													</td>
												</tr>
												<script language="javascript">
												 var trainDetailFlag = '<%=trainYNFlag%>';
												 
												 if(siteIdGlobal != null && siteIdGlobal != ""){
													 if(trainDetailFlag === "true") {
														$("label#trnRequiredNo").removeClass("active");
														$("label#trnRequiredYes").addClass("active");													
														$("input:radio#trnRequired_N").attr('checked', false);
														$("input:radio#trnRequired_Y").attr('checked', true);
														$("tr#trainDetailDiv").removeClass("hide");
														$("tr#trainDetailDiv").addClass("show");
													 } else {
														 $("label#trnRequiredYes").removeClass("active");
														 $("label#trnRequiredNo").addClass("active");
														 $("input:radio#trnRequired_Y").attr('checked', false);
														 $("input:radio#trnRequired_N").attr('checked', true);
														 $("tr#trainDetailDiv").removeClass("show");
														 $("tr#trainDetailDiv").addClass("hide");													
													 }
												 } else {
														// Added by Gurmeet Singh on 31-07-2015 to disable Train Details Radio Buttons [Start]
														$("label#trnRequiredYes").addClass("disable");
														$("label#trnRequiredNo").addClass("disable");
														$("input:radio#trnRequired_Y").attr('checked', false);
														$("input:radio#trnRequired_N").attr('checked', true);
														$("input:radio#trnRequired_Y").prop('disabled', true);
														$("input:radio#trnRequired_N").prop('disabled', true);
														$("tr#trainDetailDiv").removeClass("show");
														$("tr#trainDetailDiv").addClass("hide");
														// Added by Gurmeet Singh on 31-07-2015 to disable Train Details Radio Buttons [End] 
												 }
													
						                        </script>
												<tr valign="top">
													<td>
														<table class="journyDetailTrnInner2Tbl">
															<tr>
																<td class="itenaryRemark"><textarea
																		name="remarksTrn" id="remarksTrn" class="textAreaCss4"
																		rows="" cols="" onKeyUp="return test2(this, 1000, 'cn')" maxlength="1000" placeholder="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>"><%=strRemarkTrn %></textarea></td>
																<td class="journyInner" style="vertical-align: middle;"><input type="button"
																	value="<%=dbLabelBean.getLabel("label.global.addintermediateleg",strsesLanguage)%>" class="bt-Add-Dom"
																	id="bt_Add_Trn" title="<%=dbLabelBean.getLabel("label.global.addintermediateleg",strsesLanguage)%>" /></td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td class="journyInner"><label class="requiredInput"><b><%=dbLabelBean.getLabel("label.global.fares",strsesLanguage)%></b></label>
													</td>
												</tr>
												<tr>
													<td class="journyType">
														<table class="journyDetailTrnInner3Tbl">
															<tr>
																<td class="requiredInputBox1"><label
																	class="requiredInput"><b><%=dbLabelBean.getLabel("label.global.bahncard",strsesLanguage)%></b></label></td>
																<td class="requiredRadioBoxleft">
																	<table width="100%" border="0" cellspacing="0"
																		cellpadding="0" class="checkbox">
																		<tr>
																			<td class="labelTd"><label class="yes"
																				id="bhnRequiredYes"> <input type="radio"
																					name="bahncrd" value="1" id="bhnRequired_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
																			</label></td>
																			<td class="labelTd"><label class="no"
																				id="bhnRequiredNo"> <input type="radio"
																					name="bahncrd" value="2" checked="checked"
																					id="bhnRequired_N"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
																			</label></td>
																		</tr>
																	</table>																	
																</td>
															</tr>
														</table>
													</td>
												</tr>
												<tr id="bahnCardDetailDiv" class="hide">
													<td class="journyInner">
														<table class="journyDetailTrnInner4Tbl">
															<tr>
																<td class="bahnCardNoLabel"><%=dbLabelBean.getLabel("label.global.bahncardno",strsesLanguage)%></td>																
																<td class="bahnCardDiscLabel"><%=dbLabelBean.getLabel("label.global.discount",strsesLanguage)%></td>
																<td class="bahnCardClassLabel"><%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%></td>
																<td class="bahnCardValidityLabel"><%=dbLabelBean.getLabel("label.global.bahncardvaliditydate",strsesLanguage)%></td>
																<td class="bahnCardOnlineLabel"><%=dbLabelBean.getLabel("label.global.onlineticket",strsesLanguage)%></td>
															</tr>
															<tr>
																<td class="bahnCardNoInput"><input type="text"
																	name="bahnNo" class="textBoxCss" value="<%=strBahncardNo %>" id="bahnNo"
																	onKeyUp="return test2(this, 20, 'n')" maxlength="20"></td>																
																<td class="bahnCardDiscInput"><select
																	name="bahnCardDisc" id="bahnCardDisc"
																	class="comboBoxCss">
																		<option value="-1" selected="selected"><%=dbLabelBean.getLabel("label.createrequest.selectdiscount",strsesLanguage)%></option>
																		<option value="0">Bonus</option>
																		<option value="25">25</option>
																		<option value="50">50</option>
																		<option value="100">100</option>
																</select>
																<%if(!strBahncardDiscnt.equals("")){%>
																	<script language="javascript">
																	 document.getElementById("bahnCardDisc").value="<%=strBahncardDiscnt%>";
											                        </script>
										                        <%} %>
																</td>
																<td class="bahnCardClassInput"><select
																	name="bahnCardClass" id="bahnCardClass"
																	class="comboBoxCss">
																		<option value="1">1</option>
																		<option value="2" selected="selected">2</option>
																</select>
																<%if(!strBahncardClass.equals("")){%>
																	<script language="javascript">
																	 document.getElementById("bahnCardClass").value="<%=strBahncardClass%>";
											                        </script>
										                        <%} %>
																</td>
																<td class="bahnCardValidityInput"><input type="text" name="bahnCardValidDate"
																		class="textBoxCss" value="<%=strBahncardValidityDate %>" id="bahnCardValidDate"
																		onFocus="initializeBahnCardValidityDate(this);"></td>
																<td class="bahnCardOnlineInput">
																	<table width="50%" border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td style="width: 80px;">
																				<table width="100%" border="0" cellspacing="0"
																					cellpadding="0" class="checkbox">
																					<tr>
																						<td class="labelTd"><label class="yes"
																							id="bhnTktRequiredYes"> <input
																								type="radio" name="bahnOnlineTkt" value="1"
																								checked="checked" id="bhnTktRequired_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
																						</label></td>
																						<td class="labelTd"><label class="no"
																							id="bhnTktRequiredNo"> <input
																								type="radio" name="bahnOnlineTkt" value="2"
																								id="bhnTktRequired_N"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
																						</label></td>
																					</tr>
																				</table>
																				<script language="javascript">
																				 var bahncardOnlineTkt = '<%=strBahncardOnlineTkt%>';
																				 if(bahncardOnlineTkt == '1') {
																					 $("label#bhnTktRequiredNo").removeClass("active");
																					 $("label#bhnTktRequiredYes").addClass("active");																					 
																					 $("input#bhnTktRequired_N").attr('checked', false);
																					 $("input#bhnTktRequired_Y").attr('checked', true);
																				 } else {
																					 $("label#bhnTktRequiredYes").removeClass("active");
																					 $("label#bhnTktRequiredNo").addClass("active");
																					 $("input#bhnTktRequired_Y").attr('checked', false);
																					 $("input#bhnTktRequired_N").attr('checked', true);
																				 }
														                        </script>
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
														</table>
														<script language="javascript">
															 var bahncardNo = '<%=strBahncardNo%>';																		 
															 if(bahncardNo != null && bahncardNo != "") {	
																 $("label#bhnRequiredNo").removeClass("active");
																 $("label#bhnRequiredYes").addClass("active");																		 
																 $("input#bhnRequired_N").attr('checked', false);
																 $("input#bhnRequired_Y").attr('checked', true);
																 $("tr#bahnCardDetailDiv").removeClass("hide");
																 $("tr#bahnCardDetailDiv").addClass("show");
															 } else {
																 $("label#bhnRequiredYes").removeClass("active");
																 $("label#bhnRequiredNo").addClass("active");
																 $("input#bhnRequired_Y").attr('checked', false);
																 $("input#bhnRequired_N").attr('checked', true);
																 $("tr#bahnCardDetailDiv").removeClass("show");
																 $("tr#bahnCardDetailDiv").addClass("hide");
															 }
									                        </script>
													</td>
												</tr>
												<tr>
													<td class="journyType">
														<table class="journyDetailTrnInner3Tbl">
															<tr>
																<td class="requiredInputBox1"><label
																	class="requiredInput"><b><%=dbLabelBean.getLabel("label.global.sparpreismitzugbindung",strsesLanguage)%></b></label></td>
																<td class="requiredRadioBoxleft">
																	<table width="100%" border="0" cellspacing="0"
																		cellpadding="0" class="checkbox">
																		<tr>
																			<td class="labelTd"><label class="yes"
																				id="sparzugRequiredYes"> <input type="radio"
																					name="sparzug" value="1" id="sparzugRequired_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
																			</label></td>
																			<td class="labelTd"><label class="no"
																				id="sparzugRequiredNo"> <input type="radio"
																					name="sparzug" value="2" 
																					id="sparzugRequired_N"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
																			</label></td>
																		</tr>
																	</table>
																	<script language="javascript">
																		 var specialTrain = '<%=strSpecialTrain%>';
																		 if(specialTrain == '1') {
																			 $("label#sparzugRequiredNo").removeClass("active");
																			 $("label#sparzugRequiredYes").addClass("active");																			 
																			 $("input#sparzugRequired_N").attr('checked', false);
																			 $("input#sparzugRequired_Y").attr('checked', true);
																		 } else if(specialTrain == '2') {
																			 $("label#sparzugRequiredYes").removeClass("active");
																			 $("label#sparzugRequiredNo").addClass("active");
																			 $("input#sparzugRequired_Y").attr('checked', false);
																			 $("input#sparzugRequired_N").attr('checked', true);
																		 } else {
																			 $("label#sparzugRequiredYes").removeClass("active");
																			 $("label#sparzugRequiredNo").removeClass("active");
																			 $("input#sparzugRequired_Y").attr('checked', false);
																			 $("input#sparzugRequired_N").attr('checked', false);
																		 }
												                        </script>
																</td>
															</tr>

														</table>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<!-- Train Detail Section END ****************************-->
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="hrSpace6Px"></td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid grey;"></td>
			</tr>
			<tr>
				<td class="hrSpace6Px"></td>
			</tr>
			<!-- Rent A Car Section Start ****************************-->		
			<tr>
				<td class="journyType">
					<table class="journyDetailRentCarMainTbl">
						<tr>
							<td class="journyDetailLabel"><label class="requiredInput"><b><%=dbLabelBean.getLabel("label.global.carreservation",strsesLanguage) %></b></label></td>
							<td class="journyDetailRadio">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="checkbox">
									<tr>
										<td class="labelTd"><label class="yes active"
											id="rentCarRequiredYes"> <input type="radio"
												name="rentCar" value="1" id="rentCarRequired_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
										</label></td>
										<td class="labelTd"><label class="no"
											id="rentCarRequiredNo"> <input type="radio"
												name="rentCar" value="2" checked="checked"
												id="rentCarRequired_N"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
										</label></td>
									</tr>
								</table>								
							</td>
						</tr>
					</table>
				</td>
			</tr>			
			<tr id="rentCarDetailDiv" class="hide">			
				<td>
					<table class="journyDetailRentCarInnerTbl">
						<tr id="carClassRow">
							<td class="journyInner">
								<table class="journyDetailRentCarInner3Tbl" style="width:11%!important; margin-bottom:0!important;">
									<tr>
										<td class="carClassInput">
											<select name="carClass" class="comboBoxCss" id="carClass" title="<%=dbLabelBean.getLabel("label.global.caroptions",strsesLanguage)%>" onchange="resetRentaCarData(this,this.value)">
												<%						                           
													entrySet = carClassList.entrySet();
													it = entrySet.iterator();
						                             while(it.hasNext()) {
						                            	 Map.Entry entry = (Map.Entry)it.next();						                            	 
			                            		%>
					                              		<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
												<%
						                         	 }
												%>
											</select>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tblRentCar">
									<tbody>
										<%  int countVal = 0;
											if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
												strSql =" SELECT TRAVEL_CAR_ID,TRAVEL_ID,TRAVEL_TYPE,ISNULL(START_CITY, '') AS START_CITY,START_LOCATION,ISNULL(END_CITY, '') AS END_CITY,END_LOCATION,DBO.CONVERTDATEDMY1(ISNULL(START_DATE,'')) AS START_DATE,START_TIME, "+
													 " DBO.CONVERTDATEDMY1(ISNULL(END_DATE,'')) AS END_DATE,END_TIME,GPS,CLASS,ISNULL(START_MOBILENO, '') AS START_MOBILENO,ISNULL(END_MOBILENO, '') AS END_MOBILENO, ISNULL(TRAVEL_CLASS, '') AS TRAVEL_CLASS, ISNULL(START_ROUTING, '') as START_ROUTING, ISNULL(END_ROUTING,'') AS END_ROUTING FROM T_TRAVEL_CAR_DETAIL WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_TYPE='"+strTravelType+"' AND STATUS_ID=10 ORDER BY TRAVEL_CAR_ID";
								
												rs8 = null;			
												rs8  =   dbConBean.executeQuery(strSql);  
												if(rs8.next()) {
													do {
													rentCarYNFlag		=  "true";
													strTravelCarId		=  rs8.getString("TRAVEL_CAR_ID");
													strStartDate        =  rs8.getString("START_DATE");
													strStartTime        =  rs8.getString("START_TIME");
													strStartCity        =  rs8.getString("START_CITY");
													strStartLocation   	=  rs8.getString("START_LOCATION");
													strEndDate        	=  rs8.getString("END_DATE");
													strEndTime        	=  rs8.getString("END_TIME");
													strEndCity          =  rs8.getString("END_CITY");
													strEndLocation      =  rs8.getString("END_LOCATION");
													strNeedGps   		=  rs8.getString("GPS");
													strCategory         =  rs8.getString("CLASS");
													strStartMobileNo	=  rs8.getString("START_MOBILENO");
													strEndMobileNo		=  rs8.getString("END_MOBILENO");
													strStartMobileNo	=  rs8.getString("START_MOBILENO");
													strEndMobileNo		=  rs8.getString("END_MOBILENO");
													strStartRouting 	=  rs8.getString("START_ROUTING");
													strEndRouting		=  rs8.getString("END_ROUTING");
													strCarClass 		=  rs8.getString("TRAVEL_CLASS");
													
																									
											%>
										<tr class="rentCarDataRow">
										 <input type="hidden" name="travelCarId" id="travelCarId" value="<%=strTravelCarId %>" />
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">																										
													<tr>
														<td class="journyInner2">
															<table class="journyDetailRentCarInner1Tbl">
																<tr>
																	<td>
																		<table class="journyDetailRentCarInner2Tbl" border="0">
																			<tr class="rentCarDataRowInner">
																				<td class="rentCarDateInput"><input type="text"
																					name="startDate" class="textBoxCss validDateRentCar" value="<%=strStartDate %>" onFocus="initializeRentCarDate(this, '<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%>');"
																					id="startDate" placeholder="<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%>"></td>
																				<td class="rentCarTimeInput"><select name="startTime"
																					class="comboBoxCss" id="startTime" title="<%=dbLabelBean.getLabel("label.global.time",strsesLanguage)%>">
																					<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>
																						<%						                           
																						entrySet = preferredTimeList.entrySet();
																						it = entrySet.iterator();
															                             while(it.hasNext())
															                             {
															                            	 Map.Entry entry = (Map.Entry)it.next();
															                            	 if(!excludeTrainTimeList.contains(entry.getKey())){
																                            	 if(!strStartTime.equals("") && entry.getKey().equals(strStartTime)) {
																									%>
																		                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																									<%
																                            	 } else {
																                            		 %>
																		                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																									<%
																                            	 }
															                            	 }
															                         	 }
																						%>	
																				</select>													
																				</td>
																				<td class="rentCarCityInput"><input type="text" 
																					name="startCity" class="textBoxCss" value="<%=strStartCity %>"
																					id="startCity" onKeyUp="return test2(this, 100, 'cn')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.startcity",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.startcity",strsesLanguage)%>"></td>
																				<td class="rentCarLocInput"><select onchange="rentCarLocationOnChange(this, this.value, 'START');"
																					name="startLocation" id="startLocation"
																					class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.location",strsesLanguage)%>">
																						<%
																						TravelRequestEnums.Locations[] locations =   TravelRequestEnums.Locations.values();
																						for(i=0; i<locations.length; i++){
																							
																							if(!strStartLocation.equals("") && locations[i].getId().equals(strStartLocation)) {
																								%>
																	                              	<option value="<%=locations[i].getId()%>" selected="selected"><%=locations[i].getName()%></option>
																								<%
															                            	 } else {
															                            		 %>
																	                              	<option value="<%=locations[i].getId()%>"><%=locations[i].getName()%></option>
																								<%
															                            	 }
																						} 
																						%>
																				</select>
																				</td>
																				<td class="rentCarMobileInput">
																					<table width="100%" border="0" cellspacing="0" cellpadding="0">
																						<tr valign="top">
																							<td class="startMobileNoTdInput hide" id="startMobileNoTdInput"  style="padding-right: 10px;">
																								<input type="text" name="startMobileNo" class="textBoxCss startMobileNo hide" value="<%=strStartMobileNo %>"
																									id="startMobileNo" onKeyUp="return test2(this, 19, 'phone')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>">
																							</td>
																							<td class="startRoutingTdInput hide" id="startRoutingTdInput"  style="padding-right: 10px;">
																								<input type="text" name="startRouting" class="textBoxCss startRouting hide" value="<%=strStartRouting %>"
																									id="startRouting" onKeyUp="return test2(this, 100, 'cn')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage) %>" title="<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage) %>">
																							</td>
																							<td style="width: 24px;">&nbsp;</td>
																						</tr>
																					</table>																					
																				</td>
																				
																			</tr>
																		</table>
																		<script language="javascript">
																			 var startLoc = '<%=strStartLocation%>';
																			 var starsCarClass = '<%=strCarClass%>';
																																						 
																			 if(startLoc == '4' && starsCarClass == '26'){
																				    $('td.startMobileNoTdInput:eq('+<%=countVal%>+')').removeClass('hide');
																					$('input.startMobileNo:eq('+<%=countVal%>+')').removeClass('hide');
																					$('td.startMobileNoTdInput:eq('+<%=countVal%>+')').addClass('show');
																					$('input.startMobileNo:eq('+<%=countVal%>+')').addClass('show');
																			 } else {
																				    $('td.startMobileNoTdInput:eq('+<%=countVal%>+')').removeClass('show');
																				    $('input.startMobileNo:eq('+<%=countVal%>+')').removeClass('show');
																				    $('td.startMobileNoTdInput:eq('+<%=countVal%>+')').addClass('hide');
																					$('input.startMobileNo:eq('+<%=countVal%>+')').addClass('hide');
																			 }
																			 
																			 if(starsCarClass == '27' || starsCarClass == '29'){
																				    $('td.startRoutingTdInput:eq('+<%=countVal%>+')').removeClass('hide');
																					$('input.startRouting:eq('+<%=countVal%>+')').removeClass('hide');
																					$('td.startRoutingTdInput:eq('+<%=countVal%>+')').addClass('show');
																					$('input.startMobileNo:eq('+<%=countVal%>+')').addClass('show');
																			 } else {
																				    $('td.startRoutingTdInput:eq('+<%=countVal%>+')').removeClass('show');
																				    $('input.startRouting:eq('+<%=countVal%>+')').removeClass('show');
																				    $('td.startRoutingTdInput:eq('+<%=countVal%>+')').addClass('hide');
																					$('input.startRouting:eq('+<%=countVal%>+')').addClass('hide');
																			 }
													                   </script>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td class="journyInner2">
															<table class="journyDetailRentCarInner1Tbl">
																<tr>
																	<td>
																		<table class="journyDetailRentCarInner2Tbl">																		
																			<tr class="rentCarDataRowInner">
																				<td class="rentCarDateInput"><input type="text" onFocus="initializeRentCarDate(this, '<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%>');"
																					name="endDate" class="textBoxCss validDateRentCar" value="<%=strEndDate %>" id="endDate" placeholder="<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%>"></td>
																				<td class="rentCarTimeInput"><select name="endTime"
																					class="comboBoxCss" id="endTime" title="<%=dbLabelBean.getLabel("label.global.time",strsesLanguage)%>">
																					<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>
																						<%						                           
																						entrySet = preferredTimeList.entrySet();
																						it = entrySet.iterator();
															                             while(it.hasNext())
															                             {
															                            	 Map.Entry entry = (Map.Entry)it.next();
															                            	 if(!excludeTrainTimeList.contains(entry.getKey())){
																                            	 if(!strEndTime.equals("") && entry.getKey().equals(strEndTime)) {
																									%>
																		                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																									<%
																                            	 } else {
																                            		 %>
																		                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																									<%
																                            	 }
															                            	 }
															                         	 }
															                         	 %>	
																				</select>
																				</td>
																				<td class="rentCarCityInput"><input type="text" 
																					name="endCity" class="textBoxCss" value="<%=strEndCity %>" id="endCity"
																					onKeyUp="return test2(this, 100, 'cn')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.endcity",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.endcity",strsesLanguage)%>"></td>
																			    <td class="rentCarLocInput"><select name="endLocation" onchange="rentCarLocationOnChange(this, this.value, 'END');"
																					id="endLocation" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.location",strsesLanguage)%>">
																						<%
																						locations =   TravelRequestEnums.Locations.values();
																							for(i=0; i<locations.length; i++){
																								
																								if(!strEndLocation.equals("") && locations[i].getId().equals(strEndLocation)) {
																									%>
																		                              	<option value="<%=locations[i].getId()%>" selected="selected"><%=locations[i].getName()%></option>
																									<%
																                            	 } else {
																                            		 %>
																		                              	<option value="<%=locations[i].getId()%>"><%=locations[i].getName()%></option>
																									<%
																                            	 }
																							}
																						%>
																				</select>
																				</td>
																				<td class="rentCarMobileInput">
																					<table width="100%" border="0" cellspacing="0" cellpadding="0">
																						<tr valign="top">
																							<td class="endMobileNoTdInput hide" id="endMobileNoTdInput"  style="padding-right: 10px;">
																								<input type="text" name="endMobileNo" class="textBoxCss endMobileNo hide" value="<%=strEndMobileNo %>"
																									id="endMobileNo" onKeyUp="return test2(this, 19, 'phone')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>">
																							</td>
																							<td class="endRoutingTdInput hide" id="endRoutingTdInput"  style="padding-right: 10px;">
																								<input type="text" name="endRouting" class="textBoxCss endRouting hide" value="<%=strEndRouting %>"
																									id="endRouting" onKeyUp="return test2(this, 100, 'cn')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage) %>" title="<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage) %>">
																							</td>
																							<td class="rentCarDelBtn">
																								<img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0" 
																								id="bt-Del-RentCar" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>">
																							</td>
																						</tr>
																					</table>	
																				</td>
																			</tr>
																		</table>
																		<script language="javascript">
																			 var endLoc = '<%=strEndLocation%>';
																			 var endCarClass = '<%=strCarClass%>';
																			 
																			 if(endLoc == '4' && endCarClass == '26'){
																				    $('td.endMobileNoTdInput:eq('+<%=countVal%>+')').removeClass('hide');
																					$('input.endMobileNo:eq('+<%=countVal%>+')').removeClass('hide');
																					$('td.endMobileNoTdInput:eq('+<%=countVal%>+')').addClass('show');
																					$('input.endMobileNo:eq('+<%=countVal%>+')').addClass('show');
																			 } else {
																				    $('td.endMobileNoTdInput:eq('+<%=countVal%>+')').removeClass('show');
																				    $('input.endMobileNo:eq('+<%=countVal%>+')').removeClass('show');
																				    $('td.endMobileNoTdInput:eq('+<%=countVal%>+')').addClass('hide');
																					$('input.endMobileNo:eq('+<%=countVal%>+')').addClass('hide');
																			 }
																			 
																			 if(endCarClass == '27' || endCarClass == '29'){
																				    $('td.endRoutingTdInput:eq('+<%=countVal%>+')').removeClass('hide');
																					$('input.endRouting:eq('+<%=countVal%>+')').removeClass('hide');
																					$('td.endRoutingTdInput:eq('+<%=countVal%>+')').addClass('show');
																					$('input.endRouting:eq('+<%=countVal%>+')').addClass('show');
																			 } else {
																				    $('td.endRoutingTdInput:eq('+<%=countVal%>+')').removeClass('show');
																				    $('input.endRouting:eq('+<%=countVal%>+')').removeClass('show');
																				    $('td.endRoutingTdInput:eq('+<%=countVal%>+')').addClass('hide');
																					$('input.endRouting:eq('+<%=countVal%>+')').addClass('hide');
																			 }
													                   </script>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>											
										</tr>
										<% countVal++;
											} 
										while(rs8.next());
										} else { %>
										<tr class="rentCarDataRow">
										 <input type="hidden" name="travelCarId" id="travelCarId" value="" />
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td class="journyInner2">
															<table class="journyDetailRentCarInner1Tbl">
																<tr>
																	<td>
																		<table class="journyDetailRentCarInner2Tbl" border="0">
																			<tr class="rentCarDataRowInner">
																				<td class="rentCarDateInput"><input type="text"
																					name="startDate" class="textBoxCss validDateRentCar" value="" onFocus="initializeRentCarDate(this, '<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%>');"
																					id="startDate" placeholder="<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%>"></td>
																				<td class="rentCarTimeInput"><select name="startTime"
																					class="comboBoxCss" id="startTime" title="<%=dbLabelBean.getLabel("label.global.time",strsesLanguage)%>">
																					<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>
																						<%						                           
																						entrySet = preferredTimeList.entrySet();
																						it = entrySet.iterator();
															                             while(it.hasNext()) {
															                            	 Map.Entry entry = (Map.Entry)it.next();
															                            	 if(!excludeTrainTimeList.contains(entry.getKey())){
														                            		 	if(entry.getKey().equals("102")) {
																						%>
																		                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																						<%
																                            	 } else {
																                        %>
																		                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																						<%
																                            	 }
															                            	 }
															                         	 }
																						%>	
																				</select>													
																				</td>
																				<td class="rentCarCityInput"><input type="text" 
																					name="startCity" class="textBoxCss" value=""
																					id="startCity" onKeyUp="return test2(this, 100, 'cn')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.startcity",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.startcity",strsesLanguage)%>"></td>
																				<td class="rentCarLocInput"><select onchange="rentCarLocationOnChange(this, this.value, 'START');"
																					name="startLocation" id="startLocation"
																					class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.location",strsesLanguage)%>">
																						<%
																						TravelRequestEnums.Locations[] locations =   TravelRequestEnums.Locations.values();
																						for(i=0; i<locations.length; i++) {																							
																							%>
																                              	<option value="<%=locations[i].getId()%>"><%=locations[i].getName()%></option>
																							<%
																						} 
																						%>
																				</select>
																				</td>
																				<td class="rentCarMobileInput">
																					<table width="100%" border="0" cellspacing="0" cellpadding="0">
																						<tr valign="top">
																							<td class="startMobileNoTdInput hide" id="startMobileNoTdInput"  style="padding-right: 10px;">
																								<input type="text" name="startMobileNo" class="textBoxCss hide" value=""
																									id="startMobileNo" onKeyUp="return test2(this, 19, 'phone')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>">
																							</td>
																							<td class="startRoutingTdInput hide" id="startRoutingTdInput"  style="padding-right: 10px;">
																								<input type="text" name="startRouting" class="textBoxCss startRouting hide" value=""
																									id="startRouting" onKeyUp="return test2(this, 100, 'cn')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage) %>" title="<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage) %>">
																							</td>
																							<td style="width: 24px;">&nbsp;</td>
																						</tr>
																					</table>																					
																				</td>
																			</tr>
																		</table>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td class="journyInner2">
															<table class="journyDetailRentCarInner1Tbl">
																<tr>
																	<td>
																		<table class="journyDetailRentCarInner2Tbl">
																			<tr class="rentCarDataRowInner">
																				<td class="rentCarDateInput"><input type="text" onFocus="initializeRentCarDate(this, '<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%>');"
																					name="endDate" class="textBoxCss validDateRentCar" value="" id="endDate" placeholder="<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%>"></td>
																				<td class="rentCarTimeInput"><select name="endTime"
																					class="comboBoxCss" id="endTime" title="<%=dbLabelBean.getLabel("label.global.time",strsesLanguage)%>">
																					<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>
																						<%						                           
																						entrySet = preferredTimeList.entrySet();
																						it = entrySet.iterator();
															                             while(it.hasNext()) {
															                            	 Map.Entry entry = (Map.Entry)it.next();
															                            	 if(!excludeTrainTimeList.contains(entry.getKey())){
																								if(entry.getKey().equals("102")) {
																						%>
																		                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																						<%
																                            	 } else {
																                        %>
																		                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																						<%
																                            	 }
															                            	 }
															                         	 }
																						%>	
																				</select>
																				</td>
																				<td class="rentCarCityInput"><input type="text" 
																					name="endCity" class="textBoxCss" value="" id="endCity"
																					onKeyUp="return test2(this, 100, 'cn')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.endcity",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.endcity",strsesLanguage)%>"></td>
																			    <td class="rentCarLocInput"><select name="endLocation" onchange="rentCarLocationOnChange(this, this.value, 'END');"
																					id="endLocation" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.location",strsesLanguage)%>">
																						<%
																						locations =   TravelRequestEnums.Locations.values();
																							for(i=0; i<locations.length; i++) {																								
																								%>
																	                              	<option value="<%=locations[i].getId()%>"><%=locations[i].getName()%></option>
																								<%
																							}
																						%>
																				</select>
																				</td>
																				<td class="rentCarMobileInput">
																					<table width="100%" border="0" cellspacing="0" cellpadding="0">
																						<tr valign="top">
																							<td class="endMobileNoTdInput hide" id="endMobileNoTdInput"  style="padding-right: 10px;">
																								<input type="text" name="endMobileNo" class="textBoxCss hide" value=""
																									id="endMobileNo" onKeyUp="return test2(this, 19, 'phone')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>">
																							</td>
																							<td class="endRoutingTdInput hide" id="endRoutingTdInput"  style="padding-right: 10px;">
																								<input type="text" name="endRouting" class="textBoxCss endRouting hide" value=""
																									id="endRouting" onKeyUp="return test2(this, 100, 'cn')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage) %>" title="<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage) %>">
																							</td>
																							<td style="width: 24px;">&nbsp;</td>
																						</tr>
																					</table>	
																				</td>
																			</tr>
																		</table>																		
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>											
										</tr>
										
										<% }
											rs8.close();
										} else { %> 
										<tr class="rentCarDataRow">
										 <input type="hidden" name="travelCarId" id="travelCarId" value="" />
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td class="journyInner2">
															<table class="journyDetailRentCarInner1Tbl">
																<tr>
																	<td>
																		<table class="journyDetailRentCarInner2Tbl" border="0">
																		   <tr class="rentCarDataRowInner">
																				<td class="rentCarDateInput"><input type="text"
																					name="startDate" class="textBoxCss validDateRentCar" value="" onFocus="initializeRentCarDate(this, '<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%>');"
																					id="startDate" placeholder="<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%>"></td>
																				<td class="rentCarTimeInput"><select name="startTime"
																					class="comboBoxCss" id="startTime" title="<%=dbLabelBean.getLabel("label.global.time",strsesLanguage)%>">
																					<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>

																						<%						                           
																						entrySet = preferredTimeList.entrySet();
																						it = entrySet.iterator();
															                             while(it.hasNext()) {
															                            	 Map.Entry entry = (Map.Entry)it.next();
															                            	 if(!excludeTrainTimeList.contains(entry.getKey())){
																								if(entry.getKey().equals("102")) {
																						%>
																		                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																						<%
																                            	 } else {
																                        %>
																		                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																						<%
																                            	 }
															                            	 }
															                         	 }
																						%>	
																				</select>													
																				</td>
																				<td class="rentCarCityInput"><input type="text" 
																					name="startCity" class="textBoxCss" value=""
																					id="startCity" onKeyUp="return test2(this, 100, 'cn')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.startcity",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.startcity",strsesLanguage)%>"></td>
																				<td class="rentCarLocInput"><select onchange="rentCarLocationOnChange(this, this.value, 'START');"
																					name="startLocation" id="startLocation"
																					class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.location",strsesLanguage)%>">
																						<%
																						TravelRequestEnums.Locations[] locations =   TravelRequestEnums.Locations.values();
																						for(i=0; i<locations.length; i++) {																							
																							%>
																                              	<option value="<%=locations[i].getId()%>"><%=locations[i].getName()%></option>
																							<%
																						} 
																						%>
																				</select>
																				</td>
																				<td class="rentCarMobileInput">
																					<table width="100%" border="0" cellspacing="0" cellpadding="0">
																						<tr valign="top">
																							<td class="startMobileNoTdInput hide" id="startMobileNoTdInput"  style="padding-right: 10px;">
																								<input type="text" name="startMobileNo" class="textBoxCss hide" value=""
																									id="startMobileNo" onKeyUp="return test2(this, 19, 'phone')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>">
																							</td>
																							<td class="startRoutingTdInput hide" id="startRoutingTdInput"  style="padding-right: 10px;margin-left: -169px;">
																								<input type="text" name="startRouting" class="textBoxCss hide" value=""
																									id="startRouting" onKeyUp="return test2(this, 100, 'cn')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage) %>" title="<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage) %>">
																							</td>
																							<td style="width: 24px;">&nbsp;</td>
																						</tr>
																					</table>																					
																				</td>
																			</tr>
																		</table>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td class="journyInner2">
															<table class="journyDetailRentCarInner1Tbl">
																<tr>
																	<td>
																		<table class="journyDetailRentCarInner2Tbl">
																			<tr class="rentCarDataRowInner">
																				<td class="rentCarDateInput"><input type="text" onFocus="initializeRentCarDate(this, '<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%>');"
																					name="endDate" class="textBoxCss validDateRentCar" value="" id="endDate" placeholder="<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%>"></td>
																				<td class="rentCarTimeInput"><select name="endTime"
																					class="comboBoxCss" id="endTime" title="<%=dbLabelBean.getLabel("label.global.time",strsesLanguage)%>">
																					<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>
																						<%						                           
																						entrySet = preferredTimeList.entrySet();
																						it = entrySet.iterator();
															                             while(it.hasNext()) {
															                            	 Map.Entry entry = (Map.Entry)it.next();
															                            	 if(!excludeTrainTimeList.contains(entry.getKey())){
																								if(entry.getKey().equals("102")) {
																						%>
																		                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																						<%
																                            	 } else {
																                        %>
																		                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																						<%
																                            	 }
															                            	 }
															                         	 }
																						%>	
																				</select>
																				</td>
																				<td class="rentCarCityInput"><input type="text" 
																					name="endCity" class="textBoxCss" value="" id="endCity"
																					onKeyUp="return test2(this, 100, 'cn')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.endcity",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.endcity",strsesLanguage)%>"></td>
																			    <td class="rentCarLocInput"><select name="endLocation" onchange="rentCarLocationOnChange(this, this.value, 'END');"
																					id="endLocation" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.location",strsesLanguage)%>">
																						<%
																						locations =   TravelRequestEnums.Locations.values();
																							for(i=0; i<locations.length; i++) {																								
																								%>
																	                              	<option value="<%=locations[i].getId()%>"><%=locations[i].getName()%></option>
																								<%
																							}
																						%>
																				</select>
																				</td>
																				<td class="rentCarMobileInput">
																					<table width="100%" border="0" cellspacing="0" cellpadding="0">
																						<tr valign="top">
																							<td class="endMobileNoTdInput hide" id="endMobileNoTdInput"  style="padding-right: 10px;">
																								<input type="text" name="endMobileNo" class="textBoxCss hide" value=""
																									id="endMobileNo" onKeyUp="return test2(this, 19, 'phone')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>">
																							</td>
																							<td class="endRoutingTdInput hide" id="endRoutingTdInput"  style="padding-right: 10px;margin-left: -169px;">
																								<input type="text" name="endRouting" class="textBoxCss hide" value=""
																									id="endRouting" onKeyUp="return test2(this, 100, 'cn')" maxlength="100"placeholder="<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage) %>" title="<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage) %>">
																							</td>
																							<td style="width: 24px;">&nbsp;</td>
																						</tr>
																					</table>	
																				</td>
																			</tr>
																		</table>																		
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>											
										</tr>
										<%} %>
										<tr class="innerRowRentCar"></tr>										
										<tr class="prototypeRowRentCar">
										   <input type="hidden" name="travelCarIdPT" id="travelCarId" value="" />
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">													
													<tr>
														<td class="journyInner2">
															<table class="journyDetailRentCarInner1Tbl">
																<tr>
																	<td>
																		<table class="journyDetailRentCarInner2Tbl" border="0">
																			<tr class="rentCarDataRowInner">
																				<td class="rentCarDateInput"><input type="text"
																					name="startDatePT" class="textBoxCss validDateRentCar" value="" onFocus="initializeRentCarDate(this, '<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%>');"
																					id="startDate" placeholder="<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%>"></td>
																				<td class="rentCarTimeInput"><select name="startTimePT"
																					class="comboBoxCss" id="startTime" title="<%=dbLabelBean.getLabel("label.global.time",strsesLanguage)%>">
																					<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>

																						<%						                           
																						entrySet = preferredTimeList.entrySet();
																						it = entrySet.iterator();
															                             while(it.hasNext()) {
															                            	 Map.Entry entry = (Map.Entry)it.next();
															                            	 if(!excludeTrainTimeList.contains(entry.getKey())){																                            	 
																								if(entry.getKey().equals("102")) {
																						%>
																		                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																						<%
																                            	 } else {
																                        %>
																		                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																						<%
																                            	 }
															                            	 }
															                         	 }
																						%>	
																				</select>													
																				</td>
																				<td class="rentCarCityInput"><input type="text" 
																					name="startCityPT" class="textBoxCss" value=""
																					id="startCity" onKeyUp="return test2(this, 100, 'cn')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.startcity",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.startcity",strsesLanguage)%>"></td>
																				<td class="rentCarLocInput"><select onchange="rentCarLocationOnChange(this, this.value, 'START');"
																					name="startLocationPT" id="startLocation"
																					class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.location",strsesLanguage)%>">
																						<%
																						TravelRequestEnums.Locations[] locations =   TravelRequestEnums.Locations.values();
																						for(i=0; i<locations.length; i++) {																							
																							%>
																                              	<option value="<%=locations[i].getId()%>"><%=locations[i].getName()%></option>
																							<%
																						} 
																						%>
																				</select>
																				</td>
																				<td class="rentCarMobileInput">
																					<table width="100%" border="0" cellspacing="0" cellpadding="0">
																						<tr valign="top">
																							<td class="startMobileNoTdInput hide" id="startMobileNoTdInput"  style="padding-right: 10px;">
																								<input type="text" name="startMobileNoPT" class="textBoxCss hide" value="<%=strStartMobileNo %>"
																									id="startMobileNo" onKeyUp="return test2(this, 19, 'phone')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>">
																							</td>
																							<td class="startRoutingTdInput hide" id="startRoutingTdInput"  style="padding-right: 10px;margin-left: -169px;">
																								<input type="text" name="startRoutingPT" class="textBoxCss hide" value="<%=strStartRouting %>"
																									id="startRouting" onKeyUp="return test2(this, 100, 'cn')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage) %>" title="<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage) %>">
																							</td>
																							<td style="width: 24px;">&nbsp;</td>
																						</tr>
																					</table>																					
																				</td>
																			</tr>
																		</table>																		
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td class="journyInner2">
															<table class="journyDetailRentCarInner1Tbl">
																<tr>
																	<td>
																		<table class="journyDetailRentCarInner2Tbl">
																			<tr class="rentCarDataRowInner">
																				<td class="rentCarDateInput"><input type="text" onFocus="initializeRentCarDate(this, '<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%>');"
																					name="endDatePT" class="textBoxCss validDateRentCar" value="" id="endDate" placeholder="<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%>"></td>
																				<td class="rentCarTimeInput"><select name="endTimePT"
																					class="comboBoxCss" id="endTime" title="<%=dbLabelBean.getLabel("label.global.time",strsesLanguage)%>">
																					<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>
																						<%						                           
																						entrySet = preferredTimeList.entrySet();
																						it = entrySet.iterator();
															                             while(it.hasNext()) {
															                            	 Map.Entry entry = (Map.Entry)it.next();
															                            	 if(!excludeTrainTimeList.contains(entry.getKey())){
																								if(entry.getKey().equals("102")) {
																						%>
																		                              	<option value="<%=entry.getKey()%>" selected="selected"><%=entry.getValue()%></option>
																						<%
																                            	 } else {
																                        %>
																		                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																						<%
																                            	 }
															                            	 }
															                         	 }
																						%>	
																				</select>
																				</td>
																				<td class="rentCarCityInput"><input type="text" 
																					name="endCityPT" class="textBoxCss" value="" id="endCity"
																					onKeyUp="return test2(this, 100, 'cn')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.endcity",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.endcity",strsesLanguage)%>"></td>
																			    <td class="rentCarLocInput"><select name="endLocationPT" onchange="rentCarLocationOnChange(this, this.value, 'END');"
																					id="endLocation" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.location",strsesLanguage)%>">
																						<%
																						locations =   TravelRequestEnums.Locations.values();
																							for(i=0; i<locations.length; i++) {																								
																								%>
																	                              	<option value="<%=locations[i].getId()%>"><%=locations[i].getName()%></option>
																								<%
																							}
																						%>
																				</select>
																				</td>
																				<td class="rentCarMobileInput">
																					<table width="100%" border="0" cellspacing="0" cellpadding="0">
																						<tr valign="top">
																							<td class="endMobileNoTdInput hide" id="endMobileNoTdInput"  style="padding-right: 10px;">
																								<input type="text" name="endMobileNoPT" class="textBoxCss hide" value="<%=strEndMobileNo %>"
																									id="endMobileNo" onKeyUp="return test2(this, 19, 'phone')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>">
																							</td>
																							<td class="endRoutingTdInput hide" id="endRoutingTdInput"  style="padding-right: 10px;">
																								<input type="text" name="endRoutingPT" class="textBoxCss hide" value="<%=strEndRouting %>"
																									id="endRouting" onKeyUp="return test2(this, 100, 'cn')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage) %>" title="<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage) %>">
																							</td>
																							<td class="rentCarDelBtn">
																								<img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0" 
																								id="bt-Del-RentCar" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>">
																							</td>
																						</tr>
																					</table>	
																				</td>
																			</tr>
																		</table>																		
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>											
										</tr>
									</tbody>
								</table>
							</td>
						</tr>						
						<tr id="gpsCategoryRow">
							<td class="journyInner">
								<table class="journyDetailRentCarInner3Tbl" id="gpsCategoryTable">
									<tr>
										<td class="rentCarGpsLabel" style="width: 70px;"><%=dbLabelBean.getLabel("label.global.needgps",strsesLanguage)%></td>
										<td class="rentCarCatLabel"><%=dbLabelBean.getLabel("label.global.category",strsesLanguage)%></td>
									</tr>
									<tr valign="top">
										<td class="rentCarGpsInput">
											<table width="30%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td class="requiredRadioBoxDefault">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="0" class="checkbox">
															<tr>
																<td class="labelTd"><label class="yes"
																	id="gpsRequiredYes"> <input type="radio"
																		name="gps" value="1" id="gpsRequired_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
																</label></td>
																<td class="labelTd"><label class="no"
																	id="gpsRequiredNo"> <input type="radio"
																		name="gps" value="2" checked="checked"
																		id="gpsRequired_N"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
																</label></td>
															</tr>
														</table>
														
													</td>
												</tr>
											</table>
										</td>
										<td class="rentCarCatInput"><select name="carCategory"
											id="carCategory" class="comboBoxCss">
											<%
											 TravelRequestEnums.CarCategories[] carCategories =   TravelRequestEnums.CarCategories.values();
												for(i=0; i<carCategories.length; i++){
													
													if(!strCategory.equals("") && carCategories[i].getId().equals(strCategory)) {
														%>
							                              	<option value="<%=carCategories[i].getId()%>" selected="selected"><%=carCategories[i].getName()%></option>
														<%
					                            	 }else if((strCategory == null || strCategory.equals("")) && carCategories[i].getId().equals("2")) {
														%>
							                              	<option value="<%=carCategories[i].getId()%>" selected="selected"><%=carCategories[i].getName()%></option>
														<%
					                            	 } else {
					                            		 %>
							                              	<option value="<%=carCategories[i].getId()%>"><%=carCategories[i].getName()%></option>
														<%
					                            	 }
												} 
												%>
										</select>
										</td>
									</tr>
									<script language="javascript">
										 var carClass = '<%=strCarClass%>';
										 if(carClass != null && carClass != "") {
											 $("select#carClass").val(carClass);
										 } else {
											 $("select#carClass").find('option:first').prop('selected', 'selected');
										 }
										 
										 var needGps = '<%=strNeedGps%>';
										 var catClClass = '<%=strCarClass%>';
										 
										 if(catClClass != '28' && catClClass != '29'){
											$("table#gpsCategoryTable").show();	
											
											if(needGps == '1') {
												 $("label#gpsRequiredNo").removeClass("active");
												 $("label#gpsRequiredYes").addClass("active");																 
												 $("input#gpsRequired_N").attr('checked', false);
												 $("input#gpsRequired_Y").attr('checked', true);
											 } else {
												 $("label#gpsRequiredYes").removeClass("active");
												 $("label#gpsRequiredNo").addClass("active");
												 $("input#gpsRequired_Y").attr('checked', false);
												 $("input#gpsRequired_N").attr('checked', true);
											 }
										} else {
											$("table#gpsCategoryTable").hide();		
										}
									</script>
								</table>
								<table width="99.6%" border="0" cellspacing="0" cellpadding="0" style="padding-left: 5px;">
									<tr>
										<td class="rentCarRmrknput">
											<textarea name="remarksCar" id="remarksCar" class="textAreaCss4" rows="" cols="" 
											onKeyUp="return test2(this, 1000, 'cn')" placeholder="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>" 
											title="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>" maxlength="1000"><%=strCarRemarks %></textarea>
										</td>
										<td class="journyInner" style="vertical-align: top; padding-top:2px;"><input type="button"
											value="<%=dbLabelBean.getLabel("label.global.addcarreservation",strsesLanguage)%>" class="bt-Add-Dom" id="bt_Add_RentCar"
											title="<%=dbLabelBean.getLabel("label.global.addcarreservation",strsesLanguage)%>" /></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<script language="javascript">
				 var rentCarFlag = '<%=rentCarYNFlag%>';
				 
				 if(siteIdGlobal != null && siteIdGlobal != ""){
					 if(rentCarFlag === "true") {
						$("label#rentCarRequiredNo").removeClass("active");
						$("label#rentCarRequiredYes").addClass("active");					
						$("input:radio#rentCarRequired_N").attr('checked', false);
						$("input:radio#rentCarRequired_Y").attr('checked', true);
						$("tr#rentCarDetailDiv").removeClass("hide");
						$("tr#rentCarDetailDiv").addClass("show");					
					 } else {
						 $("label#rentCarRequiredYes").removeClass("active");
						 $("label#rentCarRequiredNo").addClass("active");
						 $("input:radio#rentCarRequired_Y").attr('checked', false);
						 $("input:radio#rentCarRequired_N").attr('checked', true);
						 $("tr#rentCarDetailDiv").removeClass("show");
						 $("tr#rentCarDetailDiv").addClass("hide");
					 }
				 } else {
					    // Added by Gurmeet Singh on 31-07-2015 to disable Rent a Car Radio Buttons [Start]
						$("label#rentCarRequiredYes").addClass("disable");
						$("label#rentCarRequiredNo").addClass("disable");
						$("input:radio#rentCarRequired_Y").attr('checked', false);
						$("input:radio#rentCarRequired_N").attr('checked', true);
						$("input:radio#rentCarRequired_Y").prop('disabled', true);
						$("input:radio#rentCarRequired_N").prop('disabled', true);
						$("tr#rentCarDetailDiv").removeClass("show");
						$("tr#rentCarDetailDiv").addClass("hide");
						// Added by Gurmeet Singh on 31-07-2015 to disable Rent a Car Radio Buttons [End]
				 }
				 
            </script>
            <!-- Rent A Car Section End ********************************-->
			<tr>
				<td class="hrSpace6Px"></td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid grey;"></td>
			</tr>
			<tr>
				<td class="hrSpace6Px"></td>
			</tr>
			<!-- Accommodation Section Start ***************************-->
			<tr>
				<td class="journyType">
					<table class="journyDetailAccomodationMainTbl">
						<tr>
							<td class="journyDetailLabel"><label class="requiredInput"><b><%=dbLabelBean.getLabel("label.global.accommodation",strsesLanguage) %></b></label>
							</td>
							<td class="journyDetailRadio">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="checkbox">
									<tr>
										<td class="labelTd"><label class="yes active"
											id="accomodationRequiredYes"> <input type="radio"
												name="accomodation" value="1" id="accomodationRequired_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
										</label></td>
										<td class="labelTd"><label class="no"
											id="accomodationRequiredNo"> <input type="radio"
												name="accomodation" value="2" id="accomodationRequired_N"
												checked="checked"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
										</label></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr valign="top" id="accomodationDetail" class="hide">
				<td class="journyInner">
					<table class="journyDetailAccomodationInnerTbl"
						id="tblAccomodation">
						<tbody>
						<%  
							int count = 0;
							if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
								strSql =" SELECT TRAVEL_ACC_ID,TRAVEL_ID,TRAVEL_TYPE,TRANSIT_TYPE,PLACE,DBO.CONVERTDATEDMY1(ISNULL(CHECK_IN_DATE,'')) AS CHECK_IN_DATE,DBO.CONVERTDATEDMY1(ISNULL(CHECK_OUT_DATE,'')) AS CHECK_OUT_DATE "+
										" FROM T_TRAVEL_ACCOMMODATION TA WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_TYPE='"+strTravelType+"' AND STATUS_ID=10 ORDER BY TRAVEL_ACC_ID";

								rs9 = null;			
									rs9  =   dbConBean.executeQuery(strSql);  
									if(rs9.next()) {
										do {
										accomYNFlag			=  "true";
										strAccId			=  rs9.getString("TRAVEL_ACC_ID");
										strHotelRequired    =  rs9.getString("TRANSIT_TYPE");
										strPlace   			=  rs9.getString("PLACE");
										strCheckin        	=  rs9.getString("CHECK_IN_DATE");
										strCheckout        	=  rs9.getString("CHECK_OUT_DATE");											
								%>
								<tr class="accomodationDataRow">
										<input type="hidden" name="accomId" id="accomId" value="<%=strAccId%>">										
										<td class="accomInputBoxPrefPlc"><input type="text"
											name="place" class="textBoxCss" id="accomPlace" value="<%=strPlace %>"
											placeholder="<%=dbLabelBean.getLabel("label.global.cityandaddress",strsesLanguage)%>" onKeyUp="return test2(this, 100, 'cn')" maxlength="100"
											title="<%=dbLabelBean.getLabel("label.global.cityandaddress",strsesLanguage)%>"></td>
										<td class="accomComboBoxHotel"><select name="hotel" 
											id="accomStayType" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.staytype",strsesLanguage)%>">
												<%
												 TravelRequestEnums.AccomodationStayTypes[] staysTypes =   TravelRequestEnums.AccomodationStayTypes.values();
												for(i=0; i<staysTypes.length; i++){
													
													if(strHotelRequired != null && !strHotelRequired.equals("") && staysTypes[i].getId().equals(strHotelRequired)) {
														%>
							                              	<option value="<%=staysTypes[i].getId()%>" selected="selected"><%=staysTypes[i].getName()%></option>
														<%
					                            	 } else {
					                            		 %>
							                              	<option value="<%=staysTypes[i].getId()%>"><%=staysTypes[i].getName()%></option>
														<%
					                            	 }
												}
											%>
										</select>
										</td>										
										<td class="accomInputBoxDate"><input type="text"
											name="checkin" class="textBoxCss validDateAccom" id="checkInDate"
											onFocus="initializeAccommoDate(this, '<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>');" value="<%=strCheckin %>"
											placeholder="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>"></td>
										<td class="accomInputBoxDate"><input type="text"
											name="checkout" class="textBoxCss validDateAccom" id="checkOutDate"
											onFocus="initializeAccommoDate(this, '<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>');" value="<%=strCheckout %>"
											placeholder="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>"></td>										
										<td class="del"><img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0" 
										id="bt-Del-Accomodation" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"></td>
									</tr>									
								<% count++;
										} 
										while(rs9.next());
									} else { 
									%>
									<tr class="accomodationDataRow">
									<input type="hidden" name="accomId" id="accomId" value="">									
									<td class="accomInputBoxPrefPlc"><input type="text"
										name="place" class="textBoxCss" id="accomPlace" value=""
										placeholder="<%=dbLabelBean.getLabel("label.global.cityandaddress",strsesLanguage)%>" onKeyUp="return test2(this, 100, 'cn')" maxlength="100"
										title="<%=dbLabelBean.getLabel("label.global.cityandaddress",strsesLanguage)%>"></td>
									<td class="accomComboBoxHotel"><select name="hotel" 
										id="accomStayType" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.staytype",strsesLanguage)%>">
											<%
													 TravelRequestEnums.AccomodationStayTypes[] staysTypes =   TravelRequestEnums.AccomodationStayTypes.values();
																				for(i=0; i<staysTypes.length; i++){
																					%>
																				<option value="<%=staysTypes[i].getId()%>"><%=staysTypes[i].getName()%></option>
																				
																				<%} %>
									</select></td>
									<td class="accomInputBoxDate"><input type="text"
										name="checkin" class="textBoxCss validDateAccom" id="checkInDate"
										onFocus="initializeAccommoDate(this, '<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>');" value=""
										placeholder="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>"></td>
									<td class="accomInputBoxDate"><input type="text"
										name="checkout" class="textBoxCss validDateAccom" id="checkOutDate"
										onFocus="initializeAccommoDate(this, '<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>');" value=""
										placeholder="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>"></td>									
									<td class="del"></td>
								</tr>
									<%
									}
									rs9.close();
							} else { %>
							<tr class="accomodationDataRow">
								<input type="hidden" name="accomId" id="accomId" value="">								
								<td class="accomInputBoxPrefPlc"><input type="text"
									name="place" class="textBoxCss" id="accomPlace" value=""
									placeholder="<%=dbLabelBean.getLabel("label.global.cityandaddress",strsesLanguage)%>" onKeyUp="return test2(this, 100, 'cn')" maxlength="100"
									title="<%=dbLabelBean.getLabel("label.global.cityandaddress",strsesLanguage)%>"></td>
								<td class="accomComboBoxHotel"><select name="hotel" 
									id="accomStayType" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.staytype",strsesLanguage)%>">
										<%
												 TravelRequestEnums.AccomodationStayTypes[] staysTypes =   TravelRequestEnums.AccomodationStayTypes.values();
																			for(i=0; i<staysTypes.length; i++){
																				%>
																			<option value="<%=staysTypes[i].getId()%>"><%=staysTypes[i].getName()%></option>
																			
																			<%} %>
								</select></td>
								<td class="accomInputBoxDate"><input type="text"
									name="checkin" class="textBoxCss validDateAccom" id="checkInDate"
									onFocus="initializeAccommoDate(this, '<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>');" value=""
									placeholder="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>"></td>
								<td class="accomInputBoxDate"><input type="text"
									name="checkout" class="textBoxCss validDateAccom" id="checkOutDate"
									onFocus="initializeAccommoDate(this, '<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>');" value=""
									placeholder="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>"></td>
								<td class="del"></td>
							</tr>							
						<%} %>
							<tr class="innerRowAccomodation"></tr>
							<tr class="prototypeRowAccomodation">
								<input type="hidden" name="accomIdPT" id="accomId" value="">								
								<td class="accomInputBoxPrefPlc"><input type="text"
									name="placePT" class="textBoxCss" id="accomPlace" value=""
									placeholder="<%=dbLabelBean.getLabel("label.global.cityandaddress",strsesLanguage)%>" onKeyUp="return test2(this, 100, 'cn')" maxlength="100"
									title="<%=dbLabelBean.getLabel("label.global.cityandaddress",strsesLanguage)%>"></td>
								<td class="accomComboBoxHotel"><select name="hotelPT" 
									id="accomStayType" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.staytype",strsesLanguage)%>">
										<%
												 TravelRequestEnums.AccomodationStayTypes[] staysTypes =   TravelRequestEnums.AccomodationStayTypes.values();
																			for(i=0; i<staysTypes.length; i++){
																				%>
																			<option value="<%=staysTypes[i].getId()%>"><%=staysTypes[i].getName()%></option>
																			
																			<%} %>
								</select></td>
								<td class="accomInputBoxDate"><input type="text"
									name="checkinPT" class="textBoxCss validDateAccom" id="checkInDate"
									onFocus="initializeAccommoDate(this, '<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>');" value=""
									placeholder="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>"></td>
								<td class="accomInputBoxDate"><input type="text"
									name="checkoutPT" class="textBoxCss validDateAccom" id="checkOutDate"
									onFocus="initializeAccommoDate(this, '<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>');" value=""
									placeholder="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>"></td>
								<td class="del"><img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0" 
										id="bt-Del-Accomodation" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"></td>
							</tr>
						</tbody>												
					</table>
					<table width="99.6%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="accomTextAreaRemark">
								<textarea name="otherComment" class="textAreaCss4" id="otherComment" cols="" rows="2" 
									placeholder="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>" 
									onKeyUp="return test2(this, 1000, 'cn')" maxlength="1000" 
									title="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>"><%=strRemarks %></textarea>
							</td>
							<td class="journyInner" style="vertical-align: top; padding-top:4px;"><input type="button"
								value="<%=dbLabelBean.getLabel("label.global.addaccommodation",strsesLanguage)%>" class="bt-Add-Dom" id="bt_Add_Accomo"
								title="<%=dbLabelBean.getLabel("label.global.addaccommodation",strsesLanguage)%>" /></td>
						</tr>
					</table>
					<script language="javascript">
					 var accomFlag = '<%=accomYNFlag%>';	
					 
					 if(siteIdGlobal != null && siteIdGlobal != ""){
						 if(accomFlag === "true") {		
							$("label#accomodationRequiredNo").removeClass("active");
							$("label#accomodationRequiredYes").addClass("active");
							$("input:radio#accomodationRequired_N").attr('checked', false);
							$("input:radio#accomodationRequired_Y").attr('checked', true);						
							$("tr#accomodationDetail").removeClass("hide");	
							$("tr#accomodationDetail").addClass("show");
						 } else {
							 $("label#accomodationRequiredYes").removeClass("active");
							 $("label#accomodationRequiredNo").addClass("active");
							 $("input:radio#accomodationRequired_Y").attr('checked', false);
							 $("input:radio#accomodationRequired_N").attr('checked', true);
							 $("tr#accomodationDetail").removeClass("show");	
							 $("tr#accomodationDetail").addClass("hide");
						 }
					 } else {
						    // Added by Gurmeet Singh on 31-07-2015 to disable Accommodation Radio Buttons [Start]
							$("label#accomodationRequiredYes").addClass("disable");
							$("label#accomodationRequiredNo").addClass("disable");
							$("input:radio#accomodationRequired_Y").attr('checked', false);
							$("input:radio#accomodationRequired_N").attr('checked', true);
							$("input:radio#accomodationRequired_Y").prop('disabled', true);
							$("input:radio#accomodationRequired_N").prop('disabled', true);
							$("tr#accomodationDetail").removeClass("show");	
							$("tr#accomodationDetail").addClass("hide");
							$("select#accomStayType").find('option').eq(0).prop('selected', true);
							$("input#accomPlace").prop('disabled', true);
							$("input#checkInDate").prop('disabled', true);
							$("input#checkOutDate").prop('disabled', true);		
							$("textarea#otherComment").prop('disabled', false);	
							// Added by Gurmeet Singh on 31-07-2015 to disable Accommodation Radio Buttons [End]
					 }
					    
					 		
                     </script>
				</td>
			</tr>
			<tr>
				<td style="border-width: 0 0 0 0;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td style="padding-bottom: 2px; border-top: 1px solid #cbcbcb;"></td>
						</tr>
					</table>
				</td>
			</tr>
			<!-- Submit To Workflow Start -->
			<tr>
				<td style="border-width: 0 0 0 0;">
					<table width="13%" border="0" cellspacing="5" cellpadding="0"
						align="center"
						style="margin-left: auto; margin-right: auto; text-align: center;">
						<tr>
							<td class="submitToWorkflow" style="display: none;"><input type="button"
								name="saveandexit" value="Save and Exit"
								class="bt-SubmitToWorkflow-Dom" id="bt-SaveExit"
								title="Save and Exit"
								onClick="checkData(this.form, 'saveExit');" /></td>
							<td class="submitToWorkflow" style="display: none;"><input type="button"
								name="save" value="Save" class="bt-SubmitToWorkflow-Dom"
								id="bt-Save" title="Save"
								onClick="checkData(this.form, 'save');" /></td>
							<td class="submitToWorkflow"><input type="button"
								name="saveproceed" value="Submit To Workflow"
								class="bt-SubmitToWorkflow-Dom" id="bt-SubmitToWorkflow"
								title="Submit To Workflow"
								onClick="checkData(this.form, 'saveProceed');" /></td>
						</tr>
					</table>
				</td>
			</tr>
			<!-- Submit To Workflow End -->
		</table>
		<input type="hidden" name="todayDate" id="todayDate" value="<%=strCurrentDate %>"/> <!--  HIDDEN FIELD  -->
		<input type="hidden" name="basecur" id="basecur" value="<%=strBaseCur %>"/> <!--  HIDDEN FIELD  -->     
	    <input type="hidden" name="travelId" id="travelId" value="<%=strTravelId%>"/> <!--  HIDDEN FIELD  -->
	    <input type="hidden" name="travelReqId" id="travelReqId" value="<%=strTravelReqId%>"/> <!--  HIDDEN FIELD  -->
	    <input type="hidden" name="travelReqNo" id="travelReqNo" value="<%=strTravelReqNo%>"/> <!--  HIDDEN FIELD  --> 
	    <input type="hidden" name="interimId"  id="interimId" value ="<%=strIntermiId %>" /> <!--  HIDDEN FIELD  -->  
	    <input type="hidden" name="showFlag" value="<%=strShowflag %>" id="hidshowFlag"/> <!--  HIDDEN FIELD  -->
	    <input type="hidden" name="approverlist" value="<%=ApproverText%>"> <!--  HIDDEN FIELD  -->
	    <input type="hidden" name="BillingSiteFlag" value="<%=strFlag%>" id="BillingSiteFlag" />
	    <input type="hidden" name="language1" id="language1" value="<%=strsesLanguage%>" />
	    <input type="hidden" name="whatAction" id="whatAction" /> <!--  HIDDEN FIELD  -->
	    <input type="hidden" name="travellerSiteId" id="travellerSiteId" value="<%=TRAVELLERSITEID %>">
	    <input type="hidden" name="travellerUserId" id="travellerUserId" value="<%=TRAVELLERUSERID %>">	
	    <input type="hidden" name="manager" id="firstApprover" value="">	
	    <input type="hidden" name="hod" id="secondApprover" value="">	    
	</form>
	<script type="text/javascript" src="ScriptLibrary/T_Group_QuickTravelRequest_Gmbh.js?buildstamp=2_0_0"></script>
</body>
</html>
<script type="text/javascript">
$(document).ready(function() {	
	
	var strTravelIdVal = '<%=strTravelId%>';
	var travelTypeVal = '<%=strTravelType%>';	
	var srcFlagVal = '<%=srcFlag%>';
	
	if(strTravelIdVal !=null && strTravelIdVal != "" && strTravelIdVal != "new") {		
		if(travelTypeVal != null && travelTypeVal != "" && travelTypeVal == 'D') {
			if($("label.Int").length > 0) {
				$("label.Int").addClass("Disable");
				$("label.Int").hide();
			}
			if($("input#rd_Int").length > 0) {
				$("input#rd_Int").attr('checked', false);				
				$('input#rd_Int').prop('disabled', true);
				$('input#rd_Int').hide();
			}
			
			$("input#rd_Dom").attr('checked', true);		
			$("input#rd_Dom").val("D");			
			$("label.Dom").removeClass("Disable");			
			$('input#rd_Dom').prop('disabled', false);
			
			setDomInEditMode();
			
		} else if(travelTypeVal != null && travelTypeVal != "" && travelTypeVal == 'I') {
			if($("label.Dom").length > 0) {
				$("label.Dom").addClass("Disable");
				$("label.Dom").hide();
			}
			if($("input#rd_Dom").length > 0) {
				$("input#rd_Dom").attr('checked', false);				
				$('input#rd_Dom').prop('disabled', true);
				$('input#rd_Dom').hide();
			}
			
			$("input#rd_Int").attr('checked', true);
			$("input#rd_Int").val("I");
			$("label.Int").removeClass("Disable");
			$("input#rd_Int").prop('disabled', false);
			
			setIntInEditMode();
		}		
	} else {
		if(travelTypeVal != null && travelTypeVal != "" && travelTypeVal == 'D') {
			if($("label.Int").length > 0) {
				$("label.Int").addClass("Disable");
				$("label.Int").hide();
			}
			if($("input#rd_Int").length > 0) {
				$("input#rd_Int").attr('checked', false);				
				$('input#rd_Int').prop('disabled', true);
				$('input#rd_Int').hide();
			}
			
			$("input#rd_Dom").attr('checked', true);		
			$("input#rd_Dom").val("D");			
			$("label.Dom").removeClass("Disable");			
			$('input#rd_Dom').prop('disabled', false);
			
			setDomOnClickMode();
			
			if(srcFlagVal != null && srcFlagVal != "" && srcFlagVal == 'homepage') {			
				window.parent.top11.document.location.href = "topMenuBuildUp.jsp?id=label.mainmenu.domestictravelrequest&travel_type=DOM";
	
	        	setTimeout(function(){
	        	    selectedMenu(); 
	        	},2000);
			}
			
		} else if(travelTypeVal != null && travelTypeVal != "" && travelTypeVal == 'I') {
			if($("label.Dom").length > 0) {
				$("label.Dom").addClass("Disable");
				$("label.Dom").hide();
			}
			if($("input#rd_Dom").length > 0) {
				$("input#rd_Dom").attr('checked', false);				
				$('input#rd_Dom').prop('disabled', true);
				$('input#rd_Dom').hide();
			}
			
			$("input#rd_Int").attr('checked', true);
			$("input#rd_Int").val("I");
			$("label.Int").removeClass("Disable");
			$("input#rd_Int").prop('disabled', false);
			
			setIntOnClickMode();
			
			if(srcFlagVal != null && srcFlagVal != "" && srcFlagVal == 'homepage') {			
				window.parent.top11.document.location.href = "topMenuBuildUp.jsp?id=label.mainmenu.internationaltravelrequest&travel_type=INT";
	
	        	setTimeout(function(){
	        	    selectedMenu(); 
	        	},2000);
			}
        	
		} else {
			$('input#rd_Dom').on('click',function() {
				$(this).attr('checked', true);
				$('input#rd_Int').attr('checked', false);
				$(this).val("D");
				$("label.Dom").removeClass("Disable");
				$("label.Int").addClass("Disable");
				setDomOnClickMode();
				
				window.parent.top11.document.location.href = "topMenuBuildUp.jsp?id=label.mainmenu.domestictravelrequest&travel_type=DOM";

	        	setTimeout(function(){
	        	    selectedMenu(); 
	        	},2000);
			});
	
			$('input#rd_Int').on('click',function() {
				$(this).attr('checked', true);
				$('input#rd_Dom').attr('checked', false);
				$(this).val("I");
				$("label.Int").removeClass("Disable");
				$("label.Dom").addClass("Disable");	
				setIntOnClickMode();
				
				window.parent.top11.document.location.href = "topMenuBuildUp.jsp?id=label.mainmenu.internationaltravelrequest&travel_type=INT";

	        	setTimeout(function(){
	        	    selectedMenu(); 
	        	},2000);
			});
			
			if($('input#rd_Dom').is(':checked')) {
				$(this).attr('checked', true);
				$('input#rd_Int').attr('checked', false);
				$(this).val("D");
				$("label.Dom").removeClass("Disable");
				$("label.Int").addClass("Disable");
				setDomInCheckedMode();
				
				window.parent.top11.document.location.href = "topMenuBuildUp.jsp?id=label.mainmenu.domestictravelrequest&travel_type=DOM";

	        	setTimeout(function(){
	        	    selectedMenu(); 
	        	},2000);
			}	
		}
	}	
	
$("select#siteNameCombo").live("change", function() {
	var val = "";
	var workFlowCode = "0";
	var userId = '<%=Suser_id%>';	
	var siteId = $("select#siteNameCombo option:selected").val();
	var siteName = $("select#siteNameCombo option:selected").text();
	if(siteId != null && siteId == "S") {
		userId = "-1";
		siteId = '0';
		siteName = "";
	}
	
	//$("#travellerSiteId").val(siteId);
	//$("#travellerUserId").val(userId);
	
	if($('input#rd_Dom').is(':checked')) {
    	$('input#rd_Int').attr('checked', false);
    	$('input#rd_Dom').val("D");
    	val = $('input#rd_Dom:checked').val();
    	
    	if($('input:radio#fltRequired_Y').is(':checked')) {
    		workFlowCode = "1";				
    	} else {
    		workFlowCode = "0";
    	}
    } else if($('input#rd_Int').is(':checked')) {
    	$('input#rd_Dom').attr('checked', false);
    	$('input#rd_Int').val("I");
    	val = $('input#rd_Int:checked').val(); 
    	workFlowCode = "1";	
    }
	
	
	if(siteId == '0'){
		clearPersonalDetails();
	} else {
		var reqpage="quickTravelReqPersonalDetail";
		var Params='<%="language1="+strsesLanguage+"&suserRole="+SuserRole%>';
	    var urlParams=Params+"&reqpage="+reqpage+"&userId="+userId+"&siteId="+siteId;
	    
	    $.ajax({
	        type: "get",
	        url: "QuickTravelRequestGMBHServlet",
	        data: urlParams,
	        cache: false,
	        dataType : 'json',
	        success: function(result) {
	        	clearPersonalDetails();
				if(result!=null) {				
					$("#travellerSiteId").val(siteId);
					$("#travellerUserId").val(result.TRAVELLERUSERID);
					$("#siteName").val(siteName);
					$("#firstName").val(result.FIRSTNAME);
					$("#lastName").val(result.LASTNAME);
					$("#designation").val(result.DESIGNATION);
					$("#costCenter").val(result.COST_CENTER);
					$("#costCenterName").val(result.COST_CENTER_NAME);			    
					$("#hidshowFlag").val(result.SHOWFLAG);
					
					var costCenterName = result.COST_CENTER_NAME;
					if(costCenterName == "") {
						alert('Please update cost centre in your profile from "My Links -> Update Profile" page before create travel request.');			
					}			 	
				 }
	     	}
	  	});
	}
		
	populateBillingUnitListData(siteId, userId, val); 	
	populateWorkFlowApproverList(siteId, userId, val, workFlowCode);
});
	

	
// Populate User for Billing Unit
$("select#billingClient").live("change", function() {
	var billingClientId = $("select#billingClient option:selected").val();
	var reqpage="quickTravelReqBillSMGUser";	  	
  	var Params='<%="language1="+strsesLanguage+"&suserRole="+SuserRole+"&userId="+Suser_id+"&siteId="+strSiteId%>';
    var urlParams=Params+"&reqpage="+reqpage+"&billingClientId="+billingClientId;
	$.ajax({type: "get", url: "QuickTravelRequestGMBHServlet",data: urlParams,dataType : 'json',
            success: function(result) {
	           	if(result!=null) {	
	           		$("#BillingSiteFlag").val();
					$("#billingApprover").html('');
					$("#billingApprover").get(0).options.add(new Option());
	             	$("#billingApprover").html(result.billUserHtml);
	             	$("#BillingSiteFlag").val(result.multiSiteAccessFlag);
				}				
        	}
      });
});

});

function selectedMenu(){
    // loop throgh the elements
    var elemArray = window.parent.top11.document.getElementsByTagName("a");
    for(var i = 0; i < elemArray.length; i++){
    	var hrefElem = elemArray[i].innerHTML;
		if(hrefElem === '<%=dbLabelBean.getLabel("submenu.domesticrequest.createeditrequisition",strsesLanguage)%>' || hrefElem === '<%=dbLabelBean.getLabel("submenu.internationalrequest.createeditrequest",strsesLanguage)%>') {
			$(elemArray[i]).addClass("selectedmenu3");
		}
    }
}

//Populate Approver Level Combo
function populateBillingUnitListData(siteId, userId, travelTypeRd) {
	var reqpage="quickTravelReqApprLvl";
	if(siteId != null && siteId == "S") {
		siteId = '0';
	}
  	var Params='<%="language1="+strsesLanguage+"&suserRole="+SuserRole%>';
    var urlParams=Params+"&reqpage="+reqpage+"&siteId="+siteId+"&userId="+userId+"&travelTypeRd="+travelTypeRd;
	$.ajax({
            type: "get",
            url: "QuickTravelRequestGMBHServlet",
            data: urlParams,
            dataType : 'json',
            success: function(result) {
			if(result!=null) {					
				$.each(result, function(key,value) {
					if(typeof(value['billSiteHtml']) == 'undefined' || value['billSiteHtml'] == null) {}
       			 	else {
					var billSite = value['billSiteHtml'];
						$("#billingClient").html('');
						$("#billingClient").get(0).options.add(new Option());
		             	$("#billingClient").html(billSite);
	   			 	}					
					$("select#billingClient").change();
				});				
			}				
        }
    });
}

//function for showing the WorkFlow Approver List
function populateWorkFlowApproverList(siteId, travellerId, traveltype, workFlowCode) {
	if(siteId != null && siteId == "S") {
		siteId = "0";
	}
	
	var urlParams="siteId="+siteId+"&travellerId="+travellerId+"&traveltype="+traveltype+"&workFlowCode="+workFlowCode;
	
	var urlApp = 'T_WorkflowApproverListMATAGmbH.jsp?'+urlParams;	
	$("div#workFlowApproverDiv").load(urlApp, function() {
		$.ajax({
	        type: "get",
	        url: "GetApproversListGMBHServlet",
	        data: urlParams,
	        cache: false,
	        dataType : 'json',
	        success: function(result) {
	        	clearApproversDetails();
				if(result!=null) {
					$("#firstApprover").val(result.manager);
					$("#secondApprover").val(result.hod);
					
					if(result.btnDisable === "true") {
						document.getElementById("bt-SaveExit").disabled=false;
						document.getElementById("bt-Save").disabled=false;
						document.getElementById("bt-SubmitToWorkflow").disabled=false;						
					} else {
						document.getElementById("bt-SaveExit").disabled=true;
						document.getElementById("bt-Save").disabled=true;
						document.getElementById("bt-SubmitToWorkflow").disabled=true;
					
						alert('Can’t proceed further due to following reasons:-\n\nA) Report To(Approver Level1)/Department Head(Approver Level2) is not defined in your profile.\nB) Default workflow is applicable, but not defined.\n\nPlease contact to Local Administrator of your unit.');
					}
				 }
	     	}
	  	});
	});
}

function deleteGroupGuestDetailsById(grpTravellerId, rowCountGroupGuest) {
	var suserId = '<%=Suser_id%>';
	var travelId = '<%=strTravelId%>';
	var travelType = '<%=strTravelType%>';	
	var actionBtn="groupGuestDelBtn";	  	
 	var urlParams="actionBtn="+actionBtn+"&suserId="+suserId+"&travelId="+travelId+"&travelType="+travelType+"&grpTravellerId="+grpTravellerId+"&rowCountGroupGuest="+rowCountGroupGuest;
 	deleteDetails(urlParams);
}

function deleteFlightDetails() {
	var suserId = '<%=Suser_id%>';
	var travelId = '<%=strTravelId%>';
	var travelType = '<%=strTravelType%>';
	var travelMode = "1";
	var actionBtn="flightNoBtn";	  	
 	var urlParams="actionBtn="+actionBtn+"&suserId="+suserId+"&travelId="+travelId+"&travelType="+travelType+"&travelMode="+travelMode;
 	deleteDetails(urlParams);
}

function deleteTrainDetails() {
	var suserId = '<%=Suser_id%>';
	var travelId = '<%=strTravelId%>';
	var travelType = '<%=strTravelType%>';
	var travelMode = "2";
	var actionBtn="trainNoBtn";	  	
 	var urlParams="actionBtn="+actionBtn+"&suserId="+suserId+"&travelId="+travelId+"&travelType="+travelType+"&travelMode="+travelMode;
 	deleteDetails(urlParams);
}

function deleteCarDetailsAll() {
	var suserId = '<%=Suser_id%>';
	var travelId = '<%=strTravelId%>';
	var travelType = '<%=strTravelType%>';
	var travelCarIdArr = document.getElementsByName("travelCarId");
	var travelCarIdValues = [];
	for(var i=0; i<travelCarIdArr.length; i++){
		if(travelCarIdArr[i].value !=""){
			travelCarIdValues.push(travelCarIdArr[i].value);
		}		
	}	
	var actionBtn="rentCarNoBtn";	  	
 	var urlParams="actionBtn="+actionBtn+"&suserId="+suserId+"&travelId="+travelId+"&travelType="+travelType+"&travelCarIdArr="+travelCarIdValues;
 	deleteDetails(urlParams);
}

function deleteCarDetailsById(travelCarId, rowCountRentCar) {
	var suserId = '<%=Suser_id%>';
	var travelId = '<%=strTravelId%>';
	var travelType = '<%=strTravelType%>';	
	var actionBtn="rentCarDelBtn";	  	
 	var urlParams="actionBtn="+actionBtn+"&suserId="+suserId+"&travelId="+travelId+"&travelType="+travelType+"&travelCarId="+travelCarId+"&rowCountRentCar="+rowCountRentCar;
 	deleteDetails(urlParams);
}

function deleteAccomDetailsAll() {
	var suserId = '<%=Suser_id%>';
	var travelId = '<%=strTravelId%>';
	var travelReqId = '<%=strTravelReqId%>';
	var travelType = '<%=strTravelType%>';
	var accomIdArr = document.getElementsByName("accomId");
	var accomIdValues = [];
	for(var i=0; i<accomIdArr.length; i++){
		if(accomIdArr[i].value !=""){
			accomIdValues.push(accomIdArr[i].value);
		}		
	}	
	var actionBtn="AccomNoBtn";	  	
 	var urlParams="actionBtn="+actionBtn+"&suserId="+suserId+"&travelId="+travelId+"&travelType="+travelType+"&travelReqId="+travelReqId+"&accomIdArr="+accomIdValues;
 	deleteDetails(urlParams);
}

function deleteAccomDetailsById(accomId, rowCountAccom) {
	var suserId = '<%=Suser_id%>';
	var travelId = '<%=strTravelId%>';
	var travelReqId = '<%=strTravelReqId%>';
	var travelType = '<%=strTravelType%>';	
	var actionBtn="AccomDelBtn";	  	
 	var urlParams="actionBtn="+actionBtn+"&suserId="+suserId+"&travelId="+travelId+"&travelType="+travelType+"&travelReqId="+travelReqId+"&accomId="+accomId+"&rowCountAccom="+rowCountAccom;
 	deleteDetails(urlParams);
}

function deleteDetails(urlParams) {
	$.ajax({
        type: "get",
        url: "QuickTravelRequisitionDeleteGMBHServlet",
        data: urlParams,
        dataType : 'json',
        success: function(result) {
        	if(result!=null) {					
				
			}				
    	}
   });
}

function checkTravellerDOB(frm, todayDate, dateOfBirth, issueDate) {	
	var d=todayDate.substr(6,4);
	var year=parseInt(d,10);

	var a =todayDate.substr(3,2);
	var month=parseInt(a,10);

	var c =todayDate.substr(0,2);
	var day=parseInt(c,10);

    //get date of birth info
	var f=dateOfBirth.substr(6,4);
	var year1=parseInt(f,10);

	var b=dateOfBirth.substr(3,2);
	var month1=parseInt(b,10);

	var h=dateOfBirth.substr(0,2);
	var day1=parseInt(h,10);
	
	if(year<year1) {
		 alert('<%=dbLabelBean.getLabel("alert.global.dobcannotgreaterthantodaydate",strsesLanguage)%>');		
		 return false;
	} //end of if
	
	if((year==year1)&&(month<month1)) {
		 alert('<%=dbLabelBean.getLabel("alert.global.dobcannotgreaterthantodaydate",strsesLanguage)%>');
		 return false;
	}//end of elseif
	
	if((year==year1)&&(month==month1)&&(day<day1)) 	{		
		 alert('<%=dbLabelBean.getLabel("alert.global.dobcannotgreaterthantodaydate",strsesLanguage)%>');
		 return false;
	}//end of elseif

	//checking for issue date
	if((issueDate != null && issueDate != '')) {		
		//get issue date info
		var d=issueDate.substr(6,4);
    	var year2=parseInt(d,10);
	    var a =issueDate.substr(3,2);
    	var month2=parseInt(a,10);
    	var c =issueDate.substr(0,2);
    	var day2=parseInt(c,10);
		if(year2<year1) 	{
	 	 alert('<%=dbLabelBean.getLabel("alert.createrequest.dateofbirthcannotbegreaterthanissuedate",strsesLanguage)%>');
		 return false;
    	}//end of if
	
     	if((year2==year1)&&(month2<month1)) {
		 alert('<%=dbLabelBean.getLabel("alert.createrequest.dateofbirthcannotbegreaterthanissuedate",strsesLanguage)%>');
		 return false;
     	}//end of elseif
	
    	if((year2==year1)&&(month2==month1)&&(day2<=day1)) {		
		 alert('<%=dbLabelBean.getLabel("alert.createrequest.dateofbirthcannotbegreaterorequalissuedate",strsesLanguage)%>');
		 return false;
    	}//end of elseif
	}
	return true;
}

function checkDateOfIssue(frm, todayDate, issueDate) {	
	var d=todayDate.substr(6,4);
	var year=parseInt(d,10);
	
	var a =todayDate.substr(3,2);
	var month=parseInt(a,10);	

	var c =todayDate.substr(0,2);
	var day=parseInt(c,10);	

    //get date of issue info
	var f=issueDate.substr(6,4);
	var year1=parseInt(f,10);	

	var b=issueDate.substr(3,2);
	var month1=parseInt(b,10);	

	var h=issueDate.substr(0,2);
	var day1=parseInt(h,10);


	if(year1>year) {
		 alert('<%=dbLabelBean.getLabel("alert.createrequest.passportissuedatecannotgeaterthancurrentdate",strsesLanguage)%>');
		 return false;
	}//end of if
	
	if((year==year1)&&(month1>month)) {
		alert('<%=dbLabelBean.getLabel("alert.createrequest.passportissuedatecannotgeaterthancurrentdate",strsesLanguage)%>');
		return false;
	}//end of elseif
	
	if((year==year1)&&(month==month1)&&(day1>day)) 	{		
		alert('<%=dbLabelBean.getLabel("alert.createrequest.passportissuedatecannotgeaterthancurrentdate",strsesLanguage)%>');
		return false;
	}//end of elseif
	
	return true;
}

function checkDateOfExpiry(frm, todayDate, issueDate, expiryDate) {
	var d=todayDate.substr(6,4);
	var year=parseInt(d,10);	

	var a =todayDate.substr(3,2);
	var month=parseInt(a,10);	

	var c =todayDate.substr(0,2);
	var day=parseInt(c,10);	

    //get date of expiry info
	var f=expiryDate.substr(6,4);
	var year1=parseInt(f,10);	

	var b=expiryDate.substr(3,2);
	var month1=parseInt(b,10);	

	var h=expiryDate.substr(0,2);
	var day1=parseInt(h,10);

	//get date of issue info
	var e=issueDate.substr(6,4);
	var year2=parseInt(e,10);	

	var g=issueDate.substr(3,2);
	var month2=parseInt(g,10);	

	var k=issueDate.substr(0,2);
	var day2=parseInt(k,10);
	
	if(year>year1) {
		 alert('<%=dbLabelBean.getLabel("alert.createrequest.passportdateexpired",strsesLanguage)%>');
		 return false;
	}//end of if
	
	if((year==year1)&&(month>month1)) {
		alert('<%=dbLabelBean.getLabel("alert.createrequest.passportdateexpired",strsesLanguage)%>');
		return false;
	}//end of elseif
	
	if((year==year1)&&(month==month1)&&(day>day1)) 	{		
		 alert('<%=dbLabelBean.getLabel("alert.createrequest.passportdateexpired",strsesLanguage)%>');
		 return false;
	}//end of elseif

	if(year1<year2) {
		 alert('<%=dbLabelBean.getLabel("alert.createrequest.expirydatecannotbesmallerthanissuedate",strsesLanguage)%>');
		 return false;
    }//end of if
	
   	if((year1==year2)&&(month1<month2)) {
	 	alert('<%=dbLabelBean.getLabel("alert.createrequest.expirydatecannotbesmallerthanissuedate",strsesLanguage)%>');
	 	return false;
   	}//end of elseif

   	if((year1==year2)&&(month1==month2)&&(day1<day2)) {		
	 	alert('<%=dbLabelBean.getLabel("alert.createrequest.expirydatecannotbesmallerthanissuedate",strsesLanguage)%>');
	 	return false;
    }//end of elseif			

	if((year1==year2)&&(month1==month2)&&(day1==day2)) {		
	 	alert('<%=dbLabelBean.getLabel("alert.createrequest.expirydatecannotbeequaltoissuedate",strsesLanguage)%>');
	 	return false;
    }//end of elseif
    
	return true;
}

function checkData(f1, actionFlag)  {
	f1.whatAction.value=actionFlag;	
	var flag = false;
	var todayDate  =  f1.todayDate.value;  
	var rowCountGrp = $("table#groupGuestDetailTbl tbody tr.groupGuestDetailDataRow").length;
	var rowCountFlt = $("table#tblItineraryFltInter tbody tr.itineraryDataRowFlt").length;
	var rowCountTrn = $("table#tblItineraryTrnInter tbody tr.itineraryDataRowTrn").length;
	var rowCountCar = $("table#tblRentCar tbody tr.rentCarDataRow").length;
	var rowCountAcm = $("table#tblAccomodation tbody tr.accomodationDataRow").length;
	
	var depCityFwdFlt = document.getElementsByName("depCityFlt");
	var arrCityFwdFlt = document.getElementsByName("arrCityFlt");
	var depDateFwdFlt = document.getElementsByName("depDateFlt");	
	var prefTimeFlt   = document.getElementsByName("preferTimeFlt");
	
	var depCityFwdTrn = document.getElementsByName("depCityTrn");
	var arrCityFwdTrn = document.getElementsByName("arrCityTrn");
	var depDateFwdTrn = document.getElementsByName("depDateTrn");
	var prefTimeTrn   = document.getElementsByName("preferTimeTrn");
	
	var carReservationClass = document.getElementById('carClass').value;
	var startDate = document.getElementsByName("startDate");
	var startTime = document.getElementsByName('startTime');
	var startCity = document.getElementsByName("startCity");
	var startLocation = document.getElementsByName("startLocation");
	var startMobileNo = document.getElementsByName("startMobileNo");
	var startRouting = document.getElementsByName("startRouting");
	var endDate = document.getElementsByName("endDate");
	var endTime = document.getElementsByName('endTime');
	var endCity = document.getElementsByName("endCity");
	var endLocation = document.getElementsByName("endLocation");
	var endMobileNo = document.getElementsByName("endMobileNo");
	var endRouting = document.getElementsByName("endRouting");
	
	var hotel = document.getElementsByName("hotel");
	var cityAddress = document.getElementsByName("place");
	var checkinDate = document.getElementsByName("checkin");
	var checkoutDate = document.getElementsByName("checkout");
	
	var trvFirstName   = document.getElementsByName("fNameGroup");
	var trvLastName    = document.getElementsByName("lNameGroup");		
	var trvGender      = document.getElementsByName("genderGroup");
	var trvMobileNo    = document.getElementsByName("mobileNoGroup");
	var trvMealPref    = document.getElementsByName("specialMealGroup");
	var trvPassportNo  = document.getElementsByName("passportNoGroup");
	var trvNationality = document.getElementsByName("nationalityGroup");
	var trvPlaceIssue  = document.getElementsByName("placeOfIssueGroup");
	var trvDateIssue   = document.getElementsByName("dateOfIssueGroup");
	var trvDateExpire  = document.getElementsByName("dateOfExpiryGroup");
	var trvDob         = document.getElementsByName("dobGroup");
	
		
	if(f1.siteNameCombo.value == 'S' || f1.siteNameCombo.value == '' || f1.siteNameCombo.value == '-1') {
	       alert('<%=dbLabelBean.getLabel("alert.global.unitname",strsesLanguage)%>');
		   f1.siteNameCombo.focus();
		   return false;  
	}		
	
	if(f1.costCenterName.value == "") {			
		alert('Please update cost centre in your profile from "My Links -> Update Profile" page before save or submit to workflow.');						
		f1.costCenterName.focus();
		return false;
	}
	
	if(f1.reasonForTravel.value == "" || f1.reasonForTravel.value == "<%=dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage)%>") {
		alert('<%=dbLabelBean.getLabel("alert.global.enterreasonfortravel",strsesLanguage)%>');
		f1.reasonForTravel.focus();
		return false;	
	}
	 
	//Billing Client/Approver Check Start
	var siteIdVal = $("select#siteNameCombo option:selected").val();
	var multiSiteFlag = $("#BillingSiteFlag").val();
	if(f1.billingClient.value == "-1") {
		alert('<%=dbLabelBean.getLabel("alert.global.pleaseselectbillingclient",strsesLanguage)%>');
	    f1.billingClient.focus();
	    return false;
	}	
	if(f1.billingClient.value != siteIdVal) {
		if(f1.billingApprover.value == "-1" && multiSiteFlag !='1') {
			alert('<%=dbLabelBean.getLabel("alert.global.approverfrombillingunit",strsesLanguage)%>' );
			f1.billingApprover.focus();
			return false;
		}		
	}//Billing Client/Approver Check End
	
	//Group/Guest Traveller Details Check Start	
	if(rowCountGrp >= 1) {
		for(var i = 0, len = rowCountGrp; i < len; i++) {
			if(trvFirstName[i].value=='' || trvFirstName[i].value=='<%=dbLabelBean.getLabel("label.global.firstnamesasperpassport",strsesLanguage)%>') {			
				alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterfirstnames",strsesLanguage)%>');
				trvFirstName[i].focus();
				return false;
			}	
			if(trvLastName[i].value=='' || trvLastName[i].value=='<%=dbLabelBean.getLabel("label.global.lastnamesasperpassport",strsesLanguage)%>') {			
				alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterlastnames",strsesLanguage)%>');
				trvLastName[i].focus();
				return false;
			}
			if(trvGender[i].value=='-1') {			
				alert('<%=dbLabelBean.getLabel("alert.global.gender",strsesLanguage)%>');
				trvGender[i].focus();
				return false;
			}
			if(trvMobileNo[i].value=='' || trvMobileNo[i].value=='<%=dbLabelBean.getLabel("label.global.contactno",strsesLanguage)%>') {			
				alert('<%=dbLabelBean.getLabel("alert.global.contactno",strsesLanguage)%>');
				trvMobileNo[i].focus();
				return false;
			}
			
			
			if($('input#rd_Int').is(':checked')) {
				if(trvMealPref[i].value=='-1') {			
					alert('<%=dbLabelBean.getLabel("alert.createrequest.pleaseselectmealpreference",strsesLanguage)%>');
					trvMealPref[i].focus();
					return false;
				}			
				if(trvPassportNo[i].value=='' || trvPassportNo[i].value=='<%=dbLabelBean.getLabel("label.global.passportnumber",strsesLanguage)%>') {			
					alert('<%=dbLabelBean.getLabel("alert.global.passportnumber",strsesLanguage)%>');
					trvPassportNo[i].focus();
					return false;
				}
				if(trvNationality[i].value=='' || trvNationality[i].value=='<%=dbLabelBean.getLabel("label.user.nationalityasperpassport",strsesLanguage)%>') {			
					alert('<%=dbLabelBean.getLabel("alert.global.pleaseenternationality",strsesLanguage)%>');
					trvNationality[i].focus();
					return false;
				}
				if(trvPlaceIssue[i].value=='' || trvPlaceIssue[i].value=='<%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%>') {			
					alert('<%=dbLabelBean.getLabel("alert.createrequest.enterplaceofissue",strsesLanguage)%>');
					trvPlaceIssue[i].focus();
					return false;
				}
				if(trvDateIssue[i].value=='' || trvDateIssue[i].value=='<%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%>') {			
					alert('<%=dbLabelBean.getLabel("alert.createrequest.enterdateofissue",strsesLanguage)%>');
					trvDateIssue[i].focus();
					return false;
				}
				if(trvDateExpire[i].value=='' || trvDateExpire[i].value=='<%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage)%>') {			
					alert('<%=dbLabelBean.getLabel("alert.createrequest.enterdateofexpiry",strsesLanguage)%>');
					trvDateExpire[i].focus();
					return false;
				}	
				if(trvDob[i].value=='' || trvDob[i].value=='<%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%>') {			
					alert('<%=dbLabelBean.getLabel("alert.global.dob",strsesLanguage)%>');
					trvDob[i].focus();
					return false;
				}			
				
			    flag = checkDateOfIssue(f1, todayDate, trvDateIssue[i].value);
			    if(flag == false) {
			    	trvDateIssue[i].focus();
			    	return flag;
			    }
			    flag = checkDateOfExpiry(f1, todayDate, trvDateIssue[i].value, trvDateExpire[i].value);
			    if(flag == false) {
			    	trvDateExpire[i].focus();
			    	return flag;
			    }
			    flag = checkTravellerDOB(f1, todayDate, trvDob[i].value, trvDateIssue[i].value);
			    if(flag == false) {
			    	trvDob[i].focus();
			    	return flag;
			    }
			}
			
		}
	}	
	//Group/Guest Traveller Details Check End
	
	//At least one of the forward journey detail is required for travel request Start
	if($('input:radio#fltRequired_N').is(':checked') && $('input:radio#trnRequired_N').is(':checked') && $('input:radio#rentCarRequired_N').is(':checked') && $('input:radio#accomodationRequired_N').is(':checked')) {
		alert ('At least provide details either Flight, Train, Car or Accommodation is required to create a travel request.');
		return false;
	}//At least one of the forward journey detail is required for travel request End 
	
	//Flight Details Check Start
	if($('input:radio#fltRequired_Y').is(':checked')) {
		
		if(depCityFwdFlt[0].value=='' || depCityFwdFlt[0].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
			depCityFwdFlt[0].focus();
			return false;
		}
		if(arrCityFwdFlt[0].value=='' || arrCityFwdFlt[0].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
			arrCityFwdFlt[0].focus();
			return false;
		}
	    if(depDateFwdFlt[0].value=='' || depDateFwdFlt[0].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
			depDateFwdFlt[0].focus();
			return false;
		}    
	    if (isDate(depDateFwdFlt[0].value)==false) {
	    	depDateFwdFlt[0].focus();
			return false;
		}	    
	    if(prefTimeFlt[0].value=='-1') {
			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
			prefTimeFlt[0].focus();
			return false;
		}
	    flag = validateDate(f1,todayDate,depDateFwdFlt[0].value,f1.todayDate,depDateFwdFlt[0].value,'<%=dbLabelBean.getLabel("alert.global.departuredateoffwdjourneynotsmallerthantodaydate",strsesLanguage)%>','no');
	    if(flag == false) {
	    	depDateFwdFlt[0].focus();
	    	return flag;
	    }
	    
		if(rowCountFlt >= 1) {
			for (var i = 1, len = rowCountFlt; i <= len; i++) {	
				if(depCityFwdFlt[i].value=='' || depCityFwdFlt[i].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
					alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
					depCityFwdFlt[i].focus();
					return false;
				}
				if(arrCityFwdFlt[i].value=='' || arrCityFwdFlt[i].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
					arrCityFwdFlt[i].focus();
					return false;
				}
				if(depDateFwdFlt[i].value=='' || depDateFwdFlt[i].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
					depDateFwdFlt[i].focus();
					return false;
				}
			    if (isDate(depDateFwdFlt[i].value)==false) {
			    	depDateFwdFlt[i].focus();
					return false;
				}
			    
			    if(prefTimeFlt[i].value=='-1') {
					alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
					prefTimeFlt[i].focus();
					return false;
				}
			}
			
			if(depCityFwdFlt[rowCountFlt+1].value != '' && depCityFwdFlt[rowCountFlt+1].value !='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
				if(arrCityFwdFlt[rowCountFlt+1].value=='' || arrCityFwdFlt[rowCountFlt+1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
					arrCityFwdFlt[rowCountFlt+1].focus();
					return false;
				}				
				if(depDateFwdFlt[rowCountFlt+1].value=='' || depDateFwdFlt[rowCountFlt+1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
					depDateFwdFlt[rowCountFlt+1].focus();
					return false;
				}    
			    if (isDate(depDateFwdFlt[rowCountFlt+1].value)==false) {
			    	depDateFwdFlt[rowCountFlt+1].focus();
					return false;
				}
			    if(prefTimeFlt[rowCountFlt+1].value=='-1') {
					alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
					prefTimeFlt[rowCountFlt+1].focus();
					return false;
				}
			} else {
				depCityFwdFlt[rowCountFlt+1].value="";
			}
			
			if(arrCityFwdFlt[rowCountFlt+1].value!= '' && arrCityFwdFlt[rowCountFlt+1].value!='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
				if(depCityFwdFlt[rowCountFlt+1].value=='' || depCityFwdFlt[rowCountFlt+1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
					alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
					depCityFwdFlt[rowCountFlt+1].focus();
					return false;
				}
				if(depDateFwdFlt[rowCountFlt+1].value=='' || depDateFwdFlt[rowCountFlt+1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
					depDateFwdFlt[rowCountFlt+1].focus();
					return false;
				}    
			    if (isDate(depDateFwdFlt[rowCountFlt+1].value)==false) {
			    	depDateFwdFlt[rowCountFlt+1].focus();
					return false;
				}
			    if(prefTimeFlt[rowCountFlt+1].value=='-1') {
					alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
					prefTimeFlt[rowCountFlt+1].focus();
					return false;
				}
			} else {
				arrCityFwdFlt[rowCountFlt+1].value="";
			}
			
			if(depDateFwdFlt[rowCountFlt+1].value!= '' && depDateFwdFlt[rowCountFlt+1].value!='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
				if(depCityFwdFlt[rowCountFlt+1].value=='' || depCityFwdFlt[rowCountFlt+1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
					alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
					depCityFwdFlt[rowCountFlt+1].focus();
					return false;
				}
				if(arrCityFwdFlt[rowCountFlt+1].value=='' || arrCityFwdFlt[rowCountFlt+1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
					arrCityFwdFlt[rowCountFlt+1].focus();
					return false;
				}				
				if (isDate(depDateFwdFlt[rowCountFlt+1].value)==false) {
			    	depDateFwdFlt[rowCountFlt+1].focus();
					return false;
				}
				if(prefTimeFlt[rowCountFlt+1].value=='-1') {
					alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
					prefTimeFlt[rowCountFlt+1].focus();
					return false;
				}
			} else {
				depDateFwdFlt[rowCountFlt+1].value= "";
			}
			  		    	
		} else {
			
			if(depCityFwdFlt[1].value != '' && depCityFwdFlt[1].value !='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
				if(arrCityFwdFlt[1].value=='' || arrCityFwdFlt[1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
					arrCityFwdFlt[1].focus();
					return false;
				}				
				if(depDateFwdFlt[1].value=='' || depDateFwdFlt[1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
					depDateFwdFlt[1].focus();
					return false;
				}    
			    if (isDate(depDateFwdFlt[1].value)==false) {
			    	depDateFwdFlt[1].focus();
					return false;
				}
			    
			    if(prefTimeFlt[1].value=='-1') {
					alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
					prefTimeFlt[1].focus();
					return false;
				}
			} else {
				depCityFwdFlt[1].value="";
			}
			
			if(arrCityFwdFlt[1].value!= '' && arrCityFwdFlt[1].value!='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
				if(depCityFwdFlt[1].value=='' || depCityFwdFlt[1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
					alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
					depCityFwdFlt[1].focus();
					return false;
				}
				if(depDateFwdFlt[1].value=='' || depDateFwdFlt[1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
					depDateFwdFlt[1].focus();
					return false;
				}			    
			    if (isDate(depDateFwdFlt[1].value)==false) {
			    	depDateFwdFlt[1].focus();
					return false;
				}
			    
			    if(prefTimeFlt[1].value=='-1') {
					alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
					prefTimeFlt[1].focus();
					return false;
				}
			} else {
				arrCityFwdFlt[1].value="";
			}
			
			if(depDateFwdFlt[1].value!= '' && depDateFwdFlt[1].value!='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
				if(depCityFwdFlt[1].value=='' || depCityFwdFlt[1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
					alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
					depCityFwdFlt[1].focus();
					return false;
				}
				if(arrCityFwdFlt[1].value=='' || arrCityFwdFlt[1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
					arrCityFwdFlt[1].focus();
					return false;
				}				
				if (isDate(depDateFwdFlt[1].value)==false) {
			    	depDateFwdFlt[1].focus();
					return false;
				}
				
				if(prefTimeFlt[1].value=='-1') {
					alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
					prefTimeFlt[1].focus();
					return false;
				}
			} else {
				depDateFwdFlt[1].value= "";
			}   
			 				    
		}
		
		if(f1.baggageFlt.value == "-1") {
			alert('<%=dbLabelBean.getLabel("alert.createrequest.selectcheckedbaggage",strsesLanguage)%>');
			f1.baggageFlt.focus();
			return false;
		} 
		
	}//Flight Details Check End
	
	//Train Details Check Start	
	if($('input:radio#trnRequired_Y').is(':checked')) {
		
		if(depCityFwdTrn[0].value=='' || depCityFwdTrn[0].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
			depCityFwdTrn[0].focus();
			return false;
		}	
		if(arrCityFwdTrn[0].value=='' || arrCityFwdTrn[0].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
			arrCityFwdTrn[0].focus();
			return false;
		}	
	    if(depDateFwdTrn[0].value=='' || depDateFwdTrn[0].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
			depDateFwdTrn[0].focus();
			return false;
		}	
	    
	    if (isDate(depDateFwdTrn[0].value)==false) {
	    	depDateFwdTrn[0].focus();
			return false;
		}
	    
	    if(prefTimeTrn[0].value=='-1') {			
			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>');
			prefTimeTrn[0].focus();
			return false;
		}	
	    
	    flag = validateDate(f1,todayDate,depDateFwdTrn[0].value,f1.todayDate,depDateFwdTrn[0].value,'<%=dbLabelBean.getLabel("alert.global.departuredateoffwdjourneynotsmallerthantodaydate",strsesLanguage)%>','no');
	    if(flag == false) {
	    	depDateFwdTrn[0].focus();
	    	return flag;
	    }
	    
		if(rowCountTrn >= 1) {
			for (var i = 1, len = rowCountTrn; i <= len; i++) {	
				if(depCityFwdTrn[i].value=='' || depCityFwdTrn[i].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
					alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
					depCityFwdTrn[i].focus();
					return false;
				}	
				if(arrCityFwdTrn[i].value=='' || arrCityFwdTrn[i].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
					arrCityFwdTrn[i].focus();
					return false;
				}	
			    if(depDateFwdTrn[i].value=='' || depDateFwdTrn[i].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
					depDateFwdTrn[i].focus();
					return false;
				}
			    
			    if (isDate(depDateFwdTrn[i].value)==false) {
			    	depDateFwdTrn[i].focus();
					return false;
				}
			    
			    if(prefTimeTrn[i].value=='-1') {			
					alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>');
					prefTimeTrn[i].focus();
					return false;
				}	
			}
			
			if(depCityFwdTrn[rowCountTrn+1].value != '' && depCityFwdTrn[rowCountTrn+1].value !='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
				if(arrCityFwdTrn[rowCountTrn+1].value=='' || arrCityFwdTrn[rowCountTrn+1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
					arrCityFwdTrn[rowCountTrn+1].focus();
					return false;
				}				
				if(depDateFwdTrn[rowCountTrn+1].value=='' || depDateFwdTrn[rowCountTrn+1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
					depDateFwdTrn[rowCountTrn+1].focus();
					return false;
				}  			    
			    if (isDate(depDateFwdTrn[rowCountTrn+1].value)==false) {
			    	depDateFwdTrn[rowCountTrn+1].focus();
					return false;
				}
			    if(prefTimeTrn[rowCountTrn+1].value=='-1') {			
					alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>');
					prefTimeTrn[rowCountTrn+1].focus();
					return false;
				}	
			} else {
				depCityFwdTrn[rowCountTrn+1].value="";
			}
			
			if(arrCityFwdTrn[rowCountTrn+1].value!= '' && arrCityFwdTrn[rowCountTrn+1].value!='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
				if(depCityFwdTrn[rowCountTrn+1].value=='' || depCityFwdTrn[rowCountTrn+1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
					alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
					depCityFwdTrn[rowCountTrn+1].focus();
					return false;
				}
				if(depDateFwdTrn[rowCountTrn+1].value=='' || depDateFwdTrn[rowCountTrn+1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
					depDateFwdTrn[rowCountTrn+1].focus();
					return false;
				} 			    
			    if (isDate(depDateFwdTrn[rowCountTrn+1].value)==false) {
			    	depDateFwdTrn[rowCountTrn+1].focus();
					return false;
				}
			    if(prefTimeTrn[rowCountTrn+1].value=='-1') {			
					alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>');
					prefTimeTrn[rowCountTrn+1].focus();
					return false;
				}
			} else {
				arrCityFwdTrn[rowCountTrn+1].value="";
			}
			
			if(depDateFwdTrn[rowCountTrn+1].value!= '' && depDateFwdTrn[rowCountTrn+1].value!='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
				if(depCityFwdTrn[rowCountTrn+1].value=='' || depCityFwdTrn[rowCountTrn+1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
					alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
					depCityFwdTrn[rowCountTrn+1].focus();
					return false;
				}
				if(arrCityFwdTrn[rowCountTrn+1].value=='' || arrCityFwdTrn[rowCountTrn+1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
					arrCityFwdTrn[rowCountTrn+1].focus();
					return false;
				}			
				if (isDate(depDateFwdTrn[rowCountTrn+1].value)==false) {
			    	depDateFwdTrn[rowCountTrn+1].focus();
					return false;
				}
				if(prefTimeTrn[rowCountTrn+1].value=='-1') {			
					alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>');
					prefTimeTrn[rowCountTrn+1].focus();
					return false;
				}
			} else {
				depDateFwdTrn[rowCountTrn+1].value= "";
			}    			
		    	   
		} else {
			if(depCityFwdTrn[1].value != '' && depCityFwdTrn[1].value !='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
				if(arrCityFwdTrn[1].value=='' || arrCityFwdTrn[1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
					arrCityFwdTrn[1].focus();
					return false;
				}				
				if(depDateFwdTrn[1].value=='' || depDateFwdTrn[1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
					depDateFwdTrn[1].focus();
					return false;
				}  			    
			    if (isDate(depDateFwdTrn[1].value)==false) {
			    	depDateFwdTrn[1].focus();
					return false;
				}
			    if(prefTimeTrn[1].value=='-1') {			
					alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>');
					prefTimeTrn[1].focus();
					return false;
				}
			} else {
				depCityFwdTrn[1].value="";
			}
			
			if(arrCityFwdTrn[1].value!= '' && arrCityFwdTrn[1].value!='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
				if(depCityFwdTrn[1].value=='' || depCityFwdTrn[1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
					alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
					depCityFwdTrn[1].focus();
					return false;
				}
				if(depDateFwdTrn[1].value=='' || depDateFwdTrn[1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
					depDateFwdTrn[1].focus();
					return false;
				} 			    
			    if (isDate(depDateFwdTrn[1].value)==false) {
			    	depDateFwdTrn[1].focus();
					return false;
				}
			    if(prefTimeTrn[1].value=='-1') {			
					alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>');
					prefTimeTrn[1].focus();
					return false;
				}
			} else {
				arrCityFwdTrn[1].value="";
			}
			
			if(depDateFwdTrn[1].value!= '' && depDateFwdTrn[1].value!='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
				if(depCityFwdTrn[1].value=='' || depCityFwdTrn[1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
					alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
					depCityFwdTrn[1].focus();
					return false;
				}
				if(arrCityFwdTrn[1].value=='' || arrCityFwdTrn[1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
					arrCityFwdTrn[1].focus();
					return false;
				}			
				if (isDate(depDateFwdTrn[1].value)==false) {
			    	depDateFwdTrn[1].focus();
					return false;
				}
				if(prefTimeTrn[1].value=='-1') {			
					alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>');
					prefTimeTrn[1].focus();
					return false;
				}
			} else {
				depDateFwdTrn[1].value= "";
			}	 
		}
		
		if($('input:radio#bhnRequired_Y').is(':checked')) {
			if(f1.bahnNo.value == "") {
				alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterbahncardnumber",strsesLanguage)%>');
				f1.bahnNo.focus();
				return false;
			}
			if(f1.bahnCardDisc.value == "-1") {
				alert('<%=dbLabelBean.getLabel("alert.global.pleaseselectdiscount",strsesLanguage)%>');
				f1.bahnCardDisc.focus();
				return false;
			}
			if(f1.bahnCardValidDate.value == "") {
				alert('<%=dbLabelBean.getLabel("alert.global.pleaseentervaliditydate",strsesLanguage)%>');
				f1.bahnCardValidDate.focus();
				return false;
			} else {
				flag =  isDate(f1.bahnCardValidDate.value);
				if(flag == false) {
					f1.bahnCardValidDate.focus();
				  	return flag; 
				}
				
				flag =  validateDate(f1,todayDate,f1.bahnCardValidDate.value,f1.todayDate,f1.bahnCardValidDate.value,'<%=dbLabelBean.getLabel("alert.global.validitydatecannotsmallerthantodaydate",strsesLanguage)%>','no');
				if(flag == false) {
					f1.bahnCardValidDate.focus();
				  	return flag; 
				}
			}
			
			if(!$('input:radio#sparzugRequired_Y').is(":checked") && !$('input:radio#sparzugRequired_N').is(":checked")) {
				alert('<%=dbLabelBean.getLabel("alert.global.pleasespecifysparpreismitzugbindung",strsesLanguage)%>');
				return false;
			}
		}
		
	}//Train Details Check End
	
	
	//Rent A Car Check Start
	if($('input:radio#rentCarRequired_Y').is(':checked')) {	
		if(rowCountCar == 1) {
			if(startDate[0].value == '' || startDate[0].value == '<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%>'){
				alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterstartdate",strsesLanguage)%>');
				startDate[0].focus();
				return false;
			} else {
				flag =  isDate(startDate[0].value);
				if(flag == false) {
					startDate[0].focus();
				  	return flag; 
				}
			}			
			if(startTime[0].value == '-1'){
				alert('<%=dbLabelBean.getLabel("alert.createrequest.rentcarstartTimerequired",strsesLanguage)%>');
				startTime[0].focus();
				return false;
			} 
			if(startCity[0].value == "" || startCity[0].value == "<%=dbLabelBean.getLabel("label.global.startcity",strsesLanguage)%>") {
				alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterstartcity",strsesLanguage)%>');
				startCity[0].focus();
				return false;
			} 
			if(carReservationClass == '26' && startLocation[0].value == "4" && (startMobileNo[0].value == "" || startMobileNo[0].value == "<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>")) {
				alert('<%=dbLabelBean.getLabel("alert.global.pleaseentermobilenoforrentacar",strsesLanguage)%>');
				startMobileNo[0].focus();
				return false;
			}
			if((carReservationClass == '27' || carReservationClass == '29') && (startRouting[0].value == "" || startRouting[0].value == "<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage)%>")) {
				alert('<%=dbLabelBean.getLabel("alert.global.routing",strsesLanguage)%>');
				startRouting[0].focus();
				return false;
			}
			if(endDate[0].value == '' || endDate[0].value == '<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%>'){
				alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterenddate",strsesLanguage)%>');
				endDate[0].focus();
				return false;
			}else {
				flag =  isDate(endDate[0].value);
				if(flag == false) {
					endDate[0].focus();
				  	return flag; 
				}
			}			
			if(endTime[0].value == '-1'){
				alert('<%=dbLabelBean.getLabel("alert.createrequest.rentcarendTimerequired",strsesLanguage)%>');
				endTime[0].focus();
				return false;
			} 
			if(endCity[0].value == "" || endCity[0].value == "<%=dbLabelBean.getLabel("label.global.endcity",strsesLanguage)%>") {
				alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterendcity",strsesLanguage)%>');
				endCity[0].focus();
				return false;
			}			
			if(carReservationClass == '26' && endLocation[0].value == "4" && (endMobileNo[0].value == "" || endMobileNo[0].value == "<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>")) {
				alert('<%=dbLabelBean.getLabel("alert.global.pleaseentermobilenoforrentacar",strsesLanguage)%>');
				endMobileNo[0].focus();
				return false;
			}
			if((carReservationClass == '27' || carReservationClass == '29') && (endRouting[0].value == "" || endRouting[0].value == "<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage)%>")) {
				alert('<%=dbLabelBean.getLabel("alert.global.routing",strsesLanguage)%>');
				endRouting[0].focus();
				return false;
			}
		} else if(rowCountCar > 1) {
			for (var i = 0, len = rowCountCar; i < len; i++) {	
				if(startDate[i].value == '' || startDate[i].value == '<%=dbLabelBean.getLabel("label.global.startdate",strsesLanguage)%>'){
					alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterstartdate",strsesLanguage)%>');
					startDate[i].focus();
					return false;
				} else {
					flag =  isDate(startDate[i].value);
					if(flag == false) {
						startDate[i].focus();
					  	return flag; 
					}
				}			
				if(startTime[i].value == '-1'){
					alert('<%=dbLabelBean.getLabel("alert.createrequest.rentcarstartTimerequired",strsesLanguage)%>');
					startTime[i].focus();
					return false;
				} 
				if(startCity[i].value == "" || startCity[i].value == "<%=dbLabelBean.getLabel("label.global.startcity",strsesLanguage)%>") {
					alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterstartcity",strsesLanguage)%>');
					startCity[i].focus();
					return false;
				} 
				if(carReservationClass == '26' && startLocation[i].value == "4" && (startMobileNo[i].value == "" || startMobileNo[i].value == "<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>")) {
					alert('<%=dbLabelBean.getLabel("alert.global.pleaseentermobilenoforrentacar",strsesLanguage)%>');
					startMobileNo[i].focus();
					return false;
				}
				if((carReservationClass == '27' || carReservationClass == '29') && (startRouting[i].value == "" || startRouting[i].value == "<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage)%>")) {
					alert('<%=dbLabelBean.getLabel("alert.global.routing",strsesLanguage)%>');
					startRouting[i].focus();
					return false;
				}
				if(endDate[i].value == '' || endDate[i].value == '<%=dbLabelBean.getLabel("label.global.enddate",strsesLanguage)%>'){
					alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterenddate",strsesLanguage)%>');
					endDate[i].focus();
					return false;
				}else {
					flag =  isDate(endDate[i].value);
					if(flag == false) {
						endDate[i].focus();
					  	return flag; 
					}
				}			
				if(endTime[i].value == '-1'){
					alert('<%=dbLabelBean.getLabel("alert.createrequest.rentcarendTimerequired",strsesLanguage)%>');
					endTime[i].focus();
					return false;
				} 
				if(endCity[i].value == "" || endCity[i].value == "<%=dbLabelBean.getLabel("label.global.endcity",strsesLanguage)%>") {
					alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterendcity",strsesLanguage)%>');
					endCity[i].focus();
					return false;
				}			
				if(carReservationClass == '26' && endLocation[i].value == "4" && (endMobileNo[i].value == "" || endMobileNo[i].value == "<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>")) {
					alert('<%=dbLabelBean.getLabel("alert.global.pleaseentermobilenoforrentacar",strsesLanguage)%>');
					endMobileNo[i].focus();
					return false;
				}
				if((carReservationClass == '27' || carReservationClass == '29') && (endRouting[i].value == "" || endRouting[i].value == "<%=dbLabelBean.getLabel("label.global.routing",strsesLanguage)%>")) {
					alert('<%=dbLabelBean.getLabel("alert.global.routing",strsesLanguage)%>');
					endRouting[i].focus();
					return false;
				}
			}
		}
	} //Rent A Car Check End
	
	//Accomodation Check Start
	if($('input:radio#accomodationRequired_Y').is(':checked')) {
		if(rowCountAcm == 1) {
			if(hotel[0].value == "1" || hotel[0].value=="2") {				
				if(cityAddress[0].value == "" || cityAddress[0].value == "<%=dbLabelBean.getLabel("label.global.cityandaddress",strsesLanguage)%>") {
					alert('<%=dbLabelBean.getLabel("alert.global.pleaseentercityandaddress",strsesLanguage)%>');
					cityAddress[0].focus();
					return false;
				}							
				if(checkinDate[0].value == "" || checkinDate[0].value == "<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>") {
					alert('<%=dbLabelBean.getLabel("alert.global.checkindate",strsesLanguage)%>');
					checkinDate[0].focus();
					return false;
				}	
				if(checkoutDate[0].value == "" || checkoutDate[0].value == "<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>") {
					alert('<%=dbLabelBean.getLabel("alert.global.checkoutdate",strsesLanguage)%>');
					checkoutDate[0].focus();
					return false;
				}
				if(isDate(checkinDate[0].value)==false) {
					checkinDate[0].focus();
		    		return false;
		    	}				
				if(isDate(checkoutDate[0].value)==false) {
					checkoutDate[0].focus();
		    		return false;
		    	}
				flag =  validateDate(f1,todayDate,checkinDate[0].value,f1.todayDate,checkinDate[0].value,'<%=dbLabelBean.getLabel("alert.global.checkindatecannotsmallerthantodaydate",strsesLanguage)%> ','no');
				if(flag == false) {
					checkinDate[0].focus();
				  	return flag; 
				}				
				flag =  validateDate(f1,todayDate,checkoutDate[0].value,f1.todayDate,checkoutDate[0].value,'<%=dbLabelBean.getLabel("alert.global.checkoutdatecannotsmallerthantodaydate",strsesLanguage)%>','no');
				if(flag == false) {
					f1.checkout.focus();
				  	return flag; 
				}				
				flag =  validateDate(f1,checkinDate[0].value,checkoutDate[0].value,checkinDate[0].value,checkoutDate[0].value,'<%=dbLabelBean.getLabel("alert.global.checkoutdatecannotsmallerthancheckindate",strsesLanguage)%>','no');
				if(flag == false) {
					checkoutDate[0].focus();
				  	return flag; 
				}		
			}
		} else if(rowCountAcm > 1) {
			for (var i = 0, len = rowCountAcm; i < len; i++) {	
				if(hotel[i].value == "1" || hotel[i].value=="2") {										
					if(cityAddress[i].value == "" || cityAddress[i].value == "<%=dbLabelBean.getLabel("label.global.cityandaddress",strsesLanguage)%>") {
						alert('<%=dbLabelBean.getLabel("alert.global.pleaseentercityandaddress",strsesLanguage)%>');
						cityAddress[i].focus();
						return false;
					}										
					if(checkinDate[i].value == "" || checkinDate[i].value == "<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>") {
						alert('<%=dbLabelBean.getLabel("alert.global.checkindate",strsesLanguage)%>');
						checkinDate[i].focus();
						return false;
					}		
					if(checkoutDate[i].value == "" || checkoutDate[i].value == "<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>") {
						alert('<%=dbLabelBean.getLabel("alert.global.checkoutdate",strsesLanguage)%>');
						checkoutDate[i].focus();
						return false;
					}					
					if(isDate(checkinDate[i].value)==false) {
						checkinDate[i].focus();
			    		return false;
			    	}				
					if(isDate(checkoutDate[i].value)==false) {
						checkoutDate[i].focus();
			    		return false;
			    	}
					flag =  validateDate(f1,todayDate,checkinDate[i].value,f1.todayDate,checkinDate[i].value,'<%=dbLabelBean.getLabel("alert.global.checkindatecannotsmallerthantodaydate",strsesLanguage)%> ','no');
					if(flag == false) {
						checkinDate[i].focus();
					  	return flag; 
					}					
					flag =  validateDate(f1,todayDate,checkoutDate[i].value,f1.todayDate,checkoutDate[i].value,'<%=dbLabelBean.getLabel("alert.global.checkoutdatecannotsmallerthantodaydate",strsesLanguage)%>','no');
					if(flag == false) {
						f1.checkout.focus();
					  	return flag; 
					}					
					flag =  validateDate(f1,checkinDate[i].value,checkoutDate[i].value,checkinDate[i].value,checkoutDate[i].value,'<%=dbLabelBean.getLabel("alert.global.checkoutdatecannotsmallerthancheckindate",strsesLanguage)%>','no');
					if(flag == false) {
						checkoutDate[i].focus();
					  	return flag; 
					}		
				}
			}
		}
	}
	//Accomodation Check End
	
	if(f1.remarksFlt.value == "<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>") {
		f1.remarksFlt.value = "";
	}
	if(f1.remarksTrn.value == "<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>") {
		f1.remarksTrn.value = "";
	}
	if(f1.remarksCar.value == "<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>") {
			f1.remarksCar.value = "";
	}	
	if(f1.otherComment.value=="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>") { 
		f1.otherComment.value = "";
	}

	$('form#frmId').find('[placeholder]').each(function() {
		var input = $(this);
		if (input.val() == input.attr('placeholder')) {
			input.val('');
		}
	});	
	
	var text=f1.approverlist.value;
	if(text!='') {
		text="Currently "+text;   
	}		
	
	if(actionFlag == "saveProceed") {
		if(confirm(text+'<%=dbLabelBean.getLabel("alert.global.submittoworkflow",strsesLanguage)%>'))  {
			f1.whatAction.value=actionFlag;
			f1.saveandexit.disabled=true;
			f1.save.disabled=true;
			f1.saveproceed.disabled=true;
			openWaitingProcess();
			$(window).scrollTop(0);
			f1.submit();	
			return true;
		} else {
			f1.saveandexit.disabled=false;
			f1.save.disabled=false;
			f1.saveproceed.disabled=false;
			return false;
		}		
	}
	
	f1.whatAction.value=actionFlag;	
	f1.saveandexit.disabled=true;
	f1.save.disabled=true;
	f1.saveproceed.disabled=true;
	openWaitingProcess();
	$(window).scrollTop(0);
	f1.submit();	
	return true;
}
</script>
<script type="text/javascript">
var chkReadyState = setInterval(function() {
    if (document.readyState == "complete") {
        clearInterval(chkReadyState);
        
        var costCenterName = document.getElementById("costCenterName").value;
    	if(costCenterName == "") {
    		alert('Please update cost centre in your profile from "My Links -> Update Profile" page before create travel request.');			
    	}
    	
       	if("true" == '<%=msgFlag%>') {
       		closeDivRequest();
       		alert('<%=strMessage%>');
       	}
    }
}, 2000);	
</script>