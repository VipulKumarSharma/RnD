	<% 
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:SACHIN GUPTA
	 *Date of Creation 		:15 Feb 2008
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STARS
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:This is the jsp file  for show the All Group Travel Requisition Details
	 *Modification 			:mode is commented by shiv on 07 jan 2009 for not showing in case of international requisition
							:added link for Learms page for showing deatils of lerms after all approveral on 29 jan 2009 
	 
	 *Date of modification	: 20 Sep 2011
	 *Modification			: show group acomodation and group interim journey details on details screen
	 *Editor				: Eclipse 3.5
	 
	 *Modified By			:Manoj Chand
	 *Date of Modification	:01 Dec 2011
	 *Modification			:Show expenditure remarks and billing approver in details page of international group request.
	 
	 *Date of Modification  :29 Mar 2012
	 *Modified By	        :MANOJ CHAND	
	 *Description			:showing board member in details screen for SMP Division.
	 
	 *Modified By	        :MANOJ CHAND
	 *Date of Modification  :29 Nov 2012
	 *Description			:Display Total Travel Fare amount and currency for smp division only.
	 
	 *Modified By	        :MANOJ CHAND
	 *Date of Modification  :31 Jan 2013
	 *Description			:Showing mulitple currency and their value in comma separate way.
	 *******************************************************/
	%>
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
	String strBoardMemberId			="";
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
	String strBilling_site="";
	String strRequisitionId					="";
	
	//end Varaible Declaration for Forex Details
	
	strTravelId = request.getParameter("strRequisitionId");
	
	strRequisitionId = request.getParameter("strRequisitionId");
	//getting travel id from the previous page
	
	//CODE STARTS
	
	String strCARD_TYPE  ="";
	String strCARD_HOLDER_NAME ="";
	String strExpRemark="";
	
	//Below 5 fields Added by Pankaj on 17 Nov 2010
	String strYTM_BUDGET = ""; 
	String strYTD_ACTUAL = ""; 
	String strAVAIL_BUDGET = ""; 
	String strEST_EXP = ""; 
	String strEXP_REMARKS = "";
	
	
	String strCARD_NUMBER1 ="";
	String strCARD_NUMBER2 ="";
	String strCARD_NUMBER3 ="";
	String strCARD_NUMBER4 ="";
	String strCVV_NUMBER ="";
	String strCARD_EXP_DATE ="";
	String strCreditCardNumber="";
	String strApproverRole="";
	String strCUserId="";
	String strReasonForSkip  = "";
	String strSeatPref="";
	
	String strBillingApprover="";
	String strTotalFareAmt="";
	String strTotalFareCur="";
	
	//CODE ENDS
	strSql = "SELECT ISNULL(TRAVEL_REQ_ID,'-') AS TRAVEL_REQ_ID , C_USERID,ISNULL(dbo.SITENAME_FROM_USERID(C_USERID),'-') AS UNIT ,ISNULL(TRAVELLER_ID,'-') AS TRAVELLER_ID ,ISNULL(AGE,'-') AS AGE ,ISNULL(SEX,'-') AS SEX,ISNULL(dbo.MEAL_NAME(MEAL),'-') AS  MEALNAME,ISNULL(VISA_REQUIRED,'-') AS VISA_REQUIRED,ISNULL(VISA_COMMENT,'-') AS VISA_COMMENT, ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE),'-')AS TRAVEL_DATE, ISNULL(INSURANCE_REQUIRED,'-') AS INSURANCE_REQUIRED,ISNULL(NOMINEE,'-') AS NOMINEE, ISNULL(RELATION,'-') AS RELATION, ISNULL(INSURANCE_COMMENTS,'-') AS INSURANCE_COMMENTS, ISNULL(HOTEL_REQUIRED,'-') AS HOTEL_REQUIRED,ISNULL(RTRIM(LTRIM(BUDGET_CURRENCY)),'-') AS BUDGET_CURRENCY , ISNULL(HOTEL_BUDGET,'') AS HOTEL_BUDGET, ISNULL(REMARKS,'-') AS REMARKS, LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CHECK_IN_DATE),'-'))) AS CHECK_IN_DATE , LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CHECK_OUT_DATE),'-'))) AS CHECK_OUT_DATE, ISNULL(PLACE,'-') AS PLACE, ISNULL(RTRIM(LTRIM(APPROVER_SELECTION)),'-') AS APPROVER_SELECTION, MANAGER_ID,HOD_ID, LTRIM(RTRIM(ISNULL(CARD_TYPE,''))) AS CARD_TYPE,LTRIM(RTRIM(ISNULL(CARD_NUMBER1,''))) AS CARD_NUMBER1,LTRIM(RTRIM(ISNULL(CARD_NUMBER2,''))) AS CARD_NUMBER2 ,LTRIM(RTRIM(ISNULL(CARD_NUMBER3,''))) AS CARD_NUMBER3, LTRIM(RTRIM(ISNULL(CARD_NUMBER4,''))) AS CARD_NUMBER4 ,LTRIM(RTRIM(ISNULL(CVV_NUMBER,''))) AS CVV_NUMBER,LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CARD_EXP_DATE),''))) AS CARD_EXP_DATE, ISNULL(CONVERT(decimal(20,0),TOTAL_AMOUNT),'0') AS TOTAL_AMOUNT,ISNULL(TA_CURRENCY,'-') AS TA_CURRENCY,BILLING_SITE,BILLING_CLIENT, ISNULL(.DBO.TRAVEL_MODE(TRAVEL_ID,'I'),'-') AS TRAVEL_MODE,            ISNULL(RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE))),'-') AS TRAVELLER_CHEQUE,ISNULL(RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE1))),'-') AS TRAVELLER_CHEQUE1, ISNULL(RTRIM(LTRIM(convert(decimal(20,0),TRAVELLER_CHEQUE2))),'-') AS TRAVELLER_CHEQUE2,ISNULL(TC_CURRENCY,'-') AS TC_CURRENCY,ISNULL(TC_CURRENCY1,'-') AS TC_CURRENCY1,ISNULL(TC_CURRENCY2,'-') AS TC_CURRENCY2, ISNULL(REASON_FOR_SKIP,'-') AS REASON_FOR_SKIP,ISNULL(CASH_BREAKUP_REMARKS,'-') AS CASH_BREAKUP_REMARKS ,ISNULL(CARD_HOLDER_NAME,'') AS CARD_HOLDER_NAME,ISNULL(EXPENDITURE_REMARKS,'-') AS EXPENDITURE_REMARKS , ROUND(YTM_BUDGET ,0) YTM_BUDGET, ROUND(YTD_ACTUAL,0) YTD_ACTUAL, ROUND(AVAIL_BUDGET ,0) AVAIL_BUDGET, ROUND(EST_EXP,0) EST_EXP, EXP_REMARKS,BOARD_MEMBER_ID,SITE_ID,FARE_CURRENCY,FARE_AMOUNT FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="+strTravelId+" AND APPLICATION_ID=1";
		
	//ISNULL(EXPENDITURE_REMARKS,'-') AS EXPENDITURE_REMARKS
	//System.out.println("**********************************************************************"+strSql);
	rs       =   dbConBean.executeQuery(strSql);  
	if(rs.next())
	{
			strTravelReqId       = rs.getString("TRAVEL_REQ_ID");
			strCUserId    = rs.getString(2);
			//System.out.println("strCUserId  "+strCUserId);
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
	        strHotelBudget       = rs.getString("HOTEL_BUDGET").trim();
	
			// added code by shiv on 09-Jul-07
				if ( strHotelBudget!= null && strHotelBudget.equals("0.0")) {
				strHotelBudget = "-";
				}
	
			if(strHotelRequired!=null)
			{
				if(strHotelRequired.trim().equals("1"))
				{
				strHotelRequired="Hotel";
				}
				else if(strHotelRequired.trim().equals("2"))
				{
					strHotelRequired="Transit House";
					if(strHotelBudget.equals("-") || strHotelBudget.equals("") || strHotelBudget.equals("0"))
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
			if(strCheckInDate!=null && strCheckInDate.trim().equals(""))
				strCheckInDate="-";
			if(strCheckOutDate!=null && strCheckOutDate.trim().equals(""))
				strCheckOutDate="-";
	// 19-02-2007 SACHIN
			strPlace             = rs.getString("PLACE"); 
	if(strPlace!=null && strPlace.trim().equals(""))
		strPlace="-";
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
			strTotal_Amount = rs.getString("TOTAL_AMOUNT");
			strTotal_Currency = rs.getString("TA_CURRENCY");
			if(strTotal_Amount != null && strTotal_Amount.equals("0"))
			{
				strTotal_Amount   = "-";
	            strTotal_Currency = ""; 
			}
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
			//23022007
	
	
	       strExpRemark=rs.getString("EXPENDITURE_REMARKS"); //added by shiv on 3/28/2007
	       
	       //strRemarks =rs.getString("REMARKS"); 
			 
	     //Below 5 fields Added by Pankaj on 17 Nov 2010
			try{
			strYTM_BUDGET = rs.getString("YTM_BUDGET"); 
			strYTD_ACTUAL = rs.getString("YTD_ACTUAL"); 
			strAVAIL_BUDGET = rs.getString("AVAIL_BUDGET"); 
			strEST_EXP = rs.getString("EST_EXP"); 
			strEXP_REMARKS = rs.getString("EXP_REMARKS");
			strBoardMemberId = rs.getString("BOARD_MEMBER_ID");
			strSiteId=	rs.getString("SITE_ID");
			strTotalFareCur=rs.getString("FARE_CURRENCY");
			strTotalFareAmt=rs.getString("FARE_AMOUNT");
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
	
	//added by manoj chand on 01 dec 2011 to fetch expenditure remarks
	strSql = "select ISNULL(EXP_REMARKS,'-') AS EXP_REMARKS from T_GROUP_USERINFO where T_GROUP_USERINFO.TRAVEL_ID="+strTravelId+" AND T_GROUP_USERINFO.TRAVEL_TYPE='I' and APPLICATION_ID=1 AND STATUS_ID=10";
	rs       =   dbConBean.executeQuery(strSql);  
	if(rs.next())
	{
	strExpRemark		= rs.getString("EXP_REMARKS").trim();
	if(strExpRemark.equalsIgnoreCase(""))
		strExpRemark="-";
	}
	rs.close();
	
	
	//System.out.println("strBilling_Client=="+strBilling_Client+"req_no ===" + strTravelId);
	//System.out.println("strBilling_site=="+strBilling_site);
	////added new by shiv on 02-Nov-07 
	
	
	if (strBilling_site!=null && !strBilling_site.equals("0") && !strBilling_site.equals(strTravelId) &&  !strBilling_site.equals("-1")) 
	///normal case  when user site is biling site  
	{
		if(strBilling_Client ==null || strBilling_Client.equals(""))
			{
			strBilling_Client ="--";
			}
	else{ 
	
	//System.out.println("strBilling_Client 1234====="+strBilling_Client);
			int intBilling_Client =Integer.parseInt(strBilling_Client);  
	 //System.out.println("intBilling_Client=="+intBilling_Client);
	//	 strSql = "select site_name from m_site where site_id=(select site_id from m_userinfo  where USERID="+intBilling_Client+")";
	
	 //	strSql = "select site_name from m_site where site_id=(select billing_site from t_travel_detail_int where TRAVEL_ID="+strTravelId+")";
	 //changed by manoj chand on 01 dec 2011 to show billing approver in details screen.
			strSql = "SELECT .DBO.SITENAME(BILLING_SITE)  AS SITE_NAME,dbo.user_name(BILLING_CLIENT) AS BILLING_CLIENT FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID ="+strTravelId;
			
	 //System.out.println("strSqlVVVVV======"+strSql);
		
		rs       =   dbConBean.executeQuery(strSql);  
		while(rs.next())
		{
			strBilling_Client = rs.getString("SITE_NAME");
			strBillingApprover=rs.getString("BILLING_CLIENT");
		}
		rs.close();
	}
	
	}
	
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
	
	//Code starts  if strBilling client is null,means the site is paying for it 
	if((strBilling_Client==null) || (strBilling_Client.equals("")) || strBilling_Client.equals("-") || strBilling_Client.equals("-1"))
	{
		//strSql = "select site_name from m_site where site_id=(select billing_site from t_travel_detail_int where TRAVEL_ID="+strTravelId+")";
	
	//changed by manoj chand on 01 Dec 2011 to show billing approver in details screen.
		strSql="SELECT .DBO.SITENAME(BILLING_SITE)  AS SITE_NAME,dbo.user_name(BILLING_CLIENT) AS BILLING_CLIENT FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID ="+strTravelId;
			
		rs       =   dbConBean.executeQuery(strSql);  
		while(rs.next())
		{
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
	//System.out.println("strBillingClient is========"+strBilling_Client);
	
	//System.out.println("strSelectManagerRadio================"+strSelectManagerRadio);
	 
	if(strSelectManagerRadio != null && strSelectManagerRadio.equals("manual"))
	{
	     
		// getting value form m_userinfo for hod and pm
		if(strManager != null && !strManager.equals("null") && !strManager.equals("") && !strManager.equals("0"))
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
	
	
		if(strHod != null && !strHod.equals("null") && !strHod.equals("")  && !strHod.equals("0") )
		{
			strSql ="select dbo.user_name("+strHod+")";
			rs = dbConBean.executeQuery(strSql);
			while(rs.next())
			{
				strHod = rs.getString(1);
			}
			rs.close();
		}
		else//  if(strHod.equals("null")) 
		{
			strHod = "-";
		}
	}
	//ADDED BY MANOJ CHAND ON 29 MAR 2012 TO GET BOARD MEMBER
	if(strBoardMemberId != null && !strBoardMemberId.equals("null") && !strBoardMemberId.equals("")  && !strBoardMemberId.equals("0") )
	{
		strSql ="select dbo.user_name("+strBoardMemberId+")";
		rs = dbConBean.executeQuery(strSql);
		while(rs.next())
		{
			strBoardMemberId = rs.getString(1);
		}
		rs.close();
	}
	else 
	{
		strBoardMemberId = "-";
	}
	// if hod is selected is automatically
	
	if(strSelectManagerRadio != null && strSelectManagerRadio.equals("automatic"))
	{
		strManager=dbLabelBean.getLabel("label.requestdetails.managerselectedautomatically",strsesLanguage);
		strHod=dbLabelBean.getLabel("label.requestdetails.hodselectedautomatically",strsesLanguage);
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
	
	strSql = "select ISNULL(dbo.user_name(userid),'-')AS USERNAME,ISNULL(PASSPORT_NO,'-')AS PASSPORT_NO,ISNULL(dbo.CONVERTDATEDMY1(DATE_ISSUE),'-') AS DATE_ISSUE,ISNULL(PLACE_ISSUE,'-') AS PLACE_ISSUE,ISNULL(dbo.CONVERTDATEDMY1(EXPIRY_DATE),'-') AS EXPIRY_DATE,ISNULL(ADDRESS,'-') AS ADDRESS ,ISNULL(CONTACT_NUMBER,'-') AS CONTACT_NUMBER,ISNULL(FF_NUMBER,'-') AS FF_NUMBER,ISNULL(FF_NUMBER1,'-') AS FF_NUMBER1,ISNULL(FF_NUMBER2,'-') AS FF_NUMBER2,ISNULL(dbo.CONVERTDATEDMY1(DOB),'-')AS DOB,ISNULL(dbo.SITENAME(SITE_ID),'-')AS COMPANYNAME,ISNULL(ECNR,'-') AS ECNR,ISNULL(dbo.DESIG_FROM_USERID(userid),'-') AS DESIGNAME,    ISNULL(CURRENT_ADDRESS,'') AS CURRENT_ADDRESS, ISNULL(FF_AIR_NAME,'') AS FF_AIR_NAME, ISNULL(FF_AIR_NAME1,'') AS FF_AIR_NAME1, ISNULL(FF_AIR_NAME2,'') AS FF_AIR_NAME2 from m_userinfo  where userid ='"+strUserId+"'";  // on the basis of traveller id 
	
	
	//System.out.println("strSql============="+strSql);
	
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
	
	
	}
	rs.close();
	
	// query for return journey
	
	strSql="SELECT ISNULL(RETURN_FROM,'-')AS RETURN_FROM, ISNULL(RETURN_TO,'-') AS RETURN_TO, ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE),'-') AS RETURN_DATE, ISNULL(RTRIM(LTRIM(TRAVEL_MODE)),'-') AS TRAVEL_MODE, ISNULL(MODE_NAME,'-') AS MODE_NAME , ISNULL(RTRIM(LTRIM(TRAVEL_CLASS)),'-') AS TRAVEL_CLASS, ISNULL(RTRIM(LTRIM(TIMINGS)),'-') AS TIMINGS, isnull( M_SEAT_PREFER.Seat_Name,'') as Seat_Name   FROM T_RET_JOURNEY_DETAILS_INT left outer JOIN  M_SEAT_PREFER ON  T_RET_JOURNEY_DETAILS_INT.SEAT_PREFFERED = M_SEAT_PREFER.seat_id WHERE T_RET_JOURNEY_DETAILS_INT.TRAVEL_ID='"+strTravelId+"'AND T_RET_JOURNEY_DETAILS_INT.JOURNEY_ORDER=1 AND T_RET_JOURNEY_DETAILS_INT.APPLICATION_ID=1";
	// query for return journey ends 
	
	String strRetSeatpreffered="";
	
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
		strRetSeatpreffered  =rs.getString("Seat_Name");
	
	}
		rs.close();
	
		strSql = "select ISNULL(PREFER_TIME,'-') AS PREFER_TIME from M_Prefer_TIME where TIME_ID ='"+strPreferTime2+"'";
	
		//System.out.println("strSql=====================++"+strSql);
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
		   //System.out.println("strELIGIBILITY--> "+strELIGIBILITY2);
		   }
	rs.close();	
	
	// query for Departure Journey starts
	strSql="SELECT ISNULL(TRAVEL_FROM,'-')AS TRAVEL_FROM, ISNULL(TRAVEL_TO,'-') AS TRAVEL_TO,ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE),'-') AS TRAVEL_DATE, ISNULL(RTRIM(LTRIM(TRAVEL_MODE)),'-') AS TRAVEL_MODE, ISNULL(MODE_NAME,'-') AS MODE_NAME, ISNULL(RTRIM(LTRIM(TRAVEL_CLASS)),'-') AS TRAVEL_CLASS, ISNULL(RTRIM(LTRIM(TIMINGS)),'-') AS TIMINGS, isnull( M_SEAT_PREFER.Seat_Name,'') as Seat_Name FROM T_JOURNEY_DETAILS_INT left outer JOIN  M_SEAT_PREFER ON  T_JOURNEY_DETAILS_INT.SEAT_PREFFERED = M_SEAT_PREFER.seat_id WHERE T_JOURNEY_DETAILS_INT.TRAVEL_ID='"+strTravelId+"'AND T_JOURNEY_DETAILS_INT.JOURNEY_ORDER=1 AND T_JOURNEY_DETAILS_INT.APPLICATION_ID=1";
	//query for departure journey ends
	
	//System.out.println("strSql======"+strSql);
	
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
				strTravelMode1="Air";
				}
			}
			
			strNameOfAirline1    = rs.getString("MODE_NAME");
			strTravelClass1      = rs.getString("TRAVEL_CLASS");
			strPreferTime1       = rs.getString("TIMINGS");
			strSeatPref          = rs.getString("Seat_Name");
			
			
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
	
	
	
	
	
	
	<body>
	 <table width="100%" align="center" border="0" >
	  <tr>
	    <td align="center">
		  <table width="100%" border="0" cellpadding="2" cellspacing="1" class="reporttble">
	        <tr>
	          <td  height="0" colspan="11" align="left" class="reportHeading" ><%=dbLabelBean.getLabel("label.requestdetails.allinformation",strsesLanguage) %>  <font size="1"></font></td>
	        </tr> 
	         
			<tr>   
			  
	       </tr>
	         
	        <tr>
	          <td height="0" colspan="11" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.requestdetails.itineraryinformationgroupguest",strsesLanguage) %>  </td>   
	        </tr>
			<tr>
			     <td colspan="11" class="reportLBL">
	              <table width="100%" border="0" cellspacing="0" cellpadding="3">
				<tr>
					<td height="0" class="reportCaption"><font color="#1d1d1d" size="1px"><%=dbLabelBean.getLabel("label.global.forwardjourney",strsesLanguage) %></font></td>
					<td height="0" class="reportCaption"></td>
					<td height="0" class="reportCaption"></td>
					<td height="0" class="reportCaption"></td> 
				</tr>
				
				<tr>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage) %></td>
				  <td height="0" class="reportdata" ><%=strDepCity.toUpperCase()%></td>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage) %></td>
				  <td height="0" class="reportdata" ><%=strArrCity.toUpperCase()%></td>
				</tr>
				<tr>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage) %> </td>
				  <td height="0" class="reportdata" ><%=strJTravelDate%></td>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage) %></td> 
				  <td height="0" class="reportdata" ><%=strPreferTime1.toUpperCase()%></td>
				</tr>
				<tr><!-- mode is commented by shiv on 07 jan 2009 for not showing in case of international requisition  -->
				  <td height="0" class="reportCaption" ><!-- Mode  --></td>
				  <td height="0" class="reportdata" ><%//=strTravelMode1.toUpperCase()%></td>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage) %></td>
				  <td height="0" class="reportdata" ><%=strNameOfAirline1.toUpperCase()%></td>
				</tr>
				<tr>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.class",strsesLanguage) %></td>
				  <td height="0" class="reportdata" ><%=strELIGIBILITY.toUpperCase()%></td> 
				  <td height="0" class="reportCaption" >   <%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage) %>    </td> 
				  <td height="0" class="reportdata" ><%=strSeatPref%></td>           
				</tr>
				 
		  <% if (!strReturnDate.equals("") && strReturnDate!=null && !strReturnDate.equals("-") && !strReturnDate.equals("1900-01-01 00:00:00.000"))
		{
	
		/*strReturnDate="-";
		strPreferTime2="-";
		strTravelMode2="-";
		strNameOfAirline2="-";
		strELIGIBILITY2="-";
		*/
		 
		%>    
		
				
				<tr>   
					<td height="0" class="reportCaption"><font color="#1d1d1d" size="1px"> <%=dbLabelBean.getLabel("label.global.returnjourney",strsesLanguage) %></font></td>  
					<td height="0" class="reportCaption"></td> 
					<td height="0" class="reportCaption"></td>
				<td height="0" class="reportCaption"></td> 
			   </tr>
		        <tr>
		          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage) %></td>
		          <td height="0" class="reportdata" ><%=strRetrunDepCity%></td>
		          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage) %></td>
		          <td height="0" class="reportdata" ><%=strRetrunArrCity%></td>
		        </tr>
	        
	        
			
		
			<tr>
	          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage) %></td>
	          <td height="0" class="reportdata" ><%=strReturnDate%></td>
			  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage) %></td>
	          <td height="0" class="reportdata" ><%=strPreferTime2%></td>
	        </tr>
	        <tr>
	          <td height="0" class="reportCaption" ></td>
	          <td height="0" class="reportdata" ><%//=strTravelMode2%></td>
	          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.requestdetails.preferredairlinetrain",strsesLanguage) %></td>
	          <td height="0" class="reportdata" ><%=strNameOfAirline2%></td>
	        </tr>
			<tr>
	           <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.class",strsesLanguage) %></td>
	          <td height="0" class="reportdata" ><%=strELIGIBILITY2%></td>
	          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage) %></td> 
	          <td height="0" class="reportdata" ><%=strRetSeatpreffered%></td> 
	        </tr>  
			<%} %>	
			
			<%
			//added by manoj chand on 29 march 2012 to show board members for smp case
			strSql="select md.SHOW_APP_LVL_3 from M_DIVISION md inner join M_SITE ms on ms.DIV_ID=md.DIV_ID where ms.SITE_ID="+strSiteId;
			//System.out.println("strSql----45--->"+strSql);
			String strAppFlag="";		                        
			rs = dbConBean1.executeQuery(strSql);
				if(rs.next())
				{
					strAppFlag=rs.getString(1);
	            }
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
			  </table> 
			</td>
		  </tr>
		  
<!-- added by manoj chand on 20 sep 2011 to show accomodation related details -->
<%
/*System.out.println("strHotelRequired--->"+strHotelRequired);
System.out.println("strPlace--->"+strPlace);
System.out.println("strHotelBudget--->"+strHotelBudget);
System.out.println("strBudgetCurrency--->"+strBudgetCurrency);
System.out.println("strCheckInDate--->"+strCheckInDate);
System.out.println("strCheckOutDate--->"+strCheckOutDate);
System.out.println("strRemarks--->"+strRemarks);*/

%>


<tr>
          <td height="0" colspan="10" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.requestdetails.accomodationinformation",strsesLanguage) %> 
        </tr>
        <tr>
			     <td colspan="10" class="reportLBL">
			     <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td height="0" class="reportCaption"><%=dbLabelBean.getLabel("label.global.staytype",strsesLanguage) %> <span class="starcolour"></span></td>
          <td height="0" class="reportdata" ><%=strHotelRequired%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage) %><span class="starcolour"></span></td>
          <td height="0" class="reportdata" ><%=strPlace%></td>
        </tr>
        <tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.budget",strsesLanguage) %><span class="starcolour"></span></td>
          <td height="0" class="reportdata" ><%=strHotelBudget%></td>          
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage) %><span class="starcolour"></span> </td>
          <td height="0" class="reportdata" ><%=strBudgetCurrency%></td>
        </tr>
		<tr>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage) %><span class="starcolour"></span></td>
          <td height="0" class="reportdata" ><%=strCheckInDate%></td>
          <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage) %> <span class="starcolour"></span></td>
          <td height="0" class="reportdata" ><%=strCheckOutDate%></td>
        </tr>
		<tr>
		  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage) %> <span class="starcolour"></span></td>
          <td height="0" class="reportdata" ><%=strRemarks%></td>
          <td height="0" class="reportCaption" > <span class="starcolour"></span></td>
          <td height="0" class="reportdata" ></td>
        </tr>		  
		</table>
		</td>
		</tr>  
		  
		  
		  
		  
		  
		  
		  
		  <tr>
	          <td height="0" colspan="11" class="reportSubHeading" > <%=dbLabelBean.getLabel("label.requestdetails.travelersinformationforwardjourney",strsesLanguage) %> </td>
	        </tr>
			<tr>
			  <td colspan="11" class="reportLBL">
	              <table width="100%" border="0" cellspacing="0" cellpadding="3">
				    <tr>
					  <td width="5%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
					  <td width="20%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage) %></td>
					  <td width="20%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage) %></td>
					  <td width="10%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage) %></td>
					  <td width="12%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage) %></td>
					  <td width="20%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.age",strsesLanguage) %></td>
					  <td width="13%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.mealpreference",strsesLanguage) %></td>
					</tr>
						<%
							    strSql = " select rtrim(first_name)+' '+rtrim(last_name) as Name,dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID, case when Gender=1 then 'Male' else 'Female' end as Gender, ISNULL(dbo.SITENAME(SITE_ID),'-') AS UNIT, ISNULL(AGE,'-') AS AGE,ISNULL(dbo.MEAL_NAME(MAEL_ID),'-') AS  MEALNAME from t_group_userinfo where  travel_type='i' and  travel_id="+strTravelId+" and status_id=10";  	 
						
								
						      int intSNo1 = 0;
							  rs = dbConBean.executeQuery(strSql); 
							  while(rs.next()) 
							  {  
						%>
	                    <tr>
							<td height="0" class="reportdata" ><%= ++intSNo1%></td>
							<td height="0" class="reportdata" ><%= rs.getString(1).toUpperCase() %></td>
							<td height="0" class="reportdata" ><%= rs.getString(2).toUpperCase() %></td>
							<td height="0" class="reportdata" ><%= rs.getString(3).toUpperCase() %></td>
							<td height="0" class="reportdata" ><%= rs.getString(4).toUpperCase() %></td>
							<td height="0" class="reportdata" ><%= rs.getString(5).toUpperCase() %></td>
							<td height="0" class="reportdata" ><%= rs.getString(6).toUpperCase() %></td>
	                      </tr>
					<%
						  } 
						  rs.close();						
					%>
				</table>
			</td>	
	       </tr>
	       <%
	       if (!strReturnDate.equals("") && strReturnDate!=null && !strReturnDate.equals("-") && !strReturnDate.equals("1900-01-01 00:00:00.000")  ) 
	    	  
	       { %>
	         
		   <tr>   
	          <td height="0" colspan="11" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.requestdetails.travelersinformationreturnjourney",strsesLanguage) %></td>
	        </tr>
			<tr>
			  <td colspan="11" class="reportLBL">
	              <table width="100%" border="0" cellspacing="0" cellpadding="3">
				    <tr>
					  <td width="5%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
					  <td width="20%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage) %></td>
					  <td width="20%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage) %></td>
					  <td width="10%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage) %></td>
					  <td width="12%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage) %></td>
					  <td width="20%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.age",strsesLanguage) %></td>
					  <td width="13%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.mealpreference",strsesLanguage) %></td> 
					</tr>
						<%
							    strSql = " select rtrim(first_name)+' '+rtrim(last_name) as Name,dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID, case when Gender=1 then 'Male' else 'Female' end as Gender, ISNULL(dbo.SITENAME(SITE_ID),'-') AS UNIT, ISNULL(AGE,'-') AS AGE,ISNULL(dbo.MEAL_NAME(MAEL_ID),'-') AS  MEALNAME from t_group_userinfo where  travel_type='i' and  Return_travel ='y' and travel_id="+strTravelId+" and status_id=10";	 
						
	                               
											
									      int intSNo2 = 0;
										  rs = dbConBean.executeQuery(strSql); 
								
										  
								  while(rs.next())  
										  {  
									%>
				                    <tr>
										<td height="0" class="reportdata" ><%= ++intSNo2%></td>
										<td height="0" class="reportdata" ><%= rs.getString(1).toUpperCase() %></td>
										<td height="0" class="reportdata" ><%= rs.getString(2).toUpperCase() %></td>
										<td height="0" class="reportdata" ><%= rs.getString(3).toUpperCase() %></td>
										<td height="0" class="reportdata" ><%= rs.getString(4).toUpperCase() %></td>
										<td height="0" class="reportdata" ><%= rs.getString(5).toUpperCase() %></td>
										<td height="0" class="reportdata" ><%= rs.getString(6).toUpperCase() %></td>
				                      </tr>
								<%
									  } 
									  rs.close();	 					
								%>
				</table>
			</td>	
	       </tr>
           <%}
	       else
	       {%>
	      <!-- <tr>
	          <td height="0" colspan="11" class="reportSubHeading" >No Traveler(s) to Return  </td> 
	        </tr>
	        
	        --> 
	       	
	       <%}
	       %>
	          
	        <tr>
	          <td height="0" colspan="11" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.requestdetails.passportdetailsoftravelers",strsesLanguage) %> </td>
	        </tr>
			<tr>
			  <td width="5%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
			  <td width="20%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage) %></td>
			  <td width="12%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.passportnumber",strsesLanguage) %></td>
			   <td width="12%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.user.nationality",strsesLanguage) %></td>
			  <td width="8%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.ecr",strsesLanguage) %></td>
			  <td width="10%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage) %></td>
			  <td width="10%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage) %></td>
			  <td width="10%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage) %></td>
			  <td width="15%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.dob",strsesLanguage) %></td>
	        </tr>
			<%
		    strSql = "select rtrim(first_name)+' '+rtrim(last_name) as Name, ISNULL(Passport_No,'-') as Passport_No,case when ECNR=1 then 'Yes' when ECNR=2 then 'No' else 'N/A' end as ECR, ISNULL(Place_of_issue,'-') as Place_of_issue, ISNULL(dbo.CONVERTDATEDMY1(Date_of_issue),'-') AS Date_of_issue,ISNULL(dbo.CONVERTDATEDMY1(Expiry_date),'-') AS Expiry_date, ISNULL(dbo.CONVERTDATEDMY1(DOB),'-') AS DOB, ISNULL(NATIONALITY, '') as NATIONALITY from t_group_userinfo where travel_type='i' and travel_id="+strTravelId+" and status_id=10";	 
	        int intSNo = 0; 
	
		 
		    rs = dbConBean.executeQuery(strSql);
		    while(rs.next()) 
		    {  
				%>
	                    <tr>
							<td height="0" class="reportdata" ><%= ++intSNo%></td>
							<td height="0" class="reportdata" ><%= rs.getString(1).toUpperCase() %></td>
							<td height="0" class="reportdata" ><%= rs.getString(2).toUpperCase() %></td>
							<td height="0" class="reportdata" ><%= rs.getString(8).toUpperCase() %></td>
							<td height="0" class="reportdata" ><%= rs.getString(3).toUpperCase() %></td>
							<td height="0" class="reportdata" ><%= rs.getString(4).toUpperCase() %></td>
							<td height="0" class="reportdata" ><%= rs.getString(5).toUpperCase() %></td>
							<td height="0" class="reportdata" ><%= rs.getString(6).toUpperCase() %></td>
							<td height="0" class="reportdata" ><%= rs.getString(7).toUpperCase() %></td>
	                      </tr>
				<%
		    } 
		    rs.close();	
			
			
	%>
	       
		
	<%
	 
	//When billing client is  not self then manager and hod will be shown
	
		if(strBilling_Client != null && !strBilling_Client.equals("self"))
		{
	%>
	        <tr>
	          <td height="0" colspan="11" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.requestdetails.approvallevel",strsesLanguage) %></td>
	        </tr>
		    <tr>
			     <td colspan="11" class="reportLBL">
	              <table width="100%" border="0" cellspacing="0" cellpadding="3">   
					<tr>
					  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage) %> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class="reportdata" >&nbsp; &nbsp; &nbsp;  &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<%=strManager%></span></td>
					  <td height="0" class="reportCaption" ></td>
					  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage) %> &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;  &nbsp; &nbsp;<span class="reportdata" > <%=strHod%> </span></td>
					  <td height="0" class="reportCaption" >&nbsp; </td>
					  <td height="0" class="reportdata" >&nbsp;</td>
					  <td height="0" class="reportdata" >&nbsp;</td>  
			       </tr>
			      	<tr>
				 
			   </table>	       
	<%
		}
	// if approval level 1 and 2 has been skip then the reason for skipping will be shown
	//	if(strSelectManagerRadio != null && strSelectManagerRadio.equals("skip"))
	//	{
		//System.out.println("strReasonForSkip==============="+strReasonForSkip);  
		
			if(strAppFlag.equalsIgnoreCase("Y")){
	%>
	<tr> 
					  <td height="0" colspan=2 class="reportCaption" ><%=dbLabelBean.getLabel("label.global.boardmember",strsesLanguage) %> </td>
					  <td height="0" class="reportCaption" ><span class="reportdata" > <%=strBoardMemberId%></span></td>
					  <td height="0" class="reportCaption">&nbsp;&nbsp;&nbsp;&nbsp;</td>
					  <td height="0" colspan=2 class="reportCaption" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.reasonforskipping",strsesLanguage) %> </td>     
					  <td height="0" class="reportCaption" ><span class="reportdata" > <%=strReasonForSkip%></span></td>  
					  <td height="0" class="reportCaption">&nbsp;&nbsp;&nbsp;&nbsp;</td>
	         		</tr>
	
	<%}else{ %>
	
	
					<tr> 
					  <td height="0" colspan=2 class="reportCaption" ><%=dbLabelBean.getLabel("label.global.reasonforskipping",strsesLanguage) %> </td>
					  <td height="0" class="reportCaption" ><span class="reportdata" > <%=strReasonForSkip%></span></td>  
					  <td height="0" class="reportdata" >&nbsp;</td>
					  <td height="0" class="reportCaption" >  <span class="reportdata" ><%//=strRemarks%></span></td>
					  <td height="0" class="reportCaption" >&nbsp; </td>
					  <td height="0" class="reportdata" >&nbsp;</td>
					  <td height="0" colspan="2" class="reportdata" >&nbsp;</td>
	         		</tr>
	<%}
	//	}
	%>
	<%
	       /*String strCurren = "";
		   strSql = "SELECT distinct currency FROM  T_TRAVEL_EXPENDITURE_INT WHERE TRAVEL_ID = "+strTravelId+"";	       
		   rs = dbConBean.executeQuery(strSql);
		   while(rs.next()) 
		   {  
				strCurren = rs.getString(1);			
		   } 
		   rs.close();*/		
	
		   /* strSql = "select case when sum(convert(decimal(20,2),Total_Amount))='0' then '-' else convert(varchar,sum(convert(decimal(20,2),Total_Amount)))  end as total_amount_of_group from t_group_userinfo where travel_type='i' and status_id=10 and  travel_id="+strTravelId+"";	       
		    rs = dbConBean.executeQuery(strSql);
		    while(rs.next()) 
		    {  
				strTotal_Amount = rs.getString(1);
				if(strTotal_Amount==null)
					{    strTotal_Amount="";
			        }else
				{
			        	//if else added by manoj chand on 01 Dec 2011 to show blank when currency amount is 0
			        	if(strTotal_Amount.equalsIgnoreCase("-")){
			        		
			        	}else{
			     	strTotal_Amount   = strTotal_Currency+"&nbsp;"+strTotal_Amount;  
			        	}
				}
				if(strTotal_Amount != null && strTotal_Amount.equals("0"))
				{
					strTotal_Amount   = "-";
					strTotal_Currency = ""; 
				}
		    } */
		  //added by manoj chand on 31 jan 2013 to get expenditure dtails
		    strSql = "SELECT dbo.FN_GET_EXPENDITURE('"+strTravelId+"','I') AS Expenditure";
		    rs = dbConBean.executeQuery(strSql);
		    if(rs.next()) 
		    {  
		    	strTotal_Amount = rs.getString("Expenditure");
		    }
		    rs.close();	
	
			if(strBilling_Client==null)
			{strBilling_Client="";
			}
	%>
	        <tr>
	          <td height="0" colspan="11" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.requestdetails.forexdetails",strsesLanguage) %></td>
	        </tr>
			<tr>
			     <td colspan="11" class="reportLBL">
	              <table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
					  <td height="0" class="reportCaption" colspan="1" width="20%"><%=dbLabelBean.getLabel("label.requestdetails.totalamountofgroupguest",strsesLanguage) %></td>
					  <td class="reportdata" width="40%"><span> <%=strTotal_Amount%> </span></td>
					  
					  <td height="0" class="reportCaption" colspan="1" width="15%"><%=dbLabelBean.getLabel("label.requestdetails.billingclient",strsesLanguage) %></td>
					  <td class="reportdata" width="25%"><span><%=strBilling_Client%> </span></td>
					</tr>
					  <tr>
					   <td height="0" class="reportCaption" colspan="1" width="20%"><%=dbLabelBean.getLabel("label.requestdetails.remarksforexpendituredetails",strsesLanguage) %></td>
					   <td class="reportdata" width="40%"><span> <%=strExpRemark%> </span></td>
					  <td height="0" class="reportCaption" colspan="1" width="15%"><%=dbLabelBean.getLabel("label.requestdetails.billingapprover",strsesLanguage) %></td>
					  <td class="reportdata" width="25%"><span><%=strBillingApprover%> </span></td>
					</tr> 
				</table>
			  </td>
			</tr>
	
	 <%if (strSHOW_BUD_INPUT.equalsIgnoreCase("Y")) { %>
			<tr>
	          <td height="0" colspan="11" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.global.budgetactualdetails",strsesLanguage) %></td>
	        </tr>
			<tr>
			<td colspan="11" class="reportLBL">
			  <table width="100%" border="0" cellspacing="0" cellpadding="3">
			  	<tr>
				  <td height="0" class="reportCaption" style="width: 100px;"><%=dbLabelBean.getLabel("label.global.ytmbudget",strsesLanguage) %></td>
		       	  <td height="0" class="reportdata" align="left"><%=strYTM_BUDGET%></td>
			   	  <td height="0" class="reportCaption" style="width: 90px;"><%=dbLabelBean.getLabel("label.global.ytdactual",strsesLanguage) %></td>
			      <td height="0" class="reportdata"  align="left"><%=strYTD_ACTUAL%></td>
			      <td height="0" class="reportCaption" style="width: 100px;"><%=dbLabelBean.getLabel("label.createrequest.availablebudget",strsesLanguage) %> </td>
				  <td height="0" class="reportdata"  align="left"><%=strAVAIL_BUDGET%> </td>
				  <td height="0" class="reportCaption" style="width: 140px;"><%=dbLabelBean.getLabel("label.global.estimatedexpenditure",strsesLanguage) %> </td>
				  <td height="0" class="reportdata"  align="left"><%=strEST_EXP%></td> 
				</tr>
				<tr>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage) %> </td>
				  <td colspan="7" height="0" class="reportdata" ><%=strEXP_REMARKS%></td>
				</tr>
		       </table>
		    </td>
			</tr>
	
	<%} %>
	
	
			<tr>
	          <td height="0" colspan="11" class="reportSubHeading"><span><%=dbLabelBean.getLabel("label.requestdetails.currencydenominationdetails",strsesLanguage) %></span></td>
	        </tr>
			<tr>
	          <td height="0" colspan="11" class="reportCaption"><span><%=strCashBreakUpRemark%></span></td>
	        </tr>

	        <tr>
	          <td height="0" colspan="11" class="reportHeading" >&nbsp;</td>
	        </tr>
	
	      	<%
	            ResultSet rs4 = null;
			    strSql = "SELECT TRAVEL_STATUS_ID FROM  T_TRAVEL_STATUS WHERE  (TRAVEL_ID = "+strTravelId+") AND (TRAVEL_TYPE = 'i')";	
				String strTravelstatus  ="";
				rs4 = dbConBean2.executeQuery(strSql);
				while(rs4.next())
				{
	             strTravelstatus   = rs4.getString("TRAVEL_STATUS_ID");
				}
				rs4.close(); 
	             
	       if(strTravelstatus.equals("10"))
			   {
			%>
	       <!-- added link for Learms page for showing deatils of lerms after all approveral on 29 jan 2009 -->
			 <tr class="formhead">
	          <td height="0" colspan="8" class="listhead"   >&nbsp;<a href="#" class="reportLink" onClick="MM_openBrWindow('group_reqlermsDetails.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=I','Attachments','scrollbars=yes,resizable=yes,width=650,height=600')"><%=dbLabelBean.getLabel("label.requestdetails.clickheretoopenlermsdetail",strsesLanguage) %></a></td>
	
	        </tr>
	        <%}
	       dbConBean1.close();
	       dbConBean2.close();
	       
			%>

	      </table>
		</td>
	  </tr>
	</table>
	</body>
	</html>
