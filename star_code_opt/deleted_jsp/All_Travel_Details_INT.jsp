<%/*************************************************** 
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:11 October 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is the jsp file  for show the Travel Requisition Details
 *Modification 			:Add Bifurcation details .
 *Reason of Modification:change suggested by MATA
 *Date of Modification  :2 Nov 2006 
 *Modified By	        :SACHIN GUPTA
 *Modification 			:1.Add Place Information. Change the different type of information like Forward Journey, Return Journey, Stay Type etc.
 2. code changed for showing '-' in place  of 0.0 on 09-Jul-07 
 3.Change the code for showing billing client in  different  cases by shiv  Sharma on 06-Nov-07   
 4. code added for showing age as year,month,days on 03-Mar-08   by Shiv Sharma    
 5. Code commented by shiv on 07 jan 2009 for not showing travel mode as requested by MATA
 6. added link for Learms page for showing deatils of lerms after all approveral on 29 jan 2009
 7:Commented Credit card no as it is not required   to show any user on 10-03-2010 by shiv sharma 

 *Reason of Modification:change suggested by MATA
 *Date of Modification  :19-02-2007 
 *Modified By	        :SACHIN GUPTA
 *Editor				:Editplus
 *Modified By	        :Pankaj Dubey on 17 Nov 2010
 *Revision History		:Added the budgetory details mentioned by request creator.
 *Editor		        :Eclipse 3.5  
 
 *Modified By			:Manoj Chand
 *Date of Modification	:22 Nov 2011
 *Modification			:Modification in sql query to show billing approver in details screen.
 
 *Modified By			:Manoj Chand
 *Date of Modification	:01 Dec 2011
 *Modification			:Show hyphen sign when expenditure remark is blank.
 
 *Modified By	        :MANOJ CHAND
 *Date of Modification  :29 Mar 2012
 *Description			:showing board member in details screen for SMP Division.
		 
 *Modified By	        :MANOJ CHAND
 *Date of Modification  :26 July 2012
 *Description			:Display AMEX card type in Credit card information section.
 
 *Modified By	        :MANOJ CHAND
 *Date of Modification  :29 Nov 2012
 *Description			:Display Total Travel Fare amount and currency for smp division only.
 
 *Modified By	        :MANOJ CHAND
 *Date of Modification  :31 Jan 2013
 *Description			:Showing mulitple currency and their value in comma separate way.
 *******************************************************/%>
<%@ include  file="importStatement.jsp" %>
<html>
<head>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean2" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="JavaScript1.2" src="scripts/div.js?buildstamp=2_0_0"></script>

<script type="text/javascript">
function openModificationDetails(travelId,flagValue,travelType)
{
  //alert("travel id is==========="+travelId);
  var mainLocation = 'T_Travel_Version_Details_INT.jsp?travelId='+travelId+'&flag='+flagValue;
  //alert(mainLocation);
  if(travelId != null && travelId!='')
  {
	  window.open(mainLocation,'Version','scrollbars=yes,resizable=yes,width=775,height=550');
	  
  }
}
</script>
	   <%
			String strSHOW_BUD_INPUT = "N";
			String strSql1 = "SELECT SHOW_BUD_INPUT FROM M_SITE WHERE site_id = "+strSiteIdSS+" ";
//			System.out.println("panakj ===================== "+strSql1);
			ResultSet rs12 = dbConBean.executeQuery(strSql1);
			while (rs12.next()) {
				strSHOW_BUD_INPUT = rs12.getString(1);
			}
			rs12.close();
	%>
<style type="text/css">
<!--
.style2 {font-size: 10px; font-weight: bold; color: #FF7D00; }
-->
</style>





</head>


<%
	//Global Variables declared and initialized
	String strSql = null;
	ResultSet rs, rs1, rs2 = null;
	// variables from userinfo table start
	String strUsername = "";
	String strPassportNo = "";
	String strNationality = "";
	String strDateIssue = "";
	String strPlaceIssue = "";
	String strExpiryDate = "";
	String strAddress = "";
	String strContactNo = "";
	String strFFNumber = "";
	String strFFNumber1 = "";
	String strFFNumber2 = "";

	//new 16-02-2007
	String strCurrentAddress = "";
	String strAirLineName = "";
	String strAirLineName1 = "";
	String strAirLineName2 = "";

	//

	String strDateofBirth = "";
	String strCompanyName = "";
	String strEcnr = "";
	String strDesignationName = "";
	String strTotal_Currency = "";

	//variables from userinfo end

	String strSiteId = "";
	String strSiteName = "";
	String strUserId = "";
	String strDivId = "";
	String strDeptId = "";
	String strDesigName = "";
	String strAge = "";
	String strAge1 = "";
	String strSex = "";
	String strMessage = "";

	String strUserNameId = "";
	String strSiteNameId = "";
	String strDesigNameId = "";
	String strMealId = "";
	String strVisaRequired = "";
	String strVisaComment = "";

	String strDepCity = "";
	String strDepDate = "";
	String strArrCity = "";

	String strRetrunDepCity = "";
	String strRetrunArrCity = "";

	String strReturnDate = "";
	String strNameOfAirline1 = "";
	String strNameOfAirline2 = "";
	String strInsuranceRequired = "";
	String strNominee = "";
	String strRelation = "";
	String strInsuranceComment = "";
	String strHotelRequired = "";
	String strBudgetCurrency = "";
	String strHotelBudget = "";
	String strRemarks = "";
	String strCheckInDate = "";
	String strCheckOutDate = "";

	//19-02-2007 sachin
	String strPlace = "";
	//

	String strTravelMode1 = "";
	String strTravelMode2 = "";
	String strTravelClass1 = "";
	String strTravelClass2 = "";
	String strManager = "";
	String strHod = "";
	String strBoardMemberId= "";
	String strSelectManagerRadio = "";
	String strPreferTime1 = "";
	String strPreferTime2 = "";
	String strTravelReqId = "";
	String strTravelId = "";
	String strTravelReqNo = "";
	String strJTravelDate = "";
	String strELIGIBILITY = ""; // for journey
	String strELIGIBILITY2 = ""; // for return journey

	// start Variable Declaration for Forex Details
	String strTotal_Amount = "";
	String strBilling_Client = "";
	String strBillingApprover="";

	String strTravellerCheque = "";
	String strTravellerCheque1 = "";
	String strTravellerCheque2 = "";
	String strTCCurrency = "";
	String strTCCurrency1 = "";
	String strTCCurrency2 = "";
	String strCashAmount = "";
	String strCashCurrency = "";
	Vector vecCash = new Vector();
	Vector vecTC = new Vector();

	String strCashBreakUpRemark = "";

	// variable to store  modifiedfields

	String strModified_fields = "";
	String strFOREX_MODIFIED_FIELDS = "";
	String[] ModifiedFiledsColoumn = null;
	String[] ModifiedForexColoumn = null;

	String strdepDateCompare = "";

	String strTOTAL_HOTEL_BUDGETCompare = "";

	String strVisaCompare = "";

	// Hotel
	String strHotelRequiredCompare = "";
	String strBudgetCompare = "";
	String strHotelBudgetCompare = "";
	String strRemarksCompare = "";
	String strCheckinCompare = "";
	String strCheckoutCompare = "";

	// meal
	String strMealCompare = "";

	// for Insurance
	String strInsuranceCompare = "";
	String strInsuranceNomineeCompare = "";
	String strInsurancerRelationCompare = "";
	String strInsuranceComments = "";
	String strInsuranceCommentsCompare = "";

	//Credit Card

	String strCardTypeCompare = "";
	String strCardNumberCompare = "";
	String strCVVNumberCompare = "";
	String strCardExpiryCompare = "";

	// Departure Journey

	String strTRAVEL_FROMCompare = "";
	String strTRAVEL_TOCompare = "";
	String strMODE_NAMECompare = "";
	String strTRAVEL_MODECompare = "";
	String strTRAVEL_CLASSCompare = "";
	String strTIMINGSCompare = "";

	// Return Journey
	String strRETURN_FROMCompare = "";
	String strReturnTRAVEL_TOCompare = "";
	String strReturnTRAVEL_MODECompare = "";
	String strReturnMODE_NAMECompare = "";
	String strReturnTRAVEL_CLASSCompare = "";
	String strReturnTIMINGSCompare = "";
	String strReturnTravelCompare = "";
	String strBilling_site = "";

	//Forex Compare

	String strForexCompare = "";
	String strForexCurrencyCompare = "";
	String strRequisitionId = "";
	String strSeatPrefferrtd = "";
	String strSeatpreferredfwd = "";

	//end Varaible Declaration for Forex Details

	strTravelId = request.getParameter("strRequisitionId");

	strRequisitionId = request.getParameter("strRequisitionId");
	//getting travel id from the previous page
	//System.out.println("strRequisitionId --> "+strTravelId);

	//CODE STARTS

	String strCARD_TYPE = "";

	//23022007
	String strCARD_HOLDER_NAME = "";
	//23022007

	String strExpRemark = "";//added by shiv on 3/28/2007

	//Below 5 fields Added by Pankaj on 17 Nov 2010
	String strYTM_BUDGET = ""; 
	String strYTD_ACTUAL = ""; 
	String strAVAIL_BUDGET = ""; 
	String strEST_EXP = ""; 
	String strEXP_REMARKS = "";
	
	String strCARD_NUMBER1 = "";
	String strCARD_NUMBER2 = "";
	String strCARD_NUMBER3 = "";
	String strCARD_NUMBER4 = "";
	String strCVV_NUMBER = "";
	String strCARD_EXP_DATE = "";
	String strCreditCardNumber = "";
	String strApproverRole = "";
	String strCUserId = "";

	String strReasonForSkip = "";
	String strTotalFareAmt="";
	String strTotalFareCur="";
	String strExpenditure="";

	//CODE ENDS

	//NEW CODE FOR FINDING WHEN MODIFICAITON DETAILS LINK WILL SHOW AND WHEN NOT
	//String strAccomodationModificaitonLink = "";
	String strModificationLink = "";
	String strForexModificationLink = "";
	String strForexModFlag = "";
	int intMaxVersionNo = 0;
	int intMaxForexVersionNo = 0;
	strSql = "SELECT MAX(VERSION_NO) AS MAX_VERSION_NO FROM AUDIT_T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="
			+ strTravelId + " AND APPLICATION_ID=1";
	rs = dbConBean.executeQuery(strSql);
	if (rs.next()) {
		intMaxVersionNo = rs.getInt("MAX_VERSION_NO");
	}
	rs.close();
	if (intMaxVersionNo > 1) {
		strModificationLink = "Modification Details";
	}
	//FOR FOREX MODIFICATION DETAIL LINK
	strSql = "SELECT MAX(FOREX_VERSION_NO) AS MAX_FOREX_VERSION_NO FROM AUDIT_T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="
			+ strTravelId + " AND APPLICATION_ID=1";
	rs = dbConBean.executeQuery(strSql);
	if (rs.next()) {
		intMaxForexVersionNo = rs.getInt("MAX_FOREX_VERSION_NO");
	}
	rs.close();
	if (intMaxForexVersionNo > 0) {
		strForexModificationLink = "Modification Details";
	}

	// Code to reterive modified Fields
	strSql = "SELECT ISNULL(MODIFIED_FIELDS,'-') AS MODIFIED_FIELDS FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="
			+ strTravelId;
	rs = dbConBean.executeQuery(strSql);

	while (rs.next()) {
		strModified_fields = rs.getString("MODIFIED_FIELDS");
	}
	if (!strModified_fields.equals("")) {
		ModifiedFiledsColoumn = strModified_fields.split(";");

		for (int i = 0; i < ModifiedFiledsColoumn.length; i++) {
			if (ModifiedFiledsColoumn[i].equals("TRAVEL_DATE")) {
				strdepDateCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("INSURANCE_REQUIRED")) {
				strInsuranceCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("NOMINEE")) {
				strInsuranceNomineeCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("RELATION")) {
				strInsurancerRelationCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("INSURANCE_COMMENTS")) {
				strInsuranceCommentsCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("HOTEL_REQUIRED")) {
				strHotelRequiredCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("BUDGET_CURRENCY")) {
				strBudgetCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("HOTEL_BUDGET")) {
				strHotelBudgetCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("REMARKS")) {
				strRemarksCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("CHECK_IN_DATE")) {
				strCheckinCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("CHECK_OUT_DATE")) {
				strCheckoutCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("MEAL")) {
				strMealCompare = "";
			}
			// for credit card  

			if (ModifiedFiledsColoumn[i].equals("CARD_TYPE")) {
				strCardTypeCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("CARD_NUMBER1")
					|| ModifiedFiledsColoumn[i].equals("CARD_NUMBER2")
					|| ModifiedFiledsColoumn[i].equals("CARD_NUMBER3")
					|| ModifiedFiledsColoumn[i].equals("CARD_NUMBER4")) {
				strCardNumberCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("CVV_NUMBER")) {
				strCVVNumberCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("CARD_EXP_DATE")) {
				strCardExpiryCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("HOTEL_BUDGET")) // for Expenditure Head 
			{
				strTOTAL_HOTEL_BUDGETCompare = "";
			}
		}
	}
	rs.close();

	// GETTING VALUES FROM JOURNEY DETAIL INT

	strSql = "SELECT ISNULL(MODIFIED_FIELDS,'-') AS MODIFIED_FIELDS FROM T_JOURNEY_DETAILS_INT WHERE JOURNEY_ORDER=1 AND APPLICATION_ID=1 AND TRAVEL_ID="
			+ strTravelId;
	rs = dbConBean.executeQuery(strSql);
	while (rs.next()) {
		strModified_fields = rs.getString("MODIFIED_FIELDS");
	}
	if (!strModified_fields.equals("")) {
		ModifiedFiledsColoumn = strModified_fields.split(";");

		for (int i = 0; i < ModifiedFiledsColoumn.length; i++) {

			if (ModifiedFiledsColoumn[i].equals("TRAVEL_FROM")) {
				strTRAVEL_FROMCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("TRAVEL_TO")) {
				strTRAVEL_TOCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("TRAVEL_MODE")) {
				strTRAVEL_MODECompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("MODE_NAME")) {
				strMODE_NAMECompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("TRAVEL_CLASS")) {
				strTRAVEL_CLASSCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("TIMINGS")) {
				strTIMINGSCompare = "";
			}

		}
	}
	rs.close();

	//------------------------------------------------------

	strSql = "SELECT ISNULL(MODIFIED_FIELDS,'-') AS MODIFIED_FIELDS FROM T_RET_JOURNEY_DETAILS_INT WHERE JOURNEY_ORDER=1 AND APPLICATION_ID=1 AND TRAVEL_ID="
			+ strTravelId;
	rs = dbConBean.executeQuery(strSql);
	while (rs.next()) {
		strModified_fields = rs.getString("MODIFIED_FIELDS");
	}

	if (!strModified_fields.equals("")) {
		ModifiedFiledsColoumn = strModified_fields.split(";");
		for (int i = 0; i < ModifiedFiledsColoumn.length; i++) {
			if (ModifiedFiledsColoumn[i].equals("RETURN_FROM")) {
				strRETURN_FROMCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("TRAVEL_TO")) {
				strReturnTRAVEL_TOCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("TRAVEL_MODE")) {
				strReturnTRAVEL_MODECompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("MODE_NAME")) {
				strReturnMODE_NAMECompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("TRAVEL_CLASS")) {
				strReturnTRAVEL_CLASSCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("TIMINGS")) {
				strReturnTIMINGSCompare = "";
			}
			if (ModifiedFiledsColoumn[i].equals("TRAVEL_DATE")) {
				strReturnTravelCompare = "";
			}

		}
	}
	rs.close();

	// compare for forex details 

	strSql = "SELECT ISNULL(FOREX_MODIFIED_FIELDS,'-') AS  FOREX_MODIFIED_FIELDS FROM T_TRAVEL_DETAIL_INT WHERE APPLICATION_ID=1 AND TRAVEL_ID="
			+ strTravelId;
	rs = dbConBean.executeQuery(strSql);

	while (rs.next()) {
		strFOREX_MODIFIED_FIELDS = rs
				.getString("FOREX_MODIFIED_FIELDS");
	}
	if (!strFOREX_MODIFIED_FIELDS.equals("")) {
		ModifiedForexColoumn = strFOREX_MODIFIED_FIELDS.split(";");
		for (int i = 0; i < ModifiedForexColoumn.length; i++) {
			if (ModifiedForexColoumn[i].equals("TRAVELLER_CHEQUE")
					|| ModifiedForexColoumn[i]
							.equals("TRAVELLER_CHEQUE1")
					|| ModifiedForexColoumn[i]
							.equals("TRAVELLER_CHEQUE2")) {
				strForexCompare = "";
			}
		}
	}
	rs.close();
//CHANGED BY MANOJ ON 26 JULY 2011
	//strSql = "SELECT ISNULL(TRAVEL_REQ_ID,'-') AS TRAVEL_REQ_ID , C_USERID,ISNULL(dbo.SITENAME_FROM_USERID(C_USERID),'-') AS UNIT ,ISNULL(TRAVELLER_ID,'-') AS TRAVELLER_ID ,ISNULL(AGE,'-') AS AGE ,ISNULL(SEX,'-') AS SEX,ISNULL(dbo.MEAL_NAME(MEAL),'-') AS  MEALNAME,ISNULL(VISA_REQUIRED,'-') AS VISA_REQUIRED,ISNULL(VISA_COMMENT,'-') AS VISA_COMMENT, ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE),'-')AS TRAVEL_DATE, ISNULL(INSURANCE_REQUIRED,'-') AS INSURANCE_REQUIRED,ISNULL(NOMINEE,'-') AS NOMINEE, ISNULL(RELATION,'-') AS RELATION, ISNULL(INSURANCE_COMMENTS,'-') AS INSURANCE_COMMENTS, ISNULL(HOTEL_REQUIRED,'-') AS HOTEL_REQUIRED,ISNULL(RTRIM(LTRIM(BUDGET_CURRENCY)),'-') AS BUDGET_CURRENCY , ISNULL(HOTEL_BUDGET,'') AS HOTEL_BUDGET, ISNULL(REMARKS,'-') AS REMARKS, LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CHECK_IN_DATE),'-'))) AS CHECK_IN_DATE , LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CHECK_OUT_DATE),'-'))) AS CHECK_OUT_DATE, ISNULL(PLACE,'-') AS PLACE, ISNULL(RTRIM(LTRIM(APPROVER_SELECTION)),'-') AS APPROVER_SELECTION, MANAGER_ID,HOD_ID, LTRIM(RTRIM(ISNULL(CARD_TYPE,''))) AS CARD_TYPE,LTRIM(RTRIM(ISNULL(CARD_NUMBER1,''))) AS CARD_NUMBER1,LTRIM(RTRIM(ISNULL(CARD_NUMBER2,''))) AS CARD_NUMBER2 ,LTRIM(RTRIM(ISNULL(CARD_NUMBER3,''))) AS CARD_NUMBER3, LTRIM(RTRIM(ISNULL(CARD_NUMBER4,''))) AS CARD_NUMBER4 ,LTRIM(RTRIM(ISNULL(CVV_NUMBER,''))) AS CVV_NUMBER,LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CARD_EXP_DATE),''))) AS CARD_EXP_DATE, ISNULL(CONVERT(decimal(20,0),TOTAL_AMOUNT),'0') AS TOTAL_AMOUNT,ISNULL(TA_CURRENCY,'-') AS TA_CURRENCY,BILLING_SITE,BILLING_CLIENT, ISNULL(.DBO.TRAVEL_MODE(TRAVEL_ID,'I'),'-') AS TRAVEL_MODE,            ISNULL(RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE))),'-') AS TRAVELLER_CHEQUE,ISNULL(RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE1))),'-') AS TRAVELLER_CHEQUE1, ISNULL(RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE2))),'-') AS TRAVELLER_CHEQUE2,ISNULL(TC_CURRENCY,'-') AS TC_CURRENCY,ISNULL(TC_CURRENCY1,'-') AS TC_CURRENCY1,ISNULL(TC_CURRENCY2,'-') AS TC_CURRENCY2, ISNULL(REASON_FOR_SKIP,'-') AS REASON_FOR_SKIP,ISNULL(CASH_BREAKUP_REMARKS,'-') AS CASH_BREAKUP_REMARKS ,ISNULL(CARD_HOLDER_NAME,'') AS CARD_HOLDER_NAME,ISNULL(EXPENDITURE_REMARKS,'-') AS EXPENDITURE_REMARKS , ROUND(YTM_BUDGET ,0) YTM_BUDGET, ROUND(YTD_ACTUAL,0) YTD_ACTUAL, ROUND(AVAIL_BUDGET ,0) AVAIL_BUDGET, ROUND(EST_EXP,0) EST_EXP, EXP_REMARKS  FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="
		//	+ strTravelId + " AND APPLICATION_ID=1 AND STATUS_ID=10";
strSql = "SELECT ISNULL(TRAVEL_REQ_ID,'-') AS TRAVEL_REQ_ID , C_USERID, ISNULL(DBO.SITENAME(SITE_ID),'-') AS UNIT ,ISNULL(TRAVELLER_ID,'-') AS TRAVELLER_ID ,ISNULL(AGE,'-') AS AGE ,ISNULL(SEX,'-') AS SEX,ISNULL(dbo.MEAL_NAME(MEAL),'-') AS  MEALNAME,ISNULL(VISA_REQUIRED,'-') AS VISA_REQUIRED,ISNULL(VISA_COMMENT,'-') AS VISA_COMMENT, ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE),'-')AS TRAVEL_DATE, ISNULL(INSURANCE_REQUIRED,'-') AS INSURANCE_REQUIRED,ISNULL(NOMINEE,'-') AS NOMINEE, ISNULL(RELATION,'-') AS RELATION, ISNULL(INSURANCE_COMMENTS,'-') AS INSURANCE_COMMENTS, ISNULL(HOTEL_REQUIRED,'-') AS HOTEL_REQUIRED,ISNULL(RTRIM(LTRIM(BUDGET_CURRENCY)),'-') AS BUDGET_CURRENCY , ISNULL(HOTEL_BUDGET,'') AS HOTEL_BUDGET, ISNULL(REMARKS,'-') AS REMARKS, LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CHECK_IN_DATE),'-'))) AS CHECK_IN_DATE , LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CHECK_OUT_DATE),'-'))) AS CHECK_OUT_DATE, ISNULL(PLACE,'-') AS PLACE, ISNULL(RTRIM(LTRIM(APPROVER_SELECTION)),'-') AS APPROVER_SELECTION, MANAGER_ID,HOD_ID, LTRIM(RTRIM(ISNULL(CARD_TYPE,''))) AS CARD_TYPE,LTRIM(RTRIM(ISNULL(CARD_NUMBER1,''))) AS CARD_NUMBER1,LTRIM(RTRIM(ISNULL(CARD_NUMBER2,''))) AS CARD_NUMBER2 ,LTRIM(RTRIM(ISNULL(CARD_NUMBER3,''))) AS CARD_NUMBER3, LTRIM(RTRIM(ISNULL(CARD_NUMBER4,''))) AS CARD_NUMBER4 ,LTRIM(RTRIM(ISNULL(CVV_NUMBER,''))) AS CVV_NUMBER,LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CARD_EXP_DATE),''))) AS CARD_EXP_DATE, ISNULL(CONVERT(decimal(20,2),TOTAL_AMOUNT),'0') AS TOTAL_AMOUNT,ISNULL(TA_CURRENCY,'-') AS TA_CURRENCY,BILLING_SITE,BILLING_CLIENT, ISNULL(.DBO.TRAVEL_MODE(TRAVEL_ID,'I'),'-') AS TRAVEL_MODE,            ISNULL(RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE))),'-') AS TRAVELLER_CHEQUE,ISNULL(RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE1))),'-') AS TRAVELLER_CHEQUE1, ISNULL(RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE2))),'-') AS TRAVELLER_CHEQUE2,ISNULL(TC_CURRENCY,'-') AS TC_CURRENCY,ISNULL(TC_CURRENCY1,'-') AS TC_CURRENCY1,ISNULL(TC_CURRENCY2,'-') AS TC_CURRENCY2, ISNULL(REASON_FOR_SKIP,'-') AS REASON_FOR_SKIP,ISNULL(CASH_BREAKUP_REMARKS,'-') AS CASH_BREAKUP_REMARKS ,ISNULL(CARD_HOLDER_NAME,'') AS CARD_HOLDER_NAME,ISNULL(EXPENDITURE_REMARKS,'-') AS EXPENDITURE_REMARKS , ROUND(YTM_BUDGET ,0) YTM_BUDGET, ROUND(YTD_ACTUAL,0) YTD_ACTUAL, ROUND(AVAIL_BUDGET ,0) AVAIL_BUDGET, ROUND(EST_EXP,0) EST_EXP, EXP_REMARKS,BOARD_MEMBER_ID,SITE_ID,FARE_CURRENCY,FARE_AMOUNT,dbo.FN_GET_EXPENDITURE('"+strTravelId+"','I') AS Expenditure  FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="
			+ strTravelId + " AND APPLICATION_ID=1";
	//ISNULL(EXPENDITURE_REMARKS,'-') AS EXPENDITURE_REMARKS

	//System.out.println("************"+strSql);
	rs = dbConBean.executeQuery(strSql);
	if (rs.next()) {
		strTravelReqId = rs.getString("TRAVEL_REQ_ID");
		strCUserId = rs.getString(2);
		//System.out.println("strCUserId  "+strCUserId);
		strSiteName = rs.getString("UNIT");
		strUserId = rs.getString("TRAVELLER_ID");
		strAge1 = rs.getString("AGE");
		strSex = rs.getString("SEX");
		if (strSex.equals("1")) {
			strSex = "Male";
		} else {
			strSex = "Female";
		}
		strMealId = rs.getString("MEALNAME");
		strVisaRequired = rs.getString("VISA_REQUIRED");
		if (strVisaRequired != null) {
			if (strVisaRequired.trim().equals("1")) {
				strVisaRequired = "Yes";
			} else {
				strVisaRequired = "No";
			}
		}
		strVisaComment = rs.getString("VISA_COMMENT");
		strDepDate = rs.getString("TRAVEL_DATE");
		strInsuranceRequired = rs.getString("INSURANCE_REQUIRED");
		if (strInsuranceRequired != null) {
			if (strInsuranceRequired.trim().equals("1")) {
				strInsuranceRequired = "Yes";
			} else {
				strInsuranceRequired = "No";
			}
		}
		strNominee = rs.getString("NOMINEE");
		strRelation = rs.getString("RELATION");
		strInsuranceComment = rs.getString("INSURANCE_COMMENTS");
		strHotelRequired = rs.getString("HOTEL_REQUIRED");
		strBudgetCurrency = rs.getString("BUDGET_CURRENCY");
		strHotelBudget = rs.getString("HOTEL_BUDGET").trim();

		// added code by shiv on 09-Jul-07
		if (strHotelBudget != null && strHotelBudget.equals("0.0")) {
			strHotelBudget = "-";
		}

		if (strHotelRequired != null) {
			if (strHotelRequired.trim().equals("1")) {
				strHotelRequired = "Hotel";
			} else if (strHotelRequired.trim().equals("2")) {
				strHotelRequired = "Transit House";
				if (strHotelBudget.equals("-")
						|| strHotelBudget.equals("")
						|| strHotelBudget.equals("0")) {
					strHotelBudget = "-";
					strBudgetCurrency = "-";
				}

			} else {
				strHotelRequired = "No";
			}
		}
		strRemarks = rs.getString("REMARKS");
		if (strRemarks == null || strRemarks.equals("")) {
			strRemarks = "-";
		}
		strCheckInDate = rs.getString("CHECK_IN_DATE");
		strCheckOutDate = rs.getString("CHECK_OUT_DATE");
		// 19-02-2007 SACHIN
		strPlace = rs.getString("PLACE");
		//

		strSelectManagerRadio = rs.getString("APPROVER_SELECTION");
		strManager = rs.getString("MANAGER_ID");
		strHod = rs.getString("HOD_ID");
		strCARD_TYPE = rs.getString("CARD_TYPE");
		strCARD_NUMBER1 = rs.getString("CARD_NUMBER1");
		strCARD_NUMBER2 = rs.getString("CARD_NUMBER2");
		strCARD_NUMBER3 = rs.getString("CARD_NUMBER3");
		strCARD_NUMBER4 = rs.getString("CARD_NUMBER4");
		strCVV_NUMBER = rs.getString("CVV_NUMBER");
		strCARD_EXP_DATE = rs.getString("CARD_EXP_DATE");
		strCreditCardNumber = strCARD_NUMBER1 + " " + strCARD_NUMBER2
				+ " " + strCARD_NUMBER3 + " " + strCARD_NUMBER4;
		//getting details for  forex
		strTotal_Amount = rs.getString("TOTAL_AMOUNT");
		strTotal_Currency = rs.getString("TA_CURRENCY");
		if (strTotal_Amount != null && (strTotal_Amount.equals("0.00"))) {
			strTotal_Amount = "-";
			strTotal_Currency = "";
		}
		strBilling_site = rs.getString("BILLING_SITE");

		strBilling_Client = rs.getString("BILLING_CLIENT");

		strTravellerCheque = rs.getString("TRAVELLER_CHEQUE");
		strTravellerCheque1 = rs.getString("TRAVELLER_CHEQUE1");
		strTravellerCheque2 = rs.getString("TRAVELLER_CHEQUE2");
		strTCCurrency = rs.getString("TC_CURRENCY");
		strTCCurrency1 = rs.getString("TC_CURRENCY1");
		strTCCurrency2 = rs.getString("TC_CURRENCY2");
		if (strTravellerCheque != null
				&& !strTravellerCheque.equals("0")
				&& !strTravellerCheque.equals("0.0")
				&& !strTravellerCheque.equals("-")) {
			vecTC.addElement(strTCCurrency);
			vecTC.addElement(strTravellerCheque);
		}
		if (strTravellerCheque1 != null
				&& !strTravellerCheque1.equals("0")
				&& !strTravellerCheque1.equals("0.0")
				&& !strTravellerCheque1.equals("-")) {
			vecTC.addElement(strTCCurrency1);
			vecTC.addElement(strTravellerCheque1);
		}
		if (strTravellerCheque2 != null
				&& !strTravellerCheque2.equals("0")
				&& !strTravellerCheque2.equals("0.0")
				&& !strTravellerCheque2.equals("-")) {
			vecTC.addElement(strTCCurrency2);
			vecTC.addElement(strTravellerCheque2);
		}

		strReasonForSkip = rs.getString("REASON_FOR_SKIP");
		strCashBreakUpRemark = rs.getString("CASH_BREAKUP_REMARKS");

		//23022007
		strCARD_HOLDER_NAME = rs.getString("CARD_HOLDER_NAME");
		//23022007

		strExpRemark = rs.getString("EXPENDITURE_REMARKS"); //added by shiv on 3/28/2007
		//added by manoj chand on 01 dec 2011 to show hyphen when expenditure remarks is blank
		if(strExpRemark.equalsIgnoreCase(""))
			strExpRemark="-";
		//System.out.println("strBill");
		//Below 5 fields Added by Pankaj on 17 Nov 2010
		try{
		strYTM_BUDGET = rs.getString("YTM_BUDGET"); 
		strYTD_ACTUAL = rs.getString("YTD_ACTUAL"); 
		strAVAIL_BUDGET = rs.getString("AVAIL_BUDGET"); 
		strEST_EXP = rs.getString("EST_EXP"); 
		strEXP_REMARKS = rs.getString("EXP_REMARKS");
		strBoardMemberId= rs.getString("BOARD_MEMBER_ID");
		strSiteId=rs.getString("SITE_ID");	
		strTotalFareCur=rs.getString("FARE_CURRENCY");
		strTotalFareAmt=rs.getString("FARE_AMOUNT");
		strExpenditure=rs.getString("Expenditure");
		if(strTotalFareCur.equals(""))
			strTotalFareCur="-";
		if(strTotalFareAmt.equals("0"))
			strTotalFareAmt="-";
		
		if(strEXP_REMARKS.equals(""))
			strEXP_REMARKS = "-";
		}catch(Exception e ){
			System.out.println("strBill22222");	
			e.printStackTrace();
		}
		
	}
	rs.close();

	//System.out.println("strBilling_Client=="+strBilling_Client+"req_no ===" + strTravelId);
	//System.out.println("strBilling_site=="+strBilling_site);
	////added new by shiv on 02-Nov-07 

	if (strBilling_site != null && !strBilling_site.equals("0")
			&& !strBilling_site.equals(strTravelId)
			&& !strBilling_site.equals("-1"))
	///normal case  when user site is biling site  
	{
		if (strBilling_Client == null) {
			strBilling_Client = "--";
		} else {

			int intBilling_Client = Integer.parseInt(strBilling_Client);
			//System.out.println("intBilling_Client=="+intBilling_Client);
			//	 strSql = "select site_name from m_site where site_id=(select site_id from m_userinfo  where USERID="+intBilling_Client+")";
			//strSq = "select site_name from m_site where site_id=(select billing_site from t_travel_detail_int where TRAVEL_ID="+ strTravelId + ")";
			//changed by manoj chand on 22 Nov 2011 to show billing approver in details screen.
			strSql = "SELECT .DBO.SITENAME(BILLING_SITE)  AS SITE_NAME,dbo.user_name(BILLING_CLIENT) AS BILLING_CLIENT FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID ="+strTravelId;
			//System.out.println("strSqlVVVVV======"+strSql);

			rs = dbConBean.executeQuery(strSql);
			while (rs.next()) {
				strBilling_Client = rs.getString("SITE_NAME");
				strBillingApprover=rs.getString("BILLING_CLIENT");
			}
			rs.close();
		}

	}

	//code added

	if (strCARD_TYPE.equals("0")) {
		strCARD_TYPE = dbLabelBean.getLabel("label.global.visa",strsesLanguage);
	}
	if (strCARD_TYPE.equals("1")) {
		strCARD_TYPE = dbLabelBean.getLabel("label.global.master",strsesLanguage);
	}
	if (strCARD_TYPE.equals("2")) {
		strCARD_TYPE = dbLabelBean.getLabel("label.createrequest.amex",strsesLanguage);
	}
	//code ends	

	//Code for getting the cash Breakup info 
	strSql = "SELECT CASH_CURRENCY, ISNULL(RTRIM(LTRIM(convert(decimal(20,0),CASH_AMOUNT))),'-') AS CASH_AMOUNT FROM T_CASH_BREAKUP_INT WHERE TRAVEL_ID="
			+ strTravelId + " AND APPLICATION_ID=1";
	rs = dbConBean.executeQuery(strSql);
	while (rs.next()) {
		vecCash.addElement(rs.getString("CASH_CURRENCY"));
		vecCash.addElement(rs.getString("CASH_AMOUNT"));
	}
	rs.close();

	//Code starts  if strBilling client is null,means the site is paying for it 
	if ((strBilling_Client == null) || (strBilling_Client.equals(""))
			|| strBilling_Client.equals("-")
			|| strBilling_Client.equals("-1")) {
		//strSql = "select site_name from m_site where site_id=(select billing_site from t_travel_detail_int where TRAVEL_ID="+ strTravelId + ")";
		//changed by manoj chand on 22 Nov 2011 to show billing approver in details screen.
		strSql="SELECT .DBO.SITENAME(BILLING_SITE)  AS SITE_NAME,dbo.user_name(BILLING_CLIENT) AS BILLING_CLIENT FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID ="+strTravelId;

		rs = dbConBean.executeQuery(strSql);
		while (rs.next()) {
			strBilling_Client = rs.getString("SITE_NAME");
			strBillingApprover=rs.getString("BILLING_CLIENT");
		}
		rs.close();
	}
	/*if(strBilling_Client == null)
	 {
	 strBilling_Client  =  "-";
	 }
	 */
	//Code ends if strBilling client is null,means the site is paying for it 
	//System.out.println("strBillingClient is========*******************************************");

	if (strSelectManagerRadio != null
			&& strSelectManagerRadio.equals("manual")) {

		// getting value form m_userinfo for hod and pm
		if (strManager != null && !strManager.equals("null")
				&& !strManager.equals("")) {
			strSql = "select dbo.user_name(" + strManager + ")";
			rs = dbConBean.executeQuery(strSql);
			while (rs.next()) {
				strManager = rs.getString(1);
			}
			rs.close();
		} else {
			strManager = "-";
		}

		if (strHod != null && !strHod.equals("null")
				&& !strHod.equals("")) {
			strSql = "select dbo.user_name(" + strHod + ")";
			rs = dbConBean.executeQuery(strSql);
			while (rs.next()) {
				strHod = rs.getString(1);
			}
			rs.close();
		} else {
			strHod = "-";
		}
	}
	//added by Manoj Chand on 29 Mar 2012 to get board member
	if (strBoardMemberId != null && !strBoardMemberId.equals("null") && !strBoardMemberId.equals("")) {
		strSql = "select dbo.user_name(" + strBoardMemberId + ")";
		rs = dbConBean.executeQuery(strSql);
		while (rs.next()) {
			strBoardMemberId = rs.getString(1);
		}
		rs.close();
	} else {
		strBoardMemberId = "-";
	}
	
	// if hod is selected is automatically

	if (strSelectManagerRadio != null
			&& strSelectManagerRadio.equals("automatic")) {
		strManager = dbLabelBean.getLabel("label.requestdetails.managerselectedautomatically",strsesLanguage);
		strHod = dbLabelBean.getLabel("label.requestdetails.hodselectedautomatically",strsesLanguage);
	} else if (strSelectManagerRadio != null
			&& strSelectManagerRadio.equals("skip")) {
		strManager = "skip";
		strHod = "skip";
	}
	//  closed code for hod and manager who are selected automatically 

	//when billing client is self then no manager and no hod
	if (strBilling_Client != null && strBilling_Client.equals("self")) {
		strManager = "-";
		strHod = "-";
	}

	//getting value from m_userinfo closed  

	strSql = "select ISNULL(dbo.user_name(userid),'-')AS USERNAME,ISNULL(PASSPORT_NO,'-')AS PASSPORT_NO,ISNULL(NATIONALITY ,'') AS NATIONALITY,ISNULL(dbo.CONVERTDATEDMY1(DATE_ISSUE),'-') AS DATE_ISSUE,ISNULL(PLACE_ISSUE,'-') AS PLACE_ISSUE,ISNULL(dbo.CONVERTDATEDMY1(EXPIRY_DATE),'-') AS EXPIRY_DATE,ISNULL(ADDRESS,'-') AS ADDRESS ,ISNULL(CONTACT_NUMBER,'-') AS CONTACT_NUMBER,ISNULL(FF_NUMBER,'-') AS FF_NUMBER,ISNULL(FF_NUMBER1,'-') AS FF_NUMBER1,ISNULL(FF_NUMBER2,'-') AS FF_NUMBER2,ISNULL(dbo.CONVERTDATEDMY1(DOB),'-')AS DOB,ISNULL(dbo.SITENAME(SITE_ID),'-')AS COMPANYNAME,ISNULL(ECNR,'-') AS ECNR,ISNULL(dbo.DESIG_FROM_USERID(userid),'-') AS DESIGNAME,    ISNULL(CURRENT_ADDRESS,'') AS CURRENT_ADDRESS, ISNULL(FF_AIR_NAME,'') AS FF_AIR_NAME, ISNULL(FF_AIR_NAME1,'') AS FF_AIR_NAME1, ISNULL(FF_AIR_NAME2,'') AS FF_AIR_NAME2 from m_userinfo  where userid ='"
			+ strUserId + "'"; // on the basis of traveller id 

	rs = dbConBean.executeQuery(strSql);
	if (rs.next()) {
		strUsername = rs.getString("USERNAME");
		// code startto convert first and last letter in uppercase
		int s = strUsername.indexOf(" ", 0);

		String FirstLetter = "";
		String LastLetter = "";

		//System.out.println("s===="+s);
		//if(s>=0){ 
		FirstLetter = strUsername.substring(0, 1).toUpperCase()
				+ strUsername.substring(1, s);
		LastLetter = strUsername.substring(s + 1, s + 2).toUpperCase()
				+ strUsername.substring(s + 2, strUsername.length());
		//}
		//else{
		strUsername = FirstLetter + " " + LastLetter;
		//} 
		strUsername = FirstLetter + " " + LastLetter;
		// code ends to convert first and last letter in uppercase

		strPassportNo = rs.getString("PASSPORT_NO");
		strNationality = rs.getString("NATIONALITY");
		strDateIssue = rs.getString("DATE_ISSUE");
		strPlaceIssue = rs.getString("PLACE_ISSUE");
		strExpiryDate = rs.getString("EXPIRY_DATE");
		strAddress = rs.getString("ADDRESS");
		strContactNo = rs.getString("CONTACT_NUMBER");
		strFFNumber = rs.getString("FF_NUMBER");
		strFFNumber1 = rs.getString("FF_NUMBER1");
		strFFNumber2 = rs.getString("FF_NUMBER2");
		strDateofBirth = rs.getString("DOB");
		strCompanyName = rs.getString("COMPANYNAME");
		strEcnr = rs.getString("ECNR");
		if (strEcnr != null) {
			if (strEcnr.trim().equals("1")) {
				strEcnr = "Yes";
			} else if (strEcnr.trim().equals("2")) {
				strEcnr = "No";
			} else if (strEcnr.trim().equals("3")) {
				strEcnr = "N/A";
			}
		}
		strDesignationName = rs.getString("DESIGNAME");

		//NEW 16-02-2007 SACHIN
		strCurrentAddress = rs.getString("CURRENT_ADDRESS");
		strAirLineName = rs.getString("FF_AIR_NAME");
		strAirLineName1 = rs.getString("FF_AIR_NAME1");
		strAirLineName2 = rs.getString("FF_AIR_NAME2");
		//

	}
	rs.close();

	// query for return journey

	strSql = "SELECT ISNULL(RETURN_FROM,'-')AS RETURN_FROM, ISNULL(RETURN_TO,'-') AS RETURN_TO, ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE),'-') AS RETURN_DATE, ISNULL(RTRIM(LTRIM(TRAVEL_MODE)),'-') AS TRAVEL_MODE, ISNULL(MODE_NAME,'-') AS MODE_NAME , ISNULL(RTRIM(LTRIM(TRAVEL_CLASS)),'-') AS TRAVEL_CLASS, ISNULL(RTRIM(LTRIM(TIMINGS)),'-') AS TIMINGS, isnull(M_SEAT_PREFER.Seat_Name,'') as Seat_Name  FROM T_RET_JOURNEY_DETAILS_INT left outer JOIN  M_SEAT_PREFER ON  T_RET_JOURNEY_DETAILS_INT.SEAT_PREFFERED = M_SEAT_PREFER.seat_id WHERE T_RET_JOURNEY_DETAILS_INT.TRAVEL_ID='"
			+ strTravelId
			+ "'AND T_RET_JOURNEY_DETAILS_INT.JOURNEY_ORDER=1 AND T_RET_JOURNEY_DETAILS_INT.APPLICATION_ID=1";
	// query for return journey ends 

	rs = dbConBean.executeQuery(strSql);
	if (rs.next()) {
		strRetrunDepCity = rs.getString("RETURN_FROM");
		strRetrunArrCity = rs.getString("RETURN_TO");

		strReturnDate = rs.getString("RETURN_DATE");
		strTravelMode2 = rs.getString("TRAVEL_MODE");
		if (strTravelMode2 != null) {
			if (strTravelMode2.trim().equals("1")) {
				strTravelMode2 = "Air";
			} else {
				strTravelMode2 = "Train";
			}
		}
		strNameOfAirline2 = rs.getString("MODE_NAME");
		strTravelClass2 = rs.getString("TRAVEL_CLASS");
		strPreferTime2 = rs.getString("TIMINGS");
		strSeatPrefferrtd = rs.getString("Seat_Name");//strSeatPrefferrtd

	}
	rs.close();

	strSql = "select ISNULL(PREFER_TIME,'-') AS PREFER_TIME from M_Prefer_TIME where TIME_ID ='"
			+ strPreferTime2 + "'";

	rs = dbConBean.executeQuery(strSql);
	while (rs.next()) {
		strPreferTime2 = rs.getString(1);
	}
	rs.close();

	if (strTravelMode2.equals("Train"))
		strSql = "SELECT DISTINCT TRAIN_ID, ISNULL(ELIGIBILITY,'-') AS ELIGIBILITY FROM M_TRAIN_CLASS WHERE STATUS_ID=10 and TRAIN_ID='"
				+ strTravelClass2 + "'";
	else
		strSql = "SELECT DISTINCT AIR_ID, ISNULL(ELIGIBILITY,'-') AS ELIGIBILITY FROM M_AIRLINE_CLASS WHERE STATUS_ID=10 and AIR_ID='"
				+ strTravelClass2 + "'";
	rs = dbConBean.executeQuery(strSql);
	while (rs.next()) {
		strELIGIBILITY2 = rs.getString(2);
		//System.out.println("strELIGIBILITY--> "+strELIGIBILITY2);
	}
	rs.close();

	// query for Departure Journey starts
	strSql = "SELECT ISNULL(TRAVEL_FROM,'-')AS TRAVEL_FROM, ISNULL(TRAVEL_TO,'-') AS TRAVEL_TO,ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE),'-') AS TRAVEL_DATE, ISNULL(RTRIM(LTRIM(TRAVEL_MODE)),'-') AS TRAVEL_MODE, ISNULL(MODE_NAME,'-') AS MODE_NAME, ISNULL(RTRIM(LTRIM(TRAVEL_CLASS)),'-') AS TRAVEL_CLASS, ISNULL(RTRIM(LTRIM(TIMINGS)),'-') AS TIMINGS, isnull(M_SEAT_PREFER.Seat_Name,'')as Seat_Name FROM T_JOURNEY_DETAILS_INT left outer JOIN  M_SEAT_PREFER ON  T_JOURNEY_DETAILS_INT.SEAT_PREFFERED = M_SEAT_PREFER.seat_id WHERE T_JOURNEY_DETAILS_INT.TRAVEL_ID='"
			+ strTravelId
			+ "'AND T_JOURNEY_DETAILS_INT.JOURNEY_ORDER=1 AND T_JOURNEY_DETAILS_INT.APPLICATION_ID=1";
	//query for departure journey ends  

	rs = dbConBean.executeQuery(strSql);
	if (rs.next()) {
		strDepCity = rs.getString("TRAVEL_FROM");
		strArrCity = rs.getString("TRAVEL_TO");
		strJTravelDate = rs.getString("TRAVEL_DATE");
		strTravelMode1 = rs.getString("TRAVEL_MODE");
		if (strTravelMode1 != null) {
			if (strTravelMode1.trim().equals("1")) {
				strTravelMode1 = "Air";
			} else {
				strTravelMode1 = "Train";
			}
		}

		strNameOfAirline1 = rs.getString("MODE_NAME");
		strTravelClass1 = rs.getString("TRAVEL_CLASS");
		strPreferTime1 = rs.getString("TIMINGS");
		strSeatpreferredfwd = rs.getString("Seat_Name");

	}
	rs.close();

	strSql = "select ISNULL(PREFER_TIME,'-') AS PREFER_TIME from M_Prefer_TIME where TIME_ID ='"
			+ strPreferTime1 + "'";
	rs = dbConBean.executeQuery(strSql);
	while (rs.next()) {
		strPreferTime1 = rs.getString(1);
	}
	rs.close();

	if (strTravelMode1.equals("Train"))
		strSql = "SELECT TRAIN_ID, ISNULL(ELIGIBILITY,'-') AS ELIGIBILITY  FROM M_TRAIN_CLASS WHERE STATUS_ID=10 and TRAIN_ID='"
				+ strTravelClass1 + "'";
	else
		strSql = "SELECT AIR_ID, ISNULL(ELIGIBILITY,'-') AS ELIGIBILITY  FROM M_AIRLINE_CLASS WHERE STATUS_ID=10 and AIR_ID='"
				+ strTravelClass1 + "'";
	rs = dbConBean.executeQuery(strSql);
	while (rs.next()) {
		strELIGIBILITY = rs.getString(2);
	}
	rs.close();
%>






<body>
 <table width="100%" align="center" style="margin:0 auto;" border="0" >
  <tr>
    <td align="center">
	  <table width="100%" border="0" cellpadding="2" cellspacing="1" class="reporttble">
        <tr>
          <td height="0" colspan="4" align="left" class="reportHeading" ><%=dbLabelBean.getLabel("label.requestdetails.allinformation",strsesLanguage) %>  <font size="1"></font></td>
        </tr>
        <tr>
          <td height="0" colspan="4" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.global.basicinformation",strsesLanguage) %> <!--<A href="#" onClick="openModificationDetails('<%//=strTravelId%>','BasicInfo','')"><%//=strModificationLink%></A>--></td>
        </tr>
        <tr>
		  <td width="29%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage) %></td>
		  <td width="21%" height="0" class="reportdata" ><%=strUsername%></td>
		  <td width="25%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage) %></td>
		  <td width="25%" height="0" class="reportdata" ><%=strSiteName%></td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strDesignationName%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.age",strsesLanguage) %></td>
   <%
   	// code added for showing age as year,month,days on 03-Mar-08   by Shiv Sharma   
   	strSql = "SELECT dbo.CalAge_YYMMDD(DOB,GETDATE()), GENDER FROM M_USERINFO WHERE USERID="
   			+ strUserId;
   	rs = dbConBean.executeQuery(strSql);
   	if (rs.next()) {
   		strAge1 = rs.getString(1);
   	}
   	rs.close();
   %>
          <td height="0" class="reportdata" ><%=strAge1%></td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strSex%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.mealpreference",strsesLanguage) %><span class="starcolour"><%=strMealCompare%></span></td>
          <td height="0" class="reportdata" ><%=strMealId%></td>
        </tr>
        <tr>
          <td height="0" colspan="4" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.global.itineraryinfo",strsesLanguage) %> <!--<A href="#" onClick="openModificationDetails('<%//=strTravelId%>','ItineraryInfo','')"><%//=strModificationLink%></A>--></td>
        </tr>
		<tr>
			<td height="0" class="reportCaption"><%=dbLabelBean.getLabel("label.global.forwardjourney",strsesLanguage) %></td>
			<td height="0" class="reportCaption"></td>
			<td height="0" class="reportCaption"></td>
			<td height="0" class="reportCaption"></td>
		</tr>
		
        <tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage) %><span class="starcolour"><%=strTRAVEL_FROMCompare%></span></td>
          <td height="0" class="reportdata" ><%=strDepCity%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage) %><span class="starcolour"><%=strTRAVEL_TOCompare%></span></td>
          <td height="0" class="reportdata" ><%=strArrCity%></td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage) %><span class="starcolour"><%=strdepDateCompare%> </span></td>
          <td height="0" class="reportdata" ><%=strJTravelDate%></td>
		  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage) %> <span class="starcolour"><%=strTIMINGSCompare%></span></td>
          <td height="0" class="reportdata" ><%=strPreferTime1%></td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" ><!-- Mode --><%
          	//strTRAVEL_MODECompare
          %><span class="starcolour"></td>
          <td height="0" class="reportdata" ><%
          	//=strTravelMode1
          %></td>
		  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage) %><span class="starcolour"> <%=strMODE_NAMECompare%></span></td>
          <td height="0" class="reportdata" ><%=strNameOfAirline1%></td> 
        </tr>
        <tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.class",strsesLanguage) %><span class="starcolour"><%=strTRAVEL_CLASSCompare%></span></td>
          <td height="0" class="reportdata" ><%=strELIGIBILITY%></td>
		  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strSeatpreferredfwd%></td>
        </tr>

		<tr>
			<td height="0" class="reportCaption"><%=dbLabelBean.getLabel("label.global.returnjourney",strsesLanguage) %></td>
			<td height="0" class="reportCaption"></td>
			<td height="0" class="reportCaption"></td>
			<td height="0" class="reportCaption"></td>
		</tr>
        <tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage) %><span class="starcolour"><%=strTRAVEL_TOCompare%></span></td>
          <td height="0" class="reportdata" ><%=strRetrunDepCity%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage) %><span class="starcolour"><%=strReturnTravelCompare%></span></td>
          <td height="0" class="reportdata" ><%=strRetrunArrCity%></td>
        </tr>

	<%
		if (strReturnDate.equals("") || strReturnDate == null
				|| strReturnDate.equals("-")) {

			strReturnDate = "-";
			strPreferTime2 = "-";
			strTravelMode2 = "-";
			strNameOfAirline2 = "-";
			strELIGIBILITY2 = "-";
		}
	%>    
	
	
		<tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage) %><span class="starcolour"><%=strReturnTravelCompare%></span></td>
          <td height="0" class="reportdata" ><%=strReturnDate%></td>
		  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage) %><span class="starcolour"> <%=strReturnTIMINGSCompare%></span></td>
          <td height="0" class="reportdata" ><%=strPreferTime2%></td>
        </tr>
        <tr><!--  Code commented by shiv on 07 jan 2009 for not showing travel mode as requested by MATA  -->
          <td height="0" class="reportCaption" ><!--  Mode --><span class="starcolour"><%
          	//=strReturnTRAVEL_MODECompare
          %> </span></td>
          <td height="0" class="reportdata" ><%
          	//=strTravelMode2
          %></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage) %> <span class="starcolour"><%
          	//=strReturnMODE_NAMECompare
          %></span> </td>
          <td height="0" class="reportdata" ><%=strNameOfAirline2%></td>
        </tr>
		<tr>
           <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.class",strsesLanguage) %><span class="starcolour"> <%=strReturnTRAVEL_CLASSCompare%></span></td>
          <td height="0" class="reportdata" ><%=strELIGIBILITY2%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strSeatPrefferrtd%></td>
        </tr>
        
        <%
      //added by manoj chand on 29 march 2012 to show board members for smp case
		ResultSet rs5 = null;
			String strAppFlag = "";
			strSql ="select md.SHOW_APP_LVL_3 from M_DIVISION md inner join M_SITE ms	 on ms.DIV_ID=md.DIV_ID where ms.SITE_ID="+strSiteId;
			rs5 = dbConBean1.executeQuery(strSql);
			if (rs5.next()) {
				strAppFlag = rs5.getString(1);
			}
			rs5.close();
			if(strAppFlag.equalsIgnoreCase("Y")){
        %>
        
<!--  added by manoj chand on 28 nov 2012 to show total travel fare details -->
		<tr>
           <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.farecurrency",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strTotalFareCur%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.totalfareamount",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strTotalFareAmt%></td>
        </tr>
        <!-- end here -->
        <%} %>
        <tr>
          <td height="0" colspan="4" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.createrequest.passportdetails",strsesLanguage) %> &quot;<%=strUsername%>&quot; </td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.passportnumber",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strPassportNo%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.emigrationclearancerequired",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strEcnr%></td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strContactNo%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.permanentaddress",strsesLanguage) %>&nbsp;</td>
          <td height="0" class="reportdata" ><%=strAddress%></td>
        </tr>
        <tr>
          
		  <!-- Code Added -->
		  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.frequentflyerdetails",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strAirLineName%> - <%=strFFNumber%>&nbsp;</td> 
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.currentaddress",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strCurrentAddress%></td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" >&nbsp;</td>
          <td height="0" class="reportdata" ><%=strAirLineName1%> - <%=strFFNumber1%>&nbsp;</td>
          <td height="0" class="reportCaption" >&nbsp;</td>
          <td height="0" class="reportdata" >&nbsp;</td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" >&nbsp;</td>
          <td height="0" class="reportdata" ><%=strAirLineName2%> - <%=strFFNumber2%>&nbsp;</td>
          <td height="0" class="reportCaption" >&nbsp;</td>
          <td height="0" class="reportdata" >&nbsp;</td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.user.nationality",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strNationality%></td>
          <td height="0" class="reportCaption" ></td>
          <td height="0" class="reportdata" ></td>
        </tr>
		<tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strPlaceIssue%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strDateIssue%></td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.dob",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strDateofBirth%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strExpiryDate%></td>
        </tr>

		 <!-- Code ends -->
        <!--<tr>
          <td height="0" colspan="4" class="reportSubHeading" >Visa Information </td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" >Visa Required </td>
          <td height="0" class="reportdata" ><%//=strVisaRequired%></td>
          <td height="0" class="reportCaption" >Visa Comments</td>
          <td height="0" class="reportdata" ><%//=strVisaComment%></td>

        </tr>-->
        <tr>
          <td height="0" colspan="4" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.requestdetails.insuranceinformation",strsesLanguage) %> <!--<A href="#" onClick="openModificationDetails('<%//=strTravelId%>','InsuranceInfo','')"><%//=strModificationLink%></A>--></td>
        </tr>
        <tr>

          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.travelinsurancerequired",strsesLanguage) %><span class="starcolour"><%=strInsuranceCompare%></span></td>
          <td height="0" class="reportdata" ><%=strInsuranceRequired%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.nominee",strsesLanguage) %><span class="starcolour"><%=strInsuranceNomineeCompare%></span></td>
          <td height="0" class="reportdata" ><%=strNominee%></td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.relation",strsesLanguage) %><span class="starcolour"><%=strInsurancerRelationCompare%></span></td>
          <td height="0" class="reportdata" ><%=strRelation%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.requestdetails.insurancecomments",strsesLanguage) %><span class="starcolour"><%=strInsuranceCommentsCompare%></span></td>
          <td height="0" class="reportdata" ><%=strInsuranceComment%></td>
        </tr>
        <tr>
          <td height="0" colspan="4" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.requestdetails.accomodationinformation",strsesLanguage) %> <!--<A href="#" onClick="openModificationDetails('<%//=strTravelId%>','AccomodationInfo','')"><%//=strModificationLink%></A>--></td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.staytype",strsesLanguage) %> <span class="starcolour"><%=strHotelRequiredCompare%></span></td>
          <td height="0" class="reportdata" ><%=strHotelRequired%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage) %><span class="starcolour"></span></td>
          <td height="0" class="reportdata" ><%=strPlace%></td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.budget",strsesLanguage) %><span class="starcolour"><%=strHotelBudgetCompare%></span></td>
          <td height="0" class="reportdata" ><%=strHotelBudget%></td>          
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage) %><span class="starcolour"><%=strBudgetCompare%></span> </td>
          <td height="0" class="reportdata" ><%=strBudgetCurrency%></td>
        </tr>
		<tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage) %><span class="starcolour"> <%=strCheckinCompare%></span></td>
          <td height="0" class="reportdata" ><%=strCheckInDate%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage) %> <span class="starcolour"><%=strCheckoutCompare%></span></td>
          <td height="0" class="reportdata" ><%=strCheckOutDate%></td>
        </tr>
		<tr>
		  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage) %> <span class="starcolour"><%=strRemarksCompare%></span></td>
          <td height="0" class="reportdata" ><%=strRemarks%></td>
          <td height="0" class="reportCaption" > <span class="starcolour"></span></td>
          <td height="0" class="reportdata" ></td>
        </tr>
		<%
			ResultSet rs3 = null;
			String strRoleinfo = "";
			strSql = "SELECT ROLE_ID FROM M_USERINFO WHERE USERID = "
					+ Suser_id + " AND APPLICATION_ID =1 AND STATUS_ID=10";
			rs3 = dbConBean1.executeQuery(strSql);
			while (rs3.next()) {
				strRoleinfo = rs3.getString(1);
				//System.out.println("strRoleinfo "+strRoleinfo);
			}
			rs3.close();
			dbConBean1.close();
			//System.out.println("Suser_id "+Suser_id +"strCUserId "+strCUserId); 
			if ((!strCARD_HOLDER_NAME.trim().equals(""))
					&& strCUserId.equals(Suser_id)) {
		%>
			
					<tr>
			          <td height="0" colspan="4" class="reportSubHeading"><%=dbLabelBean.getLabel("label.global.creditcardinfo",strsesLanguage) %> <!--<A href="#" onClick="openModificationDetails('<%//=strTravelId%>','CreditCardInfo','')"><%//=strModificationLink%></A>--></td>
			        </tr>
			        <tr>
			          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.cardtype",strsesLanguage) %><span class="starcolour"> <%=strCardTypeCompare%></span> </td>
					  <%
					  	if (strCARD_TYPE.equals("-1")) // if credit card option not selected
					  		{
					  			strCARD_TYPE = "-";
					  			strCreditCardNumber = "-";
					  			strCARD_EXP_DATE = "-";
					  			strCVV_NUMBER = "-";
					  		}
					  %>
			          <td height="0" class="reportdata" ><%=strCARD_TYPE%>&nbsp;</td>
			          <td height="0" class="reportCaption" ><!-- Credit Card Number  --><%=dbLabelBean.getLabel("label.global.creditcardholder",strsesLanguage) %><span class="starcolour"><%=strCardNumberCompare%></span> </td>
			          <td height="0" class="reportdata" ><%=strCARD_HOLDER_NAME%>&nbsp;</td> 
			        </tr>
			        <tr>
			          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.expirydate",strsesLanguage) %> <span class="starcolour"><%=strCardExpiryCompare%></span></td>
			          <td height="0" class="reportdata" ><%=strCARD_EXP_DATE%>&nbsp;</td>
			         
					  
					  
			           <td height="0" class="reportCaption" ><!-- Card Holder Name  --></td>
			          <td height="0" colspan="2" class="reportdata" ><%
			          	//=strCARD_HOLDER_NAME
			          %></td>  
			          
			        </tr>
	        
	         <%
	        	         	}
	        	         %>

<%
	//When billing client is  not self then manager and hod will be shown
	if (strBilling_Client != null && !strBilling_Client.equals("self")) {
%>
        <tr>
          <td height="0" colspan="4" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.requestdetails.approvallevel",strsesLanguage) %></td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage) %> </td>
          <td height="0" class="reportdata" ><%=strManager%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage) %> </td>
          <td height="0" class="reportdata" ><%=strHod%></td>
        </tr>
<%
	}
	// if approval level 1 and 2 has been skip then the reason for skipping will be shown
	//	if(strSelectManagerRadio != null && strSelectManagerRadio.equals("skip"))
	//	{
		
			if(strAppFlag.equalsIgnoreCase("Y")){
%>
<tr>
 		  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.boardmember",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strBoardMemberId%></td>  
		  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.reasonforskipping",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strReasonForSkip%></td>          
		<tr>

<%}else{ %>
		<tr>
		  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.reasonforskipping",strsesLanguage) %></td>
          <td height="0" colspan="3" class="reportdata" ><%=strReasonForSkip%></td>          
		<tr>
<%}
	//	}
%>
        <!--<tr>
          <td height="0" colspan="4" class="reportSubHeading" >Issue Details </td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" >Place of Issue</td>
          <td height="0" class="reportdata" ><%//=strPlaceIssue%></td>
          <td height="0" class="reportCaption" >Date of Issue</td>
          <td height="0" class="reportdata" ><%//=strDateIssue%></td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" >Date Of Birth</td>
          <td height="0" class="reportdata" ><%//=strDateofBirth%></td>
          <td height="0" class="reportCaption" >Date of Expiry</td>
          <td height="0" class="reportdata" ><%//=strExpiryDate%></td>
        </tr>-->
        <tr>
          <td height="0" colspan="4" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.requestdetails.forexdetails",strsesLanguage) %> <!--<A href="#" onClick="openModificationDetails('<%//=strTravelId%>','ForexInfo','')"><%//=strForexModificationLink%></A>--> </td>
        </tr>
		<%
			if (strBilling_Client == null) {
				strBilling_Client = "-";
			}
		%>
        <tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage) %><span class="starcolour"> <%=strTOTAL_HOTEL_BUDGETCompare%></span></td>
          <td height="0" class="reportdata" ><%=strExpenditure%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.requestdetails.billingclient",strsesLanguage) %> </td>
          <td height="0" class="reportdata" ><%=strBilling_Client%></td>
        </tr>
                    <!--//added by shiv on 3/28/2007 open  --> 
		 <tr>
           <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.requestdetails.remarksforexpendituredetails",strsesLanguage) %> </td>
          <td height="0" class="reportdata" > <%=strExpRemark%> </td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.requestdetails.billingapprover",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strBillingApprover %></td> 
        </tr>
        <!--//added by shiv on 3/28/2007 close  -->

        
        <%if (strSHOW_BUD_INPUT.equalsIgnoreCase("Y")) { %>
        <!--//added by Pankaj Dubey on 17 Nov 2010 starts-->
        <tr>
          <td height="0" colspan="4" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.global.budgetactualdetails",strsesLanguage) %> </td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.ytmbudget",strsesLanguage) %></td>
          <td height="0" class="reportdata" ><%=strYTM_BUDGET%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.ytdactual",strsesLanguage) %> </td>
          <td height="0" class="reportdata" ><%=strYTD_ACTUAL%></td>
        </tr>
		<tr>
           <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.availablebudget",strsesLanguage) %> </td>
          <td height="0" class="reportdata" ><%=strAVAIL_BUDGET%> </td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.estimatedexpenditure",strsesLanguage) %> </td>
          <td height="0" class="reportdata" ><%=strEST_EXP%></td> 
        </tr>
		<tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage) %> </td>
          <td height="0" class="reportdata" ><%=strEXP_REMARKS%></td>
          <td height="0" class="reportCaption" >&nbsp; </td>
          <td height="0" class="reportdata" >&nbsp;</td> 
        </tr>
        <!--//added by Pankaj Dubey on 17 Nov 2010 ends  -->             

	<%} %>

		<tr>
          <td height="0" colspan="4" class="reportSubHeading"><%=dbLabelBean.getLabel("label.requestdetails.currencydenominationdetails",strsesLanguage) %></td>
        </tr>
		<tr>
          <td height="0" colspan="4" class="reportCaption"><%=strCashBreakUpRemark%></td>
        </tr> 

<!-- Bifurcation details hile through the <span style="display:none"> tag rather this details we will show only the the Currency Denomination Remarks -->
   
		<tr>
          <td height="0" colspan="4" class="reportSubHeading"><span style="display:none"><%=dbLabelBean.getLabel("label.requestdetails.bifurcationdetails",strsesLanguage) %></span></td>
        </tr>
<%
	int i = 0;
	Enumeration vEnum = vecTC.elements();
	while (vEnum.hasMoreElements()) {
		i++;
%>
		<tr>
	   <%
	   	if (i == 1) {
	   %>
          <td height="0" class="reportCaption" ><span style="display:none"><%=dbLabelBean.getLabel("label.global.travellerscheque",strsesLanguage) %> <span class="starcolour"><%=strForexCompare%></span></span></td>
	   <%
	   	} else {
	   %>
	      <td height="0" class="reportCaption" ></td>
	   <%
	   	}
	   %> 
          <td height="0" class="reportdata" ><span style="display:none"><%=i%>.&nbsp;<%=vEnum.nextElement()%> <%=vEnum.nextElement()%></span></td>
          <td height="0" class="reportCaption" ></td>
          <td height="0" class="reportdata" ></td>
        </tr>
<%
	}
	i = 0;
	vEnum = vecCash.elements();
	while (vEnum.hasMoreElements()) {
		i++;
%>
        <tr>
       <%
       	if (i == 1) {
       %>
          <td height="0" class="reportCaption" ><span style="display:none"><%=dbLabelBean.getLabel("label.global.cash",strsesLanguage) %></span></td>
	   <%
	   	} else {
	   %>
	      <td height="0" class="reportCaption" ></td>
	   <%
	   	}
	   %>           
	      <td height="0" class="reportdata" ><span style="display:none"><%=i%>.&nbsp;<%=vEnum.nextElement()%> <%=vEnum.nextElement()%></span></td>
          <td height="0" class="reportCaption" >&nbsp;</td>
          <td height="0" class="reportdata" ></td>
        </tr>
<%
	}
%>
<!-- Not in User End -->               

   

        <tr>
          <td height="0" colspan="4" class="reportHeading" >&nbsp;</td>
        </tr>

		<%
			ResultSet rs4 = null;
			strSql = "SELECT TRAVEL_STATUS_ID FROM  T_TRAVEL_STATUS WHERE  (TRAVEL_ID = "
					+ strTravelId
					+ ") AND (TRAVEL_TYPE = 'i')";
			String strTravelstatus = "";
			rs4 = dbConBean2.executeQuery(strSql);
			while (rs4.next()) {
				strTravelstatus = rs4.getString("TRAVEL_STATUS_ID");
			}
			rs4.close();

			if (strTravelstatus.equals("10")) {
		%>
       <!-- added link for Learms page for showing deatils of lerms after all approveral on 29 jan 2009 -->
		 <tr class="formhead">
          <td height="0" colspan="4" class="listhead"   >&nbsp;<a href="#" class="reportLink" onClick="MM_openBrWindow('reqlermsDetails.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=I','Attachments','scrollbars=yes,resizable=yes,width=650,height=600')"><%=dbLabelBean.getLabel("label.requestdetails.clickheretoopenlermsdetail",strsesLanguage) %></td>

        </tr>
        <%
        	}
        %>
      </table>
	</td>
  </tr>
</table>
</body>
</html>
