 <%
/***************************************************
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
 *Modification 			:Add Place Information. Change the different type of information like Forward Journey, Return Journey, Stay Type etc.
                                :Query changed  by shiv on 26-Oct-07 for  preferred  time on 26-Oct-07 
								:Change the code for showing billing client in  different  cases by shiv  Sharma on 06-Nov-07 
								:Code change for showing Email ID of traveller in reports that appear to MATA on 4th jan 2008  
								:Query Changed by shiv   on 20-May-08 
								:Making approver comment bold  if he change the comment on 03-04-2009 by shiv sharma   
								:Commented Credit card no as it is not required  to show any user on 10-03-2010 by shiv sharma 
								


 *Reason of Modification:change suggested by MATA
 *Date of Modification  :19-02-2007 
 *Modified By	        :SACHIN GUPTA
 *Revision 		        :Added Employee  Code  on date 3/1/2007 
                                 by shiv Sharma
  
*Modified By			:Pankaj Dubey
*Date of Modification	:26 August 2011
*Modification			:Show foreign exchange remarks to mata page.                                 
  *Editor					:Editplus
  
  *Modified By			: Manoj Chand
  *Modification 		: Correct the spelling of Expenditure detail remarks
  *Date of Modification	: 30 July 2012
  
  *Modified by			:Manoj Chand
  *Date of Modification	:01 Feb 2013
  *Modification			:showing requested value in comma separated way if multiple currency exist in the request.
 *******************************************************/
%>
<%@ page  pageEncoding="UTF-8"%>
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
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="JavaScript1.2" src="scripts/div.js?buildstamp=2_0_0"></script>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<style>
.linkedReq {
font-family:Verdana, Arial, Helvetica, sans-serif;
font-size:10px;
font-weight:bold;
color:#d62234;
}
</style>
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

<style type="text/css">
<!--
.style2 {font-size: 10px; font-weight: bold; color: #FF7D00;}
-->
</style> 
<%
//Global Variables declared and initialized
String strSql                   =  null;              
ResultSet rs,rs1,rs2            =  null;   
// variables from userinfo table start
String strUsername				="";
String strPassportNo			="";
String strDateIssue				="";
String strPlaceIssue			="";
String strExpiryDate			="";
String strAddress				="";
String strContactNo				="";
String strFFNumber				="";
String strFFNumber1				="";
String strFFNumber2				="";


//new 16-02-2007
String strCurrentAddress	=	"";
String strAirLineName		=	"";
String strAirLineName1		=	"";
String strAirLineName2		=	"";

//


String strDateofBirth			="";
String strCompanyName			="";
String strEcnr					="";
String strDesignationName		="";
String strTotal_Currency		="";

//variables from userinfo end


String strSiteId                =  "";
String strSiteName              =  "";
String strUserId                =  "";
String strDivId                 =  "";
String strDeptId                =  "";
String strDesigName             =  "";
String strAge                   =  "";
String strAge1                  =  "";                 
String strSex                   =  "";
String strMessage               =  "";

String strUserNameId            =  "";  
String strSiteNameId            =  "";
String strDesigNameId           =  "";   
String strMealId                =  ""; 
String strVisaRequired          =  "";
String strVisaComment           =  "";


String strDepCity               =  "";                              
String strDepDate               =  "";                              
String strArrCity               =  "";


String strRetrunDepCity			=  "";
String strRetrunArrCity			=  "";


String strReturnDate            =  "";                                 
String strNameOfAirline1        =  "";
String strNameOfAirline2        =  "";
String strInsuranceRequired     =  "";
String strNominee               =  ""; 
String strRelation              =  ""; 
String strInsuranceComment      =  "";
String strHotelRequired         =  "";
String strBudgetCurrency        =  "";
String strHotelBudget           =  "";
String strRemarks               =  "";
String strCheckInDate           =  "";
String strCheckOutDate          =  "";

//19-02-2007 sachin
String strPlace                 =  "";
//

String strTravelMode1           =  "";
String strTravelMode2           =  "";
String strTravelClass1          =  "";
String strTravelClass2          =  "";
String strManager               =  ""; 
String strHod                   =  ""; 
String strSelectManagerRadio    =  ""; 
String strPreferTime1           =  "";
String strPreferTime2           =  "";
String strTravelReqId           =  "";
String strTravelId				=  "";
String strTravelReqNo           =  "";  
String strJTravelDate			="";
String strELIGIBILITY			=""; // for journey
String strELIGIBILITY2			=""; // for return journey


// start Variable Declaration for Forex Details
String strTotal_Amount = "";
String strBilling_Client="";

String strTravellerCheque       =  "";
String strTravellerCheque1      =  "";
String strTravellerCheque2      =  "";
String strTCCurrency            =  "";
String strTCCurrency1           =  "";
String strTCCurrency2           =  "";
String strCashAmount            =  "";
String strCashCurrency          =  "";
Vector vecCash                  =  new Vector(); 
Vector vecTC                    =  new Vector(); 

String strCashBreakUpRemark     =  "";
String strCancelledReqId	    =  "0";

strTravelId = request.getParameter("purchaseRequisitionId"); //getting travel id from the previous page

String strTravellerId  =   request.getParameter("traveller_Id");

//CODE STARTS

String strCARD_TYPE  ="";

//23022007
String strCARD_HOLDER_NAME ="";
String strReasonForTravel = "";
//23022007
String strCARD_NUMBER1 ="";
String strCARD_NUMBER2 ="";
String strCARD_NUMBER3 ="";
String strCARD_NUMBER4 ="";
String strCVV_NUMBER ="";
String strCARD_EXP_DATE ="";
String strCreditCardNumber="";
String strApproverRole="";
String strOriginatorName="";

String strCUserId = "";

String strReasonForSkip  = "";
String strEmpcode="";
String strBilling_site=""; ///added new  on 02-Nov-07 by shiv Sharma 
String strEmail="";

//CODE ENDS

//strSql = "SELECT TRAVEL_REQ_NO, ISNULL(TRAVEL_REQ_ID,'-') AS TRAVEL_REQ_ID , ISNULL(RTRIM(.DBO.USER_NAME(C_USERID)),'NA') AS ORIGINATED_BY,C_USERID,ISNULL(dbo.SITENAME_FROM_USERID(C_USERID),'-') AS UNIT, ISNULL(TRAVELLER_ID,'-') AS TRAVELLER_ID ,ISNULL(AGE,'-') AS AGE ,ISNULL(SEX,'-') AS SEX,ISNULL(dbo.MEAL_NAME(MEAL),'-') AS  MEALNAME,ISNULL(VISA_REQUIRED,'-') AS VISA_REQUIRED,ISNULL(VISA_COMMENT,'-') AS VISA_COMMENT, ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE),'-')AS TRAVEL_DATE, ISNULL(INSURANCE_REQUIRED,'-') AS INSURANCE_REQUIRED,ISNULL(NOMINEE,'-') AS NOMINEE, ISNULL(RELATION,'-') AS RELATION, ISNULL(INSURANCE_COMMENTS,'-') AS INSURANCE_COMMENTS, ISNULL(HOTEL_REQUIRED,'-') AS HOTEL_REQUIRED,ISNULL(RTRIM(LTRIM(BUDGET_CURRENCY)),'-') AS BUDGET_CURRENCY , ISNULL(RTRIM(LTRIM(HOTEL_BUDGET)),'-') AS HOTEL_BUDGET, ISNULL(REMARKS,'-') AS REMARKS, LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CHECK_IN_DATE),'-'))) AS CHECK_IN_DATE , LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CHECK_OUT_DATE),'-'))) AS CHECK_OUT_DATE, ISNULL(PLACE,'-') AS PLACE, ISNULL(RTRIM(LTRIM(APPROVER_SELECTION)),'-') AS APPROVER_SELECTION, MANAGER_ID,HOD_ID, LTRIM(RTRIM(ISNULL(CARD_TYPE,''))) AS CARD_TYPE,LTRIM(RTRIM(ISNULL(CARD_NUMBER1,''))) AS CARD_NUMBER1,LTRIM(RTRIM(ISNULL(CARD_NUMBER2,''))) AS CARD_NUMBER2 ,LTRIM(RTRIM(ISNULL(CARD_NUMBER3,''))) AS CARD_NUMBER3, LTRIM(RTRIM(ISNULL(CARD_NUMBER4,''))) AS CARD_NUMBER4 ,LTRIM(RTRIM(ISNULL(CVV_NUMBER,''))) AS CVV_NUMBER,LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CARD_EXP_DATE),''))) AS CARD_EXP_DATE, ISNULL(CONVERT(decimal(20,0),TOTAL_AMOUNT),'0') AS TOTAL_AMOUNT,ISNULL(TA_CURRENCY,'-') AS TA_CURRENCY,BILLING_SITE, BILLING_CLIENT, ISNULL(.DBO.TRAVEL_MODE(TRAVEL_ID,'I'),'-') AS TRAVEL_MODE,            ISNULL(RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE))),'-') AS TRAVELLER_CHEQUE,ISNULL(RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE1))),'-') AS TRAVELLER_CHEQUE1, ISNULL(RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE2))),'-') AS TRAVELLER_CHEQUE2,ISNULL(TC_CURRENCY,'-') AS TC_CURRENCY,ISNULL(TC_CURRENCY1,'-') AS TC_CURRENCY1,ISNULL(TC_CURRENCY2,'-') AS TC_CURRENCY2, ISNULL(REASON_FOR_SKIP,'-') AS REASON_FOR_SKIP,ISNULL(CASH_BREAKUP_REMARKS,'-') AS CASH_BREAKUP_REMARKS ,ISNULL(CARD_HOLDER_NAME,'') AS CARD_HOLDER_NAME, ISNULL(REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL ,  isnull(EXPENDITURE_REMARKS,'') as EXPENDITURE_REMARKS FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="+strTravelId+" AND APPLICATION_ID=1 AND STATUS_ID=10";
//query changed by manoj chand on 01 feb 2013 to show total amount in multiple currency.
  strSql = "SELECT TRAVEL_REQ_NO, ISNULL(T_TRAVEL_DETAIL_INT.TRAVEL_REQ_ID,'-') AS TRAVEL_REQ_ID , ISNULL(RTRIM(.DBO.USER_NAME(C_USERID)),'NA') AS ORIGINATED_BY,C_USERID,ISNULL(dbo.SITENAME_FROM_USERID(C_USERID),'-') AS UNIT, ISNULL(TRAVELLER_ID,'-') AS TRAVELLER_ID ,ISNULL(AGE,'-') AS AGE ,ISNULL(SEX,'-') AS SEX,ISNULL(dbo.MEAL_NAME(MEAL),'-') AS  MEALNAME,ISNULL(VISA_REQUIRED,'-') AS VISA_REQUIRED,ISNULL(VISA_COMMENT,'-') AS VISA_COMMENT, ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE),'-')AS TRAVEL_DATE, ISNULL(INSURANCE_REQUIRED,'-') AS INSURANCE_REQUIRED,ISNULL(NOMINEE,'-') AS NOMINEE, ISNULL(RELATION,'-') AS RELATION, ISNULL(INSURANCE_COMMENTS,'-') AS INSURANCE_COMMENTS, ISNULL(HOTEL_REQUIRED,'-') AS HOTEL_REQUIRED,ISNULL(RTRIM(LTRIM(BUDGET_CURRENCY)),'-') AS BUDGET_CURRENCY , ISNULL(RTRIM(LTRIM(HOTEL_BUDGET)),'-') AS HOTEL_BUDGET, ISNULL(REMARKS,'-') AS REMARKS, LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CHECK_IN_DATE),'-'))) AS CHECK_IN_DATE , LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CHECK_OUT_DATE),'-'))) AS CHECK_OUT_DATE, ISNULL(PLACE,'-') AS PLACE, ISNULL(RTRIM(LTRIM(APPROVER_SELECTION)),'-') AS APPROVER_SELECTION, MANAGER_ID,HOD_ID, LTRIM(RTRIM(ISNULL(CARD_TYPE,''))) AS CARD_TYPE,LTRIM(RTRIM(ISNULL(CARD_NUMBER1,''))) AS CARD_NUMBER1,LTRIM(RTRIM(ISNULL(CARD_NUMBER2,''))) AS CARD_NUMBER2 ,LTRIM(RTRIM(ISNULL(CARD_NUMBER3,''))) AS CARD_NUMBER3, LTRIM(RTRIM(ISNULL(CARD_NUMBER4,''))) AS CARD_NUMBER4 ,LTRIM(RTRIM(ISNULL(CVV_NUMBER,''))) AS CVV_NUMBER,LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CARD_EXP_DATE),''))) AS CARD_EXP_DATE, dbo.FN_GET_EXPENDITURE('"+strTravelId+"','I') AS Expenditure,BILLING_SITE, BILLING_CLIENT, ISNULL(.DBO.TRAVEL_MODE(T_TRAVEL_DETAIL_INT.TRAVEL_ID,'I'),'-') AS TRAVEL_MODE,            ISNULL(RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE))),'-') AS TRAVELLER_CHEQUE,ISNULL(RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE1))),'-') AS TRAVELLER_CHEQUE1, ISNULL(RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE2))),'-') AS TRAVELLER_CHEQUE2,ISNULL(TC_CURRENCY,'-') AS TC_CURRENCY,ISNULL(TC_CURRENCY1,'-') AS TC_CURRENCY1,ISNULL(TC_CURRENCY2,'-') AS TC_CURRENCY2, ISNULL(REASON_FOR_SKIP,'-') AS REASON_FOR_SKIP,ISNULL(CASH_BREAKUP_REMARKS,'-') AS CASH_BREAKUP_REMARKS ,ISNULL(CARD_HOLDER_NAME,'') AS CARD_HOLDER_NAME, ISNULL(REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL ,  isnull(EXPENDITURE_REMARKS,'') as EXPENDITURE_REMARKS, T_TRAVEL_STATUS.LINKED_TRAVEL_ID FROM T_TRAVEL_DETAIL_INT INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_STATUS.TRAVEL_ID=T_TRAVEL_DETAIL_INT.TRAVEL_ID AND T_TRAVEL_STATUS.TRAVEL_TYPE='I' WHERE T_TRAVEL_DETAIL_INT.TRAVEL_ID="+strTravelId+" AND T_TRAVEL_DETAIL_INT.APPLICATION_ID=1 AND T_TRAVEL_DETAIL_INT.STATUS_ID=10";
//System.out.println("sql Str===2222222222=1==="+strSql);	
rs       =   dbConBean.executeQuery(strSql);
String strEXPENDITURE_REMARKS  = "";
if(rs.next())
{
		
	    strTravelReqNo       = rs.getString("TRAVEL_REQ_NO"); 
		strTravelReqId       = rs.getString("TRAVEL_REQ_ID");
		strOriginatorName    = rs.getString("ORIGINATED_BY");
		strCUserId           = rs.getString("C_USERID");
		strSiteName            = rs.getString("UNIT");
		strUserId            = rs.getString("TRAVELLER_ID");
		strAge1              = rs.getString("AGE");
		strSex               = rs.getString("SEX");
		if(strSex.equals("1"))
		{
		strSex="Male";
		}
		else
		{
		strSex="Female";
		}
		strMealId            = rs.getString("MEALNAME");
		strVisaRequired      = rs.getString("VISA_REQUIRED");

		//System.out.println("strVisaRequired====="+strVisaRequired);
		if(strVisaRequired!=null)
		{
				if(strVisaRequired.trim().equals("1"))
				{
				strVisaRequired="Yes";
				}
				else
				{
				strVisaRequired="No";
				}
		}
		strVisaComment       = rs.getString("VISA_COMMENT");
		strDepDate           = rs.getString("TRAVEL_DATE");
        strInsuranceRequired = rs.getString("INSURANCE_REQUIRED");  
		if(strInsuranceRequired!=null)
		{
			if(strInsuranceRequired.trim().equals("1"))
			{
			strInsuranceRequired="Yes";
			}
			else
			{
			strInsuranceRequired="No";
			}
		}
		strNominee           = rs.getString("NOMINEE");   
		strRelation          = rs.getString("RELATION");   
        strInsuranceComment  = rs.getString("INSURANCE_COMMENTS");   
		strHotelRequired     = rs.getString("HOTEL_REQUIRED");
        strBudgetCurrency    = rs.getString("BUDGET_CURRENCY");     
        strHotelBudget       = rs.getString("HOTEL_BUDGET");     

		if(strHotelRequired!=null)
		{
			if(strHotelRequired.trim().equals("1"))
			{
			strHotelRequired="Hotel";
			}
			else if(strHotelRequired.trim().equals("2"))
			{
				strHotelRequired="Transit House";
				if(strHotelBudget .equals("-") || strHotelBudget.equals("") || strHotelBudget.equals("0"))
				{
					strHotelBudget = "-";
					strBudgetCurrency = "-";
				}

			}
			else
			{
			strHotelRequired="No";
			}
		}
		strRemarks           = rs.getString("REMARKS");     
		if(strRemarks == null || strRemarks.equals(""))
		{
			strRemarks = "-";
		}
		strCheckInDate       = rs.getString("CHECK_IN_DATE");
		strCheckOutDate      = rs.getString("CHECK_OUT_DATE");
// 19-02-2007 SACHIN
		strPlace             = rs.getString("PLACE"); 
//

		strSelectManagerRadio  = rs.getString("APPROVER_SELECTION"); 
		strManager		= rs.getString("MANAGER_ID");
		strHod			= rs.getString("HOD_ID");
		strCARD_TYPE		 = rs.getString("CARD_TYPE");
		strCARD_NUMBER1		 = rs.getString("CARD_NUMBER1");
		strCARD_NUMBER2		 = rs.getString("CARD_NUMBER2");
		strCARD_NUMBER3		 = rs.getString("CARD_NUMBER3");
		strCARD_NUMBER4		 = rs.getString("CARD_NUMBER4");
		strCVV_NUMBER		 = rs.getString("CVV_NUMBER");
		strCARD_EXP_DATE	 = rs.getString("CARD_EXP_DATE");
		strCreditCardNumber=strCARD_NUMBER1+" "+strCARD_NUMBER2 +" "+strCARD_NUMBER3+" "+strCARD_NUMBER4;
		//getting details for  forex
		strTotal_Amount = rs.getString("Expenditure");
		//strTotal_Currency = rs.getString("TA_CURRENCY");
		/*if(strTotal_Amount != null && strTotal_Amount.equals("0"))
		{
			strTotal_Amount   = "-";
            strTotal_Currency = ""; 
		}*/
		strBilling_site=rs.getString("BILLING_SITE");
		strBilling_Client=rs.getString("BILLING_CLIENT");

		strTravellerCheque    = rs.getString("TRAVELLER_CHEQUE"); 
		strTravellerCheque1   = rs.getString("TRAVELLER_CHEQUE1"); 
		strTravellerCheque2   = rs.getString("TRAVELLER_CHEQUE2"); 
		strTCCurrency         = rs.getString("TC_CURRENCY");  
		strTCCurrency1        = rs.getString("TC_CURRENCY1");  
		strTCCurrency2        = rs.getString("TC_CURRENCY2");  
		if(strTravellerCheque != null && !strTravellerCheque.equals("0") && !strTravellerCheque.equals("0.0") && !strTravellerCheque.equals("-"))
		{
		  vecTC.addElement(strTCCurrency);
		  vecTC.addElement(strTravellerCheque);
		}
		if(strTravellerCheque1 != null && !strTravellerCheque1.equals("0") && !strTravellerCheque1.equals("0.0")&& !strTravellerCheque1.equals("-"))
		{
		  vecTC.addElement(strTCCurrency1);
		  vecTC.addElement(strTravellerCheque1);
		}
		if(strTravellerCheque2 != null && !strTravellerCheque2.equals("0") && !strTravellerCheque2.equals("0.0")&& !strTravellerCheque2.equals("-"))
		{
		  vecTC.addElement(strTCCurrency2);
		  vecTC.addElement(strTravellerCheque2);
		}

		strReasonForSkip     = rs.getString("REASON_FOR_SKIP");
		strCashBreakUpRemark = rs.getString("CASH_BREAKUP_REMARKS");


		//23022007
		strCARD_HOLDER_NAME= rs.getString("CARD_HOLDER_NAME");
		strReasonForTravel  = rs.getString("REASON_FOR_TRAVEL");
		strEXPENDITURE_REMARKS = rs.getString("EXPENDITURE_REMARKS") ;
		//23022007
		strCancelledReqId = rs.getString("LINKED_TRAVEL_ID");
		
}
rs.close();

//code added
	
if(strCARD_TYPE.equals("0"))
{
	strCARD_TYPE="Visa";
}
if(strCARD_TYPE.equals("1"))
{
	strCARD_TYPE="Master";
}
//code ends


//Code for getting the cash Breakup info 
strSql= "SELECT CASH_CURRENCY, ISNULL(RTRIM(LTRIM(convert(decimal(20,0),CASH_AMOUNT))),'-') AS CASH_AMOUNT FROM T_CASH_BREAKUP_INT WHERE TRAVEL_ID="+strTravelId+" AND APPLICATION_ID=1";

     rs       =   dbConBean.executeQuery(strSql);  
    while(rs.next())
    {
		vecCash.addElement(rs.getString("CASH_CURRENCY"));
		vecCash.addElement(rs.getString("CASH_AMOUNT"));
	}
	rs.close();



////added new by shiv on 02-Nov-07
if (strBilling_site!=null && !strBilling_site.equals("0") && !strBilling_site.equals("-1")) 
///normal case  when user site is biling site  
{
  
        if(strBilling_Client ==null)
                  {
                    strBilling_Client ="--";
                    }
                 else{				 //Query Changed by shiv   on 20-May-08  
						int intBilling_Client =Integer.parseInt(strBilling_Client);  

						strSql = "select site_name from m_site where site_id=(select billing_site from t_travel_detail_int where TRAVEL_ID="+strTravelId+")"; 
						/* 	strSql = "select site_name from m_site where site_id=(select site_id from m_userinfo  where USERID="+intBilling_Client+")";
                         */
			rs       =   dbConBean.executeQuery(strSql);  
			while(rs.next())
			{
				strBilling_Client = rs.getString("site_name");
			}
			rs.close();
		}
}
//code added

//Code starts  if strBilling client is null,means the site is paying for it 
//code changed for showing billing site on 02-Nov-07 by shiv  

if((strBilling_Client==null) || (strBilling_Client.equals("")) || strBilling_Client.equals("-") || strBilling_Client.equals("-1"))
{
	strSql = "select site_name from m_site where site_id=(select billing_site from t_travel_detail_int where TRAVEL_ID="+strTravelId+")";

	rs       =   dbConBean.executeQuery(strSql);  
	while(rs.next())
	{
		strBilling_Client = rs.getString("site_name");
	}
	rs.close();
}


 
/*
if(strBilling_Client == null)
{
    strBilling_Client  =  "-";
}
*/
//Code ends if strBilling client is null,means the site is paying for it 


if(strSelectManagerRadio != null && strSelectManagerRadio.equals("manual"))
{
     
	// getting value form m_userinfo for hod and pm
	if(strManager != null && !strManager.equals("null") && !strManager.equals("") )
	{
		strSql ="select dbo.user_name("+strManager+")";
		rs       =   dbConBean.executeQuery(strSql);  
		while(rs.next())
		{
		  strManager = rs.getString(1);
		}
		rs.close();
	}
	else
	{
		strManager = "-";
	}

	if(strHod != null && !strHod.equals("null") && !strHod.equals("") )
	{
		strSql ="select dbo.user_name("+strHod+")";
		rs = dbConBean.executeQuery(strSql);
		while(rs.next())
		{
			strHod = rs.getString(1);
		}
		rs.close();
	}
	else
	{
		strHod = "-";
	}
}
// if hod is selected is automatically
if(strSelectManagerRadio != null && strSelectManagerRadio.equals("automatic"))
{
	strManager="Manager selected automatically ";
	strHod="HOD selected automatically";
}
else if(strSelectManagerRadio != null && strSelectManagerRadio.equals("skip"))
{
	strManager = "skip";
	strHod = "skip";
}
//  closed code for hod and manager who are selected automatically

//when billing client is self then no manager and no hod
if(strBilling_Client != null && strBilling_Client.equals("self"))
{
  strManager = "-";
  strHod = "-";
}

//getting value from m_userinfo closed

strSql = "select ISNULL(dbo.user_name(userid),'-')AS USERNAME,ISNULL(PASSPORT_NO,'-')AS PASSPORT_NO,ISNULL(dbo.CONVERTDATEDMY1(DATE_ISSUE),'-') AS DATE_ISSUE,ISNULL(PLACE_ISSUE,'-') AS PLACE_ISSUE,ISNULL(dbo.CONVERTDATEDMY1(EXPIRY_DATE),'-') AS EXPIRY_DATE,ISNULL(ADDRESS,'-') AS ADDRESS ,ISNULL(CONTACT_NUMBER,'-') AS CONTACT_NUMBER,ISNULL(FF_NUMBER,'-') AS FF_NUMBER,ISNULL(FF_NUMBER1,'-') AS FF_NUMBER1,ISNULL(FF_NUMBER2,'-') AS FF_NUMBER2,ISNULL(dbo.CONVERTDATEDMY1(DOB),'-')AS DOB,ISNULL(dbo.SITENAME(SITE_ID),'-')AS COMPANYNAME,ISNULL(ECNR,'-') AS ECNR,ISNULL(dbo.DESIG_FROM_USERID(userid),'-') AS DESIGNAME,    ISNULL(CURRENT_ADDRESS,'') AS CURRENT_ADDRESS, ISNULL(FF_AIR_NAME,'') AS FF_AIR_NAME, ISNULL(FF_AIR_NAME1,'') AS FF_AIR_NAME1, ISNULL(FF_AIR_NAME2,'') AS FF_AIR_NAME2 ,ISNULL(EMP_CODE,'') AS EMP_CODE,EMAIL from m_userinfo  where userid ='"+strUserId+"'";  // on the basis of traveller id 





//System.out.println("sql Str====3==="+strSql);	


rs       =   dbConBean.executeQuery(strSql);  
if(rs.next())
{
strUsername = rs.getString("USERNAME");
// code startto convert first and last letter in uppercase
int s = strUsername.indexOf(" ",0);
String FirstLetter = strUsername.substring(0,1).toUpperCase() + strUsername.substring(1,s);
String LastLetter = strUsername.substring(s+1,s+2).toUpperCase() +strUsername.substring(s+2,strUsername.length()) ;
strUsername = FirstLetter+" "+LastLetter;
// code ends to convert first and last letter in uppercase

strPassportNo = rs.getString("PASSPORT_NO");
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



if(strEcnr!=null)
{
	if(strEcnr.trim().equals("1"))
	{
	strEcnr="Yes";
	}
	else if(strEcnr.trim().equals("2"))
	{
	strEcnr="No";
	}
	else if(strEcnr.trim().equals("3"))
	{
	strEcnr="N/A";
	}
}
strDesignationName = rs.getString("DESIGNAME");

//NEW 16-02-2007 SACHIN
	strCurrentAddress	=	rs.getString("CURRENT_ADDRESS");
	strAirLineName		=	rs.getString("FF_AIR_NAME");
	strAirLineName1		=	rs.getString("FF_AIR_NAME1");
	strAirLineName2		=	rs.getString("FF_AIR_NAME2");
	//
		strEmpcode= rs.getString("EMP_CODE"); //Adding employee code  3/1/2007

   strEmail= rs.getString("EMAIL");


}
rs.close();

// query for return journey

strSql="SELECT ISNULL(RETURN_FROM,'-')AS RETURN_FROM, ISNULL(RETURN_TO,'-') AS RETURN_TO, ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE),'-') AS RETURN_DATE, ISNULL(RTRIM(LTRIM(TRAVEL_MODE)),'-') AS TRAVEL_MODE, ISNULL(MODE_NAME,'-') AS MODE_NAME , ISNULL(RTRIM(LTRIM(TRAVEL_CLASS)),'-') AS TRAVEL_CLASS, ISNULL(RTRIM(LTRIM(TIMINGS)),'-') AS TIMINGS FROM T_RET_JOURNEY_DETAILS_INT WHERE TRAVEL_ID='"+strTravelId+"'AND JOURNEY_ORDER=1 AND APPLICATION_ID=1";

//System.out.println("STRsQL ======4======= "+strSql);

// query for return journey ends 
rs       =   dbConBean.executeQuery(strSql);  
if(rs.next())
{

	strRetrunDepCity	= rs.getString("RETURN_FROM");	
	strRetrunArrCity	= rs.getString("RETURN_TO");	
	
	strReturnDate        = rs.getString("RETURN_DATE");	
	strTravelMode2       = rs.getString("TRAVEL_MODE");
	if(strTravelMode2!=null)
	{
		if(strTravelMode2.trim().equals("1"))
		{
		strTravelMode2="Air";
		}
		else
		{
		strTravelMode2="Train";
		}
	}
	strNameOfAirline2    = rs.getString("MODE_NAME");
	strTravelClass2      = rs.getString("TRAVEL_CLASS");
	strPreferTime2       = rs.getString("TIMINGS");

}
	rs.close();

	strSql = "select ISNULL(PREFER_TIME,'-') AS PREFER_TIME from M_Prefer_TIME where TIME_ID ='"+strPreferTime2+"'";
	rs       =   dbConBean.executeQuery(strSql);  
	   while(rs.next())
	   {
		strPreferTime2 = rs.getString(1);
	   }
	   rs.close();

	if(strTravelMode2.equals("Train"))
		strSql =   "SELECT DISTINCT TRAIN_ID, ISNULL(ELIGIBILITY,'-') AS ELIGIBILITY FROM M_TRAIN_CLASS WHERE STATUS_ID=10 and TRAIN_ID='"+strTravelClass2+"'";
         else
		strSql =   "SELECT DISTINCT AIR_ID, ISNULL(ELIGIBILITY,'-') AS ELIGIBILITY FROM M_AIRLINE_CLASS WHERE STATUS_ID=10 and AIR_ID='"+strTravelClass2+"'";
     rs       =   dbConBean.executeQuery(strSql);  
	   while(rs.next())
	   {
		 strELIGIBILITY2=rs.getString(2);
	   }
rs.close();	

// query for Departure Journey starts
strSql="SELECT ISNULL(TRAVEL_FROM,'-')AS TRAVEL_FROM, ISNULL(TRAVEL_TO,'-') AS TRAVEL_TO,ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE),'-') AS TRAVEL_DATE, ISNULL(RTRIM(LTRIM(TRAVEL_MODE)),'-') AS TRAVEL_MODE, ISNULL(MODE_NAME,'-') AS MODE_NAME, ISNULL(RTRIM(LTRIM(TRAVEL_CLASS)),'-') AS TRAVEL_CLASS, ISNULL(RTRIM(LTRIM(TIMINGS)),'-') AS TIMINGS FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID='"+strTravelId+"'AND JOURNEY_ORDER=1 AND APPLICATION_ID=1";
//System.out.println("STRsQL ======5======= "+strSql);

//query for departure journey ends
rs       =   dbConBean.executeQuery(strSql);  
    if(rs.next())
    {
		strDepCity           = rs.getString("TRAVEL_FROM");
		strArrCity           = rs.getString("TRAVEL_TO");
		strJTravelDate    	 = rs.getString("TRAVEL_DATE");
		strTravelMode1       = rs.getString("TRAVEL_MODE");
		if(strTravelMode1!=null)
		{
			if(strTravelMode1.trim().equals("1"))
			{
			strTravelMode1="Air";
			}
			else
			{
			strTravelMode1="Train";
			}
		}
		
		strNameOfAirline1    = rs.getString("MODE_NAME");
		strTravelClass1      = rs.getString("TRAVEL_CLASS");
		strPreferTime1       = rs.getString("TIMINGS");
		
		
	}
	rs.close();
	strSql = "select ISNULL(PREFER_TIME,'-') AS PREFER_TIME from M_Prefer_TIME where TIME_ID ='"+strPreferTime1+"'";
	rs       =   dbConBean.executeQuery(strSql);  
	   while(rs.next())
	   {
		strPreferTime1 = rs.getString(1);
	   }
	   rs.close();

	if(strTravelMode1.equals("Train"))
		strSql =   "SELECT TRAIN_ID, ISNULL(ELIGIBILITY,'-') AS ELIGIBILITY  FROM M_TRAIN_CLASS WHERE STATUS_ID=10 and TRAIN_ID='"+strTravelClass1+"'";
         else
		strSql =   "SELECT AIR_ID, ISNULL(ELIGIBILITY,'-') AS ELIGIBILITY  FROM M_AIRLINE_CLASS WHERE STATUS_ID=10 and AIR_ID='"+strTravelClass1+"'";
     rs       =   dbConBean.executeQuery(strSql);  
	   while(rs.next())
	   {
	   strELIGIBILITY=rs.getString(2);
	   }
rs.close();	
%>

</head>



<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css">
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
  <div align="center">
  <table width="600" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="45" class="bodyline-top">
        <ul class="pagebullet">
          <li class="pageHead"><b><%=dbLabelBean.getLabel("label.requestdetails.internationaljourneyreport",strsesLanguage) %></b></li>
	    </ul>   
	       </td>
      <td align="right" valign="bottom" class="bodyline-top">
	<table  align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
       <td>
     <ul id="list-nav">
      <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
      <li><a href="#" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
     </ul>
       </td>
      </tr>
    </table>
	</td>
    </tr>
  </table>
  <table width="600" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="center">
        <table width="600" border="0" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" class="reporttbl">
          <tr>
            <td colspan="11" bgcolor="#000000" class="reportheading2"><%=dbLabelBean.getLabel("label.global.basicinformation",strsesLanguage) %> </td>
	      </tr>
          <tr>
            <td width="85" class="reportLBL"><%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage) %></td>
            <td width="96" class="reportdata"><%=strUsername.toUpperCase()%></td>
	        <td width="69" class="reportLBL"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage) %></td>
		    <td width="34" class="reportdata"><%=strSiteName.toUpperCase()%></td>
            <td width="67" class="reportLBL"><%=dbLabelBean.getLabel("label.requestdetails.originator",strsesLanguage) %></td>
	        <td width="24" class="reportdata"><%=strOriginatorName.toUpperCase()%> </td>
            <td width="56" class="reportLBL"><%=dbLabelBean.getLabel("label.global.mobileno",strsesLanguage) %> </td>
	        <td width="30" class="reportdata"><%=strContactNo%></td>
		    <td width="47" class="reportLBL"><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage) %></td>
		    <td width="26" class="reportdata"> <%=strSex.toUpperCase()%> </td>
	      </tr>
          <tr>
            <td class="reportLBL"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage) %></td>
		    <td class="reportdata"><%=strDesignationName.toUpperCase()%></td>
		    <td class="reportLBL"><%=dbLabelBean.getLabel("label.requestdetails.dob",strsesLanguage) %></td>
		    <td class="reportdata"><%=strDateofBirth%></td>
		    <td colspan="2" class="reportLBL" ><%=dbLabelBean.getLabel("label.global.mealpreference",strsesLanguage) %></td>
		    <td class="reportdata"><%=strMealId.toUpperCase()%></td>
		    <td class="reportLBL"><%=dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage) %> </td>
		    <td colspan="2" class="reportdata"><%=strTravelReqNo%></td>
	      </tr>
		  <tr><!-- Adding Employee code on 3/1/2007  -->
            <td class="reportLBL"><%=dbLabelBean.getLabel("label.mylinks.employeecode",strsesLanguage) %></td>
		    <td class="reportdata"><%=strEmpcode%></td> 
			<td class="reportLBL"></td>
		    <td class="reportLBL"></td>
			<!-- Code change for showing Email ID of traveller in reports that appear to MATA on 4th jan 2008   -->
		    <td colspan="1" class="reportLBL" ><%=dbLabelBean.getLabel("label.global.emailid",strsesLanguage) %></td>
		    <td  colspan="4" class="reportdata"><font size=1><%=strEmail%></font></td>
		  </tr>
		         <!-- 3/1/2007 -->
          
          <tr>
            <td colspan="4" class="reportheading2"><%=dbLabelBean.getLabel("label.global.itineraryinfo",strsesLanguage) %> </td>
            <td colspan="7" class="reportheading2" style="text-align: right; padding-right:5px; font-size: xx-small;">
	        <%if(strCancelledReqId != null && !"0".equals(strCancelledReqId)) { %>
	        	<a href="#" class="linkedReq" onClick="MM_openBrWindow('T_TravelRequisitionDetails.jsp?purchaseRequisitionId=<%=strCancelledReqId%>&traveller_Id=<%=strTravellerId%>&travelType=I','LinkedCancelledRequest<%=strCancelledReqId %>','scrollbars=yes,resizable=yes,width=975,height=550')"><%=dbLabelBean.getLabel("label.global.linkedcancelledtravelrequest",strsesLanguage) %></a>
	        <% } else {%>
	             &nbsp;&nbsp;
	        <%} %>
	        </td>
          </tr>
          <tr>
            <td colspan="11" class="reportLBL">
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr>
                  <td class="reportheading3"><%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage) %></td>
				  <td class="reportheading3"><%=dbLabelBean.getLabel("label.approverequest.to",strsesLanguage) %></td>
				  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage) %> </td>
				 <!--  <td class="reportheading3">Mode</td> -->
				  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.class",strsesLanguage) %></td>
				  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage) %> </td>
				  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage) %> </td>
				  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage) %> </td>
				  <td class="reportheading3"><%=dbLabelBean.getLabel("label.global.visarequired",strsesLanguage) %></td>
			    </tr>
                <%
      ///	query changed  by shiv on 26-Oct-07 for  preferred  time on 26-Oct-07 
      // ISNULL(RTRIM(LTRIM(dbo.TRAVEL_MODE_NAME(TRAVEL_MODE))),'-') AS TRAVEL_MODE 

     strSql = " SELECT TRAVEL_FROM, TRAVEL_TO, ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE),'-') AS TRAVEL_DATE,  ISNULL(RTRIM(LTRIM(dbo.TRAVEL_CLASS_NAME(TRAVEL_MODE,TRAVEL_CLASS))),'-') AS TRAVEL_CLASS, ISNULL(RTRIM(LTRIM(dbo.PREFER_TIME_DESC(TIMINGS))),'-') AS TIMINGS, ISNULL(MODE_NAME,'-') AS MODE_NAME, isnull(M_SEAT_PREFER.Seat_Name,'')AS  Seat_Name ,VISA_REQUIRED, VISA_COMMENT  FROM T_JOURNEY_DETAILS_INT left outer JOIN  M_SEAT_PREFER ON  T_JOURNEY_DETAILS_INT.SEAT_PREFFERED = M_SEAT_PREFER.seat_id WHERE T_JOURNEY_DETAILS_INT.TRAVEL_ID ="+strTravelId+"AND T_JOURNEY_DETAILS_INT.STATUS_ID=10 ORDER BY 3";
 

	 String strVisaReq = "";      
  	 String strVisaCom = ""; 
  	 rs = dbConBean.executeQuery(strSql);
	 while(rs.next()) 
	 {  
 %>
                <tr align="left">
                  <td class="reportdata" ><%= rs.getString(1).toUpperCase() %></td>
                  <td class="reportdata" ><%= rs.getString(2).toUpperCase() %></td>
                  <td class="reportdata" ><%= rs.getString(3) %></td>
  
				  <!-- <td class="reportdata"> <%//= rs.getString(4).toUpperCase() %> </td> -->
				  <td class="reportdata"><%= rs.getString(4).toUpperCase() %></td>
				  <td class="reportdata"> <%= rs.getString(5).toUpperCase() %> </td>
				  <td class="reportdata"> <%= rs.getString(6).toUpperCase() %></td>
				  <td class="reportdata"> <%= rs.getString(7).toUpperCase() %></td>
                 <%
				strVisaRequired      = rs.getString("VISA_REQUIRED");

				


				if(strVisaRequired!=null)
				{
						if(strVisaRequired.trim().equals("1"))
						{
						strVisaRequired="Yes";
						}
						else
						{
						strVisaRequired="No";
						}
				}
%>
                  <td class="reportdata"> <%= strVisaRequired.toUpperCase() %> </td>
			    </tr>
                
  <%
	 } 
	 rs.close();						


// SET THE RETURN TRAVEL DETAIL
	if (strReturnDate.equals("") || strReturnDate==null ||strReturnDate.equals("-"))
	{

		strReturnDate="-";
		strPreferTime2="-";
		strTravelMode2="-";
		strNameOfAirline2="-";
		strELIGIBILITY2="-";
	}
	else
	{

            // ISNULL(RTRIM(LTRIM(dbo.TRAVEL_MODE_NAME(TRAVEL_MODE))),'-') AS TRAVEL_MODE,
		 strSql = " SELECT RETURN_FROM, RETURN_TO, ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE),'-') AS TRAVEL_DATE,  ISNULL(RTRIM(LTRIM(dbo.TRAVEL_CLASS_NAME(TRAVEL_MODE,TRAVEL_CLASS))),'-') AS TRAVEL_CLASS, ISNULL(RTRIM(LTRIM(dbo.PREFER_TIME_DESC(TIMINGS))),'-') AS TIMINGS, ISNULL(MODE_NAME,'-') AS MODE_NAME, isnull(M_SEAT_PREFER.Seat_Name,'')AS  Seat_Name  FROM T_RET_JOURNEY_DETAILS_INT  left outer JOIN  M_SEAT_PREFER ON  T_RET_JOURNEY_DETAILS_INT.SEAT_PREFFERED = M_SEAT_PREFER.seat_id WHERE T_RET_JOURNEY_DETAILS_INT.TRAVEL_ID ="+strTravelId+" AND T_RET_JOURNEY_DETAILS_INT.JOURNEY_ORDER=1 ";
    
		// System.out.println("STRsQL ======7==s===== "+strSql);

		 //String strVisaReq = "";      
		 //String strVisaCom = ""; 
		 rs = dbConBean.executeQuery(strSql);
		 while(rs.next()) 
		 {  
%>
                <tr align="left">
                  <td class="reportdata" ><%= rs.getString(1).toUpperCase() %></td>
				   <td class="reportdata" ><%= rs.getString(2).toUpperCase() %></td>
				   <td class="reportdata" ><%= rs.getString(3) %></td>
  
				   <td class="reportdata"> <%= rs.getString(4).toUpperCase() %> </td>
				   <td class="reportdata"><%= rs.getString(5).toUpperCase() %></td>
				   <td class="reportdata"> <%= rs.getString(6).toUpperCase() %> </td>
				   <td class="reportdata"> <%= rs.getString(7).toUpperCase() %> </td> 
				   
				   <td class="reportdata"> <%=dbLabelBean.getLabel("label.requestdetails.no",strsesLanguage) %>  </td>
			    </tr>
                
  <%
		 } 
		 rs.close();						
	}
%>

			<tr>
				<td colspan="11" valign="top" class="reportheading3"><%=dbLabelBean.getLabel("label.createrequest.frequentflyerdetails",strsesLanguage) %></td>				
			</tr>
			<tr>
			  <td class="reportLBL"><%=dbLabelBean.getLabel("label.requestdetails.name",strsesLanguage) %></td>
			  <td colspan="3" class="reportdata"><%=strAirLineName%></td>
			  <td colspan="2" class="reportdata"><%=strAirLineName1%></td>
			  <td colspan="3" class="reportdata"><%=strAirLineName2%></td>				  
			</tr>
			<tr>
			  <td class="reportLBL"><%=dbLabelBean.getLabel("label.requestdetails.number",strsesLanguage) %></td>
			  <td colspan="3" class="reportdata"><%=strFFNumber%></td>
			  <td colspan="2" class="reportdata"><%=strFFNumber1%></td>
			  <td colspan="3" class="reportdata"><%=strFFNumber2%></td>				  
			</tr>

                <tr>
                  <td colspan="2" class="reportLBL"><%=dbLabelBean.getLabel("label.requestdetails.purposeofjourney",strsesLanguage) %> </td>
				  <td colspan="6"  class="reportdata"><%=strReasonForTravel%></td>
			    </tr>
              </table></td>
          </tr>
          
          <tr>
            <td colspan="11" class="reportheading2"><%=dbLabelBean.getLabel("label.requestdetails.passportdetails",strsesLanguage) %></td>
	      </tr>
          
          <tr>
            <td class="reportLBL"><%=dbLabelBean.getLabel("label.global.passportnumber",strsesLanguage) %></td>
            <td class="reportdata"><%=strPassportNo%></td>
	        <td class="reportLBL"><%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage) %></td>
		    <td colspan="2" class="reportdata"><%=strPlaceIssue%></td>
            <td  class="reportLBL"><%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage) %></td>
	        <td  class="reportdata"><%=strDateIssue%></td>
			<td  class="reportLBL"><%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage) %></td>
		    <td valign="top" class="reportdata"><%=strExpiryDate%></td>
          </tr>	
          <tr>
            <!--<td rowspan="2" valign="top" class="reportLBL">Frequent Flyer Details</td>
		    <td rowspan="2" valign="top">
		      <table width="100%" border="0" cellspacing="0" cellpadding="3">
		        <tr>
		          <td class="reportLBL">Name</td>
				  <td class="reportLBL">Number</td>
			    </tr>
		        <tr>
		          <td align="left" class="reportdata"><%=strAirLineName%></td>
				  <td align="left" class="reportdata"><%=strFFNumber%></td>
			    </tr>
		        <tr>
		          <td align="left" class="reportdata"><%=strAirLineName1%></td>
				  <td align="left" class="reportdata"><%=strFFNumber1%></td>
			    </tr>
		        <tr>
		          <td align="left" class="reportdata"><%=strAirLineName2%></td>
				  <td align="left" class="reportdata"><%=strFFNumber2%></td>
			    </tr>
				</table>			
				</td>-->

		    <td height="52" valign="top" class="reportLBL"><%=dbLabelBean.getLabel("label.createrequest.permanentaddress",strsesLanguage) %>&nbsp;</td>
		    <td colspan="2" valign="top" class="reportdata"><%=strAddress%> </td>
			<td colspan="2" valign="top" class="reportLBL"><%=dbLabelBean.getLabel("label.createrequest.currentaddress",strsesLanguage) %></td>
		    <td colspan="2" valign="top" class="reportdata"><%=strCurrentAddress%></td>
			<td colspan="2" class="reportLBL"><%=dbLabelBean.getLabel("label.global.emigrationclearancerequired",strsesLanguage) %></td>
		    <td colspan="2" valign="top" class="reportdata"><%=strEcnr%></td>
	      </tr>
          
          <tr>
            <td colspan="11" class="reportheading2"><%=dbLabelBean.getLabel("label.requestdetails.insuranceinformation",strsesLanguage) %> </td>
          </tr>
          <tr>
            <td class="reportLBL"><%=dbLabelBean.getLabel("label.createrequest.travelinsurancerequired",strsesLanguage) %></td>
            <td valign="top" class="reportdata"><%=strInsuranceRequired%></td>
	        <td class="reportLBL"><%=dbLabelBean.getLabel("label.global.nominee",strsesLanguage) %></td>
		    <td valign="top" class="reportdata"><%=strNominee%></td>
            <td class="reportLBL"><%=dbLabelBean.getLabel("label.createrequest.relation",strsesLanguage) %></td>
	        <td valign="top" class="reportdata"><%=strRelation%></td>
		    <td colspan="2" class="reportLBL"><%=dbLabelBean.getLabel("label.requestdetails.insurancecomments",strsesLanguage) %></td>
            <td colspan="3" valign="top" class="reportdata"><%=strInsuranceComment%></td>
	      </tr>
          <tr>
            <td colspan="11" class="reportheading2"><%=dbLabelBean.getLabel("label.requestdetails.accomodationinformation",strsesLanguage) %> </td>
          </tr>
          <tr>
            <td class="reportLBL"><%=dbLabelBean.getLabel("label.global.staytype",strsesLanguage) %></td>
            <td align="center" class="reportdata"><%=strHotelRequired%></td>
	        <td class="reportLBL"><%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage) %></td>
		    <td align="center" class="reportdata"><%=strPlace%></td>
            <td class="reportLBL"><%=dbLabelBean.getLabel("label.global.budget",strsesLanguage) %></td>
	        <td align="center" class="reportdata"> <%=strHotelBudget%> </td>
		    <td colspan="2" class="reportLBL"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage) %> </td>
            <td colspan="3" align="center" class="reportdata"> <%=strBudgetCurrency%> </td>
	      </tr>
          
          <tr>
            <td class="reportLBL"><%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage) %> </td>
		    <td align="center" class="reportdata"><%=strCheckInDate%></td>
		    <td class="reportLBL"><%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage) %> </td>
		    <td align="center" class="reportdata"><%=strCheckOutDate%></td>		    
	      </tr>
          
          
  <% 

			ResultSet rs3 = null; 
			String strRoleinfo="";
			 strSql = "SELECT ROLE_ID FROM M_USERINFO WHERE USERID = "+ Suser_id+ " AND APPLICATION_ID =1 AND STATUS_ID=10";	
			rs3 = dbConBean1.executeQuery(strSql);
			while(rs3.next())
			{
			strRoleinfo=rs3.getString(1);
			//System.out.println("strRoleinfo "+strRoleinfo); 
			}
			rs3.close();
		    
				//System.out.println("Suser_id "+Suser_id +"strCUserId "+strCUserId); 
				
		 		 if ((!strCARD_HOLDER_NAME.trim().equals("")) && strRoleinfo.trim().equals("MATA"))
				{ 
				%>
		          <tr>
        			    <td colspan="11" class="reportheading2"><%=dbLabelBean.getLabel("label.global.creditcardinfo",strsesLanguage) %> </td>
		          </tr>
        		  <tr>
		            <td class="reportLBL"><%=dbLabelBean.getLabel("label.global.cardtype",strsesLanguage) %> </td>
					   <%					if(strCARD_TYPE.equals("-1")) // if credit card option not selected
						{
								strCARD_TYPE="-";
								strCreditCardNumber="-";
								strCARD_EXP_DATE="-";
								strCVV_NUMBER="-";
						}
						%>
				            <td class="reportdata"><%=strCARD_TYPE%>&nbsp;</td>
				            <td class="reportLBL"><%=dbLabelBean.getLabel("label.requestdetails.holdername",strsesLanguage) %></td> 
					        <td class="reportdata"><%=strCARD_HOLDER_NAME%></td>  
				            <td class="reportLBL"><!--Holder Name--> </td>  
					        <td class="reportdata"> <%//=strCARD_HOLDER_NAME%> </td>
					        <td colspan="2" class="reportLBL"><%=dbLabelBean.getLabel("label.global.expirydate",strsesLanguage) %></td>
						    <td colspan="3" class="reportdata"> <%=strCARD_EXP_DATE%>&nbsp; </td>
	          				</tr> 
			          <% } %>
            <tr>
            <td colspan="4" class="reportheading2"><%=dbLabelBean.getLabel("message.approverequest.approvedby",strsesLanguage) %></td>
            <td colspan="7" class="reportheading2"><%=dbLabelBean.getLabel("label.requestdetails.forexdetails",strsesLanguage) %> </td>
	      </tr>
          
          
  <%
	String strUnitHeadId = "";
	 strSql = "SELECT USERID  AS UNIT_HEAD_USERID FROM M_USERINFO WHERE UNIT_HEAD=1 AND SITE_ID IN (SELECT SITE_ID FROM M_USERINFO WHERE USERID="+strCUserId+" AND STATUS_ID=10)  AND APPLICATION_ID =1 AND STATUS_ID=10";	
	 rs3 = dbConBean1.executeQuery(strSql);
	 if(rs3.next())
	 {
		strUnitHeadId =rs3.getString("UNIT_HEAD_USERID");
		//System.out.println("strUnitHeadId========== "+strUnitHeadId);
	 }
	 rs3.close();


String strUnitHeadApproval  = "";
String strChairmanApproval  = "";
if(strBilling_Client != null && strBilling_Client.equals("self"))
{
	strUnitHeadApproval  = "Not Applicable";
	strChairmanApproval  = "Not Applicable";
}
else
{
	strUnitHeadApproval  = "Approved";
	strChairmanApproval  = "Approved";
}



//new code for showing unit head  name for mata page only on  2 jan 2009    
    String unitheadName=""; 
          strSql  = "SELECT dbo.user_name(TA.APPROVER_ID)as unit_head  FROM  " +
                    "T_APPROVERS TA INNER JOIN  USER_MULTIPLE_ACCESS UMASS   " + 
                    " ON TA.APPROVER_ID = UMASS.USERID AND TA.SITE_ID = UMASS.SITE_ID WHERE (TA.TRAVEL_TYPE = 'i') " + 
                    " AND (TA.TRAVEL_ID = "+strTravelId+") AND (UMASS.UNIT_HEAD = '1')";
          
          //System.out.println("strSql=================="+strSql); 

			 rs1                          = dbConBean1.executeQuery(strSql);
			 while(rs1.next())
			 {
				 unitheadName =	"by "+rs1.getString("unit_head");
					 
			 }
			 rs1.close();


%>
          
          
          <tr>
            <td class="reportLBL"><%=dbLabelBean.getLabel("label.requestdetails.unithead",strsesLanguage) %> </td>
		    <td class="reportdata"><%=strUnitHeadApproval%> <%=unitheadName%></td>
		    <td class="reportLBL"><%=dbLabelBean.getLabel("label.requestdetails.chairman",strsesLanguage) %></td>
		    <td class="reportdata"><%=strUnitHeadApproval%></td>
		    <td class="reportLBL"><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage) %> </td>
		    <td colspan="2" class="reportdata"><%=strTotal_Amount%></td>
		    <td class="reportLBL"><%=dbLabelBean.getLabel("label.requestdetails.billing",strsesLanguage) %> </td>
		    <td colspan="3" class="reportdata"><%=strBilling_Client%></td>
	      </tr>
          <tr>
            <td colspan="4" class="reportLBL">&nbsp;</td>
		    <td colspan="3" class="reportLBL"><%=dbLabelBean.getLabel("label.requestdetails.currencydenominationdetails",strsesLanguage) %> </td>
		    <td colspan="3" class="reportdata"><%=strCashBreakUpRemark%></td>
	      </tr>
	      <tr>
            <td colspan="4" class="reportLBL">&nbsp;</td>
		    <td colspan="3" class="reportLBL"><%=dbLabelBean.getLabel("label.requestdetails.expenditureremarks",strsesLanguage) %> </td>
		    <td colspan="3" class="reportdata"><%=strEXPENDITURE_REMARKS%></td>
	      </tr> 	
		   <tr>
            <td colspan="11" class="reportheading2"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage) %></td>             
	      </tr>
		   <tr>		    
		    <td colspan="11" class="reportdata"><%=strRemarks%></td>
		    </tr>
	    </table>
        <br>      </td>
    </tr>
  </table>
     
    
  </div>
</body>
<table width="600" align="center" border="0" cellpadding="2" cellspacing="0" bordercolor="#FFFFFF" class="reporttbl">
  <tr width="100%" class="formhead">
    <td colspan="11" bgcolor="#000000" class="reportheading2"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %></td>
  </tr>	
  <tr class="reportLBL">
    <td class="reportLBL" width="2%" align="left" valign="top" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
	<td class="reportLBL" width="24%" align="left" valign="top"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %></td>
	<td class="reportLBL" width="24%" align="left" valign="top"><%=dbLabelBean.getLabel("label.global.postedby",strsesLanguage) %></td>
	<td class="reportLBL" width="24%"><%=dbLabelBean.getLabel("label.global.postedon",strsesLanguage) %></td>
  </tr>
<%
		String strCommentId		=	null;
		String strComments		=	null;
		String strPostedBy		=	null;
		String strPostedOn		=	null;
	    String strCommentsId			=	"";
		String strOriginatedUserId=	"";
		String strStyleCls        = "";
		int iCls                  = 0; 
        
		//Making approver comment bold  if he change the comment on 03-04-2009 by shiv sharma 
		strSql="SELECT TRAVEL_ID,case when left(rtrim(ltrim(COMMENTS)),8) <>'approved' then '<b>'+ COMMENTS + '</b>' else COMMENTS end  as COMMENTS,DBO.USER_NAME(POSTED_BY),DBO.CONVERTDATEDMY1(POSTED_ON), COMMENTS_ID,POSTED_BY FROM TRAVEL_REQ_COMMENTS WHERE TRAVEL_ID='"+strTravelId+"'  AND TRAVEL_TYPE='I' ORDER BY POSTED_ON DESC";
		
		
		//System.out.println("strSql==============="+strSql);  
		
	 rs = dbConBean.executeQuery(strSql);
	 int intSno=1;
	 if(rs.next())
	 {
		do
		 {
			 strCommentId			=	rs.getString(1);
			 strComments			=	rs.getString(2);
			 strPostedBy			=	rs.getString(3);
			 strPostedOn			=	rs.getString(4);
			 strCommentsId			=	rs.getString(5);
			 strOriginatedUserId	=	rs.getString(6);
         	 if (iCls%2 == 0) { 
        		strStyleCls="formtr2";
             } else { 
    		 strStyleCls="formtr1";
             } 
      	     iCls++;
%>
				<tr class="<%=strStyleCls%>">
					<td class="reportdata" width="2%" align="left" valign="top"><%=intSno++%></td>
					<td class="reportdata" width="24%" align="left" valign="top"><%=strComments%></td>
					<td class="reportdata" width="24%" align="left" valign="top"><%=strPostedBy%></td>
					<td class="reportdata" width="24%"><%=strPostedOn%></td>
				</tr>
<%
		 }while(rs.next());
	 }
	 rs.close();          // close the result set 
	 dbConBean.close();   //close all connection
%>
</table>
<%
dbConBean1.close();
%>