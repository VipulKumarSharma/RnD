<%@page import="org.apache.log4j.Level"%>
<%@page import="java.util.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.log4j.Logger"%>
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
<jsp:useBean id="dbConBean3" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />
<jsp:useBean id="mailDaoImpl" scope="page" class="src.dao.MailDaoImpl"/>
<%

	DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	Calendar cal = Calendar.getInstance();
	
	Logger logger=Logger.getLogger(this.getClass().getName()); 		
	logger.setLevel(Level.ALL);		

	// Global Variables declared and initialized
	request.setCharacterEncoding("UTF-8");
	String strSql, strSql2, strSql3    			=  null;            // String for Sql String
	Connection objCon               			=  null;            //Object for Connection 
	Connection objCon1              			=  null;            //Object for Connection 
	ResultSet rs,rs1,rs2, rs3, rsAccom 			=  null;            // Object for ResultSet
	CallableStatement objCstmt	    			=  null;		    // Object for Callable Statement
	Statement stmt								=  null;
	src.connection.DbConnectionBean db11 		=  null;
	src.travelBean.TravelBean travelBean1      	=  null;
	
	int intSuccess                  = 0;
	int intSuccess1                 = 0;
	int intSuccess2                 = 0;
	int intSuccess3                 = 0;
	int intSuccess4                 = 0;
	int intSuccess5                 = 0;
	int intSuccess6                 = 0;
	int intSuccess7                 = 0;
	int intSuccess8                 = 0;
	int intSuccess9                 = 0;
	int iSuccess 					= 0;
	int iSuccess1					= 0;
	int iSuccess2				    = 0;
	int iSuccess3					= 0;
	int iSuccess4					= 0;
	int iSuccess5					= 0;
	int iSuccess6					= 0;
	int iSuccess7					= 0;
	int iSuccess8					= 0;
	int intCounter                  = 0;	
	
	String strIPAddress 			= "127.1.1.1";   
	strIPAddress 					= request.getRemoteAddr();
	
	String strSiteId                =  "";
	String strUserId                =  "";
	String strDesigName             =  "";
	String strAge                   =  "";
	String strGender 				=  "";
	String strSex                   =  "";
	String strMealId                =  ""; 

	String strDepCity[]             =  null; 
	String strArrCity[]             =  null;
	String strDepDate[]             =  null;                              
	String strPreferTime[]			=  null;
	String strTravelMode[]          =  null;
	String strTravelClass[]         =  null;
	String strNameOfAirline[]		=  null;	
	String strPreferSeat[]			=  null;
	
	String strManager               =  ""; 
	String strHod                   =  ""; 
	String strBoardMember           =  "";
	String strSelectManagerRadio    =  ""; 
	String strReasonForTravel       =  "";
	String strReasonForSkip         =  "";	
	String strCostCentre			=  "";
	String strBillingSite 			=  "";
	String strBillingClient 		=  "";
	String strHidAppFlag			=  "";
	String strHidAppShowBMFlag		=  "";	
	
	String strVisaRequired          =  "";
	String strVisaComment           =  "";
	String strInsuranceRequired     =  "";
	String strNominee               =  ""; 
	String strRelation              =  ""; 
	String strInsuranceComment      =  "";

	String strHotelRequired         =  "";
	String strBudgetCurrency        =  "";
	String strHotelBudget           =  "";
	String strPlace                 =  "";
	String strCheckin				=  "";
	String strCheckout    			=  "";
	String strRemarks               =  "";

	String strTravelReqId           =  "";
	String strTravelId				=  "";
	String strTravelReqNo           =  "";
	String strInterimId             =  "";
	String strCancelledReqId		=  "0";
	
	//String strInterId               =  "";
	String strParentId              =  "";
	
	String strCARD_TYPE  			=  "";
	String strCARD_HOLDER_NAME 		=  "";
	String strCARD_NUMBER1 			=  "";
	String strCARD_NUMBER2 			=  "";
	String strCARD_NUMBER3 			=  "";
	String strCARD_NUMBER4 			=  "";
	String strCVV_NUMBER 			=  "";
	String strCARD_EXP_DATE 		=  "";
		
	String strTravllerSiteId 		=  "";
	String strTravellerId 			=  "";	
	String strTravelType            =  "";	
	String strReturnType            =  ""; 
	String strActionFlag            =  "";
	String strMessage               =  "";
	String strUserRole              =  "";        
		
	String strRoleofTraveler   		=  "";
	String strIDofTraveler     		=  ""; 	
	String strWorkFlowName			=  "";
	strWorkFlowName					= SSstrSplRole;
		
	String strDepCityFwd 			= "";
	String strArrCityFwd 			= "";
	String strDepDateFwd 			= "";
	String strPreferTimeFwd			= "";
	String strTravelModeFwd 		= "";
	String strTravelClassFwd 		= "";
	String strNameOfAirlineFwd		= "";
	String strPreferSeatFwd			= "";
	
	String strDepCityRet 			= "";
	String strArrCityRet 			= "";
	String strDepDateRet 			= "";
	String strPreferTimeRet			= "";
	String strTravelModeRet 		= "";
	String strTravelClassRet 		= "";
	String strNameOfAirlineRet		= "";
	String strPreferSeatRet			= "";
	
	String strDepCityIntrmi 		= "";
	String strArrCityIntrmi 		= "";
	String strDepDateIntrmi 		= "";
	String strPreferTimeIntrmi		= "";
	String strTravelModeIntrmi 		= "";
	String strTravelClassIntrmi		= "";
	String strNameOfAirlineIntrmi	= "";
	String strPreferSeatIntrmi		= "";
	
	String strForTatkaalRequired	= "";
	String strForCoupanRequired		= "";
	String strRetTatkaalRequired	= "";
	String strRetCoupanRequired		= "";
	String strTicketRefundfwd 		= ""; 
	String strTicketRefundRtd 		= "";
		
	String strIdentityProof			= "";
	String strIdentityProofNo		= "";
	String strIdentityProofOld		= "";
	String strIdentityProofNoOld	= "";
	
	String radioEcnr				= "";
	String strContactNo		        = "";	
	String strDOB				    = "";
	String strPassportNo        	= "";
	String strNationality        	= "";
	String strPassportIssuePlace	= "";	
	String strPassportIssueDate		= "";		
	String strPassportExpireDate	= "";	
	String strPermanentAddress		= "";
	String strCurrentAddress	    = "";
	
	String fullName					=  "";
	String firstName				=  "";
	String lastName					=  "";
	
	String strAirLineName		    = "";
	String strAirLineName1		    = "";
	String strAirLineName2		    = "";
	String strAirLineName3		    = "";
	String strAirLineName4		    = "";
	String strAirLineNo		        = "";
	String strAirLineNo1		    = "";
	String strAirLineNo2		    = "";
	String strAirLineNo3		    = "";
	String strAirLineNo4		    = "";
	String strHotelName		    	=  "";
	String strHotelName1		  	=  "";
	String strHotelName2		  	=  "";
	String strHotelName3		 	=  "";
	String strHotelName4			=  "";
	String strHotelNo	 			=  "";
	String strHotelNo1				=  "";
	String strHotelNo2				=  "";
	String strHotelNo3 				=  "";
	String strHotelNo4 				=  "";
	
	String strBaseCurrency		    =  "";
	String strTotalAmount           =  "";
	String strExpenditureRemarks    =  "";
	String strCashBreakupRemarks    =  "";
	
	String strTotalFareCurrency		=  "";
	String strTotalFareAmount		=  "";
		
	//Fields for T_Travel_Expenditure_Int Table 
    String strExpID[]               =  {"1","2","3","4"};
    String strTACurrency[]          = null; 
    String strEntPerDay[]           =  null;
    String strTotalTourDay[]        =  null;
    String strTotalForex[]          =  null; 
    String strContingecies[]        =  null;
    String strEntPerDay2[]	        =  null;
    String strContingecies2[]       =  null;
    String strTotalTourDay2[]       =  null;
    String strExRate[]        	    =  null;
    String strTotalINR[]        	=  null;
    String strHiddenValue[]		    =  null;
       
    String strTravellerCheque       =  "";
	String strTravellerCheque1      =  "";
	String strTravellerCheque2      =  "";
	
	String strTCCurrency            =  "";
	String strTCCurrency1           =  "";
	String strTCCurrency2           =  "";
	
	String dbl_YTM_BUDGET           = "";
	String dbl_YTD_ACTUAL           = "";
	String dbl_AVAIL_BUDGET         = "";
	String dbl_EST_EXP              = "";
	String str_EXP_REMARKS          = "";
	
	String strmataprice             = "";  
    
	//Fields for T_Cash_BreakUp_Int Table
	String strCashAmount1           =  "";
	String strCashAmount2           =  "";
	String strCashAmount3           =  "";
	String strCashAmount4           =  "";

    String strCashCurrency1         =  "";
    String strCashCurrency2         =  "";
    String strCashCurrency3         =  "";
    String strCashCurrency4         =  "";
    
    String strLAprice               = "";
	String strLAAirLine             = "";
	String strLACurrency            = "";
	String strLAPrice               = "";
	String strLARemarks             = "";
	  
	String strTkAgent 		        = ""; 
	String strTkAirLine 	        = ""; 
	String strTkcurrency 	        = ""; 
	String strTklocalprice 	        = ""; 
	String strTkRemarks 	        = ""; 

	String strPermanent_Req_No      =  "";
	String strJourneyOrder          =  "1";
	String strTravelStatusId        =  "1";  
	String strApproverId            =  "";   
	String strApproveStatus         =  "0"; 
	String strApproverOrderId       =  "";   
	String strApproverRole          =  ""; 
	ArrayList approverList          =  new ArrayList();
	ArrayList approverList1         =  new ArrayList();
	ArrayList l1                    =  new ArrayList();
	String url                      =  "";
		
	String strSetFlage 				= "";
	String flag 					= ""; 
	String strWhatAction            = "";
	
	String strSiteName				= "";
	
	//Added By Gurmeet Singh
	String strUserAccessCheckFlag = "";
		
	boolean strFwdJurnFlag          = false;
	boolean strRetJurnFlag          = false;
	boolean strIntrmiJurnFlag       = false;
	boolean strRetJurnExistFlag     = false;
	boolean saveSuccess             = false;
	boolean submitToWorkFlow       	= false;
	
	strUserId                       =  Suser_id;
	strSiteId                		=  (request.getParameter("site")==null || request.getParameter("site").equals("null")) ? strSiteIdSS : request.getParameter("site") ;
	strTravellerId              	=  request.getParameter("userName");
	strTravllerSiteId				=  strSiteId;
	strTravelType					=  request.getParameter("travelType");	
	strDesigName                  	=  "";
    strAge                     		=  "";	
	strSex                     		=  "";
	strMealId                    	=  request.getParameter("meal");
	
	strDepCity                  	=  request.getParameterValues("depCity");	
	strArrCity                  	=  request.getParameterValues("arrCity");
	strDepDate                 		=  request.getParameterValues("depDate");
	strPreferTime               	=  request.getParameterValues("preferTime");
	strTravelMode          			=  request.getParameterValues("departMode");	
	strTravelClass          		=  request.getParameterValues("departClass");	
	strNameOfAirline      			=  request.getParameterValues("nameOfAirline");		
	strPreferSeat   				=  request.getParameterValues("seatPreffred");
	
	strManager             			=  request.getParameter("manager");
	strHod                			=  request.getParameter("hod");
	strBoardMember			 		=  request.getParameter("boardmember");
	strSelectManagerRadio         	=  "manual";
	strReasonForTravel       		=  request.getParameter("reasonForTravel");
	strReasonForSkip         		=  request.getParameter("reasonForSkip");
	strCostCentre			   		=  request.getParameter("costcentre")==null?"0":request.getParameter("costcentre");
	strHidAppFlag			 		=  request.getParameter("hidAppLvl3flg");
	strHidAppShowBMFlag				=  request.getParameter("hidAppLvl3showbmflg");
	
	strVisaRequired                 =  request.getParameter("visa");
	strVisaComment        			=  request.getParameter("visaComment");
	strInsuranceRequired            =  request.getParameter("insurance");
	strNominee                		=  request.getParameter("nominee");
	strRelation                  	=  request.getParameter("relation");
	strInsuranceComment      		=  request.getParameter("insuranceComment");
	
	strHotelRequired                =  request.getParameter("hotel");
	strBudgetCurrency        		=  request.getParameter("currency");
	strHotelBudget           		=  request.getParameter("budget");
	strPlace						=  request.getParameter("place");
	strCheckin				 		=  request.getParameter("checkin");
	strCheckout				 		=  request.getParameter("checkout");
	strRemarks          			=  request.getParameter("otherComment");	
	
	strBillingSite               	=  request.getParameter("billingSMGSite")==null ?"" :request.getParameter("billingSMGSite");          
	strBillingClient                =  request.getParameter("billingSMGUser")==null?"0":request.getParameter("billingSMGUser")	 ;    
		
	strForTatkaalRequired			= "0";
	strForCoupanRequired			= "0";
	strRetTatkaalRequired			= "0";
	strRetCoupanRequired			= "0";
	strTicketRefundfwd 				= "n"; 
	strTicketRefundRtd 				= "n";
		
	strCARD_TYPE					=  "-1"; 
	strCARD_HOLDER_NAME         	=  ""; 
	strCVV_NUMBER			   		=  "";
	strCARD_EXP_DATE				=  "";
	strCARD_NUMBER1					=  "";
	strCARD_NUMBER2					=  "";
	strCARD_NUMBER3					=  "";
	strCARD_NUMBER4					=  ""; 
		
	strIdentityProof			    =  request.getParameter("identityProof")== null ? "" : request.getParameter("identityProof");
	strIdentityProofNo		        =  request.getParameter("identityProofno")== null ? "" : request.getParameter("identityProofno");
	
	radioEcnr				        = request.getParameter("ecnrradio");
	strContactNo		            = request.getParameter("passport_Contact_No");	
	strDOB				            = request.getParameter("passport_DOB");
	strPassportNo                   = request.getParameter("passport_No");
	strNationality                  = request.getParameter("nationality");
	strPassportIssuePlace		    = request.getParameter("passport_issue_place");
	strPassportIssueDate			= request.getParameter("passport_issue_date");		
	strPassportExpireDate			= request.getParameter("passport_expire_date");	
	strPermanentAddress		        = request.getParameter("passport_address");
	strCurrentAddress	            = request.getParameter("current_address")== null ? "" : request.getParameter("current_address");
		
	strAirLineName		            = request.getParameter("airLineName")== null ? "" : request.getParameter("airLineName");
	strAirLineName1		            = request.getParameter("airLineName1")== null ? "" : request.getParameter("airLineName1");
	strAirLineName2		            = request.getParameter("airLineName2")== null ? "" : request.getParameter("airLineName2");
	strAirLineNo		            = request.getParameter("passport_flight_No")== null ? "" : request.getParameter("passport_flight_No");
	strAirLineNo1		            = request.getParameter("passport_flight_No1")== null ? "" : request.getParameter("passport_flight_No1");
	strAirLineNo2		            = request.getParameter("passport_flight_No2")== null ? "" : request.getParameter("passport_flight_No2");
	
	strBaseCurrency                 =  request.getParameter("basecur")==null?"INR":request.getParameter("basecur");
	strTotalAmount                	=  request.getParameter("grandTotalForex");	
	strExpenditureRemarks          	=  request.getParameter("expRemarks");    
	strCashBreakupRemarks        	=  request.getParameter("cashBreakupRemarks");
	
	strTACurrency                   =  request.getParameterValues("expCurrency"); 
	strEntPerDay                    =  request.getParameterValues("entitlement");     
	strTotalTourDay                 =  request.getParameterValues("tourDays");     
	strTotalForex                   =  request.getParameterValues("totalForex");      
	strContingecies                 =  request.getParameterValues("contingencies");	
	strEntPerDay2                   =  request.getParameterValues("entitlement2");     
	strTotalTourDay2                =  request.getParameterValues("tourDays2");     
	strContingecies2                =  request.getParameterValues("contingencies2");
	strExRate              		    =  request.getParameterValues("exRate");     
	strTotalINR						=  request.getParameterValues("totalInr");
	strHiddenValue					=  request.getParameterValues("hd");	
	String strPerDayAmtinUSD	    =  request.getParameter("grandTotalForexUSD")==null?"0.00":request.getParameter("grandTotalForexUSD");
	strTotalFareCurrency		    =  request.getParameter("TotalFareCurrency")==null?"":request.getParameter("TotalFareCurrency");
	strTotalFareAmount		        =  request.getParameter("TotalFareAmount")==null?"0":request.getParameter("TotalFareAmount");
		
	dbl_YTM_BUDGET        		   	=  request.getParameter("YtmBud")==null?"0":request.getParameter("YtmBud");
	dbl_YTD_ACTUAL        		    =  request.getParameter("YtmAct")==null?"0":request.getParameter("YtmAct");
	dbl_AVAIL_BUDGET        		=  request.getParameter("AvailBud")==null?"0":request.getParameter("AvailBud");
	dbl_EST_EXP        		 	    =  request.getParameter("EstExp")==null?"0":request.getParameter("EstExp");
	str_EXP_REMARKS        		    =  request.getParameter("budgetRemarks")==null?"":request.getParameter("budgetRemarks");
	
	if(strTravelType.equals("D")) {
		strmataprice =  request.getParameter("matapricecompdom");
	} else if(strTravelType.equals("I")) {
		strmataprice =  request.getParameter("matapricecompint");
	}
	
	if(strmataprice.equalsIgnoreCase("y")) { 	
		 strTkAgent 			    =  request.getParameter("tkflyes");
		 strTkAirLine 			    =  request.getParameter("pricingAirline");
		 strTkcurrency 			    =  request.getParameter("pricingCurrency");
		 strTklocalprice 		    =  request.getParameter("localprice"); 
		 strTkRemarks 			    =  request.getParameter("pricingRemarks"); 
	  }	 
	
	strTravelReqId                  =  request.getParameter("travelReqId");    // from hidden field
	strTravelId                     =  request.getParameter("travelId");       // from hidden field
	strTravelReqNo                  =  request.getParameter("travelReqNo");    // for hidden field
	strInterimId			 		=  request.getParameter("interimId");	   // for hidden field
	strWhatAction                   =  request.getParameter("whatAction");     //from hidden field 
	strCancelledReqId				=  request.getParameter("cancelledTravelReq")==null?"0":request.getParameter("cancelledTravelReq"); 
	
	String strTravel_Req_Id  		=  "";
	String strTravel_Id  			=  "";
	String strTravel_Req_No 		=  "";
	String strTravel_Id_Intrim		=  "";
	
	if(strManager != null && strManager.equalsIgnoreCase("S")) {
		strManager = null;		
	}
	if(strHod != null && strHod.equalsIgnoreCase("S")) {
		strHod = null;		
	}
	if(strBoardMember!= null && strBoardMember.equalsIgnoreCase("B")) {
		strBoardMember = null;
	}	
	
	if(strCheckin !=null && "".equals(strCheckin)) {
		strCheckin	=	null;
	}
	if(strCheckout !=null && "".equals(strCheckout)) {
		strCheckout	=	null; 
	}
	
	if(strBillingSite.equals(strTravllerSiteId)) {
	 	flag ="no"; 
    }
	
	if(strBillingClient.equals("-1")) {
		flag ="no"; 
	}
	
	if(strHotelRequired != null && strHotelRequired.equals("2")) {
		if(strHotelBudget!= null && strHotelBudget.equalsIgnoreCase("Budget")) {
			strHotelBudget = null;
		} 
	}
	
	if(strCostCentre.equals("")) {
		strCostCentre ="0"; 
    }
	
	if(strTotalFareAmount.equals("")) {
		strTotalFareAmount ="0"; 
    }
	
	if(strTravelReqId != null && strTravelReqId.equals("new")) {
	    strActionFlag   = "insert";
	}
	
	//Added By Gurmeet Singh
	strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(Suser_id, strSiteId, "0");		
	if(!strUserAccessCheckFlag.equals("420")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strTravellerId, strSiteId, "0");		
	} 
	if(strManager != null && !strManager.equalsIgnoreCase("S") && !strUserAccessCheckFlag.equals("420")){
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strManager, strSiteId, "1");
	} 
	if(strHod != null && !strHod.equalsIgnoreCase("S") && !strUserAccessCheckFlag.equals("420")){
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strHod, strSiteId, "2");
	} 
	if(strBoardMember!= null && !strBoardMember.equalsIgnoreCase("B") && !strBoardMember.equalsIgnoreCase("-2") && !strUserAccessCheckFlag.equals("420")){
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strBoardMember, strSiteId, "3");
	}
	if(!strUserAccessCheckFlag.equals("420")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthCostCenter(strCostCentre, strSiteId);		
	}
	if(!strUserAccessCheckFlag.equals("420") && !strTravelId.equals("new")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthEditTravelReq(strTravelId, '"'+strTravelType+'"', Suser_id);		
	}
	
	if(strUserAccessCheckFlag.equals("420")){	
		dbConBean.close();  
		dbConBean1.close();
		dbConBean2.close();
		dbConBean3.close();
		securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_QuickTravel_Detail_Post.jsp", "Unauthorized Access");
		response.sendRedirect("UnauthorizedAccess.jsp");		
	} else {
	
	strSql = "SELECT ISNULL(dbo.DESIGNATIONNAME(DESIG_ID),'') AS DESIG FROM M_USERINFO (NOLOCK) WHERE USERID="+strTravellerId+" AND STATUS_ID=10 AND APPLICATION_ID=1";
      rs       =   dbConBean.executeQuery(strSql); 
	  if(rs.next()) {
        strDesigName = rs.getString("DESIG"); 
	  }
	  rs.close();	
	  
    strSql = "SELECT dbo.CalAge_YYMMDD(DOB,GETDATE()), GENDER FROM M_USERINFO (NOLOCK) WHERE USERID="+strTravellerId;	  
	  rs       =   dbConBean.executeQuery(strSql);  
	  if(rs.next()) {
		strAge = rs.getString(1);
		strGender=rs.getString(2);	
	  }  
	  rs.close();
	  
	  if(strGender!=null) {
		  if(strGender.equals("Male")  ) {
			  strSex= "1";
		  } else {
			  strSex= "2";
		  }
	  } else {
		  strSex= "1";
	  }
	  
    strSql = "SELECT dbo.CALAGE(DOB,GETDATE()), GENDER FROM M_USERINFO (NOLOCK) WHERE USERID="+strTravellerId;
	  rs       =   dbConBean.executeQuery(strSql);  
	  if(rs.next())  {
		  strAge = rs.getString(1);
	  }  
	  rs.close();
	  if(strAge == null)
		  strAge = "";
	  if(strAge != null && strAge.equals("0"))
		  strAge="";
	  if(strAge != null && strAge.equals("-1"))
		  strAge="";
		
	
	strSql="SELECT SP_ROLE FROM M_USERINFO WHERE M_USERINFO.USERID="+strTravellerId+" AND M_USERINFO.STATUS_ID=10";
	rs = dbConBean.executeQuery(strSql);
		if(rs.next()) {  
			strWorkFlowName= rs.getString("SP_ROLE");	 		
		 }
	rs.close();
	
	// code to check if identity proof and passport info is already exits in M_userinfor then added
	strSql="SELECT IDENTITY_ID, IDENTITY_NO, ISNULL(FF_AIR_NAME3,'') AS FF_AIR_NAME3, ISNULL(FF_AIR_NAME4,'') AS FF_AIR_NAME4, ISNULL(FF_NUMBER3,'') AS FF_NUMBER3, ISNULL(FF_NUMBER4,'') AS FF_NUMBER4, ISNULL(HOTEL_NAME,'') AS HOTEL_NAME, ISNULL(HOTEL_NAME1,'') AS HOTEL_NAME1, " 
			+ " ISNULL(HOTEL_NAME2,'') AS HOTEL_NAME2, ISNULL(HOTEL_NAME3,'') AS HOTEL_NAME3, ISNULL(HOTEL_NAME4,'') AS HOTEL_NAME4, ISNULL(HOTEL_NUMBER,'') AS HOTEL_NUMBER, ISNULL(HOTEL_NUMBER1,'') AS HOTEL_NUMBER1, ISNULL(HOTEL_NUMBER2,'') AS HOTEL_NUMBER2, ISNULL(HOTEL_NUMBER3,'') AS HOTEL_NUMBER3, " 
			+ " ISNULL(HOTEL_NUMBER4,'') AS HOTEL_NUMBER4, ISNULL(NATIONALITY,'') AS NATIONALITY, ISNULL(FULL_NAME,'') AS FULL_NAME, ISNULL(PASSPORT_F_NAME,'') AS PASSPORT_F_NAME, ISNULL(PASSPORT_L_NAME,'') AS PASSPORT_L_NAME FROM M_USERINFO (NOLOCK) WHERE USERID = "+strTravellerId+" AND STATUS_ID = 10";
	rs	=	dbConBean.executeQuery(strSql);
	while(rs.next()) {
		strIdentityProofOld 	= rs.getString("IDENTITY_ID"); 
		strIdentityProofNoOld 	= rs.getString("IDENTITY_NO"); 
       	strAirLineName3 		= rs.getString("FF_AIR_NAME3");
		strAirLineName4 		= rs.getString("FF_AIR_NAME4");
		strAirLineNo3  			= rs.getString("FF_NUMBER3");
		strAirLineNo4  			= rs.getString("FF_NUMBER4");
		strHotelName 			= rs.getString("HOTEL_NAME");
		strHotelName1 			= rs.getString("HOTEL_NAME1");
		strHotelName2			= rs.getString("HOTEL_NAME2");
		strHotelName3 			= rs.getString("HOTEL_NAME3");
		strHotelName4			= rs.getString("HOTEL_NAME4");
		strHotelNo				= rs.getString("HOTEL_NUMBER");
		strHotelNo1				= rs.getString("HOTEL_NUMBER1");
		strHotelNo2				= rs.getString("HOTEL_NUMBER2");
		strHotelNo3 			= rs.getString("HOTEL_NUMBER3");
		strHotelNo4 			= rs.getString("HOTEL_NUMBER4");
		//strNationality			= rs.getString("NATIONALITY");
		fullName				= rs.getString("FULL_NAME");
		firstName				= rs.getString("PASSPORT_F_NAME");
		lastName				= rs.getString("PASSPORT_L_NAME");
		}
	rs.close();	
	
	if( strIdentityProof ==null) {
		strIdentityProof="";
	}
	
	if( strIdentityProofNo ==null) {
		strIdentityProofNo="";
	}
		
	if(strDepCity.length == 1) {	
		strFwdJurnFlag = true;
		strReturnType       =  "1"; 
	} else if(strDepCity.length == 2) {	
		strFwdJurnFlag = true;
		strRetJurnFlag = true;
		strReturnType       =  "2";
	} else if(strDepCity.length > 2) {	
		strFwdJurnFlag = true;
		strRetJurnFlag = true;
		strIntrmiJurnFlag = true;
		strReturnType       =  "2";
	}		
	
	if(!strSiteId.trim().equalsIgnoreCase(strSiteIdSS.trim())) {		 
		 strSql="select site_name from m_site where site_id="+strSiteId;
		 rs = dbConBean.executeQuery(strSql);
			while(rs.next()){  
				strSiteName = rs.getString("site_name");	 		
			 }			
			rs.close();				
	  } else {	  
		  strSiteName = strSiteFullName;
	  }
			
	if(strActionFlag!=null && strActionFlag.equals("insert")) {		
		strTravel_Req_Id  =  dbUtilityBean.getNewGeneratedId("TRAVEL_REQ_ID")+"";		
		if(strTravelType.equals("D")) {
			strTravel_Id  =  dbUtilityBean.getNewGeneratedId("TRAVEL_ID_DOM")+"";
			strTravel_Req_No = "TEMP/"+strSiteName.trim()+"/DOM/"+strTravel_Id;
		} else if(strTravelType.equals("I")) {
			strTravel_Id  =  dbUtilityBean.getNewGeneratedId("TRAVEL_ID_INT")+"";
			strTravel_Req_No = "TEMP/"+strSiteName.trim()+"/INT/"+strTravel_Id;
		} 
		
		try {			 
			 	objCon =  dbConBean.getConnection(); 
			 	objCon.setAutoCommit(false);
			 
			   //PROCEDURE to insert the data in T_TRAVEL_MST
				objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_MST(?,?,?,?)}");
			    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			    objCstmt.setString(2, strTravel_Req_Id);
			    objCstmt.setString(3, strSiteId);
			    objCstmt.setString(4, Suser_id);
			    objCstmt.setString(5, strTravelType);
			    intSuccess1 = objCstmt.executeUpdate();
			    objCstmt.close();
			    
			    if(strFwdJurnFlag) {					
					strDepDateFwd 		= strDepDate[0];
			    }
			    
			    if(strTravelType.equals("D")) {
			    	//PROCEDURE for INSERT data in T_TRAVEL_DETAIL_DOM
					  objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_DETAIL_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,   ?,?,?,?,?,?,     ?,?   ,?,?,?,?,?,?,?,?,?,?,?,?,?)}");  
					  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					  objCstmt.setString(2, strTravel_Req_Id);
					  objCstmt.setString(3, strTravel_Id);
					  objCstmt.setString(4, strTravel_Req_No);
					  objCstmt.setString(5, strSiteId);
					  objCstmt.setString(6, strTravellerId);
					  objCstmt.setString(7, strAge);
					  objCstmt.setString(8, strSex);
					  objCstmt.setString(9, strDepDateFwd);
					  objCstmt.setString(10, strMealId);
					  objCstmt.setString(11, strHotelRequired);
					  objCstmt.setString(12, strHotelBudget);
					  objCstmt.setString(13, strBudgetCurrency);
					  objCstmt.setString(14, strCheckin);
					  objCstmt.setString(15, strCheckout);
					  objCstmt.setString(16, strRemarks);
					  objCstmt.setString(17, strReturnType);
					  objCstmt.setString(18, Suser_id);
					  objCstmt.setString(19, strSelectManagerRadio);
					  objCstmt.setString(20, strManager);
			      	  objCstmt.setString(21, strHod);
			  		  objCstmt.setString(22, strCARD_TYPE);					  
					  objCstmt.setString(23, strCARD_HOLDER_NAME);
			          objCstmt.setString(24, strCARD_NUMBER1); 
					  objCstmt.setString(25, strCARD_NUMBER2); 
					  objCstmt.setString(26, strCARD_NUMBER3); 
					  objCstmt.setString(27, strCARD_NUMBER4); 
					  objCstmt.setString(28, strCVV_NUMBER); 
					  objCstmt.setString(29, strCARD_EXP_DATE); 
					  objCstmt.setString(30, strReasonForTravel); 
			  		  objCstmt.setString(31, strReasonForSkip); 
			   		  objCstmt.setString(32, strPlace); 	
			   		  objCstmt.setString(33, strForTatkaalRequired); 
			   		  objCstmt.setString(34, strForCoupanRequired); 
			  		  objCstmt.setString(35, strRetTatkaalRequired); 
					  objCstmt.setString(36, strRetCoupanRequired); 			  		 
					  objCstmt.setString(37, strIdentityProof);			         
					  objCstmt.setString(38, strIdentityProofNo); 
					  objCstmt.setString(39, "N");
					  objCstmt.setString(40,strBoardMember);
					  objCstmt.setInt(41, Integer.parseInt(strCostCentre));
					  objCstmt.setString(42, "");
					  objCstmt.setString(43, "2");
					  objCstmt.setString(44, "2");
					  objCstmt.setString(45, "0");
					  objCstmt.setString(46, "");
					  objCstmt.setString(47, "0");
					  objCstmt.setString(48, "1");
					  objCstmt.setString(49, "2");
					  objCstmt.setString(50, "2");
					  objCstmt.setString(51, "");
					  objCstmt.setString(52, "");
					  objCstmt.setString(53, null);
					  objCstmt.setString(54, "");
					  intSuccess2 = objCstmt.executeUpdate();
					  objCstmt.close();
					
				} else if(strTravelType.equals("I")) {
					//PROCEDURE to INSERT data in T_TRAVEL_DETAIL_INT			
				    objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_DETAIL_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
					objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				    objCstmt.setString(2, strTravel_Req_Id);
				    objCstmt.setString(3, strTravel_Id);
				    objCstmt.setString(4, strTravel_Req_No);
				    objCstmt.setString(5, strSiteId);
				    objCstmt.setString(6, strTravellerId);
				    objCstmt.setString(7, strAge);
				    objCstmt.setString(8, strSex);
				    objCstmt.setString(9, strDepDateFwd);
				    objCstmt.setString(10, strMealId);
				    objCstmt.setString(11, strVisaRequired);
				    objCstmt.setString(12, strVisaComment);
				    objCstmt.setString(13, strInsuranceRequired);
				    objCstmt.setString(14, strNominee);
				    objCstmt.setString(15, strRelation);
				    objCstmt.setString(16, strInsuranceComment);
				    objCstmt.setString(17, strHotelRequired);
				    objCstmt.setString(18, strHotelBudget);
				    objCstmt.setString(19, strPlace);
				    objCstmt.setString(20, strBudgetCurrency);
				    objCstmt.setString(21, strRemarks);
				    objCstmt.setString(22, strReturnType);
					objCstmt.setString(23, Suser_id);
				    objCstmt.setString(24, strSelectManagerRadio);
					objCstmt.setString(25, strManager);
					objCstmt.setString(26, strHod);
					objCstmt.setString(27, strCARD_TYPE);  
					objCstmt.setString(28, strCARD_HOLDER_NAME);		
					objCstmt.setString(29, strCARD_NUMBER1); 
					objCstmt.setString(30, strCARD_NUMBER2); 
					objCstmt.setString(31, strCARD_NUMBER3); 
					objCstmt.setString(32, strCARD_NUMBER4); 
					objCstmt.setString(33, strCVV_NUMBER); 
					objCstmt.setString(34, strCARD_EXP_DATE); 
					objCstmt.setString(35, strCheckin); 
					objCstmt.setString(36, strCheckout); 
					objCstmt.setString(37, strReasonForTravel);
					objCstmt.setString(38, strReasonForSkip);
					objCstmt.setString(39, "");
					objCstmt.setString(40, "N");
					objCstmt.setString(41,strBoardMember);
					objCstmt.setInt(42,Integer.parseInt(strCostCentre));
					objCstmt.setString(43, "");
					objCstmt.setString(44, "2");
					objCstmt.setString(45, "2");
					objCstmt.setString(46, "0");
					objCstmt.setString(47, "");
					objCstmt.setString(48, "0");
					objCstmt.setString(49, "1");
					objCstmt.setString(50, "2");
					objCstmt.setString(51, "2");
					objCstmt.setString(52, "");
					objCstmt.setString(53, "");
					objCstmt.setString(54, null);
					objCstmt.setString(55, "");
					objCstmt.setString(56, "0");
					objCstmt.setString(57, null);
					objCstmt.setString(58, null);
				    intSuccess2 = objCstmt.executeUpdate();
				    objCstmt.close();
				}	
			 
			 if(strFwdJurnFlag) {
					strDepCityFwd 		= strDepCity[0];
					strArrCityFwd 		= strArrCity[0];
					strDepDateFwd 		= strDepDate[0];
					strPreferTimeFwd	= strPreferTime[0];					
					strTravelClassFwd 	= strTravelClass[0];
					strNameOfAirlineFwd = strNameOfAirline[0];
					strPreferSeatFwd	= strPreferSeat[0];
					
					if(strTravelType.equals("D")) {
						strTravelModeFwd 	= strTravelMode[0];
						
						//PROCEDURE for INSERT data in T_JOURNEY_DETAILS_DOM
						objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
						objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2, strTravel_Id);
						objCstmt.setString(3, strDepCityFwd);
						objCstmt.setString(4, strArrCityFwd);
						objCstmt.setString(5, strDepDateFwd); 
						objCstmt.setString(6, strJourneyOrder);
						objCstmt.setString(7, strTravelModeFwd);
						objCstmt.setString(8, strNameOfAirlineFwd);
						objCstmt.setString(9, strTravelClassFwd);
						objCstmt.setString(10, strPreferTimeFwd);
						objCstmt.setString(11, Suser_id);						  
						objCstmt.setString(12, strPreferSeatFwd);
						objCstmt.setString(13, strTicketRefundfwd);	
						objCstmt.setString(14, "1");
						objCstmt.setInt(15, 0);
						intSuccess3 = objCstmt.executeUpdate();
						objCstmt.close();
					} else if(strTravelType.equals("I")) {
						strTravelModeFwd = "1";
						//strPreferSeatFwd = "1";
						
						//PROCEDURE to INSERT data in T_JOURNEY_DETAILS_INT
					    objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
					    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2, strTravel_Id);
					    objCstmt.setString(3, strDepCityFwd);
					    objCstmt.setString(4, strArrCityFwd);
					    objCstmt.setString(5, strDepDateFwd); 
					    objCstmt.setString(6, strJourneyOrder);
					    objCstmt.setString(7, strTravelModeFwd);
					    objCstmt.setString(8, strNameOfAirlineFwd);
					    objCstmt.setString(9, strTravelClassFwd);
					    objCstmt.setString(10, strVisaRequired);
					    objCstmt.setString(11, strVisaComment);
					    objCstmt.setString(12, strPreferTimeFwd);
					    objCstmt.setString(13, Suser_id);
					    objCstmt.setString(14, strPreferSeatFwd); 
					    objCstmt.setString(15, "1");
					    objCstmt.setInt(16, 0);
					    intSuccess3   =  objCstmt.executeUpdate();
					    objCstmt.close();
					}			
				} 
				
				if(strRetJurnFlag) {
					strDepCityRet 		= strDepCity[(strDepCity.length - 1)];
					strArrCityRet 		= strArrCity[strDepCity.length - 1];
					strDepDateRet 		= strDepDate[strDepCity.length - 1];
					strPreferTimeRet	= strPreferTime[strDepCity.length - 1];					
					strTravelClassRet 	= strTravelClass[strDepCity.length - 1];
					strNameOfAirlineRet = strNameOfAirline[strDepCity.length - 1];
					strPreferSeatRet	= strPreferSeat[strDepCity.length - 1];
					
					 if(strDepCityRet==null) {
						strDepCityRet = ""; 
					 }
					 if(strArrCityRet==null) {
						 strArrCityRet = ""; 
					 }
					 if(strDepDateRet==null) {
						 strDepDateRet = ""; 
					 }
					
					if(strTravelType.equals("D")) {
						strTravelModeRet 	= strTravelMode[strDepCity.length - 1];

						objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_RET_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
						objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2, strTravel_Id);
						objCstmt.setString(3, strDepCityRet);
						objCstmt.setString(4, strArrCityRet);
						objCstmt.setString(5, strDepDateRet);
						objCstmt.setString(6, strJourneyOrder);
						objCstmt.setString(7, strTravelModeRet);
						objCstmt.setString(8, strNameOfAirlineRet);
						objCstmt.setString(9, strTravelClassRet);
						objCstmt.setString(10, strPreferTimeRet);
						objCstmt.setString(11, Suser_id); 
						objCstmt.setString(12, strPreferSeatRet);
						objCstmt.setString(13, strTicketRefundRtd);
						objCstmt.setString(14, "1");
						objCstmt.setInt(15, 0);
						intSuccess4 = objCstmt.executeUpdate();
						objCstmt.close();
					} else if(strTravelType.equals("I")) {
						strTravelModeRet = "1";
						//strPreferSeatRet = "1";
						
						//PROCEDURE To INSERT data in T_RET_JOURNEY_DETAILS_INT
					    objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_RET_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
					    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					    objCstmt.setString(2, strTravel_Id);
					    objCstmt.setString(3, strDepCityRet);
					    objCstmt.setString(4, strArrCityRet);
					    objCstmt.setString(5, strDepDateRet);
					    objCstmt.setString(6, strJourneyOrder);
					    objCstmt.setString(7, strTravelModeRet);
					    objCstmt.setString(8, strNameOfAirlineRet);
					    objCstmt.setString(9, strTravelClassRet);
					    objCstmt.setString(10, strPreferTimeRet);
					    objCstmt.setString(11, Suser_id);
					    objCstmt.setString(12, strPreferSeatRet);
					    objCstmt.setString(13, "1");
					    objCstmt.setInt(14, 0);
					    
					    intSuccess4 = objCstmt.executeUpdate();
					    objCstmt.close();
					}			
				}
				
				if(strIntrmiJurnFlag) {
					strTravel_Id_Intrim  =  dbUtilityBean.getNewGeneratedId("INTERIM_ID")+"";					
					for(int i = 1; i < strDepCity.length - 1; i++) {	
						int jrOrder = i+1;
						strDepCityIntrmi 		= strDepCity[i];
						strArrCityIntrmi 		= strArrCity[i];
						strDepDateIntrmi 		= strDepDate[i];
						strPreferTimeIntrmi 	= strPreferTime[i];						
						strTravelClassIntrmi 	= strTravelClass[i];
						strNameOfAirlineIntrmi 	= strNameOfAirline[i];
						strPreferSeatIntrmi		= strPreferSeat[i];
						
						if(strTravelType.equals("D")) {
							strTravelModeIntrmi	    = strTravelMode[i];		

							objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
							objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setString(2, strTravel_Id);
							objCstmt.setString(3, strDepCityIntrmi);
							objCstmt.setString(4, strArrCityIntrmi);
							objCstmt.setString(5, strDepDateIntrmi);
							objCstmt.setInt(6, jrOrder);
							objCstmt.setString(7, strTravelModeIntrmi);
							objCstmt.setString(8, strNameOfAirlineIntrmi);
							objCstmt.setString(9, strTravelClassIntrmi);
							objCstmt.setString(10, strPreferTimeIntrmi);
							objCstmt.setString(11, Suser_id);
							objCstmt.setString(12, strPreferSeatIntrmi);
							objCstmt.setString(13, "n");
							objCstmt.setString(14, "1");
							objCstmt.setInt(15, 0);
							intSuccess5 = objCstmt.executeUpdate();
							objCstmt.close();		
						} else if(strTravelType.equals("I")) {
							strTravelModeIntrmi = "1";
							//strPreferSeatIntrmi = "1";
							
							objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
							objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setString(2, strTravel_Id);
							objCstmt.setString(3, strDepCityIntrmi);
							objCstmt.setString(4, strArrCityIntrmi);
							objCstmt.setString(5, strDepDateIntrmi);
							objCstmt.setInt(6, jrOrder);
							objCstmt.setString(7, strTravelModeIntrmi);
							objCstmt.setString(8, strNameOfAirlineIntrmi);
							objCstmt.setString(9, strTravelClassIntrmi);
							objCstmt.setString(10, strVisaRequired);
							objCstmt.setString(11, strVisaComment);
							objCstmt.setString(12, strPreferTimeIntrmi);     
							objCstmt.setString(13, Suser_id);
							objCstmt.setString(14, strPreferSeatIntrmi); 
							objCstmt.setString(15, "1");
						    objCstmt.setInt(16, 0);
							intSuccess5 = objCstmt.executeUpdate();
							objCstmt.close();				
						}
						
						  objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_INTERIM_JOURNEY_DETAILS(?,?,?,?,?,?,?,?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_INTERIM_JOURNEY  Table
						  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						  objCstmt.setString(2, strTravel_Id_Intrim);
						  objCstmt.setString(3, strDepCityIntrmi);             //set the current user Site Id
						  objCstmt.setString(4, strArrCityIntrmi);                //set the current user Login UserId
						  objCstmt.setString(5, strDepDateIntrmi);
						  objCstmt.setString(6, strTravelModeIntrmi);
						  objCstmt.setString(7, strNameOfAirlineIntrmi);
						  objCstmt.setString(8, strTravelClassIntrmi);
						  objCstmt.setString(9, strVisaRequired);
						  objCstmt.setString(10, strVisaComment); 
						  objCstmt.setString(11, strTravelType);
						  objCstmt.setString(12, strPreferTimeIntrmi);   /// added new for prefered time on 25-Oct-07 By Shiv Sharma   
						  objCstmt.setString(13, strPreferSeatIntrmi);
						  objCstmt.setString(14, "n");
						  //objCstmt.setInt(15, 0);
						  iSuccess1   =  objCstmt.executeUpdate();
						  objCstmt.close();
					}
					
					// update T_INTERIM_JOURNEY
					if(strTravel_Id_Intrim != null && !strTravel_Id_Intrim.equals("")) {
					  stmt = 	objCon.createStatement();
					  strSql = "UPDATE T_INTERIM_JOURNEY SET TRAVEL_ID='"+strTravel_Id+"' WHERE PARENT_ID ="+ strTravel_Id_Intrim;
					  int  iupdate1 = stmt.executeUpdate(strSql);
					}
				}				
				
				//PROCEDURE to INSERT data in T_TRAVEL_STATUS
			    objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_STATUS(?,?,?,?,?)}"); 
			    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			    objCstmt.setString(2, strTravel_Req_Id);
			    objCstmt.setString(3, strTravel_Id);
			    objCstmt.setString(4, strTravelStatusId);      //set the Travel Status Id(1-Temp, 2-Permanent, 3-Return, 4-Rejected, 6-Canceled, 10-Approved by All)
			    objCstmt.setString(5, strTravelType);
			    objCstmt.setString(6, strCancelledReqId);
			    intSuccess6   =  objCstmt.executeUpdate();
			    objCstmt.close();			
				objCon.commit(); //commit the query
			    objCon.setAutoCommit(true);
				
				
			    objCstmt = objCon.prepareCall("{?=call PROC_T_TRAVEL_ACCOMMODATION(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
  			    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
  	            objCstmt.setString(2, "0");
  	            objCstmt.setString(3, strTravel_Req_Id);
  	            objCstmt.setString(4, strTravel_Id);
  	            objCstmt.setString(5, strTravelType); 
  	            objCstmt.setString(6, strHotelRequired);
  			    objCstmt.setString(7, strPlace);
  			     if(strHotelBudget!=null && !strHotelBudget.equals("")){
	  			  	objCstmt.setDouble(8, Double.parseDouble(strHotelBudget));
	  			 } else {
	  				objCstmt.setDouble(8, Double.parseDouble("0"));
	  			 }
  			    objCstmt.setString(9, strBudgetCurrency);
  		        objCstmt.setString(10, strCheckin);
  			    objCstmt.setString(11, strCheckout);			  			   	
  			    objCstmt.setString(12, Suser_id); 
  			    objCstmt.setString(13, "INSERT"); 
  			    objCstmt.setString(14, strIPAddress);
  			    objCstmt.setInt(15, 0);
  			    intSuccess8   =  objCstmt.executeUpdate();
  			    objCstmt.close();
  			  
				
			    if(intSuccess1 > 0 && intSuccess2 > 0 && intSuccess6 > 0) {
					if(strFwdJurnFlag && !strRetJurnFlag && !strIntrmiJurnFlag) {
						if(intSuccess3 > 0) {
							saveSuccess = true;
						}							    		
			    	} else if(strFwdJurnFlag && strRetJurnFlag && !strIntrmiJurnFlag) {
						if(intSuccess3 > 0 && intSuccess4 > 0) {
							saveSuccess = true;						
						}						
			    	} else if(strFwdJurnFlag && strRetJurnFlag && strIntrmiJurnFlag) {
			    		if(intSuccess3 > 0 && intSuccess4 > 0 && intSuccess5 > 0) {
			    			saveSuccess = true;
						}
			    	}				
			    }
				
		    if(saveSuccess) {		    	
			   //PROCEDURE for INSERT data in T_APPROVERS			
			   //Get the new Approve_Id from the T_Travel_Mst Table
			   String strApprove_Id  = "";
			   strApprove_Id  =  dbUtilityBean.getNewGeneratedId("APPROVE_ID")+"";
		
			   if(strSelectManagerRadio != null && strSelectManagerRadio.equals("manual")) {
					String strTravellerRole  = "";
					String strUnitHead       = "0";
					strSql = "SELECT LTRIM(RTRIM(ISNULL(ROLE_ID,'OR'))) AS ROLE_ID, LTRIM(RTRIM(ISNULL(UNIT_HEAD,'0'))) AS UNIT_HEAD FROM M_USERINFO (NOLOCK) WHERE USERID="+strTravellerId;
					rs     = dbConBean1.executeQuery(strSql);
					if(rs.next()) {
						 strTravellerRole = rs.getString("ROLE_ID");							
						 if(strTravellerRole.equalsIgnoreCase("CHAIRMAN")) {
							approverList.clear();
						 }						
					}
					rs.close();	
					//one UnitHead for multiple site
					strSql = "SELECT ISNULL(UNIT_HEAD,'0') AS UNIT_HEAD   FROM USER_MULTIPLE_ACCESS (NOLOCK) where userid="+strTravellerId+" and site_id="+strSiteId+" and status_id=10 and unit_head=1";
					rs = dbConBean1.executeQuery(strSql);
					if(rs.next()) {
						strUnitHead			=	rs.getString(1).trim();			
					}
					rs.close();
				   //one UnitHead for multiple site
	               //added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers					
				   if(strTravellerRole.equalsIgnoreCase("CHAIRMAN")) {
					   if(strTravelType.equals("D")) {
						   strSql = "SELECT LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, APPROVER_ID, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS (NOLOCK) WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='D' AND sp_role="+strWorkFlowName+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4"; 
					   } else if(strTravelType.equals("I")) {
						   strSql = "SELECT LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, APPROVER_ID, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS (NOLOCK) WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='I' AND sp_role="+strWorkFlowName+"  AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4"; 
					   }
						 
						rs     = dbConBean1.executeQuery(strSql);
						while(rs.next()) {
							  strUserRole = rs.getString("USERROLE");
							 if(strUserRole != null && strUserRole.equalsIgnoreCase("MATA")) {
								approverList.add(rs.getString("APPROVER_ID"));	
								approverList.add(strUserRole);  
							 }				 
						} 
						rs.close();	
					} else {					   
					  if(strManager != null) {
						// adding 1 level approver  as manager id 
					    approverList.add(strManager);
						approverList.add("WORKFLOW");
					  }
					  if(strHod != null) {
						//adding 2 level approver  as hod id
						//if condition added on 23 july 2013 by manoj chand to prevent addition of approval level 1 approver in level 2.
						if(!approverList.contains(strHod)) {
							approverList.add(strHod);
							approverList.add("WORKFLOW"); 
						}
					  }
					  
					  					  
					 
					  if(strTravelType.equals("D")) {
						  if(strHidAppFlag.equalsIgnoreCase("Y") && strHidAppShowBMFlag.equalsIgnoreCase("Y") && strBoardMember!=null && !strBoardMember.equalsIgnoreCase("-1") && !strBoardMember.equalsIgnoreCase("-2")) {
								approverList.add(strBoardMember);
								approverList.add("WORKFLOW"); 
						   }
						  
						  strSql = "SELECT APPROVER_ID, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS (NOLOCK) WHERE SITE_ID="+strSiteId+" AND TRV_TYPE = 'D' AND sp_role="+strWorkFlowName+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4"; 
					  } else if(strTravelType.equals("I")) {
						  if(strHidAppFlag.equalsIgnoreCase("Y") && strHidAppShowBMFlag.equalsIgnoreCase("Y") && strBoardMember!=null && !strBoardMember.equalsIgnoreCase("-1")) {
								approverList.add(strBoardMember);
								approverList.add("WORKFLOW"); 
						   }
						  
						  strSql = "SELECT APPROVER_ID, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS (NOLOCK) WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='I' AND sp_role="+strWorkFlowName+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4";  
					  }
					  
					  rs     = dbConBean1.executeQuery(strSql);
					  while(rs.next())  {						
						String strTempApproverId =  rs.getString("APPROVER_ID").trim();
						 strUserRole = rs.getString("USERROLE");
						 //if traveller id is unit head of the site then it would not be appear in the approver list.	
						 if(strUnitHead.equalsIgnoreCase("1") && strTravellerId.equals(strTempApproverId)) {
						 }
						 	//Two Unit Heads belonging to the same site.
						 	//STATUS_ID=10
							 String strQuery="Select Unit_Head from USER_MULTIPLE_ACCESS (NOLOCK) where USERID="+strTempApproverId+" and SITE_ID="+strSiteId+" AND UNIT_HEAD=1 AND STATUS_ID=10 ORDER BY 1";
							 rs1     = dbConBean2.executeQuery(strQuery);
							 if(strUnitHead.equalsIgnoreCase("1") && rs1.next()) {								 
							 }
							 //End of modification
							 else {
								 if(strTravelType.equals("D")) {
									    if(approverList.contains(strTempApproverId)){  
											  int j = approverList.indexOf(strTempApproverId);
										    	int k=j+1;
	
												if (j == k - 1) {
													approverList.remove(j);
													approverList.remove(j);
												}
								             }	
											approverList.add(strTempApproverId);
											if(strUserRole != null && strUserRole.equalsIgnoreCase("OR"))
											{
												strUserRole = "DEFAULT";
											}
											approverList.add(strUserRole);
											
								 }  else if(strTravelType.equals("I")) {
								    // Added code for checking if appro ver is exits in defualt approver list
							        //modified added "approverList.contains("WORKFLOW")" condition in if
									if(approverList.contains(strTempApproverId) && approverList.contains("WORKFLOW")) {  
									  approverList.remove(strTempApproverId); 
									  approverList.remove("WORKFLOW"); 
									  }
			 					    approverList.add(strTempApproverId); 
								   if(strUserRole != null && strUserRole.equalsIgnoreCase("OR")) {
										strUserRole = "DEFAULT";
									}
									approverList.add(strUserRole);  
								 }
							 }rs1.close();
					  }
					  rs.close();					  
					}
				}			   
			   
			 	//Removing traveller name from approver list if he/she Exist
			 	if(strTravelType.equals("D")) {
			 	 	strSql = "SELECT  isnull(MUI.ROLE_ID,'OR') as ROLE_ID, TTDI.TRAVELLER_ID as TRAVELLER_ID FROM T_TRAVEL_DETAIL_DOM AS TTDI (NOLOCK)  INNER JOIN M_USERINFO AS MUI (NOLOCK) ON TTDI.TRAVELLER_ID = MUI.USERID "+
	 		  				  "	WHERE     (TTDI.TRAVEL_ID = "+strTravel_Id+")";
			 	} else if(strTravelType.equals("I")) {
				    strSql = "SELECT  isnull(MUI.ROLE_ID,'OR') as ROLE_ID, TTDI.TRAVELLER_ID as TRAVELLER_ID FROM T_TRAVEL_DETAIL_INT AS TTDI (NOLOCK) INNER JOIN M_USERINFO AS MUI (NOLOCK) ON TTDI.TRAVELLER_ID = MUI.USERID "+
					 		  "	WHERE     (TTDI.TRAVEL_ID = "+strTravel_Id+")";
			 	}
				rs     = dbConBean1.executeQuery(strSql);
			    while(rs.next()) {
				 	strRoleofTraveler=rs.getString("ROLE_ID");
					strIDofTraveler=rs.getString("TRAVELLER_ID");								    
			    }
			   
			    if(strRoleofTraveler.equalsIgnoreCase("OR")) {
				   strRoleofTraveler = "DEFAULT";
			    }
					
				   if(strManager == null || !strManager.equals(strIDofTraveler)) {
				 	   if(strHod==null ||  !strHod.equals(strIDofTraveler)) { 
				 		//ROLE != MATA CONDITION TO SHOW MATA AS APPROVER FOR MATA'S REQUEST
						   if(approverList.contains(strIDofTraveler) && !strRoleofTraveler.trim().equalsIgnoreCase("MATA")) {
							   	 int i=approverList.indexOf(strIDofTraveler);							     
							     approverList.remove(i);
							     approverList.remove(i);							   
						   }
				 	   }
				   }
				   
				   Iterator itr =  approverList.iterator(); 
				   while(itr.hasNext()) {
					  intCounter++;  
					  strApproverId       = (String) itr.next();
					  strApproverRole     = (String)itr.next(); 
					  strApproverOrderId  = intCounter+"";
					  objCstmt             = objCon.prepareCall("{?=call PROC_INSERT_T_APPROVERS(?,?,?,?,?,?,?,?,?,?)}"); 
					  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					  objCstmt.setString(2, strApprove_Id);            //set the Approve Id      
					  objCstmt.setString(3, strTravel_Id);             //set the Travel Id    
					  objCstmt.setString(4, strSiteId);                //set the Traveller Site Id  
					  objCstmt.setString(5, strTravellerId);           //Set the Traveller Id
					  objCstmt.setString(6, strTravelType);            //Set the TravelType 
					  objCstmt.setString(7, strApproverId);            //Set the Approver Id
					  objCstmt.setString(8, strApproveStatus);         //Set the Approve Status(0-no approve, 10-approve, 3-return, 4-rejected)
					  objCstmt.setString(9, strApproverOrderId);       //Set the Approver Order Id in which  order approver approve the requsition
					  objCstmt.setString(10, strApproverRole);         //Set the Approver Role
					  objCstmt.setString(11, Suser_id);                //Set the Login user id 
					  intSuccess7   =  objCstmt.executeUpdate();
					  objCstmt.close();
					  if(intSuccess7 == 0)
						 break;
					}
				   
				   if(strTravelType != null && strTravelType.equals("D")) {
						  stmt = 	objCon.createStatement();
						  if(strIdentityProofOld==null || strIdentityProofOld.equals("-1") || strIdentityProofOld.equals("0")) {
						        strSql = "UPDATE M_USERINFO SET  IDENTITY_ID='"+strIdentityProof+"',IDENTITY_NO='"+strIdentityProofNo+"', CONTACT_NUMBER='"+strContactNo+"',FF_NUMBER=N'"+strAirLineNo+"',FF_NUMBER1=N'"+strAirLineNo1+"',FF_NUMBER2=N'"+strAirLineNo2 +"',FF_AIR_NAME=N'"+strAirLineName+"',FF_AIR_NAME1=N'"+strAirLineName1+"',FF_AIR_NAME2=N'"+strAirLineName2+"',FF_AIR_NAME3=N'"+strAirLineName3+"',FF_AIR_NAME4=N'"+strAirLineName4+"',HOTEL_NUMBER=N'"+strHotelNo+"',HOTEL_NUMBER1=N'"+strHotelNo1+"',HOTEL_NUMBER2=N'"+strHotelNo2+"',HOTEL_NUMBER3=N'"+strHotelNo3+"',HOTEL_NUMBER4=N'"+strHotelNo4 +"',HOTEL_NAME=N'"+strHotelName+"',HOTEL_NAME1=N'"+strHotelName1+"',HOTEL_NAME2=N'"+strHotelName2+"',HOTEL_NAME3=N'"+strHotelName3+"',HOTEL_NAME4=N'"+strHotelName4+"' WHERE USERID ="+strTravellerId;
						  } else {
						  strSql = "UPDATE M_USERINFO SET  CONTACT_NUMBER='"+strContactNo+"',FF_NUMBER=N'"+strAirLineNo+"',FF_NUMBER1=N'"+strAirLineNo1+"',FF_NUMBER2=N'"+strAirLineNo2 +"',FF_AIR_NAME=N'"+strAirLineName+"',FF_AIR_NAME1=N'"+strAirLineName1+"',FF_AIR_NAME2=N'"+strAirLineName2+"',FF_AIR_NAME3=N'"+strAirLineName3+"',FF_AIR_NAME4=N'"+strAirLineName4+"',HOTEL_NUMBER=N'"+strHotelNo+"',HOTEL_NUMBER1=N'"+strHotelNo1+"',HOTEL_NUMBER2=N'"+strHotelNo2+"',HOTEL_NUMBER3=N'"+strHotelNo3+"',HOTEL_NUMBER4=N'"+strHotelNo4 +"',HOTEL_NAME=N'"+strHotelName+"',HOTEL_NAME1=N'"+strHotelName1+"',HOTEL_NAME2=N'"+strHotelName2+"',HOTEL_NAME3=N'"+strHotelName3+"',HOTEL_NAME4=N'"+strHotelName4+"' WHERE USERID ="+strTravellerId;
						  }
			
						  int iupdate = stmt.executeUpdate(strSql); 						  
						  objCstmt   =  objCon.prepareCall("{?=call PROC_DELETE_FOREX_DETAIL_TABLES_DOM(?)}");
						  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						  objCstmt.setString(2, strTravel_Id);
						  iSuccess2   =  objCstmt.executeUpdate();
						  objCstmt.close();

						  //Procedure for update the billing info and travel cheque info in T_Travel_Detail_Dom Table
						  objCstmt  =  objCon.prepareCall("{?=call PROC_UPDATE_BILLING_INFO_DOM(?,?,?,?,?,?,?,? , ?,?,?,?,?,?,?)}");
						  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						  objCstmt.setString(2, strTravel_Id);
						  objCstmt.setString(3, strBillingSite);             
						  objCstmt.setString(4, strBillingClient);
						  objCstmt.setString(5, strTotalAmount);
						  objCstmt.setString(6, strBaseCurrency);
						  objCstmt.setString(7, strExpenditureRemarks);
						  objCstmt.setString(8, ""); 
						  objCstmt.setString(9, Suser_id);
						  objCstmt.setString(10, dbl_YTM_BUDGET);
						  objCstmt.setString(11, dbl_YTD_ACTUAL);
						  objCstmt.setString(12, dbl_AVAIL_BUDGET);
						  objCstmt.setString(13, dbl_EST_EXP);
						  objCstmt.setString(14, str_EXP_REMARKS);
						  objCstmt.setString(15, strTotalFareCurrency);
						  objCstmt.setInt(16,Integer.parseInt(strTotalFareAmount));
						  iSuccess3   =  objCstmt.executeUpdate();
						  objCstmt.close();

						  for ( int k =0; k < strEntPerDay.length ; k++ ) {						  		 
					  			  if(strEntPerDay[k]==null || strEntPerDay[k].equals(""))
					  				  strEntPerDay[k]="0";
					  			  if(strTotalTourDay[k]==null || strTotalTourDay[k].equals(""))
					  				  strTotalTourDay[k]="0";
					  			  if(strEntPerDay2[k]==null || strEntPerDay2[k].equals(""))
					  				  strEntPerDay2[k]="0";
					  			  if(strTotalTourDay2[k]==null || strTotalTourDay2[k].equals(""))
					  				  strTotalTourDay2[k]="0";
					  			  if(strContingecies[k]==null || strContingecies[k].equals(""))
					  				strContingecies[k]="0";
					  			  if(strContingecies2[k]==null || strContingecies2[k].equals(""))
					  				  strContingecies2[k]="0";
					  			  if(strTotalForex[k]==null || strTotalForex[k].equals(""))
					  				strTotalForex[k]="0";
					  			  if(strTACurrency[k]!=null)
					  				strTACurrency[k]=strTACurrency[k].trim();
					  			  if(strTotalINR[k]==null || strTotalINR[k].equals(""))
					  				  strTotalINR[k]="0";  
						  			
					  			  objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_EXPENDITURE_DOM(?,?,?,?,?,?,?,?,?,?,?)}"); //PROCEDURE to insert the row in T_TRAVEL_MST Table
					  			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					  	          objCstmt.setString(2, strTravel_Id);
					  	          objCstmt.setString(3, strTACurrency[k]);
					  	          objCstmt.setDouble(4, Double.parseDouble(strEntPerDay[k]));
					  	          objCstmt.setString(5, strTotalTourDay[k]); 
					  	          objCstmt.setDouble(6, Double.parseDouble(strEntPerDay2[k]));
					  			  objCstmt.setString(7, strTotalTourDay2[k]);
					  			  objCstmt.setDouble(8, Double.parseDouble(strContingecies[k]));
					  			  objCstmt.setDouble(9, Double.parseDouble(strContingecies2[k]));
					  		      objCstmt.setDouble(10, Double.parseDouble(strTotalForex[k]));
					  			  objCstmt.setString(11, Suser_id); 
					  			  objCstmt.setString(12, "0"); 			  
					  			  if(strHiddenValue[k].equals("v") && Double.parseDouble(strTotalINR[k])>0) {
					  				  iSuccess4   =  objCstmt.executeUpdate();
					  			  }
					  			  objCstmt.close();
						  	}
						  
						    if(strmataprice.equalsIgnoreCase("y")) {								
						    	if(strTkAgent.equalsIgnoreCase("n")) { 
									objCstmt=objCon.prepareCall("{?=call PROC_UPDATE_TRAVEL_TICKET_DETAIL(?,?,?,?,?,?,?,?)}");
									objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
									objCstmt.setString(2,strTravel_Id);
									objCstmt.setString(3,strTravelType);
									objCstmt.setString(4,strTkAgent);
									objCstmt.setString(5,strTkAirLine);
									objCstmt.setString(6,strTkcurrency);
									objCstmt.setString(7,strTklocalprice);
									objCstmt.setString(8,strTkRemarks);
									objCstmt.setString(9,Suser_id);
								    objCstmt.executeUpdate();
							        objCstmt.close();						        
								} else { 					
									objCstmt=objCon.prepareCall("{?=call PROC_UPDATE_TRAVEL_TICKET_DETAIL(?,?,?,?,?,?,?,?)}");
									objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
									objCstmt.setString(2,strTravel_Id);
									objCstmt.setString(3,strTravelType);
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
					 } else if(strTravelType != null && strTravelType.equals("I")) {
							objCstmt =  objCon.prepareCall("{?=call PROC_TRANSFER_PASSPORTUSERINFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,     ?,?,?,?,?,?,?)}");
							objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setString(2,strTravellerId.trim());
							objCstmt.setString(3, strPassportNo.trim());
							objCstmt.setString(4, strPassportIssuePlace.trim());
							objCstmt.setString(5, strPassportIssueDate.trim());
							objCstmt.setString(6, strPassportExpireDate.trim());
							objCstmt.setString(7, radioEcnr);
							objCstmt.setString(8, strDOB.trim());
							objCstmt.setString(9, strContactNo.trim());
							objCstmt.setString(10, strPermanentAddress.trim());
							objCstmt.setString(11, strAirLineNo.trim());
							objCstmt.setString(12, strAirLineNo1.trim());
							objCstmt.setString(13, strAirLineNo2.trim());
							objCstmt.setString(14, strCurrentAddress.trim());
							objCstmt.setString(15, strAirLineName.trim());
							objCstmt.setString(16, strAirLineName1.trim());
							objCstmt.setString(17, strAirLineName2.trim());
							objCstmt.setString(18, strAirLineNo3.trim());
							objCstmt.setString(19, strAirLineNo4.trim());
							objCstmt.setString(20, strAirLineName3.trim());
							objCstmt.setString(21, strAirLineName4.trim());
							objCstmt.setString(22, strHotelNo.trim());
							objCstmt.setString(23, strHotelNo1.trim());
							objCstmt.setString(24, strHotelNo2.trim());
							objCstmt.setString(25, strHotelNo3.trim());
							objCstmt.setString(26, strHotelNo4.trim());
							objCstmt.setString(27, strHotelName.trim());
							objCstmt.setString(28, strHotelName1.trim());
							objCstmt.setString(29, strHotelName2.trim());
							objCstmt.setString(30, strHotelName3.trim());
							objCstmt.setString(31, strHotelName4.trim());
							objCstmt.setString(32, fullName.trim());
							objCstmt.setString(33, firstName.trim());
							objCstmt.setString(34, lastName.trim());
							objCstmt.setString(35, strNationality.trim());
							objCstmt.execute();
							objCstmt.close();							
							
							objCstmt = objCon.prepareCall("{?=call PROC_DELETE_FOREX_DETAIL_TABLES(?)}");//PROCEDURE to insert the row in T_TRAVEL_MST Table
					        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					        objCstmt.setString(2, strTravel_Id);
					        iSuccess2 = objCstmt.executeUpdate();
					        objCstmt.close();					        
					        
							//Procedure for update the billing info and travel cheque info in T_Travel_Detail_Int Table
							objCstmt = objCon.prepareCall("{?=call PROC_UPDATE_BILLING_INFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST  Table
					        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					        objCstmt.setString(2, strTravel_Id);
					        objCstmt.setString(3, strBillingSite);             
					        objCstmt.setString(4, strBillingClient);
					        objCstmt.setString(5, strTotalAmount);
							objCstmt.setString(6, strBaseCurrency);							
							objCstmt.setString(7, strTravellerCheque);
							objCstmt.setString(8, strTravellerCheque1);
							objCstmt.setString(9, strTravellerCheque2);					
							objCstmt.setString(10, strTCCurrency);
							objCstmt.setString(11, strTCCurrency1);
							objCstmt.setString(12, strTCCurrency2);					
							objCstmt.setString(13, strExpenditureRemarks);
							objCstmt.setString(14, strCashBreakupRemarks);					
							objCstmt.setString(15, "");					
							objCstmt.setString(16, Suser_id);		
							objCstmt.setString(17, dbl_YTM_BUDGET);
							objCstmt.setString(18, dbl_YTD_ACTUAL);
							objCstmt.setString(19, dbl_AVAIL_BUDGET);
							objCstmt.setString(20, dbl_EST_EXP);
							objCstmt.setString(21, str_EXP_REMARKS);
							objCstmt.setString(22, strTotalFareCurrency);
							objCstmt.setInt(23, Integer.parseInt(strTotalFareAmount));							
					        iSuccess3   =  objCstmt.executeUpdate();
					        objCstmt.close();
					
							for(int i=0; i<strEntPerDay.length; i++) {								
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
					  
						          objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_EXPENDITURE_INT(?,?,?,?,?,?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST Table        
						          objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						          objCstmt.setString(2, strTravel_Id);
						          objCstmt.setString(3, strTACurrency[i]);
						          objCstmt.setDouble(4, Double.parseDouble(strEntPerDay[i]));
						          objCstmt.setString(5, strTotalTourDay[i]);
						          objCstmt.setDouble(6, Double.parseDouble(strEntPerDay2[i]));
								  objCstmt.setString(7, strTotalTourDay2[i]);
								  objCstmt.setDouble(8, Double.parseDouble(strContingecies[i]));
								  objCstmt.setDouble(9, Double.parseDouble(strContingecies2[i]));
							      objCstmt.setDouble(10, Double.parseDouble(strTotalForex[i]));
								  objCstmt.setString(11, Suser_id); 
								  objCstmt.setString(12, "0"); 
								  if(strHiddenValue[i].equals("v") && Double.parseDouble(strTotalINR[i])>0) {
									  iSuccess4 =  objCstmt.executeUpdate();
								  }							  
						          objCstmt.close();
							   }
							
							if(strmataprice.equalsIgnoreCase("y")) {																
						    	if(strTkAgent.equalsIgnoreCase("n")) { 
									objCstmt=objCon.prepareCall("{?=call PROC_UPDATE_TRAVEL_TICKET_DETAIL(?,?,?,?,?,?,?,?)}");
									objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
									objCstmt.setString(2,strTravel_Id);
									objCstmt.setString(3,strTravelType);
									objCstmt.setString(4,strTkAgent);
									objCstmt.setString(5,strTkAirLine);
									objCstmt.setString(6,strTkcurrency);
									objCstmt.setString(7,strTklocalprice);
									objCstmt.setString(8,strTkRemarks);
									objCstmt.setString(9,Suser_id);
								    objCstmt.executeUpdate();
							        objCstmt.close();						        
								} else { 					
									objCstmt=objCon.prepareCall("{?=call PROC_UPDATE_TRAVEL_TICKET_DETAIL(?,?,?,?,?,?,?,?)}");
									objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
									objCstmt.setString(2,strTravel_Id);
									objCstmt.setString(3,strTravelType);
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
					}
				   strMessage = dbLabelBean.getLabel("message.global.save",strsesLanguage);	
				   submitToWorkFlow = true;
			}  else	{
				objCon.rollback();
				strTravel_Id = null;
				strMessage = dbLabelBean.getLabel("message.global.notsave",strsesLanguage);
			}
		} catch(Exception e) {			  
			  System.out.println("Error in Insertion block of T_QuickTravel_Detail_Post.jsp=="+e);
			  strMessage = dbLabelBean.getLabel("message.global.notsave",strsesLanguage);			  
		}	
		
	} else {
		strTravel_Req_Id     = strTravelReqId;
	    strTravel_Id         = strTravelId;   
	    strTravel_Req_No     = strTravelReqNo;
	    
	    try {
	    	
	    	objCon =  dbConBean.getConnection(); 
	    	
	    	if(strFwdJurnFlag) {					
				strDepDateFwd 		= strDepDate[0];
		    }	    
	    	
	    	if(strTravelType != null && strTravelType.equals("D")) {
				  stmt = 	objCon.createStatement();
				  if(strIdentityProofOld==null || strIdentityProofOld.equals("-1") || strIdentityProofOld.equals("0")) {
				        strSql = "UPDATE M_USERINFO SET  IDENTITY_ID='"+strIdentityProof+"',IDENTITY_NO='"+strIdentityProofNo+"', CONTACT_NUMBER='"+strContactNo+"',FF_NUMBER=N'"+strAirLineNo+"',FF_NUMBER1=N'"+strAirLineNo1+"',FF_NUMBER2=N'"+strAirLineNo2 +"',FF_AIR_NAME=N'"+strAirLineName+"',FF_AIR_NAME1=N'"+strAirLineName1+"',FF_AIR_NAME2=N'"+strAirLineName2+"',FF_AIR_NAME3=N'"+strAirLineName3+"',FF_AIR_NAME4=N'"+strAirLineName4+"',HOTEL_NUMBER=N'"+strHotelNo+"',HOTEL_NUMBER1=N'"+strHotelNo1+"',HOTEL_NUMBER2=N'"+strHotelNo2+"',HOTEL_NUMBER3=N'"+strHotelNo3+"',HOTEL_NUMBER4=N'"+strHotelNo4 +"',HOTEL_NAME=N'"+strHotelName+"',HOTEL_NAME1=N'"+strHotelName1+"',HOTEL_NAME2=N'"+strHotelName2+"',HOTEL_NAME3=N'"+strHotelName3+"',HOTEL_NAME4=N'"+strHotelName4+"' WHERE USERID ="+strTravellerId;
				  } else {
				  strSql = "UPDATE M_USERINFO SET CONTACT_NUMBER='"+strContactNo+"',FF_NUMBER=N'"+strAirLineNo+"',FF_NUMBER1=N'"+strAirLineNo1+"',FF_NUMBER2=N'"+strAirLineNo2 +"',FF_AIR_NAME=N'"+strAirLineName+"',FF_AIR_NAME1=N'"+strAirLineName1+"',FF_AIR_NAME2=N'"+strAirLineName2+"',FF_AIR_NAME3=N'"+strAirLineName3+"',FF_AIR_NAME4=N'"+strAirLineName4+"',HOTEL_NUMBER=N'"+strHotelNo+"',HOTEL_NUMBER1=N'"+strHotelNo1+"',HOTEL_NUMBER2=N'"+strHotelNo2+"',HOTEL_NUMBER3=N'"+strHotelNo3+"',HOTEL_NUMBER4=N'"+strHotelNo4 +"',HOTEL_NAME=N'"+strHotelName+"',HOTEL_NAME1=N'"+strHotelName1+"',HOTEL_NAME2=N'"+strHotelName2+"',HOTEL_NAME3=N'"+strHotelName3+"',HOTEL_NAME4=N'"+strHotelName4+"' WHERE USERID ="+strTravellerId;
				  }	
				  int iupdate = stmt.executeUpdate(strSql);				  
				 
				  strSql = "SELECT * FROM T_RET_JOURNEY_DETAILS_DOM (NOLOCK) WHERE TRAVEL_ID="+strTravelId+" AND JOURNEY_ORDER=1 AND APPLICATION_ID=1";
				  rs3     = dbConBean3.executeQuery(strSql);
					if(rs3.next()) {						
						strRetJurnExistFlag = true;						 					
					}
				  rs3.close();
				  
				  if(!strRetJurnFlag && strRetJurnExistFlag) {
					  stmt = 	objCon.createStatement();
						strSql3 = "DELETE FROM T_RET_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravelId+" AND JOURNEY_ORDER=1 AND APPLICATION_ID=1"; 
						iSuccess = stmt.executeUpdate(strSql3);
				   }				  
				  
				  strSql = "SELECT PARENT_ID FROM T_INTERIM_JOURNEY WHERE TRAVEL_ID = "+strTravel_Id;
					rs3     = dbConBean3.executeQuery(strSql);
					if(rs3.next()) {						
						strParentId = rs3.getString("PARENT_ID");						
						stmt = 	objCon.createStatement();
						strSql2 = "DELETE FROM T_INTERIM_JOURNEY WHERE PARENT_ID='"+strParentId+"' AND TRAVEL_ID='"+strTravel_Id+"'"; 
						iSuccess = stmt.executeUpdate(strSql2);						 					
					}
					rs3.close();
					
					stmt = 	objCon.createStatement();
					strSql="DELETE T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID='"+strTravel_Id+"' AND JOURNEY_ORDER > 1 AND STATUS_ID=10 AND APPLICATION_ID=1";
					intSuccess = stmt.executeUpdate(strSql);
				  
				  objCstmt = objCon.prepareCall("{?=call PROC_DELETE_FROM_DOM_TABLE(?,?,?)}"); 
				  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				  objCstmt.setString(2, strTravel_Req_Id);
				  objCstmt.setString(3, strTravel_Id);
				  objCstmt.setString(4, strTravelType); 
				  intSuccess1   =  objCstmt.executeUpdate();
				  objCstmt.close();
				  
				  objCstmt = objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_DETAIL_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,    ?,?,?,?,?,?,   ?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
				  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				  objCstmt.setString(2, strTravel_Req_Id);
				  objCstmt.setString(3, strTravel_Id);
				  objCstmt.setString(4, strTravel_Req_No);
				  objCstmt.setString(5, strSiteId);
				  objCstmt.setString(6, strTravellerId);
				  objCstmt.setString(7, strAge);
				  objCstmt.setString(8, strSex);
				  objCstmt.setString(9, strDepDateFwd);
				  objCstmt.setString(10, strMealId);
				  objCstmt.setString(11, strHotelRequired);
				  objCstmt.setString(12, strHotelBudget);
				  objCstmt.setString(13, strBudgetCurrency);
				  objCstmt.setString(14, strCheckin);
				  objCstmt.setString(15, strCheckout);
				  objCstmt.setString(16, strRemarks);
				  objCstmt.setString(17, strReturnType);
				  objCstmt.setString(18, Suser_id);
				  objCstmt.setString(19, strSelectManagerRadio);
				  objCstmt.setString(20, strManager);
				  objCstmt.setString(21, strHod);
				  objCstmt.setString(22, strCARD_TYPE); 
				  objCstmt.setString(23, strCARD_HOLDER_NAME);
				  objCstmt.setString(24, strCARD_NUMBER1); 
				  objCstmt.setString(25, strCARD_NUMBER2); 
				  objCstmt.setString(26, strCARD_NUMBER3); 
				  objCstmt.setString(27, strCARD_NUMBER4); 
				  objCstmt.setString(28, strCVV_NUMBER); 
				  objCstmt.setString(29, strCARD_EXP_DATE); 
				  objCstmt.setString(30, strReasonForTravel); 
				  objCstmt.setString(31, strReasonForSkip);	
				  objCstmt.setString(32, strPlace); 	
				  objCstmt.setString(33, strForTatkaalRequired); 
				  objCstmt.setString(34, strForCoupanRequired); 
				  objCstmt.setString(35, strRetTatkaalRequired); 
				  objCstmt.setString(36, strRetCoupanRequired); 
				  objCstmt.setString(37, strIdentityProof); 	
				  objCstmt.setString(38, strIdentityProofNo);	
				  objCstmt.setString(39, "");  
				  objCstmt.setString(40, strBoardMember);
				  objCstmt.setInt(41, Integer.parseInt(strCostCentre));	
				  objCstmt.setString(42, "");
				  objCstmt.setString(43, "2");
				  objCstmt.setString(44, "2");
				  objCstmt.setString(45, "0");
				  objCstmt.setString(46, "");
				  objCstmt.setString(47, "0");
				  objCstmt.setString(48, "1");
				  objCstmt.setString(49, "2");
				  objCstmt.setString(50, "2");
				  objCstmt.setString(51, "");
				  objCstmt.setString(52, "");
				  objCstmt.setString(53, null);
				  objCstmt.setString(54, "");
				  intSuccess2   =  objCstmt.executeUpdate();
				  objCstmt.close();
	    	} else if(strTravelType.equals("I")) {	
	    		
	    		strSql = "SELECT * FROM T_RET_JOURNEY_DETAILS_INT (NOLOCK) WHERE TRAVEL_ID="+strTravelId+" AND JOURNEY_ORDER=1 AND APPLICATION_ID=1";
				  rs3     = dbConBean3.executeQuery(strSql);
					if(rs3.next()) {						
						strRetJurnExistFlag = true;						 					
					}
				  rs3.close();
				  
				  if(!strRetJurnFlag && strRetJurnExistFlag) {
					  stmt = 	objCon.createStatement();
						strSql3 = "DELETE FROM T_RET_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravelId+" AND JOURNEY_ORDER=1 AND APPLICATION_ID=1"; 
						iSuccess = stmt.executeUpdate(strSql3);
				   }			
	    		
	    		  strSql = "SELECT PARENT_ID FROM T_INTERIM_JOURNEY WHERE TRAVEL_ID = "+strTravel_Id;
				  rs3     = dbConBean3.executeQuery(strSql);
				  if(rs3.next()) {						
					 strParentId = rs3.getString("PARENT_ID");						
					 stmt = 	objCon.createStatement();
					 strSql2 = "DELETE FROM T_INTERIM_JOURNEY WHERE PARENT_ID='"+strParentId+"' AND TRAVEL_ID='"+strTravel_Id+"'"; 
					 iSuccess = stmt.executeUpdate(strSql2);
					 					
				  }
				  rs3.close();
			    			
    			  stmt = 	objCon.createStatement();
				  strSql = "DELETE T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID='"+strTravel_Id+"' AND JOURNEY_ORDER > 1 AND STATUS_ID=10 AND APPLICATION_ID=1";
				  intSuccess = stmt.executeUpdate(strSql);
	    		
		    	  objCstmt = objCon.prepareCall("{?=call PROC_DELETE_FROM_INT_TABLE(?,?,?)}"); 
		  	      objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		  	      objCstmt.setString(2, strTravel_Req_Id);
		  	      objCstmt.setString(3, strTravel_Id);
		  		  objCstmt.setString(4, strTravelType); 
		  	      intSuccess1   =  objCstmt.executeUpdate();
		  	      objCstmt.close();
	  	      
			  	  objCstmt = objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_DETAIL_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
			  	  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			      objCstmt.setString(2, strTravel_Req_Id);
			      objCstmt.setString(3, strTravel_Id);
			      objCstmt.setString(4, strTravel_Req_No);
			      objCstmt.setString(5, strSiteId);
			      objCstmt.setString(6, strTravellerId);
			      objCstmt.setString(7, strAge);
			      objCstmt.setString(8, strSex);
			      objCstmt.setString(9, strDepDateFwd);
			      objCstmt.setString(10, strMealId);
			      objCstmt.setString(11, strVisaRequired);
			      objCstmt.setString(12, strVisaComment);
			      objCstmt.setString(13, strInsuranceRequired);
			      objCstmt.setString(14, strNominee);
			      objCstmt.setString(15, strRelation);
			      objCstmt.setString(16, strInsuranceComment);
			      objCstmt.setString(17, strHotelRequired);
			      objCstmt.setString(18, strHotelBudget);
			      objCstmt.setString(19, strPlace);
			      objCstmt.setString(20, strBudgetCurrency);
			      objCstmt.setString(21, strRemarks);
			      objCstmt.setString(22, strReturnType);
				  objCstmt.setString(23, Suser_id);
			      objCstmt.setString(24, strSelectManagerRadio);
				  objCstmt.setString(25, strManager);
				  objCstmt.setString(26, strHod);
				  objCstmt.setString(27, strCARD_TYPE);  
				  objCstmt.setString(28, strCARD_HOLDER_NAME);		
				  objCstmt.setString(29, strCARD_NUMBER1); 
				  objCstmt.setString(30, strCARD_NUMBER2); 
				  objCstmt.setString(31, strCARD_NUMBER3); 
				  objCstmt.setString(32, strCARD_NUMBER4); 
				  objCstmt.setString(33, strCVV_NUMBER); 
				  objCstmt.setString(34, strCARD_EXP_DATE); 
				  objCstmt.setString(35, strCheckin); 
				  objCstmt.setString(36, strCheckout); 
				  objCstmt.setString(37, strReasonForTravel);
				  objCstmt.setString(38, strReasonForSkip);
				  objCstmt.setString(39, "");
			  	  objCstmt.setString(40, strBoardMember);
			  	  objCstmt.setInt(41, Integer.parseInt(strCostCentre));
			  	  objCstmt.setString(42, "");
				  objCstmt.setString(43, "2");
				  objCstmt.setString(44, "2");
				  objCstmt.setString(45, "0");
				  objCstmt.setString(46, "");
				  objCstmt.setString(47, "0");
				  objCstmt.setString(48, "1");
				  objCstmt.setString(49, "2");
				  objCstmt.setString(50, "2");
				  objCstmt.setString(51, "");
				  objCstmt.setString(52, "");
				  objCstmt.setString(53, null);
				  objCstmt.setString(54, "");
				  objCstmt.setString(55, "0");
				  objCstmt.setString(56, null);
				  objCstmt.setString(57, null);
			  	  intSuccess2   =  objCstmt.executeUpdate();
			  	  objCstmt.close();
	    		
	    	}
	    	
	    	if(strFwdJurnFlag) {
	    		strDepCityFwd 		= strDepCity[0];
				strArrCityFwd 		= strArrCity[0];
				strDepDateFwd 		= strDepDate[0];
				strPreferTimeFwd	= strPreferTime[0];				
				strTravelClassFwd 	= strTravelClass[0];
				strNameOfAirlineFwd = strNameOfAirline[0];
				strPreferSeatFwd	= strPreferSeat[0];
				
				if(strTravelType.equals("D")) {
					strTravelModeFwd 	= strTravelMode[0];

					
					objCstmt = objCon.prepareCall("{?=call PROC_UPDATE_T_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
					objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					objCstmt.setString(2, strTravel_Id);
					objCstmt.setString(3, strDepCityFwd);
					objCstmt.setString(4, strArrCityFwd);
					objCstmt.setString(5, strDepDateFwd); 
					objCstmt.setString(6, strJourneyOrder);
					objCstmt.setString(7, strTravelModeFwd); 
					objCstmt.setString(8, strNameOfAirlineFwd); 
					objCstmt.setString(9, strTravelClassFwd);
					objCstmt.setString(10, strPreferTimeFwd);
					objCstmt.setString(11, ""); 
					objCstmt.setString(12, Suser_id); 
					objCstmt.setString(13, strPreferSeatFwd); 
					objCstmt.setString(14, strTicketRefundfwd);
					objCstmt.setString(15, "1");
					objCstmt.setInt(16, 0);
					intSuccess3   =  objCstmt.executeUpdate();
					objCstmt.close();
				} else if(strTravelType.equals("I")) {
					strTravelModeFwd = "1";
					//strPreferSeatFwd = "1";
					
					objCstmt = objCon.prepareCall("{?=call PROC_UPDATE_T_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
					objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					objCstmt.setString(2, strTravel_Id);
					objCstmt.setString(3, strDepCityFwd);
					objCstmt.setString(4, strArrCityFwd);
					objCstmt.setString(5, strDepDateFwd);
					objCstmt.setString(6, strJourneyOrder); 
					objCstmt.setString(7, strTravelModeFwd);
					objCstmt.setString(8, strNameOfAirlineFwd); 
					objCstmt.setString(9, strTravelClassFwd);
					objCstmt.setString(10, strPreferTimeFwd);
					objCstmt.setString(11, "");
					objCstmt.setString(12, Suser_id);
					objCstmt.setString(13, strPreferSeatFwd);
					objCstmt.setString(14, "1");
					objCstmt.setInt(15, 0);
					intSuccess3   =  objCstmt.executeUpdate();
					objCstmt.close();
				}			
			}
	    	
	    	if(strRetJurnFlag) {
	    		strDepCityRet 		= strDepCity[(strDepCity.length - 1)];
				strArrCityRet 		= strArrCity[strDepCity.length - 1];
				strDepDateRet 		= strDepDate[strDepCity.length - 1];
				strPreferTimeRet	= strPreferTime[strDepCity.length - 1];
				strTravelClassRet 	= strTravelClass[strDepCity.length - 1];
				strNameOfAirlineRet = strNameOfAirline[strDepCity.length - 1];
				strPreferSeatRet	= strPreferSeat[strDepCity.length - 1];
				
				 if(strDepCityRet==null) {
					strDepCityRet = ""; 
				 }
				 if(strArrCityRet==null) {
					 strArrCityRet = ""; 
				 }
				 if(strDepDateRet==null) {
					 strDepDateRet = ""; 
				 }
				
				if(strTravelType.equals("D")) {
					strTravelModeRet 	= strTravelMode[strDepCity.length - 1];
					
					if(strRetJurnExistFlag) {
						objCstmt  = objCon.prepareCall("{?=call PROC_UPDATE_T_RET_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
						objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2, strTravel_Id);
						objCstmt.setString(3, strDepCityRet);    
						objCstmt.setString(4, strArrCityRet);  
						objCstmt.setString(5, strDepDateRet); 
						objCstmt.setString(6, strJourneyOrder); 
						objCstmt.setString(7, strTravelModeRet); 
						objCstmt.setString(8, strNameOfAirlineRet);
						objCstmt.setString(9, strTravelClassRet); 
						objCstmt.setString(10, strPreferTimeRet);
						objCstmt.setString(11, "");
						objCstmt.setString(12, Suser_id); 
						objCstmt.setString(13, strPreferSeatRet);
						objCstmt.setString(14, strTicketRefundRtd);
						objCstmt.setString(15, "1");
						objCstmt.setInt(16, 0);
						intSuccess4   =  objCstmt.executeUpdate();
						objCstmt.close();
					} else {
						objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_RET_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
						objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2, strTravel_Id);
						objCstmt.setString(3, strDepCityRet);
						objCstmt.setString(4, strArrCityRet);
						objCstmt.setString(5, strDepDateRet);
						objCstmt.setString(6, strJourneyOrder);
						objCstmt.setString(7, strTravelModeRet);
						objCstmt.setString(8, strNameOfAirlineRet);
						objCstmt.setString(9, strTravelClassRet);
						objCstmt.setString(10, strPreferTimeRet);
						objCstmt.setString(11, Suser_id); 
						objCstmt.setString(12, strPreferSeatRet);
						objCstmt.setString(13, strTicketRefundRtd);
						objCstmt.setString(14, "1");
						objCstmt.setInt(15, 0);
						intSuccess4 = objCstmt.executeUpdate();
						objCstmt.close();
					}
				} else if(strTravelType.equals("I")) {
					strTravelModeRet = "1";
					//strPreferSeatRet = "1";
					
					if(strRetJurnExistFlag) {
						objCstmt = objCon.prepareCall("{?=call PROC_UPDATE_T_RET_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
						objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2, strTravel_Id);
						objCstmt.setString(3, strDepCityRet);
						objCstmt.setString(4, strArrCityRet);
						objCstmt.setString(5, strDepDateRet);
						objCstmt.setString(6, strJourneyOrder); 
						objCstmt.setString(7, strTravelModeRet); 
						objCstmt.setString(8, strNameOfAirlineRet);
						objCstmt.setString(9, strTravelClassRet);
						objCstmt.setString(10, strPreferTimeRet);
						objCstmt.setString(11, ""); 
						objCstmt.setString(12, Suser_id);
						objCstmt.setString(13, strPreferSeatRet);
						objCstmt.setString(14, "1");
						objCstmt.setInt(15, 0);
						intSuccess4   =  objCstmt.executeUpdate();
						objCstmt.close();
					} else {
						objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_RET_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
					    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					    objCstmt.setString(2, strTravel_Id);
					    objCstmt.setString(3, strDepCityRet);
					    objCstmt.setString(4, strArrCityRet);
					    objCstmt.setString(5, strDepDateRet);
					    objCstmt.setString(6, strJourneyOrder);
					    objCstmt.setString(7, strTravelModeRet);
					    objCstmt.setString(8, strNameOfAirlineRet);
					    objCstmt.setString(9, strTravelClassRet);
					    objCstmt.setString(10, strPreferTimeRet);
					    objCstmt.setString(11, Suser_id);
					    objCstmt.setString(12, strPreferSeatRet);
					    objCstmt.setString(13, "1");
					    objCstmt.setInt(14, 0);
					    intSuccess4 = objCstmt.executeUpdate();
					    objCstmt.close();
					}					
				}			
			}
	    	
	    	if(strIntrmiJurnFlag) {	    		
	    		strTravel_Id_Intrim  =  dbUtilityBean.getNewGeneratedId("INTERIM_ID")+"";	    		
	    		for(int i = 1; i < strDepCity.length - 1; i++) {	
	    			int jrOrder = i+1;
	    			strDepCityIntrmi 		= strDepCity[i];
					strArrCityIntrmi 		= strArrCity[i];
					strDepDateIntrmi 		= strDepDate[i];
					strPreferTimeIntrmi 	= strPreferTime[i];					
					strTravelClassIntrmi 	= strTravelClass[i];
					strNameOfAirlineIntrmi 	= strNameOfAirline[i];
					strPreferSeatIntrmi		= strPreferSeat[i];
					
					if(strTravelType.equals("D")) {						
						strTravelModeIntrmi	    = strTravelMode[i];
						
						objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
						objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2, strTravel_Id);
						objCstmt.setString(3, strDepCityIntrmi);
						objCstmt.setString(4, strArrCityIntrmi);
						objCstmt.setString(5, strDepDateIntrmi);
						objCstmt.setInt(6, jrOrder);
						objCstmt.setString(7, strTravelModeIntrmi);
						objCstmt.setString(8, strNameOfAirlineIntrmi);
						objCstmt.setString(9, strTravelClassIntrmi);
						objCstmt.setString(10, strPreferTimeIntrmi);
						objCstmt.setString(11, Suser_id);
						objCstmt.setString(12, strPreferSeatIntrmi);
						objCstmt.setString(13, "n");
						objCstmt.setString(14, "1");
						objCstmt.setInt(15, 0);
						intSuccess5 = objCstmt.executeUpdate();
						objCstmt.close();		
					} else if(strTravelType.equals("I")) {
						strTravelModeIntrmi = "1";
						//strPreferSeatIntrmi = "1";
						
						objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
						objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2, strTravel_Id);
						objCstmt.setString(3, strDepCityIntrmi);
						objCstmt.setString(4, strArrCityIntrmi);
						objCstmt.setString(5, strDepDateIntrmi);
						objCstmt.setInt(6, jrOrder);
						objCstmt.setString(7, strTravelModeIntrmi);
						objCstmt.setString(8, strNameOfAirlineIntrmi);
						objCstmt.setString(9, strTravelClassIntrmi);
						objCstmt.setString(10, strVisaRequired);
						objCstmt.setString(11, strVisaComment);
						objCstmt.setString(12, strPreferTimeIntrmi);     
						objCstmt.setString(13, Suser_id);
						objCstmt.setString(14, strPreferSeatIntrmi); 
						objCstmt.setString(15, "1");
					    objCstmt.setInt(16, 0);
						intSuccess5 = objCstmt.executeUpdate();
						objCstmt.close();				
					}
					
					  objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_INTERIM_JOURNEY_DETAILS(?,?,?,?,?,?,?,?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_INTERIM_JOURNEY  Table
					  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					  objCstmt.setString(2, strTravel_Id_Intrim);
					  objCstmt.setString(3, strDepCityIntrmi);
					  objCstmt.setString(4, strArrCityIntrmi);
					  objCstmt.setString(5, strDepDateIntrmi);
					  objCstmt.setString(6, strTravelModeIntrmi);
					  objCstmt.setString(7, strNameOfAirlineIntrmi);
					  objCstmt.setString(8, strTravelClassIntrmi);
					  objCstmt.setString(9, strVisaRequired);
					  objCstmt.setString(10, strVisaComment); 
					  objCstmt.setString(11, strTravelType);
					  objCstmt.setString(12, strPreferTimeIntrmi);
					  objCstmt.setString(13, strPreferSeatIntrmi);
					  objCstmt.setString(14, "n");
					  //objCstmt.setInt(15, 0);
					  iSuccess1   =  objCstmt.executeUpdate();
					  objCstmt.close();
				}
				
				// update T_INTERIM_JOURNEY
				if(strTravel_Id_Intrim != null && !strTravel_Id_Intrim.equals("")) {
				  stmt = 	objCon.createStatement();
				  strSql = "UPDATE T_INTERIM_JOURNEY SET TRAVEL_ID='"+strTravel_Id+"' WHERE PARENT_ID ="+ strTravel_Id_Intrim;				 
				  int  iupdate1 = stmt.executeUpdate(strSql);
				}
			}
	    	
	    	    strSql = "SELECT TRAVEL_ACC_ID FROM T_TRAVEL_ACCOMMODATION WHERE TRAVEL_ID='"+strTravel_Id+"' and TRAVEL_TYPE='"+strTravelType+"' AND STATUS_ID=10";
	    	    rsAccom     = dbConBean.executeQuery(strSql);
	    	    String strTravelAccId = "0";
				if(rsAccom.next()) {						
					strTravelAccId = rsAccom.getString("TRAVEL_ACC_ID");						 					
				}
				rsAccom.close();
			    
	    	    objCstmt = objCon.prepareCall("{?=call PROC_T_TRAVEL_ACCOMMODATION(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	            objCstmt.setString(2, strTravelAccId);
	            objCstmt.setString(3, strTravel_Req_Id);
	            objCstmt.setString(4, strTravel_Id);
	            objCstmt.setString(5, strTravelType); 
	            objCstmt.setString(6, strHotelRequired);
			    objCstmt.setString(7, strPlace);
			    if(strHotelBudget!=null && !strHotelBudget.equals("")){
	  			  	objCstmt.setDouble(8, Double.parseDouble(strHotelBudget));
	  			 } else {
	  				objCstmt.setDouble(8, Double.parseDouble("0"));
	  			 }
			    objCstmt.setString(9, strBudgetCurrency);
		        objCstmt.setString(10, strCheckin);
			    objCstmt.setString(11, strCheckout);			  			   	
			    objCstmt.setString(12, Suser_id); 
			    objCstmt.setString(13, "UPDATE"); 
			    objCstmt.setString(14, strIPAddress);
			    objCstmt.setInt(15, 0);
			    intSuccess8   =  objCstmt.executeUpdate();
			    objCstmt.close();
	    	
	    	if(intSuccess1 > 0 && intSuccess2 > 0) {
				if(strFwdJurnFlag && !strRetJurnFlag && !strIntrmiJurnFlag) {
					if(intSuccess3 > 0) {
						saveSuccess = true;
					}						    		
		    	} else if(strFwdJurnFlag && strRetJurnFlag && !strIntrmiJurnFlag) {
					if(intSuccess3 > 0 && intSuccess4 > 0) {
						saveSuccess = true;						
					}					
		    	} else if(strFwdJurnFlag && strRetJurnFlag && strIntrmiJurnFlag) {
		    		if(intSuccess3 > 0 && intSuccess4 > 0 && intSuccess5 > 0) {
		    			saveSuccess = true;
					}
		    	}			
		    }
	    	
	    	if(saveSuccess) {	    	
	    	//PROCEDURE for INSERT data in T_APPROVERS			
			   //Get the new Approve_Id from the T_Travel_Mst Table
			   String strApprove_Id  = "";
			   strApprove_Id  =  dbUtilityBean.getNewGeneratedId("APPROVE_ID")+"";
		
			   if(strSelectManagerRadio != null && strSelectManagerRadio.equals("manual")) {
					String strTravellerRole  = "";
					String strUnitHead       = "0";
					strSql = "SELECT LTRIM(RTRIM(ISNULL(ROLE_ID,'OR'))) AS ROLE_ID, LTRIM(RTRIM(ISNULL(UNIT_HEAD,'0'))) AS UNIT_HEAD FROM M_USERINFO (NOLOCK) WHERE USERID="+strTravellerId;
					rs     = dbConBean1.executeQuery(strSql);
					if(rs.next()) {
						 strTravellerRole = rs.getString("ROLE_ID");							
						 if(strTravellerRole.equalsIgnoreCase("CHAIRMAN")) {
							approverList.clear();
						 }						
					}
					rs.close();	
					//one UnitHead for multiple site
					strSql = "SELECT ISNULL(UNIT_HEAD,'0') AS UNIT_HEAD   FROM USER_MULTIPLE_ACCESS (NOLOCK) where userid="+strTravellerId+" and site_id="+strSiteId+" and status_id=10 and unit_head=1";
					rs = dbConBean1.executeQuery(strSql);
					if(rs.next()) {
						strUnitHead			=	rs.getString(1).trim();			
					}
					rs.close();
				   //one UnitHead for multiple site
	               //added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers					
				   if(strTravellerRole.equalsIgnoreCase("CHAIRMAN")) {
					   if(strTravelType.equals("D")) {
						   strSql = "SELECT LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, APPROVER_ID, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS (NOLOCK) WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='D' AND sp_role="+strWorkFlowName+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4"; 
					   } else if(strTravelType.equals("I")) {
						   strSql = "SELECT LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, APPROVER_ID, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS (NOLOCK) WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='I' AND sp_role="+strWorkFlowName+"  AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4"; 
					   }
						 
						rs     = dbConBean1.executeQuery(strSql);
						while(rs.next()) {
							  strUserRole = rs.getString("USERROLE");
							 if(strUserRole != null && strUserRole.equalsIgnoreCase("MATA")) {
								approverList.add(rs.getString("APPROVER_ID"));	
								approverList.add(strUserRole);  
							 }				 
						} 
						rs.close();	
					} else {					   
					  if(strManager != null) {
						// adding 1 level approver  as manager id 
					    approverList.add(strManager);
						approverList.add("WORKFLOW");
					  }
					  if(strHod != null) {
						//adding 2 level approver  as hod id
						//if condition added on 23 july 2013 by manoj chand to prevent addition of approval level 1 approver in level 2.
						if(!approverList.contains(strHod)) {
							approverList.add(strHod);
							approverList.add("WORKFLOW"); 
						}
					  }	   				  
					 
					  if(strTravelType.equals("D")) {
						  if(strHidAppFlag.equalsIgnoreCase("Y") && strHidAppShowBMFlag.equalsIgnoreCase("Y") && strBoardMember!=null && !strBoardMember.equalsIgnoreCase("-1") && !strBoardMember.equalsIgnoreCase("-2")) {
								approverList.add(strBoardMember);
								approverList.add("WORKFLOW"); 
						   }	
						  
						  strSql = "SELECT APPROVER_ID, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS (NOLOCK) WHERE SITE_ID="+strSiteId+" AND TRV_TYPE = 'D' AND sp_role="+strWorkFlowName+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4"; 
					  } else if(strTravelType.equals("I")) {
						  if(strHidAppFlag.equalsIgnoreCase("Y") && strHidAppShowBMFlag.equalsIgnoreCase("Y") && strBoardMember!=null && !strBoardMember.equalsIgnoreCase("-1")) {
								approverList.add(strBoardMember);
								approverList.add("WORKFLOW"); 
						   }
						  
						  strSql = "SELECT APPROVER_ID, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS (NOLOCK) WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='I' AND sp_role="+strWorkFlowName+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4";  
					  }
					  
					  rs     = dbConBean1.executeQuery(strSql);
					  while(rs.next())  {						
						String strTempApproverId =  rs.getString("APPROVER_ID").trim();
						 strUserRole = rs.getString("USERROLE");
						 //if traveller id is unit head of the site then it would not be appear in the approver list.	
						 if(strUnitHead.equalsIgnoreCase("1") && strTravellerId.equals(strTempApproverId)) {
						 }
						 	//Two Unit Heads belonging to the same site.
						 	//STATUS_ID=10
							 String strQuery="Select Unit_Head from USER_MULTIPLE_ACCESS (NOLOCK) where USERID="+strTempApproverId+" and SITE_ID="+strSiteId+" AND UNIT_HEAD=1 AND STATUS_ID=10 ORDER BY 1";
							 rs1     = dbConBean2.executeQuery(strQuery);
							 if(strUnitHead.equalsIgnoreCase("1") && rs1.next()) {								 
							 }
							 //End of modification
							 else {
								 if(strTravelType.equals("D")) {
									    if(approverList.contains(strTempApproverId)){  
											  int j = approverList.indexOf(strTempApproverId);
										    	int k=j+1;
	
												if (j == k - 1) {
													approverList.remove(j);
													approverList.remove(j);
												}
								             }	
											approverList.add(strTempApproverId);
											if(strUserRole != null && strUserRole.equalsIgnoreCase("OR"))
											{
												strUserRole = "DEFAULT";
											}
											approverList.add(strUserRole);
											
								 }  else if(strTravelType.equals("I")) {
								    // Added code for checking if appro ver is exits in defualt approver list
							        //modified added "approverList.contains("WORKFLOW")" condition in if
									if(approverList.contains(strTempApproverId) && approverList.contains("WORKFLOW")) {  
									  approverList.remove(strTempApproverId); 
									  approverList.remove("WORKFLOW"); 
									  }
			 					    approverList.add(strTempApproverId); 
								   if(strUserRole != null && strUserRole.equalsIgnoreCase("OR")) {
										strUserRole = "DEFAULT";
									}
									approverList.add(strUserRole);  
								 }
							 }rs1.close();
					  }
					  rs.close();					  
					}
				}			   
			   
			 	//Removing traveller name from approver list if he/she Exist				
			    if(strTravelType.equals("D")) {
			 	 	strSql = "SELECT  isnull(MUI.ROLE_ID,'OR') as ROLE_ID, TTDI.TRAVELLER_ID as TRAVELLER_ID FROM T_TRAVEL_DETAIL_DOM AS TTDI (NOLOCK)  INNER JOIN M_USERINFO AS MUI (NOLOCK) ON TTDI.TRAVELLER_ID = MUI.USERID "+
	 		  				  "	WHERE     (TTDI.TRAVEL_ID = "+strTravel_Id+")";
			 	} else if(strTravelType.equals("I")) {
				    strSql = "SELECT  isnull(MUI.ROLE_ID,'OR') as ROLE_ID, TTDI.TRAVELLER_ID as TRAVELLER_ID FROM T_TRAVEL_DETAIL_INT AS TTDI (NOLOCK) INNER JOIN M_USERINFO AS MUI (NOLOCK) ON TTDI.TRAVELLER_ID = MUI.USERID "+
					 		  "	WHERE     (TTDI.TRAVEL_ID = "+strTravel_Id+")";
			 	}
				rs     = dbConBean1.executeQuery(strSql);
			    while(rs.next()) {
				 	strRoleofTraveler=rs.getString("ROLE_ID");
					strIDofTraveler=rs.getString("TRAVELLER_ID");								    
			    }
			   
			    if(strRoleofTraveler.equalsIgnoreCase("OR")) {
				   strRoleofTraveler = "DEFAULT";
			    }
					
				   if(strManager == null || !strManager.equals(strIDofTraveler)) {
				 	   if(strHod==null ||  !strHod.equals(strIDofTraveler)) { 
				 		//ROLE != MATA CONDITION TO SHOW MATA AS APPROVER FOR MATA'S REQUEST
						   if(approverList.contains(strIDofTraveler) && !strRoleofTraveler.trim().equalsIgnoreCase("MATA")) {
							   	 int i=approverList.indexOf(strIDofTraveler);							     
							     approverList.remove(i);
							     approverList.remove(i);							   
						   }
				 	   }
				   }
				   
				   Iterator itr =  approverList.iterator(); 
				   while(itr.hasNext()) {
					  intCounter++;  
					  strApproverId       = (String) itr.next();
					  strApproverRole     = (String)itr.next(); 
					  strApproverOrderId  = intCounter+"";
					  objCstmt             = objCon.prepareCall("{?=call PROC_INSERT_T_APPROVERS(?,?,?,?,?,?,?,?,?,?)}"); 
					  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					  objCstmt.setString(2, strApprove_Id);            //set the Approve Id      
					  objCstmt.setString(3, strTravel_Id);             //set the Travel Id    
					  objCstmt.setString(4, strSiteId);                //set the Traveller Site Id  
					  objCstmt.setString(5, strTravellerId);           //Set the Traveller Id
					  objCstmt.setString(6, strTravelType);            //Set the TravelType 
					  objCstmt.setString(7, strApproverId);            //Set the Approver Id
					  objCstmt.setString(8, strApproveStatus);         //Set the Approve Status(0-no approve, 10-approve, 3-return, 4-rejected)
					  objCstmt.setString(9, strApproverOrderId);       //Set the Approver Order Id in which  order approver approve the requsition
					  objCstmt.setString(10, strApproverRole);         //Set the Approver Role
					  objCstmt.setString(11, Suser_id);                //Set the Login user id 
					  intSuccess7   =  objCstmt.executeUpdate();
					  objCstmt.close();
					  if(intSuccess7 == 0)
						 break;
					}
				   
				   if(strTravelType != null && strTravelType.equals("D")) {
						  stmt = 	objCon.createStatement();
						  if(strIdentityProofOld==null || strIdentityProofOld.equals("-1") || strIdentityProofOld.equals("0")) {
						        strSql = "UPDATE M_USERINFO SET  IDENTITY_ID='"+strIdentityProof+"',IDENTITY_NO='"+strIdentityProofNo+"', CONTACT_NUMBER='"+strContactNo+"',FF_NUMBER=N'"+strAirLineNo+"',FF_NUMBER1=N'"+strAirLineNo1+"',FF_NUMBER2=N'"+strAirLineNo2 +"',FF_AIR_NAME=N'"+strAirLineName+"',FF_AIR_NAME1=N'"+strAirLineName1+"',FF_AIR_NAME2=N'"+strAirLineName2+"',FF_AIR_NAME3=N'"+strAirLineName3+"',FF_AIR_NAME4=N'"+strAirLineName4+"',HOTEL_NUMBER=N'"+strHotelNo+"',HOTEL_NUMBER1=N'"+strHotelNo1+"',HOTEL_NUMBER2=N'"+strHotelNo2+"',HOTEL_NUMBER3=N'"+strHotelNo3+"',HOTEL_NUMBER4=N'"+strHotelNo4 +"',HOTEL_NAME=N'"+strHotelName+"',HOTEL_NAME1=N'"+strHotelName1+"',HOTEL_NAME2=N'"+strHotelName2+"',HOTEL_NAME3=N'"+strHotelName3+"',HOTEL_NAME4=N'"+strHotelName4+"' WHERE USERID ="+strTravellerId;
						  } else {
						  strSql = "UPDATE M_USERINFO SET  CONTACT_NUMBER='"+strContactNo+"',FF_NUMBER=N'"+strAirLineNo+"',FF_NUMBER1=N'"+strAirLineNo1+"',FF_NUMBER2=N'"+strAirLineNo2 +"',FF_AIR_NAME=N'"+strAirLineName+"',FF_AIR_NAME1=N'"+strAirLineName1+"',FF_AIR_NAME2=N'"+strAirLineName2+"',FF_AIR_NAME3=N'"+strAirLineName3+"',FF_AIR_NAME4=N'"+strAirLineName4+"',HOTEL_NUMBER=N'"+strHotelNo+"',HOTEL_NUMBER1=N'"+strHotelNo1+"',HOTEL_NUMBER2=N'"+strHotelNo2+"',HOTEL_NUMBER3=N'"+strHotelNo3+"',HOTEL_NUMBER4=N'"+strHotelNo4 +"',HOTEL_NAME=N'"+strHotelName+"',HOTEL_NAME1=N'"+strHotelName1+"',HOTEL_NAME2=N'"+strHotelName2+"',HOTEL_NAME3=N'"+strHotelName3+"',HOTEL_NAME4=N'"+strHotelName4+"' WHERE USERID ="+strTravellerId;
						  }
			
						  int iupdate = stmt.executeUpdate(strSql); 
						  
						  objCstmt   =  objCon.prepareCall("{?=call PROC_DELETE_FOREX_DETAIL_TABLES_DOM(?)}");
						  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						  objCstmt.setString(2, strTravel_Id);
						  iSuccess2   =  objCstmt.executeUpdate();
						  objCstmt.close();

						  //Procedure for update the billing info and travel cheque info in T_Travel_Detail_Dom Table
						  objCstmt  =  objCon.prepareCall("{?=call PROC_UPDATE_BILLING_INFO_DOM(?,?,?,?,?,?,?,? , ?,?,?,?,?,?,?)}");
						  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						  objCstmt.setString(2, strTravel_Id);
						  objCstmt.setString(3, strBillingSite);             
						  objCstmt.setString(4, strBillingClient);
						  objCstmt.setString(5, strTotalAmount);
						  objCstmt.setString(6, strBaseCurrency);
						  objCstmt.setString(7, strExpenditureRemarks);
						  objCstmt.setString(8, ""); 
						  objCstmt.setString(9, Suser_id);
						  objCstmt.setString(10, dbl_YTM_BUDGET);
						  objCstmt.setString(11, dbl_YTD_ACTUAL);
						  objCstmt.setString(12, dbl_AVAIL_BUDGET);
						  objCstmt.setString(13, dbl_EST_EXP);
						  objCstmt.setString(14, str_EXP_REMARKS);
						  objCstmt.setString(15, strTotalFareCurrency);
						  objCstmt.setInt(16, Integer.parseInt(strTotalFareAmount));
						  iSuccess3   =  objCstmt.executeUpdate();
						  objCstmt.close();

						  for ( int k =0; k < strEntPerDay.length ; k++ ) {						  		 
					  			  if(strEntPerDay[k]==null || strEntPerDay[k].equals(""))
					  				  strEntPerDay[k]="0";
					  			  if(strTotalTourDay[k]==null || strTotalTourDay[k].equals(""))
					  				  strTotalTourDay[k]="0";
					  			  if(strEntPerDay2[k]==null || strEntPerDay2[k].equals(""))
					  				  strEntPerDay2[k]="0";
					  			  if(strTotalTourDay2[k]==null || strTotalTourDay2[k].equals(""))
					  				  strTotalTourDay2[k]="0";
					  			  if(strContingecies[k]==null || strContingecies[k].equals(""))
					  				strContingecies[k]="0";
					  			  if(strContingecies2[k]==null || strContingecies2[k].equals(""))
					  				  strContingecies2[k]="0";
					  			  if(strTotalForex[k]==null || strTotalForex[k].equals(""))
					  				strTotalForex[k]="0";
					  			  if(strTACurrency[k]!=null)
					  				strTACurrency[k]=strTACurrency[k].trim();
					  			  if(strTotalINR[k]==null || strTotalINR[k].equals(""))
					  				  strTotalINR[k]="0";  
						  			
					  			  objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_EXPENDITURE_DOM(?,?,?,?,?,?,?,?,?,?,?)}"); //PROCEDURE to insert the row in T_TRAVEL_MST Table
					  			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					  	          objCstmt.setString(2, strTravel_Id);
					  	          objCstmt.setString(3, strTACurrency[k]);
					  	          objCstmt.setDouble(4, Double.parseDouble(strEntPerDay[k]));
					  	          objCstmt.setString(5, strTotalTourDay[k]); 
					  	          objCstmt.setDouble(6, Double.parseDouble(strEntPerDay2[k]));
					  			  objCstmt.setString(7, strTotalTourDay2[k]);
					  			  objCstmt.setDouble(8, Double.parseDouble(strContingecies[k]));
					  			  objCstmt.setDouble(9, Double.parseDouble(strContingecies2[k]));
					  		      objCstmt.setDouble(10, Double.parseDouble(strTotalForex[k]));
					  			  objCstmt.setString(11, Suser_id); 
					  			  objCstmt.setString(12, "0"); 			  
					  			  if(strHiddenValue[k].equals("v") && Double.parseDouble(strTotalINR[k])>0) {
					  				  iSuccess4   =  objCstmt.executeUpdate();
					  			  }
					  			  objCstmt.close();
						  	}
						  
						    if(strmataprice.equalsIgnoreCase("y")) {								
						    	if(strTkAgent.equalsIgnoreCase("n")) { 
									objCstmt=objCon.prepareCall("{?=call PROC_UPDATE_TRAVEL_TICKET_DETAIL(?,?,?,?,?,?,?,?)}");
									objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
									objCstmt.setString(2,strTravel_Id);
									objCstmt.setString(3,strTravelType);
									objCstmt.setString(4,strTkAgent);
									objCstmt.setString(5,strTkAirLine);
									objCstmt.setString(6,strTkcurrency);
									objCstmt.setString(7,strTklocalprice);
									objCstmt.setString(8,strTkRemarks);
									objCstmt.setString(9,Suser_id);
								    objCstmt.executeUpdate();
							        objCstmt.close();						        
								} else { 					
									objCstmt=objCon.prepareCall("{?=call PROC_UPDATE_TRAVEL_TICKET_DETAIL(?,?,?,?,?,?,?,?)}");
									objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
									objCstmt.setString(2,strTravel_Id);
									objCstmt.setString(3,strTravelType);
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
						    
						    objCstmt = objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_STATUS_DOM(?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST Table
						    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						    objCstmt.setString(2, strTravel_Id);
						    objCstmt.setString(3, strTravel_Req_Id);
						    objCstmt.setString(4, strTravelStatusId);
						    objCstmt.setString(5, strTravelType);
						    objCstmt.setString(6, strTravel_Req_No);
						    objCstmt.setString(7, strCancelledReqId);
						   
				           try {
						   	  iSuccess5   =  objCstmt.executeUpdate();
						    } catch(Exception e) {
							   System.out.println("PROC_UPDATE_T_TRAVEL_STATUS_DOM[Update Temp Travel Request]---"+e);
						    }
						    objCstmt.close();
						    
					 } else if(strTravelType != null && strTravelType.equals("I")) {
							objCstmt =  objCon.prepareCall("{?=call PROC_TRANSFER_PASSPORTUSERINFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,     ?,?,?,?,?,?,?)}");
							objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setString(2,strTravellerId.trim());
							objCstmt.setString(3, strPassportNo.trim());
							objCstmt.setString(4, strPassportIssuePlace.trim());
							objCstmt.setString(5, strPassportIssueDate.trim());
							objCstmt.setString(6, strPassportExpireDate.trim());
							objCstmt.setString(7, radioEcnr);
							objCstmt.setString(8, strDOB.trim());
							objCstmt.setString(9, strContactNo.trim());
							objCstmt.setString(10, strPermanentAddress.trim());
							objCstmt.setString(11, strAirLineNo.trim());
							objCstmt.setString(12, strAirLineNo1.trim());
							objCstmt.setString(13, strAirLineNo2.trim());
							objCstmt.setString(14, strCurrentAddress.trim());
							objCstmt.setString(15, strAirLineName.trim());
							objCstmt.setString(16, strAirLineName1.trim());
							objCstmt.setString(17, strAirLineName2.trim());
							objCstmt.setString(18, strAirLineNo3.trim());
							objCstmt.setString(19, strAirLineNo4.trim());
							objCstmt.setString(20, strAirLineName3.trim());
							objCstmt.setString(21, strAirLineName4.trim());
							objCstmt.setString(22, strHotelNo.trim());
							objCstmt.setString(23, strHotelNo1.trim());
							objCstmt.setString(24, strHotelNo2.trim());
							objCstmt.setString(25, strHotelNo3.trim());
							objCstmt.setString(26, strHotelNo4.trim());
							objCstmt.setString(27, strHotelName.trim());
							objCstmt.setString(28, strHotelName1.trim());
							objCstmt.setString(29, strHotelName2.trim());
							objCstmt.setString(30, strHotelName3.trim());
							objCstmt.setString(31, strHotelName4.trim());
							objCstmt.setString(32, fullName.trim());
							objCstmt.setString(33, firstName.trim());
							objCstmt.setString(34, lastName.trim());
							objCstmt.setString(35, strNationality.trim());
							objCstmt.execute();
							objCstmt.close();							
							
							objCstmt = objCon.prepareCall("{?=call PROC_DELETE_FOREX_DETAIL_TABLES(?)}");//PROCEDURE to insert the row in T_TRAVEL_MST Table
					        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					        objCstmt.setString(2, strTravel_Id);
					        iSuccess2 = objCstmt.executeUpdate();
					        objCstmt.close();					        
					        
							//Procedure for update the billing info and travel cheque info in T_Travel_Detail_Int Table
							objCstmt = objCon.prepareCall("{?=call PROC_UPDATE_BILLING_INFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST  Table
					        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					        objCstmt.setString(2, strTravel_Id);
					        objCstmt.setString(3, strBillingSite);             
					        objCstmt.setString(4, strBillingClient);
					        objCstmt.setString(5, strTotalAmount);
							objCstmt.setString(6, strBaseCurrency);							
							objCstmt.setString(7, strTravellerCheque);
							objCstmt.setString(8, strTravellerCheque1);
							objCstmt.setString(9, strTravellerCheque2);					
							objCstmt.setString(10, strTCCurrency);
							objCstmt.setString(11, strTCCurrency1);
							objCstmt.setString(12, strTCCurrency2);					
							objCstmt.setString(13, strExpenditureRemarks);
							objCstmt.setString(14, strCashBreakupRemarks);					
							objCstmt.setString(15, "");					
							objCstmt.setString(16, Suser_id);		
							objCstmt.setString(17, dbl_YTM_BUDGET);
							objCstmt.setString(18, dbl_YTD_ACTUAL);
							objCstmt.setString(19, dbl_AVAIL_BUDGET);
							objCstmt.setString(20, dbl_EST_EXP);
							objCstmt.setString(21, str_EXP_REMARKS);
							objCstmt.setString(22, strTotalFareCurrency);
							objCstmt.setInt(23, Integer.parseInt(strTotalFareAmount));							
					        iSuccess3   =  objCstmt.executeUpdate();
					        objCstmt.close();
					
							for(int i=0; i<strEntPerDay.length; i++) {								
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
					  
						          objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_EXPENDITURE_INT(?,?,?,?,?,?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST Table        
						          objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						          objCstmt.setString(2, strTravel_Id);
						          objCstmt.setString(3, strTACurrency[i]);
						          objCstmt.setDouble(4, Double.parseDouble(strEntPerDay[i]));
						          objCstmt.setString(5, strTotalTourDay[i]);
						          objCstmt.setDouble(6, Double.parseDouble(strEntPerDay2[i]));
								  objCstmt.setString(7, strTotalTourDay2[i]);
								  objCstmt.setDouble(8, Double.parseDouble(strContingecies[i]));
								  objCstmt.setDouble(9, Double.parseDouble(strContingecies2[i]));
							      objCstmt.setDouble(10, Double.parseDouble(strTotalForex[i]));
								  objCstmt.setString(11, Suser_id); 
								  objCstmt.setString(12, "0"); 
								  if(strHiddenValue[i].equals("v") && Double.parseDouble(strTotalINR[i])>0) {
									  iSuccess4 =  objCstmt.executeUpdate();
								  }							  
						          objCstmt.close();
							   }
							
							if(strmataprice.equalsIgnoreCase("y")) {																
						    	if(strTkAgent.equalsIgnoreCase("n")) { 
									objCstmt=objCon.prepareCall("{?=call PROC_UPDATE_TRAVEL_TICKET_DETAIL(?,?,?,?,?,?,?,?)}");
									objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
									objCstmt.setString(2,strTravel_Id);
									objCstmt.setString(3,strTravelType);
									objCstmt.setString(4,strTkAgent);
									objCstmt.setString(5,strTkAirLine);
									objCstmt.setString(6,strTkcurrency);
									objCstmt.setString(7,strTklocalprice);
									objCstmt.setString(8,strTkRemarks);
									objCstmt.setString(9,Suser_id);
								    objCstmt.executeUpdate();
							        objCstmt.close();						        
								} else { 					
									objCstmt=objCon.prepareCall("{?=call PROC_UPDATE_TRAVEL_TICKET_DETAIL(?,?,?,?,?,?,?,?)}");
									objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
									objCstmt.setString(2,strTravel_Id);
									objCstmt.setString(3,strTravelType);
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
							
							   objCstmt =  objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_STATUS(?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST Table
					           objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					           objCstmt.setString(2, strTravel_Id);
					           objCstmt.setString(3, strTravel_Req_Id);
					           objCstmt.setString(4, strTravelStatusId);                        //SET THE  TRAVEL_STATUS_ID 2 AS A PERMANENT REQUEST FOR THE WORKFLOW
							   objCstmt.setString(5, strTravelType);
							   objCstmt.setString(6, strTravel_Req_No);
							   objCstmt.setString(7, strCancelledReqId);
							   try {
							   	  iSuccess5   =  objCstmt.executeUpdate();
							    } catch(Exception e) {
								   System.out.println("PROC_UPDATE_T_TRAVEL_STATUS[Update Temp Travel Request]---"+e);
							    }					           
					           objCstmt.close();
					}	    	
					strMessage = dbLabelBean.getLabel("message.global.save",strsesLanguage);
					submitToWorkFlow = true;
			}  else	{
				objCon.rollback();
				strTravel_Id = null;
				strMessage = dbLabelBean.getLabel("message.global.notsave",strsesLanguage);
			}	    	
	    } catch(Exception e) {			  
			  System.out.println("Error in Updation block of T_QuickTravel_Detail_Post.jsp=="+e);
			  strMessage = dbLabelBean.getLabel("message.global.notsave",strsesLanguage);			  
		}	
	}
	 
	 
	 if(submitToWorkFlow && strWhatAction != null && strWhatAction.equals("saveProceed")) {
		 logger.info("T_QuickTravel_Detail_Post.jsp Submit To WorkFlow Start for Request number--> " +strTravel_Id+ " at " +dateFormat.format(cal.getTime()));	
		 if(strTravelType != null && strTravelType.equals("D")) {			 
			 try {
				 if(flag!="no") {
					    int intTravelId =Integer.parseInt(strTravel_Id);
			            int intBillingClient =Integer.parseInt(strBillingClient);
			            int intTravellerId =Integer.parseInt(strTravellerId);
						int intC_userID =Integer.parseInt(Suser_id);						  
							
						objCon =  dbConBean.getConnection(); 
						objCstmt=objCon.prepareCall("{?=call PROC_APPROVER_OF_OTHERSITE(?,?,?,?,?)}");
						objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setInt(2,intTravelId);
						objCstmt.setString(3,strTravelType);
						objCstmt.setInt(4,intBillingClient);
						objCstmt.setInt(5,intTravellerId);
						objCstmt.setInt(6,intC_userID); 
					    objCstmt.executeUpdate();
				        objCstmt.close();
	           }	
	
		  		strPermanent_Req_No = strSiteName.trim()+"/DOM/"+strTravel_Id;	
		  		session.setAttribute("strSetFlage","1"); 
		  			   
			    objCstmt = objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_STATUS_DOM(?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST Table
			    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			    objCstmt.setString(2, strTravel_Id);
			    objCstmt.setString(3, strTravel_Req_Id);
			    objCstmt.setString(4, "2");                        //SET THE  TRAVEL_STATUS_ID 2 AS A PERMANENT REQUEST FOR THE WORKFLOW
			    objCstmt.setString(5, strTravelType);
			    objCstmt.setString(6, strPermanent_Req_No);
			    objCstmt.setString(7, strCancelledReqId);
			   
	           try {
			   	  iSuccess5   =  objCstmt.executeUpdate();
			    } catch(Exception e) {
				   System.out.println("PROC_UPDATE_T_TRAVEL_STATUS_DOM---"+e);
			    }
			    objCstmt.close();
			
			    if(strTravel_Id_Intrim != null && !"".equals(strTravel_Id_Intrim.trim()) && !strTravel_Id_Intrim.trim().equals("null")) {
			       //Procedure for delete the all temp detail from T_INTRIM_JOURNEY temp Table
				   objCstmt = objCon.prepareCall("{?=call PROC_DELETE_INTERIM_JOURNEY(?,?)}");
				   objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				   objCstmt.setString(2, strTravel_Id_Intrim);
				   objCstmt.setString(3, strTravelType);
				   iSuccess6 = objCstmt.executeUpdate();
				   objCstmt.close();
			    }		  	
		  		 
			      // Procedure for inserting the version for T_TRAVEL_DETAIL_DOM, T_JOURNEY_DETAIL_DOM, T_RET_JOURNEY_DETAIL_DOM in the audit table  
				  objCstmt = objCon.prepareCall("{?=call PROC_INSERT_IN_ALL_AUDIT_DOM(?,?)}");
				  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				  objCstmt.setString(2, strTravel_Req_Id);
				  objCstmt.setString(3, strTravel_Id);
				
				  try {
				 	  iSuccess7   =  objCstmt.executeUpdate();
				  } catch(Exception e) {
					 System.out.println("PROC_INSERT_IN_ALL_AUDIT_DOM---"+e);
				  }						  		
				  objCstmt.close();
				  
				  strMessage = dbLabelBean.getLabel("message.global.save",strsesLanguage);
				  
			 } catch(Exception e) {				  
				  System.out.println("Error in Save Proceed (DOM) block of T_QuickTravel_Detail_Post.jsp=="+e);
				  strMessage = dbLabelBean.getLabel("message.global.notsave",strsesLanguage);			  
			}	
		 } else if(strTravelType != null && strTravelType.equals("I")) {			 
			 try {
				 	objCstmt = objCon.prepareCall("{?=call PROC_TRANSFER_USERINFO_TO_AUDIT_USERINFO(?)}");
					objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					objCstmt.setString(2,strTravellerId.trim());
					objCstmt.execute();
					objCstmt.close();
					
				 if(flag!="no") {
					 int intTravelId =Integer.parseInt(strTravel_Id);
		             int intBillingClient =Integer.parseInt(strBillingClient);
		             int intTravellerId =Integer.parseInt(strTravellerId);
					 int intC_userid= Integer.parseInt(Suser_id);				 
						
					objCon = dbConBean.getConnection(); 
					objCstmt=objCon.prepareCall("{?=call PROC_APPROVER_OF_OTHERSITE(?,?,?,?,?)}");
					objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					objCstmt.setInt(2,intTravelId);
					objCstmt.setString(3,strTravelType);
					objCstmt.setInt(4,intBillingClient);
					objCstmt.setInt(5,intTravellerId);
					objCstmt.setInt(6,intC_userid);
				    objCstmt.executeUpdate();
			        objCstmt.close();
	             }
	
				   strPermanent_Req_No = strSiteName.trim()+"/INT/"+strTravel_Id;				   
				   session.setAttribute("strSetFlage","1");					            
				    
		           objCstmt =  objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_STATUS(?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST Table
		           objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		           objCstmt.setString(2, strTravel_Id);
		           objCstmt.setString(3, strTravel_Req_Id);
		           objCstmt.setString(4, "2");                        //SET THE  TRAVEL_STATUS_ID 2 AS A PERMANENT REQUEST FOR THE WORKFLOW
				   objCstmt.setString(5, strTravelType);
				   objCstmt.setString(6, strPermanent_Req_No);
				   objCstmt.setString(7, strCancelledReqId);
				   
				   try {
				   	  iSuccess5   =  objCstmt.executeUpdate();
				    } catch(Exception e) {
					   System.out.println("PROC_UPDATE_T_TRAVEL_STATUS---"+e);
				    }					           
		           objCstmt.close();
		
				   if(strTravel_Id_Intrim!= null && !"".equals(strTravel_Id_Intrim)  && !strTravel_Id_Intrim.trim().equals("null")) {
					   //Procedure for delete the all temp detail from T_INTRIM_JOURNEY temp Table
					   objCstmt =  objCon.prepareCall("{?=call PROC_DELETE_INTERIM_JOURNEY(?,?)}");
					   objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					   objCstmt.setString(2, strTravel_Id_Intrim);
					   objCstmt.setString(3, strTravelType);
					   iSuccess6 = objCstmt.executeUpdate();
					   objCstmt.close();
				   }
		
					// Procedure for inserting the version for T_TRAVEL_DETAIL_INT, T_JOURNEY_DETAIL_INT, T_RET_JOURNEY_DETAIL_INT in the audit table  
		            objCstmt =  objCon.prepareCall("{?=call PROC_INSERT_IN_ALL_AUDIT_INT(?,?)}");
		 		    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					objCstmt.setString(2, strTravel_Req_Id);
					objCstmt.setString(3, strTravel_Id);
					try {
					 	 iSuccess7   =  objCstmt.executeUpdate();
				     } catch(Exception e) {
					 System.out.println("PROC_INSERT_IN_ALL_AUDIT_INT---"+e);
				     }		
					objCstmt.close();
					
					strMessage = dbLabelBean.getLabel("message.global.save",strsesLanguage);
					
			 } catch(Exception e) {				  
				  System.out.println("Error in Save Proceed (INT) block of T_QuickTravel_Detail_Post.jsp=="+e);
				  strMessage = dbLabelBean.getLabel("message.global.notsave",strsesLanguage);			  
			}	
		 }
		 logger.info("T_QuickTravel_Detail_Post.jsp Submit To WorkFlow End for Request number--> " +strTravel_Id+ " at " +dateFormat.format(cal.getTime()));  
	 }
	 dbConBean3.close();
	 dbConBean2.close();
	 dbConBean1.close();
	 dbConBean.close(); 	
	
	if(strMessage!=null && strMessage.equals(dbLabelBean.getLabel("message.global.save",strsesLanguage))) {	
		if(strWhatAction != null && strWhatAction.equals("save")) {
		  url = "T_QuickTravel_Detail.jsp?message="+strMessage+"&travelId="+strTravel_Id+"&travelReqId="+strTravel_Req_Id+"&travellerId="+strTravellerId+"&travellerSiteId="+strTravllerSiteId+"&travelReqNo="+strTravel_Req_No+"&interimId="+strTravel_Id_Intrim+"&travel_type="+strTravelType;
		} 
		else if(strWhatAction != null && strWhatAction.equals("saveExit")) {
			if(strTravelType != null && strTravelType.equals("D")) {
				url = "T_TravelRequisitionList_D.jsp?travel_type=DOM";
			} else if(strTravelType != null && strTravelType.equals("I")) {
				url = "T_TravelRequisitionList.jsp?travel_type=INT";
			}
		}
		else if(strWhatAction != null && strWhatAction.equals("saveProceed")) {
			if(iSuccess5 > 0) {
				String	strReq	=	"";
				if(strTravelType.equalsIgnoreCase("I")) {
					strReq	=	"International Travel";
				} else {
					strReq	=	"Domestic Travel";
				}
				mailDaoImpl.sendRequisitionMailOnOriginating(strTravel_Id, strReq, Suser_id, strsesLanguage, strCurrentYear);
				
				url = "FinallySubmitted.jsp?travelId="+strTravel_Id+"&travelReqId="+strTravel_Req_Id+"&travellerId="+strTravellerId+"&travellerSiteId="+strTravllerSiteId+"&travelReqNo="+strPermanent_Req_No+"&ReqTyp="+strTravelType+"&interimId="+strTravel_Id_Intrim+"&flag="+strSetFlage; 
			}
		}
	} else {	
		url = "T_QuickTravel_Detail.jsp?message="+strMessage;
	}	
	logger.info("T_QuickTravel_Detail_Post.jsp sendRedirect to -->" +url+ " at " +dateFormat.format(cal.getTime()));
	response.sendRedirect(url);
 }
%>