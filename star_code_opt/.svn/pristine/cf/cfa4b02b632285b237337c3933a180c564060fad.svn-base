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
	 *Modification 			:
	 *Reason of Modification:
	 *Date of Modification  :
	 *Modified By	        :
	 *Editor				:Editplus
	 *Modified By	        :Pankaj Dubey on 17 Nov 2010
	 *Revision History		:Added the budgetory details mentioned by request creator.
	 
	 *Modified By			:Manoj Chand
	 *Modification			:Show accomodation details on domestic group/guest request details page
	 *Date of modification  :27 Sep 2011
	 
	 *Editor		        :Eclipse 3.5 
	 
	 *Modified By			:Manoj Chand
	 *Modification			:Show Expenditure Remarks and Billing Approvers group domestic request details page
	 *Date of modification  :01 Dec 2011
	 
	 *Date of Modification  :29 Mar 2012
	 *Modified By	        :MANOJ CHAND	
	 *Description			:showing board member in details screen for SMP Division.
	 
	 *Date of Modification  :29 Nov 2012
	 *Modified By	        :MANOJ CHAND	
	 *Description			:showing total travel fare amount and currency for smp division only.
	 
	 *Date of Modification  :24 Jan 2013
	 *Modified By	        :MANOJ CHAND	
	 *Description			:showing travel mode and travel class value from table.
	 
	 *Modified By	        :MANOJ CHAND
	 *Date of Modification :31 Jan 2013
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
	<jsp:useBean id="dbmethod" scope="page" class="src.connection.DbUtilityMethods" />
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
	String strManager                  =  ""; 
	String strHod                         =  "";
	String strBoardMemberId		= "";
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
	
	
	//Below 5 fields Added by Pankaj on 17 Nov 2010
	String strYTM_BUDGET = ""; 
	String strYTD_ACTUAL = ""; 
	String strAVAIL_BUDGET = ""; 
	String strEST_EXP = ""; 
	String strEXP_REMARKS = "";
	
	String strTatkaalRequired ="";	
	String strCoupanRequired="";
	String strIdentityProof="";
	String strIdentityProofName="";
	
	String strSeatPrefer="";  
	String strTicketRefund="";
	
	String strRetTatkaalRequired	="";
	String strRetCoupanRequired     ="";
	String strTicketRefund2			="";	
	
	String strSeatprefered2			="";
	String strBillingApprover				=	"";
	String strTotalFareAmt="";
	String strTotalFareCur="";
	String strCurrency="-";
	
	//CODE ENDS
	strSql = "SELECT   ISNULL(TRAVEL_REQ_ID, '-') AS TRAVEL_REQ_ID, C_USERID, ISNULL(dbo.SITENAME_FROM_USERID(C_USERID), '-') AS UNIT,ISNULL(TRAVELLER_ID, '-') AS TRAVELLER_ID, ISNULL(AGE, '-') AS AGE, ISNULL(SEX, '-') AS SEX, ISNULL(dbo.MEAL_NAME(MEAL), '-') AS MEALNAME, ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE), '-') AS TRAVEL_DATE, ISNULL(REMARKS, '-') AS REMARKS, ISNULL(EXPENDITURE_REMARKS, '-')  AS EXPENDITURE_REMARKS,  DBO.USER_NAME(MANAGER_ID) AS MANAGER_ID , DBO.USER_NAME(HOD_ID) AS HOD_ID,BILLING_SITE, BILLING_CLIENT,REASON_FOR_TRAVEL, REASON_FOR_SKIP, ROUND(YTM_BUDGET ,0) YTM_BUDGET, ROUND(YTD_ACTUAL,0) YTD_ACTUAL, ROUND(AVAIL_BUDGET ,0) AVAIL_BUDGET, ROUND(EST_EXP,0) EST_EXP, EXP_REMARKS,DBO.USER_NAME(BOARD_MEMBER_ID) AS BOARD_MEMBER_ID,T_TRAVEL_DETAIL_DOM.SITE_ID,TA_CURRENCY,FARE_CURRENCY,FARE_AMOUNT FROM T_TRAVEL_DETAIL_DOM WHERE TRAVEL_ID="+strTravelId+" AND APPLICATION_ID=1 AND (Group_Travel_Flag = 'y')";
	//query changed by manoj chand on 01 dec 2011 to get billing approver name
	//strSql = "SELECT   ISNULL(TRAVEL_REQ_ID, '-') AS TRAVEL_REQ_ID, C_USERID, ISNULL(dbo.SITENAME_FROM_USERID(C_USERID), '-') AS UNIT,ISNULL(TRAVELLER_ID, '-') AS TRAVELLER_ID, ISNULL(AGE, '-') AS AGE, ISNULL(SEX, '-') AS SEX, ISNULL(dbo.MEAL_NAME(MEAL), '-') AS MEALNAME, ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE), '-') AS TRAVEL_DATE, ISNULL(REMARKS, '-') AS REMARKS, ISNULL(EXPENDITURE_REMARKS, '-')  AS EXPENDITURE_REMARKS,  DBO.USER_NAME(MANAGER_ID) AS MANAGER_ID , DBO.USER_NAME(HOD_ID) AS HOD_ID,BILLING_SITE, dbo.user_name(BILLING_CLIENT) AS BILLING_CLIENT,REASON_FOR_TRAVEL, REASON_FOR_SKIP, ROUND(YTM_BUDGET ,0) YTM_BUDGET, ROUND(YTD_ACTUAL,0) YTD_ACTUAL, ROUND(AVAIL_BUDGET ,0) AVAIL_BUDGET, ROUND(EST_EXP,0) EST_EXP, EXP_REMARKS FROM T_TRAVEL_DETAIL_DOM WHERE TRAVEL_ID="+strTravelId+" AND APPLICATION_ID=1 AND STATUS_ID=10   AND (Group_Travel_Flag = 'y')";
		
	//ISNULL(EXPENDITURE_REMARKS,'-') AS EXPENDITURE_REMARKS
	
	
	
	rs       =   dbConBean.executeQuery(strSql);  
	if(rs.next())
	{ 
			strTravelReqId       = rs.getString("TRAVEL_REQ_ID");
			strCUserId    = rs.getString(2);
			// 
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
			
			
			
			strDepDate           = rs.getString("TRAVEL_DATE");
			strRemarks    		 = rs.getString("REMARKS");
	
			strManager		= rs.getString("MANAGER_ID");
	
			strHod			= rs.getString("HOD_ID");
	     	if(strManager == null) {
	                 strManager    =  "-";
	         }
			if(strHod == null) {   
	                 strHod    =  "-";
	        }
	
			strBilling_site=rs.getString("BILLING_SITE");
			strBilling_Client=rs.getString("BILLING_CLIENT");
	//System.out.println("billing site---->"+strBilling_site);
	//System.out.println("billing client---->"+strBilling_Client);
	 		strReasonForSkip     = rs.getString("REASON_FOR_SKIP");
	
			//strTotal_Currency = rs.getString("TA_CURRENCY");
	      
	 		//Below 5 fields Added by Pankaj on 17 Nov 2010
			try{
			strYTM_BUDGET = rs.getString("YTM_BUDGET"); 
			strYTD_ACTUAL = rs.getString("YTD_ACTUAL"); 
			strAVAIL_BUDGET = rs.getString("AVAIL_BUDGET"); 
			strEST_EXP = rs.getString("EST_EXP"); 
			strEXP_REMARKS = rs.getString("EXP_REMARKS");
			strBoardMemberId = rs.getString("BOARD_MEMBER_ID");
			if(strBoardMemberId == null || strBoardMemberId.equalsIgnoreCase("")) {
				strBoardMemberId    =  "-";
            }
			strSiteId= rs.getString("SITE_ID");
			strCurrency=rs.getString("TA_CURRENCY");
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
	strSql = "select ISNULL(EXP_REMARKS,'-') AS EXP_REMARKS from T_GROUP_USERINFO where T_GROUP_USERINFO.TRAVEL_ID="+strTravelId+" AND T_GROUP_USERINFO.TRAVEL_TYPE='D' and APPLICATION_ID=1 AND STATUS_ID=10";
	rs       =   dbConBean.executeQuery(strSql);  
	if(rs.next())
	{
	strExpRemark		= rs.getString("EXP_REMARKS").trim();
	if(strExpRemark.equalsIgnoreCase(""))
		strExpRemark="-";
	}
	rs.close();
	
	////added new by shiv on 02-Nov-07 
	
	   if (strBilling_site!=null && !strBilling_site.equals("0") && !strBilling_site.equals(strTravelId) &&  !strBilling_site.equals("-1")) 
	    ///normal case  when user site is biling site  
	      {
	     	if(strBilling_Client ==null || strBilling_Client.equals(""))
			{
			strBilling_Client ="--";
			}
	else{ 
			//int intBilling_Client =Integer.parseInt(strBilling_Client);  
	  	    //strSql = "select site_name from m_site where site_id=(select billing_site from t_travel_detail_DOM where TRAVEL_ID="+strTravelId+")";
	  	    //query changed by manoj chand on 01 dec 2011 to fetch sitename and billing approver name
	  	    strSql = "SELECT .DBO.SITENAME(BILLING_SITE)  AS SITE_NAME,dbo.user_name(BILLING_CLIENT) AS BILLING_CLIENT FROM T_TRAVEL_DETAIL_DOM WHERE TRAVEL_ID ="+strTravelId;
	 	    rs       =   dbConBean.executeQuery(strSql);  
		   while(rs.next())
		     {
			strBilling_Client = rs.getString("SITE_NAME");
			strBillingApprover=rs.getString("BILLING_CLIENT");
		      }
		rs.close();
	}
	
	}
	 
 
	
	   	
	//Code for getting the cash Breakup info 
	//Code starts  if strBilling client is null,means the site is paying for it 
	if((strBilling_Client==null) || (strBilling_Client.equals("")) || strBilling_Client.equals("-") || strBilling_Client.equals("-1"))
	{
		//strSql = "select site_name from m_site where site_id=(select billing_site from t_travel_detail_DOM where TRAVEL_ID="+strTravelId+")";
	//query changed by manoj chand on 01 dec 2011 to fetch sitename and billing approver name
	  	    strSql = "SELECT .DBO.SITENAME(BILLING_SITE)  AS SITE_NAME,dbo.user_name(BILLING_CLIENT) AS BILLING_CLIENT FROM T_TRAVEL_DETAIL_DOM WHERE TRAVEL_ID ="+strTravelId;
	 	   
		rs       =   dbConBean.executeQuery(strSql);  
		while(rs.next())
		{
			strBilling_Client = rs.getString("site_name");
			strBillingApprover=rs.getString("BILLING_CLIENT");
		}
		rs.close();
	}
	if(strBilling_Client == null)
	{
	    strBilling_Client  =  "-";
	}
	
	//Code ends if strBilling client is null,means the site is paying for it 
	// 
	
	// 
	 
	//when billing client is self then no manager and no hod
	if(strBilling_Client != null && strBilling_Client.equals("self"))
	{
	  strManager = "-";   
	  strHod = "-";
	}
	 
	//getting value from m_userinfo closed
	/*
	strSql = "select ISNULL(dbo.user_name(userid),'-')AS USERNAME,ISNULL(PASSPORT_NO,'-')AS PASSPORT_NO,ISNULL(dbo.CONVERTDATEDMY1(DATE_ISSUE),'-') AS DATE_ISSUE,ISNULL(PLACE_ISSUE,'-') AS PLACE_ISSUE,ISNULL(dbo.CONVERTDATEDMY1(EXPIRY_DATE),'-') AS EXPIRY_DATE,ISNULL(ADDRESS,'-') AS ADDRESS ,ISNULL(CONTACT_NUMBER,'-') AS CONTACT_NUMBER,ISNULL(FF_NUMBER,'-') AS FF_NUMBER,ISNULL(FF_NUMBER1,'-') AS FF_NUMBER1,ISNULL(FF_NUMBER2,'-') AS FF_NUMBER2,ISNULL(dbo.CONVERTDATEDMY1(DOB),'-')AS DOB,ISNULL(dbo.SITENAME(SITE_ID),'-')AS COMPANYNAME,ISNULL(ECNR,'-') AS ECNR,ISNULL(dbo.DESIG_FROM_USERID(userid),'-') AS DESIGNAME,    ISNULL(CURRENT_ADDRESS,'') AS CURRENT_ADDRESS, ISNULL(FF_AIR_NAME,'') AS FF_AIR_NAME, ISNULL(FF_AIR_NAME1,'') AS FF_AIR_NAME1, ISNULL(FF_AIR_NAME2,'') AS FF_AIR_NAME2 from m_userinfo  where userid ='"+strUserId+"'";  // on the basis of traveller id 
	
	
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
		else
		{
		strEcnr="No";
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
	*/
	// query for return journey     
  //QUERY CHANGED BY MANOJ CHAND ON 24 JAN 2013 TO FETCH TRAVEL MODE NAME AND TRAVEL CLASS NAME INSTEAD OF THEIR ID'S
	/*strSql="SELECT ISNULL(RETURN_FROM,'-')AS RETURN_FROM, ISNULL(RETURN_TO,'-') AS RETURN_TO,  "+ 
	        " ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE),'-') AS RETURN_DATE, ISNULL(RTRIM(LTRIM(TRAVEL_MODE)),'-') AS TRAVEL_MODE, "+ 
	        " ISNULL(MODE_NAME,'-') AS MODE_NAME , ISNULL(RTRIM(LTRIM(TRAVEL_CLASS)),'-') AS TRAVEL_CLASS, "+
	        " ISNULL(RTRIM(LTRIM(TIMINGS)),'-') AS TIMINGS,TICKET_REFUNDABLE,isnull(M_SEAT_PREFER.Seat_Name,'')AS  Seat_Name "+
            " FROM  T_RET_JOURNEY_DETAILS_DOM left outer JOIN  M_SEAT_PREFER ON " +
	        " T_RET_JOURNEY_DETAILS_DOM.SEAT_PREFFERED = M_SEAT_PREFER.seat_id WHERE TRAVEL_ID='"+strTravelId+"'AND JOURNEY_ORDER=1  ";*/
	 
	strSql="SELECT ISNULL(RETURN_FROM,'-')AS RETURN_FROM, ISNULL(RETURN_TO,'-') AS RETURN_TO,  "+ 
	        " ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE),'-') AS RETURN_DATE, RTRIM(LTRIM(dbo.TRAVEL_MODE_NAME(TRAVEL_MODE))) AS TRAVEL_MODE, "+ 
	        " ISNULL(MODE_NAME,'-') AS MODE_NAME , RTRIM(LTRIM(DBO.TRAVEL_CLASS_NAME(TRAVEL_MODE,TRAVEL_CLASS))) AS TRAVEL_CLASS, "+
	        " ISNULL(RTRIM(LTRIM(TIMINGS)),'-') AS TIMINGS,TICKET_REFUNDABLE,isnull(M_SEAT_PREFER.Seat_Name,'')AS  Seat_Name "+
            " FROM  T_RET_JOURNEY_DETAILS_DOM left outer JOIN  M_SEAT_PREFER ON " +
	        " T_RET_JOURNEY_DETAILS_DOM.SEAT_PREFFERED = M_SEAT_PREFER.seat_id WHERE TRAVEL_ID='"+strTravelId+"'AND JOURNEY_ORDER=1  ";
	// query for return journey ends 
	//System.out.println("strSql---gr-dom1-->"+strSql);
	          
	
	rs       =   dbConBean.executeQuery(strSql);  
	 if(rs.next())
	 {
		strRetrunDepCity	= rs.getString("RETURN_FROM");	
		strRetrunArrCity	= rs.getString("RETURN_TO");	
		
		strReturnDate        = rs.getString("RETURN_DATE");	
		strTravelMode2       = rs.getString("TRAVEL_MODE");
		//commmented by manoj chand on 24 jan 2013 because travel_mode name fetch direct from query.
		/*if(strTravelMode2!=null)
		{
			if(strTravelMode2.trim().equals("1"))
			{
			strTravelMode2="Air";
			}
			else
			{
			strTravelMode2="Train";
			}
		}*/
		strNameOfAirline2    = rs.getString("MODE_NAME");
		strTravelClass2      = rs.getString("TRAVEL_CLASS");
		strPreferTime2       = rs.getString("TIMINGS");
		strTicketRefund2     =rs.getString("TICKET_REFUNDABLE"); 
		
		strSeatprefered2     =rs.getString("Seat_Name");
		
		
		if (strTicketRefund2.equals("y")){
			strTicketRefund2="Yes";
		}else{
			strTicketRefund2="No"; 
		} 
	
	}
		rs.close();
	
		strSql = "select ISNULL(PREFER_TIME,'-') AS PREFER_TIME from M_Prefer_TIME where TIME_ID ='"+strPreferTime2+"'";
	
		
		rs       =   dbConBean.executeQuery(strSql);  
		   while(rs.next())
		   {
			strPreferTime2 = rs.getString(1);
		   }
		   rs.close();
	
		/*if(strTravelMode2.equals("Train"))
			strSql =   "SELECT DISTINCT TRAIN_ID, ISNULL(ELIGIBILITY,'-') AS ELIGIBILITY FROM M_TRAIN_CLASS WHERE STATUS_ID=10 and TRAIN_ID='"+strTravelClass2+"'";
	         else
			strSql =   "SELECT DISTINCT AIR_ID, ISNULL(ELIGIBILITY,'-') AS ELIGIBILITY FROM M_AIRLINE_CLASS WHERE STATUS_ID=10 and AIR_ID='"+strTravelClass2+"'";
	     rs       =   dbConBean.executeQuery(strSql);  
		   while(rs.next())
		   {
		   strELIGIBILITY2=rs.getString(2);
		     
		   }
	rs.close();	*/
	strELIGIBILITY2=strTravelClass2;
	// query for Departure Journey starts
//QUERY CHANGED BY MANOJ CHAND ON 24 JAN 2013 TO FETCH TRAVEL MODE NAME AND TRAVEL CLASS NAME INSTEAD OF THEIR ID'S
	/*strSql=" SELECT ISNULL(TRAVEL_FROM,'-')AS TRAVEL_FROM, ISNULL(TRAVEL_TO,'-') AS TRAVEL_TO,  "+
	       " ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE),'-') AS TRAVEL_DATE, ISNULL(RTRIM(LTRIM(TRAVEL_MODE)),'-') AS TRAVEL_MODE, "+
	       " ISNULL(MODE_NAME,'-') AS MODE_NAME, ISNULL(RTRIM(LTRIM(TRAVEL_CLASS)),'-') AS TRAVEL_CLASS, ISNULL(RTRIM(LTRIM(TIMINGS)),'-') AS TIMINGS, "+
	       " isnull(M_SEAT_PREFER.Seat_Name,'')AS  Seat_Name,TICKET_REFUNDABLE FROM    T_JOURNEY_DETAILS_DOM left outer JOIN  M_SEAT_PREFER ON "+ 
	       " T_JOURNEY_DETAILS_DOM.SEAT_PREFFERED = M_SEAT_PREFER.seat_id WHERE T_JOURNEY_DETAILS_DOM.TRAVEL_ID='"+strTravelId+"' AND  "+
	       " T_JOURNEY_DETAILS_DOM.JOURNEY_ORDER=1  AND T_JOURNEY_DETAILS_DOM.APPLICATION_ID=1";*/  

	strSql=" SELECT ISNULL(TRAVEL_FROM,'-')AS TRAVEL_FROM, ISNULL(TRAVEL_TO,'-') AS TRAVEL_TO,  "+
	       " ISNULL(dbo.CONVERTDATEDMY1(TRAVEL_DATE),'-') AS TRAVEL_DATE, RTRIM(LTRIM(dbo.TRAVEL_MODE_NAME(TRAVEL_MODE))) AS TRAVEL_MODE, "+
	       " ISNULL(MODE_NAME,'-') AS MODE_NAME, RTRIM(LTRIM(DBO.TRAVEL_CLASS_NAME(TRAVEL_MODE,TRAVEL_CLASS))) AS TRAVEL_CLASS, ISNULL(RTRIM(LTRIM(TIMINGS)),'-') AS TIMINGS, "+
	       " isnull(M_SEAT_PREFER.Seat_Name,'')AS  Seat_Name,TICKET_REFUNDABLE FROM    T_JOURNEY_DETAILS_DOM left outer JOIN  M_SEAT_PREFER ON "+ 
	       " T_JOURNEY_DETAILS_DOM.SEAT_PREFFERED = M_SEAT_PREFER.seat_id WHERE T_JOURNEY_DETAILS_DOM.TRAVEL_ID='"+strTravelId+"' AND  "+
	       " T_JOURNEY_DETAILS_DOM.JOURNEY_ORDER=1  AND T_JOURNEY_DETAILS_DOM.APPLICATION_ID=1";
	//query for departure journey ends
	//System.out.println("strSql---gr-dom2-->"+strSql);
        
 	
	
	rs       =   dbConBean.executeQuery(strSql);  
	    if(rs.next())
	    {
			strDepCity           = rs.getString("TRAVEL_FROM");
			strArrCity           = rs.getString("TRAVEL_TO");
			strJTravelDate    	 = rs.getString("TRAVEL_DATE");
			strTravelMode1       = rs.getString("TRAVEL_MODE"); 
			
			/*if (strTravelMode1.equals("0"))
			 {
				strTravelMode1="1";
			}
	
			if(strTravelMode1!=null)
			{
				if(strTravelMode1.trim().equals("1"))
				{
				strTravelMode1="Air";
				}
				if(strTravelMode1.trim().equals("2")) 
				{
				strTravelMode1="Train";
				}
				if(strTravelMode1.trim().equals("3"))
				{
				strTravelMode1="Cab";
				}
			}*/
			
			strNameOfAirline1    = rs.getString("MODE_NAME");
			strTravelClass1      = rs.getString("TRAVEL_CLASS");
			strPreferTime1       = rs.getString("TIMINGS");
			
			//code added for showing seat  prefference and ticket refund on 12 jan 2009 by shiv sharma 
			strSeatPrefer       = rs.getString("Seat_Name");
			strTicketRefund     = rs.getString("TICKET_REFUNDABLE");  
			
			if (strTicketRefund.equals("y")){
				strTicketRefund="Yes";
			}else{
				strTicketRefund="No";
			} 
			
			
		}
		rs.close();  
	
		 
		
		strSql = "select ISNULL(PREFER_TIME,'-') AS PREFER_TIME from M_Prefer_TIME where TIME_ID ='"+strPreferTime1+"'";
		
		 
		rs       =   dbConBean.executeQuery(strSql);  
		   while(rs.next())
		   {
			strPreferTime1 = rs.getString(1); 
		   }
		   rs.close(); 
		   
		
	
	/*	if(strTravelMode1.equals("Train"))
		{strSql =   "SELECT TRAIN_ID, ISNULL(ELIGIBILITY,'-') AS ELIGIBILITY  FROM M_TRAIN_CLASS WHERE STATUS_ID=10 and TRAIN_ID='"+strTravelClass1+"'";
		}
	   if(strTravelMode1.equals("Air")){
			strSql =   "SELECT AIR_ID, ISNULL(ELIGIBILITY,'-') AS ELIGIBILITY  FROM M_AIRLINE_CLASS WHERE STATUS_ID=10 and AIR_ID='"+strTravelClass1+"'";
			}
	    if(strTravelMode1.equals("Cab"))
		   {strSql =   "SELECT CAB_ID, ISNULL(ELIGIBILITY,'-') AS ELIGIBILITY  FROM M_CAB_CLASS WHERE STATUS_ID=10 and CAB_ID='"+strTravelClass1+"'";
		}
	  
  
	     
	     rs       =   dbConBean.executeQuery(strSql);  
		   while(rs.next())
		   {
		   strELIGIBILITY=rs.getString(2); 
		   }
	rs.close();	*/
	strELIGIBILITY=strTravelClass1;

	  
	
	%>
	
	
	
	
	
	
	<body>
	 <table width="100%" align="center" border="0" >
	  <tr>
	    <td align="center">
		  <table width="100%" border="0" cellpadding="2" cellspacing="1" class="reporttble">
	        <tr>
	          <td  height="0" colspan="11" align="left" class="reportHeading" ><%=dbLabelBean.getLabel("label.requestdetails.allinformation",strsesLanguage) %>  <font size="1"></font></td>
	        </tr> 
	        <%
	        
	    	
			strSql = " SELECT  FORWARD_TATKAAL, FORWARD_COUPAN,RETURN_TATKAAL,RETURN_COUPAN "+ 
            "  FROM  T_TRAVEL_DETAIL_DOM where travel_id="+strTravelId;	
	
	

		rs = dbConBean.executeQuery(strSql);
		  while(rs.next()){ 

				  strTatkaalRequired=rs.getString("FORWARD_TATKAAL");  
				  
				 
				  
				  
			        if (strTatkaalRequired.equals("")) {
						strTatkaalRequired="";
					 }
				   if (strTatkaalRequired.equalsIgnoreCase("Y")) {
			             strTatkaalRequired="Yes";
					  }
				  else if (strTatkaalRequired.equalsIgnoreCase("N")){
					     strTatkaalRequired="No";
					  } 
				  
				   
			     strCoupanRequired=rs.getString("FORWARD_COUPAN");  
			     
			     
			        if (strCoupanRequired.equals("")) {
						strCoupanRequired="";
					 }
			      if (strCoupanRequired.equalsIgnoreCase("Y")) { 
			             strCoupanRequired="Yes";
					  }
				  else if (strCoupanRequired.equalsIgnoreCase("N")) {
					     strCoupanRequired="No";
				  } 
			      
	
				  strRetTatkaalRequired=rs.getString("RETURN_TATKAAL");  
				  
		 
				  
			        if (strRetTatkaalRequired.equals("")) {
			        	strRetTatkaalRequired="";
					 }
				   if (strRetTatkaalRequired.equalsIgnoreCase("Y")) {
					   strRetTatkaalRequired="Yes";
					  }
				  else if (strRetTatkaalRequired.equalsIgnoreCase("N")){
					  strRetTatkaalRequired="No"; 
					  } 
				   
				   
			     strRetCoupanRequired=rs.getString("RETURN_COUPAN");  
			     
			     
			      
			        if (strRetCoupanRequired.equals("")) {
			        	strRetCoupanRequired="";
					 }
			      if (strRetCoupanRequired.equalsIgnoreCase("Y")) {
			    	  strRetCoupanRequired="Yes";
					  }
				  else if (strRetCoupanRequired.equalsIgnoreCase("N")) {
					  strRetCoupanRequired="No";
				  }  
			      
       }       
	        %>
	         
	        
	        <tr>
	          <td height="0" colspan="11" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.requestdetails.itineraryinformationgroupguest",strsesLanguage) %> </td>
	        </tr>
			<tr>
			     <td colspan="11" class="reportLBL">
	              <table width="100%" border="0" cellspacing="0" cellpadding="3">
				<tr>
					<td height="0" class="reportCaption"><%=dbLabelBean.getLabel("label.global.forwardjourney",strsesLanguage) %></td>  
					<td height="0" class="reportCaption"></td>
					<td height="0" class="reportCaption"></td>
					<td height="0" class="reportCaption"></td>
				</tr>
				
				<tr>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage) %></td>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage) %></td>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage) %></td>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage) %></td>
				</tr>
				<tr>
				  <td height="0" class="reportdata" ><%=strDepCity.toUpperCase()%></td>   
				  <td height="0" class="reportdata" ><%=strArrCity.toUpperCase()%></td>
				  <td height="0" class="reportdata" ><%=strJTravelDate%></td>
				  <td height="0" class="reportdata" ><%=strPreferTime1.toUpperCase()%></td>
				</tr>
				<tr>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.mode",strsesLanguage) %></td>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.class",strsesLanguage) %></td>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.preferredairlinetraincab",strsesLanguage) %></td>  
				  <td height="0" class="reportdata" > </td>
				</tr>
				<tr>
				  <td height="0" class="reportdata" ><%=strTravelMode1.toUpperCase()%></td>
				  <td height="0" class="reportdata" ><%=strELIGIBILITY.toUpperCase()%></td>
				  <td height="0" class="reportdata" ><%=strNameOfAirline1.toUpperCase()%></td>
				  <td height="0" class="reportdata" ></td>
				</tr>
				<tr>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.tatkaalrequired",strsesLanguage) %></td>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.couponticketrequired",strsesLanguage) %></td>
				  <td height="0" class="reportCaption" > <%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage) %> </td>  
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage) %></td>
				</tr>
				<tr>
				  <td height="0" class="reportdata" ><%=strTatkaalRequired%></td>
				  <td height="0" class="reportdata" ><%=strCoupanRequired%></td>    
				  <td height="0" class="reportdata" ><%=strSeatPrefer%></td> 
				  <td height="0" class="reportdata" ><%=strTicketRefund%></td>
				</tr>
				

						
				<% 
				
				
				//System.out.println("strReturnDate============321 ========"+strReturnDate); 
				if (!strReturnDate.equals("") && strReturnDate!=null && !strReturnDate.equals("-"))    
				{  
					/*strReturnDate="-"; 
					strPreferTime2="-";
					strTravelMode2="-";
					strNameOfAirline2="-";
					strELIGIBILITY2="-";
					*/
					
				
				
				%>
		
 				
				
				 <tr>
				<td height="0" class="reportCaption"><%=dbLabelBean.getLabel("label.global.returnjourney",strsesLanguage) %></td>
				<td height="0" class="reportCaption"></td>
				<td height="0" class="reportCaption"></td>
				<td height="0" class="reportCaption"></td>     
			    </tr>
			
				
				<tr>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage) %></td>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage) %></td>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage) %></td>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage) %></td>
				</tr>
				<tr>
				  <td height="0" class="reportdata" ><%=strRetrunDepCity.toUpperCase()%></td> 
				  <td height="0" class="reportdata" ><%=strRetrunArrCity.toUpperCase()%></td>
				  <td height="0" class="reportdata" ><%=strReturnDate%></td>
				  <td height="0" class="reportdata" ><%=strPreferTime2.toUpperCase()%></td>
				</tr>
				<tr>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.mode",strsesLanguage) %></td>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.class",strsesLanguage) %></td>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.preferredairlinetraincab",strsesLanguage) %></td>      
				  <td height="0" class="reportdata" > </td>
				</tr>
				<tr>
				  <td height="0" class="reportdata" ><%=strTravelMode2.toUpperCase()%></td>
				  <td height="0" class="reportdata" ><%=strELIGIBILITY2.toUpperCase()%></td>
				  <td height="0" class="reportdata" ><%=strNameOfAirline2.toUpperCase()%></td>
				  <td height="0" class="reportdata" ></td>
				</tr>
				<tr>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.tatkaalrequired",strsesLanguage) %></td>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.couponticketrequired",strsesLanguage) %></td> 
				  <td height="0" class="reportCaption" >  <%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage) %> </td>  
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage) %></td>
				</tr>
				<tr>
				  <td height="0" class="reportdata" ><%=strRetTatkaalRequired%></td>
				  <td height="0" class="reportdata" ><%=strRetCoupanRequired%></td>
				  <td height="0" class="reportdata" ><%=strSeatprefered2%></td>
				  <td height="0" class="reportdata" ><%=strTicketRefund2%></td>
				</tr>
				
			  <%} %> 
			  
		<%	  //added by manoj chand on 29 march 2012 to show board members for smp case
		strSql="select md.SHOW_APP_LVL_3 from M_DIVISION md inner join M_SITE ms on ms.DIV_ID=md.DIV_ID where ms.SITE_ID="+strSiteId;
		//System.out.println("strSql----45--->"+strSql);
		String strAppFlag="";		                        
		rs1 = dbConBean1.executeQuery(strSql);
			if(rs1.next())
			{
				strAppFlag=rs1.getString(1);
            }
			if(strAppFlag.equalsIgnoreCase("Y")){
			 %>  
			  <!-- ADDED BY MANOJ CHAND ON 28 NOV 2012 TO DISPLAY TOTAL TRAVEL FARE --> 
				<tr>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.farecurrency",strsesLanguage) %></td>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.totalfareamount",strsesLanguage) %></td> 
				  <td height="0" class="reportCaption" >&nbsp; </td>  
				  <td height="0" class="reportCaption" >&nbsp;</td>
				</tr>
				<tr>
				  <td height="0" class="reportdata" ><%=strTotalFareCur%></td>
				  <td height="0" class="reportdata" ><%=strTotalFareAmt%></td>
				  <td height="0" class="reportdata" >&nbsp;</td>
				  <td height="0" class="reportdata" >&nbsp;</td>
				</tr>
				<!-- End Here -->
				<%} %>
			  </table>
			</td>
		  </tr>   
	 
<!--  added by manoj to show accomodation details in group details 20 sept 2011 -->

<%	
	String strTransitType="";
	String strTransitTypeDesc="";
	String strTransitBudget="";
	String strOthers = "";
	strSql = "SELECT ISNULL(TRANSIT_TYPE,'-') AS TRANSIT_TYPE,ISNULL(CONVERT(VARCHAR(50),TRANSIT_BUDGET),'-') AS TRANSIT_BUDGET,ISNULL(BUDGET_CURRENCY,'-') AS BUDGET_CURRENCY,"+
			" ISNULL(dbo.CONVERTDATEDMY1(CHECK_IN_DATE),'-') AS CHECK_IN_DATE,ISNULL(dbo.CONVERTDATEDMY1(CHECK_OUT_DATE),'-') AS CHECK_OUT_DATE,REMARKS,CASE WHEN PLACE = '' THEN '-' ELSE PLACE END AS PLACE"+ 
			" FROM T_TRAVEL_DETAIL_DOM WHERE TRAVEL_ID="+strTravelId;	
//System.out.println("strSql==dom details===>"+strSql);
	rs = dbConBean.executeQuery(strSql);
	while(rs.next()){ 
	strTransitType=rs.getString("TRANSIT_TYPE");
	strTransitBudget= rs.getString("TRANSIT_BUDGET");
	strBudgetCurrency=rs.getString("BUDGET_CURRENCY");
	strCheckInDate=rs.getString("CHECK_IN_DATE");
	strCheckOutDate=rs.getString("CHECK_OUT_DATE");
	if(strCheckInDate!=null && strCheckInDate.trim().equals(""))
		strCheckInDate="-";
	if(strCheckOutDate!=null && strCheckOutDate.trim().equals(""))
		strCheckOutDate="-";
	strOthers=rs.getString("REMARKS");
	if(strOthers!=null && strOthers.trim().equals(""))
		strOthers="-";
	strPlace=rs.getString("PLACE");
	}
	rs.close();
%>

	 <tr>
	
			<td height="0" colspan="6" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.requestdetails.accomodationinformation",strsesLanguage) %> </td>
	    </tr>
	      <tr>
	        <td height="0"  width="10%" colspan="2" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.staytype",strsesLanguage) %></td>
			<% 
			if (strTransitType != null  && !strTransitType.equals("") && strTransitType.equals("1") ) {
				strTransitTypeDesc = "Hotel";
			} else if (strTransitType != null  && !strTransitType.equals("") && strTransitType.equals("2") ) 
			{
				strTransitTypeDesc = "Transit House";
				
			} else 
				strTransitTypeDesc	 =	 "No";
			%>
			<td height="0" width="30%" class="reportdata" ><%= strTransitTypeDesc %></td>
			<td height="0" width="10%" colspan="2" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage) %></td>
	        <td height="0" width="30%" class="reportdata" ><%=strPlace%></td>
		  </tr>
	      <tr>
	        <td height="0" colspan="2" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.budget",strsesLanguage) %></td>
		<%   if (strTransitBudget != null && !strTransitBudget.equals("0.0") && !strTransitBudget.equals("-")) { %>
	    		<td height="0" class="reportdata" > <%=strTransitBudget%></td>
	
	    <% } 
		   else 
		   {
			   strBudgetCurrency = "-";
		%>
				<td height="0" class="reportdata" >-</td>
		<% } %>
			<td height="0" colspan="2" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage) %></td>
	        <td height="0" class="reportdata" ><%=strBudgetCurrency%></td>
	      </tr>
		  <tr>
	          <td height="0" colspan="2" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage) %></td>
	          <td height="0" class="reportdata" ><%=strCheckInDate%></td>
	          <td height="0" colspan="2" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage) %></td>
	          <td height="0" class="reportdata" ><%=strCheckOutDate%></td>
	      </tr>
	  	  <tr>
	         <td height="0" colspan="2" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage) %></td>
	          <td height="0" class="reportdata" ><%= strOthers %></td>
		 	  <td height="0" colspan="2" class="reportCaption" ></td>
	          <td height="0" class="reportdata" >&nbsp;</td>
	      </tr>
	 
	 
	 <!-- End here -->
	 
	 
	 
	 
	 
	 
	 
	 
	        <tr>
	          <td height="0" colspan="11" class="reportSubHeading" > <%=dbLabelBean.getLabel("label.requestdetails.travelersinformationforwardjourney",strsesLanguage) %></td>
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
							    strSql = " select rtrim(first_name)+' '+rtrim(last_name) as Name,dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID, case when Gender=1 then 'Male' else 'Female' end as Gender, ISNULL(dbo.SITENAME(SITE_ID),'-') AS UNIT, ISNULL(AGE,'-') AS AGE,ISNULL(dbo.MEAL_NAME(MAEL_ID),'-') AS  MEALNAME from t_group_userinfo where travel_type='d' and travel_id="+strTravelId+" and status_id=10";	 
						
								
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
	        if (!strReturnDate.equals("") && strReturnDate!=null && !strReturnDate.equals("-")) 
			{
	       %>
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
							    strSql = " select rtrim(first_name)+' '+rtrim(last_name) as Name,dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG_ID, case when Gender=1 then 'Male' else 'Female' end as Gender, ISNULL(dbo.SITENAME(SITE_ID),'-') AS UNIT, ISNULL(AGE,'-') AS AGE,ISNULL(dbo.MEAL_NAME(MAEL_ID),'-') AS  MEALNAME from t_group_userinfo where travel_type='d' and Return_travel='y' and travel_id="+strTravelId+" and status_id=10";	 
						
								
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
	        else{  
	       %>
	       <!-- 
	       <tr>  
	          <td height="0" colspan="11" class="reportSubHeading" >No Traveler(s) to Return </td>
	        </tr> 
	         -->
			
	       <%} %>
	  
	        <tr>  
	          <td height="0" colspan="11" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.requestdetails.identityproofdetailstravelers",strsesLanguage) %>  </td>
	        </tr>
			
	
	
			<tr>
			  <td width="5%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
			  <td width="20%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage) %></td>
			  <td width="20%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.identityname",strsesLanguage) %></td>
			  <td width="10%" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.identitynumber",strsesLanguage) %></td>
			 
		 
			  <td width="15%" colspan="3" height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.mobileno",strsesLanguage) %></td>
			 
	        </tr>
			<%
		    strSql = "select rtrim(first_name)+' '+rtrim(last_name) as Name,IDENTITY_ID, IDENTITY_NO, MOBILE_NO from t_group_userinfo where travel_type='d' and travel_id="+strTravelId+" and status_id=10 order by 1";	 
	        int intSNo = 0;
	 
		    rs = dbConBean.executeQuery(strSql);
		    while(rs.next()) 
		    {  
				%>
				                    <tr>
										<td height="0" class="reportdata" ><%= ++intSNo%></td>
										<td height="0" class="reportdata" ><%= rs.getString(1).toUpperCase() %></td>
				
					    <%
							strIdentityProof=rs.getString("IDENTITY_ID");
				   
						  if(dbmethod.checkforString(strIdentityProof)==1) 
											{
											strIdentityProofName=strIdentityProof;
										   }
								  else
										   {  
									
								      	strSql="SELECT  ISNULL(IDENTITY_NAME,'') AS IDENTITY_NAME FROM m_IDENTITY_PROOF WHERE  IDENTITY_ID="+strIdentityProof+" and STATUS_ID=10";
				                        
												rs1 = dbConBean1.executeQuery(strSql);
													while(rs1.next())
													{
														strIdentityProofName=rs1.getString("IDENTITY_NAME");
				                                 	}
										  	  
				
										   }	
				 
						%>
										<td height="0" class="reportdata" ><%=strIdentityProofName.toUpperCase() %></td>
										<td height="0" class="reportdata" ><%= rs.getString(3).toUpperCase() %></td>
										<td height="0" colspan="3" class="reportdata" ><%= rs.getString(4).toUpperCase() %></td>
										 
										 
				                      </tr>
				<%
					    } 
					    rs.close();	
						
						
				%>
				       
		
	<%
	 
	//When billing client is  not self then manager and hod will be shown
	//
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
					  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage) %> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class="reportdata" > <%=strManager%></span></td>
					  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage) %> &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp;<span class="reportdata" > <%=strHod%> </span></td>
					  <td height="0" class="reportCaption" >&nbsp; </td>
					  <td height="0" class="reportdata" >&nbsp;</td>
			</tr>
	<%
		}
	// if approval level 1 and 2 has been skip then the reason for skipping will be shown
	//	if(strSelectManagerRadio != null && strSelectManagerRadio.equals("skip"))
	//	{
			if(strAppFlag.equalsIgnoreCase("Y")){
	%>
	<tr>  
					  <td height="0"  class="reportCaption" ><%=dbLabelBean.getLabel("label.global.boardmember",strsesLanguage) %>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class="reportdata" ><%=strBoardMemberId%> </span></td>
					  <td height="0"  class="reportCaption" ><%=dbLabelBean.getLabel("label.global.reasonforskipping",strsesLanguage) %> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class="reportdata" ><%=strReasonForSkip%> </span></td>
					  <td height="0"  class="reportCaption" >&nbsp;&nbsp;</td> 
					  <td height="0"  class="reportCaption" >&nbsp;&nbsp;</td>  
				     
					 
					</tr>
	<%}else{ %>
					<tr>  
					  <td height="0"   colspan="1" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.reasonforskipping",strsesLanguage) %> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class="reportdata" ><%=strReasonForSkip%> </span></td>
					  <td height="0"   colspan="8" class="reportCaption" >&nbsp;&nbsp;</td>  
				     
					 
					</tr>
				<%} %>	 
				  
			   </table>  
	         </tr>
	<%
	//	}
	%>
	<%
	       /*String strCurren = "";
		   strSql = "SELECT distinct currency FROM  T_TRAVEL_EXPENDITURE_DOM WHERE TRAVEL_ID = "+strTravelId+"";	       
		   rs = dbConBean.executeQuery(strSql);
		   while(rs.next()) 
		   {  
				strCurren = rs.getString(1);			
		   } 
		   rs.close();	*/	
	
		  /*  strSql = "select case when sum(convert(decimal(20,2),Total_Amount))='0' then '-' else convert(varchar,sum(convert(decimal(20,2),Total_Amount)))  end as total_amount_of_group from t_group_userinfo where travel_type='d'and status_id=10 and  travel_id="+strTravelId+"";	       
		    rs = dbConBean.executeQuery(strSql);
		    if(rs.next()) 
		    {  
				strTotal_Amount = rs.getString(1);
				if(strTotal_Amount==null)
					{
						strTotal_Amount="";
			        }else
					{
			        	//if else added by manoj chand on 01 Dec 2011 to show blank when currency amount is 0
			        	if(strTotal_Amount.equalsIgnoreCase("-")){
			        		
			        	}else{
			     			strTotal_Amount   = strCurrency+"&nbsp;&nbsp;"+strTotal_Amount;
			        	}
				}
				if(strTotal_Amount != null && strTotal_Amount.equals("-"))
				{
					strTotal_Amount   = "-";
					strTotal_Currency = ""; 
				}
		    } */
		  //added by manoj chand on 31 jan 2013 to get expenditure dtails
		    strSql = "SELECT dbo.FN_GET_EXPENDITURE('"+strTravelId+"','D') AS Expenditure";
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
	          <td height="0" colspan="11" class="reportSubHeading" ><%=dbLabelBean.getLabel("label.createrequest.advancerequired",strsesLanguage) %></td>
	        </tr>
			<tr>
			     <td colspan="11" class="reportLBL">
	              <table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
					  <td height="0" class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.requestdetails.totalamountofgroupguest",strsesLanguage) %></td>
					  <td height="0"  class="reportdata" width="40%"><span><%=strTotal_Amount%></span></td>
					  <td height="0" class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.requestdetails.billingclient",strsesLanguage) %></td>
					  <td height="0" class="reportdata" width="25%"><span><%=strBilling_Client%> </span></td>
					</tr>
					  <tr>
					   <td height="0" class="reportCaption" width="20%"><%=dbLabelBean.getLabel("label.requestdetails.remarksforexpendituredetails",strsesLanguage) %></td>
					  <td height="0" class="reportdata" width="40%"><span> <%=strExpRemark%> </span></td>
					  <td height="0" class="reportCaption" width="15%"><%=dbLabelBean.getLabel("label.requestdetails.billingapprover",strsesLanguage) %></td>
					  <td height="0" class="reportdata" width="25%"><span><%=strBillingApprover%> </span></td> 
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
			  <table width="100%" border="0" cellspacing="0" cellpadding="3"><tr>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.ytmbudget",strsesLanguage) %></td>
		       	  <td height="0" class="reportdata" align="left"><%=strYTM_BUDGET%></td>
			   	  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.global.ytdactual",strsesLanguage) %> </td>
			      <td height="0" class="reportdata"  align="left"><%=strYTD_ACTUAL%></td>
			      <td height="0" class="reportCaption" style="width: 100px;"><%=dbLabelBean.getLabel("label.createrequest.availablebudget",strsesLanguage) %> </td>
				  <td height="0" class="reportdata"  align="left"><%=strAVAIL_BUDGET%> </td>
				  <td height="0" class="reportCaption" style="width: 140px;"><%=dbLabelBean.getLabel("label.global.estimatedexpenditure",strsesLanguage) %> </td>
				  <td height="0" class="reportdata"  align="left"><%=strEST_EXP%></td> 
				  <tr>
				  <td height="0" class="reportCaption" ><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage) %> </td>
				  <td colspan="7" height="0" class="reportdata" ><%=strEXP_REMARKS%></td>
				  </tr>
		      </tr></table>
		    </td>
			</tr>
	<%}
	 dbConBean1.close();
	 %>
	
	
	
			<tr>
	          <td height="0" colspan="11" class="reportSubHeading"> &nbsp;</td>
	        </tr>
			<tr>
	          <td height="0" colspan="11" class="reportCaption"><%//=strTotal_Currency%><%=strCashBreakUpRemark%></td>
	        </tr>
	
	
	 
	
	        <tr>
	          <td height="0" colspan="11" class="reportHeading" >&nbsp;</td>
	        </tr>
	      </table>
		</td>
	  </tr>
	</table>
	</body>
	</html>
