<!DOCTYPE html>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.util.Map.Entry"%>
<%@ include  file="application.jsp" %>
<%@ page import = "java.sql.*" pageEncoding="UTF-8"%>
<%@ page import="src.enumTypes.TravelRequestEnums" %>
<%@ page import="src.dao.T_QuicktravelRequestDaoImpl" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean2" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean3" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean4" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean5" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />

<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<title>Group/Guest Travel Request</title>

<link href="style/quick-travel-style-mata.css?buildstamp=2_0_0" rel="stylesheet" media="all" type="text/css"/>
<link href="style/jquery-ui-1.9.2.css?buildstamp=2_0_0" rel="stylesheet" type="text/css"/>
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
	if(navigator.appVersion.indexOf("MSIE 10") !== -1) {
		document.write("<meta http-equiv='X-UA-Compatible' content='IE=EmulateIE9'>");
	}
</script>

<%
T_QuicktravelRequestDaoImpl dao = new T_QuicktravelRequestDaoImpl();
Set entrySet = null;
Iterator it = null;
TravelRequestEnums.PreferredTimeTypes [] types = null;
TravelRequestEnums.LocationsMataIndia[] locations = null;
int t = 0;
//Global Variables declared and initialized
request.setCharacterEncoding("UTF-8");
String strSql, strSql2          		=  "";              // String for Sql String
ResultSet rs,rs1,rsForex,rsAccom  		=  null;              // Object for ResultSet
ResultSet rsFlt1,rsFlt2,rsFlt3	 		=  null;              // Object for ResultSet
ResultSet rsTrn1,rsTrn2,rsTrn3	 		=  null;              // Object for ResultSet
ResultSet rsCar1,rsCar2,rsCar3	 		=  null;              // Object for ResultSet
ResultSet rsGroupGuest1,rsGroupGuest2	=  null;              // Object for ResultSet

String strSiteId="", strUserId="", strGUserId="", strMealId="", strCostCentre="0", strReasonForTravel="";

int intSerialNo = 1;
String strTravelAgencyId = "1";
String strGroupTravelFlag = "Y";		
//Group/Guest Trevller Details
String strGrpTrvUserId="", strGrpTrvFirstName="", strGrpTrvLastName="", strGrpTrvDesign="-1", strGrpTrvDOB="", strGrpTrvAge="", strGrpTrvGender="-1", strGrpTrvMealPref="6", strGrpTrvIdentityProof="", strGrpTrvIdentityProofNo="", strGrpTrvMobileNo="", strGrpTrvPassportNo="", strGrpTrvNationality="", strGrpTrvPasprtIssuePlace="", strGrpTrvPasprtIssueDate="", strGrpTrvPasprtExpiryDate="", strGrpTrvVisaRequired="2", strGrpTrvEcrRequired="2";
String strGrpTrvEmailAddress = "", strGrpTrvEmpId = "";

//Group/Guest Trevller(s) List Details
String strTrvUserId="", strFirstNameList="", strLastNameList="", strDesignList="", strDOBList="", strAgeList="", strGenderList="", strMealPrefList="", strIdentityProofList="", strIdentityProofNoList="", strMobileNoList="", strPassportNoList="", strNationalityList="", strPasprtIssuePlaceList="", strPasprtIssueDateList="", strPasprtExpiryDateList="", strVisaRequiredList="", strEcrRequiredList="", strSex="", strVisaReq="", strEcrReq="", strTotalForexList="", strCurrency="", strGrpTrvReturnTravel="", strchecked="";
String strGrpTrvEmailAddressList = "", strGrpTrvEmpIdList = "";

//Flight Details
String strTravelModeFlt="", strDepCityFwdFlt="", strArrCityFwdFlt="", strDepDateFwdFlt="", strPreferTimeModeFwdFlt="", strPreferTimeFwdFlt="", strTravelClassFwdFlt="", strPreferAirlineFwdFlt="", strPreferSeatFwdFlt="", strNonRefundableTktFwdFlt="n", strDepCityRetFlt="", strArrCityRetFlt="", strDepDateRetFlt="", strPreferTimeModeRetFlt="", strPreferTimeRetFlt="", strTravelClassRetFlt="", strPreferAirlineRetFlt="",  strPreferSeatRetFlt="", strNonRefundableTktRetFlt="n", strDepCityIntrmiFlt="", strArrCityIntrmiFlt="", strDepDateIntrmiFlt="", strPreferTimeModeIntrmiFlt="", strPreferTimeIntrmiFlt="", strTravelClassIntrmiFlt="", strPreferAirlineIntrmiFlt="", strPreferSeatIntrmiFlt="", strNonRefundableTktIntrmiFlt="n", strRemarkFlt="";

//Train Details
String strTravelModeTrn="", strDepCityFwdTrn="", strArrCityFwdTrn="", strDepDateFwdTrn="", strPreferTimeModeFwdTrn="", strPreferTimeFwdTrn="", strTravelClassFwdTrn="", strPreferAirlineFwdTrn="", strPreferSeatFwdTrn="", strTatkalTicketReqFwdTrn="0", strDepCityRetTrn="", strArrCityRetTrn="", strDepDateRetTrn="", strPreferTimeModeRetTrn="", strPreferTimeRetTrn="", strTravelClassRetTrn="", strPreferAirlineRetTrn="",  strPreferSeatRetTrn="", strTatkalTicketReqRetTrn="0", strDepCityIntrmiTrn="", strArrCityIntrmiTrn="", strDepDateIntrmiTrn="", strPreferTimeModeIntrmiTrn="", strPreferTimeIntrmiTrn="", strTravelClassIntrmiTrn="", strPreferAirlineIntrmiTrn="", strPreferSeatIntrmiTrn="", strRemarkTrn="";

//Car Details
String strTravelModeCar="", strCarClassType="16", strCarCategory="", strTravelIdFwdCar="", strDepCityFwdCar="", strArrCityFwdCar="", strDepDateFwdCar="", strPreferTimeModeFwdCar="", strPreferTimeFwdCar="", strLocationFwdCar="", strMobileFwdCar="", strTravelIdRetCar="", strDepCityRetCar="", strArrCityRetCar="", strDepDateRetCar="", strPreferTimeModeRetCar="", strPreferTimeRetCar="", strLocationRetCar="", strMobileRetCar="", strTravelIdIntrmiCar="", strDepCityIntrmiCar="", strArrCityIntrmiCar="", strDepDateIntrmiCar="", strPreferTimeModeIntrmiCar="", strPreferTimeIntrmiCar="", strLocationIntrmiCar="", strMobileIntrmiCar="", strRemarkCar="";

//Accommodation Details
String strAccId="", strHotelRequired="", strBudgetCurrency="", strHotelBudget="", strCheckin="", strCheckout="", strPlace="", strRemarks="";

//Approver Details
String strManager="", strHod="", strBoardMember="", strBillingSite="", strBillingClient="", strHidAppFlag="", strHidAppShowBMFlag="", strReasonForSkip="";

//Travel Expenditure Details 
String strExpID="", strTACurrency="", strTACurrency2="USD", strEntPerDay="", strTotalTourDay="", strEntPerDay2="", strTotalTourDay2="", strContingecies="", strContingecies2="", strTotalForex="", strExRate="", strTotalINR="", strTotalAmount="", strExpenditureRemarks="", strTotalFareCurrency="", strTotalFareAmount="";

String dbl_YTM_BUDGET="", dbl_YTD_ACTUAL="", dbl_AVAIL_BUDGET="", dbl_EST_EXP="", str_EXP_REMARKS="";

String strTkAgent="", strTkAirLine="", 	strTkcurrency="", strTklocalprice="", strTkRemarks=""; 

//Travel Request Details
String strTravelReqId="", strTravelId="", strTravelReqNo="", strIntermiId="", strTravllerSiteId="", strTravellerId="", strTravelType="", strReturnType="", strCancelledReqId="0";

String strFlag="", strRec="no", msgFlag="", strAppLvl3flg="", strAppLvl3flgforBM="", strMandatatoryApvFlag="", strShowflag="n", strShowCancelledRegflag="n", strSHOW_BUD_INPUT="N";

String strMessage = "false", flightYNFlag = "false", trainYNFlag = "false", carYNFlag = "false", accomYNFlag = "false", forexYNFlag = "false", strGrpTrvExists="false"; 

String strforPriceDesicionDom="", strforPriceDesicionInt="";

String strApproverid = "", ApproverText = "", strname1 = "", strname2 = "";

String strDepDate="", strwhatAction="";

strSql = "";
strSql2 = "";

strSiteId                       		=  strSiteIdSS;  
strUserId                       		=  Suser_id;
strMessage                      		=  request.getParameter("message");
strTravelId                     		=  request.getParameter("travelId");
strTravelReqNo                  		=  request.getParameter("travelReqNo");
strTravelReqId							=  request.getParameter("travelReqId");
strTravellerId							=  request.getParameter("travellerId");
strTravelType 							=  request.getParameter("travel_type");
strIntermiId							=  request.getParameter("interimId")== null ? "" : request.getParameter("interimId");
strGUserId								=  request.getParameter("G_userId")==null ? "" : request.getParameter("G_userId");
strwhatAction                           =  request.getParameter("action")==null ? "" : request.getParameter("action");	

Date currentDate = new Date();
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
String strCurrentDate = (sdf.format(currentDate)).trim();

if(strMessage != null && strMessage.equalsIgnoreCase("save")) {
	msgFlag	 = "true";
    strMessage = dbLabelBean.getLabel("message.global.infosavesuccessfully",strsesLanguage);
} else if(strMessage != null && strMessage.equalsIgnoreCase("not Save")) {
	msgFlag	 = "true";
    strMessage = dbLabelBean.getLabel("message.master.erroroccuredhencecouldnotbesaved",strsesLanguage);
} else if(strMessage != null && strMessage.equalsIgnoreCase("approvernotexists")) {
	msgFlag	 = "true";
    strMessage = "Could not Submit to Workflow, Please select at least one Approver from Approver Level-1 or Approver Level-2.";
} else if(strMessage != null && strMessage.equalsIgnoreCase("travellerAdded")) {
	msgFlag	 = "true";
    strMessage = dbLabelBean.getLabel("message.createrequest.useradded",strsesLanguage);
} else if(strMessage != null && strMessage.equalsIgnoreCase("travellerAddedFailed")) {
	msgFlag	 = "true";
    strMessage = dbLabelBean.getLabel("message.createrequest.useraddedfailed",strsesLanguage);
} else if(strMessage != null && strMessage.equalsIgnoreCase("travellerUpdated")) {
	msgFlag	 = "true";
    strMessage = dbLabelBean.getLabel("message.global.updatedsuccessfully",strsesLanguage);
} else {
	msgFlag	 = "false";
    strMessage = ""; 
}

//Get Base Currency
String strBaseCur="INR";
String baseCurr = dao.getBaseCurrency(strSiteId);
if(baseCurr != null) {
	strBaseCur = baseCurr;
}

//Get Approval Level 3/Board Member Flag
String strAppLvl3flgFromDB = dao.getAppLvl3Flag(Suser_id);
if(strAppLvl3flgFromDB!=null) {
	strAppLvl3flg=strAppLvl3flgFromDB;
}

//Get Unit Head Flag
String strUnit_Head="0";
String strUnitHeadFromDB = dao.getUnitHeadFlag(strUserId, strSiteId);
if(strUnitHeadFromDB != null) {
	strUnit_Head = strUnitHeadFromDB;
}

//Get Cost Centre Flag
String strShowFlagFromDB = dao.getCostCentreFlag(strSiteId);
if(strShowFlagFromDB != null) {
	strShowflag= strShowFlagFromDB;
}

//Get Approval Level 3 for Board Member Flag
String strAppLvl3flgforBMFromDB = dao.getAppLvl3flgforBM(strSiteId);
if(strAppLvl3flgforBMFromDB != null) {
	strAppLvl3flgforBM = strAppLvl3flgforBMFromDB;
}

//Get Mandatatory Approver Flag
String strMandatatoryApvFlagFromDB = dao.getManadatoryAppFlag(strSiteId);
if(strMandatatoryApvFlagFromDB != null) {
	strMandatatoryApvFlag = strMandatatoryApvFlagFromDB;
}

//Get Budget Flag
String strSHOW_BUD_INPUTFromDB = dao.getShowBudgetFlag(strSiteId);
if(strSHOW_BUD_INPUTFromDB != null) {
	strSHOW_BUD_INPUT = strSHOW_BUD_INPUTFromDB;
}

//Get Price Desicion for Dom
String strforPriceDesicionDomFromDB = dao.getPriceDesicionForDom(strSiteId);
if(strforPriceDesicionDomFromDB != null) {
	strforPriceDesicionDom = strforPriceDesicionDomFromDB;
}

//Get Price Desicion for Int
String strforPriceDesicionIntFromDB = dao.getPriceDesicionForInt(strSiteId);
if(strforPriceDesicionIntFromDB != null) {
	strforPriceDesicionInt = strforPriceDesicionIntFromDB;
}

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new Date());
String strExchRate="0.000000";
boolean exchRateExistsFlag = true;
if(strBaseCur!=null && !strBaseCur.equals("")) {
	strSql="SELECT DBO.FN_GET_EXCHANGE_RATE('"+ strBaseCur +"','"+ formattedDate +"') AS EXCHANGE_RATE";
	rs=null;
	rs = dbConBean.executeQuery(strSql);
	if(rs.next()) {
		if(rs.getString("EXCHANGE_RATE")==null) {
			exchRateExistsFlag  = false;
			strExchRate 		= "0.000000";
		} else {
			exchRateExistsFlag  = true;
			strExchRate 		= rs.getString("EXCHANGE_RATE").trim();
		}
	}
	rs.close();
}

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
		strSql = "select top 1 approver_id  from T_approvers  where travel_id ="+strTravelId+ " and travel_type='d' and status_id=10 order by order_id ";
		
	} else if(strTravelType.equals("I")) { 	
		strSql = "select top 1 approver_id  from T_approvers  where travel_id ="+strTravelId+ " and travel_type='i' and status_id=10 order by order_id ";
	
	}
	
	rs=null;
	rs = dbConBean.executeQuery(strSql);
	while (rs.next()) {
		strApproverid = rs.getString(1);
		strSql = "select dbo.user_name(" + strApproverid + "),dbo.user_name(dbo.finalooo(" + strApproverid + ",getdate(),'i'))";
		rs1 = dbConBean1.executeQuery(strSql);

		while (rs1.next()) {
			strname2 = rs1.getString(1);
			strname1 = rs1.getString(2).trim();
			if (!strname1.equals("-")) {
				ApproverText = ApproverText + strname2
						+ " "+dbLabelBean.getLabel("alert.createrequest.hasdelegatedhisauthorityto",strsesLanguage)+" " 
						+ strname1 + ".\n ";
			}
		}
		rs1.close();
	}
	rs.close();
	
	if(strTravelType.equals("D")) {
		strSql = "SELECT LTRIM(RTRIM(TD.SITE_ID)) AS SITE_ID,LTRIM(RTRIM(TD.TRAVEL_REQ_ID)) as TRAVEL_REQ_ID,LTRIM(RTRIM(TD.TRAVELLER_ID)) AS TRAVELLER_ID, LTRIM(RTRIM(TD.MEAL)) AS MEAL, MANAGER_ID, HOD_ID, ISNULL(.DBO.CONVERTDATEDMY1(TD.TRAVEL_DATE),'') AS TRAVEL_DATE,LTRIM(RTRIM(TD.TRANSIT_TYPE)) AS TRANSITTYPE,  ISNULL(TD.TRANSIT_BUDGET,'') AS BUDGET,LTRIM(RTRIM(BUDGET_CURRENCY)) AS BUDGET_CURRENCY,TD.PLACE AS PLACE,  ISNULL(.DBO.CONVERTDATEDMY1(TD.CHECK_IN_DATE),'') AS CHECKINDATE,ISNULL(.DBO.CONVERTDATEDMY1(TD.CHECK_OUT_DATE),'') AS CHECKOUTDATE,LTRIM(RTRIM(TD.REMARKS)) AS REMARKS,ISNULL(TD.REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL,ISNULL(TD.REASON_FOR_SKIP,'') AS REASON_FOR_SKIP, TD.BOARD_MEMBER_ID,TD.CC_ID, ISNULL(TD.IDENTITY_PROOFNO,'') AS IDENTITY_PROOFNO, ISNULL(TD.IDENTITY_PROOF,'0') AS IDENTITY_PROOF, TS.LINKED_TRAVEL_ID, ISNULL(TD.FLIGHT_REMARKS,'') AS FLIGHT_REMARKS, ISNULL(TD.TRAIN_REMARKS,'') AS TRAIN_REMARKS, ISNULL(TD.CAR_REMARKS,'') AS CAR_REMARKS FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_DOM TD (NOLOCK) ON TS.TRAVEL_ID=TD.TRAVEL_ID AND TS.TRAVEL_TYPE='D' WHERE TD.TRAVEL_ID="+strTravelId+" AND TD.APPLICATION_ID=1 AND TD.STATUS_ID=10"; 
		rs = dbConBean.executeQuery(strSql);
		if (rs.next()) {			
			strTravelReqId				= rs.getString("TRAVEL_REQ_ID");
			strSiteId					= rs.getString("SITE_ID");
			strUserId					= rs.getString("TRAVELLER_ID");
			strDepDate					= rs.getString("TRAVEL_DATE");
			strManager            		= rs.getString("MANAGER_ID");
			strHod             		    = rs.getString("HOD_ID");
			strBoardMember				= rs.getString("BOARD_MEMBER_ID");
			strReasonForSkip			= rs.getString("REASON_FOR_SKIP");
			strReasonForTravel      	= rs.getString("REASON_FOR_TRAVEL"); 			
			strRemarks           		= rs.getString("REMARKS"); 
			strCostCentre		 		= rs.getString("CC_ID");	
			strCancelledReqId 			= rs.getString("LINKED_TRAVEL_ID");
			strRemarkFlt          		= rs.getString("FLIGHT_REMARKS");
			strRemarkTrn          		= rs.getString("TRAIN_REMARKS");
			strRemarkCar				= rs.getString("CAR_REMARKS");
			
			if(strCostCentre==null) {
				strCostCentre="0";
			}
		}					
		rs.close();		
	}
	else if(strTravelType.equals("I")) {
		strSql = "SELECT TD.TRAVEL_REQ_ID, TD.SITE_ID, TD.TRAVELLER_ID,AGE,SEX,TD.MEAL,VISA_REQUIRED,VISA_COMMENT, DBO.CONVERTDATEDMY1(TD.TRAVEL_DATE)AS TRAVEL_DATE, INSURANCE_REQUIRED,NOMINEE, RELATION, INSURANCE_COMMENTS, HOTEL_REQUIRED,RTRIM(LTRIM(BUDGET_CURRENCY))AS BUDGET_CURRENCY , ISNULL(HOTEL_BUDGET,'') AS HOTEL_BUDGET, REMARKS,  DBO.CONVERTDATEDMY1(CHECK_IN_DATE)AS CHECK_IN_DATE, DBO.CONVERTDATEDMY1(CHECK_OUT_DATE)AS CHECK_OUT_DATE,   RTRIM(LTRIM(APPROVER_SELECTION)) AS APPROVER_SELECTION, MANAGER_ID,HOD_ID,  LTRIM(RTRIM(ISNULL(CARD_TYPE,''))) AS CARD_TYPE,LTRIM(RTRIM(ISNULL(CARD_NUMBER1,''))) AS CARD_NUMBER1,LTRIM(RTRIM(ISNULL(CARD_NUMBER2,''))) AS CARD_NUMBER2 ,LTRIM(RTRIM(ISNULL(CARD_NUMBER3,''))) AS CARD_NUMBER3, LTRIM(RTRIM(ISNULL(CARD_NUMBER4,''))) AS CARD_NUMBER4 ,LTRIM(RTRIM(ISNULL(CVV_NUMBER,''))) AS CVV_NUMBER,LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CARD_EXP_DATE),''))) AS CARD_EXP_DATE,ISNULL(REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL,ISNULL(REASON_FOR_SKIP,'') AS REASON_FOR_SKIP, ISNULL(PLACE,'') AS  PLACE, ISNULL(CARD_HOLDER_NAME,'') AS CARD_HOLDER_NAME,BOARD_MEMBER_ID,CC_ID, TS.LINKED_TRAVEL_ID, ISNULL(TD.FLIGHT_REMARKS,'') AS FLIGHT_REMARKS, ISNULL(TD.TRAIN_REMARKS,'') AS TRAIN_REMARKS, ISNULL(TD.CAR_REMARKS,'') AS CAR_REMARKS FROM  T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_INT TD (NOLOCK) ON TS.TRAVEL_ID=TD.TRAVEL_ID AND TS.TRAVEL_TYPE='I' WHERE TD.TRAVEL_ID="+strTravelId+" AND TD.APPLICATION_ID=1 AND TD.STATUS_ID=10";
	  	rs       =   dbConBean.executeQuery(strSql);  
		if(rs.next()) {
			strTravelReqId       		= rs.getString("TRAVEL_REQ_ID");
			strSiteId            		= rs.getString("SITE_ID");
			strUserId            		= rs.getString("TRAVELLER_ID");
		    strDepDate        			= rs.getString("TRAVEL_DATE");
			strManager           		= rs.getString("MANAGER_ID");
			strHod               		= rs.getString("HOD_ID");
		    strBoardMember		 		= rs.getString("BOARD_MEMBER_ID");
			strReasonForSkip     		= rs.getString("REASON_FOR_SKIP");
			strReasonForTravel   		= rs.getString("REASON_FOR_TRAVEL");
			strRemarks           		= rs.getString("REMARKS");	
			strCostCentre		 		= rs.getString("CC_ID");
			strCancelledReqId 			= rs.getString("LINKED_TRAVEL_ID");
			strRemarkFlt          		= rs.getString("FLIGHT_REMARKS");
			strRemarkTrn          		= rs.getString("TRAIN_REMARKS");
			strRemarkCar				= rs.getString("CAR_REMARKS");
			
			if(strCostCentre==null) {
				strCostCentre="0";
			}				
		}
		rs.close();
	}
		
	if(strTravelType.equals("D")) {
		strSql = "SELECT BILLING_SITE,BILLING_CLIENT,RTRIM(LTRIM(convert(decimal(20,2),TOTAL_AMOUNT))) AS TOTAL_AMOUNT, RTRIM(LTRIM(TA_CURRENCY)) AS TA_CURRENCY, RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE))) AS TRAVELLER_CHEQUE, RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE1))) AS TRAVELLER_CHEQUE1, RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE2))) AS TRAVELLER_CHEQUE2, RTRIM(LTRIM(TC_CURRENCY)) AS TC_CURRENCY,RTRIM(LTRIM(TC_CURRENCY1)) AS TC_CURRENCY1,RTRIM(LTRIM(TC_CURRENCY2)) AS TC_CURRENCY2, EXPENDITURE_REMARKS, CASH_BREAKUP_REMARKS, TRAVEL_REQ_ID, SITE_ID,TK_PROVIDER_FLAG,TK_AIRLINE_NAME,TK_CURRENCY,TK_AMOUNT,TK_REMARKS , "
				+ " YTM_BUDGET , YTD_ACTUAL , AVAIL_BUDGET , EST_EXP , EXP_REMARKS,FARE_CURRENCY,FARE_AMOUNT"
				+ " FROM T_TRAVEL_DETAIL_DOM WHERE TRAVEL_ID="
				+ strTravelId + " AND APPLICATION_ID=1 AND STATUS_ID=10";
	}
	else if(strTravelType.equals("I")) {
		strSql = "SELECT BILLING_SITE,BILLING_CLIENT,RTRIM(LTRIM(convert(decimal(20,2),TOTAL_AMOUNT))) AS TOTAL_AMOUNT, RTRIM(LTRIM(TA_CURRENCY)) AS TA_CURRENCY, RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE))) AS TRAVELLER_CHEQUE, RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE1))) AS TRAVELLER_CHEQUE1, RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE2))) AS TRAVELLER_CHEQUE2, RTRIM(LTRIM(TC_CURRENCY)) AS TC_CURRENCY,RTRIM(LTRIM(TC_CURRENCY1)) AS TC_CURRENCY1,RTRIM(LTRIM(TC_CURRENCY2)) AS TC_CURRENCY2, EXPENDITURE_REMARKS, CASH_BREAKUP_REMARKS, TRAVEL_REQ_ID, SITE_ID,TK_PROVIDER_FLAG,TK_AIRLINE_NAME,TK_CURRENCY,TK_AMOUNT,TK_REMARKS , "
			+ " YTM_BUDGET , YTD_ACTUAL , AVAIL_BUDGET , EST_EXP , EXP_REMARKS,FARE_CURRENCY,FARE_AMOUNT"
			+ " FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="
			+ strTravelId + " AND APPLICATION_ID=1 AND STATUS_ID=10";
	}
	
	rs = dbConBean.executeQuery(strSql);
	if (rs.next()) {
		strBillingSite           = rs.getString("BILLING_SITE");
		strBillingClient         = rs.getString("BILLING_CLIENT");
		strTACurrency            = rs.getString("TA_CURRENCY");
		strTravelReqId           = rs.getString("TRAVEL_REQ_ID");
		strTravllerSiteId        = rs.getString("SITE_ID");
		strTkAgent               = rs.getString("TK_PROVIDER_FLAG");
		strTkAirLine             = rs.getString("TK_AIRLINE_NAME");
		strTkcurrency            = rs.getString("TK_CURRENCY");
		strTklocalprice          = rs.getString("TK_AMOUNT");
		strTkRemarks             = rs.getString("TK_REMARKS");
		dbl_YTM_BUDGET           = rs.getString("YTM_BUDGET");
		dbl_YTD_ACTUAL           = rs.getString("YTD_ACTUAL");
		dbl_AVAIL_BUDGET         = rs.getString("AVAIL_BUDGET");
		dbl_EST_EXP              = rs.getString("EST_EXP");
		str_EXP_REMARKS          = rs.getString("EXP_REMARKS");
		strTotalFareCurrency     = rs.getString("FARE_CURRENCY");
		strTotalFareAmount       = rs.getString("FARE_AMOUNT");

		if(dbl_YTM_BUDGET.equalsIgnoreCase("0.0")) {
			dbl_YTM_BUDGET = "";
		}
		if(dbl_YTD_ACTUAL.equalsIgnoreCase("0.0")) {
			dbl_YTD_ACTUAL = "";
		}
		if(dbl_AVAIL_BUDGET.equalsIgnoreCase("0.0")) {
			dbl_AVAIL_BUDGET = "";
		}
		if(dbl_EST_EXP.equalsIgnoreCase("0.0")) {
			dbl_EST_EXP = "";
		}		
		if (strTklocalprice.equals("0")) {
			strTklocalprice = "";
		}
		if (strBillingClient == null) {
			strBillingClient = "";
		}
		if (strTotalAmount == null) {
			strTotalAmount = "";
		}
		if (strTACurrency == null || strTACurrency.equals("")) {
			strTACurrency = "USD";
		}
		if (strTkcurrency == null || strTkcurrency.equals("")) {
			strTkcurrency = "USD";
		}		
	}
	rs.close();
	
	if (strBillingSite == null) {
	} else {
		strSql = "SELECT  1 AS yes FROM USER_SITE_ACCESS WHERE  (USERID = "
				+ strUserId
				+ ") AND (SITE_ID = "
				+ strBillingSite
				+ ") and USER_SITE_ACCESS.STATUS_ID=10";

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
if(strMealId == null || strMealId.equals("")) {
	strMealId = "6";
}	
if(strManager == null) {
	strManager = "S";
}
if(strHod == null) {
	strHod = "S";
}
if(strBoardMember==null) {
	strBoardMember="B";
}
if(strReasonForTravel==null) {
	strReasonForTravel="";
}
if(strReasonForSkip==null) {
	strReasonForSkip="";
}
if(strCostCentre==null) {
	strCostCentre="0";
}

			
			if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
				rs=null;
				if(strTravelType.equals("D")) {					
					strSql = " SELECT 1 FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_DOM TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+
							" WHERE TS.TRAVEL_TYPE='D' AND TS.TRAVEL_STATUS_ID =6 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") "+ 
							" AND (CONVERT(DATE,TD.C_DATETIME) BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE()) OR  TD.TRAVEL_DATE BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE())) AND TD.Group_Travel_Flag='Y' "+  
							" UNION "+  
							" SELECT 1 FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_DOM TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+   
							" INNER JOIN (SELECT TRAVEL_ID,TJDI.JOURNEY_ORDER,TRAVEL_DATE FROM T_JOURNEY_DETAILS_DOM TJDI WHERE STATUS_ID=10 "+
							" UNION "+
							" SELECT TRAVEL_ID,9999,TRAVEL_DATE FROM T_RET_JOURNEY_DETAILS_DOM WHERE STATUS_ID=10 AND YEAR(TRAVEL_DATE)<>1900 AND TRAVEL_DATE IS NOT NULL)DRV ON TD.TRAVEL_ID=DRV.TRAVEL_ID "+
							" WHERE TS.TRAVEL_TYPE='D' AND TS.TRAVEL_STATUS_ID =10 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") AND TD.Group_Travel_Flag='Y' "+  
							" GROUP BY TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID HAVING CONVERT(DATE,GETDATE()) BETWEEN MIN(DRV.TRAVEL_DATE) AND MAX(DRV.TRAVEL_DATE) ";
				} else if(strTravelType.equals("I")) {	
					strSql = " SELECT 1 FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_INT TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+
							" WHERE TS.TRAVEL_TYPE='I' AND TS.TRAVEL_STATUS_ID =6 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") "+ 
							" AND (CONVERT(DATE,TD.C_DATETIME) BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE()) OR  TD.TRAVEL_DATE BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE())) AND TD.Group_Travel_Flag='Y' "+  
							" UNION "+  
							" SELECT 1 FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_INT TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+   
							" INNER JOIN (SELECT TRAVEL_ID,TJDI.JOURNEY_ORDER,TRAVEL_DATE FROM T_JOURNEY_DETAILS_INT TJDI WHERE STATUS_ID=10 "+
							" UNION "+
							" SELECT TRAVEL_ID,9999,TRAVEL_DATE FROM T_RET_JOURNEY_DETAILS_INT WHERE YEAR(TRAVEL_DATE)<>1900 AND TRAVEL_DATE IS NOT NULL)DRV ON TD.TRAVEL_ID=DRV.TRAVEL_ID "+
							" WHERE TS.TRAVEL_TYPE='I' AND TS.TRAVEL_STATUS_ID =10 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") AND TD.Group_Travel_Flag='Y' "+  
							" GROUP BY TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID HAVING CONVERT(DATE,GETDATE()) BETWEEN MIN(DRV.TRAVEL_DATE) AND MAX(DRV.TRAVEL_DATE) ";
				}
					rs = dbConBean.executeQuery(strSql);
					if(rs.next()) {	
						strShowCancelledRegflag = "y";
					}
					rs.close();
			}
			
			Map specialMeal = dao.getSpecialMeal(strTravelAgencyId);
			Map preferredTimeList = dao.getPreferredTimeList();
			Map flightClassList = dao.getFlightClassList(strTravelAgencyId, strUserId, strTravelType, strGroupTravelFlag);
			Map flightWindowList = dao.getFlightWindowList(strTravelAgencyId);			
			Map trainClassList = dao.getTrainClassList(strTravelAgencyId);
			Map trainWindowList = dao.getTrainWindowList(strTravelAgencyId);
			Map carClassList = dao.getCarClassList(strTravelAgencyId);
			Map carWindowList = dao.getCarWindowList(strTravelAgencyId);
			Map currencyList = dao.getCurrencyList();
			Map carCategoryList = null;
			
			List excludePreferredTimeList = new ArrayList();
			excludePreferredTimeList.add("1");
			excludePreferredTimeList.add("2");
			excludePreferredTimeList.add("3");
			excludePreferredTimeList.add("4");
			
		%>
		
<!-- Added By Gurmeet Singh [START] -->
  <script type="text/javascript">
	var siteIdGlobal = '<%=strSiteIdSS%>';
	var userIdGlobal = '<%=Suser_id%>';	
	var baseCurrencyVal = '<%=strBaseCur%>';
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
<form name="frm" id="frmId" action="T_Group_QuickTravel_Detail_MATA_Post.jsp" >
<!-- <div id="main"> -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr><td class="hrSpace4Px"></td></tr>
		<tr>
			<td style="height: 22px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>	
					<%
					if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
					%>
						<td>
							<ul class="pagebullet">
						     	 <li><%=dbLabelBean.getLabel("label.editrequest.editgroupguesttravelrequest",strsesLanguage)%>&nbsp;-&nbsp;<span style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; font-weight: bold;color: #0000ff;">[<%=strTravelReqNo %>]</span></li>
						    </ul>
						</td>
					<%	
					} else {
					%>
						<td>
						<ul class="pagebullet">
					     	 <li><%=dbLabelBean.getLabel("label.createrequest.creategroupguesttravelrequest",strsesLanguage)%></li>
					    </ul>
					</td>
					<% } %>
					
					<td width="500px" class="hide" id="cancelledTravelReqTd" style="text-align: right;">
						<table width="400px" border="0" cellspacing="0" cellpadding="0" align="right" style="background-color:#00a452;" id="linkCanReqTbl">
							<tr>
								<td class="linkCanReqTd"><%=dbLabelBean.getLabel("label.global.linkwithcancelledrequest",strsesLanguage)%></td>
								<td style="width:220px;">
									<select name="cancelledTravelReq" id="cancelledTravelReq" class="comboBoxCss" style="color:#ff0000; font-size:10px;">
									<%
										if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
									%>
									
										<option value="0"><%=dbLabelBean.getLabel("label.global.selectcancelledrequest",strsesLanguage)%></option>
										<%	
										if(strTravelType.equals("D")) {	
											strSql = " SELECT TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_DOM TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+
													" WHERE TS.TRAVEL_TYPE='D' AND TS.TRAVEL_STATUS_ID =6 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") "+ 
													" AND (CONVERT(DATE,TD.C_DATETIME) BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE()) OR  TD.TRAVEL_DATE BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE())) AND TD.Group_Travel_Flag='Y' "+  
													" UNION "+  
													" SELECT TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_DOM TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+   
													" INNER JOIN (SELECT TRAVEL_ID,TJDI.JOURNEY_ORDER,TRAVEL_DATE FROM T_JOURNEY_DETAILS_DOM TJDI WHERE STATUS_ID=10 "+
													" UNION "+
													" SELECT TRAVEL_ID,9999,TRAVEL_DATE FROM T_RET_JOURNEY_DETAILS_DOM WHERE STATUS_ID=10 AND YEAR(TRAVEL_DATE)<>1900 AND TRAVEL_DATE IS NOT NULL)DRV ON TD.TRAVEL_ID=DRV.TRAVEL_ID "+
													" WHERE TS.TRAVEL_TYPE='D' AND TS.TRAVEL_STATUS_ID =10 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") AND TD.Group_Travel_Flag='Y' "+  
													" GROUP BY TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID HAVING CONVERT(DATE,GETDATE()) BETWEEN MIN(DRV.TRAVEL_DATE) AND MAX(DRV.TRAVEL_DATE) ";
										} else if(strTravelType.equals("I")) {
											strSql = " SELECT TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_INT TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+
													" WHERE TS.TRAVEL_TYPE='I' AND TS.TRAVEL_STATUS_ID =6 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") "+ 
													" AND (CONVERT(DATE,TD.C_DATETIME) BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE()) OR  TD.TRAVEL_DATE BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE())) AND TD.Group_Travel_Flag='Y' "+  
													" UNION "+  
													" SELECT TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_INT TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+   
													" INNER JOIN (SELECT TRAVEL_ID,TJDI.JOURNEY_ORDER,TRAVEL_DATE FROM T_JOURNEY_DETAILS_INT TJDI WHERE STATUS_ID=10 "+
													" UNION "+
													" SELECT TRAVEL_ID,9999,TRAVEL_DATE FROM T_RET_JOURNEY_DETAILS_INT WHERE YEAR(TRAVEL_DATE)<>1900 AND TRAVEL_DATE IS NOT NULL)DRV ON TD.TRAVEL_ID=DRV.TRAVEL_ID "+
													" WHERE TS.TRAVEL_TYPE='I' AND TS.TRAVEL_STATUS_ID =10 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") AND TD.Group_Travel_Flag='Y' "+  
													" GROUP BY TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID HAVING CONVERT(DATE,GETDATE()) BETWEEN MIN(DRV.TRAVEL_DATE) AND MAX(DRV.TRAVEL_DATE) ";
										}
										rs = dbConBean.executeQuery(strSql);
										
										while(rs.next()) {	
											if("6".equals(rs.getString("TRAVEL_STATUS_ID"))) {
										%> 
										  		<option value="<%=rs.getString("TRAVEL_ID")%>"><%=rs.getString("TRAVEL_REQ_NO")%>-(<%=dbLabelBean.getLabel("label.requestdetails.cancelled",strsesLanguage)%>)</option>
										<%
											} else if("10".equals(rs.getString("TRAVEL_STATUS_ID"))) {
										%> 
										  		<option value="<%=rs.getString("TRAVEL_ID")%>"><%=rs.getString("TRAVEL_REQ_NO")%>-(<%=dbLabelBean.getLabel("label.requestdetails.onair",strsesLanguage)%>)</option>
										<%		
											}
							             }
							              rs.close();
										}
										%>
										
									</select>
									<script language="javascript">
		                              document.frm.cancelledTravelReq.value="<%=strCancelledReqId%>";
		                            </script>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		
		<tr><td class="hrSpace4Px"></td></tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border: 1px solid #dddddd;">
		<tr><td class="hrSpace4Px"></td></tr>
		<!-- Request type button Start -->
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="2" cellpadding="0">
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr valign="top">
									<td>
										<table width="65%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<% if(strTravelType !=null && strTravelType.equals("I")) { %>
												<td id="reqTypeBtn" style="width:8%;">
													<table width="100%" border="0" cellspacing="0" cellpadding="0" class="bt-RequestType">
														<tr>														
																<td id="bt-Int" title="<%=dbLabelBean.getLabel("label.createrequest.createinternationalrequest",strsesLanguage) %>">
																	<label class="Int">
																		<input type="radio" name="travelType" value="I" id="rd_Int" checked="checked"><%=dbLabelBean.getLabel("button.global.international",strsesLanguage)%>
																	</label>
																</td>																												
														</tr>
													</table>
												</td>
												<%} else if(strTravelType !=null && strTravelType.equals("D")) { %>
												<td id="reqTypeBtn" style="width:8%;">
													<table width="100%" border="0" cellspacing="0" cellpadding="0" class="bt-RequestType">
														<tr>														
																<td id="bt-Dom" title="<%=dbLabelBean.getLabel("label.createrequest.createdomestictravelrequest",strsesLanguage) %>">
																	<label class="Dom">
																		<input type="radio" name="travelType" value="D" id="rd_Dom" checked="checked"><%=dbLabelBean.getLabel("button.global.domestic",strsesLanguage)%>
																	</label>
																</td>
															</tr>
													</table>
												</td>
												<%} else { %>
												<td id="reqTypeBtn">
													<table width="100%" border="0" cellspacing="0" cellpadding="0" class="bt-RequestType">
														<tr>														
																<td id="bt-Dom" title="<%=dbLabelBean.getLabel("label.createrequest.createdomestictravelrequest",strsesLanguage) %>">
																	<label class="Dom">
																		<input type="radio" name="travelType" value="D" id="rd_Dom" checked="checked"><%=dbLabelBean.getLabel("button.global.domestic",strsesLanguage)%>
																	</label>
																</td>
																<td id="bt-Int" title="<%=dbLabelBean.getLabel("label.createrequest.createinternationalrequest",strsesLanguage) %>">
																	<label class="Int">
																		<input type="radio" name="travelType" value="I" id="rd_Int"><%=dbLabelBean.getLabel("button.global.international",strsesLanguage)%>
																	</label>
																</td>																												
														</tr>
													</table>
												</td>
												<%} %>	
												<td id="siteName">
													<select name="site" class="comboBoxCss" id="siteName">
						                           
						                          <option value="S" selected><%=dbLabelBean.getLabel("label.createrequest.selectunit",strsesLanguage) %></option>
												<%
						                          //For Population of Site Combo according to the Site
						                          //strSql =   "select site_id, site_Name from M_Site where status_id=10 and application_id=1 order by 2";
												  strSql = "select distinct site_id, dbo.sitename(site_id) as Site_Name  from USER_MULTIPLE_ACCESS (NOLOCK) where userid="+Suser_id+" and status_id=10 and (UNIT_HEAD=1 or ROLE_ID='LA') order by 2";
												  //System.out.println("strsql-=---=-=-=>"+strSql);
						                          rs       =   dbConBean.executeQuery(strSql);  
						                          while(rs.next())
						                          {
												   
												%>       
						                            <option value="<%=rs.getString("Site_Id")%>"><%=rs.getString("Site_Name")%></option>
												<%
						                     	  }
						                          rs.close();	 
												 
													
						
												  /*@Gaurav 26-Apr-2007 For Showing Primary site & 27-Apr-2007 it should appear only once */
												  strSql =   "select Site_id, Site_Name from M_Site (NOLOCK) where status_id=10 and application_id=1 and Site_id="+strSiteIdSS+" and Site_id Not IN (select distinct site_id from USER_MULTIPLE_ACCESS (NOLOCK) where userid="+Suser_id+" and status_id=10 and (UNIT_HEAD=1 or ROLE_ID='LA')) order by 2";	
												  rs       =   dbConBean.executeQuery(strSql);  
						                          while(rs.next())
						                          {
												%>
						                             <option value="<%=rs.getString("Site_Id")%>"><%=rs.getString("Site_Name")%></option> 
												<%   
													}
						                          rs.close();	
												  // End of Code
												%>
						                        </select>
						                        <script language="javascript">
												  var tt =  "<%=strSiteId%>";
												 // alert(tt);
												  if(tt != null && (tt=="0" || tt==""))
												     document.frm.site.value="S";  
												  else
						                            document.frm.site.value="<%=strSiteId%>";
												  
						                        </script>
												</td>
												<%
							                        if(strAppLvl3flg.trim().equalsIgnoreCase("Y") && strShowflag.equalsIgnoreCase("y")){
							                        %>
												<td id="costCentre">
													<select name="costcentre" class="comboBoxCss">
							                          <option value="0"><%=dbLabelBean.getLabel("label.createrequest.selectcostcentre",strsesLanguage)%></option>
														<%                          
														strSql =   "SELECT CC_ID,CC_CODE+' - '+CC_DESC+'' AS CC_CODE FROM M_COST_CENTRE WHERE SITE_ID="+strSiteId+" AND M_COST_CENTRE.STATUS_ID=10 ORDER BY CC_CODE";
														rs       =   dbConBean.executeQuery(strSql);  
														while(rs.next()) {%>
															<option value="<%=rs.getString("CC_ID")%>"><%=rs.getString("CC_CODE")%></option>
														<%}
														rs.close();	  
														%>
							                         </select>
							                         <script language="javascript">
							                         	document.frm.costcentre.value="<%=strCostCentre%>";
							                         </script>
												</td>
												<% } else { %>
												<td id="costCentre"></td>
												<% } %>					
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
		<!-- Request type button End -->
		
		<!-- Personal Detail Start -->
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="2">
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="titleBar"><%=dbLabelBean.getLabel("label.global.personaladdress",strsesLanguage) %></td>
								</tr>
							</table>
						</td>
					</tr>
					<%
						if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new") && strGUserId != null && !"".equals(strGUserId)) {
							strSql =" SELECT G_EMP_CODE, G_EMAIL, G_USERID, SITE_ID, FIRST_NAME, LAST_NAME, DESIG_ID, ISNULL(DBO.CONVERTDATEDMY1(DOB),'-') AS DOB, AGE, GENDER, "+
							        " MAEL_ID, IDENTITY_ID, IDENTITY_NO, ISNULL(MOBILE_NO,'') AS MOBILE_NO, PASSPORT_NO, ISNULL(NATIONALITY ,'') AS NATIONALITY, " +
							        " PLACE_OF_ISSUE, ISNULL(DBO.CONVERTDATEDMY1(DATE_OF_ISSUE),'-') AS DATE_OF_ISSUE, ISNULL(DBO.CONVERTDATEDMY1(EXPIRY_DATE),'-') AS EXPIRY_DATE, "+
							        " ECNR, VISA_REQUIRED, ISNULL(RETURN_TRAVEL,'n') AS RETURN_TRAVEL, RTRIM(LTRIM(CONVERT(DECIMAL(20,2), TOTAL_AMOUNT))) AS TOTAL_AMOUNT, ISNULL(EXP_REMARKS,'') AS EXP_REMARKS "+
								    " FROM T_GROUP_USERINFO WHERE (G_USERID = "+strGUserId+") AND (TRAVEL_ID = "+strTravelId+" ) AND (TRAVEL_TYPE = '"+strTravelType+"') AND STATUS_ID=10";
							
							rs = dbConBean.executeQuery(strSql);
							if(rs.next()) {	
								strGrpTrvUserId					= rs.getString("G_USERID").trim();
								strGrpTrvFirstName 			 	= rs.getString("FIRST_NAME").trim();
								strGrpTrvLastName 			 	= rs.getString("LAST_NAME").trim();
								strGrpTrvDesign 			 	= rs.getString("DESIG_ID").trim();
								strGrpTrvDOB 			 		= rs.getString("DOB").trim();
								strGrpTrvAge 			 		= rs.getString("AGE").trim();
								strGrpTrvGender 			 	= rs.getString("GENDER").trim();
								strGrpTrvMealPref 			 	= rs.getString("MAEL_ID").trim();
								strGrpTrvIdentityProof 			= rs.getString("IDENTITY_ID").trim();
								strGrpTrvIdentityProofNo 		= rs.getString("IDENTITY_NO").trim();
								strGrpTrvMobileNo 			 	= rs.getString("MOBILE_NO").trim();
								strGrpTrvPassportNo 			= rs.getString("PASSPORT_NO").trim();
								strGrpTrvNationality 			= rs.getString("NATIONALITY").trim();
								strGrpTrvPasprtIssuePlace 		= rs.getString("PLACE_OF_ISSUE").trim();
								strGrpTrvPasprtIssueDate 		= rs.getString("DATE_OF_ISSUE").trim();
								strGrpTrvPasprtExpiryDate 		= rs.getString("EXPIRY_DATE").trim();
								strGrpTrvVisaRequired 			= rs.getString("VISA_REQUIRED").trim();
								strGrpTrvEcrRequired 			= rs.getString("ECNR").trim();
								strTotalAmount           		= rs.getString("TOTAL_AMOUNT");
								strExpenditureRemarks    		= rs.getString("EXP_REMARKS");
								
								strGrpTrvEmpId					= rs.getString("G_EMP_CODE") == null ? "" : rs.getString("G_EMP_CODE").trim();
								strGrpTrvEmailAddress			= rs.getString("G_EMAIL") == null ? "" : rs.getString("G_EMAIL").trim();
								
								if (strTotalAmount != null && strTotalAmount.trim().equals("0")) {
									strTotalAmount = "";
								}
								
								if (strExpenditureRemarks == null) {
									strExpenditureRemarks = "";
								}
							}
							rs.close();
						}
					%>
					<tr>
						<td style="padding:0 0 0 10px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="2" cellpadding="0">
											<tr>
												<input type="hidden" name="grpUserID" value="<%=strGrpTrvUserId%>"/> 
												<td class="grpFirstLastNameInput">
													<input type="text" name="firstName" id="firstName" class="textBoxCss" value="<%=strGrpTrvFirstName %>" onFocus="initializeGuestName(this);" onKeyUp="return test2(this, 30, 'c')" maxlength="30" placeholder="<%=dbLabelBean.getLabel("label.global.firstname",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.firstname",strsesLanguage)%>"/>
												</td>
												<td class="grpFirstLastNameInput">
													<input type="text" name="lastName" id="lastName" class="textBoxCss" value="<%=strGrpTrvLastName %>" onKeyUp="return test2(this, 30, 'c')" maxlength="30" placeholder="<%=dbLabelBean.getLabel("label.global.lastname",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.lastname",strsesLanguage)%>"/>
												</td>
												<td class="grpDesignationCombo">
													<select name="designation" id="designation" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%>">
														<option value="-1"> <%=dbLabelBean.getLabel("label.global.selectdesignation",strsesLanguage)%></option>
														<%		
									   						String strDesignIdGuest = "";						   			
															strSql = "SELECT DESIG_ID,DESIG_NAME FROM M_DESIGNATION where site_id="+strSiteId+" AND APPLICATION_ID = 1 AND STATUS_ID = 10 ORDER BY DESIG_NAME";
															rs = null;
				                                 			rs = dbConBean.executeQuery(strSql);  
				                                 			while(rs.next()) {				                                 				
				                                 		%>
													 	 	<option value="<%=rs.getString("DESIG_ID")%>"><%=rs.getString("DESIG_NAME")%></option> 														
				                                 		<%			
						                                 		if(rs.getString("DESIG_NAME") != null && rs.getString("DESIG_NAME").trim().equalsIgnoreCase("guest")) {
						                                 			strDesignIdGuest = rs.getString("DESIG_ID");											
																}	
				                                 			}
				                              				rs.close();
														%>
													</select>
													 <script language="javascript">
													  var designVal = '<%=strGrpTrvDesign%>';
													  var designValGuest = '<%=strDesignIdGuest%>';
													  if(designValGuest != "" && designVal != null && designVal != "" && designVal == "-1") {
														  $("select#designation").val(designValGuest);
													  } else if(designVal != null && designVal != "" && designVal != "-1") {
														  $("select#designation").val(designVal);
													  } else {
														  $("select#designation").val("-1");
													  }
													 </script>
												</td>
												<td class="grpDOBInput">
													<input type="text" name="dateOfBirth" id="dateOfBirth" class="textBoxCss" value="<%=strGrpTrvDOB %>" onFocus="initializeDOBDate(this);" placeholder="<%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%>"/>
												</td>
												<td class="grpAgeInput">
													<input type="text" name="age" id="age" class="textBoxCss" value="<%=strGrpTrvAge %>" placeholder="<%=dbLabelBean.getLabel("label.global.age",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.age",strsesLanguage)%>" readonly="readonly"/>
												</td>
												<td class="grpGenderCombo">
													<select name="gender" id="gender" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%>">
														<option value='-1'><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%></option>
							                          	<option value='1'><%=dbLabelBean.getLabel("label.global.male",strsesLanguage)%></option>
							                          	<option value='2'><%=dbLabelBean.getLabel("label.global.female",strsesLanguage)%></option>
							                        </select>
							                        <script language="javascript">
														var genderVal = '<%=strGrpTrvGender%>';
														if(genderVal!=null && genderVal!="" && genderVal=="1"){
															$("select#gender").val(genderVal);
														} else if(genderVal!=null && genderVal!="" && genderVal=="2"){
															$("select#gender").val(genderVal);
														} else {
															$("select#gender").val(genderVal);
														}
													</script> 
												</td>
												<td class="grpMealPrefCombo">
													<select name="mealPref" id="mealPref" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.mealpreference",strsesLanguage)%>">
									  					<option value='-1'><%=dbLabelBean.getLabel("label.createrequest.selectmealpreference",strsesLanguage)%></option>
									  				<%
									  					strSql =   "SELECT MEAL_ID, MEAL_NAME FROM M_MEAL (NOLOCK) WHERE TRAVEL_AGENCY_ID = 1 AND STATUS_ID =10 ORDER BY MEAL_ID";
									  					rs = null;	
									  					rs  =  dbConBean.executeQuery(strSql);  
				                             			while(rs.next()) {
				                             				if(strGrpTrvMealPref != null && !"".equals(strGrpTrvMealPref) && rs.getString("MEAL_ID").equals(strGrpTrvMealPref)) {
													%>
																<option value="<%=rs.getString("MEAL_ID")%>" selected="selected"><%=rs.getString("MEAL_NAME")%></option>
													<%		} else {
													%>
																<option value="<%=rs.getString("MEAL_ID")%>"><%=rs.getString("MEAL_NAME")%></option>
													<%
															}
				                         	 			}
				                             			rs.close();	  
													%>
												</td>
											</tr>
										</table>
									</td>
								</tr>							
								<tr><td class="hrSpace4Px"></td></tr>
								<tr id="identityProofDetail" style="display:none;">
									<td>
										<table width="70%" border="0" cellspacing="2" cellpadding="0">
											<tr>
												<td class="grpIdentityNameCombo">
													<select name="identityProof" id="identityProof" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.identityname",strsesLanguage)%>">
														<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.proofofidentity",strsesLanguage)%></option>
													<%	
														strSql = "SELECT IDENTITY_ID, IDENTITY_NAME FROM m_IDENTITY_PROOF WHERE STATUS_ID=10 ORDER BY ORDER_ID ";
														rs = null;
														rs = dbConBean.executeQuery(strSql); 
														while(rs.next()){
															if(strGrpTrvIdentityProof != null && !"".equals(strGrpTrvIdentityProof) && rs.getString(1).equals(strGrpTrvIdentityProof)) {
													%>
														  		<option value = <%=rs.getString(1)%> selected="selected"> <%= rs.getString(2) %></option>
													<%
															} else {
													%>
																<option value = <%=rs.getString(1)%>> <%= rs.getString(2) %></option>
													<%			
															}
														}
														rs.close();
													%>
													</select>
												</td>
												<td class="grpIdentityNoInput">
													<input type="text" name="identityProofno" id="identityProofno" class="textBoxCss" value="<%=strGrpTrvIdentityProofNo %>" onKeyUp="return test2(this, 30, 'all')" maxlength="30" placeholder="<%=dbLabelBean.getLabel("label.global.identitynumber",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.identitynumber",strsesLanguage)%>"/>
												</td>
												
												<td class="grpEmailIdInput">
													<input type="text" name="emailId" id="emailId" class="textBoxCss" value="<%=strGrpTrvEmailAddress %>" onKeyUp="return test2(this, 100, 'an')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.emailid",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.emailid",strsesLanguage)%>"/>
												</td>
												
												<td class="grpEmpIdInput">
													<input type="text" name="empId" id="empId" class="textBoxCss" value="<%=strGrpTrvEmpId %>" onKeyUp="return test2(this, 30, 'all')" maxlength="30" placeholder="Employee Id" title="Employee Id"/>
												</td>
												
												<td class="grpMobileNoInput">
													<input type="text" name="contactNo" id="contactNo" class="textBoxCss" value="<%=strGrpTrvMobileNo %>"  onKeyUp="return test2(this, 19, 'phone')" maxlength="20" placeholder="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>"/>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr id="passportDetail" style="display:none;">
									<td>
										<table width="100%" border="0" cellspacing="2" cellpadding="0">
											<tr>
												<td class="grpPassportNoInput">
													<input type="text" name="passportNo" id="passportNo" class="textBoxCss" value="<%=strGrpTrvPassportNo %>" onkeyup="return test2(this, 49, 'all')" maxlength="49" placeholder="<%=dbLabelBean.getLabel("label.global.passportnumber",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.passportnumber",strsesLanguage)%>"/>
												</td>
												<td class="grpNationalityInput">
													<input type="text" name="passportNationality" id="passportNationality" class="textBoxCss" value="<%=strGrpTrvNationality %>" onkeyup="return test2(this, 49, 'c')" maxlength="99" placeholder="<%=dbLabelBean.getLabel("label.user.nationality",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.user.nationality",strsesLanguage)%>"/>
												</td>
												<td class="grpIssuePlaceInput">
													<input type="text" name="passportIssuePlace" id="passportIssuePlace" class="textBoxCss" value="<%=strGrpTrvPasprtIssuePlace %>" onKeyUp="return test2(this, 99, 'c')" maxlength="99" placeholder="<%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%>"/>
												</td>
												<td class="grpIssueDateInput">
													<input type="text" name="passportIssueDate" class="textBoxCss" id="passportIssueDate" value="<%=strGrpTrvPasprtIssueDate %>" onFocus="initializeDate(this);" placeholder="<%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%>"/>
												</td>
												<td class="grpExpiryDateInput">
													<input type="text" name="passportExpiryDate" class="textBoxCss" id="passportExpiryDate" value="<%=strGrpTrvPasprtExpiryDate %>" onFocus="initializeDate(this);" placeholder="<%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage)%>"/>
												</td>
												<td class="grpVisaRequiredCombo">
													<select name="visaRequired" id="visaRequired" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.visarequired",strsesLanguage)%>">
														<option value='1'><%=dbLabelBean.getLabel("label.global.visarequired",strsesLanguage)%>&nbsp;[<%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>]</option>
                        								<option value='2' selected="selected"><%=dbLabelBean.getLabel("label.global.visarequired",strsesLanguage)%>&nbsp;[<%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>]</option>
													</select>
													<script language="javascript">
														var visaRequiredVal = '<%=strGrpTrvVisaRequired%>';
														if(visaRequiredVal!=null && visaRequiredVal!="" && visaRequiredVal=="1"){
															$("select#visaRequired").val(visaRequiredVal);
														} else if(visaRequiredVal!=null && visaRequiredVal!="" && visaRequiredVal=="2"){
															$("select#visaRequired").val(visaRequiredVal);
														} else {
															$("select#visaRequired").val(visaRequiredVal);
														}
													</script>
												</td>
												<td class="grpEcnrRequiredCombo">
													<select name="ecnrRequired" id="ecnrRequired" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.emigrationclearancerequired",strsesLanguage)%>">
                        								<option value='1'><%=dbLabelBean.getLabel("label.global.emigrationclearancerequired",strsesLanguage)%>&nbsp;[<%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>]</option>
                        								<option value='2' selected="selected"><%=dbLabelBean.getLabel("label.global.emigrationclearancerequired",strsesLanguage)%>&nbsp;[<%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>]</option>
                        								<option value='3'><%=dbLabelBean.getLabel("label.global.emigrationclearancerequired",strsesLanguage)%>&nbsp;[<%=dbLabelBean.getLabel("label.global.na",strsesLanguage)%>]</option>
													</select>
													<script language="javascript">
														var ecrRequiredVal = '<%=strGrpTrvEcrRequired%>';
														if(ecrRequiredVal!=null && ecrRequiredVal!="" && ecrRequiredVal=="1"){
															$("select#ecnrRequired").val(ecrRequiredVal);
														} else if(ecrRequiredVal!=null && ecrRequiredVal!="" && ecrRequiredVal=="2"){
															$("select#ecnrRequired").val(ecrRequiredVal);
														} else if(ecrRequiredVal!=null && ecrRequiredVal!="" && ecrRequiredVal=="3"){
															$("select#ecnrRequired").val(ecrRequiredVal);
														} else {
															$("select#ecnrRequired").val(ecrRequiredVal);
														}
													</script>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr><td class="hrSpace4Px"></td></tr>
								<tr id="identityProofDetailInt" style="">
									<td>
										<table width="32%" border="0" cellspacing="2" cellpadding="0">
											<tr>
												<td class="grpIntEmailIdInput">
													<input type="text" name="emailIdInt" id="emailIdInt" class="textBoxCss" style="width:99%;" value="<%=strGrpTrvEmailAddress %>" onKeyUp="return test2(this, 100, 'an')" maxlength="100" placeholder="<%=dbLabelBean.getLabel("label.global.emailid",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.emailid",strsesLanguage)%>"/>
												</td>
												<td class="grpIntEmpIdInput">
													<input type="text" name="empIdInt" id="empIdInt" class="textBoxCss" style="width:99%;" value="<%=strGrpTrvEmpId %>" onKeyUp="return test2(this, 30, 'all')" maxlength="30" placeholder="Employee Id" title="Employee Id"/>
												</td>
											</tr>
										</table>
									</td>
								</tr>								
								<tr><td class="hrSpace2Px"></td></tr>
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<!--  Forex/Advance Details Start -->
											<tr>
												<td style="padding:0 10px 0 0;">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr><td class="hrSpace6Px"></td></tr>
														<tr valign="top" id="forexDetailBtn">
															<td class="journyType" style="padding:5px 0 0 0; border-top:1px solid #aea899;">
																<table width="230px" border="0" cellspacing="0" cellpadding="0">
																	<tr>
																		<td style="width:100%;">
																			<label class="modeType" id="forexLabel_Int" style="display: none;"><b><%=dbLabelBean.getLabel("label.requestdetails.forexdetails",strsesLanguage)%></b></label>
																			<label class="modeType" id="forexLabel_Dom" style="display: none;"><b><%=dbLabelBean.getLabel("label.createrequest.advancerequired",strsesLanguage)%></b></label>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
														<tr valign="top">
															<td style="padding:3px 0 0 0;">
																<table width="100%" border="0" cellspacing="0" cellpadding="0">
																	<tr>
																		<td width="100%">
																			<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tblForexDetail" class="forexDetail">
																				<thead>
																					<tr>
																						<th rowspan="2" align="center"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></th>
																						<th rowspan="2" align="center"><%=dbLabelBean.getLabel("label.global.currencypreference",strsesLanguage)%></th>
																						<th colspan="2" align="center"><%=dbLabelBean.getLabel("label.global.dailyallowances",strsesLanguage)%></th>
																						<th colspan="2" align="center"><%=dbLabelBean.getLabel("label.global.hotelcharges",strsesLanguage)%></th>
																						<th rowspan="2" align="center"><%=dbLabelBean.getLabel("label.global.contigencies",strsesLanguage)%></th>
																						<th rowspan="2" align="center"><%=dbLabelBean.getLabel("label.mylinks.others",strsesLanguage)%></th>
																						<th rowspan="2" align="center"><%=dbLabelBean.getLabel("label.global.total",strsesLanguage)%></th>
																						<th rowspan="2" align="center"><%=dbLabelBean.getLabel("label.requisition.exchrate",strsesLanguage)%><br>(<%=dbLabelBean.getLabel("label.requisition.inr",strsesLanguage)%>)</th>
																						<th rowspan="2" align="center"><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage)%><br>(<%=strBaseCur%>)</th>
																						<th rowspan="2" align="center"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></th>										
																					</tr>
																					<tr>
																	                     <th align="center"><%=dbLabelBean.getLabel("label.requisitiondetails.expday",strsesLanguage)%></th>
																	                     <th align="center"><%=dbLabelBean.getLabel("label.requisition.tourdays",strsesLanguage)%></th>
																	                     <th align="center"><%=dbLabelBean.getLabel("label.requisitiondetails.expday",strsesLanguage)%></th>
																	                     <th align="center"><%=dbLabelBean.getLabel("label.requisition.tourdays",strsesLanguage)%></th>
																                     </tr>
																                   </thead>	
																                   <tbody id="currencyTbltTbdy">
																                   <%		
																                   if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new") && strGUserId != null && !"".equals(strGUserId)) {
																                	   int count=0,sno=0;
																                	   CallableStatement objCstmt	    =  null;
																                	   Connection objCon               =  dbConBean.getConnection(); 
																                	   objCstmt             =  objCon.prepareCall("{?=call SPG_GET_TRAVEL_EXPENDITURE_DETAILS(?,?,?)}");        
																                	   objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
																                	   objCstmt.setString(2,strTravelId);
																                	   objCstmt.setString(3,strTravelType);
																                	   objCstmt.setString(4,strGUserId);
																                	   rsForex = objCstmt.executeQuery();
																                	   while (rsForex.next()) {
																                	   strRec="yes";
																                	   strTACurrency2		=	rsForex.getString("CURRENCY");
																                	   strEntPerDay			=	rsForex.getString("ENT_PER_DAY1");
																                	   strTotalTourDay		=	rsForex.getString("TOTAL_TOUR_DAYS1");
																                	   strEntPerDay2		=	rsForex.getString("ENT_PER_DAY2");
																                	   strTotalTourDay2		=	rsForex.getString("TOTAL_TOUR_DAYS2");
																                	   strContingecies		=	rsForex.getString("TOTAL_EXP_ID3");
																                	   strContingecies2		=	rsForex.getString("TOTAL_EXP_ID4");
																                	   strTotalForex		=	rsForex.getString("TOTAL_EXP");
																                	   strExRate			=	rsForex.getString("EXCHANGE_RATE");
																                	   if(strExRate.equals("0.000000")) {
																                	   	strExRate = "";
																                	   }
																                	   strTotalINR			=	rsForex.getString("TOTAL"); 
																                	   %>
																                	   <tr class="forexDataRow">
																					 	<td class="srno"><span class="spn"><%=++sno %></span></td>
																						<td class="currency">
																							<select name="expCurrency" id="expCurrency" class="combo-currencyType" title="<%=dbLabelBean.getLabel("label.global.currencypreference",strsesLanguage) %>" onchange="fun_exchangerate(this);">
																							 	<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectcurrency",strsesLanguage) %></option>
																								<%
																									strSql = "Select rtrim(Currency), rtrim(Currency) from m_currency where status_id=10";
																									rs = dbConBean.executeQuery(strSql);
																									while (rs.next()) {%>
																	                             		<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>  
																								<%}
																  									rs.close();
																  								%> 
																	                         </select>
																							<script language="javascript">
																								document.getElementsByName("expCurrency")[<%=count%>].value="<%=strTACurrency2%>";
													                         				</script>
																						</td>
																						<td class="dailyAllowances1"><input type="text" name="entitlement" class="forex" value="<%=strEntPerDay %>" id="entitlement1" onChange="check1();" onKeyUp="return test1(this, 10, 'n');" title="<%=dbLabelBean.getLabel("label.requisitiondetails.expday",strsesLanguage)%>"></td>
																						<td class="dailyAllowances2"><input type="text" name="tourDays" class="forex" value="<%=strTotalTourDay %>" id="tourDays1" onChange="check1();" onKeyUp="return test1(this, 3, 'n');" title="<%=dbLabelBean.getLabel("label.requisition.tourdays",strsesLanguage)%>"></td>
																						<td class="hotelCharges1"><input type="text" name="entitlement2" class="forex" value="<%=strEntPerDay2 %>" id="entitlement2" onChange="check1();" onKeyUp="return test1(this, 10, 'n');" title="<%=dbLabelBean.getLabel("label.requisitiondetails.expday",strsesLanguage)%>"></td>
																						<td class="hotelCharges2"><input type="text" name="tourDays2" class="forex" value="<%=strTotalTourDay2 %>" id="tourDays2" onChange="check1();" onKeyUp="return test1(this, 3, 'n');" title="<%=dbLabelBean.getLabel("label.requisition.tourdays",strsesLanguage)%>"></td>
																						<td class="contingencies"><input type="text" name="contingencies" class="forex" value="<%=strContingecies %>" id="contingencies1" onChange="check1();" onKeyUp="return test1(this, 10, 'n.');" title="<%=dbLabelBean.getLabel("label.global.contigencies",strsesLanguage)%>"></td>
																						<td class="others"><input type="text" name="contingencies2" class="forex" value="<%=strContingecies2 %>" id="contingencies2" onChange="check1();" onKeyUp="return test1(this, 10, 'n.');" title="<%=dbLabelBean.getLabel("label.mylinks.others",strsesLanguage)%>"></td>
																						<td class="total"><input type="text" name="totalForex" class="forex" value="<%=strTotalForex %>" id="totalforex" onChange="check1();" onKeyUp="return test1(this, 20, 'n.');" readonly="readonly" title="<%=dbLabelBean.getLabel("label.global.total",strsesLanguage)%>"></td>
																						<td class="exchRate"><input type="text" name="exRate" class="forex" value="<%=strExRate %>" id="exrate" onChange="check1();" onKeyUp="return test1(this, 20, 'n.');" readonly="readonly" title="<%=dbLabelBean.getLabel("label.requisition.exchrate",strsesLanguage)%>&nbsp;(<%=dbLabelBean.getLabel("label.requisition.inr",strsesLanguage)%>)" disabled="disabled"></td>
																						<td class="totalAmount"><input type="text" name="totalInr" class="forex" value="<%=strTotalINR %>" id="totalinr" onChange="check1();" onKeyUp="return test1(this, 20, 'n.');" readonly="readonly" title="<%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage)%>&nbsp;(<%=strBaseCur%>)"></td>
																						<td class="action"><img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0"	id="bt-Del-Curr" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"></td>										
																					    <input name="hd" id="hd" type="hidden" value="v" />
																					</tr>				                	   
																                   <% 
																                   count++;
																                   } 
																                   }
																                if(strRec.equals("yes")) {%>
																                	<tr class="forexDataRow" style="display: none;">
																                <%} else if(strRec.equals("no")) {%>
																					<tr class="forexDataRow">
																					 	<td class="srno"><span class="spn">1</span></td>
																						<td class="currency">
																							<select name="expCurrency" id="expCurrency" class="combo-currencyType" title="Currency Preference" onchange="fun_exchangerate(this);">
																							 	<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectcurrency",strsesLanguage) %></option>
																								<%
																									strSql = "Select rtrim(Currency), rtrim(Currency) from m_currency where status_id=10";
																									rs = dbConBean.executeQuery(strSql);
																									while (rs.next()) {%>
																	                             		<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>  
																								<%}
																  									rs.close();
																  								%> 
																	                         </select>
																							<script language="javascript">
																			 		        	document.frm.expCurrency.value="<%=strBaseCur%>";
													                         				</script>
																						</td>
																						<td class="dailyAllowances1"><input type="text" name="entitlement" class="forex" value="0" id="entitlement1" onChange="check1();" onKeyUp="return test1(this, 10, 'n');" title="<%=dbLabelBean.getLabel("label.requisitiondetails.expday",strsesLanguage)%>"></td>
																						<td class="dailyAllowances2"><input type="text" name="tourDays" class="forex" value="0" id="tourDays1" onChange="check1();" onKeyUp="return test1(this, 3, 'n');" title="<%=dbLabelBean.getLabel("label.requisition.tourdays",strsesLanguage)%>"></td>
																						<td class="hotelCharges1"><input type="text" name="entitlement2" class="forex" value="0" id="entitlement2" onChange="check1();" onKeyUp="return test1(this, 10, 'n');" title="<%=dbLabelBean.getLabel("label.requisitiondetails.expday",strsesLanguage)%>"></td>
																						<td class="hotelCharges2"><input type="text" name="tourDays2" class="forex" value="0" id="tourDays2" onChange="check1();" onKeyUp="return test1(this, 3, 'n');" title="<%=dbLabelBean.getLabel("label.requisition.tourdays",strsesLanguage)%>"></td>
																						<td class="contingencies"><input type="text" name="contingencies" class="forex" value="0" id="contingencies1" onChange="check1();" onKeyUp="return test1(this, 10, 'n.');" title="<%=dbLabelBean.getLabel("label.global.contigencies",strsesLanguage)%>"></td>
																						<td class="others"><input type="text" name="contingencies2" class="forex" value="0" id="contingencies2" onChange="check1();" onKeyUp="return test1(this, 10, 'n.');" title="<%=dbLabelBean.getLabel("label.mylinks.others",strsesLanguage)%>"></td>
																						<td class="total"><input type="text" name="totalForex" class="forex" value="0" id="totalforex" onChange="check1();" onKeyUp="return test1(this, 20, 'n.');" readonly="readonly" title="<%=dbLabelBean.getLabel("label.global.total",strsesLanguage)%>"></td>
																						<td class="exchRate"><input type="text" name="exRate" class="forex" value="<%=strExchRate %>" id="exrate" onChange="check1();" onKeyUp="return test1(this, 20, 'n.');" readonly="readonly" title="<%=dbLabelBean.getLabel("label.requisition.exchrate",strsesLanguage)%>&nbsp;(<%=dbLabelBean.getLabel("label.requisition.inr",strsesLanguage)%>)" disabled="disabled"></td>
																						<td class="totalAmount"><input type="text" name="totalInr" class="forex" value="0.00" id="totalinr" onChange="check1();" onKeyUp="return test1(this, 20, 'n.');" readonly="readonly" title="<%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage)%>&nbsp;(<%=strBaseCur%>)"></td>
																						<td class="action"></td>										
																					    <input name="hd" id="hd" type="hidden" value="v" />
																					</tr>
																					<%} %>
																					<tr class="innerRowForex"></tr>									
																					<tr class="prototypeRowForex">
																					 	<td class="srno"><span class="spn"></span></td>
																						<td class="currency">
																							<select name="expCurrency" id="expCurrency" class="combo-currencyType" title="Currency Preference" onchange="fun_exchangerate(this);">
																							 	<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectcurrency",strsesLanguage) %></option>
																									<%
																										strSql = "Select rtrim(Currency), rtrim(Currency) from m_currency where status_id=10";
																										rs = dbConBean.executeQuery(strSql);
																										while (rs.next()) {%>
																		                             		<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>  
																									<%}
																	  									rs.close();
																	  								%> 
																		                     </select>											
																						</td>
																						<td class="dailyAllowances1"><input type="text" name="entitlement" class="forex" value="0" id="entitlement1" onChange="check1();" onKeyUp="return test1(this, 10, 'n');" title="<%=dbLabelBean.getLabel("label.requisitiondetails.expday",strsesLanguage)%>"></td>
																						<td class="dailyAllowances2"><input type="text" name="tourDays" class="forex" value="0" id="tourDays1" onChange="check1();" onKeyUp="return test1(this, 3, 'n');" title="<%=dbLabelBean.getLabel("label.requisition.tourdays",strsesLanguage)%>"></td>
																						<td class="hotelCharges1"><input type="text" name="entitlement2" class="forex" value="0" id="entitlement2" onChange="check1();" onKeyUp="return test1(this, 10, 'n');" title="<%=dbLabelBean.getLabel("label.requisitiondetails.expday",strsesLanguage)%>"></td>
																						<td class="hotelCharges2"><input type="text" name="tourDays2" class="forex" value="0" id="tourDays2" onChange="check1();" onKeyUp="return test1(this, 3, 'n');" title="<%=dbLabelBean.getLabel("label.requisition.tourdays",strsesLanguage)%>"></td>
																						<td class="contingencies"><input type="text" name="contingencies" class="forex" value="0" id="contingencies1" onChange="check1();" onKeyUp="return test1(this, 10, 'n.');" title="<%=dbLabelBean.getLabel("label.global.contigencies",strsesLanguage)%>"></td>
																						<td class="others"><input type="text" name="contingencies2" class="forex" value="0" id="contingencies2" onChange="check1();" onKeyUp="return test1(this, 10, 'n.');" title="<%=dbLabelBean.getLabel("label.mylinks.others",strsesLanguage)%>"></td>
																						<td class="total"><input type="text" name="totalForex" class="forex" value="0" id="totalforex" onChange="check1();" onKeyUp="return test1(this, 20, 'n.');" readonly="readonly" title="<%=dbLabelBean.getLabel("label.global.total",strsesLanguage)%>"></td>
																						<td class="exchRate"><input type="text" name="exRate" class="forex" value="0.000000" id="exrate" onChange="check1();" onKeyUp="return test1(this, 20, 'n.');" readonly="readonly" title="<%=dbLabelBean.getLabel("label.requisition.exchrate",strsesLanguage)%>&nbsp;(<%=dbLabelBean.getLabel("label.requisition.inr",strsesLanguage)%>)" disabled="disabled"></td>
																						<td class="totalAmount"><input type="text" name="totalInr" class="forex" value="0.00" id="totalinr" onChange="check1();" onKeyUp="return test1(this, 20, 'n.');" readonly="readonly" title="<%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage)%>&nbsp;(<%=strBaseCur%>)"></td>
																						<td class="action"><img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0"	id="bt-Del-Curr" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"></td>										
																					    <input name="hd" id="hd" type="hidden" value="h" />
																					</tr>
																					<tr>
																						<td class="inrTxt" colspan="10">
																							<div class="multipleCurr"><%=dbLabelBean.getLabel("label.createrequest.toaddmultiplecurrencieskindlypressaddcurrency",strsesLanguage)%></div>
																							<div class="inr"><%=strBaseCur %></div>
																						</td>
																						<td class="totalAmount"><input type="text" name="grandTotalForex" class="forex"  id="grandTotalForexinr" onChange="check1();" onKeyUp="return test1(this, 20, 'n')" value="<%=strTotalAmount%>" title="<%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage)%>&nbsp;(<%=dbLabelBean.getLabel("label.requisition.inr",strsesLanguage)%>)"></td>
																						<td class="action"></td>										
																					</tr>
																					<tr>
																						<td class="usdPerDay" colspan="10">
																							<input type="button" value="<%=dbLabelBean.getLabel("label.currency.addcurrency",strsesLanguage)%>" class="bt-Add-Curr-Dom" id="bt_Add-Curr" title="<%=dbLabelBean.getLabel("label.currency.addcurrency",strsesLanguage)%>"/>
																							<div><%=dbLabelBean.getLabel("label.createrequest.aspercorporateguidelines",strsesLanguage)%> <b><%=dbLabelBean.getLabel("label.createrequest.usdperday",strsesLanguage)%></b></div>
																						</td>
																						<td class="totalAmount"><input type="text" name="grandTotalForexUSD" class="forex" value="" id="grandtotalforexusd" onChange="check1();" onKeyUp="return test1(this, 20, 'n')" readonly="readonly" title="<%=dbLabelBean.getLabel("label.createrequest.usdperday",strsesLanguage)%>"></td>
																						<td class="action"></td>										
																					</tr>										
																					<tr>
																						<td class="contingenciesRemark" colspan="6">
																							<textarea name="expRemarks" class="contingenciesRemark" id="expRemarks" cols="" rows="2" placeholder="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%> / <%=dbLabelBean.getLabel("alert.global.reasonforcontigencies",strsesLanguage)%>" onKeyUp="return test2(this, 100, 'all')" maxlength="100" title="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%> / <%=dbLabelBean.getLabel("alert.global.reasonforcontigencies",strsesLanguage)%>"><%=strExpenditureRemarks %></textarea>
																						</td>
																						<td class="addTravellerTd" colspan="6">
																						<%
																							if(strwhatAction != null && !"".equals(strwhatAction) && "addBtn".equals(strwhatAction)) {
																						%>
																								<input type="button" value="<%=dbLabelBean.getLabel("label.global.addtraveler",strsesLanguage)%>" class="bt-Add-Trv-Dom"  id="bt_Add-Traveller" title="<%=dbLabelBean.getLabel("label.global.addtraveler",strsesLanguage)%>" onClick="addTravellerData(this.form, 'addTraveller');"/>
																						<%
																							} else if(strwhatAction != null && !"".equals(strwhatAction) && "updateBtn".equals(strwhatAction)) {
																						%>	
																								<input type="button" value="<%=dbLabelBean.getLabel("label.createrequest.updatedetails",strsesLanguage)%>" class="bt-Add-Trv-Dom" id="bt_Update-Traveller" title="<%=dbLabelBean.getLabel("label.createrequest.updatedetails",strsesLanguage)%>" onClick="updateTravellerData(this.form, 'updateTraveller');"/>
																						<%	
																							} else {
																						%>
																								<input type="button" value="<%=dbLabelBean.getLabel("label.global.addtraveler",strsesLanguage)%>" class="bt-Add-Trv-Dom"  id="bt_Add-Traveller" title="<%=dbLabelBean.getLabel("label.global.addtraveler",strsesLanguage)%>" onClick="addTravellerData(this.form, 'addTraveller');"/>
																						<%	
																							}
																						%>
																						</td>
																					</tr>																						
																				</tbody>
																			</table>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
													</table>
												</td>
											</tr>								
											<!--  Forex/Advance Details End -->
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>					
				</table>
			</td>
		</tr>
		<!-- Personal Traveller Detail End -->
		
		<!-- Group/Guest Traveller Detail Start -->
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="2">
					<tr><td class="hrSpace4Px"></td></tr>
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="titleBar"><%=dbLabelBean.getLabel("label.global.groupguesttravelerdetail",strsesLanguage) %></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td style="padding:0 10px 0 10px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">							
								<tr><td class="hrSpace4Px"></td></tr>
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">											
											<tr id="travellerDetailDomTr" style="display:none;">
												<td width="100%">
													<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tblTravellerDetailInt" class="forexDetail">
														<thead>
															<tr>
																<th width="3%" rowspan="2" align="center"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></th>
																<th width="12%" rowspan="2" align="center"><%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage)%></th>
																<th width="18%" align="center"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%></th>
																<th width="10%" align="center"><%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%></th>
																<th width="13%" align="center"><%=dbLabelBean.getLabel("label.global.age",strsesLanguage)%></th>
																<th width="13%" align="center">Employee Id</th>
																<th width="5%" rowspan="2"><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%></th>
																<th width="10%" rowspan="2"><%=dbLabelBean.getLabel("label.global.mealpref",strsesLanguage)%></th>
																<th width="8%" rowspan="2" align="center"><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage)%></th>
																<th width="8%" rowspan="2" align="center"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></th>										
															</tr>
															<tr>
																 <th width="16%" align="center"><%=dbLabelBean.getLabel("label.global.identityname",strsesLanguage)%></th>
																 <th width="10%" align="center"><%=dbLabelBean.getLabel("label.global.identitynumber",strsesLanguage)%></th>
																 <th width="10%" align="center"><%=dbLabelBean.getLabel("label.global.mobileno",strsesLanguage)%></th>
																 <th width="10%" align="center"><%=dbLabelBean.getLabel("label.global.emailid",strsesLanguage)%></th>
															 </tr>
														   </thead>
														   <tbody>
														   	<%
																if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new") && strTravelType.equals("D")) {
																	strSql =" SELECT G_EMP_CODE, G_EMAIL, G_USERID, SITE_ID, FIRST_NAME, LAST_NAME, DBO.DESIGNATIONNAME(DESIG_ID) AS DESIG, ISNULL(DBO.CONVERTDATEDMY1(DOB),'-') AS DOB, AGE, GENDER, "+
																				" ISNULL(DBO.MEAL_NAME(MAEL_ID),'-') AS MEALNAME, IDENTITY_ID, IDENTITY_NO, ISNULL(MOBILE_NO,'') AS MOBILE_NO, TOTAL_AMOUNT, ISNULL(RETURN_TRAVEL,'n') AS RETURN_TRAVEL "+
																				" FROM T_GROUP_USERINFO WHERE (TRAVEL_ID = "+strTravelId+" ) AND TRAVEL_TYPE = 'D' AND STATUS_ID=10 ORDER BY FIRST_NAME";
																	rsGroupGuest2 = dbConBean.executeQuery(strSql);  
																    while(rsGroupGuest2.next()) {
																    	strGrpTrvExists					= "true";
																    	strTrvUserId					= rsGroupGuest2.getString("G_USERID");
																    	strFirstNameList				= rsGroupGuest2.getString("FIRST_NAME");
																    	strLastNameList					= rsGroupGuest2.getString("LAST_NAME");
																    	strDesignList					= rsGroupGuest2.getString("DESIG");
																    	strDOBList						= rsGroupGuest2.getString("DOB");
																    	strAgeList						= rsGroupGuest2.getString("AGE");
																    	strGenderList					= rsGroupGuest2.getString("GENDER");
																    	strMealPrefList					= rsGroupGuest2.getString("MEALNAME");
																    	strIdentityProofList			= rsGroupGuest2.getString("IDENTITY_ID");
																    	strIdentityProofNoList			= rsGroupGuest2.getString("IDENTITY_NO");
																    	strMobileNoList					= rsGroupGuest2.getString("MOBILE_NO");
																    	strGrpTrvReturnTravel			= rsGroupGuest2.getString("RETURN_TRAVEL");
																    	strTotalForexList				= rsGroupGuest2.getString("TOTAL_AMOUNT");
																    	
																    	strGrpTrvEmpIdList				= rsGroupGuest2.getString("G_EMP_CODE") == null ? "" : rsGroupGuest2.getString("G_EMP_CODE").trim();
																    	strGrpTrvEmailAddressList		= rsGroupGuest2.getString("G_EMAIL") == null ? "" : rsGroupGuest2.getString("G_EMAIL").trim();
																    	
																    	if(strGenderList.equals("1")) {
																    		strSex="Male";
																    	} else {
																    		strSex="Female";
																	    }
																    	
																    	if(strGrpTrvReturnTravel.equalsIgnoreCase("y")) {
																    		strchecked = "checked";
																		} else {
																			strchecked = ""; 
																		}
																    	
																    	strSql = "SELECT IDENTITY_NAME FROM M_IDENTITY_PROOF WHERE IDENTITY_ID="+strIdentityProofList+" AND STATUS_ID=10";
												   				        rs= dbConBean1.executeQuery(strSql);
																		   while(rs.next()) {  
																			   strIdentityProofList = rs.getString(1); 
																		   }
																		rs.close();
															%>
																		<tr>
																   			<td rowspan="2" align="center">
																   				<div class="srNum"><%=intSerialNo%>.</div>
																   				<div class="chkBox" style="display: none;"><input type="checkbox" name="userids" value="<%=strTrvUserId%>"  <%=strchecked %> /></div>
																   				<div class="hashText" style="display: none;">#</div>
																		   	</td>
																	   		<td rowspan="2" align="center"><%=strFirstNameList %>  <%=strLastNameList %></td>
																	   		<td align="center"><%=strDesignList %></td>
																	   		<td align="center"><%=strDOBList %></td>
																	   		<td align="center"><%=strAgeList %></td>
																	   		<td align="center"><%=strGrpTrvEmpIdList %></td>
																	   		<td rowspan="2" align="center"><%=strSex %></td>
																	   		<td rowspan="2" align="center"><%=strMealPrefList %></td>
																	   		<td rowspan="2" align="center"><%=strBaseCur %> <%=strTotalForexList %></td>
																	   		<td rowspan="2" align="center">
																	   			<span class="link"><a href="T_Group_QuickTravel_Detail_MATA.jsp?G_userId=<%=strTrvUserId%>&travelId=<%=strTravelId%>&travelReqNo=<%=strTravelReqNo%>&travelReqId=<%=strTravelReqId%>&travellerId=<%=strTravellerId%>&interimId=<%=strIntermiId%>&travel_type=<%=strTravelType%>&action=updateBtn" onClick="return"><%=dbLabelBean.getLabel("link.createrequest.edit",strsesLanguage) %></a></span>
																	   			&nbsp;|&nbsp;
																	   			<span class="link"><a href="GroupGuest_User_Delete.jsp?G_userId=<%=strTrvUserId%>&travelId=<%=strTravelId%>&travelReqNo=<%=strTravelReqNo%>&travelReqId=<%=strTravelReqId%>&travellerId=<%=strTravellerId%>&interimId=<%=strIntermiId%>&travel_type=<%=strTravelType%>&action=addBtn" onClick="return  deleteConfirm();"><%=dbLabelBean.getLabel("link.createrequest.delete",strsesLanguage) %></a></span>
																	   		</td>
																   		</tr>
																   		<tr>
																   			<td align="center"><%=strIdentityProofList %></td>
																   			<td align="center"><%=strIdentityProofNoList %></td>
																   			<td align="center"><%=strMobileNoList %></td>
																   			<td align="center"><%=strGrpTrvEmailAddressList %></td>
																   		</tr>
															<%
																		intSerialNo++;
																    }
																    rsGroupGuest2.close();
																}
															%>
														   		
														   </tbody>																	                   
													</table>
												</td>
											</tr>
											<tr id="travellerDetailIntTr" style="display:none;">
												<td width="100%">
													<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tblTravellerDetailInt" class="forexDetail">
														<thead>
															<tr>
																<th width="3%" rowspan="2" align="center"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></th>
																<th width="12%" rowspan="2" align="center"><%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage)%></th>
																<th width="8%" align="center"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%></th>
																<th width="8%" align="center"><%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%></th>
																<th width="10%" align="center"><%=dbLabelBean.getLabel("label.global.age",strsesLanguage)%></th>
																<th width="8%" align="center"><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%></th>
																<th width="8%" align="center"><%=dbLabelBean.getLabel("label.global.mealpref",strsesLanguage)%></th>
																<th width="12%" align="center">Employee Id</th>
																<th width="6%" align="center"><%=dbLabelBean.getLabel("label.global.visarequired",strsesLanguage)%></th>
																<th width="6%" rowspan="2" align="center"><%=dbLabelBean.getLabel("label.global.totalforex",strsesLanguage)%></th>
																<th width="8%" rowspan="2" align="center"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></th>										
															</tr>
															<tr>
																 <th width="8%" align="center"><%=dbLabelBean.getLabel("label.createrequest.passportnumber",strsesLanguage)%></th>
																 <th width="8%" align="center"><%=dbLabelBean.getLabel("label.user.nationality",strsesLanguage)%></th>
																 <th width="10%" align="center"><%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%></th>
																 <th width="8%" align="center"><%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%></th>
																 <th width="8%" align="center"><%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage)%></th>
																 <th width="12%" align="center"><%=dbLabelBean.getLabel("label.global.emailid",strsesLanguage)%></th>
																 <th width="6%" align="center"><%=dbLabelBean.getLabel("label.mail.ecrrequired",strsesLanguage)%></th>
															 </tr>
														   </thead>
														   <tbody>
														   	<%
																if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new") && strTravelType.equals("I")) {
																	strSql =" SELECT G_EMP_CODE, G_EMAIL, G_USERID, SITE_ID, FIRST_NAME, LAST_NAME, DBO.DESIGNATIONNAME(DESIG_ID) AS DESIG, ISNULL(DBO.CONVERTDATEDMY1(DOB),'-') AS DOB, AGE, GENDER, "+
																		        " ISNULL(DBO.MEAL_NAME(MAEL_ID),'-') AS  MEALNAME, PASSPORT_NO, ISNULL(NATIONALITY ,'') AS NATIONALITY, PLACE_OF_ISSUE, " +
																		        " ISNULL(DBO.CONVERTDATEDMY1(DATE_OF_ISSUE),'-') AS DATE_OF_ISSUE, ISNULL(DBO.CONVERTDATEDMY1(EXPIRY_DATE),'-') AS EXPIRY_DATE, TOTAL_AMOUNT, "+
																		        " ECNR, VISA_REQUIRED, ISNULL(RETURN_TRAVEL,'n') AS RETURN_TRAVEL "+
														 				        " FROM T_GROUP_USERINFO WHERE (TRAVEL_ID = "+strTravelId+" ) AND TRAVEL_TYPE = 'I' AND STATUS_ID=10 ORDER BY FIRST_NAME";
																	
																	rsGroupGuest2 = dbConBean.executeQuery(strSql);  
																    while(rsGroupGuest2.next()) {
																    	strGrpTrvExists					= "true";
																    	strTrvUserId					= rsGroupGuest2.getString("G_USERID");
																    	strFirstNameList				= rsGroupGuest2.getString("FIRST_NAME");
																    	strLastNameList					= rsGroupGuest2.getString("LAST_NAME");
																    	strDesignList					= rsGroupGuest2.getString("DESIG");
																    	strDOBList						= rsGroupGuest2.getString("DOB");
																    	strAgeList						= rsGroupGuest2.getString("AGE");
																    	strGenderList					= rsGroupGuest2.getString("GENDER");
																    	strMealPrefList					= rsGroupGuest2.getString("MEALNAME");
																    	strPassportNoList				= rsGroupGuest2.getString("PASSPORT_NO");
																    	strNationalityList				= rsGroupGuest2.getString("NATIONALITY");
																    	strPasprtIssuePlaceList			= rsGroupGuest2.getString("PLACE_OF_ISSUE");
																    	strPasprtIssueDateList			= rsGroupGuest2.getString("DATE_OF_ISSUE");
																    	strPasprtExpiryDateList			= rsGroupGuest2.getString("EXPIRY_DATE");
																    	strVisaRequiredList				= rsGroupGuest2.getString("VISA_REQUIRED");
																    	strEcrRequiredList				= rsGroupGuest2.getString("ECNR");
																    	strGrpTrvReturnTravel			= rsGroupGuest2.getString("RETURN_TRAVEL");
																    	strTotalForexList				= rsGroupGuest2.getString("TOTAL_AMOUNT");
																    	
																    	strGrpTrvEmpIdList				= rsGroupGuest2.getString("G_EMP_CODE") == null ? "" : rsGroupGuest2.getString("G_EMP_CODE").trim();
																    	strGrpTrvEmailAddressList		= rsGroupGuest2.getString("G_EMAIL") == null ? "" : rsGroupGuest2.getString("G_EMAIL").trim();
																    	
																    	if(strGenderList.equals("1")) {
																    		strSex="Male";
																    	} else {
																    		strSex="Female";
																	    }
																    	
																    	if(strVisaRequiredList!=null) {
																			if(strVisaRequiredList.trim().equals("1")) {
																				strVisaReq="Yes";
																			} else if(strVisaRequiredList.trim().equals("2")) {
																				strVisaReq="No";
																			} 
																		}
																    	
																    	if(strEcrRequiredList!=null) {
																			if(strEcrRequiredList.trim().equals("1")) {
																				strEcrReq="Yes";
																			} else if(strEcrRequiredList.trim().equals("2")) {
																				strEcrReq="No";
																			} else if(strEcrRequiredList.trim().equals("3")) {
																				strEcrReq="N/A";
																			}
																		}
																    	
																    	if(strGrpTrvReturnTravel.equalsIgnoreCase("y")) {
																    		strchecked = "checked";
																		} else {
																			strchecked = ""; 
																		}															    	
																		
															%>
																		<tr>
																   			<td rowspan="2" align="center">
																   				<div class="srNum"><%=intSerialNo%>.</div>
																   				<div class="chkBox" style="display: none;"><input type="checkbox" name="userids" value="<%=strTrvUserId%>"  <%=strchecked %> /></div>
																   				<div class="hashText" style="display: none;">#</div>
																		   	</td>
																			<td rowspan="2" align="center"><%=strFirstNameList %>  <%=strLastNameList %></td>
																	   		<td align="center"><%=strDesignList %></td>
																	   		<td align="center"><%=strDOBList %></td>
																	   		<td align="center"><%=strAgeList %></td>
																	   		<td align="center"><%=strSex %></td>
																	   		<td align="center"><%=strMealPrefList %></td>
																	   		<td align="center"><%=strGrpTrvEmpIdList %></td>
																	   		<td align="center"><%=strVisaReq %></td>
																	   		<td rowspan="2" align="center"><%=strBaseCur %> <%=strTotalForexList %></td>
																	   		<td rowspan="2" align="center">
																	   			<span class="link"><a href="T_Group_QuickTravel_Detail_MATA.jsp?G_userId=<%=strTrvUserId%>&travelId=<%=strTravelId%>&travelReqNo=<%=strTravelReqNo%>&travelReqId=<%=strTravelReqId%>&travellerId=<%=strTravellerId%>&interimId=<%=strIntermiId%>&travel_type=<%=strTravelType%>&action=updateBtn" onClick="return"><%=dbLabelBean.getLabel("link.createrequest.edit",strsesLanguage) %></a></span>
																	   			&nbsp;|&nbsp;
																	   			<span class="link"><a href="GroupGuest_User_Delete.jsp?G_userId=<%=strTrvUserId%>&travelId=<%=strTravelId%>&travelReqNo=<%=strTravelReqNo%>&travelReqId=<%=strTravelReqId%>&travellerId=<%=strTravellerId%>&interimId=<%=strIntermiId%>&travel_type=<%=strTravelType%>&action=addBtn" onClick="return  deleteConfirm();"><%=dbLabelBean.getLabel("link.createrequest.delete",strsesLanguage) %></a></span>
																	   		</td>
																   		</tr>
																   		<tr>
																   			<td align="center"><%=strPassportNoList %></td>
																   			<td align="center"><%=strNationalityList %></td>
																   			<td align="center"><%=strPasprtIssuePlaceList %></td>
																   			<td align="center"><%=strPasprtIssueDateList %></td>
																   			<td align="center"><%=strPasprtExpiryDateList %></td>
																   			<td align="center"><%=strGrpTrvEmailAddressList %></td>
																   			<td align="center"><%=strEcrReq %></td>
																   		</tr>
															<%		
																		intSerialNo++;
																    }
																    rsGroupGuest2.close();
																}
															%>
														   		
														   		
														   </tbody>																		                   
													</table>
												</td>
											</tr>
											<%
												if(strGrpTrvExists.equals("true")) {
											%>
											<tr style="display: none;">
												<td>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr><td class="hrSpace2Px" colspan="2"></td></tr>
														<tr>
															<td class="returnJrnChk1">#</td>
															<td class="returnJrnChk2"><%=dbLabelBean.getLabel("message.createrequest.selectcheckboxforreturnjourney",strsesLanguage) %></td>
														</tr>
													</table>
												</td>
											</tr>
											<% } %>
										</table>
									</td>
								</tr>
								<tr><td class="hrSpace4Px"></td></tr>
							</table>
						</td>
					</tr>					
				</table>
			</td>
		</tr>
		<!-- Group/Guest Traveller Detail End -->
		
		<!-- Itinerary Detail Start -->
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="2">
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="titleBar"><%=dbLabelBean.getLabel("label.global.journeydetails",strsesLanguage) %></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="2" cellpadding="5">
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								
								
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<!-- Flight Details Start -->
											<tr valign="top" id="flightDetailBlock">
												<td>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr valign="top" id="flightDetailBtn">
															<td class="journyType" style="padding:5px 0 0 0; border-top:1px solid #aea899;">
																<table width="230px" border="0" cellspacing="0" cellpadding="0">
																	<tr>
																		<td class="journyDetailLabel"><label
																			class="modeType"><b><%=dbLabelBean.getLabel("label.global.flightdetails",strsesLanguage) %></b></label></td>
																		<td class="journyDetailRadio">
																			<table width="100%" border="0" cellspacing="0"
																				cellpadding="0" class="checkbox">
																				<tr>
																					<td class="labelTd"><label class="yes"
																						id="flightRequiredYes"> <input type="radio"
																							name="flight" value="1" id="flightRequired_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
																					</label></td>
																					<td class="labelTd"><label class="no"
																						id="flightRequiredNo"> <input type="radio"
																							name="flight" value="2" checked="checked"
																							id="flightRequired_N"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
																					</label></td>
																				</tr>
																			</table>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
														<tr valign="top" id="flightDetail" style="display: none;">
															<td style="border:1px solid #e0dfdf;">
																<table width="100%" border="0" cellspacing="0" cellpadding="0">
																	<tr valign="top">
																		<td style="padding:0 0 5px 20px;">
																			<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tblItineraryFlight">
																				<tbody>
																						<%
																							if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																								if(strTravelType.equals("D")) {
																									strSql =" SELECT 'Forword' as JOURNEY,TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(ISNULL(TJDD.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																											" ISNULL(TRAVEL_CLASS,'1') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE, TJDD.TICKET_REFUNDABLE AS TICKET_REFUNDABLE "+
																											" FROM T_TRAVEL_DETAIL_DOM (nolock) AS TTDD INNER JOIN T_JOURNEY_DETAILS_DOM (nolock) AS TJDD ON TTDD.TRAVEL_ID = TJDD.TRAVEL_ID "+
																											" WHERE TTDD.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1 AND JOURNEY_ORDER =(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1 AND STATUS_ID=10)";
																								} else if(strTravelType.equals("I")) {
																									strSql =" SELECT 'Forword' as JOURNEY,TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(ISNULL(TJDI.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																											" ISNULL(TRAVEL_CLASS,'1') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE, TJDI.TICKET_REFUNDABLE AS TICKET_REFUNDABLE "+
																											" FROM T_TRAVEL_DETAIL_INT (nolock) AS TTDI INNER JOIN T_JOURNEY_DETAILS_INT (nolock) AS TJDI ON TTDI.TRAVEL_ID = TJDI.TRAVEL_ID "+
																											" WHERE TTDI.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1 AND JOURNEY_ORDER =(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1 AND STATUS_ID=10)";
																								}										
																	
																								rsFlt1=null;
																								rsFlt1  =   dbConBean.executeQuery(strSql);  
																								if(rsFlt1.next()) {
																									flightYNFlag 				= "true";
																									strDepCityFwdFlt           	= rsFlt1.getString("TRAVEL_FROM"); 
																									strArrCityFwdFlt           	= rsFlt1.getString("TRAVEL_TO");
																									strDepDateFwdFlt		 	= rsFlt1.getString("TRAVEL_DATE");
																									strPreferTimeModeFwdFlt		= rsFlt1.getString("PREF_TIME_TYPE");
																									strPreferTimeFwdFlt        	= rsFlt1.getString("PREFERRED_TIME");
																									strTravelClassFwdFlt       	= rsFlt1.getString("TRAVEL_CLASS");
																									strPreferAirlineFwdFlt		= rsFlt1.getString("MODE_NAME");
																									strPreferSeatFwdFlt      	= rsFlt1.getString("SEAT_PREFFERED");
																									strNonRefundableTktFwdFlt 	= rsFlt1.getString("TICKET_REFUNDABLE");
																								}
																								rsFlt1.close();
																							} 
																						%>			
																						<tr><td class="journeyTitle" colspan="8"><%=dbLabelBean.getLabel("label.global.forwardjourney",strsesLanguage)%></td></tr>
																						<tr class="itineraryDataRowFlight">
																							<td class="city"><input type="text" name="depCityFlt" class="textBoxCss" value="<%=strDepCityFwdFlt %>" id="depCityFltTBFwd" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'sector')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																							<td class="city"><input type="text" name="arrCityFlt" class="textBoxCss" value="<%=strArrCityFwdFlt %>" id="arrCityFltTBFwd" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'sector')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																							<td class="date"><input type="text" name="depDateFlt" class="textBoxCss validDateFlt validDate" value="<%=strDepDateFwdFlt %>" id="depDateFltTBFwd" onFocus="initializeJourneyDateFlt(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');" placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																							<td class="timeMode">
																								<select name="preferTimeModeFlt" class="comboBoxCss" id="preferTimeModeFltSBFwd" title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																								<%
																									types =   TravelRequestEnums.PreferredTimeTypes.values();
																										for(t=0; t<types.length; t++){
																											if(!strPreferTimeModeFwdFlt.equals("") && types[t].getId().equals(strPreferTimeModeFwdFlt)) {
																								%>
														                              							<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																								<%
												                            								} else {
												                            		 							if((strPreferTimeModeFwdFlt == null || strPreferTimeModeFwdFlt.equals("")) && types[t].getId().equals("2")) {
												                           					 	%>
														                              								<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																								<%
												                            		 							} else {
												                            					%>
												                            										<option value="<%=types[t].getId()%>"><%=types[t].getName()%></option>
												                            					<%	 
												                            			 						}
												                            	 							}
																										}
																								%>
																								</select>
																							</td>
																							<td class="time">
																								 <select name="preferTimeFlt" class="comboBoxCss" id="preferTimeFltSBFwd"  title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																										<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>
																									<%						                           
																										entrySet = preferredTimeList.entrySet();
																										it = entrySet.iterator();
																			                             while(it.hasNext()) {
																			                            	Map.Entry entry = (Map.Entry)it.next();
																			                            	if(!excludePreferredTimeList.contains(entry.getKey())) {
																											 	if(!entry.getKey().equals("102")) {
																				                            	 	if(strPreferTimeFwdFlt != null && !strPreferTimeFwdFlt.equals("") && entry.getKey().equals(strPreferTimeFwdFlt)) {
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
																			                         	 }
																									%>																																					
																		                        </select>
																							</td>
																							<td class="trClass">
																								<select name="departClassFlt" class="comboBoxCss" id="departClassFltSBFwd" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																									<%						                           
																										entrySet = flightClassList.entrySet();
																										it = entrySet.iterator();
																			                             while(it.hasNext()) {
																			                            	 Map.Entry entry = (Map.Entry)it.next();																			                            	 
																			                            	 if(strTravelClassFwdFlt != null && !strTravelClassFwdFlt.equals("") && entry.getKey().equals(strTravelClassFwdFlt)) {
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
																							<td class="flight"><input type="text" name="nameOfAirlineFlt" class="textBoxCss" value="<%=strPreferAirlineFwdFlt %>" id="nameOfAirlineFltTBFwd" placeholder="<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>" onKeyUp="return test2(this, 30, 'cn')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>"></td>
																							<td class="seat">
																								<select name="seatPreffredFlt" class="comboBoxCss" id="seatPreffredFltSBFwd" title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																									<%						                           
																										entrySet = flightWindowList.entrySet();
																										it = entrySet.iterator();
																			                             while(it.hasNext()) {
																			                            	 Map.Entry entry = (Map.Entry)it.next();																			                            	 
																			                            	 if(strPreferSeatFwdFlt != null && !strPreferSeatFwdFlt.equals("") && entry.getKey().equals(strPreferSeatFwdFlt)) {
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
																							<td class="nonRefundableTktInput">
																								<table width="100%" border="0" cellspacing="0" cellpadding="0">
																									<tr>
																										<%-- <td class="nonRefundableTkt">
																											<select name="ticketRefundFlt" class="comboBoxCss" id="ticketRefundFltSBFwd" title="<%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage)%>">
																											<%
																												if(strNonRefundableTktFwdFlt != null && !"".equals(strNonRefundableTktFwdFlt) && "y".equals(strNonRefundableTktFwdFlt)) {
																											%>
																													<option value="y"  selected="selected"><%=dbLabelBean.getLabel("label.global.refundableticket",strsesLanguage)%></option>
																													<option value="n"><%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage)%></option>
																											<%
																												} else if(strNonRefundableTktFwdFlt != null && !"".equals(strNonRefundableTktFwdFlt) && "n".equals(strNonRefundableTktFwdFlt)) {																											
																											%>
																													<option value="y"><%=dbLabelBean.getLabel("label.global.refundableticket",strsesLanguage)%></option>
																													<option value="n" selected="selected"><%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage)%></option>
																											<%
																												} else {
																											%>
																													<option value="y" selected="selected"><%=dbLabelBean.getLabel("label.global.refundableticket",strsesLanguage)%></option>
																													<option value="n"><%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage)%></option>
																											<%
																												}
																											%>
																											</select>
																										</td> --%>
																										<td class="delBtn"></td>
																									</tr>
																								</table>
																							</td>															
																						</tr>
																						
																						<tr id="intJrnyTitleRowFlight" class="hide"><td class="journeyTitle" colspan="8"><%=dbLabelBean.getLabel("label.global.intermediatejourney",strsesLanguage)%></td></tr>
																						<%
																							int i = 0;
																							if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																								if(strTravelType.equals("D")) {
																									strSql =" SELECT 'Intermediate' as JOURNEY,TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(ISNULL(TJDD.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																											" ISNULL(TRAVEL_CLASS,'1') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE, TJDD.TICKET_REFUNDABLE AS TICKET_REFUNDABLE "+
																											" FROM T_TRAVEL_DETAIL_DOM (nolock) AS TTDD INNER JOIN T_JOURNEY_DETAILS_DOM (nolock) AS TJDD ON TTDD.TRAVEL_ID = TJDD.TRAVEL_ID "+
																											" WHERE TTDD.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1 AND JOURNEY_ORDER >(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1 AND STATUS_ID=10)";
																								} else if(strTravelType.equals("I")) {
																									strSql =" SELECT 'Intermediate' as JOURNEY,TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(ISNULL(TJDI.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																											" ISNULL(TRAVEL_CLASS,'1') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE, TJDI.TICKET_REFUNDABLE AS TICKET_REFUNDABLE "+
																											" FROM T_TRAVEL_DETAIL_INT (nolock) AS TTDI INNER JOIN T_JOURNEY_DETAILS_INT (nolock) AS TJDI ON TTDI.TRAVEL_ID = TJDI.TRAVEL_ID  "+
																											" WHERE TTDI.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1 AND JOURNEY_ORDER >(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1 AND STATUS_ID=10)";
																								}		
																								
																								rsFlt2 = null;
																								rsFlt2  =   dbConBean.executeQuery(strSql);  
																								while(rsFlt2.next()) {
																									flightYNFlag 					= "true";
																									strDepCityIntrmiFlt           	= rsFlt2.getString("TRAVEL_FROM"); 
																									strArrCityIntrmiFlt           	= rsFlt2.getString("TRAVEL_TO");
																									strDepDateIntrmiFlt           	= rsFlt2.getString("TRAVEL_DATE");
																									strPreferTimeModeIntrmiFlt		= rsFlt2.getString("PREF_TIME_TYPE");
																									strPreferTimeIntrmiFlt        	= rsFlt2.getString("PREFERRED_TIME");
																									strTravelClassIntrmiFlt       	= rsFlt2.getString("TRAVEL_CLASS");
																									strPreferAirlineIntrmiFlt		= rsFlt2.getString("MODE_NAME");
																									strPreferSeatIntrmiFlt      	= rsFlt2.getString("SEAT_PREFFERED");
																									strNonRefundableTktIntrmiFlt 	= rsFlt2.getString("TICKET_REFUNDABLE");	
																								
																										if(!strDepCityIntrmiFlt.trim().equals("") || !strArrCityIntrmiFlt.trim().equals("")) {	
																						%>
																										<tr class="itineraryDataRowFlight itineraryDataRowFlightIntrmi">
																											<td class="city"><input type="text" name="depCityFlt" class="textBoxCss" value="<%=strDepCityIntrmiFlt %>" id="depCityFltTBInt" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'sector')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																											<td class="city"><input type="text" name="arrCityFlt" class="textBoxCss" value="<%=strArrCityIntrmiFlt %>" id="arrCityFltTBInt" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'sector')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																											<td class="date"><input type="text" name="depDateFlt" class="textBoxCss validDateFlt validDate" value="<%=strDepDateIntrmiFlt %>" id="depDateFltTBInt" onFocus="initializeJourneyDateFlt(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');" placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																											<td class="timeMode">
																												<select name="preferTimeModeFlt" class="comboBoxCss" id="preferTimeModeFltSBInt" title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																												<%
																													types =   TravelRequestEnums.PreferredTimeTypes.values();
																														for(t=0; t<types.length; t++){
																															if(!strPreferTimeModeIntrmiFlt.equals("") && types[t].getId().equals(strPreferTimeModeIntrmiFlt)) {
																												%>
																		                              							<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																												<%
																                            								} else {
																                            		 							if((strPreferTimeModeIntrmiFlt == null || strPreferTimeModeIntrmiFlt.equals("")) && types[t].getId().equals("1")) {
																                           					 	%>
																		                              								<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																												<%
																                            		 							} else {
																                            					%>
																                            										<option value="<%=types[t].getId()%>"><%=types[t].getName()%></option>
																                            					<%	 
																                            			 						}
																                            	 							}
																														}
																												%>
																												</select>
																											</td>
																											<td class="time">
																												 <select name="preferTimeFlt" class="comboBoxCss" id="preferTimeFltSBInt"  title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																														<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>
																													<%						                           
																														entrySet = preferredTimeList.entrySet();
																														it = entrySet.iterator();
																							                             while(it.hasNext()) {																							                            	
																								                            Map.Entry entry = (Map.Entry)it.next();
																								                            if(!excludePreferredTimeList.contains(entry.getKey())) {
																															 	if(!entry.getKey().equals("102")){
																								                            	 	if(strPreferTimeIntrmiFlt != null && !strPreferTimeIntrmiFlt.equals("") && entry.getKey().equals(strPreferTimeIntrmiFlt)) {
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
																							                         	 }
																													%>													
																						                        </select>
																											</td>
																											<td class="trClass">
																												<select name="departClassFlt" class="comboBoxCss" id="departClassFltSBInt" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																													<%						                           
																														entrySet = flightClassList.entrySet();
																														it = entrySet.iterator();
																							                             while(it.hasNext()) {
																							                            	 Map.Entry entry = (Map.Entry)it.next();																						                            	 
																							                            	 if(strTravelClassIntrmiFlt != null && !strTravelClassIntrmiFlt.equals("") && entry.getKey().equals(strTravelClassIntrmiFlt)) {
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
																											<td class="flight"><input type="text" name="nameOfAirlineFlt" class="textBoxCss" value="<%=strPreferAirlineIntrmiFlt %>" id="nameOfAirlineFltTBInt" placeholder="<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>" onKeyUp="return test2(this, 30, 'cn')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>"></td>
																											<td class="seat">
																												<select name="seatPreffredFlt" class="comboBoxCss" id="seatPreffredFltSBInt" title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																													<%						                           
																														entrySet = flightWindowList.entrySet();
																														it = entrySet.iterator();
																							                             while(it.hasNext()) {
																							                            	 Map.Entry entry = (Map.Entry)it.next();																						                            	 
																							                            	 if(strPreferSeatIntrmiFlt != null && !strPreferSeatIntrmiFlt.equals("") && entry.getKey().equals(strPreferSeatIntrmiFlt)) {
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
																											<td class="nonRefundableTktInput">
																												<table width="100%" border="0" cellspacing="0" cellpadding="0">
																													<tr>
																														<%-- <td class="nonRefundableTkt">
																															<select name="ticketRefundFlt" class="comboBoxCss" id="ticketRefundFltSBInt" title="<%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage)%>">
																															<%
																																if(strNonRefundableTktIntrmiFlt != null && !"".equals(strNonRefundableTktIntrmiFlt) && "y".equals(strNonRefundableTktIntrmiFlt)) {
																															%>
																																	<option value="y"  selected="selected"><%=dbLabelBean.getLabel("label.global.refundableticket",strsesLanguage)%></option>
																																	<option value="n"><%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage)%></option>
																															<%
																																} else if(strNonRefundableTktIntrmiFlt != null && !"".equals(strNonRefundableTktIntrmiFlt) && "n".equals(strNonRefundableTktIntrmiFlt)) {																											
																															%>
																																	<option value="y"><%=dbLabelBean.getLabel("label.global.refundableticket",strsesLanguage)%></option>
																																	<option value="n" selected="selected"><%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage)%></option>
																															<%
																																} else {
																															%>
																																	<option value="y" selected="selected"><%=dbLabelBean.getLabel("label.global.refundableticket",strsesLanguage)%></option>
																																	<option value="n"><%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage)%></option>
																															<%
																																}
																															%>				
																															</select>
																														</td> --%>
																														<td class="delBtn"><img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0"	id="bt-Del-ItInr-Flight" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"></td>
																													</tr>
																												</table>
																											</td>															
																										</tr>
																							<%
																									}
																								i++;
																								}
																								rsFlt2.close();
																							}
																							%>
																									
																						<tr class="innerRowItineraryFlight"></tr>	
																						<tr class="prototypeRowItineraryFlight">
																							<td class="city"><input type="text" name="depCityFltPT" class="textBoxCss" value="" id="depCityFltTBInt" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'sector')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																							<td class="city"><input type="text" name="arrCityFltPT" class="textBoxCss" value="" id="arrCityFltTBInt" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'sector')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																							<td class="date"><input type="text" name="depDateFltPT" class="textBoxCss validDateFlt validDate" value="" id="depDateFltTBInt" onFocus="initializeJourneyDateFlt(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');" placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																							<td class="timeMode">
																								<select name="preferTimeModeFltPT" class="comboBoxCss" id="preferTimeModeFltSBInt" title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																								<%
																									types =   TravelRequestEnums.PreferredTimeTypes.values();
																										for(t=0; t<types.length; t++){
																											if(types[t].getId().equals("1")) {
												                           					 	%>
														                              								<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																								<%
												                            		 							} else {
												                            					%>
												                            										<option value="<%=types[t].getId()%>"><%=types[t].getName()%></option>
												                            					<%	 
												                            			 						}
																										}
																								%>
																								</select>
																							</td>
																							<td class="time">
																								 <select name="preferTimeFltPT" class="comboBoxCss" id="preferTimeFltSBInt" title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																										<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>
																									<%						                           
																										entrySet = preferredTimeList.entrySet();
																										it = entrySet.iterator();
																			                             while(it.hasNext()) {
																			                            	 Map.Entry entry = (Map.Entry)it.next();
																			                            	 if(!excludePreferredTimeList.contains(entry.getKey())) {
																										 		if(!entry.getKey().equals("102")){
																									%>
																											 		<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																									<%
																			                            	 	}
																			                            	 }
																			                         	 }
																									%>											
																		                        </select>														
																							</td>
																							<td class="trClass">
																								<select name="departClassFltPT" class="comboBoxCss" id="departClassFltSBInt" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																									<%						                           
																										entrySet = flightClassList.entrySet();
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
																							<td class="flight"><input type="text" name="nameOfAirlineFltPT" class="textBoxCss" value="" id="nameOfAirlineFltTBInt" placeholder="<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>" onKeyUp="return test2(this, 30, 'cn')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>"></td>
																							<td class="seat">
																								<select name="seatPreffredFltPT" class="comboBoxCss" id="seatPreffredFltSBInt" title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																									<%						                           
																										entrySet = flightWindowList.entrySet();
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
																							<td class="nonRefundableTktInput">
																								<table width="100%" border="0" cellspacing="0" cellpadding="0">
																									<tr>
																										<%-- <td class="nonRefundableTkt">
																											<select name="ticketRefundFltPT" class="comboBoxCss" id="ticketRefundFltSBInt" title="<%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage)%>">
																												<option value="y" selected="selected"><%=dbLabelBean.getLabel("label.global.refundableticket",strsesLanguage)%></option>
																												<option value="n"><%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage)%></option>	
																											</select>
																										</td> --%>
																										<td class="delBtn"><img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0"	id="bt-Del-ItInr-Flight" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"></td>
																									</tr>
																								</table>
																							</td>
																						</tr>
																					 
																					 <%
																						if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																							if(strTravelType.equals("D")) {
																								  strSql = " SELECT 'Return' as Journey, RETURN_FROM, RETURN_TO, DBO.CONVERTDATEDMY1(ISNULL(TJRDD.TRAVEL_DATE, '')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																										   " ISNULL(TRAVEL_CLASS,'1') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE, TJRDD.TICKET_REFUNDABLE AS TICKET_REFUNDABLE "+
																										   " FROM T_TRAVEL_DETAIL_DOM (nolock) AS TTDD INNER JOIN T_RET_JOURNEY_DETAILS_DOM (nolock) AS TJRDD ON TTDD.TRAVEL_ID = TJRDD.TRAVEL_ID WHERE TTDD.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1";
																							  } else if(strTravelType.equals("I")) {
																								  strSql = " SELECT 'Return' as Journey, RETURN_FROM, RETURN_TO, DBO.CONVERTDATEDMY1(ISNULL(TJRDI.TRAVEL_DATE, '')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																										   " ISNULL(TRAVEL_CLASS,'1') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE, TJRDI.TICKET_REFUNDABLE AS TICKET_REFUNDABLE "+
																										   " FROM T_TRAVEL_DETAIL_INT (nolock) AS TTDI INNER JOIN T_RET_JOURNEY_DETAILS_INT (nolock) AS TJRDI ON TTDI.TRAVEL_ID = TJRDI.TRAVEL_ID WHERE TTDI.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=1";
																							  }											
														
																							rsFlt3=null;
																							rsFlt3  =   dbConBean.executeQuery(strSql);  
																							if(rsFlt3.next()) {
																								flightYNFlag 			   	= "true";
																								strDepCityRetFlt           	= rsFlt3.getString("RETURN_FROM"); 
																								strArrCityRetFlt           	= rsFlt3.getString("RETURN_TO");
																								strDepDateRetFlt           	= rsFlt3.getString("TRAVEL_DATE");	
																								strPreferTimeModeRetFlt		= rsFlt3.getString("PREF_TIME_TYPE");
																								strPreferTimeRetFlt        	= rsFlt3.getString("PREFERRED_TIME");
																								strTravelClassRetFlt       	= rsFlt3.getString("TRAVEL_CLASS");
																								strPreferAirlineRetFlt		= rsFlt3.getString("MODE_NAME");
																								strPreferSeatRetFlt      	= rsFlt3.getString("SEAT_PREFFERED");
																								strNonRefundableTktRetFlt 	= rsFlt3.getString("TICKET_REFUNDABLE");	
																							}
																							rsFlt3.close();
																						} 
																					%>	
																					    <tr><td class="journeyTitle" colspan="8"><%=dbLabelBean.getLabel("label.global.returnjourney",strsesLanguage)%></td></tr>
																						<tr class="itineraryDataRowFlight">
																							<td class="city"><input type="text" name="depCityFlt" class="textBoxCss" value="<%=strDepCityRetFlt %>" id="depCityFltTBRet" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'sector')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																							<td class="city"><input type="text" name="arrCityFlt" class="textBoxCss" value="<%=strArrCityRetFlt %>" id="arrCityFltTBRet" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'sector')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																							<td class="date"><input type="text" name="depDateFlt" class="textBoxCss validDateFlt validDate" value="<%=strDepDateRetFlt %>" id="depDateFltTBRet" onFocus="initializeJourneyDateFlt(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');" placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																							<td class="timeMode">
																								<select name="preferTimeModeFlt" class="comboBoxCss" id="preferTimeModeFltSBRet" title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																								<%
																									types =   TravelRequestEnums.PreferredTimeTypes.values();
																										for(t=0; t<types.length; t++){
																											if(!strPreferTimeModeRetFlt.equals("") && types[t].getId().equals(strPreferTimeModeRetFlt)) {
																								%>
														                              							<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																								<%
												                            								} else {
												                            		 							if((strPreferTimeModeRetFlt == null || strPreferTimeModeRetFlt.equals("")) && types[t].getId().equals("1")) {
												                           					 	%>
														                              								<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																								<%
												                            		 							} else {
												                            					%>
												                            										<option value="<%=types[t].getId()%>"><%=types[t].getName()%></option>
												                            					<%	 
												                            			 						}
												                            	 							}
																										}
																								%>
																								</select>
																							</td>
																							<td class="time">
																								 <select name="preferTimeFlt" class="comboBoxCss" id="preferTimeFltSBRet" title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																										<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>
																									<%						                           
																										entrySet = preferredTimeList.entrySet();
																										it = entrySet.iterator();
																			                             while(it.hasNext()) {
																			                            	Map.Entry entry = (Map.Entry)it.next();
																			                            	if(!excludePreferredTimeList.contains(entry.getKey())) {
																										 		if(!entry.getKey().equals("102")){
																			                            	 		if(strPreferTimeRetFlt != null && !strPreferTimeRetFlt.equals("") && entry.getKey().equals(strPreferTimeRetFlt)) {
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
																			                         	 }
																									%>
																		                        </select>
																							</td>
																							<td class="trClass">
																								<select name="departClassFlt" class="comboBoxCss" id="departClassFltSBRet" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																									<%						                           
																										entrySet = flightClassList.entrySet();
																										it = entrySet.iterator();
																			                             while(it.hasNext()) {
																			                            	 Map.Entry entry = (Map.Entry)it.next();																			                            	 
																			                            	 if(strTravelClassRetFlt != null && !strTravelClassRetFlt.equals("") && entry.getKey().equals(strTravelClassRetFlt)) {
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
																							<td class="flight"><input type="text" name="nameOfAirlineFlt" class="textBoxCss" value="<%=strPreferAirlineRetFlt %>" id="nameOfAirlineFltTBRet" placeholder="<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>" onKeyUp="return test2(this, 30, 'cn')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>"></td>
																							<td class="seat">
																								<select name="seatPreffredFlt" class="comboBoxCss" id="seatPreffredFltSBRet" title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																								<%						                           
																									entrySet = flightWindowList.entrySet();
																									it = entrySet.iterator();
																		                             while(it.hasNext()) {
																		                            	 Map.Entry entry = (Map.Entry)it.next();																		                            	 
																		                            	 if(strPreferSeatRetFlt != null && !strPreferSeatRetFlt.equals("") && entry.getKey().equals(strPreferSeatRetFlt)) {
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
																							<td class="nonRefundableTktInput">
																								<table width="100%" border="0" cellspacing="0" cellpadding="0">
																									<tr>
																										<%-- <td class="nonRefundableTkt">
																											<select name="ticketRefundFlt" class="comboBoxCss" id="ticketRefundFltSBRet" title="<%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage)%>">
																											<%
																												if(strNonRefundableTktRetFlt != null && !"".equals(strNonRefundableTktRetFlt) && "y".equals(strNonRefundableTktRetFlt)) {
																											%>
																													<option value="y"  selected="selected"><%=dbLabelBean.getLabel("label.global.refundableticket",strsesLanguage)%></option>
																													<option value="n"><%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage)%></option>
																											<%
																												} else if(strNonRefundableTktRetFlt != null && !"".equals(strNonRefundableTktRetFlt) && "n".equals(strNonRefundableTktRetFlt)) {																											
																											%>
																													<option value="y"><%=dbLabelBean.getLabel("label.global.refundableticket",strsesLanguage)%></option>
																													<option value="n" selected="selected"><%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage)%></option>
																											<%
																												} else {
																											%>
																													<option value="y" selected="selected"><%=dbLabelBean.getLabel("label.global.refundableticket",strsesLanguage)%></option>
																													<option value="n"><%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage)%></option>
																											<%
																												}
																											%>																										
																											</select>
																										</td> --%>
																										<td class="delBtn"></td>
																									</tr>
																								</table>
																							</td>																
																						</tr>																
																				</tbody>
																				<script language="javascript">
																					 var flightDetailFlag = '<%=flightYNFlag%>';
																					 if(flightDetailFlag === "true") {
																						$("label#flightRequiredNo").removeClass("active");
																						$("label#flightRequiredYes").addClass("active");
																						$("input:radio#flightRequired_N").attr('checked', false);
																						$("input:radio#flightRequired_Y").attr('checked', true);													
																						$("tr#flightDetail").show();	
																					 } else {
																						 $("label#flightRequiredYes").removeClass("active");
																						 $("label#flightRequiredNo").addClass("active");
																						 $("input:radio#flightRequired_Y").attr('checked', false);
																						 $("input:radio#flightRequired_N").attr('checked', true);
																						 $("tr#flightDetail").hide();
																					 }
																				 
																					var rowLength = $("table#tblItineraryFlight tbody tr.itineraryDataRowFlight").length;
																					if(rowLength > 2 && $("tr#intJrnyTitleRowFlight").hasClass("hide")){
																						$("tr#intJrnyTitleRowFlight").removeClass("hide");
																						$("tr#intJrnyTitleRowFlight").addClass("show");
																					}
																				</script>																				
																			</table>
																		</td>
																	</tr>
																	<tr valign="top">
																		<td>
																			<table width="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td class="itenaryRemark">
																						<textarea name="remarksFlt" id="remarksFlt" class="textAreaCss" rows="" cols="" onKeyUp="return test2(this, 1000, 'cn')" maxlength="1000" placeholder="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>"><%=strRemarkFlt %></textarea>
																					</td>
																					<td class="addIntrimJourneyBtn"><input type="button" value="<%=dbLabelBean.getLabel("link.global.intermediatejourney",strsesLanguage)%>" class="bt-Add-Dom" id="bt_Add-Flight" title=""/></td>	
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
											<!-- Flight Details End -->
											
											<!-- Train Details Start -->
											<tr valign="top" id="trainDetailBlock" style="display: none;">
												<td>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr><td class="hrSpace6Px"></td></tr>
														<tr valign="top" id="trainDetailBtn">
															<td class="journyType" style="padding:5px 0 0 0; border-top:1px solid #aea899;">
																<table width="230px" border="0" cellspacing="0" cellpadding="0">
																	<tr>
																		<td class="journyDetailLabel"><label
																			class="modeType"><b><%=dbLabelBean.getLabel("label.global.traindetails",strsesLanguage) %></b></label></td>
																		<td class="journyDetailRadio">
																			<table width="100%" border="0" cellspacing="0"
																				cellpadding="0" class="checkbox">
																				<tr>
																					<td class="labelTd"><label class="yes"
																						id="trainRequiredYes"> <input type="radio"
																							name="train" value="1" id="trainRequired_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
																					</label></td>
																					<td class="labelTd"><label class="no"
																						id="trainRequiredNo"> <input type="radio"
																							name="train" value="2" checked="checked"
																							id="trainRequired_N"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
																					</label></td>
																				</tr>
																			</table>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
														<tr valign="top" id="trainDetail" style="display: none;">
															<td style="border:1px solid #e0dfdf;">
																<table width="100%" border="0" cellspacing="0" cellpadding="0">
																	<tr valign="top">
																		<td style="padding:0 0 5px 20px;">
																			<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tblItineraryTrain">
																				<tbody>
																						<%
																							if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																								if(strTravelType.equals("D")) {
																									strSql =" SELECT 'Forword' as JOURNEY,TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(ISNULL(TJDD.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																											" ISNULL(TRAVEL_CLASS,'5') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'3') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE, TTDD.FORWARD_TATKAAL AS FORWARD_TATKAAL "+
																											" FROM T_TRAVEL_DETAIL_DOM (nolock) AS TTDD INNER JOIN T_JOURNEY_DETAILS_DOM (nolock) AS TJDD ON TTDD.TRAVEL_ID = TJDD.TRAVEL_ID "+
																											" WHERE TTDD.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2 AND JOURNEY_ORDER =(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2 AND STATUS_ID=10)";
																								} else if(strTravelType.equals("I")) {
																									strSql =" SELECT 'Forword' as JOURNEY,TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(ISNULL(TJDI.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																											" ISNULL(TRAVEL_CLASS,'5') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'3') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE "+
																											" FROM T_TRAVEL_DETAIL_INT (nolock) AS TTDI INNER JOIN T_JOURNEY_DETAILS_INT (nolock) AS TJDI ON TTDI.TRAVEL_ID = TJDI.TRAVEL_ID  "+
																											" WHERE TTDI.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2 AND JOURNEY_ORDER =(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2 AND STATUS_ID=10)";
																								}
																	
																								rsTrn1=null;
																								rsTrn1  =   dbConBean.executeQuery(strSql);  
																								if(rsTrn1.next()) {
																									trainYNFlag 				= "true";
																									strDepCityFwdTrn           	= rsTrn1.getString("TRAVEL_FROM"); 
																									strArrCityFwdTrn           	= rsTrn1.getString("TRAVEL_TO");
																									strDepDateFwdTrn		 	= rsTrn1.getString("TRAVEL_DATE");
																									strPreferTimeModeFwdTrn		= rsTrn1.getString("PREF_TIME_TYPE");
																									strPreferTimeFwdTrn        	= rsTrn1.getString("PREFERRED_TIME");
																									strTravelClassFwdTrn       	= rsTrn1.getString("TRAVEL_CLASS");
																									strPreferAirlineFwdTrn		= rsTrn1.getString("MODE_NAME");
																									strPreferSeatFwdTrn      	= rsTrn1.getString("SEAT_PREFFERED");
																									if(strTravelType.equals("D")) {
																										strTatkalTicketReqFwdTrn	= rsTrn1.getString("FORWARD_TATKAAL");
																									}
																								}
																								rsTrn1.close();
																							} 
																						%>
																						<tr><td class="journeyTitle" colspan="8"><%=dbLabelBean.getLabel("label.global.forwardjourney",strsesLanguage)%></td></tr>
																						<tr class="itineraryDataRowTrain">
																							<td class="city"><input type="text" name="depCityTrn" class="textBoxCss" value="<%=strDepCityFwdTrn %>" id="depCityTrnTBFwd" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'sector')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																							<td class="city"><input type="text" name="arrCityTrn" class="textBoxCss" value="<%=strArrCityFwdTrn %>" id="arrCityTrnTBFwd" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'sector')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																							<td class="date"><input type="text" name="depDateTrn" class="textBoxCss validDateTrn validDate" value="<%=strDepDateFwdTrn %>" id="depDateTrnTBFwd" onFocus="initializeJourneyDateTrn(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');" placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																							<td class="timeMode">
																								<select name="preferTimeModeTrn" class="comboBoxCss" id="preferTimeModeTrnSBFwd" title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																								<%
																									types =   TravelRequestEnums.PreferredTimeTypes.values();
																										for(t=0; t<types.length; t++){
																											if(!strPreferTimeModeFwdTrn.equals("") && types[t].getId().equals(strPreferTimeModeFwdTrn)) {
																								%>
														                              							<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																								<%
												                            								} else {
												                            		 							if((strPreferTimeModeFwdTrn == null || strPreferTimeModeFwdTrn.equals("")) && types[t].getId().equals("2")) {
												                           					 	%>
														                              								<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																								<%
												                            		 							} else {
												                            					%>
												                            										<option value="<%=types[t].getId()%>"><%=types[t].getName()%></option>
												                            					<%	 
												                            			 						}
												                            	 							}
																										}
																								%>
																								</select>
																							</td>
																							<td class="time">
																								 <select name="preferTimeTrn" class="comboBoxCss" id="preferTimeTrnSBFwd"  title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																										<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>
																									<%						                           
																										entrySet = preferredTimeList.entrySet();
																										it = entrySet.iterator();
																			                             while(it.hasNext()) {
																			                            	Map.Entry entry = (Map.Entry)it.next();
																			                            	if(!excludePreferredTimeList.contains(entry.getKey())) {
																										 		if(!entry.getKey().equals("102")) {
																			                            	 		if(strPreferTimeFwdTrn != null && !strPreferTimeFwdTrn.equals("") && entry.getKey().equals(strPreferTimeFwdTrn)) {
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
																			                         	 }
																									%>													
																		                        </select>
																							</td>
																							<td class="trClass">
																								<select name="departClassTrn" class="comboBoxCss" id="departClassTrnSBFwd" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																									<%						                           
																										entrySet = trainClassList.entrySet();
																										it = entrySet.iterator();
																			                             while(it.hasNext()) {
																			                            	 Map.Entry entry = (Map.Entry)it.next();																			                            	 
																			                            	 if(strTravelClassFwdTrn != null && !strTravelClassFwdTrn.equals("") && entry.getKey().equals(strTravelClassFwdTrn)) {
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
																							<td class="flight"><input type="text" name="nameOfAirlineTrn" class="textBoxCss" value="<%=strPreferAirlineFwdTrn %>" id="nameOfAirlineTrnTBFwd" placeholder="<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>" onKeyUp="return test2(this, 30, 'cn')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>"></td>
																							<td class="seat">
																								<select name="seatPreffredTrn" class="comboBoxCss" id="seatPreffredTrnSBFwd" title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																									<%						                           
																										entrySet = trainWindowList.entrySet();
																										it = entrySet.iterator();
																			                             while(it.hasNext()) {
																			                            	 Map.Entry entry = (Map.Entry)it.next();																			                            	 
																			                            	 if(strPreferSeatFwdTrn != null && !strPreferSeatFwdTrn.equals("") && entry.getKey().equals(strPreferSeatFwdTrn)) {
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
																							<td class="tatkaalTktInput">
																								<table width="100%" border="0" cellspacing="0" cellpadding="0">
																									<tr>
																										<td class="tatkaalTkt">
																											<select name="tatkaalTicketTrnFwd" class="comboBoxCss" id="tatkaalTicketTrnSBFwd" title="<%=dbLabelBean.getLabel("label.createrequest.tatkaalrequired",strsesLanguage)%>">
																											<%
																												if(strTatkalTicketReqFwdTrn != null && !"".equals(strTatkalTicketReqFwdTrn) && "0".equals(strTatkalTicketReqFwdTrn)) {
																											%>
																													<option value="0" selected="selected"><%=dbLabelBean.getLabel("label.createrequest.normalticket",strsesLanguage)%></option>
																													<option value="1"><%=dbLabelBean.getLabel("label.createrequest.tatkalticket",strsesLanguage)%></option>
																											<%
																												} else if(strTatkalTicketReqFwdTrn != null && !"".equals(strTatkalTicketReqFwdTrn) && "1".equals(strTatkalTicketReqFwdTrn)) {																											
																											%>
																													<option value="0"><%=dbLabelBean.getLabel("label.createrequest.normalticket",strsesLanguage)%></option>
																													<option value="1"  selected="selected"><%=dbLabelBean.getLabel("label.createrequest.tatkalticket",strsesLanguage)%></option>
																											<%
																												} else {
																											%>
																													<option value="0" selected="selected"><%=dbLabelBean.getLabel("label.createrequest.normalticket",strsesLanguage)%></option>
																													<option value="1"><%=dbLabelBean.getLabel("label.createrequest.tatkalticket",strsesLanguage)%></option>
																											<%
																												}
																											%>
																											</select>
																										</td>
																										<td class="delBtn"></td>
																									</tr>
																								</table>
																							</td>															
																						</tr>
																						
																						<tr id="intJrnyTitleRowTrain" class="hide"><td class="journeyTitle" colspan="8"><%=dbLabelBean.getLabel("label.global.intermediatejourney",strsesLanguage)%></td></tr>
																						<%
																							int j = 0;
																							if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																								if(strTravelType.equals("D")) {
																									strSql =" SELECT 'Intermediate' as JOURNEY,TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(ISNULL(TJDD.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																											" ISNULL(TRAVEL_CLASS,'5') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'3') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE "+
																											" FROM T_TRAVEL_DETAIL_DOM (nolock) AS TTDD INNER JOIN T_JOURNEY_DETAILS_DOM (nolock) AS TJDD ON TTDD.TRAVEL_ID = TJDD.TRAVEL_ID  "+
																											" WHERE TTDD.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2 AND JOURNEY_ORDER >(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2 AND STATUS_ID=10)";
																								} else if(strTravelType.equals("I")) {
																									strSql =" SELECT 'Intermediate' as JOURNEY,TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(ISNULL(TJDI.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																											" ISNULL(TRAVEL_CLASS,'5') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'3') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE "+
																											" FROM T_TRAVEL_DETAIL_INT (nolock) AS TTDI INNER JOIN T_JOURNEY_DETAILS_INT (nolock) AS TJDI ON TTDI.TRAVEL_ID = TJDI.TRAVEL_ID  "+
																											" WHERE TTDI.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2 AND JOURNEY_ORDER >(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2 AND STATUS_ID=10)";
																								}		
																								
																								rsTrn2 = null;
																								rsTrn2  =   dbConBean.executeQuery(strSql);  
																								while(rsTrn2.next()) {
																									trainYNFlag 					= "true";
																									strDepCityIntrmiTrn           	= rsTrn2.getString("TRAVEL_FROM"); 
																									strArrCityIntrmiTrn           	= rsTrn2.getString("TRAVEL_TO");
																									strDepDateIntrmiTrn           	= rsTrn2.getString("TRAVEL_DATE");
																									strPreferTimeModeIntrmiTrn		= rsTrn2.getString("PREF_TIME_TYPE");
																									strPreferTimeIntrmiTrn        	= rsTrn2.getString("PREFERRED_TIME");
																									strTravelClassIntrmiTrn       	= rsTrn2.getString("TRAVEL_CLASS");
																									strPreferAirlineIntrmiTrn		= rsTrn2.getString("MODE_NAME");
																									strPreferSeatIntrmiTrn      	= rsTrn2.getString("SEAT_PREFFERED");
																								
																										if(!strDepCityIntrmiTrn.trim().equals("") || !strArrCityIntrmiTrn.trim().equals("")) {
																						%>
																											<tr class="itineraryDataRowTrain itineraryDataRowTrainIntrmi">
																												<td class="city"><input type="text" name="depCityTrn" class="textBoxCss" value="<%=strDepCityIntrmiTrn %>" id="depCityTrnTBInt" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'sector')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																												<td class="city"><input type="text" name="arrCityTrn" class="textBoxCss" value="<%=strArrCityIntrmiTrn %>" id="arrCityTrnTBInt" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'sector')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																												<td class="date"><input type="text" name="depDateTrn" class="textBoxCss validDateTrn validDate" value="<%=strDepDateIntrmiTrn %>" id="depDateTrnTBInt" onFocus="initializeJourneyDateTrn(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');" placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																												<td class="timeMode">
																													<select name="preferTimeModeTrn" class="comboBoxCss" id="preferTimeModeTrnSBInt" title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																													<%
																														types =   TravelRequestEnums.PreferredTimeTypes.values();
																															for(t=0; t<types.length; t++){
																																if(!strPreferTimeModeIntrmiTrn.equals("") && types[t].getId().equals(strPreferTimeModeIntrmiTrn)) {
																													%>
																			                              							<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																													<%
																	                            								} else {
																	                            		 							if((strPreferTimeModeIntrmiTrn == null || strPreferTimeModeIntrmiTrn.equals("")) && types[t].getId().equals("1")) {
																	                           					 	%>
																			                              								<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																													<%
																	                            		 							} else {
																	                            					%>
																	                            										<option value="<%=types[t].getId()%>"><%=types[t].getName()%></option>
																	                            					<%	 
																	                            			 						}
																	                            	 							}
																															}
																													%>
																													</select>
																												</td>
																												<td class="time">
																													 <select name="preferTimeTrn" class="comboBoxCss" id="preferTimeTrnSBInt"  title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																															<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>
																														<%						                           
																															entrySet = preferredTimeList.entrySet();
																															it = entrySet.iterator();
																								                             while(it.hasNext()) {
																								                            	Map.Entry entry = (Map.Entry)it.next();
																								                            	if(!excludePreferredTimeList.contains(entry.getKey())) {
																															 		if(!entry.getKey().equals("102")) {
																								                            	 		if(strPreferTimeIntrmiTrn != null && !strPreferTimeIntrmiTrn.equals("") && entry.getKey().equals(strPreferTimeIntrmiTrn)) {
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
																								                         	 }
																														%>													
																							                        </select>
																												</td>
																												<td class="trClass">
																													<select name="departClassTrn" class="comboBoxCss" id="departClassTrnSBInt" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																														<%						                           
																															entrySet = trainClassList.entrySet();
																															it = entrySet.iterator();
																								                             while(it.hasNext()) {
																								                            	 Map.Entry entry = (Map.Entry)it.next();																			                            	 
																								                            	 if(strTravelClassIntrmiTrn != null && !strTravelClassIntrmiTrn.equals("") && entry.getKey().equals(strTravelClassIntrmiTrn)) {
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
																												<td class="flight"><input type="text" name="nameOfAirlineTrn" class="textBoxCss" value="<%=strPreferAirlineIntrmiTrn %>" id="nameOfAirlineTrnTBInt" placeholder="<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>" onKeyUp="return test2(this, 30, 'cn')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>"></td>
																												<td class="seat">
																													<select name="seatPreffredTrn" class="comboBoxCss" id="seatPreffredTrnSBInt" title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																														<%						                           
																															entrySet = trainWindowList.entrySet();
																															it = entrySet.iterator();
																								                             while(it.hasNext()) {
																								                            	 Map.Entry entry = (Map.Entry)it.next();																			                            	 
																								                            	 if(strPreferSeatIntrmiTrn != null && !strPreferSeatIntrmiTrn.equals("") && entry.getKey().equals(strPreferSeatIntrmiTrn)) {
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
																												<td class="tatkaalTktInput"><img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0"	id="bt-Del-ItInr-Train" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"></td>															
																											</tr>
																						<%
																										}
																								j++;
																								}
																								rsTrn2.close();
																							}	
																						%>
																						
																						
																						<tr class="innerRowItineraryTrain"></tr>	
																						<tr class="prototypeRowItineraryTrain">
																							<td class="city"><input type="text" name="depCityTrnPT" class="textBoxCss" value="" id="depCityTrnTBInt" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'sector')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																							<td class="city"><input type="text" name="arrCityTrnPT" class="textBoxCss" value="" id="arrCityTrnTBInt" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'sector')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																							<td class="date"><input type="text" name="depDateTrnPT" class="textBoxCss validDateTrn validDate" value="" id="depDateTrnTBInt" onFocus="initializeJourneyDateTrn(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');" placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																							<td class="timeMode">
																								<select name="preferTimeModeTrnPT" class="comboBoxCss" id="preferTimeModeTrnSBInt" title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																								<%
																									types =   TravelRequestEnums.PreferredTimeTypes.values();
																										for(t=0; t<types.length; t++){
																											if(types[t].getId().equals("1")) {
												                           					 	%>
														                              								<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																								<%
												                            		 							} else {
												                            					%>
												                            										<option value="<%=types[t].getId()%>"><%=types[t].getName()%></option>
												                            					<%	 
												                            			 						}
																										}
																								%>
																								</select>
																							</td>
																							<td class="time">
																								 <select name="preferTimeTrnPT" class="comboBoxCss" id="preferTimeTrnSBInt" title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																										<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>
																									<%						                           
																										entrySet = preferredTimeList.entrySet();
																										it = entrySet.iterator();
																			                             while(it.hasNext()) {
																			                            	Map.Entry entry = (Map.Entry)it.next();
																			                            	if(!excludePreferredTimeList.contains(entry.getKey())) {
																										 		if(!entry.getKey().equals("102")) {
																									 %>
																					                              		<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																									<%
																			                            	 	}
																			                            	}
																			                         	 }
																									%>											
																		                        </select>														
																							</td>
																							<td class="trClass">
																								<select name="departClassTrnPT" class="comboBoxCss" id="departClassTrnSBInt" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																									<%						                           
																										entrySet = trainClassList.entrySet();
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
																							<td class="flight"><input type="text" name="nameOfAirlineTrnPT" class="textBoxCss" value="" id="nameOfAirlineTrnTBInt" placeholder="<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>" onKeyUp="return test2(this, 30, 'cn')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>"></td>
																							<td class="seat">
																								<select name="seatPreffredTrnPT" class="comboBoxCss" id="seatPreffredTrnSBInt" title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																									<%						                           
																										entrySet = trainWindowList.entrySet();
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
																							<td class="tatkaalTktInput"><img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0"	id="bt-Del-ItInr-Train" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"></td>													
																						</tr>
																					 
																						 <%
																							if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																								if(strTravelType.equals("D")) {
																									  strSql = " SELECT 'Return' as Journey, RETURN_FROM, RETURN_TO, DBO.CONVERTDATEDMY1(ISNULL(TJRDD.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																											   " ISNULL(TRAVEL_CLASS,'5') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'3') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE, TTDD.RETURN_TATKAAL AS RETURN_TATKAAL "+
																											   " FROM T_TRAVEL_DETAIL_DOM (nolock) AS TTDD INNER JOIN T_RET_JOURNEY_DETAILS_DOM (nolock) AS TJRDD ON TTDD.TRAVEL_ID = TJRDD.TRAVEL_ID WHERE TTDD.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2";
																								  } else if(strTravelType.equals("I")) {
																									  strSql = " SELECT 'Return' as Journey, RETURN_FROM, RETURN_TO, DBO.CONVERTDATEDMY1(ISNULL(TJRDI.TRAVEL_DATE,'')) AS TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, ISNULL((TIMINGS),'1') AS PREFERRED_TIME, "+ 
																											   " ISNULL(TRAVEL_CLASS,'5') AS TRAVEL_CLASS, ISNULL(SEAT_PREFFERED,'3') AS SEAT_PREFFERED, ISNULL(PREF_TIME_TYPE,'1') AS PREF_TIME_TYPE "+
																											   " FROM T_TRAVEL_DETAIL_INT (nolock) AS TTDI INNER JOIN T_RET_JOURNEY_DETAILS_INT (nolock) AS TJRDI ON TTDI.TRAVEL_ID = TJRDI.TRAVEL_ID WHERE TTDI.TRAVEL_ID="+strTravelId+" AND TRAVEL_MODE=2";
																								  }											
																								rsTrn3=null;
																								rsTrn3  =   dbConBean.executeQuery(strSql);  
																								if(rsTrn3.next()) {
																								trainYNFlag 			   	= "true";
																								strDepCityRetTrn           	= rsTrn3.getString("RETURN_FROM"); 
																								strArrCityRetTrn           	= rsTrn3.getString("RETURN_TO");
																								strDepDateRetTrn           	= rsTrn3.getString("TRAVEL_DATE");	
																								strPreferTimeModeRetTrn		= rsTrn3.getString("PREF_TIME_TYPE");
																								strPreferTimeRetTrn        	= rsTrn3.getString("PREFERRED_TIME");
																								strTravelClassRetTrn       	= rsTrn3.getString("TRAVEL_CLASS");
																								strPreferAirlineRetTrn		= rsTrn3.getString("MODE_NAME");
																								strPreferSeatRetTrn      	= rsTrn3.getString("SEAT_PREFFERED");
																									if(strTravelType.equals("D")) {
																										strTatkalTicketReqRetTrn	= rsTrn3.getString("RETURN_TATKAAL");
																									} 
																								}
																								rsTrn3.close();
																							} 
																						%>	
																					    <tr><td class="journeyTitle" colspan="8"><%=dbLabelBean.getLabel("label.global.returnjourney",strsesLanguage)%></td></tr>
																						<tr class="itineraryDataRowTrain">
																							<td class="city"><input type="text" name="depCityTrn" class="textBoxCss" value="<%=strDepCityRetTrn %>" id="depCityTrnTBRet" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'sector')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																							<td class="city"><input type="text" name="arrCityTrn" class="textBoxCss" value="<%=strArrCityRetTrn %>" id="arrCityTrnTBRet" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'sector')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																							<td class="date"><input type="text" name="depDateTrn" class="textBoxCss validDateTrn validDate" value="<%=strDepDateRetTrn %>" id="depDateTrnTBRet" onFocus="initializeJourneyDateTrn(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');" placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																							<td class="timeMode">
																								<select name="preferTimeModeTrn" class="comboBoxCss" id="preferTimeModeTrnSBRet" title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																								<%
																									types =   TravelRequestEnums.PreferredTimeTypes.values();
																										for(t=0; t<types.length; t++){
																											if(!strPreferTimeModeRetTrn.equals("") && types[t].getId().equals(strPreferTimeModeRetTrn)) {
																								%>
														                              							<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																								<%
												                            								} else {
												                            		 							if((strPreferTimeModeRetTrn == null || strPreferTimeModeRetTrn.equals("")) && types[t].getId().equals("1")) {
												                           					 	%>
														                              								<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																								<%
												                            		 							} else {
												                            					%>
												                            										<option value="<%=types[t].getId()%>"><%=types[t].getName()%></option>
												                            					<%	 
												                            			 						}
												                            	 							}
																										}
																								%>
																								</select>
																							</td>
																							<td class="time">
																								 <select name="preferTimeTrn" class="comboBoxCss" id="preferTimeTrnSBRet" title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																										<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>
																									<%						                           
																										entrySet = preferredTimeList.entrySet();
																										it = entrySet.iterator();
																			                             while(it.hasNext()) {
																			                            	Map.Entry entry = (Map.Entry)it.next();
																			                            	if(!excludePreferredTimeList.contains(entry.getKey())) {
																										 		if(!entry.getKey().equals("102")){
																			                            	 		if(strPreferTimeRetTrn != null && !strPreferTimeRetTrn.equals("") && entry.getKey().equals(strPreferTimeRetTrn)) {
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
																			                         	 }
																									%>
																		                        </select>
																							</td>
																							<td class="trClass">
																								<select name="departClassTrn" class="comboBoxCss" id="departClassTrnSBRet" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																									<%						                           
																										entrySet = trainClassList.entrySet();
																										it = entrySet.iterator();
																			                             while(it.hasNext()) {
																			                            	 Map.Entry entry = (Map.Entry)it.next();																			                            	 
																			                            	 if(strTravelClassRetTrn != null && !strTravelClassRetTrn.equals("") && entry.getKey().equals(strTravelClassRetTrn)) {
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
																							<td class="flight"><input type="text" name="nameOfAirlineTrn" class="textBoxCss" value="<%=strPreferAirlineRetTrn %>" id="nameOfAirlineTrnTBRet" placeholder="<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>" onKeyUp="return test2(this, 30, 'cn')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>"></td>
																							<td class="seat">
																								<select name="seatPreffredTrn" class="comboBoxCss" id="seatPreffredTrnSBRet" title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																									<%						                           
																										entrySet = trainWindowList.entrySet();
																										it = entrySet.iterator();
																			                             while(it.hasNext()) {
																			                            	 Map.Entry entry = (Map.Entry)it.next();																			                            	 
																			                            	 if(strPreferSeatRetTrn != null && !strPreferSeatRetTrn.equals("") && entry.getKey().equals(strPreferSeatRetTrn)) {
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
																							<td class="tatkaalTktInput">
																								<table width="100%" border="0" cellspacing="0" cellpadding="0">
																									<tr>
																										<td class="tatkaalTkt">
																											<select name="tatkaalTicketTrnRet" class="comboBoxCss" id="tatkaalTicketTrnSBRet" title="<%=dbLabelBean.getLabel("label.createrequest.tatkaalrequired",strsesLanguage)%>">
																											<%
																												if(strTatkalTicketReqRetTrn != null && !"".equals(strTatkalTicketReqRetTrn) && "0".equals(strTatkalTicketReqRetTrn)) {
																											%>
																													<option value="0" selected="selected"><%=dbLabelBean.getLabel("label.createrequest.normalticket",strsesLanguage)%></option>
																													<option value="1"><%=dbLabelBean.getLabel("label.createrequest.tatkalticket",strsesLanguage)%></option>
																											<%
																												} else if(strTatkalTicketReqRetTrn != null && !"".equals(strTatkalTicketReqRetTrn) && "1".equals(strTatkalTicketReqRetTrn)) {																											
																											%>
																													<option value="0"><%=dbLabelBean.getLabel("label.createrequest.normalticket",strsesLanguage)%></option>
																													<option value="1"  selected="selected"><%=dbLabelBean.getLabel("label.createrequest.tatkalticket",strsesLanguage)%></option>
																											<%
																												} else {
																											%>
																													<option value="0" selected="selected"><%=dbLabelBean.getLabel("label.createrequest.normalticket",strsesLanguage)%></option>
																													<option value="1"><%=dbLabelBean.getLabel("label.createrequest.tatkalticket",strsesLanguage)%></option>
																											<%
																												}
																											%>
																											</select>
																										</td>
																										<td class="delBtn"></td>
																									</tr>
																								</table>
																							</td>															
																						</tr>																
																				</tbody>
																				<script language="javascript">
																					 var trainDetailFlag = '<%=trainYNFlag%>';
																					 if(trainDetailFlag === "true") {
																						$("label#trainRequiredNo").removeClass("active");
																						$("label#trainRequiredYes").addClass("active");
																						$("input:radio#trainRequired_N").attr('checked', false);
																						$("input:radio#trainRequired_Y").attr('checked', true);													
																						$("tr#trainDetail").show();	
																					 } else {
																						 $("label#trainRequiredYes").removeClass("active");
																						 $("label#trainRequiredNo").addClass("active");
																						 $("input:radio#trainRequired_Y").attr('checked', false);
																						 $("input:radio#trainRequired_N").attr('checked', true);
																						 $("tr#trainDetail").hide();
																					 }
																				
																					var rowLength = $("table#tblItineraryTrain tbody tr.itineraryDataRowTrain").length;
																					if(rowLength > 2 && $("tr#intJrnyTitleRowTrain").hasClass("hide")){
																						$("tr#intJrnyTitleRowTrain").removeClass("hide");
																						$("tr#intJrnyTitleRowTrain").addClass("show");
																					}
																				</script>
																			</table>
																		</td>
																	</tr>
																	<tr valign="top">
																		<td>
																			<table width="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td class="itenaryRemark">
																						<textarea name="remarksTrn" id="remarksTrn" class="textAreaCss" rows="" cols="" onKeyUp="return test2(this, 1000, 'cn')" maxlength="1000" placeholder="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>"><%=strRemarkTrn %></textarea>
																					</td>
																					<td class="addIntrimJourneyBtn"><input type="button" value="<%=dbLabelBean.getLabel("link.global.intermediatejourney",strsesLanguage)%>" class="bt-Add-Dom" id="bt_Add-Train" title=""/></td>	
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
											<!-- Train Details End -->
											
											<!-- Car Details Start -->
											<tr valign="top" id="carDetailBlock" style="display: none;">
												<td>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr><td class="hrSpace6Px"></td></tr>
														<tr valign="top" id="carDetailBtn">
															<td class="journyType" style="padding:5px 0 0 0; border-top:1px solid #aea899;">
																<table width="230px" border="0" cellspacing="0" cellpadding="0">
																	<tr>
																		<td class="journyDetailLabel"><label
																			class="modeType"><b><%=dbLabelBean.getLabel("label.global.carreservation",strsesLanguage) %></b></label></td>
																		<td class="journyDetailRadio">
																			<table width="100%" border="0" cellspacing="0"
																				cellpadding="0" class="checkbox">
																				<tr>
																					<td class="labelTd"><label class="yes"
																						id="carRequiredYes"> <input type="radio"
																							name="car" value="1" id="carRequired_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
																					</label></td>
																					<td class="labelTd"><label class="no"
																						id="carRequiredNo"> <input type="radio"
																							name="car" value="2" checked="checked"
																							id="carRequired_N"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
																					</label></td>
																				</tr>
																			</table>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
														<tr valign="top" id="carDetail" style="display: none;">
															<td style="border:1px solid #e0dfdf;">
																<table width="100%" border="0" cellspacing="0" cellpadding="0">
																	<tr>
																		<td style="padding:0 0 5px 20px;">
																			<table width="20%" border="0" cellspacing="0" cellpadding="0">
																			<%
																				if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {																					
																					strSql = "SELECT DISTINCT CLASS, ISNULL(TCD.TRAVEL_CLASS, '') AS TRAVEL_CLASS FROM T_TRAVEL_CAR_DETAIL TCD WHERE TCD.TRAVEL_ID="+strTravelId+" AND TRAVEL_TYPE='"+strTravelType+"' AND TCD.STATUS_ID=10";
																					rs=null;
																					rs  =   dbConBean.executeQuery(strSql);  
																					if(rs.next()) {
																						strCarClassType				= rs.getString("TRAVEL_CLASS");
																						strCarCategory				= rs.getString("CLASS");
																					}
																					rs.close();
																				}
																			
																				if(strCarClassType != null && !"".equals(strCarClassType)) {
																					carCategoryList = dao.getCarCategoryList(strCarClassType, "B", "1");
																				}
																			%>
																			
																			
																				<tr>
																					<td class="carClass">
																						<select name="carClassType" class="comboBoxCss" id="carClassType" title="<%=dbLabelBean.getLabel("label.global.caroptions",strsesLanguage)%>" onchange="">
																							<%						                           
																								entrySet = carClassList.entrySet();
																								it = entrySet.iterator();
																	                             while(it.hasNext()) {
																	                            	 Map.Entry entry = (Map.Entry)it.next();
																	                            	 if(strCarClassType != null && !strCarClassType.equals("") && entry.getKey().equals(strCarClassType)) {
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
																					<td class="carCategory">
																						<select name="carCategoryType" class="comboBoxCss" id="carCategoryType" title="<%=dbLabelBean.getLabel("label.global.category",strsesLanguage)%>" onchange="">
																							<%						                           
																								entrySet = carCategoryList.entrySet();
																								it = entrySet.iterator();
																	                             while(it.hasNext()) {
																	                            	 Map.Entry entry = (Map.Entry)it.next();
																	                            	 if(strCarCategory != null && !strCarCategory.equals("") && entry.getKey().equals(strCarCategory)) {
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
																				</tr>
																			</table>
																		</td>
																	</tr>
																	<tr valign="top">
																		<td style="padding:0 0 5px 20px;">
																			<table width="94.2%" border="0" cellspacing="0" cellpadding="0" id="tblItineraryCar">
																				<tbody>
																						<%
																							if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																								if(strTravelType.equals("D")) {
																									strSql =" SELECT 'Forword' AS JOURNEY, TRAVEL_CAR_ID, TCD.TRAVEL_ID, TRAVEL_TYPE, ISNULL(START_CITY, '') AS START_CITY, START_LOCATION, ISNULL(END_CITY, '') AS END_CITY, "+
																											" END_LOCATION, DBO.CONVERTDATEDMY1(ISNULL(START_DATE,'')) AS START_DATE, START_TIME, DBO.CONVERTDATEDMY1(ISNULL(END_DATE,'')) AS END_DATE, END_TIME, GPS, CLASS, "+
																											" ISNULL(START_MOBILENO, '') AS START_MOBILENO, ISNULL(END_MOBILENO, '') AS END_MOBILENO, ISNULL(TCD.TRAVEL_CLASS, '') AS TRAVEL_CLASS, TCD.PREF_TIME_TYPE "+
																											" FROM T_TRAVEL_CAR_DETAIL TCD WHERE TCD.TRAVEL_ID="+strTravelId+" AND TRAVEL_TYPE='D' AND TCD.STATUS_ID=10 AND JOURNEY_ORDER=(SELECT MIN(T_TRAVEL_CAR_DETAIL.JOURNEY_ORDER) "+
																										    " FROM T_TRAVEL_CAR_DETAIL  WHERE T_TRAVEL_CAR_DETAIL.TRAVEL_ID=TCD.TRAVEL_ID AND T_TRAVEL_CAR_DETAIL.TRAVEL_TYPE='D' AND T_TRAVEL_CAR_DETAIL.STATUS_ID=10) ORDER BY JOURNEY_ORDER";
																								} else if(strTravelType.equals("I")) {
																									strSql =" SELECT 'Forword' AS JOURNEY, TRAVEL_CAR_ID, TCD.TRAVEL_ID, TRAVEL_TYPE, ISNULL(START_CITY, '') AS START_CITY, START_LOCATION, ISNULL(END_CITY, '') AS END_CITY, "+
																											" END_LOCATION, DBO.CONVERTDATEDMY1(ISNULL(START_DATE,'')) AS START_DATE,START_TIME, DBO.CONVERTDATEDMY1(ISNULL(END_DATE,'')) AS END_DATE, END_TIME, GPS, CLASS, "+
																											" ISNULL(START_MOBILENO, '') AS START_MOBILENO, ISNULL(END_MOBILENO, '') AS END_MOBILENO, ISNULL(TCD.TRAVEL_CLASS, '') AS TRAVEL_CLASS, TCD.PREF_TIME_TYPE "+
																											" FROM T_TRAVEL_CAR_DETAIL TCD WHERE TCD.TRAVEL_ID="+strTravelId+" AND TRAVEL_TYPE='I' AND TCD.STATUS_ID=10  AND JOURNEY_ORDER=(SELECT MIN(T_TRAVEL_CAR_DETAIL.JOURNEY_ORDER) "+
																											" FROM T_TRAVEL_CAR_DETAIL  WHERE T_TRAVEL_CAR_DETAIL.TRAVEL_ID=TCD.TRAVEL_ID AND T_TRAVEL_CAR_DETAIL.TRAVEL_TYPE='I' AND T_TRAVEL_CAR_DETAIL.STATUS_ID=10) ORDER BY JOURNEY_ORDER";
																								}
																	
																								rsCar1=null;
																								rsCar1  =   dbConBean.executeQuery(strSql);  
																								if(rsCar1.next()) {
																									carYNFlag 					= "true";
																									strTravelIdFwdCar			= rsCar1.getString("TRAVEL_CAR_ID");
																									strDepCityFwdCar           	= rsCar1.getString("START_CITY"); 
																									strArrCityFwdCar           	= rsCar1.getString("END_CITY");
																									strDepDateFwdCar		 	= rsCar1.getString("START_DATE");
																									strPreferTimeModeFwdCar		= rsCar1.getString("PREF_TIME_TYPE");
																									strPreferTimeFwdCar        	= rsCar1.getString("START_TIME");
																									strLocationFwdCar       	= rsCar1.getString("START_LOCATION");
																									strMobileFwdCar				= rsCar1.getString("START_MOBILENO");
																								}
																								rsCar1.close();
																							} 
																						%>
																						<tr><td class="journeyTitle" colspan="8"><%=dbLabelBean.getLabel("label.global.forwardjourney",strsesLanguage)%></td></tr>
																						<tr class="itineraryDataRowCar">
																							<input type="hidden" name="travelCarId" id="travelCarIdFwd" value="<%=strTravelIdFwdCar %>" />
																							<td class="city"><input type="text" name="depCityCar" class="textBoxCss" value="<%=strDepCityFwdCar %>" id="depCityCarTBFwd" placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'c')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																							<td class="city"><input type="text" name="arrCityCar" class="textBoxCss" value="<%=strArrCityFwdCar %>" id="arrCityCarTBFwd" placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'c')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																							<td class="date"><input type="text" name="depDateCar" class="textBoxCss validDateCar validDate" value="<%=strDepDateFwdCar %>" id="depDateCarTBFwd" onFocus="initializeJourneyDateCar(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');" placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																							<td class="timeMode">
																								<select name="preferTimeModeCar" class="comboBoxCss" id="preferTimeModeCarSBFwd" title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																								<%
																									types =   TravelRequestEnums.PreferredTimeTypes.values();
																										for(t=0; t<types.length; t++){
																											if(!strPreferTimeModeFwdCar.equals("") && types[t].getId().equals(strPreferTimeModeFwdCar)) {
																								%>
														                              							<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																								<%
												                            								} else {
												                            		 							if((strPreferTimeModeFwdCar == null || strPreferTimeModeFwdCar.equals("")) && types[t].getId().equals("2")) {
												                           					 	%>
														                              								<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																								<%
												                            		 							} else {
												                            					%>
												                            										<option value="<%=types[t].getId()%>"><%=types[t].getName()%></option>
												                            					<%	 
												                            			 						}
												                            	 							}
																										}
																								%>
																								</select>
																							</td>
																							<td class="time">
																								 <select name="preferTimeCar" class="comboBoxCss" id="preferTimeCarSBFwd"  title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																										<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>
																									<%						                           
																										entrySet = preferredTimeList.entrySet();
																										it = entrySet.iterator();
																			                             while(it.hasNext()) {
																			                            	Map.Entry entry = (Map.Entry)it.next();
																			                            	if(!excludePreferredTimeList.contains(entry.getKey())) {
																										 		if(!entry.getKey().equals("102")){
																			                            	 		if(strPreferTimeFwdCar != null && !strPreferTimeFwdCar.equals("") && entry.getKey().equals(strPreferTimeFwdCar)) {
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
																			                         	 }
																									%>												
																		                        </select>
																							</td>
																							<td class="location">
																								<select name="locationCar" class="comboBoxCss" id="locationCarSBFwd" title="<%=dbLabelBean.getLabel("label.global.location",strsesLanguage)%>">
																									<%
																										locations =   TravelRequestEnums.LocationsMataIndia.values();
																										for(i=0; i<locations.length; i++) {	
																											if(strLocationFwdCar != null && !strLocationFwdCar.equals("") && locations[i].getId().equals(strLocationFwdCar)) {
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
																							<td class="mobileNo"><input type="text" name="mobileNumberCar" class="textBoxCss" value="<%=strMobileFwdCar %>" id="mobileNumberCarTBFwd" placeholder="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>" onKeyUp="return test2(this, 19, 'phone')" maxlength="20" title="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>"></td>
																							<td class="tatkaalTktInput"></td>															
																						</tr>
																						
																						<tr id="intJrnyTitleRowCar" class="hide"><td class="journeyTitle" colspan="8"><%=dbLabelBean.getLabel("label.global.intermediatejourney",strsesLanguage)%></td></tr>
																						<%
																							int k = 0;
																							if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																								if(strTravelType.equals("D")) {
																									strSql =" SELECT 'Intermediate' AS JOURNEY, TRAVEL_CAR_ID, TCD.TRAVEL_ID, TRAVEL_TYPE, ISNULL(START_CITY, '') AS START_CITY, START_LOCATION, ISNULL(END_CITY, '') AS END_CITY, "+
																								            " END_LOCATION, DBO.CONVERTDATEDMY1(ISNULL(START_DATE,'')) AS START_DATE, START_TIME, DBO.CONVERTDATEDMY1(ISNULL(END_DATE,'')) AS END_DATE, END_TIME, GPS, CLASS, "+
																											" ISNULL(START_MOBILENO, '') AS START_MOBILENO, ISNULL(END_MOBILENO, '') AS END_MOBILENO, ISNULL(TCD.TRAVEL_CLASS, '') AS TRAVEL_CLASS, TCD.PREF_TIME_TYPE "+
																								            " FROM T_TRAVEL_CAR_DETAIL TCD WHERE TCD.TRAVEL_ID="+strTravelId+" AND TRAVEL_TYPE='D' AND TCD.STATUS_ID=10 AND JOURNEY_ORDER>(SELECT MIN(T_TRAVEL_CAR_DETAIL.JOURNEY_ORDER) "+
																								            " FROM T_TRAVEL_CAR_DETAIL  WHERE T_TRAVEL_CAR_DETAIL.TRAVEL_ID=TCD.TRAVEL_ID AND T_TRAVEL_CAR_DETAIL.TRAVEL_TYPE='D' AND T_TRAVEL_CAR_DETAIL.STATUS_ID=10) AND JOURNEY_ORDER<(SELECT MAX(T_TRAVEL_CAR_DETAIL.JOURNEY_ORDER) "+
																								            " FROM T_TRAVEL_CAR_DETAIL  WHERE T_TRAVEL_CAR_DETAIL.TRAVEL_ID=TCD.TRAVEL_ID AND T_TRAVEL_CAR_DETAIL.TRAVEL_TYPE='D' AND T_TRAVEL_CAR_DETAIL.STATUS_ID=10) ORDER BY JOURNEY_ORDER";
																								} else if(strTravelType.equals("I")) {
																									strSql =" SELECT 'Intermediate' AS JOURNEY, TRAVEL_CAR_ID, TCD.TRAVEL_ID, TRAVEL_TYPE, ISNULL(START_CITY, '') AS START_CITY, START_LOCATION, ISNULL(END_CITY, '') AS END_CITY, "+
																								            " END_LOCATION, DBO.CONVERTDATEDMY1(ISNULL(START_DATE,'')) AS START_DATE, START_TIME, DBO.CONVERTDATEDMY1(ISNULL(END_DATE,'')) AS END_DATE, END_TIME, GPS, CLASS, "+
																											" ISNULL(START_MOBILENO, '') AS START_MOBILENO, ISNULL(END_MOBILENO, '') AS END_MOBILENO, ISNULL(TCD.TRAVEL_CLASS, '') AS TRAVEL_CLASS, TCD.PREF_TIME_TYPE "+
																								            " FROM T_TRAVEL_CAR_DETAIL TCD WHERE TCD.TRAVEL_ID="+strTravelId+" AND TRAVEL_TYPE='I' AND TCD.STATUS_ID=10 AND JOURNEY_ORDER>(SELECT MIN(T_TRAVEL_CAR_DETAIL.JOURNEY_ORDER) "+
																										    " FROM T_TRAVEL_CAR_DETAIL  WHERE T_TRAVEL_CAR_DETAIL.TRAVEL_ID=TCD.TRAVEL_ID AND T_TRAVEL_CAR_DETAIL.TRAVEL_TYPE='I' AND T_TRAVEL_CAR_DETAIL.STATUS_ID=10) AND JOURNEY_ORDER<(SELECT MAX(T_TRAVEL_CAR_DETAIL.JOURNEY_ORDER) "+
																										    " FROM T_TRAVEL_CAR_DETAIL  WHERE T_TRAVEL_CAR_DETAIL.TRAVEL_ID=TCD.TRAVEL_ID AND T_TRAVEL_CAR_DETAIL.TRAVEL_TYPE='I' AND T_TRAVEL_CAR_DETAIL.STATUS_ID=10) ORDER BY JOURNEY_ORDER";
																								}	
																								
																								rsCar2 = null;
																								rsCar2  =   dbConBean.executeQuery(strSql);  
																								while(rsCar2.next()) {
																									carYNFlag 						= "true";																								
																									strTravelIdIntrmiCar			= rsCar2.getString("TRAVEL_CAR_ID");
																									strDepCityIntrmiCar           	= rsCar2.getString("START_CITY"); 
																									strArrCityIntrmiCar           	= rsCar2.getString("END_CITY");
																									strDepDateIntrmiCar		 		= rsCar2.getString("START_DATE");
																									strPreferTimeModeIntrmiCar		= rsCar2.getString("PREF_TIME_TYPE");
																									strPreferTimeIntrmiCar        	= rsCar2.getString("START_TIME");
																									strLocationIntrmiCar       		= rsCar2.getString("START_LOCATION");
																									strMobileIntrmiCar				= rsCar2.getString("START_MOBILENO");
																								
																										if(!strDepCityIntrmiCar.trim().equals("") || !strArrCityIntrmiCar.trim().equals("")) {
																						%>
																											<tr class="itineraryDataRowCar itineraryDataRowCarIntrmi">
																												<input type="hidden" name="travelCarId" id="travelCarIdInt" value="<%=strTravelIdIntrmiCar %>" />
																												<td class="city"><input type="text" name="depCityCar" class="textBoxCss" value="<%=strDepCityIntrmiCar %>" id="depCityCarTBInt" placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'c')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																												<td class="city"><input type="text" name="arrCityCar" class="textBoxCss" value="<%=strArrCityIntrmiCar %>" id="arrCityCarTBInt" placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'c')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																												<td class="date"><input type="text" name="depDateCar" class="textBoxCss validDateCar" value="<%=strDepDateIntrmiCar %>" id="depDateCarTBInt" onFocus="initializeJourneyDateCar(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');" placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																												<td class="timeMode">
																													<select name="preferTimeModeCar" class="comboBoxCss" id="preferTimeModeCarSBInt" title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																													<%
																														types =   TravelRequestEnums.PreferredTimeTypes.values();
																															for(t=0; t<types.length; t++){
																																if(!strPreferTimeModeIntrmiCar.equals("") && types[t].getId().equals(strPreferTimeModeIntrmiCar)) {
																													%>
																			                              							<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																													<%
																	                            								} else {
																	                            		 							if((strPreferTimeModeIntrmiCar == null || strPreferTimeModeIntrmiCar.equals("")) && types[t].getId().equals("1")) {
																	                           					 	%>
																			                              								<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																													<%
																	                            		 							} else {
																	                            					%>
																	                            										<option value="<%=types[t].getId()%>"><%=types[t].getName()%></option>
																	                            					<%	 
																	                            			 						}
																	                            	 							}
																															}
																													%>
																													</select>
																												</td>
																												<td class="time">
																													 <select name="preferTimeCar" class="comboBoxCss" id="preferTimeCarSBInt" title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																															<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>
																														<%						                           
																															entrySet = preferredTimeList.entrySet();
																															it = entrySet.iterator();
																								                             while(it.hasNext()) {
																								                            	Map.Entry entry = (Map.Entry)it.next();
																								                            	if(!excludePreferredTimeList.contains(entry.getKey())) {
																															 		if(!entry.getKey().equals("102")){
																								                            	 		if(strPreferTimeIntrmiCar != null && !strPreferTimeIntrmiCar.equals("") && entry.getKey().equals(strPreferTimeIntrmiCar)) {
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
																								                         	 }
																														%>											
																							                        </select>														
																												</td>
																												<td class="location">
																													<select name="locationCar" class="comboBoxCss" id="locationCarSBInt" title="<%=dbLabelBean.getLabel("label.global.location",strsesLanguage)%>">
																														<%
																															locations =   TravelRequestEnums.LocationsMataIndia.values();
																															for(i=0; i<locations.length; i++) {	
																																if(strLocationIntrmiCar != null && !strLocationIntrmiCar.equals("") && locations[i].getId().equals(strLocationIntrmiCar)) {
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
																												<td class="mobileNo"><input type="text" name="mobileNumberCar" class="textBoxCss" value="<%=strMobileIntrmiCar %>" id="mobileNumberCarTBInt" placeholder="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>" onKeyUp="return test2(this, 19, 'phone')" maxlength="20" title="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>"></td>
																												<td class="tatkaalTktInput"><img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0"	id="bt-Del-ItInr-Car" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"></td>															
																											</tr>
																						<%
																										}
																								k++;
																								}
																								rsCar2.close();
																							}	
																						%>
																						
																						<tr class="innerRowItineraryCar"></tr>	
																						<tr class="prototypeRowItineraryCar">
																							<input type="hidden" name="travelCarIdPT" id="travelCarIdInt" value="" />
																							<td class="city"><input type="text" name="depCityCarPT" class="textBoxCss" value="" id="depCityCarTBInt" placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'c')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																							<td class="city"><input type="text" name="arrCityCarPT" class="textBoxCss" value="" id="arrCityCarTBInt" placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'c')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																							<td class="date"><input type="text" name="depDateCarPT" class="textBoxCss validDateCar validDate" value="" id="depDateCarTBInt" onFocus="initializeJourneyDateCar(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');" placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																							<td class="timeMode">
																								<select name="preferTimeModeCarPT" class="comboBoxCss" id="preferTimeModeCarSBInt" title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																								<%
																									types =   TravelRequestEnums.PreferredTimeTypes.values();
																										for(t=0; t<types.length; t++){
																											if(types[t].getId().equals("1")) {
												                           					 	%>
														                              							<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																								<%
												                            		 						} else {
												                            					%>
												                            									<option value="<%=types[t].getId()%>"><%=types[t].getName()%></option>
												                            					<%	 
												                            			 					}
																										}
																								%>
																								</select>
																							</td>
																							<td class="time">
																								 <select name="preferTimeCarPT" class="comboBoxCss" id="preferTimeCarSBInt" title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																										<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>
																									<%						                           
																										entrySet = preferredTimeList.entrySet();
																										it = entrySet.iterator();
																			                             while(it.hasNext()) {
																			                            	Map.Entry entry = (Map.Entry)it.next();
																			                            	if(!excludePreferredTimeList.contains(entry.getKey())) {
																										 		if(!entry.getKey().equals("102")) {
																									%>
																					                              	<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																									<%
																			                            		}
																			                            	}
																			                         	 }
																									%>											
																		                        </select>														
																							</td>
																							<td class="location">
																								<select name="locationCarPT" class="comboBoxCss" id="locationCarSBInt" title="<%=dbLabelBean.getLabel("label.global.location",strsesLanguage)%>">
																									<%
																										locations =   TravelRequestEnums.LocationsMataIndia.values();
																										for(i=0; i<locations.length; i++) {																							
																											%>
																				                              	<option value="<%=locations[i].getId()%>"><%=locations[i].getName()%></option>
																											<%
																										} 
																										%>
																								</select>
																							</td>
																							<td class="mobileNo"><input type="text" name="mobileNumberCarPT" class="textBoxCss" value="" id="mobileNumberCarTBInt" placeholder="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>" onKeyUp="return test2(this, 19, 'phone')" maxlength="20" title="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>"></td>
																							<td class="tatkaalTktInput"><img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0"	id="bt-Del-ItInr-Car" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"></td>													
																						</tr>
																						
																						<%
																							if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																								if(strTravelType.equals("D")) {
																									  strSql = " SELECT 'Return' AS JOURNEY, TRAVEL_CAR_ID, TCD.TRAVEL_ID, TRAVEL_TYPE, ISNULL(START_CITY, '') AS START_CITY, START_LOCATION,ISNULL(END_CITY, '') AS END_CITY, "+
																											   " END_LOCATION, DBO.CONVERTDATEDMY1(ISNULL(START_DATE,'')) AS START_DATE, START_TIME, DBO.CONVERTDATEDMY1(ISNULL(END_DATE,'')) AS END_DATE, END_TIME, GPS, CLASS, "+
																									  		   " ISNULL(START_MOBILENO, '') AS START_MOBILENO, ISNULL(END_MOBILENO, '') AS END_MOBILENO, ISNULL(TCD.TRAVEL_CLASS, '') AS TRAVEL_CLASS,TCD.PREF_TIME_TYPE "+
																											   " FROM T_TRAVEL_CAR_DETAIL TCD WHERE TCD.TRAVEL_ID="+strTravelId+" AND TRAVEL_TYPE='D' AND TCD.STATUS_ID=10 AND JOURNEY_ORDER=(SELECT MAX(T_TRAVEL_CAR_DETAIL.JOURNEY_ORDER) "+
																											   " FROM T_TRAVEL_CAR_DETAIL  WHERE T_TRAVEL_CAR_DETAIL.TRAVEL_ID=TCD.TRAVEL_ID AND T_TRAVEL_CAR_DETAIL.TRAVEL_TYPE='D' AND T_TRAVEL_CAR_DETAIL.STATUS_ID=10) ORDER BY JOURNEY_ORDER";
																								  } else if(strTravelType.equals("I")) {
																									  strSql = " SELECT 'Return' AS JOURNEY, TRAVEL_CAR_ID, TCD.TRAVEL_ID, TRAVEL_TYPE, ISNULL(START_CITY, '') AS START_CITY, START_LOCATION,ISNULL(END_CITY, '') AS END_CITY, "+
																								  			   " END_LOCATION, DBO.CONVERTDATEDMY1(ISNULL(START_DATE,'')) AS START_DATE, START_TIME, DBO.CONVERTDATEDMY1(ISNULL(END_DATE,'')) AS END_DATE, END_TIME, GPS, CLASS, "+
																									           " ISNULL(START_MOBILENO, '') AS START_MOBILENO, ISNULL(END_MOBILENO, '') AS END_MOBILENO, ISNULL(TCD.TRAVEL_CLASS, '') AS TRAVEL_CLASS,TCD.PREF_TIME_TYPE "+
																								  			   " FROM T_TRAVEL_CAR_DETAIL TCD WHERE TCD.TRAVEL_ID="+strTravelId+" AND TRAVEL_TYPE='I' AND TCD.STATUS_ID=10 AND JOURNEY_ORDER=(SELECT MAX(T_TRAVEL_CAR_DETAIL.JOURNEY_ORDER) "+
																											   " FROM T_TRAVEL_CAR_DETAIL WHERE T_TRAVEL_CAR_DETAIL.TRAVEL_ID=TCD.TRAVEL_ID AND T_TRAVEL_CAR_DETAIL.TRAVEL_TYPE='I' AND T_TRAVEL_CAR_DETAIL.STATUS_ID=10) ORDER BY JOURNEY_ORDER";
																								  }		
																								
																								rsCar3=null;
																								rsCar3  =   dbConBean.executeQuery(strSql);  
																								if(rsCar3.next()) {
																								carYNFlag 			   		= "true";
																								strTravelIdRetCar			= rsCar3.getString("TRAVEL_CAR_ID");
																								strDepCityRetCar           	= rsCar3.getString("START_CITY"); 
																								strArrCityRetCar           	= rsCar3.getString("END_CITY");
																								strDepDateRetCar		 	= rsCar3.getString("START_DATE");
																								strPreferTimeModeRetCar		= rsCar3.getString("PREF_TIME_TYPE");
																								strPreferTimeRetCar        	= rsCar3.getString("START_TIME");
																								strLocationRetCar       	= rsCar3.getString("START_LOCATION");
																								strMobileRetCar				= rsCar3.getString("START_MOBILENO");
																								}
																								rsCar3.close();
																							} 
																						%>																				 
																					    <tr><td class="journeyTitle" colspan="8"><%=dbLabelBean.getLabel("label.global.returnjourney",strsesLanguage)%></td></tr>
																						<tr class="itineraryDataRowCar">
																							<input type="hidden" name="travelCarId" id="travelCarIdRet" value="<%=strTravelIdRetCar %>" />
																							<td class="city"><input type="text" name="depCityCar" class="textBoxCss" value="<%=strDepCityRetCar %>" id="depCityCarTBRet" placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'c')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																							<td class="city"><input type="text" name="arrCityCar" class="textBoxCss" value="<%=strArrCityRetCar %>" id="arrCityCarTBRet" placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'c')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																							<td class="date"><input type="text" name="depDateCar" class="textBoxCss validDateCar validDate" value="<%=strDepDateRetCar %>" id="depDateCarTBRet" onFocus="initializeJourneyDateCar(this, '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>');" placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																							<td class="timeMode">
																								<select name="preferTimeModeCar" class="comboBoxCss" id="preferTimeModeCarSBRet" title="<%=dbLabelBean.getLabel("label.global.preferredtimemode",strsesLanguage)%>">
																								<%
																									types =   TravelRequestEnums.PreferredTimeTypes.values();
																										for(t=0; t<types.length; t++){
																											if(!strPreferTimeModeRetCar.equals("") && types[t].getId().equals(strPreferTimeModeRetCar)) {
																								%>
														                              							<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																								<%
												                            								} else {
												                            		 							if((strPreferTimeModeRetCar == null || strPreferTimeModeRetCar.equals("")) && types[t].getId().equals("1")) {
												                           					 	%>
														                              								<option value="<%=types[t].getId()%>" selected="selected"><%=types[t].getName()%></option>
																								<%
												                            		 							} else {
												                            					%>
												                            										<option value="<%=types[t].getId()%>"><%=types[t].getName()%></option>
												                            					<%	 
												                            			 						}
												                            	 							}
																										}
																								%>
																								</select>
																							</td>
																							<td class="time">
																								 <select name="preferTimeCar" class="comboBoxCss" id="preferTimeCarSBRet" title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																										<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectTime",strsesLanguage)%></option>
																									<%						                           
																										entrySet = preferredTimeList.entrySet();
																										it = entrySet.iterator();
																			                             while(it.hasNext()) {
																			                            	Map.Entry entry = (Map.Entry)it.next();
																			                            	if(!excludePreferredTimeList.contains(entry.getKey())) {
																										 		if(!entry.getKey().equals("102")){
																			                            	 		if(strPreferTimeRetCar != null && !strPreferTimeRetCar.equals("") && entry.getKey().equals(strPreferTimeRetCar)) {
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
																			                         	 }
																									%>	
																		                        </select>
																							</td>
																							<td class="location">
																								<select name="locationCar" class="comboBoxCss" id="locationCarSBRet" title="<%=dbLabelBean.getLabel("label.global.location",strsesLanguage)%>">
																									<%
																										locations =   TravelRequestEnums.LocationsMataIndia.values();
																										for(i=0; i<locations.length; i++) {	
																											if(strLocationRetCar != null && !strLocationRetCar.equals("") && locations[i].getId().equals(strLocationRetCar)) {
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
																							<td class="mobileNo"><input type="text" name="mobileNumberCar" class="textBoxCss" value="<%=strMobileRetCar %>" id="mobileNumberCarTBRet" placeholder="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>" onKeyUp="return test2(this, 19, 'phone')" maxlength="20" title="<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>"></td>
																							<td class="tatkaalTktInput"></td>															
																						</tr>																
																				</tbody>
																				<script language="javascript">
																					var carDetailFlag = '<%=carYNFlag%>';
																					 if(carDetailFlag === "true") {
																						$("label#carRequiredNo").removeClass("active");
																						$("label#carRequiredYes").addClass("active");
																						$("input:radio#carRequired_N").attr('checked', false);
																						$("input:radio#carRequired_Y").attr('checked', true);													
																						$("tr#carDetail").show();	
																					 } else {
																						 $("label#carRequiredYes").removeClass("active");
																						 $("label#carRequiredNo").addClass("active");
																						 $("input:radio#carRequired_Y").attr('checked', false);
																						 $("input:radio#carRequired_N").attr('checked', true);
																						 $("tr#carDetail").hide();
																					 }
																					 
																					var rowLength = $("table#tblItineraryCar tbody tr.itineraryDataRowCar").length;
																					if(rowLength > 2 && $("tr#intJrnyTitleRowCar").hasClass("hide")){
																						$("tr#intJrnyTitleRowCar").removeClass("hide");
																						$("tr#intJrnyTitleRowCar").addClass("show");
																					}
																				</script>
																			</table>
																		</td>
																	</tr>
																	<tr valign="top">
																		<td>
																			<table width="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td class="itenaryRemark">
																						<textarea name="remarksCar" id="remarksCar" class="textAreaCss" rows="" cols="" onKeyUp="return test2(this, 1000, 'cn')" maxlength="1000" placeholder="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>"><%=strRemarkCar %></textarea>
																					</td>
																					<td class="addIntrimJourneyBtn"><input type="button" value="<%=dbLabelBean.getLabel("link.global.intermediatejourney",strsesLanguage)%>" class="bt-Add-Dom" id="bt_Add-Car" title=""/></td>	
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
											<!-- Car Details End -->	
											
											<!--  Accommodation Details Start -->
											<tr valign="top" id="accomodationDetailBlock">
												<td>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr><td class="hrSpace6Px"></td></tr>
														<tr valign="top" id="accomodationDetailBtn">
															<td class="journyType" style="padding:5px 0 0 0; border-top:1px solid #aea899;">
																<table width="230px" border="0" cellspacing="0" cellpadding="0">
																	<tr>
																		<td class="journyDetailLabel"><label
																			class="modeType"><b><%=dbLabelBean.getLabel("label.global.accommodation",strsesLanguage) %></b></label></td>
																		<td class="journyDetailRadio">
																			<table width="100%" border="0" cellspacing="0"
																				cellpadding="0" class="checkbox">
																				<tr>
																					<td class="labelTd"><label class="yes"
																						id="accomodationRequiredYes"> <input type="radio"
																							name="accomodation" value="1" id="accomodationRequired_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
																					</label></td>
																					<td class="labelTd"><label class="no"
																						id="accomodationRequiredNo"> <input type="radio"
																							name="accomodation" value="2" checked="checked"
																							id="accomodationRequired_N"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
																					</label></td>
																				</tr>
																			</table>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
														<tr valign="top" id="accomodationDetail" style="display: none;">
															<td style="border:1px solid #e0dfdf;">
																<table width="100%" border="0" cellspacing="0" cellpadding="0">
																	<tr valign="top">
																		<td style="padding:0 0 5px 20px;">
																			<table width="75%" border="0" cellspacing="0" cellpadding="0" id="tblAccomodation">
																				<tbody>
																					<%  
																						int x = 0;
																						if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																							strSql =" SELECT TRAVEL_ACC_ID,TRAVEL_ID,TRAVEL_TYPE,TRANSIT_TYPE,BUDGET_CURRENCY,TRANSIT_BUDGET,DBO.CONVERTDATEDMY1(ISNULL(CHECK_IN_DATE,'')) AS CHECK_IN_DATE,DBO.CONVERTDATEDMY1(ISNULL(CHECK_OUT_DATE,'')) AS CHECK_OUT_DATE,PLACE "+
																									" FROM T_TRAVEL_ACCOMMODATION TA WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_TYPE='"+strTravelType+"' AND STATUS_ID=10 ORDER BY TRAVEL_ACC_ID";
															
																								rsAccom = null;			
																								rsAccom  =   dbConBean.executeQuery(strSql);  
																								if(rsAccom.next()) {
																									do {
																									accomYNFlag			=  "true";
																									strAccId			=  rsAccom.getString("TRAVEL_ACC_ID");
																									strHotelRequired    =  rsAccom.getString("TRANSIT_TYPE");
																									strBudgetCurrency	=  rsAccom.getString("BUDGET_CURRENCY");
																									strHotelBudget		=  rsAccom.getString("TRANSIT_BUDGET");
																									strPlace   			=  rsAccom.getString("PLACE");
																									strCheckin        	=  rsAccom.getString("CHECK_IN_DATE");
																									strCheckout        	=  rsAccom.getString("CHECK_OUT_DATE");	
																									
																									if(!strHotelRequired.equals("0")) {
																					%>
																									<tr class="accomodationDataRow">
																										<input type="hidden" name="accomId" id="accomId" value="<%=strAccId%>">	
																										<td class="accomComboBoxHotel">
																											<select name="hotel" id="accomStayType" class="comboBoxCss" onchange="stayTypeChangeEvent(this);" title="<%=dbLabelBean.getLabel("label.global.staytype",strsesLanguage)%>" >
																											<%
																												if(strHotelRequired != null && !"".equals(strHotelRequired) && "1".equals(strHotelRequired)) {
																											%>
																													<option value="1" selected="selected"><%=dbLabelBean.getLabel("label.global.hotel",strsesLanguage)%></option>
																													<option value="2"><%=dbLabelBean.getLabel("label.global.transithouse",strsesLanguage)%></option>
																											<%		
																												} else if(strHotelRequired != null && !"".equals(strHotelRequired) && "2".equals(strHotelRequired)) {																											
																											%>
																													<option value="1"><%=dbLabelBean.getLabel("label.global.hotel",strsesLanguage)%></option>
																													<option value="2" selected="selected"><%=dbLabelBean.getLabel("label.global.transithouse",strsesLanguage)%></option>
																											<%
																												} else {																											
																											%>
																													<option value="1" selected="selected"><%=dbLabelBean.getLabel("label.global.hotel",strsesLanguage)%></option>
																													<option value="2"><%=dbLabelBean.getLabel("label.global.transithouse",strsesLanguage)%></option>
																											<%																													
																												}
																											%>
																											</select>																						
																										</td>
																										<td class="accomComboBoxCurr">
																											<select name="currency" id="accomCurrency" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.currency",strsesLanguage)%>">
																										 	<%						                           
																												entrySet = currencyList.entrySet();
																												it = entrySet.iterator();
																					                             while(it.hasNext()) {
																					                            	 Map.Entry entry = (Map.Entry)it.next();
																					                            	 if(strBudgetCurrency != null && !strBudgetCurrency.equals("") && entry.getKey().equals(strBudgetCurrency)) {
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
																										<td class="accomInputBoxBudget">
																											<input type="text" name="budget" class="textBoxCss" id="accomBudget" value="<%=strHotelBudget %>" placeholder="<%=dbLabelBean.getLabel("label.global.budget",strsesLanguage)%>" onKeyUp="return test2(this, 12, 'n')" maxlength="20" title="<%=dbLabelBean.getLabel("label.global.budget",strsesLanguage)%>">
																										</td>
																										<td class="accomInputBoxDate">
																											<input type="text" name="checkin" class="textBoxCss validDateAccom" id="checkInDate" onFocus="initializeAccommoDate(this, '<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>');" value="<%=strCheckin %>" placeholder="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>">
																										</td>
																										<td class="accomInputBoxDate">
																											<input type="text" name="checkout" class="textBoxCss validDateAccom" id="checkOutDate" onFocus="initializeAccommoDate(this, '<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>');" value="<%=strCheckout %>" placeholder="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>">
																										</td>
																										<td class="accomInputBoxPrefPlc">
																											<input type="text" name="place" class="textBoxCss" id="accomPlace" value="<%=strPlace %>" placeholder="<%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage)%>" onKeyUp="return test2(this, 20, 'c')" maxlength="20" title="<%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage)%>">
																										</td>
																										<td class="accomDel"><img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0" id="bt-Del-Accomodation" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"></td>
																									</tr>
																					<%				
																									} else {
																					%>
																									<tr class="accomodationDataRow">
																										<input type="hidden" name="accomId" id="accomId" value="">	
																										<td class="accomComboBoxHotel">
																											<select name="hotel" id="accomStayType" class="comboBoxCss" onchange="stayTypeChangeEvent(this);" title="<%=dbLabelBean.getLabel("label.global.staytype",strsesLanguage)%>" >
																												<option value="1"><%=dbLabelBean.getLabel("label.global.hotel",strsesLanguage)%></option>
																												<option value="2"><%=dbLabelBean.getLabel("label.global.transithouse",strsesLanguage)%></option>
																											</select>
																										</td>
																										<td class="accomComboBoxCurr">
																											<select name="currency" id="accomCurrency" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.currency",strsesLanguage)%>">
																										 	<%						                           
																												entrySet = currencyList.entrySet();
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
																										<td class="accomInputBoxBudget">
																											<input type="text" name="budget" class="textBoxCss" id="accomBudget" value="" placeholder="<%=dbLabelBean.getLabel("label.global.budget",strsesLanguage)%>" onKeyUp="return test2(this, 12, 'n')" maxlength="20" title="<%=dbLabelBean.getLabel("label.global.budget",strsesLanguage)%>">
																										</td>
																										<td class="accomInputBoxDate">
																											<input type="text" name="checkin" class="textBoxCss validDateAccom validDate" id="checkInDate" onFocus="initializeAccommoDate(this, '<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>');" value="" placeholder="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>">
																										</td>
																										<td class="accomInputBoxDate">
																											<input type="text" name="checkout" class="textBoxCss validDateAccom validDate" id="checkOutDate" onFocus="initializeAccommoDate(this, '<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>');" value="" placeholder="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>">
																										</td>
																										<td class="accomInputBoxPrefPlc">
																											<input type="text" name="place" class="textBoxCss" id="accomPlace" value="" placeholder="<%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage)%>" onKeyUp="return test2(this, 20, 'c')" maxlength="20" title="<%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage)%>">
																										</td>
																										<td class="accomDel"></td>
																									</tr>
																					<%
																									}
																								x++;
																									} 
																									while(rsAccom.next());
																								} else { 
																					%>
																									<tr class="accomodationDataRow">
																										<input type="hidden" name="accomId" id="accomId" value="">	
																										<td class="accomComboBoxHotel">
																											<select name="hotel" id="accomStayType" class="comboBoxCss" onchange="stayTypeChangeEvent(this);" title="<%=dbLabelBean.getLabel("label.global.staytype",strsesLanguage)%>" >
																												<option value="1"><%=dbLabelBean.getLabel("label.global.hotel",strsesLanguage)%></option>
																												<option value="2"><%=dbLabelBean.getLabel("label.global.transithouse",strsesLanguage)%></option>
																											</select>
																										</td>
																										<td class="accomComboBoxCurr">
																											<select name="currency" id="accomCurrency" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.currency",strsesLanguage)%>">
																										 	<%						                           
																												entrySet = currencyList.entrySet();
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
																										<td class="accomInputBoxBudget">
																											<input type="text" name="budget" class="textBoxCss" id="accomBudget" value="" placeholder="<%=dbLabelBean.getLabel("label.global.budget",strsesLanguage)%>" onKeyUp="return test2(this, 12, 'n')" maxlength="20" title="<%=dbLabelBean.getLabel("label.global.budget",strsesLanguage)%>">
																										</td>
																										<td class="accomInputBoxDate">
																											<input type="text" name="checkin" class="textBoxCss validDateAccom" id="checkInDate" onFocus="initializeAccommoDate(this, '<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>');" value="" placeholder="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>">
																										</td>
																										<td class="accomInputBoxDate">
																											<input type="text" name="checkout" class="textBoxCss validDateAccom" id="checkOutDate" onFocus="initializeAccommoDate(this, '<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>');" value="" placeholder="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>">
																										</td>
																										<td class="accomInputBoxPrefPlc">
																											<input type="text" name="place" class="textBoxCss" id="accomPlace" value="" placeholder="<%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage)%>" onKeyUp="return test2(this, 20, 'c')" maxlength="20" title="<%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage)%>">
																										</td>
																										<td class="accomDel"></td>
																									</tr>
																					<% 
																								}
																								rsAccom.close();
																						} else {
																					%>
																							<tr class="accomodationDataRow">
																								<input type="hidden" name="accomId" id="accomId" value="">	
																								<td class="accomComboBoxHotel">
																									<select name="hotel" id="accomStayType" class="comboBoxCss" onchange="stayTypeChangeEvent(this);" title="<%=dbLabelBean.getLabel("label.global.staytype",strsesLanguage)%>" >
																										<option value="1"><%=dbLabelBean.getLabel("label.global.hotel",strsesLanguage)%></option>
																										<option value="2"><%=dbLabelBean.getLabel("label.global.transithouse",strsesLanguage)%></option>
																									</select>
																								</td>
																								<td class="accomComboBoxCurr">
																									<select name="currency" id="accomCurrency" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.currency",strsesLanguage)%>">
																								 	<%						                           
																										entrySet = currencyList.entrySet();
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
																								<td class="accomInputBoxBudget">
																									<input type="text" name="budget" class="textBoxCss" id="accomBudget" value="" placeholder="<%=dbLabelBean.getLabel("label.global.budget",strsesLanguage)%>" onKeyUp="return test2(this, 12, 'n')" maxlength="20" title="<%=dbLabelBean.getLabel("label.global.budget",strsesLanguage)%>">
																								</td>
																								<td class="accomInputBoxDate">
																									<input type="text" name="checkin" class="textBoxCss validDateAccom" id="checkInDate" onFocus="initializeAccommoDate(this, '<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>');" value="" placeholder="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>">
																								</td>
																								<td class="accomInputBoxDate">
																									<input type="text" name="checkout" class="textBoxCss validDateAccom" id="checkOutDate" onFocus="initializeAccommoDate(this, '<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>');" value="" placeholder="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>">
																								</td>
																								<td class="accomInputBoxPrefPlc">
																									<input type="text" name="place" class="textBoxCss" id="accomPlace" value="" placeholder="<%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage)%>" onKeyUp="return test2(this, 20, 'c')" maxlength="20" title="<%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage)%>">
																								</td>
																								<td class="accomDel"></td>
																							</tr>
																					<%
																						}
																					%>
																					<tr class="innerRowAccomodation"></tr>
																					<tr class="prototypeRowAccomodation">
																						<input type="hidden" name="accomIdPT" id="accomId" value="">	
																						<td class="accomComboBoxHotel">
																							<select name="hotelPT" id="accomStayType" class="comboBoxCss" onchange="stayTypeChangeEvent(this);" title="<%=dbLabelBean.getLabel("label.global.staytype",strsesLanguage)%>" >
																								<option value="1" selected="selected"><%=dbLabelBean.getLabel("label.global.hotel",strsesLanguage)%></option>
																								<option value="2"><%=dbLabelBean.getLabel("label.global.transithouse",strsesLanguage)%></option>
																							</select>
																						</td>
																						<td class="accomComboBoxCurr">
																							<select name="currencyPT" id="accomCurrency" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.currency",strsesLanguage)%>">
																						 	<%						                           
																								entrySet = currencyList.entrySet();
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
																						<td class="accomInputBoxBudget">
																							<input type="text" name="budgetPT" class="textBoxCss" id="accomBudget" value="" placeholder="<%=dbLabelBean.getLabel("label.global.budget",strsesLanguage)%>" onKeyUp="return test2(this, 12, 'n')" maxlength="20" title="<%=dbLabelBean.getLabel("label.global.budget",strsesLanguage)%>">
																						</td>
																						<td class="accomInputBoxDate">
																							<input type="text" name="checkinPT" class="textBoxCss validDateAccom" id="checkInDate" onFocus="initializeAccommoDate(this, '<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>');" value="" placeholder="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>">
																						</td>
																						<td class="accomInputBoxDate">
																							<input type="text" name="checkoutPT" class="textBoxCss validDateAccom" id="checkOutDate" onFocus="initializeAccommoDate(this, '<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>', '<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>');" value="" placeholder="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>">
																						</td>
																						<td class="accomInputBoxPrefPlc">
																							<input type="text" name="placePT" class="textBoxCss" id="accomPlace" value="" placeholder="<%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage)%>" onKeyUp="return test2(this, 20, 'c')" maxlength="20" title="<%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage)%>">
																						</td>
																						<td class="accomDel"><img src="images/delete.png?buildstamp=2_0_0" width="24px" height="20px" border="0" id="bt-Del-Accomodation" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"></td>
																					</tr>
																				</tbody>
																				<tr valign="top">
																					<td colspan="8">
																						<table width="100%" border="0" cellspacing="0" cellpadding="0">
																							<tr>
																								<td class="accomRemark">
																									<textarea name="otherComment" class="textAreaCss" id="otherComment" cols="" rows="2" placeholder="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>" onKeyUp="return test2(this, 200, 'all')" maxlength="200" title="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>"><%=strRemarks %></textarea>
																								</td>
																								<td class="addAccomBtn"><input type="button" value="<%=dbLabelBean.getLabel("label.global.addaccommodation",strsesLanguage)%>" class="bt-Add-Accom-Dom" id="bt_Add_Accomo" title="<%=dbLabelBean.getLabel("label.global.addaccommodation",strsesLanguage)%>" /></td>	
																							</tr>
																						</table>
																					</td>																										
																				</tr>
																				<tr>
																					<td colspan="8"><span class="accomtxt2"><sub>*</sub><%=dbLabelBean.getLabel("label.global.requirehotelthenspecifyhotelbudget",strsesLanguage)%></span><span id="hidethis" class="accomtxt3" style="display: none;">&nbsp;|&nbsp;<span class="accomtxt1"><sub>*</sub><%=dbLabelBean.getLabel("label.global.smokingmessage",strsesLanguage)%></span></span></td>
																				</tr>
																				
																				<script language="javascript">
																				    var accomRemarks = '<%=strRemarks%>';
																					var accomFlag = '<%=accomYNFlag%>';
																					var hotelRequired = '<%=strHotelRequired%>';
																					 if(accomFlag === "true" && hotelRequired != "0") {		
																						$("label#accomodationRequiredNo").removeClass("active");
																						$("label#accomodationRequiredYes").addClass("active");
																						$("input:radio#accomodationRequired_N").attr('checked', false);
																						$("input:radio#accomodationRequired_Y").attr('checked', true);
																						$("textarea#otherComment").val(accomRemarks);
																						$("tr#accomodationDetail").show();	
																					 } else {
																						 $("label#accomodationRequiredYes").removeClass("active");
																						 $("label#accomodationRequiredNo").addClass("active");
																						 $("input:radio#accomodationRequired_Y").attr('checked', false);
																						 $("input:radio#accomodationRequired_N").attr('checked', true);
																						 $("textarea#otherComment").val("");
																						 $("tr#accomodationDetail").hide();
																					 }
																			 	</script>
																			</table>
																		</td>
																	</tr>											
																</table>
															</td>
														</tr>
													</table>
												</td>
											</tr>								
											<!--  Accommodation Details End -->	
											
											<tr><td class="hrSpace6Px"></td></tr>
											<tr><td style="border-top:1px solid #aea899;"></td></tr>								
											<tr><td class="hrSpace6Px"></td></tr>
											
										</table>
									</td>
								</tr>
								
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">											
											<% if(strAppLvl3flg.equalsIgnoreCase("Y")) { %>
											<tr>
												<td>
													<table width="50%" border="0" cellspacing="2" cellpadding="0">
														<tr>
															<td class="ttfLabel"><%=dbLabelBean.getLabel("label.createrequest.totaltravelfare",strsesLanguage)%></td>
															<td class="ttfCurrnLabel"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage)%></td>
															<td class="ttfCurrnCombo">
																<select	name="TotalFareCurrency" id="totalfarecurrency" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.currency",strsesLanguage)%>">
																	<option value=""><%=dbLabelBean.getLabel("label.createrequest.selectcurrency",strsesLanguage) %></option>
																			<%
																				strSql = "Select rtrim(Currency), rtrim(Currency) from m_currency where status_id=10";
																				rs = dbConBean.executeQuery(strSql);
																				while (rs.next()) {%>
																					<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
																				<%}
																				rs.close();
																			%>
																	</select>
																	<% if(strTotalFareCurrency != null && !strTotalFareCurrency.equals("")) { %>
																	<script>
																		document.getElementById("totalfarecurrency").value="<%=strTotalFareCurrency%>";
																	</script>
																	<% } %>
															
															</td>
															<td class="ttfTotalFarelabel"><%=dbLabelBean.getLabel("label.createrequest.totalfare",strsesLanguage)%></td>
															<td class="ttfTotalFareBox">
																<input name="TotalFareAmount" id="totalfareamount" type="text" class="textBoxCss" onChange="check1();" onKeyUp="return test1(this, 20, 'n')" value="<%=strTotalFareAmount %>" title="<%=dbLabelBean.getLabel("label.createrequest.totalfare",strsesLanguage)%>" />
															</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr><td class="hrSpace6Px"></td></tr>
											<tr><td style="border-top:1px solid #aea899;"></td></tr>								
											<tr><td class="hrSpace6Px"></td></tr>
											 <%} %>
											 
											<%	if (strSHOW_BUD_INPUT.equalsIgnoreCase("Y")) { %>
											<tr>
												<td>
													<table width="80%" border="0" cellspacing="2" cellpadding="0">
														<tr>
															<td class="badLabel"><%=dbLabelBean.getLabel("label.global.budgetactualdetails",strsesLanguage) %></td>
															<td class="badYTMBudgetBox">
																<input type="text" name="YtmBud" class="textBoxCss" value="" id="YtmBud" onChange="check1();showDiff();" onKeyUp="return test2(this, 15, 'n')" maxlength="15" placeholder="<%=dbLabelBean.getLabel("label.global.ytmbudget",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.ytmbudget",strsesLanguage)%>">													
															</td>
																<script language="javascript">
																  	document.frm.YtmBud.value="<%=dbl_YTM_BUDGET%>";
																  </script>
															<td class="badYTMActualBox">
																<input type="text" name="YtmAct" class="textBoxCss" value="" id="YtmAct" onChange="check1();showDiff();" onKeyUp="return test2(this, 15, 'n')" placeholder="<%=dbLabelBean.getLabel("label.global.ytdactual",strsesLanguage)%>" maxlength="15" title="<%=dbLabelBean.getLabel("label.global.ytdactual",strsesLanguage)%>">
															</td>
															 	<script language="javascript">
																  	document.frm.YtmAct.value="<%=dbl_YTD_ACTUAL%>";
																  </script>
															<td class="badAvlBudgetBox">
																<input type="text" name="AvailBud" class="textBoxCss" value="" id="AvailBud" onChange="" onKeyUp="" placeholder="<%=dbLabelBean.getLabel("label.createrequest.availablebudget",strsesLanguage)%>" maxlength="15" title="<%=dbLabelBean.getLabel("label.createrequest.availablebudget",strsesLanguage)%>" readonly="readonly" onfocus="blur();">
															</td>
															<script language="javascript">
															  	document.frm.AvailBud.value="<%=dbl_AVAIL_BUDGET%>";
															  </script>
															<td class="badEstBox">
																<input type="text" name="EstExp" class="textBoxCss" value="" id="EstExp" onChange="check1();" onKeyUp="return test2(this, 15, 'n')" placeholder="<%=dbLabelBean.getLabel("label.global.estimatedexpenditure",strsesLanguage)%>" maxlength="15" title="<%=dbLabelBean.getLabel("label.global.estimatedexpenditure",strsesLanguage)%>">
															</td>
															<script language="javascript">
															  	document.frm.EstExp.value="<%=dbl_EST_EXP%>";
															  </script>
															<td class="badRemarkBox">
																<textarea name="budgetRemarks" class="textAreaCss2" id="budgetRemarks" cols="" rows="2" onKeyUp="return test2(this, 100, 'all')" placeholder="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>" maxlength="100" title="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>"><%=str_EXP_REMARKS.trim()%></textarea>
															</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr><td class="hrSpace6Px"></td></tr>
											<tr><td style="border-top:1px solid #aea899;"></td></tr>								
											<tr><td class="hrSpace6Px"></td></tr>
											<%} %>
											<tr class="hide" id="ticketsDetailRow">
												<td>
													<table width="100%" border="0" cellspacing="2" cellpadding="0">
														<tr valign="top">
															<td class="nonMataLeft">
																<table width="100%" border="0" cellspacing="0" cellpadding="0">
																	  <tr>
																		  <td class="nonMataTxt1"><%=dbLabelBean.getLabel("label.global.proposetobuyticketsfromnonmatasource",strsesLanguage)%></td>
																		  <td class="nonMataRadio">
																				<table width="100%" border="0" cellspacing="0" cellpadding="0">
																					<tr>																	
																						<td class="nonMataYesNoRd">
																							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="checkbox">
																								<tr>
																									<td class="labelTd">
																										<label class="yes" id="tkflyYes">
																											<input type="radio" name="tkflyes" value="n" id="tkflyes_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
																										</label>
																									</td>
																									<td class="labelTd">
																										<label class="no active" id="tkflyNo">
																											<input type="radio" name="tkflyes" value="y" id="tkflyes_N" checked="checked"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
																										</label>
																									</td>																									
																								</tr>
																							</table>
																						</td>
																					</tr>
																				</table>
																		  </td>
																	  </tr>
																	  <tr><td class="nonMataTxt2" colspan="2"><%=dbLabelBean.getLabel("label.global.nonmatasource",strsesLanguage)%></td></tr>													  																
																  </table>
															</td>
															<td class="nonMataRight">
																<table width="70%" border="0" cellspacing="0" cellpadding="0">
																	<tr class="hide" id="nonMataDetailRow">	
																		<td class="nonMataAirline">
																  			<input type="text" name="pricingAirline" class="textBoxCss" value="" id="pricingAirline" onkeyup="return test2(this, 50, 'cn')" placeholder="<%=dbLabelBean.getLabel("label.global.airline",strsesLanguage)%>" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.airline",strsesLanguage)%>">
																  			<script language="javascript">
																		  		document.frm.pricingAirline.value="<%=strTkAirLine.trim()%>";
																		  	</script>
																  		</td>
																  		<td class="nonMataCurrency">
																  			<select name="pricingCurrency" class="comboBoxCss" id="pricingCurrency" title="<%=dbLabelBean.getLabel("label.global.currency",strsesLanguage)%>">
																			<%
																			strSql = "Select Currency, Currency from m_currency where status_id=10";
																			rs = dbConBean.executeQuery(strSql);
																			while (rs.next()) {
																			%>
																				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
																			<%}
																			rs.close();
																			%>
																			</select>
																			 <script language="JavaScript">
																			 	var pricingCurrencyVal = '<%=strTkcurrency.trim()%>';
																			 	if(pricingCurrencyVal == null || pricingCurrencyVal == '') {
																			  	 $("select#pricingCurrency").find('option').eq(1).prop('selected', true);
																			 	} else {
																			 		document.frm.pricingCurrency.value="<%=strTkcurrency.trim()%>"; 
																			 	}
																			</script>
																  		</td>
																  		<td class="nonMataLocalPrice">
																  			<input type="text" name="localprice" class="textBoxCss" value="" id="localprice" onKeyUp="return test2(this, 10, 'n')" placeholder="<%=dbLabelBean.getLabel("label.global.localprice",strsesLanguage)%>" maxlength="10" title="<%=dbLabelBean.getLabel("label.global.localprice",strsesLanguage)%>">
																  			<script language="javascript">
																		  		document.frm.localprice.value="<%=strTklocalprice.trim()%>";
																		  	</script>
																  		</td>
																  		<td class="nonMataRemark">
																  			<textarea name="pricingRemarks" class="textAreaCss2" id="pricingRemarks" cols="" rows="2" onKeyUp="return test2(this, 100, 'all')" placeholder="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>" maxlength="100" title="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>"><%=strTkRemarks.trim()%></textarea>
																  		</td>	
																	</tr>
																	<script language= "JavaScript">
																			var matapricecomp = "";	
																			var ticketProvider = '<%=strTkAgent%>';
																		
																			if($('input#rd_Dom').is(':checked')) {
																				matapricecomp = '<%=strforPriceDesicionDom %>';
																			} else if($('input#rd_Int').is(':checked')) { 
																				matapricecomp = '<%=strforPriceDesicionInt %>';
																			}
																		
																			var matapricecomp1 = matapricecomp;
																			var matapricecomp2 = "y";
																			
																			if(matapricecomp1.toLowerCase() === matapricecomp2.toLowerCase()) {
																				if (ticketProvider == "n") {
																					$("label#tkflyNo").removeClass("active");
																					$("label#tkflyYes").addClass("active");																			
																					$('input:radio#tkflyes_Y').val("n");
																					document.frm.tkflyes[0].checked = true;
																					document.frm.tkflyes[1].checked = false;
																					$('tr#nonMataDetailRow').removeClass("hide");
																					$('tr#nonMataDetailRow').addClass("show");
																				} else {
																					$("label#tkflyYes").removeClass("active");
																				   	$("label#tkflyNo").addClass("active");
																				   	$('input:radio#tkflyes_N').val("y");
																					document.frm.tkflyes[0].checked = false;
																					document.frm.tkflyes[1].checked = true;
																					$('tr#nonMataDetailRow').removeClass("show");
																					$('tr#nonMataDetailRow').addClass("hide");
																				}
																			}
																		 </script>	
																</table>
															</td>
														</tr>
														<tr><td class="hrSpace6Px"></td></tr>
														<tr><td style="border-top:1px solid #aea899;"></td></tr>								
														<tr><td class="hrSpace6Px"></td></tr>											
													</table>
												</td>
											</tr>											
										</table>
									</td>
								</tr>
								
								<!--  Billing/Approver/Default Approver Details Start -->	
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<!--  Billing/Approver Details Start -->
												<td id="left">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td style="width:40%;">
																<table width="100%" border="0" cellspacing="0" cellpadding="0">
																	<tr>
																		<td class="billingClientLabel"><%=dbLabelBean.getLabel("label.requestdetails.billingclient",strsesLanguage)%></td>
																		<td class="billingClientCombo">
																			<select name="billingSMGSite" id="billingSMGSite" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.requestdetails.billingclient",strsesLanguage)%>">
																			<% 
																				strSql = "SELECT SITE_ID,DBO.SITENAME(SITE_ID) AS SITE_NAME FROM M_SITE WHERE STATUS_ID=10 AND APPLICATION_ID=1 AND (M_SITE.CLOSED_UNIT_FLAG is null or M_SITE.CLOSED_UNIT_FLAG='') ORDER BY 2";
																				rs = dbConBean.executeQuery(strSql);
																			    while (rs.next()) {%>
																					<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
																					<%}
																					rs.close();
																					%>
																			</select>
																			
																				<%
																				if (strBillingSite != null && !strBillingSite.equals("-1")	&& !strBillingSite.equals("0")) {
																				%>
																				<script language="javascript">
																					document.frm.billingSMGSite.value="<%=strBillingSite%>";
																				</script>
																				<% } else if (strBillingSite != null && (strBillingSite.equals("-1") || strBillingSite.equals("0"))) { %>
																				<script language="javascript">
																					document.frm.billingSMGSite.value="<%=strTravllerSiteId%>";
																				</script>
																				<%} else if (strBillingSite == null) {
																				%>
																				<script language="javascript">      
																					document.frm.billingSMGSite.value="<%=strTravllerSiteId%>";
																				</script>
																				<%
																				}
																				%>
																		</td>
																	</tr>
																	<tr><td class="hrSpace10Px" colspan="2"></td></tr>
																	<tr>
																		<td class="billingApproverLabel"><%=dbLabelBean.getLabel("label.requestdetails.billingapprover",strsesLanguage)%></td>
																		<td class="billingApproverCombo">
																			<select name="billingSMGUser" id="billingSMGUser" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.requestdetails.billingapprover",strsesLanguage)%>">
																				<option  value='-1'><%=dbLabelBean.getLabel("label.createrequest.userfrombillingunit",strsesLanguage)%></option>
																				<%
																					if (strBillingSite != null && !strBillingSite.equals("0") && !strBillingSite.equals("-1") && !strBillingSite.equals(strTravllerSiteId) && !strFlag.equals("1")) { 
																					strSql = "SELECT  1 "
																						+ "FROM M_BILLING_APPROVER BA inner join M_userInfo UI on UI.userid = BA.approver_id "
																						+ "WHERE BA.SITE_ID= " + strBillingSite
																						+ " and status_id =10";
																						
																						rs = dbConBean.executeQuery(strSql);
																						if (!rs.next()) {
																							rs.close();
																							strSql = "select distinct userid, dbo.user_name(userid) As UserName from M_userInfo "
																								+ "where (site_id="
																								+ strBillingSite
																								+ " and status_id=10 and  ISNULL(APPROVER_LEVEL,0) in (1,2) )"
																								+ "or (status_id=10 and  ISNULL(APPROVER_LEVEL,0) in (3) )"
																								+ "order by 2";
																								
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
																								+ strBillingSite
																								+ " and status_id =10";
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
																			if (strBillingSite != null && !(strBillingSite.equals("-1") || strBillingSite.equals("0") || strBillingSite.equals(""))) {
																			%>
																			<script language="javascript">													
																				document.frm.billingSMGUser.value="<%=strBillingClient%>";
																			</script>
																			<%
																				}
																			%>
																		</td>
																	</tr>
																	<tr><td class="hrSpace10Px" colspan="2"></td></tr>
																	<tr>
																		<td class="approverLevel1Label"><%=dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage)%></td>
																		<td class="approverLevel1Combo">
																			<select name="manager" id="firstapprover" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage)%>" onChange="skipDisabled(this.form,'first');">
																				<option value='S'><%=dbLabelBean.getLabel("label.createrequest.selectapprovallevel1",strsesLanguage)%></option>
																				<%
																					strSql="Select USERID, dbo.user_name(USERID) AS PM FROM M_USERINFO (NOLOCK) WHERE APPROVER_LEVEL=1 AND SITE_ID="+strSiteId+" AND USERID<>"+strUserId+" AND STATUS_ID=10 AND APPLICATION_ID=1 UNION SELECT UAM.USERID,dbo.user_name(UAM.USERID)AS PM  FROM USER_MULTIPLE_ACCESS UAM WHERE UAM.USERID<>"+strUserId+" AND SITE_ID="+strSiteId+" AND UAM.USERID<>"+strUserId+" AND APPROVAL_LVL1='Y' AND STATUS_ID=10 ORDER BY 2";
																					rs  =   dbConBean.executeQuery(strSql);  
															                        while(rs.next()) {%>
															                          <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
															                    <%}
															                    rs.close();	  
																				%>
																			</select>
																			<% if(strManager !=null && !strManager.equals("") && !strManager.equalsIgnoreCase("S")) {%>
																				<script language="javascript">
																                  var firstApprover = document.getElementById("firstapprover");
																                  var firstAppVal = "";
																                  for (var i = 0; i < firstApprover.length; i++) {
																                  	firstAppVal = firstApprover.options[i].value;	                    	
																                  	if(firstAppVal == <%=strManager%>){	                    		
																                  		document.frm.manager.value="<%=strManager%>"; 
																                  		break;
																                  	} else if(firstAppVal != <%=strManager%>){                    		
																                  		document.frm.manager.value="S";
																                  	} 
																                  }
															            	   </script> 
																			<% } %>
																		</td>
																	</tr>
																	<tr><td class="hrSpace10Px" colspan="2"></td></tr>
																	<tr>
																		<td class="approverLevel2Label"><%=dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage)%></td>
																		<td class="approverLevel2Combo">
																			<select name="hod" id="secondapprover" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage)%>" onChange="skipDisabled(this.form,'second');">
																				<option value='S'><%=dbLabelBean.getLabel("label.createrequest.selectapprovallevel2",strsesLanguage)%></option>
																				<%
																					strSql="Select USERID, dbo.user_name(USERID) AS HOD FROM M_USERINFO (NOLOCK) WHERE ((APPROVER_LEVEL=2 AND SITE_ID="+strSiteId+") or (APPROVER_LEVEL=3)) AND USERID<>"+strUserId+" AND STATUS_ID=10 AND APPLICATION_ID=1 UNION SELECT UAM.USERID,dbo.user_name(UAM.USERID)AS PM  FROM USER_MULTIPLE_ACCESS UAM WHERE UAM.USERID<>"+strUserId+" AND SITE_ID="+strSiteId+" AND APPROVAL_LVL2='Y' AND STATUS_ID=10 ORDER BY 2";
																					rs       =   dbConBean.executeQuery(strSql); 
																					while(rs.next()) {%>
																					 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
																					<%}
																					rs.close();
																				%>
																			</select>
																			<%if(strHod !=null && !strHod.equals("") && !strHod.equalsIgnoreCase("S")) {%>
																			 	<script language="javascript">
																                 	var secondApprover = document.getElementById("secondapprover");
																                 	var secondAppVal;
																                 	for (var i = 0; i < secondApprover.length; i++) {
																                 		secondAppVal = secondApprover.options[i].value;	                    	
																                 		if(secondAppVal == <%=strHod%>){	                    		
																                 			document.frm.hod.value="<%=strHod%>"; 
																                 			break;
																                 		} else if(secondAppVal != <%=strHod%>){                    		
																                 			document.frm.hod.value="S";
																                 		} 
																                 	}
															            		 </script>
																			<%} %>
																		</td>
																	</tr>
																	<% if(strAppLvl3flgforBM.trim().equalsIgnoreCase("Y")) {%>
																	<tr><td class="hrSpace10Px" colspan="2"></td></tr>
																	<tr>
																		<td class="approverLevel3Label"><%=dbLabelBean.getLabel("label.global.boardmember",strsesLanguage)%></td>
																		<td class="approverLevel3Combo">
																			<select name="boardmember" id="thirdapprover" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.boardmember",strsesLanguage)%>" onChange="skipDisabled(this.form,'third');">
																				<option value='B'><%=dbLabelBean.getLabel("label.createrequest.selectboardmember",strsesLanguage)%></option>
																				<option value="-2"><%=dbLabelBean.getLabel("label.global.notapplicable",strsesLanguage)%></option> 
																				<%
																					 strSql = "SELECT USERID, DBO.user_name(USERID) AS BM FROM M_BOARD_MEMBER WHERE M_BOARD_MEMBER.USERID<>"+strUserId+" AND M_BOARD_MEMBER.SITE_ID="+strSiteId+" AND M_BOARD_MEMBER.STATUS_ID=10";
																					 rs   =   dbConBean.executeQuery(strSql); 
																					 while(rs.next()) {%>
																					      <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
																					<%}
																					 rs.close();	  
																					%>
																			</select>
																			<%if(strBoardMember !=null && !strBoardMember.equals("") && !strBoardMember.equalsIgnoreCase("B")) {%>
																				<script language="javascript">
															                	  var thirdApprover = document.getElementById("thirdapprover");
															                	  var thirdAppVal;
															                	  for (var i = 0; i < thirdApprover.length; i++) {
															                	  	thirdAppVal = thirdApprover.options[i].value;	                    	
															                	  	if(thirdAppVal == <%=strBoardMember%>){	                    		
															                	  		document.frm.boardmember.value="<%=strBoardMember%>";
															                	  		break;
															                	  	} else if(thirdAppVal != <%=strBoardMember%>){                    		
															                	  		document.frm.boardmember.value="B";
															                	  	} 
															                	  }
															            		  </script>
																			<%} %>
																		</td>
																	</tr>
																	<%} %>
																</table>
															</td>
															<td style="width:60%;" valign="top">
																<table width="100%" border="0" cellspacing="0" cellpadding="0">
																	<tr valign="top">
																		<td class="reasonForTravelLabel"><%=dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage)%></td>
																		<td class="reasonForTravelTextArea">
																			<textarea name="reasonForTravel" class="textAreaCss" cols="" rows="2" onKeyUp="return test2(this, 200, 'all')" maxlength="200" title="<%=dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage)%>"><%=strReasonForTravel %></textarea>
																		</td>
																	</tr>
																	<tr><td class="hrSpace10Px" colspan="2"></td></tr>
																	<tr valign="top">
																		<td class="skipReasonLabel"><%=dbLabelBean.getLabel("label.global.reasonforskippingtheapprovers",strsesLanguage)%></td>
																		<td class="skipReasonTextArea">
																			<textarea name="reasonForSkip" class="textAreaCss4" id="reasonForSkip" cols="" rows="2" onKeyUp="return test2(this, 200, 'all')" maxlength="200" title="<%=dbLabelBean.getLabel("label.global.reasonforskippingtheapprovers",strsesLanguage)%>"><%=strReasonForSkip %></textarea>
																		</td>
																	</tr>
																</table>															
															</td>
														</tr>														
													</table>
												</td>
												<!--  Billing/Approver Details End -->
												
												<!--  Defaul tApprover Start -->
												<td id="right">
													<div id="defaultApproverDiv"></div>
												</td>
												<!--  Default Approver End -->
											</tr>
										</table>
									</td>
								</tr>
								<!--  Billing/Approver/Default Approver Details End -->		
							</table>
						</td>
					</tr>					
				</table>
			</td>
		</tr>
		<!-- Itinerary Detail End -->
		
		<!-- Upload Attachment Start -->
		<tr>
			<td style="border-width: 0 0 0 0;">
				<table width="100%" border="0" cellspacing="2" cellpadding="0">					
					<tr>
						<td><a href="#" onClick="uploadAttachment();" title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%>"><img src="images/AttachFile.gif?buildstamp=2_0_0" width="94" height="24" border="0" /></a></td>
					</tr>
				</table>	
			</td>
		</tr>
		<!-- Upload Attachment End -->
		
		<tr>
			<td style="border-width: 0 0 0 0;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr><td style="padding-bottom:2px; border-top:1px solid #cbcbcb;"></td></tr>
				</table>
			</td>
		</tr>
		
		<!-- Submit To Workflow Start -->
		<tr>
			<td style="border-width: 0 0 0 0;">
				<table width="30%" border="0" cellspacing="5" cellpadding="0" align="center" style="margin-left:auto; margin-right:auto; text-align:center;">
					<tr>
						<td class="submitToWorkflow"><input type="button" name="saveandexit" value="Save and Exit" class="bt-SubmitToWorkflow-Dom" id="bt-SaveExit" title="Save and Exit"  onClick="checkData(this.form, 'saveExit');"/></td>
						<td class="submitToWorkflow"><input type="button" name="save" value="Save" class="bt-SubmitToWorkflow-Dom" id="bt-Save" title="Save"  onClick="checkData(this.form, 'save');"/></td>
						<td class="submitToWorkflow"><input type="button" name="saveproceed" value="Submit To Workflow" class="bt-SubmitToWorkflow-Dom" id="bt-SubmitToWorkflow" title="Submit To Workflow"  onClick="checkData(this.form, 'saveProceed');"/></td>					
					</tr>
				</table>
			</td>
		</tr>
		<!-- Submit To Workflow End -->
		
		<!-- Add Traveller(s) Note Start -->
		<tr>
			<td style="border-width: 0 0 0 0;">
				<table width="30%" border="0" cellspacing="0" cellpadding="0" align="center" style="margin-left:auto; margin-right:auto; text-align:center;">
					<tr>
						<td class="addTravellerNoteTxt">Kindly Add Traveller(s) Before <b>'Save'</b> or <b>'Submit To Workflow'</b></td>
					</tr>
				</table>
			</td>
		</tr>
		<!-- Add Traveller(s) Note End -->
	</table>
<!-- </div> -->
   <input type="hidden" name="todayDate" value="<%=strCurrentDate %>"/>
   <input type="hidden" name="travelId" value="<%=strTravelId%>"/>
   <input type="hidden" name="travelReqId" value="<%=strTravelReqId%>"/>
   <input type="hidden" name="travelReqNo" value="<%=strTravelReqNo%>"/>
   <input type="hidden" name="interimId" value ="<%=strIntermiId %>" />
   <input type="hidden" name="basecur" value="<%=strBaseCur %>" id="basecur"/>
   <input type="hidden" name="showFlag" value="<%=strShowflag %>" id="hidshowFlag"/> 
   <input type="hidden" name="unitHeadFlag" value="<%=strUnit_Head %>" id="unitHeadFlag"/> 
   <input type="hidden" name="BillingSiteFlag" value="<%=strFlag%>" id="BillingSiteFlag" />
   <input type="hidden" name="showBudInput" value="<%=strSHOW_BUD_INPUT %>" id="hidShowBudInput"/>
   <input type="hidden" name="hidAppLvl3flg" value="<%=strAppLvl3flg %>" id="hidAppLvl3flg"/>   
   <input type="hidden" name="hidAppLvl3showbmflg" value="<%=strAppLvl3flgforBM %>" id="hidAppLvl3showbmflg"/>  
   <input type="hidden" name="matapricecompdom" value="<%=strforPriceDesicionDom %>" id="matapricecompdom"/>
   <input type="hidden" name="matapricecompint" value="<%=strforPriceDesicionInt %>" id="matapricecompint"/>
   <input type="hidden" name="showCancelledRegflag" value="<%=strShowCancelledRegflag%>" id="showCancelledRegflag" />   
   <input type="hidden" name="approverlist" value="<%=ApproverText%>">   
   <input type="hidden" name="grpTrvExists" value= "<%=strGrpTrvExists%>" id="grpTrvExists"/>   
   <input type="hidden" name="whatAction" value ="<%=strwhatAction%>"/>
</form>  
<script type="text/javascript" src="ScriptLibrary/T_Group_QuickTravel_Detail_MATA.js?buildstamp=2_0_0"></script>
</body>
</html>
								
								
<script type="text/javascript">
var defaultApprWin;
var grpTrvExists	= '<%=strGrpTrvExists%>';

jQuery(document).ready(function($) {
	
	fun_calculate_GrandTotalUSD();	
	
	var strTravelIdVal 	= '<%=strTravelId%>';
	var travelTypeVal 	= '<%=strTravelType%>';
	
	if(travelTypeVal != null && travelTypeVal != '' && travelTypeVal == 'I') {
		$("#forexLabel_Int").css("display","block");
	} else {
		$("#forexLabel_Dom").css("display","block");
	}
	
	if(strTravelIdVal !=null && strTravelIdVal != "" && strTravelIdVal != "new") {
		
		fun_calculate_GrandTotalUSD();
		
		if(travelTypeVal != null && travelTypeVal != "" && travelTypeVal == 'D') {			
			setDomEditMode();			
		} else if(travelTypeVal != null && travelTypeVal != "" && travelTypeVal == 'I') {
			setIntEditMode();
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
						
			$('input#rd_Dom').attr('checked', true);			
			$('input#rd_Dom').val("D");
			$("label.Dom").removeClass("Disable");	
			
			setDomOnClickMode();	
			
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
			
			$('input#rd_Int').attr('checked', true);			
			$('input#rd_Int').val("I");
			$("label.Int").removeClass("Disable");
			
			setIntOnClickMode();	   
			
		} else {
		
			var domClickedFlag = false;
			var intClickedFlag = false;
			var checkItnrFlag = false;
			$("label.Int").addClass("Disable");	
			
			// domestic button click event 
			// [enable travel mode combo, change 'Add City +', 	    
			// 'Add Currency +'  and 'Submit to Workflow' button color]
			$('input#rd_Dom').on('click',function() {
				if(!domClickedFlag) {
					
					$(this).attr('checked', true);
					$('input#rd_Int').attr('checked', false);
					$(this).val("D");
					$("label.Dom").removeClass("Disable");
					$("label.Int").addClass("Disable");
					
					setDomOnClickMode();
					
					var depCityFlt 			= document.getElementsByName("depCityFlt");
			    	var arrCityFlt 			= document.getElementsByName("arrCityFlt");
			    	
			        for(var i = 0, len = depCityFlt.length; i < len; i++) {
					    if((depCityFlt[i].value != '' && depCityFlt[i].value != '<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') || (arrCityFlt[i].value != '' && arrCityFlt[i].value != '<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>')) {			
					    	  checkItnrFlag = true;
					    	  break;
					    }
					}
			        
				    if(checkItnrFlag){
				    	 checkItnrFlag = false;
				    	alert("You have changed your request type. Please verify/change your itinerary as per request type.");
				    }
			        
				}
				
				domClickedFlag = true;
				intClickedFlag = false;     
				
				$("#forexLabel_Dom").css("display","block");
				$("#forexLabel_Int").css("display","none");
				
				window.parent.top11.document.location.href = "topMenuBuildUp.jsp?id=label.mainmenu.domestictravelrequest&travel_type=DOM";

	        	setTimeout(function(){
	        	    selectedMenu(); 
	        	},2000);
			});
			
			// international button click event 
			// [disable travel mode combo, change 'Add City +', 
			// 'Add Currency +' and 'Submit to Workflow' button color]	
			$('input#rd_Int').on('click',function() {
				if(!intClickedFlag) {
					
					$(this).attr('checked', true);
					$('input#rd_Dom').attr('checked', false);
					$(this).val("I");
					$("label.Int").removeClass("Disable");
					$("label.Dom").addClass("Disable");	
					
					setIntOnClickMode();			
				
					var depCityFlt 			= document.getElementsByName("depCityFlt");
			    	var arrCityFlt 			= document.getElementsByName("arrCityFlt");
			    	
			        for(var i = 0, len = depCityFlt.length; i < len; i++) {
					    if((depCityFlt[i].value != '' && depCityFlt[i].value != '<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') || (arrCityFlt[i].value != '' && arrCityFlt[i].value != '<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>')) {			
					    	  checkItnrFlag = true;
					    	  break;
					    }
					}
			        
				    if(checkItnrFlag){
				    	 checkItnrFlag = false;
				    	alert("You have changed your request type. Please verify/change your itinerary as per request type.");
				    }
				}
				
				intClickedFlag = true;
				domClickedFlag = false;     
				
				$("#forexLabel_Dom").css("display","none");
				$("#forexLabel_Int").css("display","block");
				
				window.parent.top11.document.location.href = "topMenuBuildUp.jsp?id=label.mainmenu.internationaltravelrequest&travel_type=INT";

	        	setTimeout(function(){
	        	    selectedMenu(); 
	        	},2000);
			});
			
		  if($('input#rd_Dom').is(':checked')) {
			  	setIsDomChecked();   
	        	domClickedFlag = true;
	        	intClickedFlag = false;
	        	
	        	window.parent.top11.document.location.href = "topMenuBuildUp.jsp?id=label.mainmenu.domestictravelrequest&travel_type=DOM";

	        	setTimeout(function(){
	        	    selectedMenu(); 
	        	},2000);
		  }	
	  
	}
}		
	//setApproverBlockHeight();
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

function uploadAttachment() {
	var travelIdVal = '<%=strTravelId%>';
	var travelTypeVal = $('input:radio[name=travelType]:checked').val();
	var attachmentUrl = "requisitionAttachment.jsp?purchaseReqID="+travelIdVal+"&err=0&travel_type="+travelTypeVal+"&whichPage=T_Group_QuickTravel_Detail_MATA.jsp&targetFrame=no";
	
	if(travelIdVal !=null && travelIdVal != "" && travelIdVal != "new") {
		var win = MM_openBrWindow(attachmentUrl,'Attachments','scrollbars=yes,resizable=yes,width=775,height=550');
	} else {
		alert("Please save the request before upload any supporting document(s).");
	}
}

// Populate Approver Level Combo
function populateApproverLevelData(siteId, userId, travelTypeRd) {
	var reqpage="quickTravelReqApprLvl";	
	if(siteId != null && siteId == "S") {
		siteId = '0';
	}
	var flagAppLvl1 = false;
	var flagAppLvl2 = false;
	var flagAppLvl3 = false;
	var flagBillSite = false;
	
	
  	var Params='<%="language1="+strsesLanguage+"&suserRole="+SuserRole%>';
    var urlParams=Params+"&reqpage="+reqpage+"&siteId="+siteId+"&userId="+userId+"&travelTypeRd="+travelTypeRd;
	$.ajax({
            type: "get",
            url: "QuickTravelRequestServlet",
            data: urlParams,
            dataType : 'json',
            success: function(result) {
			if(result!=null) {			
				
				$.each(result, function(key,value) {
					if(typeof(value['aprLvl1Html']) == 'undefined' || value['aprLvl1Html'] == null) {}
       			 	else { 
						var apprLvl1 = value['aprLvl1Html'];
						$("#firstapprover").html('');
						$("#firstapprover").get(0).options.add(new Option());
		             	$("#firstapprover").html(apprLvl1);
		             	flagAppLvl1 = true;
       			 	}
					if(typeof(value['aprLvl2Html']) == 'undefined' || value['aprLvl2Html'] == null) {}
       			 	else {
						var apprLvl2 = value['aprLvl2Html'];
						$("#secondapprover").html('');
						$("#secondapprover").get(0).options.add(new Option());
		             	$("#secondapprover").html(apprLvl2);
		             	flagAppLvl2 = true;
	   			 	}
					if(typeof(value['aprLvl3Html']) == 'undefined' || value['aprLvl3Html'] == null) {}
       			 	else {
					var apprLvl3 = value['aprLvl3Html'];					
						$("#thirdapprover").html('');
						if($('#thirdapprover').length) {
							$("#thirdapprover").get(0).options.add(new Option());
						}
						$("#thirdapprover").html(apprLvl3);
		             	flagAppLvl3 = true;
	   			 	}
					if(typeof(value['billSiteHtml']) == 'undefined' || value['billSiteHtml'] == null) {}
       			 	else {
					var billSite = value['billSiteHtml'];					
						$("#billingSMGSite").html('');
						$("#billingSMGSite").get(0).options.add(new Option());
		             	$("#billingSMGSite").html(billSite);
		             	flagBillSite = true;
	   			 	}
					
					if(flagAppLvl1 && flagAppLvl2 && flagAppLvl3 && flagBillSite){
						skipDisabled(frm,'abcd');
						$("select#billingSMGSite").change();
					}
					
				});				
			}				
        }
    });
}

function showDiff() {
	var YtmBud = $("#YtmBud").val();
	var YtmAct = $("#YtmAct").val();
	if(isNaN(parseFloat(YtmBud) - parseFloat(YtmAct)))
		$("#AvailBud").val('0.0');
	else
		$("#AvailBud").val(parseFloat(YtmBud) - parseFloat(YtmAct)); 
}

$("select#siteName").live("change", function() {
	var val = "";
	var siteId = $("select#siteName option:selected").val();
	
	if(siteId != null && siteId == "S") {
		siteId = '0';
	}
	
	
	if($('input#rd_Dom').is(':checked')) {
    	$('input#rd_Int').attr('checked', false);
    	$('input#rd_Dom').val("D");
    	val = $('input#rd_Dom:checked').val();      	
    } else if($('input#rd_Int').is(':checked')) {
    	$('input#rd_Dom').attr('checked', false);
    	$('input#rd_Int').val("I");
    	val = $('input#rd_Int:checked').val();    	    		
    }
	
	var userId = "-1";
	populateApproverLevelData(siteId, userId, val); 
	populateCancelledRequest(userId, val);
	defaultApproverList(siteId, userId, val); 
});

// Populate User for Billing Unit
$("select#billingSMGSite").live("change", function() {
	var siteIdBillSMGUser = $("select#billingSMGSite option:selected").val();
	var userId = '<%=Suser_id%>';
	
	var reqpage="quickTravelReqBillSMGUser";	  	
  	var Params='<%="language1="+strsesLanguage+"&suserRole="+SuserRole+"&suserId="+Suser_id+"&siteId="+strSiteId%>';
    var urlParams=Params+"&reqpage="+reqpage+"&siteIdBillSMGUser="+siteIdBillSMGUser+"&userId="+userId;
	$.ajax({
            type: "get",
            url: "QuickTravelRequestServlet",
            data: urlParams,
            dataType : 'json',
            success: function(result) {
	           	if(result!=null) {	
	           		$("#BillingSiteFlag").val();
					$("#billingSMGUser").html('');
					$("#billingSMGUser").get(0).options.add(new Option());
	             	$("#billingSMGUser").html(result.billUserHtml);
	             	$("#BillingSiteFlag").val(result.multiSiteAccessFlag);
				}				
        	}
      });
});

//Populate User for Car Category
$("select#carClassType").live("change", function() {
	var carClassTypeId = $(this).val();
	var travelTypeVal = "B";
	
	
	var reqpage="quickTravelReqCarClassCategory";	  	
    var urlParams="reqpage="+reqpage+"&carClassType="+carClassTypeId+"&travelTypeRd="+travelTypeVal;
	$.ajax({
            type: "get",
            url: "QuickTravelRequestServlet",
            data: urlParams,
            dataType : 'json',
            success: function(result) {
	           	if(result!=null) {	
					$("#carCategoryType").html('');
					$("#carCategoryType").get(0).options.add(new Option());
	             	$("#carCategoryType").html(result.carCategoryHtml);
				}				
        	}
      });
});

//Populate Cancelled Travel Request(s)
function populateCancelledRequest(userId, travelTypeRd) {
	
	var reqpage="quickTravelReqCancelledRequest";
	var groupReqFlag = "Y";
  	var Params='<%="language1="+strsesLanguage+"&suserRole="+SuserRole+"&suserId="+Suser_id%>';
    var urlParams=Params+"&reqpage="+reqpage+"&userId="+userId+"&travelTypeRd="+travelTypeRd+"&groupReqFlag="+groupReqFlag;
	$.ajax({
            type: "get",
            url: "QuickTravelRequestServlet",
            data: urlParams,
            dataType : 'json',
            success: function(result) {
	           	if(result!=null) {	
	           		$("input#showCancelledRegflag").val();
					$("select#cancelledTravelReq").html('');
					$("select#cancelledTravelReq").get(0).options.add(new Option());
	             	$("select#cancelledTravelReq").html(result.cancelledReqHtml);
	             	$("input#showCancelledRegflag").val(result.showCancelledRegflag);
	             	$("select#cancelledTravelReq").val('<%=strCancelledReqId%>');
	             	var cancelledRegflag = $("#showCancelledRegflag").val();
	    			if(cancelledRegflag === 'y'){
	    				$("td#cancelledTravelReqTd").removeClass("hide");
	    				$("td#cancelledTravelReqTd").addClass("show");
	    			} else {
	    				$("td#cancelledTravelReqTd").removeClass("show");
	    				$("td#cancelledTravelReqTd").addClass("hide");
	    			}
	    			
	    			
	    			$("select#cancelledTravelReq").change();
				}				
        	}
      });
}

$("select#cancelledTravelReq").live("change", function() {
	var cancelledReqId = $("select#cancelledTravelReq option:selected").val();
	var userId = '<%=Suser_id%>';
	
	if(cancelledReqId != "0") {
		$("table#canReqDetailTbl").remove();
		$('<table width="80px" border="0" align="left" cellspacing="0" cellpadding="0" id="canReqDetailTbl"><tr><td class="viewDetailLink"><a href="#" onClick="viewCancelledReqDetail('+cancelledReqId+', '+userId+')">View Detail</a></td></tr></table>').insertBefore('table#linkCanReqTbl');
	} else {
		$("table#canReqDetailTbl").remove();
	}
});

function viewCancelledReqDetail(cancelledReqId, userId) {
	if($('input#rd_Dom').is(':checked')) {
		MM_openBrWindow("T_TravelRequisitionDetails_D.jsp?purchaseRequisitionId="+cancelledReqId+"&traveller_Id="+userId+"&travelType=D","LinkedCancelledRequest", "scrollbars=yes,resizable=yes,width=975,height=550");
    } else if($('input#rd_Int').is(':checked')) {
    	MM_openBrWindow("T_TravelRequisitionDetails.jsp?purchaseRequisitionId="+cancelledReqId+"&traveller_Id="+userId+"&travelType=I","LinkedCancelledRequest", "scrollbars=yes,resizable=yes,width=975,height=550");
    }	
}

// Forex Detail Calculation Start
$("#bt_Add-Curr").live("click",function() {
	var master = $("table#tblForexDetail");
	//to set sno.
	var id = 1;
	 $('table#tblForexDetail tbody > tr').each(function() {		 
		 var a=$(this).find('#hd').val();
		  if(a=='v') {
			  id++;
		  }
	});
	//end here	
	
	// Get a new row based on the prototype row
	var prot = master.find(".prototypeRowForex").clone();
	prot.find("#hd").val('v');
	prot.attr("class", ""); 
	prot.addClass("forexDataRow");
	prot.find(".spn").text(id);
	$('.innerRowForex').before(prot);
});

// Remove button functionality
$("table#tblForexDetail #bt-Del-Curr").live("click", function() {
	var strRecVal = '<%=strRec%>';
	var rowCount = $("table#tblForexDetail tbody tr.forexDataRow").length;
	if(strRecVal !=null && strRecVal != "" && strRecVal != "no") {
		if(rowCount == 2) {
			var master = $(this).parents("table#tblForexDetail tbody#currencyTbltTbdy tr");
			master.find('#expCurrency').val('<%=strBaseCur%>');
			master.find('#entitlement1').val("0");
			master.find('#tourDays1').val("0");
			master.find('#entitlement2').val("0");
			master.find('#tourDays2').val("0");
			master.find('#contingencies1').val("0");
			master.find('#contingencies2').val("0");
			master.find('#totalforex').val("0.00");
			master.find('#totalinr').val("0.00");			
			master.find('#expCurrency').change();
			$(this).attr("disabled", "disabled");
			$("textarea#expRemarks").val("");
			$("textarea#cashBreakupRemarks").val("");
			//set placeholder on page load
			setPlaceholder();
		} else {
			$(this).parents("table#tblForexDetail tr").remove();
		}
	} else {
		$(this).parents("table#tblForexDetail tr").remove();
	}
	
	var id = 1;
	 $('table#tblForexDetail tbody > tr').each(function() {
		 var a=$(this).find('#hd').val();
		 if(a=='v') {
		  	$(this).find('.spn').text(id);
		  	id++;
		  	var total=fun_calculate_GrandTotal();
	      	$('#grandTotalForexinr').val(total);
	      	fun_calculate_GrandTotalUSD();
	  	}				  
	});
});	
	
function fun_check_duplicate_currency(checkbox_obj,sno_num) {
	cur_val=$(checkbox_obj).val();
	var var_flag=true;
	$('table#tblForexDetail tbody#currencyTbltTbdy > tr').each(function() {
		var hd_val=$(this).find('#hd').val();
		var sno_val=$(this).find('.spn').text();
		if(hd_val=='v') {
			var a=$(this).find('#expCurrency').val();
			if(cur_val!='-1' && cur_val==a && sno_val!=sno_num) {
				var msg='<%=dbLabelBean.getLabel("alert.createrequest.isalreadyused.",strsesLanguage)%>';
				alert(cur_val+' '+msg);
				$(checkbox_obj).val('-1');
				var_flag=false;
				return false;
			}
		}
	});
	return var_flag;
}
	
function fun_exchangerate(x) {	
	var master = $(x).parents("table#tblForexDetail tbody#currencyTbltTbdy tr");
	var sno_val=master.find('.spn').text();
	var res_cur=fun_check_duplicate_currency(x,sno_val);	
	if(res_cur==false) {
		return false;
	}
	calculate(x);
	var curPref = x.value;
	if(curPref!='-1') {
		var urlParams = "strFlag=curexchangerate&currency="+curPref+"&seldate=<%=formattedDate%>";
		jQuery.ajax({
	           type: "post",
	           url: "AjaxMaster.jsp",
	           data: urlParams,
	           async:false,
	           success: function(result) {
	           var res = $.trim(result);		           
	           if(res != '') {
	            if(res=='0.000000') {
		            res='';
		            alert('<%=dbLabelBean.getLabel("label.global.exchangeratefor",strsesLanguage)%> '+$.trim(curPref)+' <%=dbLabelBean.getLabel("label.createrequest.isnotdefinedcontactstarsadmin",strsesLanguage)%>');
	            }
	           	master.find('#exrate').val(res);
	           	var x=master.find('#totalforex').val();
	           	fun_calculate_TotalinBaseCurrency(master.find('#totalinr'),x,curPref,'<%=strBaseCur%>','<%=formattedDate%>');	
	           	var total=fun_calculate_GrandTotal();
	           	$('#grandTotalForexinr').val(total);
	           	fun_calculate_GrandTotalUSD();	            				             
	            } else {
	           	 alert('<%=dbLabelBean.getLabel("label.global.exchangeratefor",strsesLanguage)%> '+$.trim(curPref)+' <%=dbLabelBean.getLabel("label.createrequest.isnotdefinedcontactstarsadmin",strsesLanguage)%>');
	             }
	           },
			   error: function() {
				alert('Get Exchange Rate-->'+'<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
	           }
	     });
	} else {
		master.find('#totalforex').val('0');
		master.find('#exrate').val('0.000000');
		master.find('#totalinr').val('0.00');
		var total=fun_calculate_GrandTotal();
    	$('#grandTotalForexinr').val(total);
    	fun_calculate_GrandTotalUSD();	 	
	}
}

function fun_calculate_GrandTotal() {
	var sum=0;
	$('table#tblForexDetail tbody#currencyTbltTbdy > tr').each(function() {
		var a=$(this).find('#totalinr').val();
		if(a!=undefined && a!='') {
		sum=parseFloat(sum)+parseFloat(a);
		}	
	});
	return sum.toFixed(2);
}

function fun_calculate_HotelTourDays() {
	var sum=0;
	$('table#tblForexDetail tbody#currencyTbltTbdy > tr').each(function() {
		var hd_val=$(this).find('#hd').val();
		if(hd_val=='v') {
			var b=$(this).find('#entitlement2').val();	
			var a=$(this).find('#tourDays2').val();
			if(b!=undefined && b>0) {
				if(a!=undefined && a!='') {
				sum=parseFloat(sum)+parseFloat(a);
				}
			}	
		}
	});
	return sum;
}

function fun_calculate_DailyTourDays() {
	var sum=0;
	$('table#tblForexDetail tbody#currencyTbltTbdy > tr').each(function() {
		var hd_val=$(this).find('#hd').val();
		if(hd_val=='v') {
			var b=$(this).find('#entitlement1').val();
			var a=$(this).find('#tourDays1').val();
			if(b!=undefined && b>0) {
				if(a!=undefined && a!='') {
				sum=parseFloat(sum)+parseFloat(a);
				}
			}	
		}
	});
	return sum;
}

function fun_calculate_GrandTotalUSD() {
	var hoteltd=fun_calculate_HotelTourDays();
	var dailytd=fun_calculate_DailyTourDays();
	var grandtotal=$('#grandTotalForexinr').val();
	if(grandtotal=='') {
		grandtotal='0.00';
		$('#grandTotalForexinr').val('0.00');
	}
	var urlParams = "strFlag=GrandTotalinUSD&totalexp="+grandtotal+"&basecur=<%=strBaseCur%>&seldate=<%=formattedDate%>";
	jQuery.ajax({
           type: "post",
           url: "AjaxMaster.jsp",
           data: urlParams,
           async:false,
           success: function(result) {
	           var res = $.trim(result);
	           if(res != '') {
	              if(hoteltd!=undefined && hoteltd!=0) {
						$('#grandtotalforexusd').val((res/hoteltd).toFixed(2));
				  } else if(dailytd!=undefined && dailytd!=0) {
		           		$('#grandtotalforexusd').val((res/dailytd).toFixed(2));
				 } else {
						$('#grandtotalforexusd').val(res);
				 }					            				             
	           }
           },
		   error: function() {
			alert('Calculate Grand Total USD-->'+'<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
           }
     });
}

function check1() { 
	var total=fun_calculate_GrandTotal();
	$('#grandTotalForexinr').val(total);
	fun_calculate_GrandTotalUSD();
}

function calculate(obj) {
	var master = $(obj).parents("table#tblForexDetail tbody#currencyTbltTbdy tr");
	var cur=master.find('#expCurrency').val();
	var a=master.find('#entitlement1').val();
	var b=master.find('#tourDays1').val();
	var c=master.find('#entitlement2').val();
	var d=master.find('#tourDays2').val();
	var e=master.find('#contingencies1').val();
	var f=master.find('#contingencies2').val();
	var g=master.find('#totalforex');
	var x=master.find('#exrate').val();
	var y=master.find('#totalinr');
	if(a=='')
		a=0;
	if(b=='')
		b=0;
	if(c=='')
		c=0;
	if(d=='')
		d=0;
	if(e=='')
		e=0;
	if(f=='')
		f=0;
	if(g=='')
		g=0;
	if(x=='')
		x=0;
	if(y=='')
		y=0;

	var totalforexval=fun_multiply(a,b)+fun_multiply(c,d)+parseFloat(e)+parseFloat(f);
	g.val(totalforexval.toFixed(2));
	if(cur!=null && cur!=undefined && cur!='-1') {
	fun_calculate_TotalinBaseCurrency(y,totalforexval,cur,'<%=strBaseCur%>','<%=formattedDate%>');
	}
}

function fun_multiply(a,b) {
	return parseFloat(a)*parseFloat(b);
}

function fun_calculate_TotalinBaseCurrency(obj,totalforex,cur_val,basecur_val,date_val) {
	
	var urlParams = "strFlag=TotalinBaseCur&totalexp="+totalforex+"&selcurrency="+cur_val+"&basecur="+basecur_val+"&seldate="+date_val;
	jQuery.ajax({
            type: "post",
            url: "AjaxMaster.jsp",
            data: urlParams,
            async:false,
            success: function(result) {
	            var res = $.trim(result);
	            if(res != '') {
	            	obj.val(res);	            				             
	             }
            },
			error: function() {
				alert('Calculate Total in Base Currency-->'+'<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
            }
      });
}

function test1(obj, length, str) {
	if(str=='n.') {
		upToTwoDecimal(obj);
	}
	
	charactercheck(obj,str);
	limitlength(obj, length);
	spaceChecking(obj);//added on for checking  starting Spaces on 05-Jul-07
	calculate(obj);
	var total=fun_calculate_GrandTotal();
	$('#grandTotalForexinr').val(total);
	fun_calculate_GrandTotalUSD();
}
// Forex Detail Calculation End

//function for showing the default approver list
function defaultApproverList(siteId, userId, val) {
	if(siteId != null && siteId == "S") {
		siteId = "0";
	}
	if(val === "D") {
    	trvTypeVal = "DOM";      	
	} else if(val === "I") {
    	trvTypeVal = "INT";    	    		
	}	
	var url = 'T_DefaultApproverListNew.jsp?traveltype='+trvTypeVal+'&siteId='+siteId+'&traveller='+userId;	
	$("#defaultApproverDiv").load(url, function() {		
		var rowCount = 0;
		var exchRateExistsFlag = '<%=exchRateExistsFlag%>';
		
		rowCount = $("div#defaultApproverDiv").find('table#defaultApprListTbl tr td table.formborder tr').length;
		
		if(rowCount > 2 && exchRateExistsFlag == 'false') {
			document.getElementById("bt-SaveExit").disabled=true;
			document.getElementById("bt-Save").disabled=true;
			document.getElementById("bt-SubmitToWorkflow").disabled=true;
			alert('<%=dbLabelBean.getLabel("alert.global.exchangeratesnotdefined",strsesLanguage)%>');
			
		} else if(rowCount > 2) {			
			if(grpTrvExists != null && grpTrvExists === "true") {
				document.getElementById("bt-SaveExit").disabled=false;
				document.getElementById("bt-Save").disabled=false;
				document.getElementById("bt-SubmitToWorkflow").disabled=false;
			} else {
				document.getElementById("bt-SaveExit").disabled=true;
				document.getElementById("bt-Save").disabled=true;
				document.getElementById("bt-SubmitToWorkflow").disabled=true;	
			}
			
		} else {
			document.getElementById("bt-SaveExit").disabled=true;
			document.getElementById("bt-Save").disabled=true;
			document.getElementById("bt-SubmitToWorkflow").disabled=true;
		}
	});
}

function skipDisabled(f2,flag) 	{
	var trvTypeVal = "";
	var siteid= $("select#siteName option:selected").val();
 	
	if(siteid != null && siteid == "S") {
		siteid = "0";
	}
	
	if($('input#rd_Dom').is(':checked')) {
    	$('input#rd_Int').attr('checked', false);
    	$('input#rd_Dom').val("D");
    	trvTypeVal = $('input#rd_Dom:checked').val();      	
	} else if($('input#rd_Int').is(':checked')) {
    	$('input#rd_Dom').attr('checked', false);
    	$('input#rd_Int').val("I");
    	trvTypeVal = $('input#rd_Int:checked').val();    	    		
	}
	

	if(flag=='first') {
		//$.noConflict();
		jQuery(document).ready(function($) {					
					var managerId = $("#firstapprover option:selected").val();					
					var urlParams2 = '<%="&sp_role="+SSstrSplRole+"&reqpage=approver1"%>';
					var urlParams = "managerId="+managerId+"&SITE_ID="+siteid+"&traveltype="+trvTypeVal+urlParams2;
					//alert(urlParams);
					$.ajax({
			            type: "post",
			            url: "AjaxMaster.jsp",
			            data: urlParams,
			            success: function(result){
			            	 //$("#delName").html(result);
			            	var res = result.trim();
			                if(res == 'y'){
			                		alert('<%=dbLabelBean.getLabel("alert.global.approverindefaultworkflow",strsesLanguage)%>');
			                		
			                }		            	 
			            },
						error: function(){
							alert('Disabled Reason For Skip[1]-->'+'<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
			            }
			   });		
		});
	}//end if

	String.prototype.trim = function() {
		return this.replace(/^\s+|\s+$/g,"");
	}	
		
	if(flag=='second') {
		//$.noConflict();
		jQuery(document).ready(function($) {				
				var managerId = $("#secondapprover option:selected").val();					
				var urlParams2 = '<%="&sp_role="+SSstrSplRole+"&reqpage=approver2"%>';
				var urlParams = "managerId="+managerId+"&SITE_ID="+siteid+"&traveltype="+trvTypeVal+urlParams2;
				//alert(urlParams);
				$.ajax({
		            type: "post",
		            url: "AjaxMaster.jsp",
		            data: urlParams,
		            success: function(result) {
		            	 //$("#delName").html(result);
		            	var res = result.trim();
		                if(res == 'y') {
		                		alert('<%=dbLabelBean.getLabel("alert.global.approverindefaultworkflow",strsesLanguage)%>');
		                		
		                }		            	 
		            },
					error: function(){
						alert('Disabled Reason For Skip[2]-->'+'<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
		            }
		          });
			});
	}//end if
	
	var manager = $("select#firstapprover").val();
	var hod = $("select#secondapprover").val();	
	if((manager != 'S' && manager != '') && (hod != 'S' && hod != '')) {		
		$("textarea#reasonForSkip").prop('disabled', true);
		$("textarea#reasonForSkip").val("");
	} else if((manager == 'S' || manager == '') && (hod == 'S' || hod == '')) {
		$("textarea#reasonForSkip").prop('disabled', false);
	} else if((manager != 'S' || manager != '') && (hod == 'S' || hod == '')) 	{
		$("textarea#reasonForSkip").prop('disabled', false);
	} else if((manager == 'S' || manager == '') && (hod != 'S' || hod != '')) 	{
		$("textarea#reasonForSkip").prop('disabled', false);
	}
	
	//set placeholder on page load
	setPlaceholder();
}

function deleteTravelDetails(travelMode) {
	var suserId = '<%=Suser_id%>';
	var travelId = '<%=strTravelId%>';
	var travelType = '<%=strTravelType%>';	
	var actionBtn="fltTrnNoBtn";	  	
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
	var actionBtn="carNoBtn";	  	
 	var urlParams="actionBtn="+actionBtn+"&suserId="+suserId+"&travelId="+travelId+"&travelType="+travelType+"&travelCarIdArr="+travelCarIdValues;
 	deleteDetails(urlParams);
}

function deleteCarDetailsById(travelCarId) {
	var suserId = '<%=Suser_id%>';
	var travelId = '<%=strTravelId%>';
	var travelType = '<%=strTravelType%>';	
	var actionBtn="carDelBtn";	  	
 	var urlParams="actionBtn="+actionBtn+"&suserId="+suserId+"&travelId="+travelId+"&travelType="+travelType+"&travelCarId="+travelCarId;
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
	var actionBtn="accomNoBtn";	  	
 	var urlParams="actionBtn="+actionBtn+"&suserId="+suserId+"&travelId="+travelId+"&travelType="+travelType+"&travelReqId="+travelReqId+"&accomIdArr="+accomIdValues;
 	deleteDetails(urlParams);
}

function deleteAccomDetailsById(accomId, rowCountAccom) {
	var suserId = '<%=Suser_id%>';
	var travelId = '<%=strTravelId%>';
	var travelReqId = '<%=strTravelReqId%>';
	var travelType = '<%=strTravelType%>';	
	var actionBtn="accomDelBtn";	  	
 	var  urlParams="actionBtn="+actionBtn+"&suserId="+suserId+"&travelId="+travelId+"&travelType="+travelType+"&travelReqId="+travelReqId+"&accomId="+accomId+"&rowCountAccom="+rowCountAccom;
 	deleteDetails(urlParams);
}


function deleteDetails(urlParams) {
	$.ajax({
        type: "get",
        url: "QuickTravelRequisitionDeleteIndiaServlet",
        data: urlParams,
        dataType : 'json',
        success: function(result) {
        	if(result!=null) {					
				
			}				
    	}
   });
}

// check TES Request Count
function checkTESRequestCount() {
	var var_travellerid = '<%=Suser_id%>';
	var var_siteid = $("select#siteName option:selected").val();
	var flag;
	var url = 'strFlag=checkTESRequestCount&travellerId='+var_travellerid+'&siteId='+var_siteid;
	$.ajax({
        type: "post",
        url: "AjaxMaster.jsp",
        data: url,
        async:false,
        success: function(result) {
        var res = $.trim(result);
        var narr=res.split("#");
        var diff = narr[2]-narr[1];
        if(narr[0] == 'Y') {
        	if(parseInt(narr[1]) != 0 && parseInt(narr[1]) < parseInt(narr[2])) {
          	  	 alert('<%=dbLabelBean.getLabel("alert.createrequest.pleasesubmityourlast",strsesLanguage)%> '+narr[1]+' <%=dbLabelBean.getLabel("alert.createrequest.pendingtravelexpensestmt",strsesLanguage)%> '+diff+' <%=dbLabelBean.getLabel("alert.createrequest.moretravelrequest",strsesLanguage)%>');
          	  	 flag=true;
	       	 } else {
	       		 flag=true;
	       	 }
         } else if(narr[0] == 'N') {
         	if(parseInt(narr[1]) >= parseInt(narr[2]) && parseInt(narr[2]) != 0) {
         		alert('<%=dbLabelBean.getLabel("alert.createrequest.pleasesubmityourlast",strsesLanguage)%> '+narr[1]+' <%=dbLabelBean.getLabel("alert.createrequest.pendingtravelexpenses",strsesLanguage)%>');
         	  	flag=false;
	       	 } else {
	       		 flag=true;
	       	 }
         } else if(narr[0] == 'A') {
             flag=true;
         } else {
        	 flag=true;
          }
         },
		error: function() {
			alert('Error in Check TES Request Count');
        }
      });
    return flag;
}

function checkValue() {	
	var contingenciesLabel = '<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%> / <%=dbLabelBean.getLabel("alert.global.reasonforcontigencies",strsesLanguage)%>';	
	var flag=true;
	var count=0;
    $('table#tblForexDetail tbody#currencyTbltTbdy> tr').each(function() {
       var hd_val=$(this).find('#hd').val();
	   if(hd_val=='v') {
	        var cur=$(this).find("#expCurrency");
		    var a=$(this).find("#entitlement1");
			var b=$(this).find('#tourDays1');
			var c=$(this).find('#entitlement2');
			var d=$(this).find('#tourDays2');
			var e=$(this).find('#contingencies1');
			var f=$(this).find('#contingencies2');			
			var x=$(this).find('#exrate');
			var expRemarks = $(this).find('#expRemarks');
			var cashBreakupRemarks = $(this).find('#cashBreakupRemarks');
			
			var cont1=$.trim(e.val());
			var cont2=$.trim(f.val());
			
				if(cont1=='0.00') {
					cont1='0';
				}
				if(cont2=='0.00') {
					cont2='0';
				}
	
				if(cur.val()!=undefined && cur.val()=='-1') {
					alert('<%=dbLabelBean.getLabel("alert.global.currency",strsesLanguage)%>');
					cur.focus();
					flag=false;
					return false;
				}
				if(a.val()!= undefined && $.trim(a.val())=='') {
					alert('<%=dbLabelBean.getLabel("alert.global.enter0ifnotrequiredinexpenditureperday",strsesLanguage)%>');
					a.focus();
					flag=false; 
					return false;
				}
				if(b.val()!= undefined && $.trim(b.val())=='') {
					alert('<%=dbLabelBean.getLabel("alert.global.enter0ifnotrequiredintotaltourdays",strsesLanguage)%>');
					b.focus();
					flag=false;
					return false;
				}
				if(c.val()!= undefined && $.trim(c.val())=='') {
					alert('<%=dbLabelBean.getLabel("alert.global.enter0ifnotrequiredinexpenditureperday",strsesLanguage)%>');
					c.focus();
					flag=false;
					return false;
				}
				if(d.val()!= undefined && $.trim(d.val())=='') {
					alert('<%=dbLabelBean.getLabel("alert.global.enter0ifnotrequiredintotaltourdays",strsesLanguage)%>');
					d.focus();
					flag=false;
					return false;
				}
				if(e.val()!= undefined && cont1!='' && cont1!='0') {
					if($("textarea#expRemarks").val()==contingenciesLabel || $("textarea#expRemarks").val()=='') {
						alert('<%=dbLabelBean.getLabel("alert.global.remarksforcontingenciesorotherexpenditure",strsesLanguage)%>');
						$("textarea#expRemarks").focus();
						flag=false;
						return false;
					}
				} 				
				if(f.val()!= undefined && cont2!='' && cont2!='0') {
					if($("textarea#expRemarks").val()==contingenciesLabel || $("textarea#expRemarks").val()=='') {
						alert('<%=dbLabelBean.getLabel("alert.global.remarksforcontingenciesorotherexpenditure",strsesLanguage)%>');
						$("textarea#expRemarks").focus();
						flag=false;
						return false;
					}
				} 				
				if(x.val()!=undefined && $.trim(x.val())=='') {
					alert('<%=dbLabelBean.getLabel("alert.createrequest.exchangeratecannotbeblank",strsesLanguage)%>');
					flag=false;
					return false;
				}				
				if(e.val()!= undefined && (cont1=='' || cont1=='0') && f.val()!= undefined && (cont2=='' || cont2=='0')) {
					if($("textarea#expRemarks").val()==contingenciesLabel) {
						$("textarea#expRemarks").val('');
					}
				}				
    		}
			count++;
		});
	return flag;
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

function validateFltTime () {
	var rowCountFlt 		= $("table#tblItineraryFlight tbody tr.itineraryDataRowFlight").length;
	var depDateFlt 			= document.getElementsByName("depDateFlt");
	var prefTimeFlt			= document.getElementsByName("preferTimeFlt");
	
	var prefTimeFltTxtArr 	= [];
	$('[name="preferTimeFlt"] :selected').each(function() {
		var st = $(this).text();
		prefTimeFltTxtArr.push(st);
	});
	
	for (var i=0; i<rowCountFlt-1; i++) {
		if (depDateFlt[i].value == depDateFlt[i+1].value) {
			
			var hr1  = prefTimeFltTxtArr[i].split(':')[0];
			var min1 = prefTimeFltTxtArr[i].split(':')[1];
			if (hr1 == '00'){
				hr1 = '24';
			}
			var time1 = hr1 + min1;
			if (time1.substring(0,1) == '0') {
				time1 = time1.substring(1,time1.length);
			}
			time1 = parseInt(time1);
			
			var hr2  = prefTimeFltTxtArr[i+1].split(':')[0];
			var min2 = prefTimeFltTxtArr[i+1].split(':')[1];
			if (hr2 == '00'){
				hr2 = '24';
			}
			var time2 = hr2 + min2;
			if (time2.substring(0,1) == '0') {
				time2 = time2.substring(1,time2.length);
			}
			time2 = parseInt(time2);
			
			if (time1 > time2) {
				alert("Flight time should be greater than that of previous journey, as their departure dates are same.");
				prefTimeFlt[i+1].focus();
				return false;
			}
		}
	}
	return true;
}

function validateTrnTime () {
	var rowCountTrn 		= $("table#tblItineraryTrain tbody tr.itineraryDataRowTrain").length;
	var depDateTrn 			= document.getElementsByName("depDateTrn");
	var prefTimeTrn			= document.getElementsByName("preferTimeTrn");
	
	var prefTimeTrnTxtArr 	= [];
	$('[name="preferTimeTrn"] :selected').each(function() {
		var st = $(this).text();
		prefTimeTrnTxtArr.push(st);
	});
	
	for (var i=0; i<rowCountTrn-1; i++) {
		if (depDateTrn[i].value == depDateTrn[i+1].value) {
			
			var hr1  = prefTimeTrnTxtArr[i].split(':')[0];
			var min1 = prefTimeTrnTxtArr[i].split(':')[1];
			if (hr1 == '00'){
				hr1 = '24';
			}
			var time1 = hr1 + min1;
			if (time1.substring(0,1) == '0') {
				time1 = time1.substring(1,time1.length);
			}
			time1 = parseInt(time1);
			
			var hr2  = prefTimeTrnTxtArr[i+1].split(':')[0];
			var min2 = prefTimeTrnTxtArr[i+1].split(':')[1];
			if (hr2 == '00'){
				hr2 = '24';
			}
			var time2 = hr2 + min2;
			if (time2.substring(0,1) == '0') {
				time2 = time2.substring(1,time2.length);
			}
			time2 = parseInt(time2);
			
			if (time1 > time2) {
				alert("Train time should be greater than that of previous journey, as their departure dates are same.");
				prefTimeTrn[i+1].focus();
				return false;
			}
		}
	}
	return true;
}

function validateCarTime () {
	var rowCountCar 		= $("table#tblItineraryCar tbody tr.itineraryDataRowCar").length;
	var depDateCar 			= document.getElementsByName("depDateCar");
	var prefTimeCar			= document.getElementsByName("preferTimeCar");
	
	var prefTimeCarTxtArr 	=[];
	$('[name="preferTimeCar"] :selected').each(function() {
		var st = $(this).text();
		prefTimeCarTxtArr.push(st);
	});
	
	for (var i=0; i<rowCountCar-1; i++) {
		if (depDateCar[i].value == depDateCar[i+1].value) {
			
			var hr1  = prefTimeCarTxtArr[i].split(':')[0];
			var min1 = prefTimeCarTxtArr[i].split(':')[1];
			if (hr1 == '00'){
				hr1 = '24';
			}
			var time1 = hr1 + min1;
			if (time1.substring(0,1) == '0') {
				time1 = time1.substring(1,time1.length);
			}
			time1 = parseInt(time1);
			
			var hr2  = prefTimeCarTxtArr[i+1].split(':')[0];
			var min2 = prefTimeCarTxtArr[i+1].split(':')[1];
			if (hr2 == '00'){
				hr2 = '24';
			}
			var time2 = hr2 + min2;
			if (time2.substring(0,1) == '0') {
				time2 = time2.substring(1,time2.length);
			}
			time2 = parseInt(time2);
			
			if (time1 > time2) {
				alert("Car time should be greater than that of previous journey, as their departure dates are same.");
				prefTimeCar[i+1].focus();
				return false;
			}
		}
	}
	return true;
}

function checkData(f1, actionFlag)  { 
	f1.whatAction.value=actionFlag;	
	var todayDate  			=  f1.todayDate.value; 
	var rowCountFlt 		= $("table#tblItineraryFlight tbody tr.itineraryDataRowFlight").length;
	var rowCountTrn 		= $("table#tblItineraryTrain tbody tr.itineraryDataRowTrain").length;
	var rowCountCar 		= $("table#tblItineraryCar tbody tr.itineraryDataRowCar").length;
	var rowCountAcm 		= $("table#tblAccomodation tbody tr.accomodationDataRow").length;
	
	var depCityFlt 			= document.getElementsByName("depCityFlt");
	var arrCityFlt 			= document.getElementsByName("arrCityFlt");
	var depDateFlt 			= document.getElementsByName("depDateFlt");
	var prefTimeFlt			= document.getElementsByName("preferTimeFlt");
	var nameOfAirlineFlt 	= document.getElementsByName("nameOfAirlineFlt");
	
	var depCityTrn 			= document.getElementsByName("depCityTrn");
	var arrCityTrn 			= document.getElementsByName("arrCityTrn");
	var depDateTrn 			= document.getElementsByName("depDateTrn");
	var prefTimeTrn			= document.getElementsByName("preferTimeTrn");
	var nameOfAirlineTrn 	= document.getElementsByName("nameOfAirlineTrn");
	
	var depCityCar 			= document.getElementsByName("depCityCar");
	var arrCityCar 			= document.getElementsByName("arrCityCar");
	var depDateCar 			= document.getElementsByName("depDateCar");
	var prefTimeCar			= document.getElementsByName("preferTimeCar");
	var mobileNumberCar 	= document.getElementsByName("mobileNumberCar");
	
	var hotel 				= document.getElementsByName("hotel");
	var currency 			= document.getElementsByName("currency");
	var budget 				= document.getElementsByName("budget");	
	var checkinDate 		= document.getElementsByName("checkin");
	var checkoutDate 		= document.getElementsByName("checkout");
	var place 				= document.getElementsByName("place");
	
	if(f1.site.value == 'S' || f1.site.value == '' || f1.site.value == '-1') {
	       alert('<%=dbLabelBean.getLabel("alert.global.unitname",strsesLanguage)%>');
		   f1.site.focus();
		   return false;  
	}
	
	var budValidations = '<%=strSHOW_BUD_INPUT%>';
	var budValidations1 = budValidations;
	var budValidations2 = "Y";
	var YtmBud 				= "";
	var YtmAct 				= "";
	var AvailBud 			= "";
	var EstExp 				= "";
	var budgetRemarks		= "";
	var YtmBudLabel 		= "";
	var YtmActLabel 		= "";
	var AvailBudLabel   	= "";
	var EstExpLabel 		= "";	
	var budgetRemarksLabel = "";	
 	if(budValidations1.toLowerCase() === budValidations2.toLowerCase()) { 	
	 	YtmBud = document.getElementById('YtmBud').value;
		YtmAct = document.getElementById('YtmAct').value;
		AvailBud = document.getElementById('AvailBud').value;
		EstExp = document.getElementById('EstExp').value;		
		budgetRemarks = document.getElementById('budgetRemarks').value;
		
		YtmBudLabel = '<%=dbLabelBean.getLabel("label.global.ytmbudget",strsesLanguage)%>';
		YtmActLabel = '<%=dbLabelBean.getLabel("label.global.ytdactual",strsesLanguage)%>';
		AvailBudLabel = '<%=dbLabelBean.getLabel("label.createrequest.availablebudget",strsesLanguage)%>';
		EstExpLabel = '<%=dbLabelBean.getLabel("label.global.estimatedexpenditure",strsesLanguage)%>';	
		budgetRemarksLabel = '<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>';		
 	}
	
	//At least one of the forward journey detail is required for travel request Start
	if($('input:radio#flightRequired_N').is(':checked') && $('input:radio#trainRequired_N').is(':checked') && $('input:radio#carRequired_N').is(':checked') && $('input:radio#accomodationRequired_N').is(':checked')) {
		if($('input#rd_Dom').is(':checked')) {
			alert ('<%=dbLabelBean.getLabel("alert.global.providedetailsfortravelrequestdomgroup",strsesLanguage)%>');
		} else if($('input#rd_Int').is(':checked')) {
			alert ('<%=dbLabelBean.getLabel("alert.global.providedetailsfortravelrequestintgroup",strsesLanguage)%>');
		}
		return false;
	}//At least one of the forward journey detail is required for travel request End
	
	if($('input:radio#flightRequired_Y').is(':checked')) {
		if(depCityFlt[0].value=='' || depCityFlt[0].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
			depCityFlt[0].focus();
			return false;
		}
		if(arrCityFlt[0].value=='' || arrCityFlt[0].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
			arrCityFlt[0].focus();
			return false;
		}
	    if(depDateFlt[0].value=='' || depDateFlt[0].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
			depDateFlt[0].focus();
			return false;
		}
	    if(prefTimeFlt[0].value=='-1' || prefTimeFlt[0].value=='') {
			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
			prefTimeFlt[0].focus();
			return false;
		}
	    if(nameOfAirlineFlt[0].value=='' || nameOfAirlineFlt[0].value=='<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>') {
			alert('<%=dbLabelBean.getLabel("alert.global.preferredairline",strsesLanguage)%>'); 
			nameOfAirlineFlt[0].focus();
			return false;
		}
	    if (isDate(depDateFlt[0].value)==false) {
	    	depDateFlt[0].focus();
			return false;
		}
	    flag = validateDate(f1,todayDate,depDateFlt[0].value,f1.todayDate,depDateFlt[0],'<%=dbLabelBean.getLabel("alert.global.departuredateoffwdjourneynotsmallerthantodaydate",strsesLanguage)%>','no');
	    if(flag == false) {
	    	depDateFlt[0].focus();
	    	return flag;
	    }
	}
	
	if($('input:radio#trainRequired_Y').is(':checked')) {
		if(depCityTrn[0].value=='' || depCityTrn[0].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
			depCityTrn[0].focus();
			return false;
		}
		if(arrCityTrn[0].value=='' || arrCityTrn[0].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
			arrCityTrn[0].focus();
			return false;
		}
	    if(depDateTrn[0].value=='' || depDateTrn[0].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
			depDateTrn[0].focus();
			return false;
		}
	    if(prefTimeTrn[0].value=='-1' || prefTimeTrn[0].value=='') {
			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>');
			prefTimeTrn[0].focus();
			return false;
		}
	    if(nameOfAirlineTrn[0].value=='' || nameOfAirlineTrn[0].value=='<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>') {
			alert('<%=dbLabelBean.getLabel("alert.global.preferredtrain",strsesLanguage)%>'); 
			nameOfAirlineTrn[0].focus();
			return false;
		}
	    if (isDate(depDateTrn[0].value)==false) {
	    	depDateTrn[0].focus();
			return false;
		}
	    flag = validateDate(f1,todayDate,depDateTrn[0].value,f1.todayDate,depDateTrn[0],'<%=dbLabelBean.getLabel("alert.global.departuredateoffwdjourneynotsmallerthantodaydate",strsesLanguage)%>','no');
	    if(flag == false) {
	    	depDateTrn[0].focus();
	    	return flag;
	    }
	}
	
	if($('input:radio#carRequired_Y').is(':checked')) {
		if(depCityCar[0].value=='' || depCityCar[0].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
			depCityCar[0].focus();
			return false;
		}
		if(arrCityCar[0].value=='' || arrCityCar[0].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
			arrCityCar[0].focus();
			return false;
		}
	    if(depDateCar[0].value=='' || depDateCar[0].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
			depDateCar[0].focus();
			return false;
		}
	    if(prefTimeCar[0].value=='-1' || prefTimeCar[0].value=='') {
			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
			prefTimeCar[0].focus();
			return false;
		}
	    if(mobileNumberCar[0].value=='' || mobileNumberCar[0].value=='<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>') {
			alert('<%=dbLabelBean.getLabel("alert.global.pleaseentermobilenoforrentacar",strsesLanguage)%>'); 
			mobileNumberCar[0].focus();
			return false;
		}
	    if (isDate(depDateCar[0].value)==false) {
	    	depDateCar[0].focus();
			return false;
		}
	    flag = validateDate(f1,todayDate,depDateCar[0].value,f1.todayDate,depDateCar[0],'<%=dbLabelBean.getLabel("alert.global.departuredateoffwdjourneynotsmallerthantodaydate",strsesLanguage)%>','no');
	    if(flag == false) {
	    	depDateCar[0].focus();
	    	return flag;
	    }
	}
	
	if($('input:radio#accomodationRequired_Y').is(':checked')) {
		if(hotel[0].value == "1" || hotel[0].value=="2") {	
			if(hotel[0].value == "1") {
				if(budget[0].value=="" || budget[0].value=="0" || budget[0].value=="<%=dbLabelBean.getLabel("label.global.budget",strsesLanguage)%>") {
				  alert('<%=dbLabelBean.getLabel("alert.global.budget",strsesLanguage)%>');
				  budget[0].focus();
				  return false;
				}
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
			if(place[0].value == "" || place[0].value == "<%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage)%>") {
				alert('<%=dbLabelBean.getLabel("alert.global.preferredplace",strsesLanguage)%>');
				place[0].focus();
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
			flag =  validateDate(f1,todayDate,checkinDate[0].value,f1.todayDate,checkinDate[0],'<%=dbLabelBean.getLabel("alert.global.checkindatecannotsmallerthantodaydate",strsesLanguage)%> ','no');
			if(flag == false) {
				checkinDate[0].focus();
			  	return flag; 
			}
		}
	}
	
	if(actionFlag == "saveProceed") {	
		//Check Flight Details Start
		if($('input:radio#flightRequired_Y').is(':checked')) {
			//Validate Travel Details for Flight Start 
	    	for (var i = 0, len = rowCountFlt-1; i < len; i++) {
	    		if(depCityFlt[i].value=='' || depCityFlt[i].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
	    			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
	    			depCityFlt[i].focus();
	    			return false;
	    		}
	    		if(arrCityFlt[i].value=='' || arrCityFlt[i].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
	    			arrCityFlt[i].focus();
	    			return false;
	    		}
	    	    if(depDateFlt[i].value=='' || depDateFlt[i].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
	    			depDateFlt[i].focus();
	    			return false;
	    		}
	    	    if(prefTimeFlt[i].value=='-1' || prefTimeFlt[i].value=='') {
	    			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
	    			prefTimeFlt[i].focus();
	    			return false;
	    		}
	    	    if(nameOfAirlineFlt[i].value=='' || nameOfAirlineFlt[i].value=='<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.preferredairline",strsesLanguage)%>'); 
	    			nameOfAirlineFlt[i].focus();
	    			return false;
	    		}
	    	    if (isDate(depDateFlt[i].value)==false) {
	    	    	depDateFlt[i].focus();
	    			return false;
	    		}
	    	    flag = validateDate(f1,todayDate,depDateFlt[i].value,f1.todayDate,depDateFlt[i],'<%=dbLabelBean.getLabel("alert.global.departuredateoffwdjourneynotsmallerthantodaydate",strsesLanguage)%>','no');
	    	    if(flag == false) {
	    	    	depDateFlt[i].focus();
	    	    	return flag;
	    	    }
	    	}
	    	
	    	if(depCityFlt[rowCountFlt-1].value!='' && depCityFlt[rowCountFlt-1].value!='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {
	    		if(arrCityFlt[rowCountFlt-1].value=='' || arrCityFlt[rowCountFlt-1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
	    			arrCityFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    	    if(depDateFlt[rowCountFlt-1].value=='' || depDateFlt[rowCountFlt-1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
	    			depDateFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    	    if(prefTimeFlt[rowCountFlt-1].value=='-1' || prefTimeFlt[rowCountFlt-1].value=='') {
	    			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
	    			prefTimeFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    	    if(nameOfAirlineFlt[rowCountFlt-1].value=='' || nameOfAirlineFlt[rowCountFlt-1].value=='<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.preferredairline",strsesLanguage)%>'); 
	    			nameOfAirlineFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    	    if (isDate(depDateFlt[rowCountFlt-1].value)==false) {
	    	    	depDateFlt[rowCountFlt-1].focus();
	    			return false;
	    		}	    
		    } else {
		    	depCityFlt[rowCountFlt-1].value='';
		    }
	    	
	    	if(arrCityFlt[rowCountFlt-1].value!='' && arrCityFlt[rowCountFlt-1].value!='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
	    		if(depCityFlt[rowCountFlt-1].value=='' || depCityFlt[rowCountFlt-1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
	    			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
	    			depCityFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    		if(depDateFlt[rowCountFlt-1].value=='' || depDateFlt[rowCountFlt-1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
	    			depDateFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    		if(prefTimeFlt[rowCountFlt-1].value=='-1' || prefTimeFlt[rowCountFlt-1].value=='') {
	    			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
	    			prefTimeFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    	    if(nameOfAirlineFlt[rowCountFlt-1].value=='' || nameOfAirlineFlt[rowCountFlt-1].value=='<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.preferredairline",strsesLanguage)%>'); 
	    			nameOfAirlineFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    	    if (isDate(depDateFlt[rowCountFlt-1].value)==false) {
	    	    	depDateFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    	} else {
	    		arrCityFlt[rowCountFlt-1].value='';
	    	}
	    	
	    	if(depDateFlt[rowCountFlt-1].value!='' && depDateFlt[rowCountFlt-1].value!='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
	    		if(depCityFlt[rowCountFlt-1].value=='' || depCityFlt[rowCountFlt-1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
	    			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
	    			depCityFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    		if(arrCityFlt[rowCountFlt-1].value=='' || arrCityFlt[rowCountFlt-1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
	    			arrCityFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    		if(prefTimeFlt[rowCountFlt-1].value=='-1' || prefTimeFlt[rowCountFlt-1].value=='') {
	    			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
	    			prefTimeFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    		if(nameOfAirlineFlt[rowCountFlt-1].value=='' || nameOfAirlineFlt[rowCountFlt-1].value=='<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.preferredairline",strsesLanguage)%>'); 
	    			nameOfAirlineFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    	    if (isDate(depDateFlt[rowCountFlt-1].value)==false) {
	    	    	depDateFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    	} else {
	    		depDateFlt[rowCountFlt-1].value='';
	    	}
	    	
	    	if(prefTimeFlt[rowCountFlt-1].value!='-1' && prefTimeFlt[rowCountFlt-1].value!='') {
	    		if(depCityFlt[rowCountFlt-1].value=='' || depCityFlt[rowCountFlt-1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
	    			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
	    			depCityFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    		if(arrCityFlt[rowCountFlt-1].value=='' || arrCityFlt[rowCountFlt-1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
	    			arrCityFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    		if(depDateFlt[rowCountFlt-1].value=='' || depDateFlt[rowCountFlt-1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
	    			depDateFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    		if(nameOfAirlineFlt[rowCountFlt-1].value=='' || nameOfAirlineFlt[rowCountFlt-1].value=='<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.preferredairline",strsesLanguage)%>'); 
	    			nameOfAirlineFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    	    if (isDate(depDateFlt[rowCountFlt-1].value)==false) {
	    	    	depDateFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    	} else {
	    		prefTimeFlt[rowCountFlt-1].value='-1';
	    	}
	    	
	    	if(nameOfAirlineFlt[rowCountFlt-1].value!='' && nameOfAirlineFlt[rowCountFlt-1].value!='<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>') {
	    		if(depCityFlt[rowCountFlt-1].value=='' || depCityFlt[rowCountFlt-1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
	    			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
	    			depCityFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    		if(arrCityFlt[rowCountFlt-1].value=='' || arrCityFlt[rowCountFlt-1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
	    			arrCityFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    		if(depDateFlt[rowCountFlt-1].value=='' || depDateFlt[rowCountFlt-1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
	    			depDateFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    		if(prefTimeFlt[rowCountFlt-1].value=='-1' || prefTimeFlt[rowCountFlt-1].value=='') {
	    			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
	    			prefTimeFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    		if (isDate(depDateFlt[rowCountFlt-1].value)==false) {
	    	    	depDateFlt[rowCountFlt-1].focus();
	    			return false;
	    		}
	    	} else {
	    		nameOfAirlineFlt[rowCountFlt-1].value='';
	    	}

	    	if(!validateFltTime()) {
	    		return false;
	    	}
		 	//Validate Travel Details for Flight End
		}
		//Check Flight Details End
		
		//Check Train Details Start
		if($('input:radio#trainRequired_Y').is(':checked')) {
			//Validate Travel Details for Train Start 
	    	for (var i = 0, len = rowCountTrn-1; i < len; i++) {
	    		if(depCityTrn[i].value=='' || depCityTrn[i].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
	    			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
	    			depCityTrn[i].focus();
	    			return false;
	    		}
	    		if(arrCityTrn[i].value=='' || arrCityTrn[i].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
	    			arrCityTrn[i].focus();
	    			return false;
	    		}
	    	    if(depDateTrn[i].value=='' || depDateTrn[i].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
	    			depDateTrn[i].focus();
	    			return false;
	    		}
	    	    if(prefTimeTrn[i].value=='-1' || prefTimeTrn[i].value=='') {
	    			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>');
	    			prefTimeTrn[i].focus();
	    			return false;
	    		}
	    	    if(nameOfAirlineTrn[i].value=='' || nameOfAirlineTrn[i].value=='<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.preferredtrain",strsesLanguage)%>'); 
	    			nameOfAirlineTrn[i].focus();
	    			return false;
	    		}
	    	    if (isDate(depDateTrn[i].value)==false) {
	    	    	depDateTrn[i].focus();
	    			return false;
	    		}
	    	    flag = validateDate(f1,todayDate,depDateTrn[i].value,f1.todayDate,depDateTrn[i],'<%=dbLabelBean.getLabel("alert.global.departuredateoffwdjourneynotsmallerthantodaydate",strsesLanguage)%>','no');
	    	    if(flag == false) {
	    	    	depDateTrn[i].focus();
	    	    	return flag;
	    	    }
	    	}
	    	
	    	if(depCityTrn[rowCountTrn-1].value!='' && depCityTrn[rowCountTrn-1].value!='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {
	    		if(arrCityTrn[rowCountTrn-1].value=='' || arrCityTrn[rowCountTrn-1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
	    			arrCityTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    	    if(depDateTrn[rowCountTrn-1].value=='' || depDateTrn[rowCountTrn-1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
	    			depDateTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    	    if(prefTimeTrn[rowCountTrn-1].value=='-1' || prefTimeTrn[rowCountTrn-1].value=='') {
	    			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>');
	    			prefTimeTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    	    if(nameOfAirlineTrn[rowCountTrn-1].value=='' || nameOfAirlineTrn[rowCountTrn-1].value=='<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.preferredtrain",strsesLanguage)%>'); 
	    			nameOfAirlineTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    	    if (isDate(depDateTrn[rowCountTrn-1].value)==false) {
	    	    	depDateTrn[rowCountTrn-1].focus();
	    			return false;
	    		}	    
		    } else {
		    	depCityTrn[rowCountTrn-1].value='';
		    }
	    	
	    	if(arrCityTrn[rowCountTrn-1].value!='' && arrCityTrn[rowCountTrn-1].value!='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
	    		if(depCityTrn[rowCountTrn-1].value=='' || depCityTrn[rowCountTrn-1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
	    			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
	    			depCityTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    		if(depDateTrn[rowCountTrn-1].value=='' || depDateTrn[rowCountTrn-1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
	    			depDateTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    		if(prefTimeTrn[rowCountTrn-1].value=='-1' || prefTimeTrn[rowCountTrn-1].value=='') {
	    			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>');
	    			prefTimeTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    	    if(nameOfAirlineTrn[rowCountTrn-1].value=='' || nameOfAirlineTrn[rowCountTrn-1].value=='<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.preferredtrain",strsesLanguage)%>'); 
	    			nameOfAirlineTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    	    if (isDate(depDateTrn[rowCountTrn-1].value)==false) {
	    	    	depDateTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    	} else {
	    		arrCityTrn[rowCountTrn-1].value='';
	    	}
	    	
	    	if(depDateTrn[rowCountTrn-1].value!='' && depDateTrn[rowCountTrn-1].value!='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
	    		if(depCityTrn[rowCountTrn-1].value=='' || depCityTrn[rowCountTrn-1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
	    			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
	    			depCityTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    		if(arrCityTrn[rowCountTrn-1].value=='' || arrCityTrn[rowCountTrn-1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
	    			arrCityTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    		if(prefTimeTrn[rowCountTrn-1].value=='-1' || prefTimeTrn[rowCountTrn-1].value=='') {
	    			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>');
	    			prefTimeTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    		if(nameOfAirlineTrn[rowCountTrn-1].value=='' || nameOfAirlineTrn[rowCountTrn-1].value=='<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.preferredtrain",strsesLanguage)%>'); 
	    			nameOfAirlineTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    	    if (isDate(depDateTrn[rowCountTrn-1].value)==false) {
	    	    	depDateTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    	} else {
	    		depDateTrn[rowCountTrn-1].value='';
	    	}
	    	
	    	if(prefTimeTrn[rowCountTrn-1].value!='-1' && prefTimeTrn[rowCountTrn-1].value!='') {
	    		if(depCityTrn[rowCountTrn-1].value=='' || depCityTrn[rowCountTrn-1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
	    			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
	    			depCityTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    		if(arrCityTrn[rowCountTrn-1].value=='' || arrCityTrn[rowCountTrn-1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
	    			arrCityTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    		if(depDateTrn[rowCountTrn-1].value=='' || depDateTrn[rowCountTrn-1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
	    			depDateTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    		if(nameOfAirlineTrn[rowCountTrn-1].value=='' || nameOfAirlineTrn[rowCountTrn-1].value=='<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.preferredtrain",strsesLanguage)%>'); 
	    			nameOfAirlineTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    	    if (isDate(depDateTrn[rowCountTrn-1].value)==false) {
	    	    	depDateTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    	} else {
	    		prefTimeTrn[rowCountTrn-1].value='-1';
	    	}
	    	
	    	if(nameOfAirlineTrn[rowCountTrn-1].value!='' && nameOfAirlineTrn[rowCountTrn-1].value!='<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>') {
	    		if(depCityTrn[rowCountTrn-1].value=='' || depCityTrn[rowCountTrn-1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
	    			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
	    			depCityTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    		if(arrCityTrn[rowCountTrn-1].value=='' || arrCityTrn[rowCountTrn-1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
	    			arrCityTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    		if(depDateTrn[rowCountTrn-1].value=='' || depDateTrn[rowCountTrn-1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
	    			depDateTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    		if(prefTimeTrn[rowCountTrn-1].value=='-1' || prefTimeTrn[rowCountTrn-1].value=='') {
	    			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>');
	    			prefTimeTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    		if (isDate(depDateTrn[rowCountTrn-1].value)==false) {
	    	    	depDateTrn[rowCountTrn-1].focus();
	    			return false;
	    		}
	    	} else {
	    		nameOfAirlineTrn[rowCountTrn-1].value='';
	    	}

	    	if(!validateTrnTime()) {
	    		return false;
	    	}
		 	//Validate Travel Details for Train End
		}
		//Check Train Details End
		
		//Check Car Details Start
		if($('input:radio#carRequired_Y').is(':checked')) {
			//Validate Travel Details for Car Start
			for (var i = 0, len = rowCountCar-1; i < len; i++) {
	    		if(depCityCar[i].value=='' || depCityCar[i].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
	    			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
	    			depCityCar[i].focus();
	    			return false;
	    		}
	    		if(arrCityCar[i].value=='' || arrCityCar[i].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
	    			arrCityCar[i].focus();
	    			return false;
	    		}
	    	    if(depDateCar[i].value=='' || depDateCar[i].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
	    			depDateCar[i].focus();
	    			return false;
	    		}
	    	    if(prefTimeCar[i].value=='-1' || prefTimeCar[i].value=='') {
	    			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
	    			prefTimeCar[i].focus();
	    			return false;
	    		}
	    	    if(mobileNumberCar[i].value=='' || mobileNumberCar[i].value=='<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.pleaseentermobilenoforrentacar",strsesLanguage)%>'); 
	    			mobileNumberCar[i].focus();
	    			return false;
	    		}
	    	    if (isDate(depDateCar[i].value)==false) {
	    	    	depDateCar[i].focus();
	    			return false;
	    		}
	    	    flag = validateDate(f1,todayDate,depDateCar[i].value,f1.todayDate,depDateCar[i],'<%=dbLabelBean.getLabel("alert.global.departuredateoffwdjourneynotsmallerthantodaydate",strsesLanguage)%>','no');
	    	    if(flag == false) {
	    	    	depDateCar[i].focus();
	    	    	return flag;
	    	    }
	    	}
	    	
	    	if(depCityCar[rowCountCar-1].value!='' && depCityCar[rowCountCar-1].value!='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {
	    		if(arrCityCar[rowCountCar-1].value=='' || arrCityCar[rowCountCar-1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
	    			arrCityCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    	    if(depDateCar[rowCountCar-1].value=='' || depDateCar[rowCountCar-1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
	    			depDateCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    	    if(prefTimeCar[rowCountCar-1].value=='-1' || prefTimeCar[rowCountCar-1].value=='') {
	    			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
	    			prefTimeCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    	    if(mobileNumberCar[rowCountCar-1].value=='' || mobileNumberCar[rowCountCar-1].value=='<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.pleaseentermobilenoforrentacar",strsesLanguage)%>'); 
	    			mobileNumberCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    	    if (isDate(depDateCar[rowCountCar-1].value)==false) {
	    	    	depDateCar[rowCountCar-1].focus();
	    			return false;
	    		}	    
		    } else {
		    	depCityCar[rowCountCar-1].value='';
		    }
	    	
	    	if(arrCityCar[rowCountCar-1].value!='' && arrCityCar[rowCountCar-1].value!='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
	    		if(depCityCar[rowCountCar-1].value=='' || depCityCar[rowCountCar-1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
	    			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
	    			depCityCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    		if(depDateCar[rowCountCar-1].value=='' || depDateCar[rowCountCar-1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
	    			depDateCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    		if(prefTimeCar[rowCountCar-1].value=='-1' || prefTimeCar[rowCountCar-1].value=='') {
	    			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
	    			prefTimeCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    		if(mobileNumberCar[rowCountCar-1].value=='' || mobileNumberCar[rowCountCar-1].value=='<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.pleaseentermobilenoforrentacar",strsesLanguage)%>'); 
	    			mobileNumberCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    	    if (isDate(depDateCar[rowCountCar-1].value)==false) {
	    	    	depDateCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    	} else {
	    		arrCityCar[rowCountCar-1].value='';
	    	}
	    	
	    	if(depDateCar[rowCountCar-1].value!='' && depDateCar[rowCountCar-1].value!='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
	    		if(depCityCar[rowCountCar-1].value=='' || depCityCar[rowCountCar-1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
	    			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
	    			depCityCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    		if(arrCityCar[rowCountCar-1].value=='' || arrCityCar[rowCountCar-1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
	    			arrCityCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    		if(prefTimeCar[rowCountCar-1].value=='-1' || prefTimeCar[rowCountCar-1].value=='') {
	    			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
	    			prefTimeCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    		if(mobileNumberCar[rowCountCar-1].value=='' || mobileNumberCar[rowCountCar-1].value=='<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.pleaseentermobilenoforrentacar",strsesLanguage)%>'); 
	    			mobileNumberCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    	    if (isDate(depDateCar[rowCountCar-1].value)==false) {
	    	    	depDateCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    	} else {
	    		depDateCar[rowCountCar-1].value='';
	    	}
	    	
	    	if(prefTimeCar[rowCountCar-1].value!='-1' && prefTimeCar[rowCountCar-1].value!='') {
	    		if(depCityCar[rowCountCar-1].value=='' || depCityCar[rowCountCar-1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
	    			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
	    			depCityCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    		if(arrCityCar[rowCountCar-1].value=='' || arrCityCar[rowCountCar-1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
	    			arrCityCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    		if(depDateCar[rowCountCar-1].value=='' || depDateCar[rowCountCar-1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
	    			depDateCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    		if(mobileNumberCar[rowCountCar-1].value=='' || mobileNumberCar[rowCountCar-1].value=='<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.pleaseentermobilenoforrentacar",strsesLanguage)%>'); 
	    			mobileNumberCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    	    if (isDate(depDateCar[rowCountCar-1].value)==false) {
	    	    	depDateCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    	} else {
	    		prefTimeCar[rowCountCar-1].value='-1';
	    	}
	    	
	    	if(mobileNumberCar[rowCountCar-1].value!='' && mobileNumberCar[rowCountCar-1].value!='<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>') {
	    		if(depCityCar[rowCountCar-1].value=='' || depCityCar[rowCountCar-1].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
	    			alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
	    			depCityCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    		if(arrCityCar[rowCountCar-1].value=='' || arrCityCar[rowCountCar-1].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
	    			arrCityCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    		if(prefTimeCar[rowCountCar-1].value=='-1' || prefTimeCar[rowCountCar-1].value=='') {
	    			alert('<%=dbLabelBean.getLabel("alert.createrequest.prefTimerequired",strsesLanguage)%>'); 
	    			prefTimeCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    		if(depDateCar[rowCountCar-1].value=='' || depDateCar[rowCountCar-1].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
	    			alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
	    			depDateCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    		if (isDate(depDateCar[rowCountCar-1].value)==false) {
	    	    	depDateCar[rowCountCar-1].focus();
	    			return false;
	    		}
	    	} else {
	    		mobileNumberCar[rowCountCar-1].value='';
	    	}

	    	if(!validateCarTime()) {
	    		return false;
	    	}
	    	//Validate Travel Details for Car End
		}
		//Check Car Details End
		
		//Check Accommodation Details Start
		if($('input:radio#accomodationRequired_Y').is(':checked')) {
			//Validate Accommodation Details Start
			for (var i = 0, len = rowCountAcm; i < len; i++) {	
				if(hotel[i].value == "1" || hotel[i].value=="2") {	
					if(hotel[i].value == "1") {
						if(budget[i].value=="" || budget[i].value=="0" || budget[i].value=="<%=dbLabelBean.getLabel("label.global.budget",strsesLanguage)%>") {
						  alert('<%=dbLabelBean.getLabel("alert.global.budget",strsesLanguage)%>');
						  budget[i].focus();
						  return false;
						}
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
					if(place[i].value == "" || place[i].value == "<%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage)%>") {
						alert('<%=dbLabelBean.getLabel("alert.global.preferredplace",strsesLanguage)%>');
						place[i].focus();
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
					flag =  validateDate(f1,todayDate,checkinDate[i].value,f1.todayDate,checkinDate[i],'<%=dbLabelBean.getLabel("alert.global.checkindatecannotsmallerthantodaydate",strsesLanguage)%> ','no');
					if(flag == false) {
						checkinDate[i].focus();
					  	return flag; 
					}
				}
			}
			//Validate Accommodation Details End
		}
		//Check Accommodation Details End
		
		//Check Reason for Travel Start
		if(f1.reasonForTravel.value == "" || f1.reasonForTravel.value == "<%=dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage)%>") {
			alert('<%=dbLabelBean.getLabel("alert.global.enterreasonfortravel",strsesLanguage)%>');
			f1.reasonForTravel.focus();
			return false;	
		}
		//Check Reason for Travel End
		
		//Check Billing Clint/Approver Details Start
		var siteIdVal = $("select#siteName option:selected").val();
		var multiSiteFlag = $("#BillingSiteFlag").val();
		if(f1.billingSMGSite.value == "-1") {
			alert('<%=dbLabelBean.getLabel("alert.global.pleaseselectbillingclient",strsesLanguage)%>');
		    f1.billingSMGSite.focus();
		    return false;
		} 	
		
		if(f1.billingSMGSite.value != siteIdVal) {
			if(f1.billingSMGUser.value == "-1" && multiSiteFlag !='1') {
				alert('<%=dbLabelBean.getLabel("alert.global.approverfrombillingunit",strsesLanguage)%>' );
				f1.billingSMGUser.focus();
				return false;
			}		
		}
		//Check Billing Clint/Approver Details End
		
		//Check Approver(s) Details Start
		var var_mand_flag = '<%=strMandatatoryApvFlag%>';
		if(var_mand_flag=='Y') {
			if(f1.manager.value=='S' || f1.hod.value=='S') {
				alert('<%=dbLabelBean.getLabel("alert.createrequest.bothapprovallevelismandatory",strsesLanguage)%>');
				if(f1.manager.value=='S')
					f1.manager.focus();
				else
					f1.hod.focus();
				return false;
			}	
		}  else {	
	 		var divflag='<%=strAppLvl3flg%>';
			var unitHeadFlag='<%=strUnit_Head%>';
			if(divflag=='Y' && unitHeadFlag!='1') {
				if(f1.manager.value=='S' && f1.hod.value=='S') {
					alert('<%=dbLabelBean.getLabel("alert.global.approvallevel1or2",strsesLanguage)%>');
					f1.manager.focus();
					return false;
				}
			}
			if($('input#rd_Dom').is(':checked')) {
				if(unitHeadFlag == '1' && f1.hod.value=='S' && divflag!='Y') {
				  	alert('<%=dbLabelBean.getLabel("alert.global.approvallevel2",strsesLanguage)%>');
				  	f1.hod.focus();
				  	return false;
				}
			}
			if((f1.manager.value == 'S' || f1.manager.value == '') && (f1.hod.value == 'S' || f1.hod.value == '')) {			
				if(f1.reasonForSkip.value == '' || f1.reasonForSkip.value == '<%=dbLabelBean.getLabel("label.global.reasonforskippingtheapprovers",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.reasonforskippingapprovallevel1or2",strsesLanguage)%>');
					f1.reasonForSkip.focus();
					return false;
				}
			} else if((f1.manager.value == 'S' || f1.manager.value == '') && (f1.hod.value != 'S' || f1.hod.value != '')) {			
				if(f1.reasonForSkip.value == '' || f1.reasonForSkip.value == '<%=dbLabelBean.getLabel("label.global.reasonforskippingtheapprovers",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.reasonforskippingapprovallevel1",strsesLanguage)%>');
					f1.reasonForSkip.focus();
					return false;
				}
			} else if((f1.manager.value != 'S' || f1.manager.value != '') && (f1.hod.value == 'S' || f1.hod.value == '')) {			
				if(f1.reasonForSkip.value == '' || f1.reasonForSkip.value == '<%=dbLabelBean.getLabel("label.global.reasonforskippingtheapprovers",strsesLanguage)%>') {
					alert('<%=dbLabelBean.getLabel("alert.global.reasonforskippingapprovallevel2",strsesLanguage)%>');
					f1.reasonForSkip.focus();
					return false;
				}
			}
		}
		
		var smpsitebmflag_val='<%=strAppLvl3flgforBM%>';
		if(smpsitebmflag_val=='y' && f1.boardmember!=undefined) {
			if((f1.boardmember.value!=null && (f1.boardmember.value=='B' || f1.boardmember.value==''))) {
				alert('<%=dbLabelBean.getLabel("alert.global.boardmember",strsesLanguage)%>');
				f1.boardmember.focus();
				return false;
			}
		}
		//Check Approver(s) Details End
		
		//Check Non-Mata Ticket Details Start
		var matapricecomp = "n";	
		if($('input#rd_Dom').is(':checked')) {
			matapricecomp = $("#matapricecompdom").val();
		} else if($('input#rd_Int').is(':checked')) { 
			matapricecomp = $("#matapricecompint").val();
		}
		
		var matapricecomp1 = matapricecomp;
		var matapricecomp2 = "y";
		
		if(matapricecomp1.toLowerCase() === matapricecomp2.toLowerCase()) {	
		    if(f1.tkflyes[0].checked) {	    	
			   	if(f1.pricingAirline.value=="" || f1.pricingAirline.value=="<%=dbLabelBean.getLabel("label.global.airline",strsesLanguage)%>") {
			   		alert('<%=dbLabelBean.getLabel("alert.global.airline",strsesLanguage)%>');
			   		
			   		setPlaceholder();
			   		f1.pricingAirline.focus();
			   		return false;
			   	}
			   	
			   	if(f1.pricingAirline.value!="") {
			   		if(f1.pricingCurrency.value=="-1") {
			   			alert('<%=dbLabelBean.getLabel("alert.global.currency",strsesLanguage)%>');
			   			
			   			setPlaceholder();
			   			f1.pricingCurrency.focus();
			   			return false;
			   		}
			   		if(f1.localprice.value=="" || f1.localprice.value=="<%=dbLabelBean.getLabel("label.global.localprice",strsesLanguage)%>") {
			   			alert('<%=dbLabelBean.getLabel("alert.global.localprice",strsesLanguage)%>'); 
			   			
			   			setPlaceholder();
			   			f1.localprice.focus(); 
			   			return false;
			   		}
			   		if(f1.pricingRemarks.value=="" || f1.pricingRemarks.value=="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>") {
			   			alert('<%=dbLabelBean.getLabel("alert.global.remarks",strsesLanguage)%>');
			   			
			   			setPlaceholder();
			   			f1.pricingRemarks.focus(); 
			   			return false;
			   		}
				}		
			}		   
		}
		//Check Non-Mata Ticket Details End
		
		//Check TES Request Count Start
		var var_res = checkTESRequestCount();
		if(var_res==false) {
			return false;
		}
		//Check TES Request Count End
		
		//Check Budget Actual Details Start
		if(budValidations1.toLowerCase() === budValidations2.toLowerCase()) {			
			if(YtmBud == '' || YtmBud == YtmBudLabel || YtmAct == '' || YtmAct == YtmActLabel || EstExp == '' || EstExp == EstExpLabel) {
				setPlaceholder();
				
				if((YtmBud == '' || YtmBud == YtmBudLabel) && (YtmAct == '' || YtmAct == YtmActLabel) && (EstExp == '' || EstExp == EstExpLabel) && (budgetRemarks == '' || budgetRemarks == budgetRemarksLabel)){
					alert('<%=dbLabelBean.getLabel("alert.global.enterremarksfornotenteringbudgetactualdetails",strsesLanguage)%>');
					document.getElementById('budgetRemarks').focus();
					return false;
				}
				else if(budgetRemarks == '' || budgetRemarks == budgetRemarksLabel) {
					if(YtmBud == '' || YtmBud == YtmBudLabel) {
						alert('<%=dbLabelBean.getLabel("alert.budget.pleaseenterytmbudgetdetails",strsesLanguage)%>');
						document.getElementById('YtmBud').focus();
						
					} else if(YtmAct == '' || YtmAct == YtmActLabel) {
						alert('<%=dbLabelBean.getLabel("alert.budget.pleaseenterytmactualdetails",strsesLanguage)%>');
						document.getElementById('YtmAct').focus();
						
					} else if(EstExp == '' || EstExp == EstExpLabel) {
						alert('<%=dbLabelBean.getLabel("alert.budget.pleaseenteractualdetails",strsesLanguage)%>');
						document.getElementById('EstExp').focus();
					}		
					return false;
				}
				
			}
			else {
				
				if(YtmBud == YtmBudLabel) {
					document.getElementById('YtmBud').value = "";
				} 
				
				if(YtmAct == YtmActLabel) {
					document.getElementById('YtmAct').value = "";
				} 
	
				if(AvailBud == AvailBudLabel) {
					document.getElementById('AvailBud').value = "";
				} 
				
				if(EstExp == EstExpLabel) {
					document.getElementById('EstExp').value = "";
				}	
				
				if(budgetRemarks == budgetRemarksLabel) {
					document.getElementById('budgetRemarks').value= "";
				}	
			}
		}	
		//Check Budget Actual Details End
		
		//Get Delegated his approval authority Approver(s) List Start
		var text=f1.approverlist.value;
		if(text!='') {
			text="Currently "+text;   
		}
		//Get Delegated his approval authority Approver(s) List End
		
		var confirmText = getReqSubmitMessage();
		
		if(confirm(text+confirmText)) {
			$('form#frmId').find('[placeholder]').each(function() {
				var input = $(this);
				if (input.val() == input.attr('placeholder')) {
					input.val('');
				}
			});
			
			f1.saveandexit.disabled=true;
			f1.save.disabled=true;
			f1.saveproceed.disabled=true;
			openWaitingProcess();
			$(window).scrollTop(0);
			f1.submit();	
			return true;	
								
		} else {
			setPlaceholder();
			
			f1.saveandexit.disabled=false;
			f1.save.disabled=false;
			f1.saveproceed.disabled=false;
			return false;
		}
	}
	
	$('form#frmId').find('[placeholder]').each(function() {
		var input = $(this);
		if (input.val() == input.attr('placeholder')) {
			input.val('');
		}
	});	
	
	f1.saveandexit.disabled=true;
	f1.save.disabled=true;
	f1.saveproceed.disabled=true;
	openWaitingProcess();
	$(window).scrollTop(0);
	f1.submit();	
	return true;
}

function getReqSubmitMessage() {
	var message 	= '<%=dbLabelBean.getLabel("alert.global.youwanttosubmit",strsesLanguage)%>';
	var dataFlag	= false;
	
	if($('input#rd_Int').is(':checked')) {
		message += ' INTERNATIONAL group travel request';
	} else {
		message += ' DOMESTIC group travel request';
	}
	
	if($('input:radio#flightRequired_Y').is(':checked')) {
		var depCityFlt 	= document.getElementsByName("depCityFlt");
		var arrCityFlt 	= document.getElementsByName("arrCityFlt");
		
		message 	+= ' for Sector : [ ' + depCityFlt[0].value + '-' + arrCityFlt[0].value + ' ]';
		dataFlag	= true;
		
		if(depCityFlt[1].value != '') {
			message 	+= '...';
		}
	}
	
	if($('input#rd_Dom').is(':checked') && !dataFlag) {
		if($('input:radio#trainRequired_Y').is(':checked') && !dataFlag) {
			var depCityTrn 	= document.getElementsByName("depCityTrn");
			var arrCityTrn 	= document.getElementsByName("arrCityTrn");
			
			message 	+= ' for Sector : [ ' + depCityTrn[0].value + '-' + arrCityTrn[0].value + ' ]';
			dataFlag	= true;
			
			if(depCityTrn[1].value != '') {
				message += '...';
			}
		}
		
		if($('input:radio#carRequired_Y').is(':checked') && !dataFlag) {
			var depCityCar 	= document.getElementsByName("depCityCar");
			var arrCityCar 	= document.getElementsByName("arrCityCar");
			
			message 	+= ' for Sector : [ ' + depCityCar[0].value + '-' + arrCityCar[0].value + ' ]';
			dataFlag	= true;
			
			if(depCityCar[1].value != '') {
				message += '...';
			}
		}
	}
	message += ' <%=dbLabelBean.getLabel("alert.global.toworkflow",strsesLanguage)%>';
	
	return message;
}

function checkGroupGuestData(f1, actionFlag) {
	var pasprtIssueDate = "";
	
	var todayDate  			= f1.todayDate.value;
	
	var rowCountFrx 		= $("table#tblForexDetail tbody tr.forexDataRow").length;
	if(actionFlag == 'updateTraveller'){
		rowCountFrx = rowCountFrx -1;	
	}
	
	var expCurrency 		= document.getElementsByName("expCurrency");
    var tourDays1 			= document.getElementsByName("tourDays");
	var tourDays2 			= document.getElementsByName("tourDays2");
	var entitlement1 		= document.getElementsByName("entitlement");
	var entitlement2 		= document.getElementsByName("entitlement2");	
	
	if(f1.site.value == 'S' || f1.site.value == '' || f1.site.value == '-1') {
	       alert('<%=dbLabelBean.getLabel("alert.global.unitname",strsesLanguage)%>');
		   f1.site.focus();
		   return false;  
	}
	
	var x='<%=strAppLvl3flg%>';
	var y='<%=strShowflag%>';
	if(x=='Y' && y=='y') {
		if(f1.costcentre.value=='0') {
			alert('<%=dbLabelBean.getLabel("alert.global.costcentre",strsesLanguage)%>');
			f1.costcentre.focus();
			return false;
		}
	}
	
	if(f1.firstName.value=='' || f1.firstName.value=='<%=dbLabelBean.getLabel("label.global.firstname",strsesLanguage)%>') {			
		alert('<%=dbLabelBean.getLabel("alert.global.firstname",strsesLanguage)%>');
		f1.firstName.focus();
		return false;
	}
	
	if(f1.designation.value == '-1') {
		alert('<%=dbLabelBean.getLabel("alert.global.designation",strsesLanguage)%>');
		f1.designation.focus();
		return false;
	}
	
	if(f1.dateOfBirth.value=='' || f1.dateOfBirth.value=='<%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%>') {			
		alert('<%=dbLabelBean.getLabel("alert.global.dob",strsesLanguage)%>');
		f1.dateOfBirth.focus();
		return false;
	}
	
	if(f1.age.value < 0 || f1.age.value == '' || f1.age.value == '<%=dbLabelBean.getLabel("label.global.age",strsesLanguage)%>') {
       alert('<%=dbLabelBean.getLabel("alert.global.correctdob",strsesLanguage)%>');
	   f1.age.value="";
	   return false;  
	}
	
	if(f1.gender.value == '-1') {
		alert('<%=dbLabelBean.getLabel("alert.global.gender",strsesLanguage)%>');
        f1.gender.focus();
		return false;
	}
	
	if(f1.mealPref.value == '0' || f1.mealPref.value == '' || f1.mealPref.value == '-1') {
	    alert('<%=dbLabelBean.getLabel("alert.createrequest.pleaseselectmealpreference",strsesLanguage)%>');
		f1.mealPref.focus();
		return false;  
	}
	
	if($('input#rd_Dom').is(':checked')) {
		if(f1.identityProof.value == '-1') {
	       alert('<%=dbLabelBean.getLabel("alert.global.identityname",strsesLanguage)%>');
		   f1.identityProof.focus();
		   return false;  
		}

		if(f1.identityProof.value != '-1')	{
			if(f1.identityProofno.value == '' || f1.identityProofno.value == '<%=dbLabelBean.getLabel("label.global.identitynumber",strsesLanguage)%>') {
				alert('<%=dbLabelBean.getLabel("alert.global.identitynumber",strsesLanguage)%>');
				f1.identityProofno.focus();
				return false;  
			}
        } 
		
		if(f1.emailId.value == '' || f1.emailId.value == '<%=dbLabelBean.getLabel("label.global.emailid",strsesLanguage)%>') {
		    alert('<%=dbLabelBean.getLabel("alert.mylinks.enteremail",strsesLanguage)%>.');
			f1.emailId.focus();
			return false;  
		}
		
		var flag = echeck(f1.emailId.value);
		if (flag == false)
		{
			f1.emailId.focus();
			return false;
		}
		
		if(f1.contactNo.value == '' || f1.contactNo.value == '<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%>') {
		    alert('<%=dbLabelBean.getLabel("alert.global.mobilenumber",strsesLanguage)%>');
		    f1.contactNo.focus();
			return false;  
		}
	}
	
	if($('input#rd_Int').is(':checked')) {
		if(f1.passportNo.value == '' || f1.passportNo.value == '<%=dbLabelBean.getLabel("label.global.passportnumber",strsesLanguage)%>') {
	       alert('<%=dbLabelBean.getLabel("alert.global.passportnumber",strsesLanguage)%>');
		   f1.passportNo.focus();
		   return false;  
		}
		
		if(f1.passportNationality.value=='' || f1.passportNationality.value=='<%=dbLabelBean.getLabel("label.user.nationality",strsesLanguage)%>') {			
			alert('<%=dbLabelBean.getLabel("alert.global.pleaseenternationality",strsesLanguage)%>');
			f1.passportNationality.focus();
			return false;
		}
		
		if(f1.passportIssuePlace.value=='' || f1.passportIssuePlace.value=='<%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%>') {			
			alert('<%=dbLabelBean.getLabel("alert.createrequest.enterplaceofissue",strsesLanguage)%>');
			f1.passportIssuePlace.focus();
			return false;
		}
		
		if(f1.passportIssueDate.value=='' || f1.passportIssueDate.value=='<%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%>') {			
			alert('<%=dbLabelBean.getLabel("alert.createrequest.enterdateofissue",strsesLanguage)%>');
			f1.passportIssueDate.focus();
			return false;
		}
		
		if(f1.passportExpiryDate.value=='' || f1.passportExpiryDate.value=='<%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage)%>') {			
			alert('<%=dbLabelBean.getLabel("alert.createrequest.enterdateofexpiry",strsesLanguage)%>');
			f1.passportExpiryDate.focus();
			return false;
		}	
		
		flag = checkDateOfIssue(f1, todayDate, f1.passportIssueDate.value);
	    if(flag == false) {
	    	f1.passportIssueDate.focus();
	    	return flag;
	    }
	    
	    flag = checkDateOfExpiry(f1, todayDate, f1.passportIssueDate.value, f1.passportExpiryDate.value);
	    if(flag == false) {
	    	f1.passportExpiryDate.focus();
	    	return flag;
	    }
	    
	    if(f1.emailIdInt.value == '' || f1.emailIdInt.value == '<%=dbLabelBean.getLabel("label.global.emailid",strsesLanguage)%>') {
		    alert('<%=dbLabelBean.getLabel("alert.mylinks.enteremail",strsesLanguage)%>.');
			f1.emailIdInt.focus();
			return false;  
		}
	    
	    var flag = echeck(f1.emailIdInt.value);
		if (flag == false)
		{
			f1.emailIdInt.focus();
			return false;
		}
	}
	
	if($('input#rd_Dom').is(':checked')) {
		pasprtIssueDate = "";
	} else if($('input#rd_Int').is(':checked')) {
		pasprtIssueDate = f1.passportIssueDate.value;
	}
	
    flag = checkTravellerDOB(f1, todayDate, f1.dateOfBirth.value, pasprtIssueDate);
    if(flag == false) {
    	f1.dateOfBirth.focus();
    	return flag;
    }
	
    
	//Check Advance/Forex Details Start
	for (var t = 0, tlen = rowCountFrx; t < tlen; t++) {
				
		if(expCurrency[t].value == "-1") {
			alert('<%=dbLabelBean.getLabel("alert.global.currency",strsesLanguage)%>');
			f1.expCurrency[t].focus();
			return false;	
		}
		
		if((entitlement1[t].value == "" || entitlement1[t].value == "0") && (entitlement2[t].value != "" && entitlement2[t].value != "0")) {
			alert('<%=dbLabelBean.getLabel("alert.global.expenditureperday",strsesLanguage)%>');
			f1.entitlement1[t].focus();
			return false;
		}		
		
		if((entitlement1[t].value != "" && entitlement1[t].value != "0") && (entitlement2[t].value == "" || entitlement2[t].value == "0")) {
			alert('<%=dbLabelBean.getLabel("alert.global.expenditureperday",strsesLanguage)%>');
			f1.entitlement2[t].focus();
			return false;
		}
		
		if(entitlement1[t].value != "0") {
			if(tourDays1[t].value == "" || tourDays1[t].value == "0") {
				alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterthetourdays",strsesLanguage)%>');
				f1.tourDays1[t].focus();
				return false;	
			}
		}
		
		if(entitlement2[t].value != "0") {
			if(tourDays2[t].value == "" || tourDays2[t].value == "0") {
				alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterthetourdays",strsesLanguage)%>');
				f1.tourDays2[t].focus();
				return false;	
			}
		}
		
		if(entitlement1[t].value != "0" || entitlement2[t].value != "0") {
			if(expCurrency[t].value == "-1") {
				alert('<%=dbLabelBean.getLabel("alert.global.currency",strsesLanguage)%>');
				f1.expCurrency[t].focus();
				return false;	
			}				
		}		
		
	}
	
	var fun_flag=checkValue();
	if(fun_flag==false) {
		return false;
	}
	
	var expenceCheck = $("#grandtotalforexusd").val();
	if(expenceCheck != undefined && expenceCheck == "") {
		alert('USD/Day can not be blank.');
		return false;
	} else if(expenceCheck != undefined && expenceCheck != "" && parseFloat(expenceCheck) > 350) {
		alert('Could not Add Traveller, As per corporate guidelines the per day amount should not be more than USD 350 (or equivalent amount in other currency). Kindly change the amount accordingly.');
		return false;
	}
	//Check Advance/Forex Details End
	
	$('form#frmId').find('[placeholder]').each(function() {
		var input = $(this);
		if (input.val() == input.attr('placeholder')) {
			input.val('');
		}
	});	
	
	f1.whatAction.value=actionFlag;	
	f1.submit();
	return true;
}

function addTravellerData(f1, actionFlag)  {
	checkGroupGuestData(f1, actionFlag);
}

function updateTravellerData(f1, actionFlag)  { 
	checkGroupGuestData(f1, actionFlag);
}

function deleteConfirm(){
	if(confirm('<%=dbLabelBean.getLabel("alert.global.deleterecord",strsesLanguage)%>'))
		return true;
	else
	   return false;
}

//initialize Guest name from database 
var fNameVal ="";
var fNameFlag = false;	
var selectedDesigId = $("select#designation option:selected").val();

function initializeGuestName(elId) {
		var timerGuestList;
		var typingTimerGuestList;              
	   	var getGuestListInterval = 200; 
	   	
	   	$(elId).keyup(function() { 
	   		if (timerGuestList) { 
	   			timerGuestList.abort();
	   		} 
	   	    clearTimeout(typingTimerGuestList);
	   	    if ($(elId).val()) {
	   	    	//console.log("hi"); 
	   	    	$(elId).removeAttr("placeholder");
	   	        typingTimerGuestList = setTimeout(function() {
	   	        	timerGuestList = getGuestList(elId);	
	   	        }, getGuestListInterval);
	   	    } else if(!$(elId).val()) {
	   	    	$(elId).val("");
	   	    	$(elId).attr("placeholder","<%=dbLabelBean.getLabel("label.global.firstname",strsesLanguage)%>");
	   	    	//console.log("helo"); 
	   	    }
	   	});	   	
}
	
	function getGuestList(elId) {
		var siteId = $("select#siteName option:selected").val();
		var cUserId = '<%=Suser_id%>';
		var travelType = "D";
		if($('input#rd_Dom').is(':checked')) {
			travelType = "D";
		} else if($('input#rd_Int').is(':checked')) { 
			travelType = "I";
		}
		
	   	$(elId).autocomplete({
	    	minLength: 3,
	   		delay: 500,
		source : function(request, response) {
			fName = "";            	
            $.ajax({
            	 type: "get",
				 url: "AutoCompleteGroupGuestDetailServlet",
				 data: { fName: $(elId).val(), siteId: siteId, cUserId:  cUserId, travelType:  travelType, flag:"getGuestList" },
                 dataType: "json",
                 success: function( data ) {                                           
                        response( $.map( data, function( item ) {
                            return {                                    
                                    label: item.TRAVELLER,
                                    value: item.GUSERID	                                                                                                        
                                   }
                        }));
                    }					 
            	});
	    	},
	    	select: function (event, ui) {
	    		
	    			fNameFlag = true;
	    			fNameVal = $("#firstName").val(); 	
	    			var rdata = ui.item.value;
    			  	getGuestDetail(rdata);
	    	},
	        focus: function (event, ui) {
	        	
	        	event.preventDefault(); // Prevent the default focus behavior.	
	        	fNameFlag = true;
    			fNameVal = $("#firstName").val(); 
    			var rdata = ui.item.value; 
			  	getGuestDetail(rdata);
	        }
		});
   	}
	
	function getGuestDetail(gUserId) {   		
		var flag="getGuestDetail";
		var siteId = $("select#siteName option:selected").val();
		var cUserId = '<%=Suser_id%>';
		var travelType = "D";
		if($('input#rd_Dom').is(':checked')) {
			travelType = "D";
		} else if($('input#rd_Int').is(':checked')) { 
			travelType = "I";
		}
		
		var urlParams="flag="+flag+"&siteId="+siteId+"&cUserId="+cUserId+"&gUserId="+gUserId+"&travelType="+travelType;
	   $.ajax({
	           type: "get",
	           url: "AutoCompleteGroupGuestDetailServlet",
	           data: urlParams,
	           dataType : 'json',
	           success: function(result) {
	        	
				if(result!=null) { 
					clearGuestDetails();
   					$("#firstName").val(result.FIRSTNAME);
   					$("#lastName").val(result.LASTNAME);
   					$("select#designation").val(result.DESIGNATION);	
   					$("#dateOfBirth").val(result.DOB);
   					FindAge($("#dateOfBirth"));	   					
   					$("select#gender").val(result.GENDER);	   					
   					$("select#mealPref").val(result.MEALPREF);
   					
   					//set style
   					$("#firstName").css('color', '#000000');
   					$("#lastName").css('color', '#000000');
   					$("#dateOfBirth").css('color', '#000000');
   					$("#age").css('color', '#000000');
   					
   					if(travelType=="D") {
   						$("select#identityProof").val(result.IDENTITYPROOF);	   					
   	   					$("#identityProofno").val(result.IDENTITYPROOFNO);
   	   					$("#contactNo").val(result.MOBILENO);
   	   					$("#identityProofno").css('color', '#000000');
   	   					$("#contactNo").css('color', '#000000');
   	   					
   	   					$("#empId").val(result.EMP_ID);
   	   					$("#empId").css('color', '#000000');
   	   					$("#emailId").val(result.EMAIL_ADDR);
   	   					$("#emailId").css('color', '#000000');
   					} else if(travelType=="I") {
   						$("#passportNo").val(result.PASSPORTNO);
   						$("#passportNationality").val(result.NATIONALITY);
   						$("#passportIssuePlace").val(result.PLACEISSUE);
   						$("#passportIssueDate").val(result.DATEISSUE);
   						$("#passportExpiryDate").val(result.EXPIRYDATE);
   						$("select#visaRequired").val(result.VISA);	
   						$("select#ecnrRequired").val(result.ECNR);	
   					
   						//set style
   	   					$("#passportNo").css('color', '#000000');
   	   					$("#passportNationality").css('color', '#000000');
   	   					$("#passportIssuePlace").css('color', '#000000');
   	   					$("#passportIssueDate").css('color', '#000000');
   	   				    $("#passportExpiryDate").css('color', '#000000');
   	   				    
   	   					$("#empIdInt").val(result.EMP_ID);
	   					$("#empIdInt").css('color', '#000000');
	   					$("#emailIdInt").val(result.EMAIL_ADDR);
	   					$("#emailIdInt").css('color', '#000000');
   					}   				 					
				 }
	          }
	     });
	}
	
	$('#firstName').on("change keyup", function() {
		if($(this).val() == "" || $(this).val() == '<%=dbLabelBean.getLabel("label.global.firstname",strsesLanguage)%>'){
			clearGuestDetails();
		} else if(fNameFlag && ($(this).val()!=fNameVal || $(this).val() == '<%=dbLabelBean.getLabel("label.global.firstname",strsesLanguage)%>')){
			clearGuestDetails();   
		}
	});
	
	function clearGuestDetails() {  		
	$("#lastName").val("");
	$("select#designation").val(selectedDesigId);
	$("#dateOfBirth").val("");
	$("select#gender").val("-1");
	$("select#mealPref").val("6");
	
	$("select#identityProof").val("-1");
	$("#identityProofno").val("");
	$("#contactNo").val("");		
	
	$("#passportNo").val("");
	$("#passportNationality").val("");
	$("#passportIssuePlace").val("");
	$("#passportIssueDate").val("");
	$("#passportExpiryDate").val("");
	$("select#visaRequired").val("2");	
	$("select#ecnrRequired").val("2");	
	
	FindAge($("#dateOfBirth"));
	}
</script>


<script type="text/javascript">
$(document).ready(function() {	
   	if("true" == '<%=msgFlag%>') {
   		closeDivRequest();
   		alert('<%=strMessage%>');
   	}
});
</script>

