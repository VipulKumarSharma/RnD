<!DOCTYPE html>
<%@ include  file="application.jsp" %>
<%@ page import = "java.sql.*" pageEncoding="UTF-8"%>

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
<title>Quick Travel Request</title>

<link href="style/quick-travel-style.css?buildstamp=2_0_0" rel="stylesheet" media="all" type="text/css"/>
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

<script type="text/javascript">
	var checkTourDaysFlag = false;
	// initialize airport name from database 
	function initializeAirPortName(elId) {
		var timer;
   		var typingTimer;              
   	   	var doneTypingInterval = 200; 
   	   	
   	   	$(elId).keyup(function() { 
   	   		if (timer) { 
   	   			timer.abort();
   	   		} 
   	   	    clearTimeout(typingTimer);
   	   	    if ($(elId).val) {
   	   	        typingTimer = setTimeout(function() {
   	   	        	timer = doneTyping(elId);	
   	   	        }, doneTypingInterval);
   	   	    }
   	   	});	   	
	}
   	
   	function doneTyping(elId) {
   	   	$(elId).autocomplete({
   	   		delay: 500,
			source : function(request, response) {
            	airPortName = "";            	
	            $.ajax({
	            	 type: "get",
					 url: "AutoCompleteServlet",
					 data: { term: $(elId).val(), airPortName: $(elId).val(), tempFlag:  "airMode", field: "tempFlag"},
	                 dataType: "json",
	                    success : function(data) {response(data);}
	            	});
		    	}
			});
   	   	}
   	
   	// set date 
   	function initializeDate(elId) {
		$(elId).datepick({
		    dateFormat: 'dd/mm/yyyy',
		    changeMonth: true,
		    changeYear: true,
		    yearRange: "-100:+30", // magic!
		    onSelect: function(dateText, inst) { $(this).css('color', '#000000'); }
		}).click(function () { $(elId).focus(); });	
	}
   	
 	function initializeJourneyDate(elId) {
		$(elId).datepick({
		    dateFormat: 'dd/mm/yyyy',
		    changeMonth: true,
		    changeYear: true,
		    yearRange: "-100:+30", // magic!
		    onSelect: function(dateText, inst) { $(this).css('color', '#000000'); },
		    onClose: function(dateText, inst) {
		    checkTourDays();
		    }
		}).click(function () { $(elId).focus(); });			
	}
 	
 	function checkTourDays() {
 		    var tDaysFlag = false;
 			var tblRowCount = $('#tblItinerary tbody tr.itineraryDataRow').length;
 			if(tblRowCount > 1) {
 				var nDays = 0;
 	 			var tDays1 = 0;
 	 			var tDays2 = 0; 	 			
 				var tourDays1 = document.getElementById("frmId").elements.namedItem("tourDays"); 
 	 			var tourDays2 = document.getElementById("frmId").elements.namedItem("tourDays2");
 	 			var totalForex = document.getElementById("frmId").elements.namedItem("totalForex");
 	 			var totalInr = document.getElementById("frmId").elements.namedItem("totalInr");
 	 			var grandTotalForex = document.getElementById("grandTotalForexinr");
 	 			var grandTotalForexUSD = document.getElementById("grandtotalforexusd");
 	 			
 	 			var depDateVal = "";
 	 			var retDateVal = "";
 	 			depDateVal = $("#tblItinerary tbody tr.itineraryDataRow:first").find("td.date").find("input").val(); 
 	 			var depDateCheck = '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>';
 	 			
 	 			var tblRowCount = $('#tblItinerary tbody tr.itineraryDataRow').length;
 	 			
 	 			if(tblRowCount == 2) {		 
 	 				retDateVal = $("#tblItinerary tbody tr.itineraryDataRow:last").find("td.date").find("input").val(); 				
 	 			} else if(tblRowCount > 2) {
 	 				$('table#tblItinerary tbody > tr.itineraryDataRow').not(':first').each(function() { 					
 	 					var depDt = $(this).find('#depDateTB').val(); 					
 	 					if(depDt != '' && depDt != '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
 	 						retDateVal = depDt;
 	 					} 
 	 				});			
 	 			}	 			
 	 			
 	 			if((depDateVal != "" && depDateVal != null  && depDateVal != depDateCheck) && 
 	 					(retDateVal != "" && retDateVal != null  && retDateVal != depDateCheck)) {
 	 				nDays = diffDays(depDateVal, retDateVal);
 	 				for (var i = 0, len = tourDays1.length; i < len; i++) {
 	 	 				tDays1 = tourDays1[i].value;
 	 	 				tDays2 = tourDays2[i].value;
 	 	 				if(nDays >= 0 && (tDays1 > nDays || tDays2 > nDays)) { 	 					
 	 	 					tourDays1[i].value = "0";
 	 	 					tourDays2[i].value = "0";
 	 	 					totalForex[i].value = "0.00";
 	 	 					totalInr[i].value = "0.00";
 	 	 					grandTotalForex.value = "0.00";
 	 	 					grandTotalForexUSD.value = "0.00";
 	 	 					tDaysFlag = true;
 	 	 				} 
 	 	 			}
 	 	 			
 	 			}  else {
 	 				 $("input[name='tourDays']").val("0");
 	 				 $("input[name='tourDays2']").val("0");
 	 				 $("input[name='totalForex']").val("0.00");
 	 				 $("input[name='totalInr']").val("0.00");
 	 				 $("input[name='grandTotalForex']").val("0.00");
 	 				 $("input[name='grandTotalForexUSD']").val("0.00");
 	 			}	 			
 			}
 			
 			if(tDaysFlag) {
 				 alert('<%=dbLabelBean.getLabel("alert.global.numberoftourdayscannotbemorethanjourneydays",strsesLanguage)%>');
 			}
 		}
 	
 	function openWaitingProcess() {
		var dv = document.getElementById("waitingData");
		if(dv != null) {
			
			var xpos = screen.width * 0.475;
			var ypos = screen.height * 0.30;   
			
			dv.style.position="absolute";       		
			dv.style.left=(xpos)+"px";
			dv.style.top=(ypos)+"px";
			
			document.getElementById("waitingData").style.display="block";	
		}
	}
	
	function closeDivRequest() {
		document.getElementById("waitingData").style.display="none";
	}
</script>

<%
//Global Variables declared and initialized
request.setCharacterEncoding("UTF-8");
String strSql, strSql2          		=  null;              // String for Sql String
ResultSet rs,rs1,rs2,rs3,rs4,rs5  		=  null;              // Object for ResultSet
String strSiteId                		=  "";
String strUserId                		=  "";
String strMealId						=  "";
String strSex                   		=  "";
		
String strDepCityFwd            		=  "";                              
String strArrCityFwd            		=  ""; 
String strDepDateFwd            		=  ""; 
String strTravelModeFwd         		=  "1"; 
String strTravelClassFwd        		=  ""; 
String strPreferTimeFwd           		=  "";
String strNameOfAirlineFwd		        =  "";
String strPreferSeatFwd					=  "";

String strDepCityRet            		=  "";
String strArrCityRet            		=  ""; 
String strDepDateRet            		=  "";
String strTravelModeRet         		=  "1"; 
String strTravelClassRet        		=  "";
String strPreferTimeRet           		=  "";
String strNameOfAirlineRet		        =  "";
String strPreferSeatRet					=  "";	

String strDepCityIntrmi         		=  "";
String strArrCityIntrmi         		=  ""; 
String strDepDateIntrmi         		=  "";
String strTravelModeIntrmi      		=  "1"; 
String strTravelClassIntrmi     		=  "";
String strPreferTimeIntrmi         		=  "";
String strNameOfAirlineIntrmi	        =  "";
String strPreferSeatIntrmi				=  "";

String strManager              	 		=  ""; 
String strHod                   		=  ""; 
String strBoardMember           		=  "";

String strReasonForTravel       		=  "";
String strReasonForSkip         		=  "";	
String strCostCentre					=  "0";
String strBillingSite 					=  "";
String strBillingClient 				=  "";
String strHidAppFlag					=  "";
String strHidAppShowBMFlag				=  "";
String strInterimId             		=  "";  

String strVisaRequired          		=  "";
String strVisaComment           		=  "";
String strInsuranceRequired     		=  "";
String strNominee               		=  ""; 
String strRelation              		=  ""; 
String strInsuranceComment      		=  "";

String strHotelRequired         		=  "";
String strBudgetCurrency        		=  "";
String strHotelBudget           		=  "";
String strPlace                 		=  "";
String strCheckin						=  "";
String strCheckout    					=  "";
String strRemarks               		=  "";

String strIdentityProof         		=  "";
String strIdentityProofNo       		=  "";

String strTravelReqId           		=  "";
String strTravelId						=  "";
String strTravelReqNo           		=  "";
String strIntermiId             		=  "";
String strCancelledReqId				=  "0";

String strTravllerSiteId 				=  "";
String strTravellerId 					=  "";	
String strTravelType            		=  "";	
String strReturnType            		=  "";

String msgFlag							=  "";
String strMessage  						= "false"; 
String strAppLvl3flg 					=  "";
String strAppLvl3flgforBM 				=  "";
String strMandatatoryApvFlag 			=  "";
String strShowflag						=  "n";
String strShowCancelledRegflag			=  "n";

String strforPriceDesicionDom 			=  "";
String strforPriceDesicionInt 			=  "";
String strSHOW_BUD_INPUT 				=  "N";

String strTotalAmount           		=  "";
String strExpenditureRemarks   			=  "";
String strCashBreakupRemarks    		=  "";

String strTotalFareCurrency				=  "";
String strTotalFareAmount				=  "";

//Fields for T_Travel_Expenditure_Int Table 
String strExpID                 		=  "";
String strTACurrency            		=  "";
String strTACurrency2           		=  "USD";
String strEntPerDay             		=  "";
String strTotalTourDay          		=  "";
String strEntPerDay2            		=  "";
String strTotalTourDay2         		=  "";
String strContingecies          		=  "";
String strContingecies2         		=  "";
String strTotalForex            		=  "";
String strExRate        	    		=  "";
String strTotalINR        	    		=  "";

String strTravellerCheque       		=  "";
String strTravellerCheque1      		=  "";
String strTravellerCheque2      		=  "";

String strTCCurrency            		=  "";
String strTCCurrency1           		=  "";
String strTCCurrency2           		=  "";

String dbl_YTM_BUDGET           		=  "";
String dbl_YTD_ACTUAL           		=  "";
String dbl_AVAIL_BUDGET         		=  "";
String dbl_EST_EXP              		=  "";
String str_EXP_REMARKS          		=  "";

String strCashAmount1           		=  "";
String strCashAmount2           		=  "";
String strCashAmount3           		=  "";
String strCashAmount4           		=  "";

String strCashCurrency1         		=  "";
String strCashCurrency2         		=  "";
String strCashCurrency3         		=  "";
String strCashCurrency4         		=  "";

String strLAprice               		=  "";
String strLAAirLine             		=  "";
String strLACurrency            		=  "";
String strLAPrice               		=  "";
String strLARemarks             		=  "";
  
String strTkAgent 		        		=  ""; 
String strTkAirLine 	        		=  ""; 
String strTkcurrency 	        		=  ""; 
String strTklocalprice 	        		=  ""; 
String strTkRemarks 	        		=  ""; 

String strFlag 							=  "";
String strRec							=  "no";

strSiteId                       		=  strSiteIdSS;  
strUserId                       		=  Suser_id;
strMessage                      		=  request.getParameter("message");

strTravelId                     		=  request.getParameter("travelId");       // for hidden field
strTravelReqNo                  		=  request.getParameter("travelReqNo");    // for hidden field
strTravelReqId							=  request.getParameter("travelReqId");
strTravellerId							=  request.getParameter("travellerId");
strTravelType 							=  request.getParameter("travel_type");
strIntermiId							=  request.getParameter("interimId")== null ? "" : request.getParameter("interimId");
	
Date currentDate = new Date();
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
String strCurrentDate = (sdf.format(currentDate)).trim();

if(strMessage != null && strMessage.equals("save")) {
	msgFlag	 = "true";
    strMessage = dbLabelBean.getLabel("message.global.savedsuccessfully",strsesLanguage);
} else if(strMessage != null && strMessage.equals("not Save")) {
	msgFlag	 = "true";
    strMessage = dbLabelBean.getLabel("message.global.couldnotsave",strsesLanguage);
} else {
	msgFlag	 = "false";
    strMessage = ""; 
}
	
strSql="SELECT SHOW_APP_LVL_3 FROM M_DIVISION MD INNER JOIN	M_USERINFO MU ON MU.DIV_ID=MD.DIV_ID WHERE USERID="+Suser_id;
rs =   dbConBean.executeQuery(strSql);  
	if(rs.next()) {
		strAppLvl3flg=rs.getString("SHOW_APP_LVL_3");
	}
rs.close();

rs=null;
String strUnit_Head="0";
strSql="SELECT A.UNIT_HEAD FROM USER_MULTIPLE_ACCESS AS A INNER JOIN M_USERINFO AS B ON A.USERID = B.USERID WHERE (A.STATUS_ID = 10) AND (B.STATUS_ID = 10) AND (A.UNIT_HEAD = 1) AND A.USERID = "+strUserId+" AND A.SITE_ID = "+strSiteId+" ";
rs = dbConBean.executeQuery(strSql); 
if (rs.next()) {
	strUnit_Head = rs.getString("UNIT_HEAD");	
}
rs.close();

rs=null;
strSql =   "SELECT 1 FROM M_COST_CENTRE WHERE SITE_ID="+strSiteId+" AND M_COST_CENTRE.STATUS_ID=10";
rs     =   dbConBean.executeQuery(strSql);
if(rs.next()) {
	strShowflag="y";
}
rs.close();

rs=null;
strSql="SELECT SHOW_APP_LVL_3,MANDATORY_APP_FLAG FROM dbo.M_SITE ms WHERE ms.STATUS_ID=10 and ms.SITE_ID="+strSiteId;
rs       =   dbConBean.executeQuery(strSql);  
if(rs.next()) {
	strAppLvl3flgforBM=rs.getString("SHOW_APP_LVL_3");
	strMandatatoryApvFlag=rs.getString("MANDATORY_APP_FLAG");
}
rs.close();

rs=null;
strSql = "SELECT SHOW_BUD_INPUT FROM M_SITE WHERE site_id = "+strSiteId+"";
rs = dbConBean.executeQuery(strSql);
while (rs.next()) {
	strSHOW_BUD_INPUT = rs.getString("SHOW_BUD_INPUT");
}
rs.close();

rs=null;
strSql = "Select isnull(DOM_LOCAL_AGENT,'') as DOM_LOCAL_AGENT From m_site where site_id="+ strSiteId + " and status_id=10";
rs = dbConBean.executeQuery(strSql);
while (rs.next()) {	
	strforPriceDesicionDom = rs.getString("DOM_LOCAL_AGENT");
}
rs.close();

rs=null;
strSql = "Select isnull(INT_LOCAL_AGENT,'') as INT_LOCAL_AGENT From m_site where site_id="+ strSiteId + " and status_id=10";
rs = dbConBean.executeQuery(strSql);
while (rs.next()) {	
	strforPriceDesicionInt = rs.getString("INT_LOCAL_AGENT");
}
rs.close();

rs=null;
String strBaseCur="INR";
strSql = "SELECT ISNULL(CURRENCY,'') AS BASE_CUR FROM dbo.M_SITE ms WHERE ms.STATUS_ID=10 AND ms.SITE_ID="+strSiteId;
rs = dbConBean.executeQuery(strSql);
if(rs.next()) {
	strBaseCur = rs.getString("BASE_CUR");
}
rs.close();

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new Date());
String strExchRate="0.000000";
if(strBaseCur!=null && !strBaseCur.equals("")) {
	strSql="SELECT ISNULL(DBO.FN_GET_EXCHANGE_RATE ('"+strBaseCur+"','"+formattedDate+"'),'') AS EXCHANGE_RATE";
	rs = dbConBean.executeQuery(strSql);
	if(rs.next()) {
		strExchRate=rs.getString("EXCHANGE_RATE");
	}
	rs.close();
}

String strApproverid = "";
String ApproverText = "";
String strname1 = "";
String strname2 = "";

strSql = "select top 1 approver_id  from T_approvers  where travel_id ="
		+ strTravelId
		+ " and travel_type='i' and status_id=10 order by order_id ";

rs = dbConBean.executeQuery(strSql);
while (rs.next()) {
	strApproverid = rs.getString(1);

	strSql = "select dbo.user_name(" + strApproverid
			+ "),dbo.user_name(dbo.finalooo(" + strApproverid
			+ ",getdate(),'i'))";

	rs5 = dbConBean1.executeQuery(strSql);

	while (rs5.next()) {

		strname2 = rs5.getString(1);
		strname1 = rs5.getString(2).trim();
		if (!strname1.equals("-")) {
			ApproverText = ApproverText + strname2
					+ " "+dbLabelBean.getLabel("alert.createrequest.hasdelegatedhisauthorityto",strsesLanguage)+" " 
					+ strname1 + ".\n ";
		}
	}
	rs5.close();
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
		strSql = "SELECT LTRIM(RTRIM(TD.SITE_ID)) AS SITE_ID,LTRIM(RTRIM(TD.TRAVEL_REQ_ID)) as TRAVEL_REQ_ID,LTRIM(RTRIM(TD.TRAVELLER_ID)) AS TRAVELLER_ID, LTRIM(RTRIM(TD.MEAL)) AS MEAL, MANAGER_ID, HOD_ID, ISNULL(.DBO.CONVERTDATEDMY1(TD.TRAVEL_DATE),'') AS TRAVEL_DATE,LTRIM(RTRIM(TD.TRANSIT_TYPE)) AS TRANSITTYPE,  ISNULL(TD.TRANSIT_BUDGET,'') AS BUDGET,LTRIM(RTRIM(BUDGET_CURRENCY)) AS BUDGET_CURRENCY,TD.PLACE AS PLACE,  ISNULL(.DBO.CONVERTDATEDMY1(TD.CHECK_IN_DATE),'') AS CHECKINDATE,ISNULL(.DBO.CONVERTDATEDMY1(TD.CHECK_OUT_DATE),'') AS CHECKOUTDATE,LTRIM(RTRIM(TD.REMARKS)) AS REMARKS,ISNULL(TD.REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL,ISNULL(TD.REASON_FOR_SKIP,'') AS REASON_FOR_SKIP, TD.BOARD_MEMBER_ID,TD.CC_ID, ISNULL(TD.IDENTITY_PROOFNO,'') AS IDENTITY_PROOFNO, ISNULL(TD.IDENTITY_PROOF,'0') AS IDENTITY_PROOF, TS.LINKED_TRAVEL_ID FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_DOM TD (NOLOCK) ON TS.TRAVEL_ID=TD.TRAVEL_ID AND TS.TRAVEL_TYPE='D' WHERE TD.TRAVEL_ID="+strTravelId+" AND TD.APPLICATION_ID=1 AND TD.STATUS_ID=10"; 
		rs = dbConBean.executeQuery(strSql);
		if (rs.next()) {			
			strTravelReqId				= rs.getString("TRAVEL_REQ_ID");
			strSiteId					= rs.getString("SITE_ID");
			strUserId					= rs.getString("TRAVELLER_ID");
			strMealId           		= rs.getString("MEAL");
			strDepDateFwd				= rs.getString("TRAVEL_DATE");
			strManager            		= rs.getString("MANAGER_ID");
			strHod             		    = rs.getString("HOD_ID");
			strBoardMember				= rs.getString("BOARD_MEMBER_ID");
			strReasonForSkip			= rs.getString("REASON_FOR_SKIP");
			strReasonForTravel      	= rs.getString("REASON_FOR_TRAVEL"); 			
			strHotelRequired     = rs.getString("TRANSITTYPE");   
		    strBudgetCurrency    = rs.getString("BUDGET_CURRENCY"); 
			    if(strBudgetCurrency == null) {
					strBudgetCurrency = "INR";
				}
			strPlace			 = rs.getString("PLACE");
				if(strPlace == null) {
					strPlace = "";
				}
		    strHotelBudget       = rs.getString("BUDGET"); 
			    if(strHotelBudget!= null && strHotelBudget.equals("0.0")) {
					strHotelBudget = "";
				}
			strCheckin			 = rs.getString("CHECKINDATE");   
			strCheckout			 = rs.getString("CHECKOUTDATE");   	
			strRemarks           = rs.getString("REMARKS"); 
			strCostCentre		 =	rs.getString("CC_ID");	
				if(strCostCentre==null) {
					strCostCentre="0";
				}
			
			strIdentityProof			=	rs.getString("IDENTITY_PROOF");	
			strIdentityProofNo			=	rs.getString("IDENTITY_PROOFNO");
			
			strCancelledReqId 			= 	rs.getString("LINKED_TRAVEL_ID");
			}					
		rs.close();		
	}
	else if(strTravelType.equals("I")) {
	 	strSql = "SELECT TD.TRAVEL_REQ_ID, TD.SITE_ID, TD.TRAVELLER_ID,AGE,SEX,TD.MEAL,VISA_REQUIRED,VISA_COMMENT, DBO.CONVERTDATEDMY1(TD.TRAVEL_DATE)AS TRAVEL_DATE, INSURANCE_REQUIRED,NOMINEE, RELATION, INSURANCE_COMMENTS, HOTEL_REQUIRED,RTRIM(LTRIM(BUDGET_CURRENCY))AS BUDGET_CURRENCY , ISNULL(HOTEL_BUDGET,'') AS HOTEL_BUDGET, REMARKS,  DBO.CONVERTDATEDMY1(CHECK_IN_DATE)AS CHECK_IN_DATE, DBO.CONVERTDATEDMY1(CHECK_OUT_DATE)AS CHECK_OUT_DATE,   RTRIM(LTRIM(APPROVER_SELECTION)) AS APPROVER_SELECTION, MANAGER_ID,HOD_ID,  LTRIM(RTRIM(ISNULL(CARD_TYPE,''))) AS CARD_TYPE,LTRIM(RTRIM(ISNULL(CARD_NUMBER1,''))) AS CARD_NUMBER1,LTRIM(RTRIM(ISNULL(CARD_NUMBER2,''))) AS CARD_NUMBER2 ,LTRIM(RTRIM(ISNULL(CARD_NUMBER3,''))) AS CARD_NUMBER3, LTRIM(RTRIM(ISNULL(CARD_NUMBER4,''))) AS CARD_NUMBER4 ,LTRIM(RTRIM(ISNULL(CVV_NUMBER,''))) AS CVV_NUMBER,LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CARD_EXP_DATE),''))) AS CARD_EXP_DATE,ISNULL(REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL,ISNULL(REASON_FOR_SKIP,'') AS REASON_FOR_SKIP, ISNULL(PLACE,'') AS  PLACE, ISNULL(CARD_HOLDER_NAME,'') AS CARD_HOLDER_NAME,BOARD_MEMBER_ID,CC_ID, TS.LINKED_TRAVEL_ID FROM  T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_INT TD (NOLOCK) ON TS.TRAVEL_ID=TD.TRAVEL_ID AND TS.TRAVEL_TYPE='I' WHERE TD.TRAVEL_ID="+strTravelId+" AND TD.APPLICATION_ID=1 AND TD.STATUS_ID=10";
	  	rs       =   dbConBean.executeQuery(strSql);  
		if(rs.next()) {
			strTravelReqId       = rs.getString("TRAVEL_REQ_ID");
			strSiteId            = rs.getString("SITE_ID");
			strUserId            = rs.getString("TRAVELLER_ID");
			strMealId            = rs.getString("MEAL");
		    strDepDateFwd        = rs.getString("TRAVEL_DATE");
			strManager           = rs.getString("MANAGER_ID");
			strHod               = rs.getString("HOD_ID");
		    strBoardMember		 = rs.getString("BOARD_MEMBER_ID");
			strReasonForSkip     = rs.getString("REASON_FOR_SKIP");
			strReasonForTravel   = rs.getString("REASON_FOR_TRAVEL");
			strVisaRequired      = rs.getString("VISA_REQUIRED");
			strVisaComment       = rs.getString("VISA_COMMENT");		
		    strInsuranceRequired = rs.getString("INSURANCE_REQUIRED");  
			strNominee           = rs.getString("NOMINEE");   
			strRelation          = rs.getString("RELATION");   
		    strInsuranceComment  = rs.getString("INSURANCE_COMMENTS");   
			strHotelRequired     = rs.getString("HOTEL_REQUIRED");   
		    strBudgetCurrency    = rs.getString("BUDGET_CURRENCY");    
			strPlace			 = rs.getString("PLACE");
				if(strPlace == null) {
					strPlace = "";
				}
		    strHotelBudget       = rs.getString("HOTEL_BUDGET"); 
			    if(strHotelBudget!= null && strHotelBudget.equals("0.0")) {
					strHotelBudget = "";
				}
			strCheckin			 = rs.getString("CHECK_IN_DATE");   
			strCheckout			 = rs.getString("CHECK_OUT_DATE");   	
			strRemarks           = rs.getString("REMARKS");	
			strCostCentre		 =	rs.getString("CC_ID");	
				if(strCostCentre==null) {
					strCostCentre="0";
				}
			strCancelledReqId 	= rs.getString("LINKED_TRAVEL_ID");
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
		strTotalAmount           = rs.getString("TOTAL_AMOUNT");
		strTACurrency            = rs.getString("TA_CURRENCY");
		strTravellerCheque       = rs.getString("TRAVELLER_CHEQUE");
		strTravellerCheque1      = rs.getString("TRAVELLER_CHEQUE1");
		strTravellerCheque2      = rs.getString("TRAVELLER_CHEQUE2");

		strTCCurrency            = rs.getString("TC_CURRENCY");
		strTCCurrency1           = rs.getString("TC_CURRENCY1");
		strTCCurrency2           = rs.getString("TC_CURRENCY2");
		strExpenditureRemarks    = rs.getString("EXPENDITURE_REMARKS");
		strCashBreakupRemarks    = rs.getString("CASH_BREAKUP_REMARKS");
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

		if(dbl_YTM_BUDGET.equalsIgnoreCase("0.0"))
			dbl_YTM_BUDGET = "";
		if(dbl_YTD_ACTUAL.equalsIgnoreCase("0.0"))
			dbl_YTD_ACTUAL = "";
		if(dbl_AVAIL_BUDGET.equalsIgnoreCase("0.0"))
			dbl_AVAIL_BUDGET = "";
		if(dbl_EST_EXP.equalsIgnoreCase("0.0"))
			dbl_EST_EXP = "";
		
		//changed by manoj chand on 21 feb 2012 to set strAmount blank when it is  zero 
		if (strTklocalprice.equals("0")) {
			strTklocalprice = "";
		}
		//TK_PROVIDER_FLAG,TK_AIRLINE_NAME,TK_CURRENCY,TK_AMOUNT,TK_REMARKS

		if (strBillingClient == null)
			strBillingClient = "";
		if (strTotalAmount == null)
			strTotalAmount = "";
		if (strTravellerCheque == null)
			strTravellerCheque = "";
		if (strTravellerCheque1 == null)
			strTravellerCheque1 = "";
		if (strTravellerCheque2 == null)
			strTravellerCheque2 = "";
		if (strExpenditureRemarks == null)
			strExpenditureRemarks = "";
		if (strCashBreakupRemarks == null)
			strCashBreakupRemarks = "";
		if (strTACurrency == null || strTACurrency.equals(""))
			strTACurrency = "USD";

		if (strTCCurrency == null || strTCCurrency.equals(""))
			strTCCurrency = "USD";
		if (strTCCurrency1 == null || strTCCurrency1.equals(""))
			strTCCurrency1 = "USD";
		if (strTCCurrency2 == null || strTCCurrency2.equals(""))
			strTCCurrency2 = "USD";

		if (strTotalAmount != null && strTotalAmount.trim().equals("0")) {
			strTotalAmount = "";
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
if(strVisaRequired == null) {
	strVisaRequired = "1";
}
if(strVisaComment == null) {
	strVisaComment = "";
}
if(strInsuranceComment == null) {
	strInsuranceComment = "";	
}
if(strNominee == null) {
	strNominee = "";
}
if(strRelation == null) {
	strRelation = "";
}
if(strHotelBudget == null || strHotelBudget.equals("0")) {
	strHotelBudget = "";
}
if(strBudgetCurrency == null) {
	strBudgetCurrency = "USD";
}
if(strRemarks == null) {
	strRemarks = "";
}
if(strCheckin == null) {
	strCheckin = "";
} 
if(strCheckout == null) {
	strCheckout = "";
}
if(strCostCentre==null) {
	strCostCentre="0";
}

			String FIRSTNAME                =  "";
			String MIDDLENAME               =  "";
			String LASTNAME                 =  "";
			String DESIGNATION				=  "";
			String GENDER					=  "";
			String EMAIL                    =  "";
			String CONTACT_NUMBER           =  "";
			String DOB                      =  "";
			String ECNR                     =  "";
			String ADDRESS                  =  "";
			String CURRENT_ADDRESS			=  "";			
			String IDENTITY_PROOF			=  "";
			String IDENTITY_PROOF_NO	 	=  "";
			String NOMINEE					=  "";
			String RELATION					=  "";			
			String PASSPORT_NO              =  "";
			String PLACE_ISSUE              =  "";	
			String NATIONALITY				=  "";
			String DATE_ISSUE               =  "";		
			String EXPIRY_DATE              =  "";	
			String AIRLINE_NAME1			=  "";
			String AIRLINE_NAME2			=  "";
			String AIRLINE_NAME3			=  "";
			String AIRLINE_NO1				=  "";
			String AIRLINE_NO2				=  "";
			String AIRLINE_NO3				=  "";
							
			strSql="SELECT FIRSTNAME, LASTNAME, ISNULL(MIDDLENAME ,'') AS MIDDLENAME, LTRIM(RTRIM(EMAIL)) AS EMAIL, ISNULL(CONTACT_NUMBER,'') AS CONTACT_NUMBER, ISNULL(ECNR,'') AS ECNR, ISNULL(ADDRESS,'') AS ADDRESS, ISNULL(CURRENT_ADDRESS,'') AS CURRENT_ADDRESS, ISNULL(IDENTITY_ID,-1) AS IDENTITY_ID, ISNULL(IDENTITY_NO,'') AS IDENTITY_NO, LTRIM(RTRIM(ISNULL(PASSPORT_NO,''))) AS PASSPORT_NO, ISNULL(NATIONALITY ,'') AS NATIONALITY, ISNULL(PLACE_ISSUE,'') AS PLACE_ISSUE, ISNULL(.DBO.CONVERTDATEDMY1(DATE_ISSUE),'') AS DATE_ISSUE, ISNULL(.DBO.CONVERTDATEDMY1(EXPIRY_DATE),'') AS EXPIRY_DATE, ISNULL(dbo.DESIGNATIONNAME(DESIG_ID),'') AS DESIG, ISNULL(.DBO.CONVERTDATEDMY1(DOB),'') AS DOB, GENDER AS GENDER, ISNULL(FF_AIR_NAME,'') AS FF_AIR_NAME, ISNULL(FF_AIR_NAME1,'') AS FF_AIR_NAME1, ISNULL(FF_AIR_NAME2,'') AS FF_AIR_NAME2, ISNULL(FF_NUMBER,'') AS FF_NUMBER, ISNULL(FF_NUMBER1,'') AS FF_NUMBER1, ISNULL(FF_NUMBER2,'') AS FF_NUMBER2 FROM M_USERINFO WHERE USERID='"+strUserId+"' AND APPLICATION_ID=1";
			rs = dbConBean.executeQuery(strSql);
			if(rs.next()) {
				FIRSTNAME       	=  rs.getString("FIRSTNAME");
				MIDDLENAME			=  rs.getString("MIDDLENAME");
				LASTNAME        	=  rs.getString("LASTNAME");
				DESIGNATION			=  rs.getString("DESIG");
				GENDER				=  rs.getString("GENDER");
				EMAIL           	=  rs.getString("EMAIL");
				CONTACT_NUMBER  	=  rs.getString("CONTACT_NUMBER");
				DOB             	=  rs.getString("DOB");
				ECNR            	=  rs.getString("ECNR");
				ADDRESS         	=  rs.getString("ADDRESS");
				CURRENT_ADDRESS 	=  rs.getString("CURRENT_ADDRESS");
				IDENTITY_PROOF		=  rs.getString("IDENTITY_ID");
				IDENTITY_PROOF_NO	=  rs.getString("IDENTITY_NO");
				PASSPORT_NO        	=  rs.getString("PASSPORT_NO");
				PLACE_ISSUE   		=  rs.getString("PLACE_ISSUE");
				DATE_ISSUE    		=  rs.getString("DATE_ISSUE");
				EXPIRY_DATE			=  rs.getString("EXPIRY_DATE");
				AIRLINE_NAME1		=  rs.getString("FF_AIR_NAME");
				AIRLINE_NAME2		=  rs.getString("FF_AIR_NAME1");
				AIRLINE_NAME3		=  rs.getString("FF_AIR_NAME2");
				AIRLINE_NO1			=  rs.getString("FF_NUMBER");
				AIRLINE_NO2			=  rs.getString("FF_NUMBER1");
				AIRLINE_NO3			=  rs.getString("FF_NUMBER2");
				NATIONALITY			=  rs.getString("NATIONALITY");
			}
			rs.close();
			
			if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
				IDENTITY_PROOF		=  strIdentityProof;
				IDENTITY_PROOF_NO	=  strIdentityProofNo;
			}
			
			
			if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
				rs=null;
				if(strTravelType.equals("D")) {					
					strSql = " SELECT 1 FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_DOM TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+
							" WHERE TS.TRAVEL_TYPE='D' AND TS.TRAVEL_STATUS_ID =6 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") "+ 
							" AND (CONVERT(DATE,TD.C_DATETIME) BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE()) OR  TD.TRAVEL_DATE BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE())) AND TD.Group_Travel_Flag='N' "+  
							" UNION "+  
							" SELECT 1 FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_DOM TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+   
							" INNER JOIN (SELECT TRAVEL_ID,TJDI.JOURNEY_ORDER,TRAVEL_DATE FROM T_JOURNEY_DETAILS_DOM TJDI WHERE STATUS_ID=10 "+
							" UNION "+
							" SELECT TRAVEL_ID,9999,TRAVEL_DATE FROM T_RET_JOURNEY_DETAILS_DOM WHERE STATUS_ID=10 AND YEAR(TRAVEL_DATE)<>1900 AND TRAVEL_DATE IS NOT NULL)DRV ON TD.TRAVEL_ID=DRV.TRAVEL_ID "+
							" WHERE TS.TRAVEL_TYPE='D' AND TS.TRAVEL_STATUS_ID =10 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") AND TD.Group_Travel_Flag='N' "+  
							" GROUP BY TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID HAVING CONVERT(DATE,GETDATE()) BETWEEN MIN(DRV.TRAVEL_DATE) AND MAX(DRV.TRAVEL_DATE) ";
				} else if(strTravelType.equals("I")) {	
					strSql = " SELECT 1 FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_INT TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+
							" WHERE TS.TRAVEL_TYPE='I' AND TS.TRAVEL_STATUS_ID =6 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") "+ 
							" AND (CONVERT(DATE,TD.C_DATETIME) BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE()) OR  TD.TRAVEL_DATE BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE())) AND TD.Group_Travel_Flag='N' "+  
							" UNION "+  
							" SELECT 1 FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_INT TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+   
							" INNER JOIN (SELECT TRAVEL_ID,TJDI.JOURNEY_ORDER,TRAVEL_DATE FROM T_JOURNEY_DETAILS_INT TJDI WHERE STATUS_ID=10 "+
							" UNION "+
							" SELECT TRAVEL_ID,9999,TRAVEL_DATE FROM T_RET_JOURNEY_DETAILS_INT WHERE YEAR(TRAVEL_DATE)<>1900 AND TRAVEL_DATE IS NOT NULL)DRV ON TD.TRAVEL_ID=DRV.TRAVEL_ID "+
							" WHERE TS.TRAVEL_TYPE='I' AND TS.TRAVEL_STATUS_ID =10 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") AND TD.Group_Travel_Flag='N' "+  
							" GROUP BY TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID HAVING CONVERT(DATE,GETDATE()) BETWEEN MIN(DRV.TRAVEL_DATE) AND MAX(DRV.TRAVEL_DATE) ";
				}
					rs = dbConBean.executeQuery(strSql);
					if(rs.next()) {	
						strShowCancelledRegflag = "y";
					}
					rs.close();
		    }
		%>
		
<!-- Added By Gurmeet Singh [START] -->
  <script type="text/javascript">
	var accomBudgetCurrency = '<%=strBudgetCurrency%>';
  </script>
<!-- Added By Gurmeet Singh [END] -->
</head>

<body>
<div id="waitingData" style="display: none;">	    
	 <img src="images/loading16.gif?buildstamp=2_0_0" width="50" height="51" border="0" /> 
	 <br>      
	 <font color="#373737" class="pageHead"><center><%=dbLabelBean.getLabel("label.global.pleasewait",strsesLanguage)%></center></font>    
</div>
<form name="frm" id="frmId" action="T_QuickTravel_Detail_Post.jsp" >
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
						     	 <li><%=dbLabelBean.getLabel("label.editrequest.edittravelrequest",strsesLanguage)%>&nbsp;-&nbsp;<span style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; font-weight: bold;color: #0000ff;">[<%=strTravelReqNo %>]</span></li>
						    </ul>
						</td>
					<%	
					} else {
					%>
						<td>
						<ul class="pagebullet">
					     	 <li><%=dbLabelBean.getLabel("label.createrequest.createtravelrequest",strsesLanguage)%></li>
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
													" AND (CONVERT(DATE,TD.C_DATETIME) BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE()) OR  TD.TRAVEL_DATE BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE())) AND TD.Group_Travel_Flag='N' "+  
													" UNION "+  
													" SELECT TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_DOM TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+   
													" INNER JOIN (SELECT TRAVEL_ID,TJDI.JOURNEY_ORDER,TRAVEL_DATE FROM T_JOURNEY_DETAILS_DOM TJDI WHERE STATUS_ID=10 "+
													" UNION "+
													" SELECT TRAVEL_ID,9999,TRAVEL_DATE FROM T_RET_JOURNEY_DETAILS_DOM WHERE STATUS_ID=10 AND YEAR(TRAVEL_DATE)<>1900 AND TRAVEL_DATE IS NOT NULL)DRV ON TD.TRAVEL_ID=DRV.TRAVEL_ID "+
													" WHERE TS.TRAVEL_TYPE='D' AND TS.TRAVEL_STATUS_ID =10 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") AND TD.Group_Travel_Flag='N' "+  
													" GROUP BY TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID HAVING CONVERT(DATE,GETDATE()) BETWEEN MIN(DRV.TRAVEL_DATE) AND MAX(DRV.TRAVEL_DATE) ";
										} else if(strTravelType.equals("I")) {
											strSql = " SELECT TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_INT TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+
													" WHERE TS.TRAVEL_TYPE='I' AND TS.TRAVEL_STATUS_ID =6 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") "+ 
													" AND (CONVERT(DATE,TD.C_DATETIME) BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE()) OR  TD.TRAVEL_DATE BETWEEN CONVERT(DATE,DATEADD(DD,-30,GETDATE())) AND CONVERT(DATE,GETDATE())) AND TD.Group_Travel_Flag='N' "+  
													" UNION "+  
													" SELECT TD.TRAVEL_ID,TD.TRAVEL_REQ_NO,TS.TRAVEL_STATUS_ID FROM T_TRAVEL_STATUS TS INNER JOIN T_TRAVEL_DETAIL_INT TD ON TS.TRAVEL_ID=TD.TRAVEL_ID "+   
													" INNER JOIN (SELECT TRAVEL_ID,TJDI.JOURNEY_ORDER,TRAVEL_DATE FROM T_JOURNEY_DETAILS_INT TJDI WHERE STATUS_ID=10 "+
													" UNION "+
													" SELECT TRAVEL_ID,9999,TRAVEL_DATE FROM T_RET_JOURNEY_DETAILS_INT WHERE YEAR(TRAVEL_DATE)<>1900 AND TRAVEL_DATE IS NOT NULL)DRV ON TD.TRAVEL_ID=DRV.TRAVEL_ID "+
													" WHERE TS.TRAVEL_TYPE='I' AND TS.TRAVEL_STATUS_ID =10 AND TS.STATUS_ID=10 AND (TD.TRAVELLER_ID="+strUserId+" OR TD.C_USERID="+strUserId+") AND TD.Group_Travel_Flag='N' "+  
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
		<!-- Itinerary Detail Start -->
		<tr>
			<td style="border-width: 0 0 0 0;">
				<table width="100%" border="0" cellspacing="2" cellpadding="0">
					<tr>
						<!-- Itinerary Detail Left TD Start -->
						<td id="left">
						<fieldset style="padding:2px 8px 8px 8px;" id="itineraryBlock">
    						<legend class="labelText"><%=dbLabelBean.getLabel("label.global.additinerary",strsesLanguage) %></legend>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr valign="top">
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
												<td id="travelerNm">
													<select name="userName" class="comboBoxCss" id="userName" title="<%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage)%>">
														<option value="-1" selected><%=dbLabelBean.getLabel("label.createrequest.travellername",strsesLanguage) %></option>
										              	<%
										              		//For Population of Name Combo according to the Site 
										              		if(ssflage.equals("1") && strAppLvl3flg.equalsIgnoreCase("N")) {
										              			if(SuserRoleOther.equals("LA")) {
										              			strSql=" SELECT USERID, DBO.USER_NAME(USERID) AS USERNAME "+
																		 "FROM M_USERINFO WITH (NOLOCK) WHERE (SITE_ID = "+strSiteId+") AND (STATUS_ID = 10) AND (APPLICATION_ID = 1) "+
																		 " UNION SELECT USERID,DBO.USER_NAME(USERID) AS USERNAME "+
																		 " FROM USER_MULTIPLE_ACCESS WHERE (SITE_ID = "+strSiteId+") AND (STATUS_ID = 10) ORDER BY USERNAME";
																} else {
																strSql =   "select userid, dbo.user_name(userid) As UserName from M_userInfo (NOLOCK) where userid="+Suser_id+" and status_id=10 and application_id=1 order by 2";
																}
										              		} 
										              		else {
										              			strSql=" SELECT USERID, DBO.USER_NAME(USERID) AS USERNAME "+
																		 "FROM M_USERINFO WITH (NOLOCK) WHERE (SITE_ID = "+strSiteId+") AND (STATUS_ID = 10) AND (APPLICATION_ID = 1) "+
																		 " UNION SELECT USERID,DBO.USER_NAME(USERID) AS USERNAME "+
																		 " FROM USER_MULTIPLE_ACCESS WHERE (SITE_ID = "+strSiteId+") AND (USER_MULTIPLE_ACCESS.ROLE_ID='LA' OR  USER_MULTIPLE_ACCESS.UNIT_HEAD=1) AND (STATUS_ID = 10) ORDER BY USERNAME";
															}
										              		rs = dbConBean.executeQuery(strSql);
										              		while(rs.next()) {
										              	%>
										              	<option value="<%=rs.getString("UserId")%>"><%=rs.getString("UserName")%></option>
										              				<% }
																	 rs.close(); 
																	 %>
													</select>
													<script language="javascript">
										                document.frm.userName.value= "<%=strUserId%>";
							            			</script>
												</td>
												<td id="meal">
													<select name="meal" class="comboBoxCss">
													<option value="0"><%=dbLabelBean.getLabel("label.createrequest.selectmealpref",strsesLanguage)%></option>
													<%						                           
						                             strSql =   "SELECT MEAL_ID, MEAL_NAME FROM M_MEAL (NOLOCK) WHERE TRAVEL_AGENCY_ID = 1 AND STATUS_ID =10 ORDER BY MEAL_ID";
						                             rs       =   dbConBean.executeQuery(strSql);  
						                             while(rs.next())
						                             {						                            
													%>
						                              <option value="<%=rs.getString("MEAL_ID")%>"><%=rs.getString("MEAL_NAME")%></option>
													<% 
						                         	 }
						                             rs.close();	  
													%>
						                          </select>
						                          <script language="javascript">
						                            document.frm.meal.value="<%=strMealId%>";
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
								<tr valign="top">
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tblItinerary">
											<tbody>
											<%											
											if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
												
												if(strTravelType.equals("D")) {
													strSql ="SELECT TRAVEL_FROM, TRAVEL_TO, RTRIM(LTRIM(TRAVEL_MODE)) AS TRAVEL_MODE, MODE_NAME, RTRIM(LTRIM(TRAVEL_CLASS)) AS TRAVEL_CLASS, RTRIM(LTRIM(TIMINGS)) AS TIMINGS, "+ 
															" ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED FROM T_JOURNEY_DETAILS_DOM (NOLOCK) WHERE TRAVEL_ID="+strTravelId+" AND JOURNEY_ORDER=1 AND APPLICATION_ID=1";
												} else if(strTravelType.equals("I")) {
													strSql ="SELECT TRAVEL_FROM, TRAVEL_TO, RTRIM(LTRIM(TRAVEL_MODE)) AS TRAVEL_MODE, MODE_NAME, RTRIM(LTRIM(TRAVEL_CLASS)) AS TRAVEL_CLASS, RTRIM(LTRIM(TIMINGS)) AS TIMINGS, "+ 
															" ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED FROM T_JOURNEY_DETAILS_INT (NOLOCK) WHERE TRAVEL_ID="+strTravelId+" AND JOURNEY_ORDER=1 AND APPLICATION_ID=1";
												}										
			
														rs1  =   dbConBean.executeQuery(strSql);  
														if(rs1.next()) {
														strDepCityFwd           = rs1.getString("TRAVEL_FROM"); 
														strArrCityFwd           = rs1.getString("TRAVEL_TO");
														strPreferTimeFwd        = rs1.getString("TIMINGS");
														strTravelModeFwd        = rs1.getString("TRAVEL_MODE");
														strTravelClassFwd       = rs1.getString("TRAVEL_CLASS");
														strNameOfAirlineFwd     = rs1.getString("MODE_NAME");
														strPreferSeatFwd        = rs1.getString("SEAT_PREFFERED");
														} 
											
												rs1.close();
											}
											%>			<tr><td class="journeyTitle" colspan="9"><%=dbLabelBean.getLabel("label.global.forwardjourney",strsesLanguage)%></td></tr>
														<tr class="itineraryDataRow">
															<td class="city"><input type="text" name="depCity" class="textBoxCss" value="<%=strDepCityFwd %>" id="depCityTB" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'c')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
															<td class="city"><input type="text" name="arrCity" class="textBoxCss" value="<%= strArrCityFwd%>" id="arrCityTB" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'c')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
															<td class="date"><input type="text" name="depDate" class="textBoxCss" value="<%= strDepDateFwd%>" id="depDateTB" onFocus="initializeJourneyDate(this);" placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
															<td class="time">
																 <select name="preferTime" class="comboBoxCss" id="preferTimeSB"  title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																	<%
										                     		 strSql =   "SELECT TIME_ID, PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY DISPLAY_ORDER ASC";
																	rs=null;
																	rs       =   dbConBean.executeQuery(strSql);  
										                            while(rs.next()) {
										                            	if(!rs.getString("TIME_ID").equals("") && !rs.getString("TIME_ID").equals("102")) {
											                            	if(!rs.getString("TIME_ID").equals("") && rs.getString("TIME_ID").equals(strPreferTimeFwd)) {
																		%>
																				<option value="<%=rs.getString("TIME_ID")%>" selected="selected"><%=rs.getString("PREFER_TIME")%></option>
																		<%  } else {  
																				if(!rs.getString("TIME_ID").equals("") && rs.getString("TIME_ID").equals("2")){
											                            %>		 
											                            			<option value="<%=rs.getString("TIME_ID")%>" selected="selected"><%=rs.getString("PREFER_TIME")%></option>
											                            <% 
											                            		} else {
																		%>
											                              			<option value="<%=rs.getString("TIME_ID")%>"><%=rs.getString("PREFER_TIME")%></option>
																		<%
											                         	 		}
																			}
										                            	}
										                         	 }
										                             rs.close();	  
																	%>													
										                        </select>
															</td>
															<td class="mode">
																<select name="departMode" class="comboBoxCss departMode" id="departModeSB" onchange="selectTravelMode(this);" title="<%=dbLabelBean.getLabel("label.global.mode",strsesLanguage)%>">
																	<%
																    strSql =   "SELECT TRIP_ID,TRIP_TYPE FROM dbo.M_TRAVEL_MODE WHERE dbo.M_TRAVEL_MODE.STATUS_ID=10 AND dbo.M_TRAVEL_MODE.TRAVEL_AGENCY_ID = 1";
																    rs=null;
										                             rs       =   dbConBean.executeQuery(strSql);
										                             while(rs.next()) { 
										                            	 if(!rs.getString("TRIP_ID").equals("") && rs.getString("TRIP_ID").equals(strTravelModeFwd)) {
										                             %>
										                             		<option  value ="<%=rs.getString("TRIP_ID") %>" selected="selected"><%=rs.getString("TRIP_TYPE")%></option>
										                             <% } else { %>
										                             
																    		<option  value ="<%=rs.getString("TRIP_ID") %>"><%=rs.getString("TRIP_TYPE")%></option>
																	<%	}
										                             }										                            	 
											                         rs.close();	  
																	%>
																</select>
															</td>
															<td class="trClass">
																<select name="departClass" class="comboBoxCss comboDepartClass" id="departClassSB" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																	<% 																
													                    strSql =   "SELECT CLASS_ID,ELIGIBILITY from dbo.M_MODE_CLASS mmc WHERE mmc.MODE_ID='"+strTravelModeFwd+"' AND mmc.TRAVEL_AGENCY_ID = 1 AND mmc.STATUS_ID=10 ORDER BY CLASS_ID";
																	 rs=null;
																	rs = dbConBean.executeQuery(strSql);
																	while (rs.next()) {
																		if(!rs.getString(1).equals("") && rs.getString(1).equals(strTravelClassFwd)) {
																	%>
																		<option value="<%=rs.getString(1)%>" selected="selected"><%=rs.getString(2)%></option>
																	<% } else { %>
																		
											                                 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
																	<%
																		}
																	}
													                rs.close();	  
																	%>	
																</select>
															</td>
															<td class="flight"><input type="text" name="nameOfAirline" class="textBoxCss nameOfAirline" value="<%= strNameOfAirlineFwd%>" id="nameOfAirlineTB" placeholder="<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>" onKeyUp="return test2(this, 30, 'cn')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>"></td>
															<td class="seat">
																<select name="seatPreffred" class="comboBoxCss comboPrefSeat" id="seatPreffredSB" title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																<%
									                            //For Population of seat prefference Combo For Departure
														   
															     strSql =   "SELECT  seat_id, Seat_Name FROM  M_SEAT_PREFER (NOLOCK) WHERE (MODE_ID = "+strTravelModeFwd+") AND (TRAVEL_AGENCY_ID = 1) AND (STATUS_ID = 10) ORDER BY SEAT_ID";
																rs=null;
															   rs       =   dbConBean.executeQuery(strSql);  
									                           while(rs.next())	{
									                        	   if(!rs.getString(1).equals("") && rs.getString(1).equals(strPreferSeatFwd)) {
																%>
																		<option value="<%=rs.getString(1)%>" selected="selected"><%=rs.getString(2)%></option>
																<% } else { %>
																
										                             	<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
																<%
																	}
										                           }
										                           rs.close();									
																%>
										                        </select>
															</td>
															<td class="del"></td>															
														</tr>
														
														<tr id="intJrnyTitleRow" class="hide"><td class="journeyTitle" colspan="9"><%=dbLabelBean.getLabel("label.global.intermediatejourney",strsesLanguage)%></td></tr>
													<% 														
														if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
															
															if(strTravelType.equals("D")) {
																strSql = "SELECT TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(TRAVEL_DATE) AS TRAVEL_DATE, RTRIM(LTRIM(TIMINGS)) AS TIMINGS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, RTRIM(LTRIM(TRAVEL_MODE)) AS TRAVEL_MODE, MODE_NAME, RTRIM(LTRIM(TRAVEL_CLASS)) AS TRAVEL_CLASS, JOURNEY_ORDER FROM T_JOURNEY_DETAILS_DOM left outer JOIN M_SEAT_PREFER ON T_JOURNEY_DETAILS_DOM.SEAT_PREFFERED = M_SEAT_PREFER.seat_id WHERE T_JOURNEY_DETAILS_DOM.JOURNEY_ORDER>1 AND T_JOURNEY_DETAILS_DOM.TRAVEL_ID='"+strTravelId+"' AND T_JOURNEY_DETAILS_DOM.STATUS_ID=10 AND T_JOURNEY_DETAILS_DOM.APPLICATION_ID = 1 ORDER BY T_JOURNEY_DETAILS_DOM.JOURNEY_ORDER";
															} else if(strTravelType.equals("I")) {
																strSql = "SELECT TRAVEL_FROM, TRAVEL_TO, DBO.CONVERTDATEDMY1(TRAVEL_DATE) AS TRAVEL_DATE, RTRIM(LTRIM(TIMINGS)) AS TIMINGS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED, RTRIM(LTRIM(TRAVEL_MODE)) AS TRAVEL_MODE, MODE_NAME, RTRIM(LTRIM(TRAVEL_CLASS)) AS TRAVEL_CLASS, JOURNEY_ORDER FROM T_JOURNEY_DETAILS_INT left outer JOIN M_SEAT_PREFER ON T_JOURNEY_DETAILS_INT.SEAT_PREFFERED = M_SEAT_PREFER.seat_id WHERE T_JOURNEY_DETAILS_INT.JOURNEY_ORDER>1 AND T_JOURNEY_DETAILS_INT.TRAVEL_ID='"+strTravelId+"' AND T_JOURNEY_DETAILS_INT.STATUS_ID=10 AND T_JOURNEY_DETAILS_INT.APPLICATION_ID = 1 ORDER BY T_JOURNEY_DETAILS_INT.JOURNEY_ORDER";
															}														
				
															  rs2       =   dbConBean.executeQuery(strSql);  
															  while (rs2.next()) {																
														        strDepCityIntrmi           = rs2.getString("TRAVEL_FROM");
																strArrCityIntrmi           = rs2.getString("TRAVEL_TO");
																strDepDateIntrmi           = rs2.getString("TRAVEL_DATE");
																strPreferTimeIntrmi        = rs2.getString("TIMINGS");
																strTravelModeIntrmi        = rs2.getString("TRAVEL_MODE");		
																strTravelClassIntrmi       = rs2.getString("TRAVEL_CLASS");
																strNameOfAirlineIntrmi     = rs2.getString("MODE_NAME");
																strPreferSeatIntrmi        = rs2.getString("SEAT_PREFFERED");
																
															if(!strDepCityIntrmi.trim().equals("") || !strArrCityIntrmi.trim().equals("")) {	
															%>
															<tr class="itineraryDataRow">
																<td class="city"><input type="text" name="depCity" class="textBoxCss" value="<%=strDepCityIntrmi %>" id="depCityTB" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'c')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
																<td class="city"><input type="text" name="arrCity" class="textBoxCss" value="<%= strArrCityIntrmi%>" id="arrCityTB" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'c')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
																<td class="date"><input type="text" name="depDate" class="textBoxCss" value="<%= strDepDateIntrmi%>" id="depDateTB" onFocus="initializeJourneyDate(this);" placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
																<td class="time">
																	 <select name="preferTime" class="comboBoxCss" id="preferTimeSB" title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																		<%
											                     		strSql =   "SELECT TIME_ID, PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY DISPLAY_ORDER ASC";
																		rs=null; 
																		rs       =   dbConBean2.executeQuery(strSql);  
																		while(rs.next()) {
																			if(!rs.getString("TIME_ID").equals("") && !rs.getString("TIME_ID").equals("102")) {
												                            	if(!rs.getString("TIME_ID").equals("") && rs.getString("TIME_ID").equals(strPreferTimeIntrmi)) {
																			%>
																					<option value="<%=rs.getString("TIME_ID")%>" selected="selected"><%=rs.getString("PREFER_TIME")%></option>
																			<%  } else {
																					if(!rs.getString("TIME_ID").equals("") && rs.getString("TIME_ID").equals("2")){
																			%>
																						<option value="<%=rs.getString("TIME_ID")%>" selected="selected"><%=rs.getString("PREFER_TIME")%></option>
																			<% 
											                            		    } else {
																			%>		
													                                	<option value="<%=rs.getString("TIME_ID")%>"><%=rs.getString("PREFER_TIME")%></option>
																			<%		}
																				}
																			}
											                         	 }
											                             rs.close();	  
																		%>															
											                        </select>
																</td>
																<td class="mode">
																	<select name="departMode" class="comboBoxCss departMode" id="departModeSB" onchange="selectTravelMode(this);" title="<%=dbLabelBean.getLabel("label.global.mode",strsesLanguage)%>">
																		<%
																	    strSql =   "SELECT TRIP_ID,TRIP_TYPE FROM dbo.M_TRAVEL_MODE WHERE dbo.M_TRAVEL_MODE.STATUS_ID=10 AND dbo.M_TRAVEL_MODE.TRAVEL_AGENCY_ID = 1";
																	    rs=null;
											                             rs       =   dbConBean3.executeQuery(strSql);
											                             while(rs.next()) { 
											                            	 if(!rs.getString("TRIP_ID").equals("") && rs.getString("TRIP_ID").equals(strTravelModeIntrmi)) {
											                             %>
											                             		<option  value ="<%=rs.getString("TRIP_ID") %>" selected="selected"><%=rs.getString("TRIP_TYPE")%></option>
											                             <% } else { %>
											                             
																	    		<option  value ="<%=rs.getString("TRIP_ID") %>"><%=rs.getString("TRIP_TYPE")%></option>
																		<%	}
											                             }										                            	 
												                         rs.close();	  
																		%>
																	</select>
																</td>
																<td class="trClass">
																	<select name="departClass" class="comboBoxCss comboDepartClass" id="departClassSB" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																		<% 																
														                    strSql =   "SELECT CLASS_ID,ELIGIBILITY from dbo.M_MODE_CLASS mmc WHERE mmc.MODE_ID='"+strTravelModeIntrmi+"' AND mmc.TRAVEL_AGENCY_ID = 1 AND mmc.STATUS_ID=10 ORDER BY CLASS_ID";
																		 rs=null;
																		rs = dbConBean4.executeQuery(strSql);
																		while (rs.next()) {
																			if(!rs.getString(1).equals("") && rs.getString(1).equals(strTravelClassIntrmi)) {
																		%>
																			<option value="<%=rs.getString(1)%>" selected="selected"><%=rs.getString(2)%></option>
																		<% } else { %>
																			
												                                 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
																		<%
																			}
																		}
														                rs.close();	  
																		%>	
																	</select>
																</td>
																<td class="flight"><input type="text" name="nameOfAirline" class="textBoxCss nameOfAirline" value="<%= strNameOfAirlineIntrmi%>" id="nameOfAirlineTB" placeholder="<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>" onKeyUp="return test2(this, 30, 'cn')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>"></td>
																<td class="seat">
																	<select name="seatPreffred" class="comboBoxCss comboPrefSeat" id="seatPreffredSB" title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																	<%
										                            //For Population of seat prefference Combo For Departure
															   
																     strSql =   "SELECT  seat_id, Seat_Name FROM  M_SEAT_PREFER (NOLOCK) WHERE (MODE_ID = "+strTravelModeIntrmi+") AND (TRAVEL_AGENCY_ID = 1) AND (STATUS_ID = 10) ORDER BY SEAT_ID";
																	rs=null;
																   rs       =   dbConBean5.executeQuery(strSql);  
																   while(rs.next())	{
										                        	   if(!rs.getString(1).equals("") && rs.getString(1).equals(strPreferSeatIntrmi)) {
																	%>
																			<option value="<%=rs.getString(1)%>" selected="selected"><%=rs.getString(2)%></option>
																	<% } else { %>
																	
											                             	<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
																	<%
																		}
											                           }
											                           rs.close();									
																	%>
										                        	</select>
																</td>
																<td class="del"><input type="button" value="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>" class="bt-Del" id="bt-Del-ItInr" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"/></td>																
															</tr>
															<%	
																}
															  }
															  rs2.close();
														 }
													%>
												<tr class="innerRowItinerary"></tr>	
												<tr class="prototypeRowItinerary">
													<td class="city"><input type="text" name="depCityPT" class="textBoxCss" value="" id="depCityTB" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'c')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
													<td class="city"><input type="text" name="arrCityPT" class="textBoxCss" value="" id="arrCityTB" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'c')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
													<td class="date"><input type="text" name="depDatePT" class="textBoxCss" value="" id="depDateTB" onFocus="initializeJourneyDate(this);" placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
													<td class="time">
														 <select name="preferTimePT" class="comboBoxCss" id="preferTimeSB" title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
															<%											                   
								                             strSql =   "SELECT TIME_ID, PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY DISPLAY_ORDER ASC";
															rs=null;
															rs       =   dbConBean.executeQuery(strSql);  
								                             while(rs.next()) {
								                            	 if(!rs.getString("TIME_ID").equals("") && !rs.getString("TIME_ID").equals("102")) {
									                            	 if(!rs.getString("TIME_ID").equals("") && rs.getString("TIME_ID").equals("2")){
									                            %>		 
									                            	<option value="<%=rs.getString("TIME_ID")%>" selected="selected"><%=rs.getString("PREFER_TIME")%></option>
									                            <% 
									                            	} else {
																%>
									                              <option value="<%=rs.getString("TIME_ID")%>"><%=rs.getString("PREFER_TIME")%></option>
																<%
									                         	 	}								                            	 
								                            	 }
								                             }
								                             rs.close();	  
															%>											
								                        </select>														
													</td>
													<td class="mode">
														<select name="departModePT" class="comboBoxCss departMode" id="departModeSB" onchange="selectTravelMode(this);" title="<%=dbLabelBean.getLabel("label.global.mode",strsesLanguage)%>">
															<%
														    strSql =   "SELECT TRIP_ID,TRIP_TYPE FROM dbo.M_TRAVEL_MODE WHERE dbo.M_TRAVEL_MODE.STATUS_ID=10 AND dbo.M_TRAVEL_MODE.TRAVEL_AGENCY_ID = 1";
														    rs=null;
								                             rs       =   dbConBean.executeQuery(strSql);
								                             while(rs.next()) {%>
														    	<option  value ="<%=rs.getString("TRIP_ID") %>"><%=rs.getString("TRIP_TYPE")%></option>
															<%}
									                         rs.close();	  
															%>
														</select>
													</td>
													<td class="trClass">
														<select name="departClassPT" class="comboBoxCss comboDepartClass" id="departClassSB" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
															<% 																
											                    strSql =   "SELECT CLASS_ID,ELIGIBILITY from dbo.M_MODE_CLASS mmc WHERE mmc.MODE_ID='1' AND mmc.TRAVEL_AGENCY_ID = 1 AND mmc.STATUS_ID=10 ORDER BY CLASS_ID";
															rs=null;
															rs = dbConBean.executeQuery(strSql);
																while (rs.next()) {%>
									                                 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
															<%}
											                  rs.close();	  
															%>	
														</select>
													</td>
													<td class="flight"><input type="text" name="nameOfAirlinePT" class="textBoxCss nameOfAirline" value="" id="nameOfAirlineTB" placeholder="<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>" onKeyUp="return test2(this, 30, 'cn')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>"></td>
													<td class="seat">
														<select name="seatPreffredPT" class="comboBoxCss comboPrefSeat" id="seatPreffredSB" title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
														<%							                           											   
														    strSql =   "SELECT  seat_id, Seat_Name FROM  M_SEAT_PREFER (NOLOCK) WHERE (MODE_ID = 1) AND (TRAVEL_AGENCY_ID = 1) AND (STATUS_ID = 10) ORDER BY SEAT_ID";
														   rs=null; 
														   rs       =   dbConBean.executeQuery(strSql);  
								                           while(rs.next())
								                           {
														%>
								                             <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
														<%
								                           }
								                           rs.close();
														%>
							                        </select>											
													</td>
													<td class="del"><input type="button" value="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>" class="bt-Del" id="bt-Del-ItInr" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"/></td>													
												</tr>
														
													<%
														if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
														 
															if(strTravelType.equals("D")) {
															  strSql = "SELECT RETURN_FROM, RETURN_TO, dbo.CONVERTDATEDMY1(TRAVEL_DATE) AS RETURN_DATE, RTRIM(LTRIM(TRAVEL_MODE)) AS TRAVEL_MODE, MODE_NAME, " +
																         " RTRIM(LTRIM(TRAVEL_CLASS)) AS TRAVEL_CLASS, RTRIM(LTRIM(TIMINGS)) AS TIMINGS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED "+
															             " FROM T_RET_JOURNEY_DETAILS_DOM (NOLOCK) WHERE TRAVEL_ID="+strTravelId+" AND JOURNEY_ORDER=1 AND APPLICATION_ID=1";
														  } else if(strTravelType.equals("I")) {
															  strSql = "SELECT RETURN_FROM, RETURN_TO, dbo.CONVERTDATEDMY1(TRAVEL_DATE) AS RETURN_DATE, RTRIM(LTRIM(TRAVEL_MODE)) AS TRAVEL_MODE, MODE_NAME, " +
															         	 " RTRIM(LTRIM(TRAVEL_CLASS)) AS TRAVEL_CLASS, RTRIM(LTRIM(TIMINGS)) AS TIMINGS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED "+
														             	 " FROM T_RET_JOURNEY_DETAILS_INT (NOLOCK) WHERE TRAVEL_ID="+strTravelId+" AND JOURNEY_ORDER=1 AND APPLICATION_ID=1";
														  }														
														  
													    rs3       =   dbConBean.executeQuery(strSql);  
													    if(rs3.next()) {
															strDepCityRet           = rs3.getString("RETURN_FROM");
															strArrCityRet           = rs3.getString("RETURN_TO");
															strDepDateRet           = rs3.getString("RETURN_DATE");	
															strPreferTimeRet        = rs3.getString("TIMINGS");
															strTravelModeRet        = rs3.getString("TRAVEL_MODE");		
															strTravelClassRet       = rs3.getString("TRAVEL_CLASS");
															strNameOfAirlineRet     = rs3.getString("MODE_NAME");
															strPreferSeatRet        = rs3.getString("SEAT_PREFFERED");															
													    }
													   
													    rs3.close();
													}															
													%>  
													    <tr><td class="journeyTitle" colspan="9"><%=dbLabelBean.getLabel("label.global.returnjourney",strsesLanguage)%></td></tr>
														<tr class="itineraryDataRow">
															<td class="city"><input type="text" name="depCity" class="textBoxCss" value="<%=strDepCityRet %>" id="depCityTB" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'c')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>"></td>
															<td class="city"><input type="text" name="arrCity" class="textBoxCss" value="<%= strArrCityRet%>" id="arrCityTB" onFocus="initializeAirPortName(this);" placeholder="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>" onKeyUp="return test3(this, 30, 'c')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>"></td>
															<td class="date"><input type="text" name="depDate" class="textBoxCss" value="<%= strDepDateRet%>" id="depDateTB" onFocus="initializeJourneyDate(this);" placeholder="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>"></td>
															<td class="time">
																 <select name="preferTime" class="comboBoxCss" id="preferTimeSB" title="<%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%>">
																	<%
										                     		strSql =   "SELECT TIME_ID, PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY DISPLAY_ORDER ASC";
																	rs=null; 
																	rs       =   dbConBean.executeQuery(strSql);  
																	while(rs.next()) {
																		if(!rs.getString("TIME_ID").equals("") && !rs.getString("TIME_ID").equals("102")) {
											                            	if(!rs.getString("TIME_ID").equals("") && rs.getString("TIME_ID").equals(strPreferTimeRet)) {
																		%>
																				<option value="<%=rs.getString("TIME_ID")%>" selected="selected"><%=rs.getString("PREFER_TIME")%></option>
																		<%  } else {  
																				if(!rs.getString("TIME_ID").equals("") && rs.getString("TIME_ID").equals("2")){
											                            %>		 
											                            			<option value="<%=rs.getString("TIME_ID")%>" selected="selected"><%=rs.getString("PREFER_TIME")%></option>
											                            <% 
											                            		} else {
																		%>
											                              			<option value="<%=rs.getString("TIME_ID")%>"><%=rs.getString("PREFER_TIME")%></option>
																		<%
											                         	 		}
																			}
																		}
										                         	 }
																	%>
										                        </select>
															</td>
															<td class="mode">
																<select name="departMode" class="comboBoxCss departMode" id="departModeSB" onchange="selectTravelMode(this);" title="<%=dbLabelBean.getLabel("label.global.mode",strsesLanguage)%>">
																	<%
																    strSql =   "SELECT TRIP_ID,TRIP_TYPE FROM dbo.M_TRAVEL_MODE WHERE dbo.M_TRAVEL_MODE.STATUS_ID=10 AND dbo.M_TRAVEL_MODE.TRAVEL_AGENCY_ID = 1";
																    rs=null;
										                             rs       =   dbConBean.executeQuery(strSql);
										                             while(rs.next()) { 
										                            	 if(!rs.getString("TRIP_ID").equals("") && rs.getString("TRIP_ID").equals(strTravelModeRet)) {
										                             %>
										                             		<option  value ="<%=rs.getString("TRIP_ID") %>" selected="selected"><%=rs.getString("TRIP_TYPE")%></option>
										                             <% } else { %>
										                             
																    		<option  value ="<%=rs.getString("TRIP_ID") %>"><%=rs.getString("TRIP_TYPE")%></option>
																	<%	}
										                             }										                            	 
											                         rs.close();	  
																	%>
																</select>
															</td>
															<td class="trClass">
																<select name="departClass" class="comboBoxCss comboDepartClass" id="departClassSB" title="<%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%>">
																	<% 																
													                    strSql =   "SELECT CLASS_ID,ELIGIBILITY from dbo.M_MODE_CLASS mmc WHERE mmc.MODE_ID='"+strTravelModeRet+"' AND mmc.TRAVEL_AGENCY_ID = 1 AND mmc.STATUS_ID=10 ORDER BY CLASS_ID";
																	 rs=null;
																	rs = dbConBean.executeQuery(strSql);
																	while (rs.next()) {
																		if(!rs.getString(1).equals("") && rs.getString(1).equals(strTravelClassRet)) {
																	%>
																		<option value="<%=rs.getString(1)%>" selected="selected"><%=rs.getString(2)%></option>
																	<% } else { %>
																		
											                                 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
																	<%
																		}
																	}
													                rs.close();	  
																	%>	
																</select>
															</td>
															<td class="flight"><input type="text" name="nameOfAirline" class="textBoxCss nameOfAirline" value="<%= strNameOfAirlineRet%>" id="nameOfAirlineTB" placeholder="<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>" onKeyUp="return test2(this, 30, 'cn')" maxlength="30" title="<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>"></td>
															<td class="seat">
																<select name="seatPreffred" class="comboBoxCss comboPrefSeat" id="seatPreffredSB" title="<%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>">
																<%
									                             	strSql =   "SELECT  seat_id, Seat_Name FROM  M_SEAT_PREFER (NOLOCK) WHERE (MODE_ID = "+strTravelModeRet+") AND (TRAVEL_AGENCY_ID = 1) AND (STATUS_ID = 10) ORDER BY SEAT_ID";
																rs=null;	
																rs       =   dbConBean.executeQuery(strSql);  
																while(rs.next())	{
									                        	   if(!rs.getString(1).equals("") && rs.getString(1).equals(strPreferSeatRet)) {
																%>
																		<option value="<%=rs.getString(1)%>" selected="selected"><%=rs.getString(2)%></option>
																<% } else { %>
																
										                             	<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
																<%
																	}
										                           }
										                           rs.close();									
																%>
									                        	</select>
															</td>
															<td class="del"></td>															
														</tr>																
											</tbody>
											<script language="javascript">
												var rowLength = $("table#tblItinerary tbody tr.itineraryDataRow").length;
												if(rowLength > 2 && $("tr#intJrnyTitleRow").hasClass("hide")){
													$("tr#intJrnyTitleRow").removeClass("hide");
													$("tr#intJrnyTitleRow").addClass("show");
												}
											</script>
										</table>
									</td>
								</tr>
								<tr valign="top">
									<td><input type="button" value="<%=dbLabelBean.getLabel("link.global.intermediatejourney",strsesLanguage)%>" class="bt-Add-Dom" id="bt_Add" title="<%=dbLabelBean.getLabel("label.createrequest.requireinterimflightsortrainspecifyit",strsesLanguage)%>"/></td>									
								</tr>
								<tr valign="top">
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td id="travelReason">
													<textarea name="reasonForTravel" class=textAreaCss cols="" rows="2" placeholder="<%=dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage)%>" onKeyUp="return test2(this, 200, 'all')" maxlength="200" title="<%=dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage)%>"><%=strReasonForTravel %></textarea>
												</td>
												<td id="billingApprover">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td class="billingApproverLabel"><%=dbLabelBean.getLabel("label.requestdetails.billingclient",strsesLanguage)%></td>
															<td class="billingApproverCombo">
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
														<tr><td class="hrSpace6Px"></td></tr>
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
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr><td class="hrSpace6Px"></td></tr>
								<tr valign="top">
									<td>										
										<table width="99%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td class="requiredInputBox1" style="border-width: 1px 0 1px 1px; border-style: solid; border-color: #dddddd;">
													<label class="requiredInput"><%=dbLabelBean.getLabel("label.global.visarequired",strsesLanguage)%></label>
													<input type="hidden" name="visaComment" class="textBoxCss" value="" id="visaRequired" onKeyUp="return test2(this, 100, 'all')" maxlength="200" readonly="readonly" title="<%=dbLabelBean.getLabel("label.global.visarequired",strsesLanguage)%>">
												</td>
												<td class="requiredRadioBoxleft" style="border-width: 1px 1px 1px 0; border-style: solid; border-color: #dddddd;">
													<table width="100%" border="0" cellspacing="0" cellpadding="0" class="checkbox">
														<tr>
															<td class="labelTd">
																<label class="yes" id="visaRequiredYes">
										                    		<input type="radio" name="visa" value="1" id="visaRequired_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
										                    	</label>
										                    </td>
															<td class="labelTd">
																<label class="no" id="visaRequiredNo">
																	<input type="radio" name="visa" value="2" checked="checked" id="visaRequired_N"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
																</label>
															</td>
														</tr>
													</table>
													<script language="javascript">
													 var visaRequiredVal ="<%=strVisaRequired%>";											 
														if(visaRequiredVal != null && visaRequiredVal == "1") {
															$('input:radio#visaRequired_N').attr('checked', false);
															$('input:radio#visaRequired_Y').attr('checked', true);
															$("label#visaRequiredNo").removeClass("active");
															$("label#visaRequiredYes").addClass("active");
															$("input#visaRequired").val("Visa Required");
														} else if(visaRequiredVal != null && visaRequiredVal == "2") {
															$('input:radio#visaRequired_Y').attr('checked', false);
															$('input:radio#visaRequired_N').attr('checked', true);
															$("label#visaRequiredYes").removeClass("active");
														   	$("label#visaRequiredNo").addClass("active");
														   	$("input#visaRequired").val("Visa Not Required");
														}
													 </script>
												</td>
												<td class="pipe ecnrTd show" style="border-width: 1px 0 1px 0; border-style: solid; border-color: #dddddd;"></td>
												<td class="requiredInputBox2 ecnrTd show" style="border-width: 1px 0 1px 0; border-style: solid; border-color: #dddddd;">
													<label class="requiredInput"><%=dbLabelBean.getLabel("label.global.emigrationclearancerequired",strsesLanguage)%></label>
													<input type="hidden" name="emigrationRequired" class="textBoxCss" value="Emigration Clearance Required" id="emigrationRequired" readonly="readonly" title="<%=dbLabelBean.getLabel("label.global.emigrationclearancerequired",strsesLanguage)%>">
												</td>
												<td class="requiredRadioBoxleft ecnrTd show" style="border-width: 1px 1px 1px 0; border-style: solid; border-color: #dddddd;">
													<table width="100%" border="0" cellspacing="0" cellpadding="0" class="checkbox">
														<tr>
															<td class="labelTd">
																<label class="yes" id="emigrationRequiredYes">
																	<input type="radio" name="ecnrradio" value="1" id="emigrationRequired_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
																</label>
															</td>
															<td class="labelTd">
																<label class="no" id="emigrationRequiredNo">
																	<input type="radio" name="ecnrradio" value="2" id="emigrationRequired_N"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
																</label>
															</td>
															<td class="labelTd">
																<label class="na" id="emigrationRequiredNA">
																	<input type="radio" name="ecnrradio" value="3" id="emigrationRequired_NA"><%=dbLabelBean.getLabel("label.global.na",strsesLanguage)%>
																</label>
															</td>
														</tr>
													</table>													
												</td>
												<script language="javascript">
														var emigrationRequired = "<%=ECNR%>";														
														if(emigrationRequired == 3) {
															$("td.ecnrTd").removeClass("show");
															$("td.ecnrTd").addClass("hide");															
															$('input:radio#emigrationRequired_NA').prop("checked", true);
														   	$('input:radio#emigrationRequired_NA').val("3");
														   	$("input#emigrationRequired").val("Emigration Clearance Not Applicable");
														} else if(emigrationRequired == 1) {
															$("td.ecnrTd").removeClass("hide");
															$("td.ecnrTd").addClass("show");
															$("label#emigrationRequiredNo").removeClass("active");
															$("label#emigrationRequiredNA").removeClass("active");
															$("label#emigrationRequiredYes").addClass("active");
															$('input:radio#emigrationRequired_Y').prop("checked", true);
															$('input:radio#emigrationRequired_Y').val("1");
															$("input#emigrationRequired").val("Emigration Clearance Required");		
														} else if(emigrationRequired == 2) {
															$("td.ecnrTd").removeClass("hide");
															$("td.ecnrTd").addClass("show");
															$("label#emigrationRequiredYes").removeClass("active");
															$("label#emigrationRequiredNA").removeClass("active");
														   	$("label#emigrationRequiredNo").addClass("active");
														   	$('input:radio#emigrationRequired_N').prop("checked", true);
														   	$('input:radio#emigrationRequired_N').val("2");
														   	$("input#emigrationRequired").val("Emigration Clearance Not Required");
														} else {
															$("td.ecnrTd").removeClass("hide");
															$("td.ecnrTd").addClass("show");
															$("label#emigrationRequiredYes").removeClass("active");
															$("label#emigrationRequiredNA").removeClass("active");
														   	$("label#emigrationRequiredNo").addClass("active");
														   	$('input:radio#emigrationRequired_N').prop("checked", true);
														   	$('input:radio#emigrationRequired_N').val("2");
														   	$("input#emigrationRequired").val("Emigration Clearance Not Required");
														}																								
												</script>
												<td class="pipe" style="border-width: 1px 0 1px 0; border-style: solid; border-color: #dddddd;"></td>
												<td class="requiredInputBox3" style="border-width: 1px 0 1px 0; border-style: solid; border-color: #dddddd;">
													<label class="requiredInput"><%=dbLabelBean.getLabel("label.createrequest.travelinsurancerequired",strsesLanguage)%></label>
													<input type="hidden" name="insuranceComment" class="textBoxCss" value="" id="insuranceRequired" onKeyUp="return test2(this, 100, 'all')" maxlength="200" readonly="readonly" title="<%=dbLabelBean.getLabel("label.createrequest.travelinsurancerequired",strsesLanguage)%>">
												</td>
												<td class="requiredRadioBoxleft" style="border-width: 1px 1px 1px 0; border-style: solid; border-color: #dddddd;">
													<table width="100%" border="0" cellspacing="0" cellpadding="0" class="checkbox">
														<tr>
															<td class="labelTd">
																<label class="yes" id="insuranceRequiredYes">
										                    		<input type="radio" name="insurance" value="1"  checked="checked" id="insuranceRequired_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
										                    	</label>
										                    </td>
															<td class="labelTd">
																<label class="no" id="insuranceRequiredNo">
																	<input type="radio" name="insurance" value="2" id="insuranceRequired_N"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
																</label>
															</td>
														</tr>
													</table>
													<script language="javascript">
													 var insurnRequiredVal ="<%=strInsuranceRequired%>";											 
														if(insurnRequiredVal != null && insurnRequiredVal == "1") {
															$('input:radio#insuranceRequired_N').attr('checked', false);
															$('input:radio#insuranceRequired_Y').attr('checked', true);
															$("label#insuranceRequiredNo").removeClass("active");
															$("label#insuranceRequiredYes").addClass("active");
															$("input#insuranceRequired").val('');															
															$("input#nominee").prop('disabled', false);
															$("input#relation").prop('disabled', false);
														} else if(insurnRequiredVal != null && insurnRequiredVal == "2") {
															$('input:radio#insuranceRequired_Y').attr('checked', false);
															$('input:radio#insuranceRequired_N').attr('checked', true);
															$("label#insuranceRequiredYes").removeClass("active");
														   	$("label#insuranceRequiredNo").addClass("active");
														   	$("input#insuranceRequired").val("Insurance Not Required");
														   	$("input#nominee").val("");
															$("input#relation").val("");
															$("input#nominee").prop('disabled', true);
															$("input#relation").prop('disabled', true);
														}
													 </script>
												</td>
												<td class="pipe" style="border-width: 1px 0 1px 0; border-style: solid; border-color: #dddddd;"></td>
												<td class="requiredInputBox4" style="border-width: 1px 0 1px 0; border-style: solid; border-color: #dddddd;">
													<label class="requiredInput"><%=dbLabelBean.getLabel("label.global.accomodationrequired",strsesLanguage)%></label>
													<input type="hidden" name="accomodationComment" class="textBoxCss" value="Accommodation Required" id="accomodationRequired" readonly="readonly" title="<%=dbLabelBean.getLabel("label.global.accomodationrequired",strsesLanguage)%>">
												</td>
												<td class="requiredRadioBoxRight" style="border-width: 1px 1px 1px 0; border-style: solid; border-color: #dddddd;">
													<table width="100%" border="0" cellspacing="0" cellpadding="0" class="checkbox">
														<tr>
															<td class="labelTd">
																<label class="yes active" id="accomodationRequiredYes">
										                    		<input type="radio" name="accomodation" value="1" id="accomodationRequired_Y"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%>
										                    	</label>
										                    </td>
															<td class="labelTd">
																<label class="no" id="accomodationRequiredNo">
																	<input type="radio" name="accomodation" value="2" id="accomodationRequired_N" checked="checked"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
																</label>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>										
									</td>
								</tr>
								<tr valign="top" id="accomodationDetail" style="display: none;">
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td class="accomComboBoxHotel">
													<select name="hotel" id="accomStayType" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.staytype",strsesLanguage)%>" >
													 	<option value="0"><%=dbLabelBean.getLabel("label.global.na",strsesLanguage)%></option>
														<option value="1"><%=dbLabelBean.getLabel("label.global.hotel",strsesLanguage)%></option>
														<option value="2"><%=dbLabelBean.getLabel("label.global.transithouse",strsesLanguage)%></option>
													</select>
													<script language="javascript">
							                			document.frm.hotel.value= "<%=strHotelRequired%>"; 
									        		</script> 
												</td>
												<td class="accomComboBoxCurr">
													<select name="currency" id="accomCurrency" class="comboBoxCss" title="<%=dbLabelBean.getLabel("label.global.currency",strsesLanguage)%>">
												 	<%
									                     strSql =   "Select Currency, Currency from m_currency (NOLOCK) where status_id=10";
									         			 rs       =   dbConBean.executeQuery(strSql);  
														 while(rs.next()) {%>
									                          <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
									                 <% } 
														 rs.close();
													  %>
									                 </select>
									                 <script language="javascript">
									                       document.frm.currency.value="<%=strBudgetCurrency%>";
									                 </script> 
												</td>
												<td class="accomInputBoxBudget">
													<input type="text" name="budget" class="textBoxCss" id="accomBudget" value="<%=strHotelBudget %>" placeholder="<%=dbLabelBean.getLabel("label.global.budget",strsesLanguage)%>" onKeyUp="return test2(this, 12, 'n')" maxlength="20" title="<%=dbLabelBean.getLabel("label.global.budget",strsesLanguage)%>">
												</td>
												<td class="accomInputBoxDate">
													<input type="text" name="checkin" class="textBoxCss" id="checkInDate" onFocus="initializeDate(this);" value="<%=strCheckin %>" placeholder="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>">
												</td>
												<td class="accomInputBoxDate">
													<input type="text" name="checkout" class="textBoxCss" id="checkOutDate" onFocus="initializeDate(this);" value="<%=strCheckout %>" placeholder="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>" title="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>">
												</td>
												<td class="accomInputBoxPrefPlc">
													<input type="text" name="place" class="textBoxCss" id="accomPlace" value="<%=strPlace %>" placeholder="<%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage)%>" onKeyUp="return test2(this, 20, 'c')" maxlength="20" title="<%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage)%>">
												</td>
												<td class="accomTextAreaRemark">
													<textarea name="otherComment" class="textAreaCss2" id="otherComment" cols="" rows="2" placeholder="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>" onKeyUp="return test2(this, 200, 'all')" maxlength="200" title="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>"><%=strRemarks%></textarea>
												</td>
											</tr>
											<tr><td colspan="7" class="hrSpace6Px"></td></tr>
											<tr>
												<td colspan="7"><span class="accomtxt2"><sub>*</sub><%=dbLabelBean.getLabel("label.global.requirehotelthenspecifyhotelbudget",strsesLanguage)%></span><span id="hidethis" class="accomtxt3" style="display: none;">&nbsp;|&nbsp;<span class="accomtxt1"><sub>*</sub><%=dbLabelBean.getLabel("label.global.smokingmessage",strsesLanguage)%></span></span></td>
											</tr>
											
											<script language="javascript">
							                  var hotelRequiredVal ="<%=strHotelRequired%>";
							                  var accomRemarkVal = "<%=strRemarks%>";
											  if(hotelRequiredVal != null && (hotelRequiredVal == "0" || hotelRequiredVal == "")) {
												  	$("label#accomodationRequiredYes").removeClass("active");
												   	$("label#accomodationRequiredNo").addClass("active");
												   	$("input#accomodationRequired").val("Accommodation Not Required");
												   	$("tr#accomodationDetail").hide();
												   	$("select#accomStayType").find('option').eq(0).prop('selected', true);
													$("select#accomCurrency").find('option').eq(1).prop('selected', true);
													$("select#accomCurrency").prop('disabled', true);
													$("input#accomPlace").prop('disabled', true);
													$("input#accomBudget").prop('disabled', true);
													$("input#checkInDate").prop('disabled', true);
													$("input#checkOutDate").prop('disabled', true);
													$("textarea#otherComment").val("Accommodation Not Required");
													$("textarea#otherComment").css('color', '#000000');
													document.getElementById('hidethis').style.display = 'none'; 
												} else {
													$("select#accomCurrency").val('<%=strBudgetCurrency%>');
													$("select#accomCurrency").prop('disabled', false);
													$("input#accomPlace").prop('disabled', false);
													$("input#accomBudget").prop('disabled', false);
													$("input#checkInDate").prop('disabled', false);
													$("input#checkOutDate").prop('disabled', false);													
													$("tr#accomodationDetail").show();
													$("textarea#otherComment").prop('disabled', false);	
													if(accomRemarkVal != "" && accomRemarkVal != null && accomRemarkVal != 'Accommodation Not Required') {
														$("textarea#otherComment").val(accomRemarkVal);
														$("textarea#otherComment").css('color', '#000000');
													} else {
														$("textarea#otherComment").val("Remarks");
														$("textarea#otherComment").css('color', '#7a7a7a');
													}																									
												}
											  
											    if(hotelRequiredVal != null && hotelRequiredVal == "1"){
											    	$("select#accomCurrency").val('<%=strBudgetCurrency%>');
													document.getElementById('hidethis').style.display = 'none'; 
												} else if(hotelRequiredVal != null && hotelRequiredVal == "2"){
													$("select#accomCurrency").val('<%=strBudgetCurrency%>');
													document.getElementById('hidethis').style.display = ''; 
												}
										 </script>
										</table>
									</td>
								</tr>
							</table>
							</fieldset>
						</td>
						<!-- Itinerary Detail Left TD End -->
						
						<!-- Itinerary Detail Right TD Start -->
						<td id="right">
						<fieldset style="padding:2px 8px 8px 8px;" id="approverBlock">
    						<legend class="labelText"><%=dbLabelBean.getLabel("label.createrequest.addapprover",strsesLanguage)%></legend>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">								
								<tr valign="top" id="approverblkRow1">
									<td class="approverLevel1">
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
									<td class="approverLevel2">
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
								<tr id="approverblkRow2"><td colspan="2" class="hrSpace6Px"></td></tr>
								<tr valign="top" id="approverblkRow3">
								<% if(strAppLvl3flgforBM.trim().equalsIgnoreCase("Y")) {%>
									<td class="skipReason">
										<textarea name="reasonForSkip" class="textAreaCss" id="reasonForSkip" cols="" rows="2" placeholder="<%=dbLabelBean.getLabel("label.global.reasonforskippingtheapprovers",strsesLanguage)%>" onKeyUp="return test2(this, 200, 'all')" maxlength="200" title="<%=dbLabelBean.getLabel("label.global.reasonforskippingtheapprovers",strsesLanguage)%>"><%=strReasonForSkip %></textarea>
									</td>									
									<td class="approverLevel3"> 
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
								<% } else { %>
									<td class="skipReason" colspan="2">
									<textarea name="reasonForSkip" class="textAreaCss" id="reasonForSkip" cols="" rows="2" placeholder="<%=dbLabelBean.getLabel("label.global.reasonforskippingtheapprovers",strsesLanguage)%>" onKeyUp="return test2(this, 200, 'all')" maxlength="200" title="<%=dbLabelBean.getLabel("label.global.reasonforskippingtheapprovers",strsesLanguage)%>"><%=strReasonForSkip %></textarea>
									</td>
								<% }  %>								
								</tr>	
								<tr id="approverblkRow4"><td colspan="2" class="hrSpace6Px"></td></tr>
								<tr>
									<td colspan="2">										
										<div id="defaultApproverDiv"></div>
									</td>
								</tr>											
							</table>
							</fieldset>
						</td>
						<!-- Itinerary Detail Right TD End -->
					</tr>
				</table>
			</td>
		</tr>
		<!-- Itinerary Detail End -->
		
		<!-- Forex Detail Start -->
		<tr>
			<td style="border-width: 0 0 0 0;">
				<table width="100%" border="0" cellspacing="2" cellpadding="0">
					<tr>
						<td class="exColBar" id="forexDetailsBar" title="<%=dbLabelBean.getLabel("label.requestdetails.forexdetails",strsesLanguage)%>">
							<table width="300px" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="exColBarIcon"><img src="images/expand-icon.png?buildstamp=2_0_0" width="16" height="16" alt="" class="fxDetImg"/></td>
									<td class="exColBarText" id="forexLabel_Int" style="display: none;"><%=dbLabelBean.getLabel("label.requestdetails.forexdetails",strsesLanguage)%></td>									
									<td class="exColBarText" id="forexLabel_Dom" style="display: none;"><%=dbLabelBean.getLabel("label.createrequest.advancerequired",strsesLanguage)%></td>
								</tr>
							</table>							
						</td>
					</tr>
					<tr id="forexDetailRow" class="hide">
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td>
										<table width="98.7%" border="0" cellspacing="0" cellpadding="0" id="tblForexDetail" class="forexDetail">
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
							                   if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
							                	   int count=0,sno=0;
							                	   CallableStatement objCstmt	    =  null;
							                	   Connection objCon               =  dbConBean.getConnection(); 
							                	   objCstmt             =  objCon.prepareCall("{?=call SPG_GET_TRAVEL_EXPENDITURE_DETAILS(?,?,?)}");        
							                	   objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							                	   objCstmt.setString(2,strTravelId);
							                	   objCstmt.setString(3,strTravelType);
							                	   objCstmt.setString(4,"0");
							                	   rs4 = objCstmt.executeQuery();
							                	   while (rs4.next()) {
							                	   strRec="yes";
							                	   strTACurrency2		=	rs4.getString("CURRENCY");
							                	   strEntPerDay			=	rs4.getString("ENT_PER_DAY1");
							                	   strTotalTourDay		=	rs4.getString("TOTAL_TOUR_DAYS1");
							                	   strEntPerDay2		=	rs4.getString("ENT_PER_DAY2");
							                	   strTotalTourDay2		=	rs4.getString("TOTAL_TOUR_DAYS2");
							                	   strContingecies		=	rs4.getString("TOTAL_EXP_ID3");
							                	   strContingecies2		=	rs4.getString("TOTAL_EXP_ID4");
							                	   strTotalForex		=	rs4.getString("TOTAL_EXP");
							                	   strExRate			=	rs4.getString("EXCHANGE_RATE");
							                	   if(strExRate.equals("0.000000")) {
							                	   	strExRate = "";
							                	   }
							                	   strTotalINR			=	rs4.getString("TOTAL"); 
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
													<td class="dailyAllowances2"><input type="text" name="tourDays" class="forex" value="<%=strTotalTourDay %>" id="tourDays1" onblur="checkDateDiff(this);" onChange="check1();" onKeyUp="return test1(this, 3, 'n');" title="<%=dbLabelBean.getLabel("label.requisition.tourdays",strsesLanguage)%>"></td>
													<td class="hotelCharges1"><input type="text" name="entitlement2" class="forex" value="<%=strEntPerDay2 %>" id="entitlement2" onChange="check1();" onKeyUp="return test1(this, 10, 'n');" title="<%=dbLabelBean.getLabel("label.requisitiondetails.expday",strsesLanguage)%>"></td>
													<td class="hotelCharges2"><input type="text" name="tourDays2" class="forex" value="<%=strTotalTourDay2 %>" id="tourDays2" onblur="checkDateDiff(this);" onChange="check1();" onKeyUp="return test1(this, 3, 'n');" title="<%=dbLabelBean.getLabel("label.requisition.tourdays",strsesLanguage)%>"></td>
													<td class="contingencies"><input type="text" name="contingencies" class="forex" value="<%=strContingecies %>" id="contingencies1" onChange="check1();" onKeyUp="return test1(this, 10, 'n.');" title="<%=dbLabelBean.getLabel("label.global.contigencies",strsesLanguage)%>"></td>
													<td class="others"><input type="text" name="contingencies2" class="forex" value="<%=strContingecies2 %>" id="contingencies2" onChange="check1();" onKeyUp="return test1(this, 10, 'n.');" title="<%=dbLabelBean.getLabel("label.mylinks.others",strsesLanguage)%>"></td>
													<td class="total"><input type="text" name="totalForex" class="forex" value="<%=strTotalForex %>" id="totalforex" onChange="check1();" onKeyUp="return test1(this, 20, 'n.');" readonly="readonly" title="<%=dbLabelBean.getLabel("label.global.total",strsesLanguage)%>"></td>
													<td class="exchRate"><input type="text" name="exRate" class="forex" value="<%=strExRate %>" id="exrate" onChange="check1();" onKeyUp="return test1(this, 20, 'n.');" readonly="readonly" title="<%=dbLabelBean.getLabel("label.requisition.exchrate",strsesLanguage)%>&nbsp;(<%=dbLabelBean.getLabel("label.requisition.inr",strsesLanguage)%>)" disabled="disabled"></td>
													<td class="totalAmount"><input type="text" name="totalInr" class="forex" value="<%=strTotalINR %>" id="totalinr" onChange="check1();" onKeyUp="return test1(this, 20, 'n.');" readonly="readonly" title="<%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage)%>&nbsp;(<%=strBaseCur%>)"></td>
													<td class="action"><input type="button" value="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>" class="bt-Del" id="bt-Del-Curr" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"/></td>										
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
													<td class="dailyAllowances2"><input type="text" name="tourDays" class="forex" value="0" id="tourDays1" onblur="checkDateDiff(this);" onChange="check1();" onKeyUp="return test1(this, 3, 'n');" title="<%=dbLabelBean.getLabel("label.requisition.tourdays",strsesLanguage)%>"></td>
													<td class="hotelCharges1"><input type="text" name="entitlement2" class="forex" value="0" id="entitlement2" onChange="check1();" onKeyUp="return test1(this, 10, 'n');" title="<%=dbLabelBean.getLabel("label.requisitiondetails.expday",strsesLanguage)%>"></td>
													<td class="hotelCharges2"><input type="text" name="tourDays2" class="forex" value="0" id="tourDays2" onblur="checkDateDiff(this);" onChange="check1();" onKeyUp="return test1(this, 3, 'n');" title="<%=dbLabelBean.getLabel("label.requisition.tourdays",strsesLanguage)%>"></td>
													<td class="contingencies"><input type="text" name="contingencies" class="forex" value="0" id="contingencies1" onChange="check1();" onKeyUp="return test1(this, 10, 'n.');" title="<%=dbLabelBean.getLabel("label.global.contigencies",strsesLanguage)%>"></td>
													<td class="others"><input type="text" name="contingencies2" class="forex" value="0" id="contingencies2" onChange="check1();" onKeyUp="return test1(this, 10, 'n.');" title="<%=dbLabelBean.getLabel("label.mylinks.others",strsesLanguage)%>"></td>
													<td class="total"><input type="text" name="totalForex" class="forex" value="0" id="totalforex" onChange="check1();" onKeyUp="return test1(this, 20, 'n.');" readonly="readonly" title="<%=dbLabelBean.getLabel("label.global.total",strsesLanguage)%>"></td>
													<td class="exchRate"><input type="text" name="exRate" class="forex" value="<%=strExchRate %>" id="exrate" onChange="check1();" onKeyUp="return test1(this, 20, 'n.');" readonly="readonly" title="<%=dbLabelBean.getLabel("label.requisition.exchrate",strsesLanguage)%>&nbsp;(<%=dbLabelBean.getLabel("label.requisition.inr",strsesLanguage)%>)" disabled="disabled"></td>
													<td class="totalAmount"><input type="text" name="totalInr" class="forex" value="0.00" id="totalinr" onChange="check1();" onKeyUp="return test1(this, 20, 'n.');" readonly="readonly" title="<%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage)%>&nbsp;(<%=strBaseCur%>)"></td>
													<td class="action"></td>										
												    <input name="hd" id="hd" type="hidden" value="v" />
												</tr>
												<%} %>								
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
													<td class="dailyAllowances2"><input type="text" name="tourDays" class="forex" value="0" id="tourDays1" onblur="checkDateDiff(this);" onChange="check1();" onKeyUp="return test1(this, 3, 'n');" title="<%=dbLabelBean.getLabel("label.requisition.tourdays",strsesLanguage)%>"></td>
													<td class="hotelCharges1"><input type="text" name="entitlement2" class="forex" value="0" id="entitlement2" onChange="check1();" onKeyUp="return test1(this, 10, 'n');" title="<%=dbLabelBean.getLabel("label.requisitiondetails.expday",strsesLanguage)%>"></td>
													<td class="hotelCharges2"><input type="text" name="tourDays2" class="forex" value="0" id="tourDays2" onblur="checkDateDiff(this);" onChange="check1();" onKeyUp="return test1(this, 3, 'n');" title="<%=dbLabelBean.getLabel("label.requisition.tourdays",strsesLanguage)%>"></td>
													<td class="contingencies"><input type="text" name="contingencies" class="forex" value="0" id="contingencies1" onChange="check1();" onKeyUp="return test1(this, 10, 'n.');" title="<%=dbLabelBean.getLabel("label.global.contigencies",strsesLanguage)%>"></td>
													<td class="others"><input type="text" name="contingencies2" class="forex" value="0" id="contingencies2" onChange="check1();" onKeyUp="return test1(this, 10, 'n.');" title="<%=dbLabelBean.getLabel("label.mylinks.others",strsesLanguage)%>"></td>
													<td class="total"><input type="text" name="totalForex" class="forex" value="0" id="totalforex" onChange="check1();" onKeyUp="return test1(this, 20, 'n.');" readonly="readonly" title="<%=dbLabelBean.getLabel("label.global.total",strsesLanguage)%>"></td>
													<td class="exchRate"><input type="text" name="exRate" class="forex" value="0.000000" id="exrate" onChange="check1();" onKeyUp="return test1(this, 20, 'n.');" readonly="readonly" title="<%=dbLabelBean.getLabel("label.requisition.exchrate",strsesLanguage)%>&nbsp;(<%=dbLabelBean.getLabel("label.requisition.inr",strsesLanguage)%>)" disabled="disabled"></td>
													<td class="totalAmount"><input type="text" name="totalInr" class="forex" value="0.00" id="totalinr" onChange="check1();" onKeyUp="return test1(this, 20, 'n.');" readonly="readonly" title="<%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage)%>&nbsp;(<%=strBaseCur%>)"></td>
													<td class="action"><input type="button" value="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>" class="bt-Del" id="bt-Del-Curr" title="<%=dbLabelBean.getLabel("button.global.delete",strsesLanguage)%>"/></td>										
												    <input name="hd" id="hd" type="hidden" value="h" />
												</tr>
												<tr class="innerRowForex">
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
													<td class="currencyDenomination" colspan="6">
														<textarea name="cashBreakupRemarks" class="currencyDenomination" id="cashBreakupRemarks" cols="" rows="2" placeholder="<%=dbLabelBean.getLabel("label.global.kindlyputyourcurrencydenominationdetails",strsesLanguage)%>" onKeyUp="return test2(this, 300, 'all')" maxlength="300" title="<%=dbLabelBean.getLabel("label.global.kindlyputyourcurrencydenominationdetails",strsesLanguage)%>"><%=strCashBreakupRemarks %></textarea>
													</td>
												</tr>																						
											</tbody>
										</table>
									</td>
								</tr>
								<tr><td class="hrSpace4Px"></td></tr>
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
													<input type="text" name="AvailBud" class="textBoxCss" value="" id="AvailBud" onChange="" onKeyUp="" placeholder="<%=dbLabelBean.getLabel("label.createrequest.availablebudget",strsesLanguage)%>" maxlength="15" title="<%=dbLabelBean.getLabel("label.createrequest.availablebudget",strsesLanguage)%>">
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
										</table>
									</td>
								</tr>										
							</table>							
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<!-- Forex Detail End -->		
		
						
		<!-- Personal Detail Start -->
		<tr>
			<td style="border-width: 0 0 0 0;">
				<table width="100%" border="0" cellspacing="2" cellpadding="0">
					<tr>
						<td class="exColBar" id="personalDetailsBar" title="<%=dbLabelBean.getLabel("label.createrequest.verifyyourpersonaldetails",strsesLanguage)%>">
							<table width="300px" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="exColBarIcon"><img src="images/expand-icon.png?buildstamp=2_0_0" width="16" height="16" alt="" class="perDetImg"/></td>
									<td class="exColBarText"><%=dbLabelBean.getLabel("label.createrequest.verifyyourpersonaldetails",strsesLanguage)%></td>									
								</tr>
							</table>							
						</td>
					</tr>
					<tr id="personalDetailRow" class="hide">
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="2" cellpadding="0">
											<tr>
												<td colspan="6">
													<table width="100%" border="0" cellspacing="5" cellpadding="0">
														<tr><td class="perDet1" colspan="6"><%=dbLabelBean.getLabel("label.createrequest.personaldetails",strsesLanguage)%></td></tr>
													</table>
												</td>
											</tr>
											<tr>
												<td class="travellerNamelabel"><%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage)%></td>
												<td class="emailLabel"><%=dbLabelBean.getLabel("label.mylinks.email",strsesLanguage)%></td>
												<td class="dobLabel"><%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%></td>
												<td class="mobileLabel"><%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%></td>
												<td class="addressLabel"><%=dbLabelBean.getLabel("label.createrequest.permanentaddress",strsesLanguage)%></td>
												<td class="addressLabel"><%=dbLabelBean.getLabel("label.createrequest.currentaddress",strsesLanguage)%></td>
											</tr>
											<tr>
												<td class="travellerNameInput"><input type="text" name="travelerName" class="textBoxCss" value="<%=FIRSTNAME%> <%=MIDDLENAME%> <%=LASTNAME%>" id="travelerName" readonly="readonly"></td>
												<td class="emailInput"><input type="text" name="eMail" class="textBoxCss" value="<%=EMAIL%>" id="eMail" readonly="readonly"></td>
												<td class="dobInput"><input type="text" name="passport_DOB" class="textBoxCss" value="<%=DOB%>" id="dateOfBirth" onFocus="initializeDate(this);"></td>
												<td class="mobileInput"><input type="text" name="passport_Contact_No" class="textBoxCss" value="<%=CONTACT_NUMBER%>" id="passportContactNo" onKeyUp="return test2(this, 19, 'phone')" maxlength="20"></td>
												<td class="addressInput" rowspan="3"><textarea name="passport_address" class="textAreaCss3" id="passportAddress" cols="" rows="2" onkeyup="return test2(this, 149, 'all')" maxlength="149"><%=ADDRESS%></textarea></td>
												<td class="addressInput" rowspan="3"><textarea name="current_address" class="textAreaCss3" id="currentAddress" cols="" rows="2" onkeyup="return test2(this, 149, 'all')" maxlength="149"><%=CURRENT_ADDRESS%></textarea></td>
											</tr>
											<tr>
												<td class="designationlabel"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%></td>
												<td class="genderlabel" colspan="3"><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%></td>
											</tr>
											<tr>
												<td class="designationInput"><input type="text" name="designation" class="textBoxCss" value="<%=DESIGNATION%>" id="designation" readonly="readonly"></td>
												<td class="genderInput" colspan="3">
													<table width="30%" border="0" cellspacing="0" cellpadding="0">
														<tr>
														<%
															if(GENDER!=null) {
																if(GENDER.equals("Male")) {
														%>
																<td class="genderInputRadio">
																	<input name="sex" type="radio" value="1" id="maleRd" checked disabled/>
																</td>
																<td class="genderInputlabel">
																	<%=dbLabelBean.getLabel("label.global.male",strsesLanguage)%>
																</td>
																<td class="genderInputRadio">
																	<input name="sex" type="radio" value="2" id="femaleRd" disabled/>
																</td>
																<td class="genderInputlabel">
																	<%=dbLabelBean.getLabel("label.global.female",strsesLanguage) %>
																</td>
																<% strSex= "1"; %>
														<%
																} else { 
														%>
																<td class="genderInputRadio">
																	<input name="sex" type="radio" value="1" id="maleRd" disabled/>
																</td>
																<td class="genderInputlabel">
																	<%=dbLabelBean.getLabel("label.global.male",strsesLanguage)%>
																</td>
																<td class="genderInputRadio">
																	<input name="sex" type="radio" value="2" id="femaleRd" checked disabled/>
																</td>
																<td class="genderInputlabel">
																	<%=dbLabelBean.getLabel("label.global.female",strsesLanguage) %>
																</td>
																<% strSex= "2"; %>
														<%
																}
															} else {
														%>
																<td class="genderInputRadio">
																	<input name="sex" type="radio" value="1" id="maleRd" checked />
																</td>
																<td class="genderInputlabel">
																	<%=dbLabelBean.getLabel("label.global.male",strsesLanguage)%>
																</td>
																<td class="genderInputRadio">
																	<input name="sex" type="radio" id="femaleRd" value="2" />
																</td>
																<td class="genderInputlabel">
																	<%=dbLabelBean.getLabel("label.global.female",strsesLanguage) %>
																</td>
																<% strSex= "1"; %>
														<%
															}
														%>
														</tr>
														<script language="javascript">
										                     var sexVal ="<%=strSex%>";							
																if(sexVal != null && sexVal == "2") {
																	document.frm.sex[1].checked=true;
																}
																
																if(sexVal != null && sexVal == "1") {
																	document.frm.sex[0].checked=true; 
																}																	
										                </script>  
													</table>
												</td>
											</tr>											
										</table>
									</td>
								</tr>
								<tr id="identityDetails">
									<td>
										<table width="100%" border="0" cellspacing="2" cellpadding="0">
											<tr>
												<td>
													<table width="100%" border="0" cellspacing="5" cellpadding="0">
														<tr><td class="perDet1"><%=dbLabelBean.getLabel("label.createrequest.identityproofdetails",strsesLanguage)%></td></tr>
													</table>
												</td>
											</tr>
											<tr>
												<td>
													<table width="26%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td class="identityProofLabel"><%=dbLabelBean.getLabel("label.global.proofofidentity",strsesLanguage)%></td>
															<td class="identityProofNoLabel"><%=dbLabelBean.getLabel("label.createrequest.identityproofnumber",strsesLanguage)%></td>												
														</tr>
														<tr>
															<td class="identityProofInput">
																<select name="identityProof" id="identityProof" class="comboBoxCss">
																 	 <option value="-1"><%=dbLabelBean.getLabel("label.createrequest.proofofidentity",strsesLanguage)%></option>
																		<%	
																		strSql = "SELECT IDENTITY_ID, IDENTITY_NAME FROM m_IDENTITY_PROOF WHERE STATUS_ID=10 ORDER BY ORDER_ID ";
																		rs = dbConBean.executeQuery(strSql); 
																		while(rs.next()){%>
																		  <option value = <%=rs.getString(1)%> > <%= rs.getString(2) %></option>
																		<%}
																		rs.close();
																		%>
																</select>
																<script language="javascript">
																	var identityProof = "<%=IDENTITY_PROOF%>";
																	$("select#identityProof").val(identityProof);																				
																	$("select#identityProof").change(function() {
																		if($(this).val() == identityProof) {
																			$("input#identityNo").val("<%=IDENTITY_PROOF_NO%>");
																		} else {
																			$("input#identityNo").val('');	
																		}
																	});
																</script>
															</td>
															<td class="identityProofNoInput">
																<input type="text" name="identityProofno" class="textBoxCss" value="<%=IDENTITY_PROOF_NO%>" id="identityNo" onKeyUp="return test2(this, 30, 'all')" maxlength="30">
															</td>												
														</tr>
													</table>
												</td>
											</tr>																						
										</table>
									</td>
								</tr>								
								<tr id="passportDetails">
									<td>
										<table width="100%" border="0" cellspacing="2" cellpadding="0">
											<tr>
												<td>
													<table width="100%" border="0" cellspacing="5" cellpadding="0">
														<tr>
															<td class="perDet1" style="width:50%;"><%=dbLabelBean.getLabel("label.requestdetails.passportdetails",strsesLanguage)%></td>
															<td class="perDet1" style="width:50%;"><%=dbLabelBean.getLabel("label.createrequest.insurancenominationdetails",strsesLanguage)%></td>
														</tr>
													</table>
												</td>
											</tr>	
											<tr>
												<td>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td style="width:50%;">
																<table width="100%" border="0" cellspacing="0" cellpadding="0">
																	<tr>
																		<td class="passportNoLabel"><%=dbLabelBean.getLabel("label.createrequest.passportnumber",strsesLanguage)%></td>
																		<td class="placeIssueLabel"><%=dbLabelBean.getLabel("label.user.nationality",strsesLanguage)%></td>
																		<td class="placeIssueLabel"><%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%></td>
																		<td class="passportDateLabel"><%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%></td>
																		<td class="passportDateLabel"><%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage)%></td>												
																	</tr>
																	<tr>
																		<td class="passportNoInput">
																			<input type="text" name="passport_No" class="textBoxCss" value="<%=PASSPORT_NO%>" id="passportNo" onKeyUp="return test2(this, 49, 'all')" maxlength="49">
																		</td>
																		<td class="placeIssueInput">
																			<input type="text" name="nationality" class="textBoxCss" value="<%=NATIONALITY%>" id="nationality" onKeyUp="return test2(this, 99, 'c')" maxlength="99">
																		</td>
																		<td class="placeIssueInput">
																			<input type="text" name="passport_issue_place" class="textBoxCss" value="<%=PLACE_ISSUE%>" id="passportIssuePlace" onKeyUp="return test2(this, 99, 'c')" maxlength="99">
																		</td>
																		<td class="passportDateInput">
																			<input type="text" name="passport_issue_date" class="textBoxCss" value="<%=DATE_ISSUE%>" id="issueDate" onFocus="initializeDate(this);">
																		</td>
																		<td class="passportDateInput">
																			<input type="text" name="passport_expire_date" class="textBoxCss" value="<%=EXPIRY_DATE%>" id="expiryDate" onFocus="initializeDate(this);">
																		</td>												
																	</tr>
																</table>
															</td>
															<td style="width:50%;">
																<table width="40%" border="0" cellspacing="0" cellpadding="0">
																	<%
																		strSql="SELECT TOP 1 ISNULL(NOMINEE,'') AS NOMINEE, ISNULL(RELATION,'') AS RELATION FROM T_TRAVEL_DETAIL_INT INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_INT.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND TRAVEL_TYPE='I' AND T_TRAVEL_STATUS.TRAVEL_STATUS_ID = 10 WHERE TRAVELLER_ID = "+strUserId+" ORDER BY C_DATETIME DESC";
																		//strSql="SELECT TOP 1 ISNULL(NOMINEE,'') AS NOMINEE, ISNULL(RELATION,'') AS RELATION FROM T_TRAVEL_DETAIL_INT INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_INT.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND TRAVEL_TYPE='I' WHERE TRAVELLER_ID = "+strUserId+" ORDER BY C_DATETIME DESC";
																		rs = dbConBean.executeQuery(strSql);
																		if(rs.next()) {
																			NOMINEE = rs.getString("NOMINEE");
																			RELATION = rs.getString("RELATION");
																		}
																		
																		if(strTravelId !=null && !strTravelId.equals("") && !strTravelId.equals("new")) {
																			NOMINEE = strNominee;
																			RELATION = strRelation;
																		}																
																	%>	
																	<tr>
																		<td class="nomineeLabel"><%=dbLabelBean.getLabel("label.global.nominee",strsesLanguage)%></td>
																		<td class="relationLabel"><%=dbLabelBean.getLabel("label.createrequest.relation",strsesLanguage)%></td>												
																	</tr>
																	<tr>
																		<td class="nomineeInput">
																			<input type="text" name="nominee" class="textBoxCss" value="<%=NOMINEE%>" id="nominee" onKeyUp="return test2(this, 30, 'c')" maxlength="30">
																		</td>
																		<td class="relationInput">
																			<input type="text" name="relation" class="textBoxCss" value="<%=RELATION%>" id="relation" onKeyUp="return test2(this, 30, 'c')" maxlength="30">
																		</td>												
																	</tr>
																	<script language="javascript">
																 var insurnRequiredVal ="<%=strInsuranceRequired%>";											 
																	if(insurnRequiredVal != null && insurnRequiredVal == "1") {
																		$('input:radio#insuranceRequired_N').attr('checked', false);
																		$('input:radio#insuranceRequired_Y').attr('checked', true);
																		$("label#insuranceRequiredNo").removeClass("active");
																		$("label#insuranceRequiredYes").addClass("active");
																		$("input#insuranceRequired").val('');															
																		$("input#nominee").prop('disabled', false);
																		$("input#relation").prop('disabled', false);
																	} else if(insurnRequiredVal != null && insurnRequiredVal == "2") {
																		$('input:radio#insuranceRequired_Y').attr('checked', false);
																		$('input:radio#insuranceRequired_N').attr('checked', true);
																		$("label#insuranceRequiredYes").removeClass("active");
																	   	$("label#insuranceRequiredNo").addClass("active");
																	   	$("input#insuranceRequired").val("Insurance Not Required");
																	   	$("input#nominee").val("");
																		$("input#relation").val("");
																		$("input#nominee").prop('disabled', true);
																		$("input#relation").prop('disabled', true);
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
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="2" cellpadding="0">
											<tr>
												<td>
													<table width="100%" border="0" cellspacing="5" cellpadding="0">
														<tr><td class="perDet1"><%=dbLabelBean.getLabel("label.createrequest.frequentflyerdetails",strsesLanguage)%></td></tr>
													</table>
												</td>
											</tr>
											<tr>
												<td>
													<table width="20%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td class="airlineNameLabel"><%=dbLabelBean.getLabel("label.createrequest.airlinenames",strsesLanguage)%></td>
															<td class="airlineNoLabel"><%=dbLabelBean.getLabel("label.createrequest.airlinenumber",strsesLanguage)%></td>												
														</tr>
														<tr>
															<td class="airlineNameInput">
																<input type="text" name="airLineName" class="textBoxCss" value="<%=AIRLINE_NAME1%>" id="airLineName" onKeyUp="return test2(this, 20, 'cn')" maxlength="20">
															</td>
															<td class="airlineNoInput">
																<input type="text" name="passport_flight_No" class="textBoxCss" value="<%=AIRLINE_NO1%>" id="passportFlightNo" onKeyUp="return test2(this, 20, 'cn')" maxlength="20">
															</td>												
														</tr>
														<tr><td class="hrSpace4Px" colspan="2"></td></tr>
														<tr>
															<td class="airlineNameInput">
																<input type="text" name="airLineName1" class="textBoxCss" value="<%=AIRLINE_NAME2%>" id="airLineName1" onKeyUp="return test2(this, 20, 'cn')" maxlength="20">
															</td>
															<td class="airlineNoInput">
																<input type="text" name="passport_flight_No1" class="textBoxCss" value="<%=AIRLINE_NO2%>" id="passportFlightNo1" onKeyUp="return test2(this, 20, 'cn')" maxlength="20">
															</td>												
														</tr>
														<tr><td class="hrSpace4Px" colspan="2"></td></tr>
														<tr>
															<td class="airlineNameInput">
																<input type="text" name="airLineName2" class="textBoxCss" value="<%=AIRLINE_NAME3%>" id="airLineName2" onKeyUp="return test2(this, 20, 'cn')" maxlength="20">
															</td>
															<td class="airlineNoInput">
																<input type="text" name="passport_flight_No2" class="textBoxCss" value="<%=AIRLINE_NO3%>" id="passportFlightNo2" onKeyUp="return test2(this, 20, 'cn')" maxlength="20">
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
		<!-- Personal Detail End -->
		
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
	</table>
<!-- </div> -->
   <input type="hidden" name="todayDate" value="<%=strCurrentDate %>"/> <!--  HIDDEN FIELD  --> 
   <input type="hidden" name="travelId" value="<%=strTravelId%>"/> <!--  HIDDEN FIELD  -->
   <input type="hidden" name="travelReqId" value="<%=strTravelReqId%>"/> <!--  HIDDEN FIELD  -->
   <input type="hidden" name="travelReqNo" value="<%=strTravelReqNo%>"/> <!--  HIDDEN FIELD  --> 
   <input type="hidden" name="interimId"  value ="<%=strIntermiId %>" /> <!--  HIDDEN FIELD  -->  
   <input type="hidden" name="hidAppLvl3flg" value="<%=strAppLvl3flg %>" /> <!--  HIDDEN FIELD  --> 
   <input type="hidden" name="hidAppLvl3showbmflg" value="<%=strAppLvl3flgforBM %>" /> <!--  HIDDEN FIELD  --> 
   <input type="hidden" name="basecur" value="<%=strBaseCur %>"/> <!--  HIDDEN FIELD  -->    
   <input type="hidden" name="matapricecompdom" id="matapricecompdom" value="<%=strforPriceDesicionDom %>" /> <!--  HIDDEN FIELD  -->   
   <input type="hidden" name="matapricecompint" id="matapricecompint" value="<%=strforPriceDesicionInt %>" /> <!--  HIDDEN FIELD  -->  
   <input type="hidden" name="showBudInput" value="<%=strSHOW_BUD_INPUT %>" id="hidShowBudInput"/> <!--  HIDDEN FIELD  -->
   <input type="hidden" name="showFlag" value="<%=strShowflag %>" id="hidshowFlag"/> <!--  HIDDEN FIELD  -->
   <input type="hidden" name="approverlist" value="<%=ApproverText%>"> <!--  HIDDEN FIELD  -->
   <input type="hidden" name="BillingSiteFlag" value="<%=strFlag%>" id="BillingSiteFlag" />
   <input type="hidden" name="showCancelledRegflag" value="<%=strShowCancelledRegflag%>" id="showCancelledRegflag" />   
   <input type="hidden" name="sex" value= "<%=strSex%>" id="sex"/>
   <input type="hidden" name="whatAction"/> <!--  HIDDEN FIELD  -->
</form>  
<script type="text/javascript" src="ScriptLibrary/T_QuickTravelRequest.js?buildstamp=2_0_0"></script>
</body>
</html>
								
								
<script type="text/javascript">
var defaultApprWin;
var emigrationRequiredVal = "<%=ECNR%>";

jQuery(document).ready(function($) {
	
	fun_calculate_GrandTotalUSD();	
	
	showPersonalDetailRow();
	
	var accomRemarkVal = '<%=strRemarks%>';
	var strTravelIdVal = '<%=strTravelId%>';
	var travelTypeVal = '<%=strTravelType%>';
	
	if(travelTypeVal != null && travelTypeVal != '' && travelTypeVal == 'I'){
		$("#forexLabel_Int").css("display","block");
	}else{
		$("#forexLabel_Dom").css("display","block");
	}
	
	if(strTravelIdVal !=null && strTravelIdVal != "" && strTravelIdVal != "new") {
		
		fun_calculate_GrandTotalUSD();
		
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
			
			$("label#visaRequiredYes").addClass("disable");
		   	$("label#visaRequiredNo").addClass("disable");
		   	$("input#visaRequired").val("Visa Not Required");
			$("input#visaRequired").prop('disabled', true);
			$("input:radio#visaRequired_Y").attr('checked', false);
			$("input:radio#visaRequired_N").attr('checked', false);
			$("input:radio#visaRequired_Y").prop('disabled', true);
			$("input:radio#visaRequired_N").prop('disabled', true);
			
			$("label#emigrationRequiredYes").addClass("disable");
			$("label#emigrationRequiredNo").addClass("disable");
			$("label#emigrationRequiredNA").addClass("disable");
			$("input#emigrationRequired").val("Emigration Clearance Not Required");
			$("input#emigrationRequired").prop('disabled', true);
			$("input:radio#emigrationRequired_Y").attr('checked', false);
			$("input:radio#emigrationRequired_N").attr('checked', false);
			$("input:radio#emigrationRequired_NA").attr('checked', false);
			$("input:radio#emigrationRequired_Y").prop('disabled', true);
			$("input:radio#emigrationRequired_N").prop('disabled', true);
			$("input:radio#emigrationRequired_NA").prop('disabled', true);
			
			$("label#insuranceRequiredYes").addClass("disable");
		   	$("label#insuranceRequiredNo").addClass("disable");
		   	$("input#insuranceRequired").val("Insurance Not Required");
			$("input#insuranceRequired").prop('disabled', true);
			$("input:radio#insuranceRequired_Y").attr('checked', false);
			$("input:radio#insuranceRequired_N").attr('checked', false);
			$("input:radio#insuranceRequired_Y").prop('disabled', true);
			$("input:radio#insuranceRequired_N").prop('disabled', true);
			
			$("td.currencyDenomination").hide();
			$("td.contingenciesRemark").attr('colspan', '12');
			$("td.contingenciesRemark").css({'width': '100%'});
			$("textarea#expRemarks").css({'width': '47.7%'});			
								
			$("tr#passportDetails").hide();			
			$("tr#identityDetails").show();	
			
			$("#bt_Add").attr('title', '<%=dbLabelBean.getLabel("label.createrequest.requireinterimflightsortrainspecifyit",strsesLanguage)%>');			
			$("#bt_Add").removeClass("bt-Add-Int");
			$("#bt_Add").addClass("bt-Add-Dom");
			$("#bt_Add-Curr").removeClass("bt-Add-Curr-Int");
			$("#bt_Add-Curr").addClass("bt-Add-Curr-Dom");
			$("#bt-SaveExit").removeClass("bt-SubmitToWorkflow-Int");
			$("#bt-SaveExit").addClass("bt-SubmitToWorkflow-Dom");
			$("#bt-Save").removeClass("bt-SubmitToWorkflow-Int");
			$("#bt-Save").addClass("bt-SubmitToWorkflow-Dom");
			$("#bt-SubmitToWorkflow").removeClass("bt-SubmitToWorkflow-Int");
			$("#bt-SubmitToWorkflow").addClass("bt-SubmitToWorkflow-Dom");
			
			var val = $('input#rd_Dom:checked').val();
			var userId = $("select#userName option:selected").val();
			var siteId = $("select#siteName option:selected").val();
			defaultApproverList(siteId, userId, val);
			populateCancelledRequest(userId, val);
			showBuyTktFrmNonMATA();
			skipDisabled(frm,'abcd');
			
			var itineraryBlockHeight =  $("#itineraryBlock").height();
	        $('#approverBlock').css({"height": itineraryBlockHeight+"px"});
	        var defaultApproverDivHeight = $("#approverBlock").height()-$("#approverblkRow1").height()-$("#approverblkRow2").height()-$("#approverblkRow3").height()-$("#approverblkRow4").height()-20;
	        $('#defaultApproverDiv').css({"height": defaultApproverDivHeight+"px", "overflow-y": "auto", "overflow-x": "hidden"});
			
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
			
			$('.departMode').each(function() {			
				$(this).find('option').eq(0).prop('selected', true);			
				$(this).prop('disabled', true);
			});			
					
			$("tr#passportDetails").show();						
			$("tr#identityDetails").hide();	
			
			$("#bt_Add").attr('title', '<%=dbLabelBean.getLabel("label.global.interimflights",strsesLanguage)%>');
			$("td#cancelledTravelReqTd").removeClass("show");
			$("td#cancelledTravelReqTd").addClass("hide");
			$("#bt_Add").removeClass("bt-Add-Dom");
			$("#bt_Add").addClass("bt-Add-Int");
			$("#bt_Add-Curr").removeClass("bt-Add-Curr-Dom");
			$("#bt_Add-Curr").addClass("bt-Add-Curr-Int");
			$("#bt-SaveExit").removeClass("bt-SubmitToWorkflow-Dom");
			$("#bt-SaveExit").addClass("bt-SubmitToWorkflow-Int");
			$("#bt-Save").removeClass("bt-SubmitToWorkflow-Dom");
			$("#bt-Save").addClass("bt-SubmitToWorkflow-Int");
			$("#bt-SubmitToWorkflow").removeClass("bt-SubmitToWorkflow-Dom");
			$("#bt-SubmitToWorkflow").addClass("bt-SubmitToWorkflow-Int");
			
			var val = $('input#rd_Int:checked').val();
			var userId = $("select#userName option:selected").val();
			var siteId = $("select#siteName option:selected").val();
			defaultApproverList(siteId, userId, val);
			populateCancelledRequest(userId, val);
			showBuyTktFrmNonMATA();	
			skipDisabled(frm,'abcd');

			var itineraryBlockHeight =  $("#itineraryBlock").height();
	        $('#approverBlock').css({"height": itineraryBlockHeight+"px"});
	        var defaultApproverDivHeight = $("#approverBlock").height()-$("#approverblkRow1").height()-$("#approverblkRow2").height()-$("#approverblkRow3").height()-$("#approverblkRow4").height()-20;
	        $('#defaultApproverDiv').css({"height": defaultApproverDivHeight+"px", "overflow-y": "auto", "overflow-x": "hidden"});
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
			
			$("label#visaRequiredYes").addClass("disable");
		   	$("label#visaRequiredNo").addClass("disable");
		   	$("input#visaRequired").val("Visa Not Required");
			$("input#visaRequired").prop('disabled', true);
			$("input:radio#visaRequired_Y").attr('checked', false);
			$("input:radio#visaRequired_N").attr('checked', false);
			$("input:radio#visaRequired_Y").prop('disabled', true);
			$("input:radio#visaRequired_N").prop('disabled', true);
			
			$("label#emigrationRequiredYes").addClass("disable");
			$("label#emigrationRequiredNo").addClass("disable");
			$("label#emigrationRequiredNA").addClass("disable");
			$("input#emigrationRequired").val("Emigration Clearance Not Required");
			$("input#emigrationRequired").prop('disabled', true);
			$("input:radio#emigrationRequired_Y").attr('checked', false);
			$("input:radio#emigrationRequired_N").attr('checked', false);
			$("input:radio#emigrationRequired_NA").attr('checked', false);
			$("input:radio#emigrationRequired_Y").prop('disabled', true);
			$("input:radio#emigrationRequired_N").prop('disabled', true);
			$("input:radio#emigrationRequired_NA").prop('disabled', true);
			
			$("label#insuranceRequiredYes").addClass("disable");
		   	$("label#insuranceRequiredNo").addClass("disable");
		   	$("input#insuranceRequired").val("Insurance Not Required");
			$("input#insuranceRequired").prop('disabled', true);
			$("input:radio#insuranceRequired_Y").attr('checked', false);
			$("input:radio#insuranceRequired_N").attr('checked', false);
			$("input:radio#insuranceRequired_Y").prop('disabled', true);
			$("input:radio#insuranceRequired_N").prop('disabled', true);
			
			$('.departMode').each(function() {			
				$(this).find('option').eq(0).prop('selected', true);			
				$(this).prop('disabled', false);
				populateTravelClass('1');
			});
			
			$('.nameOfAirline').each(function() {
				$(this).attr('value', '');
				$(this).attr('placeholder', '<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>');
				$(this).attr('title', '<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>');
			});
			
			//set placeholder on page load
			setPlaceholder();			
			
			$("td.currencyDenomination").hide();
			$("td.contingenciesRemark").attr('colspan', '12');
			$("td.contingenciesRemark").css({'width': '100%'});
			$("textarea#expRemarks").css({'width': '47.7%'});			
			
			$("tr#passportDetails").hide();		
			$("tr#identityDetails").show();	
			
			$("#bt_Add").attr('title', '<%=dbLabelBean.getLabel("label.createrequest.requireinterimflightsortrainspecifyit",strsesLanguage)%>');
			$("#bt_Add").removeClass("bt-Add-Int");
			$("#bt_Add").addClass("bt-Add-Dom");
			$("#bt_Add-Curr").removeClass("bt-Add-Curr-Int");
			$("#bt_Add-Curr").addClass("bt-Add-Curr-Dom");
			$("#bt-SaveExit").removeClass("bt-SubmitToWorkflow-Int");
			$("#bt-SaveExit").addClass("bt-SubmitToWorkflow-Dom");
			$("#bt-Save").removeClass("bt-SubmitToWorkflow-Int");
			$("#bt-Save").addClass("bt-SubmitToWorkflow-Dom");
			$("#bt-SubmitToWorkflow").removeClass("bt-SubmitToWorkflow-Int");
			$("#bt-SubmitToWorkflow").addClass("bt-SubmitToWorkflow-Dom");
			
			var val = $('input#rd_Dom:checked').val();
			var userId = $("select#userName option:selected").val();
			var siteId = $("select#siteName option:selected").val();
			populateApproverLevelData(siteId, userId, val); 
			defaultApproverList(siteId, userId, val);
			populateCancelledRequest(userId, val);
	    	showBuyTktFrmNonMATA();   	
	    	
	    	var itineraryBlockHeight =  $("#itineraryBlock").height();
	        $('#approverBlock').css({"height": itineraryBlockHeight+"px"});
	        var defaultApproverDivHeight = $("#approverBlock").height()-$("#approverblkRow1").height()-$("#approverblkRow2").height()-$("#approverblkRow3").height()-$("#approverblkRow4").height()-20;
	        $('#defaultApproverDiv').css({"height": defaultApproverDivHeight+"px", "overflow-y": "auto", "overflow-x": "hidden"});
		
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
				
				
			$("label#visaRequiredYes").removeClass("disable");
			$("label#visaRequiredYes").removeClass("active");
		   	$("label#visaRequiredNo").removeClass("disable");
		   	$("label#visaRequiredNo").addClass("active");
		   	$("input#visaRequired").val("Visa Not Required");
			$("input#visaRequired").prop('disabled', false);
			$("input:radio#visaRequired_Y").attr('checked', false);
			$("input:radio#visaRequired_N").attr('checked', true);
			$("input:radio#visaRequired_Y").prop('disabled', false);
			$("input:radio#visaRequired_N").prop('disabled', false);
			
			$("label#emigrationRequiredYes").removeClass("disable");
			$("label#emigrationRequiredYes").removeClass("active");
			$("label#emigrationRequiredNA").removeClass("disable");
			$("label#emigrationRequiredNA").removeClass("active");
		   	$("label#emigrationRequiredNo").removeClass("disable");
		   	$("label#emigrationRequiredNo").addClass("active");
			$("input#emigrationRequired").val("Emigration Clearance Required");
			$("input#emigrationRequired").prop('disabled', false);
			$("input:radio#emigrationRequired_Y").attr('checked', false);
			$("input:radio#emigrationRequired_NA").attr('checked', false);
			$("input:radio#emigrationRequired_N").attr('checked', true);
			$("input:radio#emigrationRequired_Y").prop('disabled', false);
			$("input:radio#emigrationRequired_N").prop('disabled', false);
			$("input:radio#emigrationRequired_NA").prop('disabled', false);
			
			
			if(emigrationRequiredVal == 3) {
				$("td.ecnrTd").removeClass("show");
				$("td.ecnrTd").addClass("hide");															
				$('input:radio#emigrationRequired_NA').prop("checked", true);
			   	$('input:radio#emigrationRequired_NA').val("3");
			   	$("input#emigrationRequired").val("Emigration Clearance Not Applicable");
			} else if(emigrationRequiredVal == 1) {
				$("td.ecnrTd").removeClass("hide");
				$("td.ecnrTd").addClass("show");
				$("label#emigrationRequiredNo").removeClass("active");
				$("label#emigrationRequiredNA").removeClass("active");
				$("label#emigrationRequiredYes").addClass("active");
				$('input:radio#emigrationRequired_Y').prop("checked", true);
				$('input:radio#emigrationRequired_Y').val("1");
				$("input#emigrationRequired").val("Emigration Clearance Required");		
			} else if(emigrationRequiredVal == 2) {
				$("td.ecnrTd").removeClass("hide");
				$("td.ecnrTd").addClass("show");
				$("label#emigrationRequiredYes").removeClass("active");
				$("label#emigrationRequiredNA").removeClass("active");
			   	$("label#emigrationRequiredNo").addClass("active");
			   	$('input:radio#emigrationRequired_N').prop("checked", true);
			   	$('input:radio#emigrationRequired_N').val("2");
			   	$("input#emigrationRequired").val("Emigration Clearance Not Required");
			} else {
				$("td.ecnrTd").removeClass("hide");
				$("td.ecnrTd").addClass("show");
				$("label#emigrationRequiredYes").removeClass("active");
				$("label#emigrationRequiredNA").removeClass("active");
			   	$("label#emigrationRequiredNo").addClass("active");
			   	$('input:radio#emigrationRequired_N').prop("checked", true);
			   	$('input:radio#emigrationRequired_N').val("2");
			   	$("input#emigrationRequired").val("Emigration Clearance Not Required");
			}
		   	
			$("label#insuranceRequiredYes").removeClass("disable");
			$("label#insuranceRequiredYes").addClass("active");
		   	$("label#insuranceRequiredNo").removeClass("disable");
			$("label#insuranceRequiredNo").removeClass("active");
		   	$("input#insuranceRequired").val("");
			$("input#insuranceRequired").prop('disabled', false);
			$("input:radio#insuranceRequired_Y").attr('checked', true);
			$("input:radio#insuranceRequired_N").attr('checked', false);
			$("input:radio#insuranceRequired_Y").prop('disabled', false);
			$("input:radio#insuranceRequired_N").prop('disabled', false);
			
			$('.departMode').each(function() {			
				$(this).find('option').eq(0).prop('selected', true);			
				$(this).prop('disabled', true);
				populateTravelClass('1');			
			});		
			
			$('.nameOfAirline').each(function() {
				$(this).attr('value', '');
				$(this).attr('placeholder', '<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>');
				$(this).attr('title', '<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>');
			});
			
			//set placeholder on page load
			setPlaceholder();
			
			$("td.currencyDenomination").show();
			$("td.contingenciesRemark").attr('colspan', '6');
			$("td.contingenciesRemark").css({'width': '50%'});
			$("textarea#expRemarks").css({'width': '98%'});			
			
			$("tr#passportDetails").show();		
			$("tr#identityDetails").hide();				
			
			$("#bt_Add").attr('title', '<%=dbLabelBean.getLabel("label.global.interimflights",strsesLanguage)%>');
			$("td#cancelledTravelReqTd").removeClass("show");
			$("td#cancelledTravelReqTd").addClass("hide");
			$("#bt_Add").removeClass("bt-Add-Dom");
			$("#bt_Add").addClass("bt-Add-Int");
			$("#bt_Add-Curr").removeClass("bt-Add-Curr-Dom");
			$("#bt_Add-Curr").addClass("bt-Add-Curr-Int");
			$("#bt-SaveExit").removeClass("bt-SubmitToWorkflow-Dom");
			$("#bt-SaveExit").addClass("bt-SubmitToWorkflow-Int");
			$("#bt-Save").removeClass("bt-SubmitToWorkflow-Dom");
			$("#bt-Save").addClass("bt-SubmitToWorkflow-Int");
			$("#bt-SubmitToWorkflow").removeClass("bt-SubmitToWorkflow-Dom");
			$("#bt-SubmitToWorkflow").addClass("bt-SubmitToWorkflow-Int");
			
			var val = $('input#rd_Int:checked').val();    	
			var userId = $("select#userName option:selected").val();
			var siteId = $("select#siteName option:selected").val();
			populateApproverLevelData(siteId, userId, val); 
			defaultApproverList(siteId, userId, val);
			populateCancelledRequest(userId, val);
	    	showBuyTktFrmNonMATA(); 
	    	
	    	var itineraryBlockHeight =  $("#itineraryBlock").height();
	        $('#approverBlock').css({"height": itineraryBlockHeight+"px"});
	        var defaultApproverDivHeight = $("#approverBlock").height()-$("#approverblkRow1").height()-$("#approverblkRow2").height()-$("#approverblkRow3").height()-$("#approverblkRow4").height()-20;
	        $('#defaultApproverDiv').css({"height": defaultApproverDivHeight+"px", "overflow-y": "auto", "overflow-x": "hidden"});
	        
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
			$("label#visaRequiredYes").addClass("disable");
		   	$("label#visaRequiredNo").addClass("disable");
		   	$("input#visaRequired").val("Visa Not Required");
			$("input#visaRequired").prop('disabled', true);
			$("input:radio#visaRequired_Y").attr('checked', false);
			$("input:radio#visaRequired_N").attr('checked', false);
			$("input:radio#visaRequired_Y").prop('disabled', true);
			$("input:radio#visaRequired_N").prop('disabled', true);
			
			$("label#emigrationRequiredYes").addClass("disable");
			$("label#emigrationRequiredNo").addClass("disable");
			$("label#emigrationRequiredNA").addClass("disable");
			$("input#emigrationRequired").val("Emigration Clearance Not Required");
			$("input#emigrationRequired").prop('disabled', true);
			$("input:radio#emigrationRequired_Y").attr('checked', false);
			$("input:radio#emigrationRequired_N").attr('checked', false);
			$("input:radio#emigrationRequired_NA").attr('checked', false);
			$("input:radio#emigrationRequired_Y").prop('disabled', true);
			$("input:radio#emigrationRequired_N").prop('disabled', true);
			$("input:radio#emigrationRequired_NA").prop('disabled', true);
			
			$("label#insuranceRequiredYes").addClass("disable");
		   	$("label#insuranceRequiredNo").addClass("disable");
		   	$("input#insuranceRequired").val("Insurance Not Required");
			$("input#insuranceRequired").prop('disabled', true);
			$("input:radio#insuranceRequired_Y").attr('checked', false);
			$("input:radio#insuranceRequired_N").attr('checked', false);
			$("input:radio#insuranceRequired_Y").prop('disabled', true);
			$("input:radio#insuranceRequired_N").prop('disabled', true);
			
			$('.departMode').each(function() {			
				$(this).find('option').eq(0).prop('selected', true);			
				$(this).prop('disabled', false);
				populateTravelClass('1');
			});
			
			$('.nameOfAirline').each(function() {
				$(this).attr('value', '');
				$(this).attr('placeholder', '<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>');
				$(this).attr('title', '<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>');
			});
			
			//set placeholder on page load
			setPlaceholder();			
			
			$("td.currencyDenomination").hide();
			$("td.contingenciesRemark").attr('colspan', '12');
			$("td.contingenciesRemark").css({'width': '100%'});
			$("textarea#expRemarks").css({'width': '47.7%'});			
			
			$("tr#passportDetails").hide();		
			$("tr#identityDetails").show();				
			
			$("#bt_Add").attr('title', '<%=dbLabelBean.getLabel("label.createrequest.requireinterimflightsortrainspecifyit",strsesLanguage)%>');
			$("#bt_Add").removeClass("bt-Add-Int");
			$("#bt_Add").addClass("bt-Add-Dom");
			$("#bt_Add-Curr").removeClass("bt-Add-Curr-Int");
			$("#bt_Add-Curr").addClass("bt-Add-Curr-Dom");
			$("#bt-SaveExit").removeClass("bt-SubmitToWorkflow-Int");
			$("#bt-SaveExit").addClass("bt-SubmitToWorkflow-Dom");
			$("#bt-Save").removeClass("bt-SubmitToWorkflow-Int");
			$("#bt-Save").addClass("bt-SubmitToWorkflow-Dom");
			$("#bt-SubmitToWorkflow").removeClass("bt-SubmitToWorkflow-Int");
			$("#bt-SubmitToWorkflow").addClass("bt-SubmitToWorkflow-Dom");
			
			var val = $('input#rd_Dom:checked').val();		
			var userId = $("select#userName option:selected").val();
			var siteId = $("select#siteName option:selected").val();
			populateApproverLevelData(siteId, userId, val); 
			defaultApproverList(siteId, userId, val);
			populateCancelledRequest(userId, val);
	    	showBuyTktFrmNonMATA(); 
	    	
	    	var itineraryBlockHeight =  $("#itineraryBlock").height();
	        $('#approverBlock').css({"height": itineraryBlockHeight+"px"});
	        var defaultApproverDivHeight = $("#approverBlock").height()-$("#approverblkRow1").height()-$("#approverblkRow2").height()-$("#approverblkRow3").height()-$("#approverblkRow4").height()-20;
	        $('#defaultApproverDiv').css({"height": defaultApproverDivHeight+"px", "overflow-y": "auto", "overflow-x": "hidden"});
		
	        var depCity = document.getElementsByName("depCity");
	        var arrCity = document.getElementsByName("arrCity");

	        
	        for(var i = 0, len = depCity.length; i < len; i++) {
			      if((depCity[i].value != '' && depCity[i].value != '<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') || (arrCity[i].value != '' && arrCity[i].value != '<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>')) {			
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
			$("label#visaRequiredYes").removeClass("disable");
			$("label#visaRequiredYes").removeClass("active");
		   	$("label#visaRequiredNo").removeClass("disable");
		   	$("label#visaRequiredNo").addClass("active");
		   	$("input#visaRequired").val("Visa Not Required");
			$("input#visaRequired").prop('disabled', false);
			$("input:radio#visaRequired_Y").attr('checked', false);
			$("input:radio#visaRequired_N").attr('checked', true);
			$("input:radio#visaRequired_Y").prop('disabled', false);
			$("input:radio#visaRequired_N").prop('disabled', false);
			
			$("label#emigrationRequiredYes").removeClass("disable");
			$("label#emigrationRequiredYes").removeClass("active");
			$("label#emigrationRequiredNA").removeClass("disable");
			$("label#emigrationRequiredNA").removeClass("active");
		   	$("label#emigrationRequiredNo").removeClass("disable");
		   	$("label#emigrationRequiredNo").addClass("active");
			$("input#emigrationRequired").val("Emigration Clearance Required");
			$("input#emigrationRequired").prop('disabled', false);
			$("input:radio#emigrationRequired_Y").attr('checked', false);
			$("input:radio#emigrationRequired_NA").attr('checked', false);
			$("input:radio#emigrationRequired_N").attr('checked', true);
			$("input:radio#emigrationRequired_Y").prop('disabled', false);
			$("input:radio#emigrationRequired_N").prop('disabled', false);
			$("input:radio#emigrationRequired_NA").prop('disabled', false);
			
						
			if(emigrationRequiredVal == 3) {
				$("td.ecnrTd").removeClass("show");
				$("td.ecnrTd").addClass("hide");															
				$('input:radio#emigrationRequired_NA').prop("checked", true);
			   	$('input:radio#emigrationRequired_NA').val("3");
			   	$("input#emigrationRequired").val("Emigration Clearance Not Applicable");
			} else if(emigrationRequiredVal == 1) {
				$("td.ecnrTd").removeClass("hide");
				$("td.ecnrTd").addClass("show");
				$("label#emigrationRequiredNo").removeClass("active");
				$("label#emigrationRequiredNA").removeClass("active");
				$("label#emigrationRequiredYes").addClass("active");
				$('input:radio#emigrationRequired_Y').prop("checked", true);
				$('input:radio#emigrationRequired_Y').val("1");
				$("input#emigrationRequired").val("Emigration Clearance Required");		
			} else if(emigrationRequiredVal == 2) {
				$("td.ecnrTd").removeClass("hide");
				$("td.ecnrTd").addClass("show");
				$("label#emigrationRequiredYes").removeClass("active");
				$("label#emigrationRequiredNA").removeClass("active");
			   	$("label#emigrationRequiredNo").addClass("active");
			   	$('input:radio#emigrationRequired_N').prop("checked", true);
			   	$('input:radio#emigrationRequired_N').val("2");
			   	$("input#emigrationRequired").val("Emigration Clearance Not Required");
			} else {
				$("td.ecnrTd").removeClass("hide");
				$("td.ecnrTd").addClass("show");
				$("label#emigrationRequiredYes").removeClass("active");
				$("label#emigrationRequiredNA").removeClass("active");
			   	$("label#emigrationRequiredNo").addClass("active");
			   	$('input:radio#emigrationRequired_N').prop("checked", true);
			   	$('input:radio#emigrationRequired_N').val("2");
			   	$("input#emigrationRequired").val("Emigration Clearance Not Required");
			}
		   	
			$("label#insuranceRequiredYes").removeClass("disable");
			$("label#insuranceRequiredYes").addClass("active");
		   	$("label#insuranceRequiredNo").removeClass("disable");
			$("label#insuranceRequiredNo").removeClass("active");
		   	$("input#insuranceRequired").val("");
			$("input#insuranceRequired").prop('disabled', false);
			$("input:radio#insuranceRequired_Y").attr('checked', true);
			$("input:radio#insuranceRequired_N").attr('checked', false);
			$("input:radio#insuranceRequired_Y").prop('disabled', false);
			$("input:radio#insuranceRequired_N").prop('disabled', false);
			
			$('.departMode').each(function() {			
				$(this).find('option').eq(0).prop('selected', true);			
				$(this).prop('disabled', true);
				populateTravelClass('1');			
			});		
			
			$('.nameOfAirline').each(function() {
				$(this).attr('value', '');
				$(this).attr('placeholder', '<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>');
				$(this).attr('title', '<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>');
			});
			
			//set placeholder on page load
			setPlaceholder();
			
			$("td.currencyDenomination").show();
			$("td.contingenciesRemark").attr('colspan', '6');
			$("td.contingenciesRemark").css({'width': '50%'});
			$("textarea#expRemarks").css({'width': '98%'});			
			
			$("tr#passportDetails").show();		
			$("tr#identityDetails").hide();				
			
			$("#bt_Add").attr('title', '<%=dbLabelBean.getLabel("label.global.interimflights",strsesLanguage)%>');
			$("td#cancelledTravelReqTd").removeClass("show");
			$("td#cancelledTravelReqTd").addClass("hide");
			$("#bt_Add").removeClass("bt-Add-Dom");
			$("#bt_Add").addClass("bt-Add-Int");
			$("#bt_Add-Curr").removeClass("bt-Add-Curr-Dom");
			$("#bt_Add-Curr").addClass("bt-Add-Curr-Int");
			$("#bt-SaveExit").removeClass("bt-SubmitToWorkflow-Dom");
			$("#bt-SaveExit").addClass("bt-SubmitToWorkflow-Int");
			$("#bt-Save").removeClass("bt-SubmitToWorkflow-Dom");
			$("#bt-Save").addClass("bt-SubmitToWorkflow-Int");
			$("#bt-SubmitToWorkflow").removeClass("bt-SubmitToWorkflow-Dom");
			$("#bt-SubmitToWorkflow").addClass("bt-SubmitToWorkflow-Int");
			
			var val = $('input#rd_Int:checked').val();    	
			var userId = $("select#userName option:selected").val();
			var siteId = $("select#siteName option:selected").val();
			populateApproverLevelData(siteId, userId, val); 
			defaultApproverList(siteId, userId, val);
			populateCancelledRequest(userId, val);
	    	showBuyTktFrmNonMATA();  
	    	
	    	var itineraryBlockHeight =  $("#itineraryBlock").height();
	        $('#approverBlock').css({"height": itineraryBlockHeight+"px"});
	        var defaultApproverDivHeight = $("#approverBlock").height()-$("#approverblkRow1").height()-$("#approverblkRow2").height()-$("#approverblkRow3").height()-$("#approverblkRow4").height()-20;
	        $('#defaultApproverDiv').css({"height": defaultApproverDivHeight+"px", "overflow-y": "auto", "overflow-x": "hidden"});
		
	        var depCity = document.getElementsByName("depCity");
	        var arrCity = document.getElementsByName("arrCity");
	        
	        for(var i = 0, len = depCity.length; i < len; i++) {
			      if((depCity[i].value != '' && depCity[i].value != '<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') || (arrCity[i].value != '' && arrCity[i].value != '<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>')) {			
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
	});
	
	  if($('input#rd_Dom').is(':checked')) {
	    	$('input#rd_Int').attr('checked', false);
	    	$('input#rd_Dom').val("D");
	    	var val = $('input#rd_Dom:checked').val(); 
	    	$("label#visaRequiredYes").addClass("disable");
		   	$("label#visaRequiredNo").addClass("disable");
		   	$("input#visaRequired").val("Visa Not Required");
			$("input#visaRequired").prop('disabled', true);
			$("input:radio#visaRequired_Y").attr('checked', false);
			$("input:radio#visaRequired_N").attr('checked', false);
			$("input:radio#visaRequired_Y").prop('disabled', true);
			$("input:radio#visaRequired_N").prop('disabled', true);
			
			$("label#emigrationRequiredYes").addClass("disable");
			$("label#emigrationRequiredNo").addClass("disable");
			$("label#emigrationRequiredNA").addClass("disable");
			$("input#emigrationRequired").val("Emigration Clearance Not Required");
			$("input#emigrationRequired").prop('disabled', true);
			$("input:radio#emigrationRequired_Y").attr('checked', false);
			$("input:radio#emigrationRequired_N").attr('checked', false);
			$("input:radio#emigrationRequired_NA").attr('checked', false);
			$("input:radio#emigrationRequired_Y").prop('disabled', true);
			$("input:radio#emigrationRequired_N").prop('disabled', true);
			$("input:radio#emigrationRequired_NA").prop('disabled', true);
			
			$("label#insuranceRequiredYes").addClass("disable");
		   	$("label#insuranceRequiredNo").addClass("disable");
		   	$("input#insuranceRequired").val("Insurance Not Required");
			$("input#insuranceRequired").prop('disabled', true);
			$("input:radio#insuranceRequired_Y").attr('checked', false);
			$("input:radio#insuranceRequired_N").attr('checked', false);
			$("input:radio#insuranceRequired_Y").prop('disabled', true);
			$("input:radio#insuranceRequired_N").prop('disabled', true);
			
			$('input:radio#accomodationRequired_N').attr('checked', true);			
			$("select#accomStayType").find('option').eq(0).prop('selected', true);		
			
		 if($('input:radio#accomodationRequired_Y').is(':checked')) {
	 	 	$("label#accomodationRequiredNo").removeClass("active");
	 		$("label#accomodationRequiredYes").addClass("active");
	 		$("input#accomodationRequired").val("Accommodation Required");
	 		$("tr#accomodationDetail").show();
	 		$("select#accomStayType").find('option').eq(1).prop('selected', true);
			$("select#accomCurrency").find('option').eq(1).prop('selected', true);
			$("select#accomCurrency").prop('disabled', false);
			$("input#accomPlace").prop('disabled', false);
			$("input#accomBudget").prop('disabled', false);
			$("input#checkInDate").prop('disabled', false);
			$("input#checkOutDate").prop('disabled', false);
			$("textarea#otherComment").prop('disabled', false);
			if(accomRemarkVal != "" && accomRemarkVal != null && accomRemarkVal != 'Accommodation Not Required') {
				$("textarea#otherComment").val(accomRemarkVal);
				$("textarea#otherComment").css('color', '#000000');
			} else {
				$("textarea#otherComment").val("Remarks");
				$("textarea#otherComment").css('color', '#7a7a7a');
			}
			
	     } else if($('input:radio#accomodationRequired_N').is(':checked')) {
	     	$("label#accomodationRequiredYes").removeClass("active");
	 	   	$("label#accomodationRequiredNo").addClass("active");
	 	   	$("input#accomodationRequired").val("Accommodation Not Required");
	 	   	$("tr#accomodationDetail").hide();
	 	    $("select#accomStayType").find('option').eq(0).prop('selected', true);
			$("select#accomCurrency").find('option').eq(1).prop('selected', true);
			$("select#accomCurrency").prop('disabled', true);
			$("input#accomPlace").prop('disabled', true);
			$("input#accomBudget").prop('disabled', true);
			$("input#checkInDate").prop('disabled', true);
			$("input#checkOutDate").prop('disabled', true);		
			$("textarea#otherComment").prop('disabled', false);
			$("textarea#otherComment").val("Accommodation Not Required");
			$("textarea#otherComment").css('color', '#000000');
	     }
		 
			 $("td.currencyDenomination").hide();
			 $("td.contingenciesRemark").attr('colspan', '12');
			 $("td.contingenciesRemark").css({'width': '100%'});
			 $("textarea#expRemarks").css({'width': '47.7%'});			 
			
			 $("tr#passportDetails").hide();			 
			 $("tr#identityDetails").show();	
			 
	    	 var userId = $("select#userName option:selected").val();
			 var siteId = $("select#siteName option:selected").val();
			 populateApproverLevelData(siteId, userId, val); 
			 defaultApproverList(siteId, userId, val);
			 populateCancelledRequest(userId, val);
		     showBuyTktFrmNonMATA();
		     
	    	var itineraryBlockHeight =  $("#itineraryBlock").height();
	        $('#approverBlock').css({"height": itineraryBlockHeight+"px"});
	        var defaultApproverDivHeight = $("#approverBlock").height()-$("#approverblkRow1").height()-$("#approverblkRow2").height()-$("#approverblkRow3").height()-$("#approverblkRow4").height()-20;
	        $('#defaultApproverDiv').css({"height": defaultApproverDivHeight+"px", "overflow-y": "auto", "overflow-x": "hidden"});
	    
	        domClickedFlag = true;
	        intClickedFlag = false;
		}	
	  
	}
}	
	
	// forex details expand/collapse click event
	$('td#forexDetailsBar').click(function() {		
		var collapseIcon = 'images/collapse-icon.png?buildstamp=2_0_0';
   		var expandIcon = 'images/expand-icon.png?buildstamp=2_0_0';   		
	   	if($("tr#forexDetailRow").hasClass("hide")) {
	   		$("td.exColBarIcon").find("img.fxDetImg").attr("src", collapseIcon);
	   		$("tr#forexDetailRow").removeClass("hide");
	   		$("tr#forexDetailRow").addClass("show");	   		
	   	} else if($("tr#forexDetailRow").hasClass("show")) {
	   		$("td.exColBarIcon").find("img.fxDetImg").attr("src", expandIcon);
	   		$("tr#forexDetailRow").removeClass("show");
	   		$("tr#forexDetailRow").addClass("hide");	   		
	   	}
	});
	
	// personal details expand/collapse click event
	$('td#personalDetailsBar').click(function() {		
		var collapseIcon = 'images/collapse-icon.png?buildstamp=2_0_0';
   		var expandIcon = 'images/expand-icon.png?buildstamp=2_0_0';   		
	   	if($("tr#personalDetailRow").hasClass("hide")) {
	   		$("td.exColBarIcon").find("img.perDetImg").attr("src", collapseIcon);
	   		$("tr#personalDetailRow").removeClass("hide");
	   		$("tr#personalDetailRow").addClass("show");	   		
	   	} else if($("tr#personalDetailRow").hasClass("show")) {
	   		$("td.exColBarIcon").find("img.perDetImg").attr("src", expandIcon);
	   		$("tr#personalDetailRow").removeClass("show");
	   		$("tr#personalDetailRow").addClass("hide");	   		
	   	}
	});
	
	// other details expand/collapse click event
	$('td#otherDetailsBar').click(function() {		
		var collapseIcon = 'images/collapse-icon.png?buildstamp=2_0_0';
   		var expandIcon = 'images/expand-icon.png?buildstamp=2_0_0';   		
	   	if($("tr#otherDetailRow").hasClass("hide")) {
	   		$("td.exColBarIcon").find("img.otrDetImg").attr("src", collapseIcon);
	   		$("tr#otherDetailRow").removeClass("hide");
	   		$("tr#otherDetailRow").addClass("show");	   		
	   	} else if($("tr#otherDetailRow").hasClass("show")) {
	   		$("td.exColBarIcon").find("img.otrDetImg").attr("src", expandIcon);
	   		$("tr#otherDetailRow").removeClass("show");
	   		$("tr#otherDetailRow").addClass("hide");	   		
	   	}
	});	
	
	var itineraryBlockHeight =  $("#itineraryBlock").height();
    $('#approverBlock').css({"height": itineraryBlockHeight+"px"});
    var defaultApproverDivHeight = $("#approverBlock").height()-$("#approverblkRow1").height()-$("#approverblkRow2").height()-$("#approverblkRow3").height()-$("#approverblkRow4").height()-20;
    $('#defaultApproverDiv').css({"height": defaultApproverDivHeight+"px", "overflow-y": "auto", "overflow-x": "hidden"});
});

function showForexDetailRow() {
	var collapseIcon = 'images/collapse-icon.png?buildstamp=2_0_0';
	if($("tr#forexDetailRow").hasClass("hide")) {
		$("td.exColBarIcon").find("img.fxDetImg").attr("src", collapseIcon);
		$("tr#forexDetailRow").removeClass("hide");
		$("tr#forexDetailRow").addClass("show");	   		
	}
}

function showPersonalDetailRow() {
	var collapseIcon = 'images/collapse-icon.png?buildstamp=2_0_0';
	if($("tr#personalDetailRow").hasClass("hide")) {
		$("td.exColBarIcon").find("img.perDetImg").attr("src", collapseIcon);
		$("tr#personalDetailRow").removeClass("hide");
		$("tr#personalDetailRow").addClass("show");	   		
	}
}


function showBuyTktFrmNonMATA() {
	var showBuyTktFrmNonMATA = false;		
	
	var matapricecomp = "";		
	if($('input#rd_Dom').is(':checked')) {		
		matapricecomp = $("#matapricecompdom").val();			
	} else if($('input#rd_Int').is(':checked')) {		
		matapricecomp = $("#matapricecompint").val();		
	}
	
	var matapricecomp1 = matapricecomp;
	var matapricecomp2 = "y";
	
	if(matapricecomp1.toLowerCase() === matapricecomp2.toLowerCase()) {
		showBuyTktFrmNonMATA = true;
	} else {
		showBuyTktFrmNonMATA = false;
	}
	
	
	if(showBuyTktFrmNonMATA) {
		$("tr#ticketsDetailRow").removeClass("hide");
		$("tr#ticketsDetailRow").addClass("show");
	} else {
		$("tr#ticketsDetailRow").removeClass("show");
		$("tr#ticketsDetailRow").addClass("hide");		
	}	
}

function uploadAttachment() {
	var travelIdVal = '<%=strTravelId%>';
	var travelTypeVal = $('input:radio[name=travelType]:checked').val();
	var attachmentUrl = "requisitionAttachment.jsp?purchaseReqID="+travelIdVal+"&err=0&travel_type="+travelTypeVal+"&whichPage=T_QuickTravel_Detail.jsp&targetFrame=no";
	
	if(travelIdVal !=null && travelIdVal != "" && travelIdVal != "new") {
		var win = MM_openBrWindow(attachmentUrl,'Attachments','scrollbars=yes,resizable=yes,width=775,height=550');
	} else {
		alert("Please save the request before upload any supporting document(s).");
	}
}


// Calculate day difference between two date
function diffDays(date1, date2) {	
	var d1 = date1.split('/');
	var convertedDate1 = new Date(parseInt(d1[2], 10),     // year
            parseInt(d1[1], 10) - 1, // month, starts with 0
            parseInt(d1[0], 10));    // day

    var d2 = date2.split('/');
	var convertedDate2 = new Date(parseInt(d2[2], 10),     // year
            parseInt(d2[1], 10) - 1, // month, starts with 0
            parseInt(d2[0], 10));    // day
            
  var ndays;
  var tv1 = convertedDate1.valueOf();  // msec since 1970
  var tv2 = convertedDate2.valueOf();
  ndays = (tv2 - tv1) / 1000 / 86400;
  ndays = Math.round(ndays - 0.5);
  return ndays+1;
}

// select travel mode event [populate travel class]
function selectTravelMode(x) {  
	var options = "";
	var master = $(x).parents("table#tblItinerary tbody tr.itineraryDataRow");
	var departMode = $(x).val();
	var departClass = master.find("#departClassSB");
	var prefSeat = master.find("#seatPreffredSB");
	var prefAirline = master.find("#nameOfAirlineTB");
	var reqpage="quickTravelReqClassName";	  	
 	var Params='<%="language1="+strsesLanguage+"&suserRole="+SuserRole+"&userId="+Suser_id%>';
    var urlParams=Params+"&reqpage="+reqpage+"&departMode="+departMode;
    
    if(departMode == "1") {
    	$(prefAirline).attr('value', '');
    	$(prefAirline).attr('placeholder', '<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>');
    	$(prefAirline).attr('title', '<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>');
    } else if(departMode == "2") {
    	$(prefAirline).attr('value', '');
    	$(prefAirline).attr('placeholder', '<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>');
    	$(prefAirline).attr('title', '<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>');
    } else if(departMode == "3") {
    	$(prefAirline).attr('value', '');
    	$(prefAirline).attr('placeholder', '<%=dbLabelBean.getLabel("label.global.preferredcab",strsesLanguage)%>');
    	$(prefAirline).attr('title', '<%=dbLabelBean.getLabel("label.global.preferredcab",strsesLanguage)%>');
    } else if(departMode == "4") {
    	$(prefAirline).attr('value', '');
    	$(prefAirline).attr('placeholder', '<%=dbLabelBean.getLabel("label.global.preferredbus",strsesLanguage)%>');
    	$(prefAirline).attr('title', '<%=dbLabelBean.getLabel("label.global.preferredbus",strsesLanguage)%>');
    } else if(departMode == "5") {
    	$(prefAirline).attr('value', '');
    	$(prefAirline).attr('placeholder', '<%=dbLabelBean.getLabel("label.global.preferredcar",strsesLanguage)%>');
    	$(prefAirline).attr('title', '<%=dbLabelBean.getLabel("label.global.preferredcar",strsesLanguage)%>');
    } else if(departMode == "6") {
    	$(prefAirline).attr('value', '');
    	$(prefAirline).attr('placeholder', '<%=dbLabelBean.getLabel("label.global.preferredvan",strsesLanguage)%>');
    	$(prefAirline).attr('title', '<%=dbLabelBean.getLabel("label.global.preferredvan",strsesLanguage)%>');
    }
    
  //set placeholder on page load
	setPlaceholder();
    
	$.ajax({
           type: "get",
           url: "QuickTravelRequestServlet",
           data: urlParams,
           dataType : 'json',
           async: false,
           cache: false,
           success: function(result) {        	   
		if(result!=null) {				
			$(departClass).html('');
			$(departClass).get(0).options.add(new Option());
			$(departClass).html(result.trvClassHtml);
			
			$(prefSeat).html('');
			$(prefSeat).get(0).options.add(new Option());
			$(prefSeat).html(result.prefSeatHtml);
		}				
       }
   });	
}
	
// populate travel class on Travel Type button click
function populateTravelClass(departMode) {
	var reqpage="quickTravelReqClassName";	  	
 	var Params='<%="language1="+strsesLanguage+"&suserRole="+SuserRole+"&userId="+Suser_id%>';
    var urlParams=Params+"&reqpage="+reqpage+"&departMode="+departMode;
	$.ajax({
           type: "get",
           url: "QuickTravelRequestServlet",
           data: urlParams,
           dataType : 'json',
           cache: false,
           success: function(result) {
			if(result!=null) {
				$('table#tblItinerary tbody > tr.itineraryDataRow').each(function() {
					var departClass = $(this).find(".comboDepartClass");
					var prefSeat = $(this).find(".comboPrefSeat");
					
					$(departClass).html('');
					$(departClass).get(0).options.add(new Option());
		            $(departClass).html(result.trvClassHtml);
		            
		            $(prefSeat).html('');
					$(prefSeat).get(0).options.add(new Option());
		            $(prefSeat).html(result.prefSeatHtml);
				});
			}				
       }
   });
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

function checkDateDiff(obj) {			
	var nDays = 0;
	var depDateVal = "";
	var retDateVal = "";
	var depDateCheck = "<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>";
	var tblRowCount = $('#tblItinerary tbody tr.itineraryDataRow').length;
	depDateVal = $("#tblItinerary tbody tr.itineraryDataRow:first").find("td.date").find("input").val(); 
	
	if(tblRowCount == 2) {		 
		retDateVal = $("#tblItinerary tbody tr.itineraryDataRow:last").find("td.date").find("input").val(); 				
	} else if(tblRowCount > 2) {
		$('table#tblItinerary tbody > tr.itineraryDataRow').not(':first').each(function() { 					
			var depDt = $(this).find('#depDateTB').val(); 					
			if(depDt != '' && depDt != '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
				retDateVal = depDt;
			} 
		});			
	}
	
	if(depDateVal == "" || depDateVal == null || depDateVal == depDateCheck) {	
	    alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>');
	    obj.value = "0";
		$("#tblItinerary tbody tr.itineraryDataRow:first").find("td.date").find("input").focus();				
	} else if((depDateVal != "" && depDateVal != null  && depDateVal != depDateCheck) && 
		(retDateVal != "" && retDateVal != null  && retDateVal != depDateCheck)) {
	     nDays = diffDays(depDateVal, retDateVal);			     
	     CheckDiff(obj, nDays);			     
	}
}

function CheckDiff(obj, nDays) {
	var objval = obj.value;
	if(objval > nDays) {
		alert('<%=dbLabelBean.getLabel("alert.global.numberoftourdayscannotbemorethanjourneydays",strsesLanguage)%>');
	   obj.value = "0";
	   obj.focus();
	   calculate(obj);
	   check1();
	}
}

function showDiff() {
	var YtmBud = document.frm.YtmBud.value;
	var YtmAct = document.frm.YtmAct.value;
	if(isNaN(parseFloat(YtmBud) - parseFloat(YtmAct)))
		document.frm.AvailBud.value = '0.0';
	else
		document.frm.AvailBud.value = parseFloat(YtmBud) - parseFloat(YtmAct); 
}

$("select#siteName").live("change", function() {
	var val = "";
	var siteId = $("select#siteName option:selected").val();
	var ssflage = '<%=ssflage%>';
	var suserId = '<%=Suser_id%>';
	var appLvl3flg = '<%=strAppLvl3flg%>';
	var suserRoleOther = '<%=SuserRoleOther%>';
	
	if(siteId != null && siteId == "S") {
		siteId = '0';
	}
	
	var reqpage="quickTravelReqTravellers";	  	
 	var Params='<%="language1="+strsesLanguage+"&suserRole="+SuserRole%>';
    var urlParams=Params+"&reqpage="+reqpage+"&siteId="+siteId+"&ssflage="+ssflage+"&suserId="+suserId+"&appLvl3flg="+appLvl3flg+"&suserRoleOther="+suserRoleOther;
    $.ajax({
           type: "get",
           url: "QuickTravelRequestServlet",
           data: urlParams,
           dataType : 'json',
           success: function(result) {
           	if(result!=null) {					
				$("#userName").html('');
				$("#userName").get(0).options.add(new Option());
             	$("#userName").html(result.travellerHtml);
			}				
       	}
      });	
	
	clearPersonalDetails();
	
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

// populate travel class on Travel Type button click
$("select#userName").live("change", function() {
	var val = "";
	var userId = $("select#userName option:selected").val();
	var siteId = $("select#siteName option:selected").val();
	
	 if($('input#rd_Dom').is(':checked')) {
	    	$('input#rd_Int').attr('checked', false);
	    	$('input#rd_Dom').val("D");
	    	val = $('input#rd_Dom:checked').val();      	
	    } else if($('input#rd_Int').is(':checked')) {
	    	$('input#rd_Dom').attr('checked', false);
	    	$('input#rd_Int').val("I");
	    	val = $('input#rd_Int:checked').val();    	    		
	    }
	    populateApproverLevelData(siteId, userId, val); 
		defaultApproverList(siteId, userId, val);
		populateCancelledRequest(userId, val);
		
	var reqpage="quickTravelReqPersonalDetail";	  	
 	var Params='<%="language1="+strsesLanguage+"&suserRole="+SuserRole%>';
    var urlParams=Params+"&reqpage="+reqpage+"&userId="+userId;
	$.ajax({
           type: "get",
           url: "QuickTravelRequestServlet",
           data: urlParams,
           dataType : 'json',
           success: function(result) {
			if(result!=null) {
				clearPersonalDetails();
				
				$("#travelerName").val(result.FULLNAME);
				$("#designation").val(result.DESIGNATION);
				$("#passportContactNo").val(result.CONTACT_NUMBER);
				$("#dateOfBirth").val(result.DOB);
				$("#passportAddress").val(result.ADDRESS);
				$("#eMail").val(result.EMAIL);
				$("#currentAddress").val(result.CURRENT_ADDRESS);
				$("#passportNo").val(result.PASSPORT_NO);
				$("#nationality").val(result.NATIONALITY);
				$("#passportIssuePlace").val(result.PLACE_ISSUE);
				$("#issueDate").val(result.DATE_ISSUE);
				$("#expiryDate").val(result.EXPIRY_DATE);
				$("#airLineName").val(result.AIRLINE_NAME1);
				$("#airLineName1").val(result.AIRLINE_NAME2);
				$("#airLineName2").val(result.AIRLINE_NAME3);
				$("#passportFlightNo").val(result.AIRLINE_NO1);
				$("#passportFlightNo1").val(result.AIRLINE_NO2);
				$("#passportFlightNo2").val(result.AIRLINE_NO3);
				$("#nominee").val(result.NOMINEE);
				$("#relation").val(result.RELATION);
				
				var sexVal = result.SEX;				
				if(sexVal != null && sexVal == "1") {					 
					$('input:radio#femaleRd').prop("checked", false);
					$('input:radio#maleRd').prop("checked", true);
					$('input#sex').val(sexVal);
				} else if(sexVal != null && sexVal == "2") {					
					$('input:radio#maleRd').prop("checked", false);
					$('input:radio#femaleRd').prop("checked", true);
					$('input#sex').val(sexVal);
				 }
	
				emigrationRequiredVal = result.ECNR;
				if(emigrationRequiredVal == 3) {
					$("td.ecnrTd").removeClass("show");
					$("td.ecnrTd").addClass("hide");															
					$('input:radio#emigrationRequired_NA').prop("checked", true);
				   	$('input:radio#emigrationRequired_NA').val("3");
				   	$("input#emigrationRequired").val("Emigration Clearance Not Applicable");
				} else if(emigrationRequiredVal == 1) {
					$("td.ecnrTd").removeClass("hide");
					$("td.ecnrTd").addClass("show");
					$("label#emigrationRequiredNo").removeClass("active");
					$("label#emigrationRequiredNA").removeClass("active");
					$("label#emigrationRequiredYes").addClass("active");
					$('input:radio#emigrationRequired_N').prop("checked", false);
					$('input:radio#emigrationRequired_NA').prop("checked", false);
					$('input:radio#emigrationRequired_Y').prop("checked", true);
					$('input:radio#emigrationRequired_Y').val("1");
					$("input#emigrationRequired").val("Emigration Clearance Required");		
				} else if(emigrationRequiredVal == 2) {
					$("td.ecnrTd").removeClass("hide");
					$("td.ecnrTd").addClass("show");
					$("label#emigrationRequiredYes").removeClass("active");
					$("label#emigrationRequiredNA").removeClass("active");
					$("label#emigrationRequiredNo").addClass("active");
					$('input:radio#emigrationRequired_Y').prop("checked", false);
					$('input:radio#emigrationRequired_NA').prop("checked", false);
					$('input:radio#emigrationRequired_N').prop("checked", true);
					$('input:radio#emigrationRequired_N').val("2");
					$("input#emigrationRequired").val("Emigration Clearance Not Required");
				} else {
					$("td.ecnrTd").removeClass("hide");
					$("td.ecnrTd").addClass("show");
					$("label#emigrationRequiredYes").removeClass("active");
					$("label#emigrationRequiredNA").removeClass("active");
				   	$("label#emigrationRequiredNo").addClass("active");
				   	$('input:radio#emigrationRequired_Y').prop("checked", false);
					$('input:radio#emigrationRequired_NA').prop("checked", false);
				   	$('input:radio#emigrationRequired_N').prop("checked", true);
				   	$('input:radio#emigrationRequired_N').val("2");
				   	$("input#emigrationRequired").val("Emigration Clearance Not Required");
				}			
	
				var identityProof = result.IDENTITY_PROOF;
				$("select#identityProof").val(identityProof);
				$("#identityNo").val(result.IDENTITY_PROOF_NO);
	
				$("select#identityProof").change(function() {
						if($(this).val() == identityProof) {
							$("input#identityNo").val(result.IDENTITY_PROOF_NO);
						} else {
							$("input#identityNo").val('');	
						}
					});
			 	}				
        	}
     });
});

// Populate User for Billing Unit
$("select#billingSMGSite").live("change", function() {
	var siteIdBillSMGUser = $("select#billingSMGSite option:selected").val();
	var userId = $("select#userName option:selected").val();
	
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

//Populate Cancelled Travel Request(s)
function populateCancelledRequest(userId, travelTypeRd) {
	
	var reqpage="quickTravelReqCancelledRequest";	
	var groupReqFlag = "N";
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
	var userId = $("select#userName option:selected").val();
	
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

// Itinerary Detail table Start
$("#bt_Add").live("click",function() {	
	
	var master = $("table#tblItinerary");		
	// Get a new row based on the prototype row
	var prot = master.find(".prototypeRowItinerary").clone();
	
	prot.find('#depCityTB').attr('name', 'depCity');
	prot.find('#arrCityTB').attr('name', 'arrCity');
	prot.find('#depDateTB').attr('name', 'depDate');
	prot.find('#preferTimeSB').attr('name', 'preferTime');
	prot.find('#departModeSB').attr('name', 'departMode');
	prot.find('#departClassSB').attr('name', 'departClass');	
	prot.find('#nameOfAirlineTB').attr('name', 'nameOfAirline');
	prot.find('#seatPreffredSB').attr('name', 'seatPreffred');
	prot.attr("class", ""); 
	prot.addClass("itineraryDataRow");
	$('.innerRowItinerary').before(prot);
	
	var rowCount = $("table#tblItinerary tbody tr.itineraryDataRow").length;
	var className = $('tr#intJrnyTitleRow').attr('class');	
	if(rowCount > 2 && $("tr#intJrnyTitleRow").hasClass("hide")){
		$("tr#intJrnyTitleRow").removeClass("hide");
		$("tr#intJrnyTitleRow").addClass("show");
	}
	
	//set placeholder on page load
	setPlaceholder();
	
	if($('input#rd_Int').is(':checked')) {    	
		  $('.departMode').each(function() {
			$(this).find('option').eq(0).prop('selected', true);
			$(this).prop('disabled', true);				
		  });		  
	  }
	
	$("input[name='tourDays']").val("0");
    $("input[name='tourDays2']").val("0");
    $("input[name='totalForex']").val("0.00");
	$("input[name='totalInr']").val("0.00");
	$("input[name='grandTotalForex']").val("0.00");
	$("input[name='grandTotalForexUSD']").val("0.00");
    
    var itineraryBlockHeight =  $("#itineraryBlock").height();
    $('#approverBlock').css({"height": itineraryBlockHeight+"px"});
    var defaultApproverDivHeight = $("#approverBlock").height()-$("#approverblkRow1").height()-$("#approverblkRow2").height()-$("#approverblkRow3").height()-$("#approverblkRow4").height()-20;
    $('#defaultApproverDiv').css({"height": defaultApproverDivHeight+"px", "overflow-y": "auto", "overflow-x": "hidden"});
});

// Remove button functionality
$("table#tblItinerary #bt-Del-ItInr").live("click", function() {
	var rowCount = $("table#tblItinerary tbody tr.itineraryDataRow").length;
	$(this).parents("table#tblItinerary tr").remove();
	
	if(rowCount == 3 && $("tr#intJrnyTitleRow").hasClass("show")){
		$("tr#intJrnyTitleRow").removeClass("show");
		$("tr#intJrnyTitleRow").addClass("hide");
	}
	 
	 var itineraryBlockHeight =  $("#itineraryBlock").height();
	 $('#approverBlock').css({"height": itineraryBlockHeight+"px"});
	 var defaultApproverDivHeight = $("#approverBlock").height()-$("#approverblkRow1").height()-$("#approverblkRow2").height()-$("#approverblkRow3").height()-$("#approverblkRow4").height()-20;
	 $('#defaultApproverDiv').css({"height": defaultApproverDivHeight+"px", "overflow-y": "auto", "overflow-x": "hidden"});
		
});
// Itinerary Detail table End

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
				alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
	           }
	     });
	} else {
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
	var nDays = 0;
	var depDateVal = "";
	var retDateVal = "";
	var depDateCheck = "<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>";
	var tblRowCount = $('#tblItinerary tbody tr.itineraryDataRow').length;
	depDateVal = $("#tblItinerary tbody tr.itineraryDataRow:first").find("td.date").find("input").val(); 
	if(tblRowCount == 2) {		 
		retDateVal = $("#tblItinerary tbody tr.itineraryDataRow:last").find("td.date").find("input").val();  
		if((depDateVal != "" && depDateVal != null  && depDateVal != depDateCheck) && 
				(retDateVal != "" && retDateVal != null  && retDateVal != depDateCheck)) {
			nDays = diffDays(depDateVal, retDateVal);			
		} else {
			nDays = 0;			
		}		
	} else if(tblRowCount > 2) {
		$('table#tblItinerary tbody > tr.itineraryDataRow').not(':first').each(function() { 					
			var depDt = $(this).find('#depDateTB').val(); 					
			if(depDt != '' && depDt != '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
				retDateVal = depDt;
			} 
		});		
		if((depDateVal != "" && depDateVal != null  && depDateVal != depDateCheck) && 
				(retDateVal != "" && retDateVal != null  && retDateVal != depDateCheck)) {
			nDays = diffDays(depDateVal, retDateVal);			
		} else {
			nDays = 0;			
		}
	}
	var hoteltd=fun_calculate_HotelTourDays();
	var dailytd=fun_calculate_DailyTourDays();
	var tourdays = nDays;
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
	             if(tourdays!=0) {
	            	   $('#grandtotalforexusd').val((res/tourdays).toFixed(2));
		            } else if(hoteltd!=undefined && hoteltd!=0) {
						$('#grandtotalforexusd').val((res/hoteltd).toFixed(2));
					} else if(dailytd!=undefined && dailytd!=0) {
		           		$('#grandtotalforexusd').val((res/dailytd).toFixed(2));
					} else {
						$('#grandtotalforexusd').val(res);
					}					            				             
	            }
           },
		   error: function() {
			alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
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
				alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
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

function test2(obj, length, str) {	
	
	if(obj.name == 'reasonForSkip') {		
		 upToTwoHyphen(obj);
	}	
	if(obj.name == 'reasonForTravel') {
		 upToTwoHyphen(obj);
	}	
	if(obj.name == 'visaComment') {
		 upToTwoHyphen(obj);
	}
	if(obj.name =='insuranceComment') {
		 upToTwoHyphen(obj);
	}
	if(obj.name == 'otherComment') {
		 upToTwoHyphen(obj);
	}	
	if(obj.name == 'budget') {
		zeroChecking(obj);
	}	
	if(obj.name == 'passport_No') {
		 upToTwoHyphen(obj);
	}
	if(obj.name == 'nationality') {
		 upToTwoHyphen(obj);
	}
	if(obj.name == 'passport_address') {
		 upToTwoHyphen(obj);
	}	
	if(obj.name == 'current_address') {
		 upToTwoHyphen(obj);
	}	
	if(obj.name == 'passport_Contact_No') {
		 upToTwoHyphen(obj);
	}	
	if(obj.name == 'expRemarks') {
		upToTwoHyphen(obj);
	}
	if(obj.name == 'cashBreakupRemarks') {
		upToTwoHyphen(obj);
	}
	if(obj.name == 'budgetRemarks') {
		upToTwoHyphen(obj);
	}
	if(obj.name == 'pricingRemarks') {
		upToTwoHyphen(obj);
	}
			
		charactercheck(obj,str);
		limitlength(obj, length);	
		spaceChecking(obj);	
}

function test3(obj, length, str) {	
	
	    charactercheck(obj,str);
		limitlength(obj, length);	
		spaceChecking(obj);	
}


function clearPersonalDetails() {
	$("#travelerName").val('');
	$("#designation").val('');
	$("#passportContactNo").val('');
	$("#dateOfBirth").val('');
	$("#passportAddress").val('');
	$("#eMail").val('');
	$("#currentAddress").val('');
	$("#identityNo").val('');
	$("#passportNo").val('');
	$("#nationality").val('');
	$("#passportIssuePlace").val('');
	$("#issueDate").val('');
	$("#expiryDate").val('');
	$("#airLineName").val('');
	$("#airLineName1").val('');
	$("#airLineName2").val('');
	$("#passportFlightNo").val('');
	$("#passportFlightNo1").val('');
	$("#passportFlightNo2").val('');
	$("#nominee").val('');
	$("#relation").val('');
	$("#emigrationRequired").val('');
	$("#sex").val('');	
}

function setPlaceholder() {	
	if($.browser.msie && $.browser.version <= 9) {
    	$('[placeholder]').focus(function() {
            var input = $(this);
            if (input.val() == input.attr('placeholder')) {
                input.val('');
                input.css('color', '#000000');
            }
        });
        
        $('[placeholder]').blur(function() {
        	var input = $(this);	        	          
            if (input.val() == '' || input.val() == input.attr('placeholder')) {	            	
                input.css('color', '#7a7a7a');
                input.val(input.attr('placeholder'));
            	}	           
        }).blur();        
        
        $('[placeholder]').parents('form').submit(function() {
            $(this).find('[placeholder]').each(function() {
                var input = $(this);
                if (input.val() == input.attr('placeholder')) {
                    input.val('');
                }
            });
        });
    }	    
}

// Declaring valid date character, minimum year and maximum year
var dtCh= "/";
var minYear=1900;
var maxYear=2100;

function isInteger(s) {
	var i;
    for (i = 0; i < s.length; i++) {   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag) {
	var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++) {   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary (year) {
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}

function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31;
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30;}
		if (i==2) {this[i] = 29;}
   } 
   return this;
}

function isDate(dtStr) {
	var daysInMonth = DaysArray(12);
	var pos1=dtStr.indexOf(dtCh);
	var pos2=dtStr.indexOf(dtCh,pos1+1);
	var strDay=dtStr.substring(0,pos1);
	var strMonth=dtStr.substring(pos1+1,pos2);
	var strYear=dtStr.substring(pos2+1);
	strYr=strYear;
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1);
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1);
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1);
	}
	month=parseInt(strMonth);
	day=parseInt(strDay);
	year=parseInt(strYr);
	if (pos1==-1 || pos2==-1) {
		alert("The date format should be : dd/mm/yyyy");
		return false;
	}
	if (strMonth.length<1 || month<1 || month>12) {
		alert("Please enter a valid month");
		return false;
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]) {
		alert("Please enter a valid day");
		return false;
	}
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear) {
		alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear);
		return false;
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false) {
		alert("Please enter a valid date");
		return false;
	}
return true;
}

function isDateValid(dtStr) {
	var daysInMonth = DaysArray(12);
	var pos1=dtStr.indexOf(dtCh);
	var pos2=dtStr.indexOf(dtCh,pos1+1);
	var strDay=dtStr.substring(0,pos1);
	var strMonth=dtStr.substring(pos1+1,pos2);
	var strYear=dtStr.substring(pos2+1);
	strYr=strYear;
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1);
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1);
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1);
	}
	month=parseInt(strMonth);
	day=parseInt(strDay);
	year=parseInt(strYr);
	if (pos1==-1 || pos2==-1) {
		return false;
	}
	if (strMonth.length<1 || month<1 || month>12) {
		return false;
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]) {
		return false;
	}
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear) {
		return false;
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false) {
		return false;
	}
return true;
}

// Checking the date of departure and arrival date from the current date(second date should not be the smalle from the first date
function validateDate(form1,firstDate,secondDate,firstDateName,secondDateName,message1,message2) {
	//Second date should be equal or greater from the first date
	//get today date info
	var todayDate=firstDate;                //today date
	var dDate=secondDate;
	
	var d=todayDate.substr(6,4);
	var year=parseInt(d,10);

	var a =todayDate.substr(3,2);
	var month=parseInt(a,10);

	var c =todayDate.substr(0,2);
	var day=parseInt(c,10);

    //get Reaching Date at Destination information
	var f=dDate.substr(6,4);
	var year1=parseInt(f,10);

	var b=dDate.substr(3,2);
	var month1=parseInt(b,10);

	var h=dDate.substr(0,2);
	var day1=parseInt(h,10);
	
	if(year>year1) 	{
		 alert(message1);
		 secondDateName.value="";		
		 return false;
	}//end of if
	
	if((year==year1)&&(month>month1)) {
		 alert(message1);
		 secondDateName.value="";		
		 return false;
	}
	
	if((year==year1)&&(month==month1)&&(day>day1)) {		
		 alert(message1);
		 secondDateName.value="";
		 return false;
	}//end of elseif
	
	return true;
}


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
		rowCount = $("div#defaultApproverDiv").find('table#defaultApprListTbl tr td table.formborder tr').length;
		if(rowCount > 2) {
			document.getElementById("bt-SaveExit").disabled=false;
			document.getElementById("bt-Save").disabled=false;
			document.getElementById("bt-SubmitToWorkflow").disabled=false;
			
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
							alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
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
						alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
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

// check TES Request Count
function checkTESRequestCount() {
	var var_travellerid = $("select#userName option:selected").val();
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
			alert('Error...');
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
					showForexDetailRow();
					cur.focus();
					flag=false;
					return false;
				}
				if(a.val()!= undefined && $.trim(a.val())=='') {
					alert('<%=dbLabelBean.getLabel("alert.global.enter0ifnotrequiredinexpenditureperday",strsesLanguage)%>');
					showForexDetailRow();
					a.focus();
					flag=false; 
					return false;
				}
				if(b.val()!= undefined && $.trim(b.val())=='') {
					alert('<%=dbLabelBean.getLabel("alert.global.enter0ifnotrequiredintotaltourdays",strsesLanguage)%>');
					showForexDetailRow();
					b.focus();
					flag=false;
					return false;
				}
				if(c.val()!= undefined && $.trim(c.val())=='') {
					alert('<%=dbLabelBean.getLabel("alert.global.enter0ifnotrequiredinexpenditureperday",strsesLanguage)%>');
					showForexDetailRow();
					c.focus();
					flag=false;
					return false;
				}
				if(d.val()!= undefined && $.trim(d.val())=='') {
					alert('<%=dbLabelBean.getLabel("alert.global.enter0ifnotrequiredintotaltourdays",strsesLanguage)%>');
					showForexDetailRow();
					d.focus();
					flag=false;
					return false;
				}
				if(e.val()!= undefined && cont1!='' && cont1!='0') {
					if($("textarea#expRemarks").val()==contingenciesLabel || $("textarea#expRemarks").val()=='') {
						alert('<%=dbLabelBean.getLabel("alert.global.remarksforcontingenciesorotherexpenditure",strsesLanguage)%>');
						showForexDetailRow();
						$("textarea#expRemarks").focus();
						flag=false;
						return false;
					}
				} 				
				if(f.val()!= undefined && cont2!='' && cont2!='0') {
					if($("textarea#expRemarks").val()==contingenciesLabel || $("textarea#expRemarks").val()=='') {
						alert('<%=dbLabelBean.getLabel("alert.global.remarksforcontingenciesorotherexpenditure",strsesLanguage)%>');
						showForexDetailRow();
						$("textarea#expRemarks").focus();
						flag=false;
						return false;
					}
				} 				
				if(x.val()!=undefined && $.trim(x.val())=='') {
					alert('<%=dbLabelBean.getLabel("alert.createrequest.exchangeratecannotbeblank",strsesLanguage)%>');
					showForexDetailRow();
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

function checkData(f1, actionFlag)  { 
	f1.whatAction.value=actionFlag;	
	var todayDate  =  f1.todayDate.value;  
	var rowCount = $("table#tblItinerary tbody tr.itineraryDataRow").length;
	
	var depCity = document.getElementsByName("depCity");
    var arrCity = document.getElementsByName("arrCity");
    var depDate = document.getElementsByName("depDate");
    var nameOfAirline = document.getElementsByName("nameOfAirline");
        
    var expCurrency = document.getElementById("frmId").elements.namedItem("expCurrency"); //document.frm.elements["expCurrency"];
    var tourDays1 = document.getElementById("frmId").elements.namedItem("tourDays"); //document.frm.elements["tourDays"];
	var tourDays2 = document.getElementById("frmId").elements.namedItem("tourDays2"); //document.frm.elements["tourDays2"];
	var entitlement1 = document.getElementById("frmId").elements.namedItem("entitlement"); //document.frm.elements["entitlement"];
	var entitlement2 = document.getElementById("frmId").elements.namedItem("entitlement2"); //document.frm.elements["entitlement2"];	
	
	if(f1.site.value == 'S' || f1.site.value == '' || f1.site.value == '-1') {
       alert('<%=dbLabelBean.getLabel("alert.global.unitname",strsesLanguage)%>');
	   f1.site.focus();
	   return false;  
	}	
	if(f1.userName.value == 'S' || f1.userName.value == '' || f1.userName.value == '-1') {
       alert('<%=dbLabelBean.getLabel("alert.global.travellername",strsesLanguage)%>');
	   f1.userName.focus();
	   return false;  
	}
	if(actionFlag == "saveProceed") {		
		if(f1.meal.value == '0' || f1.meal.value == '' || f1.meal.value == '-1') {
		       alert('<%=dbLabelBean.getLabel("alert.createrequest.pleaseselectmealpreference",strsesLanguage)%>');
			   f1.meal.focus();
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
	}
	if(depCity[0].value=='' || depCity[0].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
		alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
		depCity[0].focus();
		return false;
	}
	if(arrCity[0].value=='' || arrCity[0].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
		alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
		arrCity[0].focus();
		return false;
	}
    if(depDate[0].value=='' || depDate[0].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
		alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
		depDate[0].focus();
		return false;
	}     
    if(nameOfAirline[0].value=='' || nameOfAirline[0].value=='<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>') {
		alert('<%=dbLabelBean.getLabel("alert.global.preferredairline",strsesLanguage)%>'); 
		nameOfAirline[0].focus();
		return false;
	} else if(nameOfAirline[0].value=='' || nameOfAirline[0].value=='<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>') {
		alert('<%=dbLabelBean.getLabel("alert.global.preferredtrain",strsesLanguage)%>'); 
		nameOfAirline[0].focus();
		return false;
	} else if(nameOfAirline[0].value=='' || nameOfAirline[0].value=='<%=dbLabelBean.getLabel("label.global.preferredcab",strsesLanguage)%>') {
		alert('<%=dbLabelBean.getLabel("alert.global.preferredcab",strsesLanguage)%>'); 
		nameOfAirline[0].focus();
		return false;
	} else if(nameOfAirline[0].value=='' || nameOfAirline[0].value=='<%=dbLabelBean.getLabel("label.global.preferredbus",strsesLanguage)%>') {
		alert('<%=dbLabelBean.getLabel("alert.global.preferredbus",strsesLanguage)%>'); 
		nameOfAirline[0].focus();
		return false;
	} else if(nameOfAirline[0].value=='' || nameOfAirline[0].value=='<%=dbLabelBean.getLabel("label.global.preferredcar",strsesLanguage)%>') {
		alert('<%=dbLabelBean.getLabel("alert.global.preferredcar",strsesLanguage)%>'); 
		nameOfAirline[0].focus();
		return false;
	} else if(nameOfAirline[0].value=='' || nameOfAirline[0].value=='<%=dbLabelBean.getLabel("label.global.preferredvan",strsesLanguage)%>') {
		alert('<%=dbLabelBean.getLabel("alert.global.preferredvan",strsesLanguage)%>'); 
		nameOfAirline[0].focus();
		return false;
	}     
    if (isDate(depDate[0].value)==false) {
    	depDate[0].focus();
		return false;
	}    
    var flag = validateDate(f1,todayDate,depDate[0].value,f1.todayDate,depDate[0].value,'<%=dbLabelBean.getLabel("alert.global.departuredateoffwdjourneynotsmallerthantodaydate",strsesLanguage)%>','no');
    if(flag == false) {
    	depDate[0].focus();
    	return flag;
    }  
 	
 	var budValidations = '<%=strSHOW_BUD_INPUT%>';
	var budValidations1 = budValidations;
	var budValidations2 = "Y";
 	
 	if(budValidations1.toLowerCase() === budValidations2.toLowerCase()) { 	
	 	var YtmBud = document.getElementById('YtmBud').value;
		var YtmAct = document.getElementById('YtmAct').value;
		var AvailBud = document.getElementById('AvailBud').value;
		var EstExp = document.getElementById('EstExp').value;		
		var budgetRemarks = document.getElementById('budgetRemarks').value;
		
		var YtmBudLabel = '<%=dbLabelBean.getLabel("label.global.ytmbudget",strsesLanguage)%>';
		var YtmActLabel = '<%=dbLabelBean.getLabel("label.global.ytdactual",strsesLanguage)%>';
		var AvailBudLabel = '<%=dbLabelBean.getLabel("label.createrequest.availablebudget",strsesLanguage)%>';
		var EstExpLabel = '<%=dbLabelBean.getLabel("label.global.estimatedexpenditure",strsesLanguage)%>';	
		var budgetRemarksLabel = '<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>';		
 	}
		
	if(actionFlag == "saveProceed") {		
		
		if(rowCount > 1) {
		     for (var i = 1, len = depCity.length; i < len; i++) {
		    	 if(i != (rowCount-1)) {
		        	if(depCity[i].value=='' || depCity[i].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
		        		alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');        		
		        		depCity[i].focus();
		        		return false;
		        	}

		        	if(arrCity[i].value=='' || arrCity[i].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>')	{
		        		alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
		        		arrCity[i].focus();
		        		return false;
		        	}

		            if(depDate[i].value=='' || depDate[i].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
		        		alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
		        		depDate[i].focus();
		        		return false;
		        	}
		            
		            if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>') {
		        		alert('<%=dbLabelBean.getLabel("alert.global.preferredairline",strsesLanguage)%>'); 
		        		nameOfAirline[i].focus();
		        		return false;
		        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>') {
		        		alert('<%=dbLabelBean.getLabel("alert.global.preferredtrain",strsesLanguage)%>'); 
		        		nameOfAirline[i].focus();
		        		return false;
		        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredcab",strsesLanguage)%>') {
		        		alert('<%=dbLabelBean.getLabel("alert.global.preferredcab",strsesLanguage)%>'); 
		        		nameOfAirline[i].focus();
		        		return false;
		        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredbus",strsesLanguage)%>') {
		        		alert('<%=dbLabelBean.getLabel("alert.global.preferredbus",strsesLanguage)%>'); 
		        		nameOfAirline[i].focus();
		        		return false;
		        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredcar",strsesLanguage)%>') {
		        		alert('<%=dbLabelBean.getLabel("alert.global.preferredcar",strsesLanguage)%>'); 
		        		nameOfAirline[i].focus();
		        		return false;
		        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredvan",strsesLanguage)%>') {
		        		alert('<%=dbLabelBean.getLabel("alert.global.preferredvan",strsesLanguage)%>'); 
		        		nameOfAirline[i].focus();
		        		return false;
		        	} 		            
		            if (isDate(depDate[i].value)==false) {
		            	f1.depDate[i].focus();
		        		return false;
		        	}
		    	 }  else if(i == (rowCount-1)) {
		    		 	if(depCity[i].value!='' && depCity[i].value!='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {
		    		 		if(arrCity[i].value=='' || arrCity[i].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>')	{
				        		alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
				        		arrCity[i].focus();
				        		return false;
				        	}
				            if(depDate[i].value=='' || depDate[i].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
				        		depDate[i].focus();
				        		return false;
				        	}				            
				            if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.preferredairline",strsesLanguage)%>'); 
				        		nameOfAirline[i].focus();
				        		return false;
				        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.preferredtrain",strsesLanguage)%>'); 
				        		nameOfAirline[i].focus();
				        		return false;
				        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredcab",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.preferredcab",strsesLanguage)%>'); 
				        		nameOfAirline[i].focus();
				        		return false;
				        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredbus",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.preferredbus",strsesLanguage)%>'); 
				        		nameOfAirline[i].focus();
				        		return false;
				        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredcar",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.preferredcar",strsesLanguage)%>'); 
				        		nameOfAirline[i].focus();
				        		return false;
				        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredvan",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.preferredvan",strsesLanguage)%>'); 
				        		nameOfAirline[i].focus();
				        		return false;
				        	} 				            
				            if (isDate(depDate[i].value)==false) {
				            	f1.depDate[i].focus();
				        		return false;
				        	}
		    		 	} else if(arrCity[i].value!='' && arrCity[i].value!='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>') {
		    		 		if(depCity[i].value=='' || depCity[i].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
				        		alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');        		
				        		depCity[i].focus();
				        		return false;
				        	}
		    		 		if(depDate[i].value=='' || depDate[i].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
				        		depDate[i].focus();
				        		return false;
				        	}				            
				            if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.preferredairline",strsesLanguage)%>'); 
				        		nameOfAirline[i].focus();
				        		return false;
				        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.preferredtrain",strsesLanguage)%>'); 
				        		nameOfAirline[i].focus();
				        		return false;
				        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredcab",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.preferredcab",strsesLanguage)%>'); 
				        		nameOfAirline[i].focus();
				        		return false;
				        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredbus",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.preferredbus",strsesLanguage)%>'); 
				        		nameOfAirline[i].focus();
				        		return false;
				        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredcar",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.preferredcar",strsesLanguage)%>'); 
				        		nameOfAirline[i].focus();
				        		return false;
				        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredvan",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.preferredvan",strsesLanguage)%>'); 
				        		nameOfAirline[i].focus();
				        		return false;
				        	} 				            
				            if (isDate(depDate[i].value)==false) {
				            	f1.depDate[i].focus();
				        		return false;
				        	}
		    		 	} else if(depDate[i].value!='' && depDate[i].value!='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
		    		 		if(depCity[i].value=='' || depCity[i].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
				        		alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');        		
				        		depCity[i].focus();
				        		return false;
				        	}
				        	if(arrCity[i].value=='' || arrCity[i].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>')	{
				        		alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
				        		arrCity[i].focus();
				        		return false;
				        	}				            
				            if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.preferredairline",strsesLanguage)%>'); 
				        		nameOfAirline[i].focus();
				        		return false;
				        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.preferredtrain",strsesLanguage)%>'); 
				        		nameOfAirline[i].focus();
				        		return false;
				        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredcab",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.preferredcab",strsesLanguage)%>'); 
				        		nameOfAirline[i].focus();
				        		return false;
				        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredbus",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.preferredbus",strsesLanguage)%>'); 
				        		nameOfAirline[i].focus();
				        		return false;
				        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredcar",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.preferredcar",strsesLanguage)%>'); 
				        		nameOfAirline[i].focus();
				        		return false;
				        	} else if(nameOfAirline[i].value=='' || nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredvan",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.preferredvan",strsesLanguage)%>'); 
				        		nameOfAirline[i].focus();
				        		return false;
				        	} 		            
				            if (isDate(depDate[i].value)==false) {
				            	f1.depDate[i].focus();
				        		return false;
				        	}
		    		 	} else if(nameOfAirline[i].value!='' && nameOfAirline[i].value!='<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>' 
		    		 			&& nameOfAirline[i].value!='<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>' 
		    		 			&& nameOfAirline[i].value!='<%=dbLabelBean.getLabel("label.global.preferredcab",strsesLanguage)%>' 
		    		 			&& nameOfAirline[i].value!='<%=dbLabelBean.getLabel("label.global.preferredbus",strsesLanguage)%>' 
		    		 			&& nameOfAirline[i].value!='<%=dbLabelBean.getLabel("label.global.preferredcar",strsesLanguage)%>' 
		    		 			&& nameOfAirline[i].value!='<%=dbLabelBean.getLabel("label.global.preferredvan",strsesLanguage)%>') { 
		    		 		if(depCity[i].value=='' || depCity[i].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
				        		alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');        		
				        		depCity[i].focus();
				        		return false;
				        	}
				        	if(arrCity[i].value=='' || arrCity[i].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>')	{
				        		alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
				        		arrCity[i].focus();
				        		return false;
				        	}
				            if(depDate[i].value=='' || depDate[i].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
				        		alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
				        		depDate[i].focus();
				        		return false;
				        	}				            		            
				            if (isDate(depDate[i].value)==false) {
				            	f1.depDate[i].focus();
				        		return false;
				        	}
		    		 	} else {
			    		 	if(depCity[i].value=='<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>') {			
			    				depCity[i].value = "";
				        	}
	
				        	if(arrCity[i].value=='<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>')	{
				        		arrCity[i].value="";
				        	}
	
				            if(depDate[i].value=='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
				            	depDate[i].value="";
				        	}
				            
				            if(nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>') {
				            	nameOfAirline[i].value="";
				        	} else if(nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>') {
				        		nameOfAirline[i].value="";
				        	} else if(nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredcab",strsesLanguage)%>') {
				        		nameOfAirline[i].value="";
				        	} else if(nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredbus",strsesLanguage)%>') {
				        		nameOfAirline[i].value="";
				        	} else if(nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredcar",strsesLanguage)%>') {
				        		nameOfAirline[i].value="";
				        	} else if(nameOfAirline[i].value=='<%=dbLabelBean.getLabel("label.global.preferredvan",strsesLanguage)%>') {
				        		nameOfAirline[i].value="";
				        	}
				            
				            if (isDateValid(depDate[i].value)) {         
				            } else {
				            	depDate[i].value = "";
				            }
		    	 		}
		    	 }
		    	 
		            if(depCity.length == "2" && rowCount == "2") {
		        	   	flag = validateDate(f1,todayDate,depDate[i].value,f1.todayDate,depDate[i].value,'<%=dbLabelBean.getLabel("alert.global.departuredateofreturnjourneynotsmallerthantodyadate",strsesLanguage)%>','no');
		        	    	if(flag == false) {
		        	    		depDate[i].focus();
		        	    		return flag;
		        	   		}
		        	    
		       	    	flag = validateDate(f1,depDate[0].value,depDate[i].value,depDate[0].value,depDate[i].value,'<%=dbLabelBean.getLabel("alert.global.departuredateofreturnjourneynotsmallerthandeptdateoffwdjourney",strsesLanguage)%>','no');
		       	    		if(flag == false) {
		       	    			depDate[i].focus();
		       	    			return flag;
		       	    		}
		       	    		
		       	    		if(depDate[i].value !='' || depDate[i].value !='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
		       	     		for (var t = 0, tlen = tourDays1.length; t < tlen; t++) {
		       	     				if(entitlement1[t].value != "0" && entitlement1[t].value != "") {
		       	 	 					if(tourDays1[t].value == "0" || tourDays1[t].value == "") { 	 					
		       	 	 						alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterthetourdays",strsesLanguage)%>');
		       	 	 						f1.tourDays1[t].focus();
		       	 	 			    		return false;
		       	 		 				}
		       	 	 				}
		       	 	 				
		       	 	 			if(entitlement2[t].value != "0" && entitlement2[t].value != "") {
		       	  					if(tourDays2[t].value == "0" || tourDays2[t].value == "") { 	 					
		       	  						alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterthetourdays",strsesLanguage)%>');
		       	  						f1.tourDays2[t].focus();
		       	  			    		return false;
		       	 	 				}
		       	  				}   	 	 				
		       	 	 		}
		       	     	}
		           	} else if(depCity.length > "2" && rowCount > "2") {
		           		if(depDate[rowCount-1] != ""){
			           		flag = validateDate(f1,todayDate,depDate[rowCount-1].value,f1.todayDate,depDate[rowCount-1].value,'<%=dbLabelBean.getLabel("alert.global.departuredateofreturnjourneynotsmallerthantodyadate",strsesLanguage)%>','no');
						    	if(flag == false) {
						    		depDate[rowCount-1].focus();
						    		return flag;
						   		}
			    
					   		flag = validateDate(f1,depDate[0].value,depDate[rowCount-1].value,depDate[0].value,depDate[rowCount-1].value,'<%=dbLabelBean.getLabel("alert.global.departuredateofreturnjourneynotsmallerthandeptdateoffwdjourney",strsesLanguage)%>','no');
					    		if(flag == false) {
					    			depDate[rowCount-1].focus();
					    			return flag;
						    	}
		           		}   		    		
		           		if(i < rowCount-1) {
		           			flag = validateDate(f1,todayDate,depDate[i].value,f1.todayDate,depDate[i].value,'<%=dbLabelBean.getLabel("alert.global.departuredateofintermidiatejourneynotsmallerthantodaydate",strsesLanguage)%>','no');
		    	    	    	if(flag == false) {
		    	    	    		depDate[i].focus();
		    	    	    		return flag;
		    	    	   		}
		        	    
		    	   	    	flag = validateDate(f1,depDate[0].value,depDate[i].value,depDate[0].value,depDate[i].value,'<%=dbLabelBean.getLabel("alert.global.departuredateofintermidiatejourneynotsmallerthandeptdateoffwdjourney",strsesLanguage)%>','no');
		    	   	    		if(flag == false) {
		    	   	    			depDate[i].focus();
		    	   	    			return flag;
		    	   	    		}
		    	   	    		
		    	   	    	if(depDate[rowCount-1] != ""){	
			       	    		flag = validateDate(f1,depDate[i].value,depDate[rowCount-1].value,depDate[i].value,depDate[rowCount-1].value,'<%=dbLabelBean.getLabel("alert.global.departuredateofintermidiatejourneynotgreaterthandeptdateofreturnjourney",strsesLanguage)%>','no');
			    	   	    		if(flag == false) {
			    	   	    			depDate[i].focus();
			    	   	    			return flag;
			    	   	    		}
		    	   	    	}	
		   	   	    		flag = validateDate(f1,depDate[i-1].value,depDate[i].value,depDate[i-1].value,depDate[i].value,'<%=dbLabelBean.getLabel("alert.global.departuredateofintermidiatejourneynotsmallerthandeptdateofpreviousintermidiatejourney",strsesLanguage)%>','no');
			   	   	    		if(flag == false) {
			   	   	    			depDate[i].focus();
			   	   	    			return flag;
			   	   	    		}
		           		} else if(i == rowCount-1) {
		           			flag = validateDate(f1,todayDate,depDate[i].value,f1.todayDate,depDate[i].value,'<%=dbLabelBean.getLabel("alert.global.departuredateofreturnjourneynotsmallerthantodyadate",strsesLanguage)%>','no');
		    	    	    	if(flag == false) {
		    	    	    		depDate[i].focus();
		    	    	    		return flag;
		    	    	   		}
		        	    
		       	    		flag = validateDate(f1,depDate[0].value,depDate[i].value,depDate[0].value,depDate[i].value,'<%=dbLabelBean.getLabel("alert.global.departuredateofreturnjourneynotsmallerthandeptdateoffwdjourney",strsesLanguage)%>','no');
		    	   	    		if(flag == false) {
		    	   	    			depDate[i].focus();
		    	   	    			return flag;
		    	   	    		}
		    	   	    		
		    	   	    		if(depDate[i].value !='' || depDate[i].value !='<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>') {
		    	   	   	     		for (var t = 0, tlen = tourDays1.length; t < tlen; t++) {	   	   	     		
		    	   	   	     				if(entitlement1[t].value != "0" && entitlement1[t].value != "") {
		    	   	   	 	 					if(tourDays1[t].value == "0" || tourDays1[t].value == "") { 	 					
		    	   	   	 	 						alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterthetourdays",strsesLanguage)%>');
		    	   	   	 	 						f1.tourDays1[t].focus();
		    	   	   	 	 			    		return false;
		    	   	   	 		 				}
		    	   	   	 	 				}
		    	   	   	 	 				
		    	   	   	 	 			if(entitlement2[t].value != "0" && entitlement2[t].value != "") {
		    	   	   	  					if(tourDays2[t].value == "0" || tourDays2[t].value == "") { 	 					
		    	   	   	  						alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterthetourdays",strsesLanguage)%>');
		    	   	   	  						f1.tourDays2[t].focus();
		    	   	   	  			    		return false;
		    	   	   	 	 				}
		    	   	   	  				}   	 	 				
		    	   	   	 	 		}
		    	   	   	     	}
		           		}           		
		           	}
		        }    
		    }
		    
		    
		    if(f1.reasonForTravel.value == "" || f1.reasonForTravel.value == "<%=dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage)%>") {
				alert('<%=dbLabelBean.getLabel("alert.global.enterreasonfortravel",strsesLanguage)%>');
				f1.reasonForTravel.focus();
				return false;	
			}	
			
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
			
			if(f1.visa[1].checked) {    	
		       if(f1.visaComment.value=="")	{  
				  alert('<%=dbLabelBean.getLabel("alert.global.visacomments",strsesLanguage)%>');
				  f1.visaComment.focus();
				  return false;
				}
			}
		    	
			if(f1.insurance[0].checked) {		
		       if(f1.nominee.value=="") {
				  alert('<%=dbLabelBean.getLabel("alert.global.nominee",strsesLanguage)%>');
				  showPersonalDetailRow();
				  f1.nominee.focus();
				  return false;
				}

				if(f1.relation.value=="") {
				  alert('<%=dbLabelBean.getLabel("alert.createrequest.relationwithnominee",strsesLanguage)%>');
				  showPersonalDetailRow();
				  f1.relation.focus();
				  return false;
				}
			}

			if(f1.insurance[1].checked)	{
				if(f1.insuranceComment.value=="") {
				  alert('<%=dbLabelBean.getLabel("alert.global.insurancecomment",strsesLanguage)%>');
				  f1.insuranceComment.focus();
				  return false;
				}
			}  

			if(f1.hotel.value == "1" || f1.hotel.value=="2") {
				var checkInDate   = f1.checkin.value;
				var checkOutDate  = f1.checkout.value;
				
				if(f1.place.value == "" || f1.place.value == "<%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage)%>") {
					alert('<%=dbLabelBean.getLabel("alert.global.preferredplace",strsesLanguage)%>');
					f1.place.focus();
					return false;
				} 
				
				if(f1.checkin.value == "" || f1.checkin.value == "<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>") {
					alert('<%=dbLabelBean.getLabel("alert.global.checkindate",strsesLanguage)%>');
					f1.checkin.focus();
					return false;
				}

				if(f1.checkout.value == "" || f1.checkout.value == "<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>") {
					alert('<%=dbLabelBean.getLabel("alert.global.checkoutdate",strsesLanguage)%>');
					f1.checkout.focus();
					return false;
				}
				
				flag =  validateDate(f1,todayDate,checkInDate,f1.todayDate,f1.checkin,'<%=dbLabelBean.getLabel("alert.global.checkindatecannotsmallerthantodaydate",strsesLanguage)%> ','no');
				if(flag == false) {
					f1.checkin.focus();
				  	return flag; 
				}
				
				flag =  validateDate(f1,todayDate,checkOutDate,f1.todayDate,f1.checkout,'<%=dbLabelBean.getLabel("alert.global.checkoutdatecannotsmallerthantodaydate",strsesLanguage)%>','no');
				if(flag == false) {
					f1.checkout.focus();
				  	return flag; 
				}
				
				flag =  validateDate(f1,checkInDate,checkOutDate,f1.checkin,f1.checkout,'<%=dbLabelBean.getLabel("alert.global.checkoutdatecannotsmallerthancheckindate",strsesLanguage)%>','no');
				if(flag == false) {
					f1.checkout.focus();
				  	return flag; 
				}
				
				
				flag =  validateDate(f1,depDate[0].value,checkInDate,depDate[0].value,f1.checkin,'<%=dbLabelBean.getLabel("alert.global.checkindatecannotsmallerthandeparturedate",strsesLanguage)%>','no');
				if(flag == false) {
					f1.checkin.focus();
				  	return flag; 
				}	
				
				if(rowCount > 1) {					
					flag =  validateDate(f1,checkOutDate,depDate[rowCount-1].value,depDate[rowCount-1].value,f1.checkout,'<%=dbLabelBean.getLabel("alert.global.checkoutdatecannotbegreaterthandeparturedate",strsesLanguage)%>','no');
					if(flag == false) {
						f1.checkout.focus();
					  	return flag; 
					}
				}
				
				if(f1.hotel.value == "1") {
					if(f1.budget.value=="" || f1.budget.value=="0" || f1.budget.value=="<%=dbLabelBean.getLabel("label.global.budget",strsesLanguage)%>") {
					  alert('<%=dbLabelBean.getLabel("alert.global.budget",strsesLanguage)%>');
					  f1.budget.focus();
					  return false;
					}
				}
				
//		 		if(f1.otherComment.value=="" || f1.otherComment.value=="Remarks") { 
		<%-- 			alert('<%=dbLabelBean.getLabel("alert.global.enterremarksifaccomodationnotrequired",strsesLanguage)%>'); --%>
//		 			f1.otherComment.focus();
//		 			return false;
//		 		}
				
				if (isDate(f1.checkin.value)==false) {
					f1.checkin.focus();
		    		return false;
		    	}
				
				if (isDate(f1.checkout.value)==false) {
		        	f1.checkout.focus();
		    		return false;
		    	}		
			}

			if(f1.hotel.value == "0") {	 
				if(f1.otherComment.value=="") {
					alert('<%=dbLabelBean.getLabel("alert.global.enterremarksifaccomodationnotrequired",strsesLanguage)%>');
					f1.otherComment.focus();
					return false;
				}
			}  
			
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
			
		    
			
		   for (var t = 0, tlen = entitlement1.length; t < tlen; t++) {
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
			
			if($('input#rd_Dom').is(':checked')) {		
				if (f1.passport_Contact_No.value == "") {
					alert('<%=dbLabelBean.getLabel("alert.global.mobilenumber",strsesLanguage)%>');
					showPersonalDetailRow();
					f1.passport_Contact_No.focus();
					return false;
				}
				
				if (f1.identityProof.value == -1) {
					alert('<%=dbLabelBean.getLabel("alert.global.identityproof",strsesLanguage)%>');
					showPersonalDetailRow();
					f1.identityProof.focus();
					return false;
				}
				
				if (f1.identityProofno.value == "") {
					alert('<%=dbLabelBean.getLabel("alert.createrequest.identityproofnumber",strsesLanguage)%>');
					showPersonalDetailRow();
					f1.identityProofno.focus();
					return false;
			     }
			}
			
			if($('input#rd_Int').is(':checked')) {
				
				var flag = CheckPassportInfo_ffno(f1);	
				if(flag == false) {		
					return flag;
				}
			
				flag =  checkDOB(f1);
				if(flag == false) {
					return flag;
				}	
				
				if (isDate(f1.passport_expire_date.value)==false) {
					showPersonalDetailRow();
					f1.passport_expire_date.focus();
					return false;
				}
				
				if (isDate(f1.passport_issue_date.value)==false) {
					showPersonalDetailRow();
					f1.passport_issue_date.focus();
					return false;
				}
				
				if (isDate(f1.passport_DOB.value)==false) {
					showPersonalDetailRow();
					f1.passport_DOB.focus();
					return false;
				}	
			}
		  
			var flag = CheckFFDetail(f1); 
			if(flag == false) {
				return flag;
			}
			
			
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
				   		showForexDetailRow();
				   		setPlaceholder();
				   		f1.pricingAirline.focus();
				   		return false;
				   	}
				   	
				   	if(f1.pricingAirline.value!="") {
				   		if(f1.pricingCurrency.value=="-1") {
				   			alert('<%=dbLabelBean.getLabel("alert.global.currency",strsesLanguage)%>');
				   			showForexDetailRow();
				   			setPlaceholder();
				   			f1.pricingCurrency.focus();
				   			return false;
				   		}
				   		if(f1.localprice.value=="" || f1.localprice.value=="<%=dbLabelBean.getLabel("label.global.localprice",strsesLanguage)%>") {
				   			alert('<%=dbLabelBean.getLabel("alert.global.localprice",strsesLanguage)%>'); 
				   			showForexDetailRow();
				   			setPlaceholder();
				   			f1.localprice.focus(); 
				   			return false;
				   		}
				   		if(f1.pricingRemarks.value=="" || f1.pricingRemarks.value=="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>") {
				   			alert('<%=dbLabelBean.getLabel("alert.global.remarks",strsesLanguage)%>');
				   			showForexDetailRow();
				   			setPlaceholder();
				   			f1.pricingRemarks.focus(); 
				   			return false;
				   		}
					}		
				}		   
			}	
			
			if((f1.manager.value != 'S' || f1.manager.value != '') && (f1.hod.value != 'S' || f1.hod.value != '')) {
				if(f1.reasonForSkip.value == "<%=dbLabelBean.getLabel("label.global.reasonforskippingtheapprovers",strsesLanguage)%>") {
					$("textarea#reasonForSkip").prop('disabled', true);
				}
			}

			if(f1.cashBreakupRemarks.value=='<%=dbLabelBean.getLabel("label.global.kindlyputyourcurrencydenominationdetails",strsesLanguage)%>') {
				f1.cashBreakupRemarks.value = "";		
			}	
			
		 	if(f1.otherComment.value=="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>") { 
				f1.otherComment.value = "";
			}

			
		var var_res = checkTESRequestCount();
		if(var_res==false) {
			return false;
		}

		var text=f1.approverlist.value;
		if(text!='') {
			text="Currently "+text;   
		}		

		if(budValidations1.toLowerCase() === budValidations2.toLowerCase()) {			
			if((YtmBud == '' || YtmBud == YtmBudLabel || YtmAct == '' || YtmAct == YtmActLabel || EstExp == '' || EstExp == EstExpLabel) && (budgetRemarks == '' || budgetRemarks == budgetRemarksLabel)) {
				alert('<%=dbLabelBean.getLabel("alert.global.enterremarksfornotenteringbudgetactualdetails",strsesLanguage)%>');				
				showForexDetailRow();
				setPlaceholder();
				if(YtmBud == '' || YtmBud == YtmBudLabel) {
				document.getElementById('YtmBud').focus();
				} else if(YtmAct == '' || YtmAct == YtmActLabel) {
				document.getElementById('YtmAct').focus();
				} else if(EstExp == '' || EstExp == EstExpLabel) {
				document.getElementById('EstExp').focus();
				}		
				return false;
			} else {
				
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
		
		if(confirm(text+'<%=dbLabelBean.getLabel("alert.global.submittoworkflow",strsesLanguage)%>'))  {
			f1.saveandexit.disabled=true;
			f1.save.disabled=true;
			f1.saveproceed.disabled=true; 
			var expenceCheck = $("#grandtotalforexusd").val();
			if(expenceCheck != undefined && expenceCheck == ""){
				alert('USD/Day can not be blank.');
				f1.saveandexit.disabled=false;
				f1.save.disabled=false;
				f1.saveproceed.disabled=false;
				return false;
			} else if(expenceCheck != undefined && expenceCheck != "" && parseFloat(expenceCheck) > 350) {
				alert('<%=dbLabelBean.getLabel("alert.createrequest.couldnotsubmittoworkflow",strsesLanguage)%>');
				f1.saveandexit.disabled=false;
				f1.save.disabled=false;
				f1.saveproceed.disabled=false;
				return false;
			} else {
				f1.saveandexit.disabled=true;
				f1.save.disabled=true;
				f1.saveproceed.disabled=true;
				openWaitingProcess();
				f1.submit();	
				return true;	
			}					
		} else {
			f1.saveandexit.disabled=false;
			f1.save.disabled=false;
			f1.saveproceed.disabled=false;
			return false;
		}
	} else {
		
		
			$('table#tblItinerary tbody > tr.itineraryDataRow').not(':first').not(':last').each(function(i) {				
				var depCty = $(this).find('#depCityTB').val();
				var arrCty = $(this).find('#arrCityTB').val();
				var depDt = $(this).find('#depDateTB').val();
				var airLineNm = $(this).find('#nameOfAirlineTB').val();		
				
				if(depCty == '' || depCty == '<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>' 
						|| arrCty == '' || arrCty == '<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>' 
						|| depDt == '' || depDt == '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>' 
						|| airLineNm == '' || airLineNm == '<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>' 
						|| airLineNm == '<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>' 
						|| airLineNm == '<%=dbLabelBean.getLabel("label.global.preferredcab",strsesLanguage)%>' 
						|| airLineNm == '<%=dbLabelBean.getLabel("label.global.preferredbus",strsesLanguage)%>' 
						|| airLineNm == '<%=dbLabelBean.getLabel("label.global.preferredcar",strsesLanguage)%>' 
						|| airLineNm == '<%=dbLabelBean.getLabel("label.global.preferredvan",strsesLanguage)%>') {
					$(this).remove();
				} else {
					if (isDateValid(depDt)) {   
			        } else { 
			        	$(this).remove();
			        }
				}
			});
		
			$('table#tblItinerary tbody > tr.itineraryDataRow:last').each(function() {
				var depCty = $(this).find('#depCityTB').val();
				var arrCty = $(this).find('#arrCityTB').val();
				var depDt = $(this).find('#depDateTB').val();
				var airLineNm = $(this).find('#nameOfAirlineTB').val();	
				
				if(depCty == '' || depCty == '<%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%>' 
					|| arrCty == '' || arrCty == '<%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%>' 
					|| depDt == '' || depDt == '<%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>' 
					|| airLineNm == '' || airLineNm == '<%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage)%>' 
					|| airLineNm == '<%=dbLabelBean.getLabel("label.global.preferredtrain",strsesLanguage)%>' 
					|| airLineNm == '<%=dbLabelBean.getLabel("label.global.preferredcab",strsesLanguage)%>' 
					|| airLineNm == '<%=dbLabelBean.getLabel("label.global.preferredbus",strsesLanguage)%>' 
					|| airLineNm == '<%=dbLabelBean.getLabel("label.global.preferredcar",strsesLanguage)%>' 
					|| airLineNm == '<%=dbLabelBean.getLabel("label.global.preferredvan",strsesLanguage)%>') {
					$(this).find('#depCityTB').val("");
					$(this).find('#arrCityTB').val("");
					$(this).find('#depDateTB').val("");
					$(this).find('#nameOfAirlineTB').val("");
				}
		       		        
		        if (isDateValid(depDt)) {         
		        } else {
		        	$(this).find('#depCityTB').val("");
					$(this).find('#arrCityTB').val("");
					$(this).find('#depDateTB').val("");
					$(this).find('#nameOfAirlineTB').val("");
		        }
			});
		
		
		if(f1.reasonForTravel.value=="<%=dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage)%>") { 
			f1.reasonForTravel.value = "";
		}
		
		if(f1.budget.value=="<%=dbLabelBean.getLabel("label.global.budget",strsesLanguage)%>") { 
			f1.budget.value = "";
		}

		if(f1.checkin.value=="<%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage)%>") { 
			f1.checkin.value = "";
		}

		if(f1.checkout.value=="<%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage)%>") { 
			f1.checkout.value = "";
		}

		if(f1.place.value=="<%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage)%>") { 
			f1.place.value = "";
		}
		
		if(f1.otherComment.value=="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>") { 
			f1.otherComment.value = "";
		}		
				
		if(f1.reasonForSkip.value == "<%=dbLabelBean.getLabel("label.global.reasonforskippingtheapprovers",strsesLanguage)%>") {
			f1.reasonForSkip.value = "";
		}	
		
		if(f1.expRemarks.value=='<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%> / <%=dbLabelBean.getLabel("alert.global.reasonforcontigencies",strsesLanguage)%>') {
			f1.expRemarks.value = "";		
		}

		if(f1.cashBreakupRemarks.value=='<%=dbLabelBean.getLabel("label.global.kindlyputyourcurrencydenominationdetails",strsesLanguage)%>') {
			f1.cashBreakupRemarks.value = "";		
		}	
		
		if(f1.pricingAirline.value=="<%=dbLabelBean.getLabel("label.global.airline",strsesLanguage)%>") { 
			f1.pricingAirline.value = "";
		}

		if(f1.localprice.value=="<%=dbLabelBean.getLabel("label.global.localprice",strsesLanguage)%>") { 
			f1.localprice.value = "";
		}

		if(f1.pricingRemarks.value=="<%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>") { 
			f1.pricingRemarks.value = "";
		}
		
		if(budValidations1.toLowerCase() === budValidations2.toLowerCase()) {	
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
	
	
	f1.whatAction.value=actionFlag;
	f1.saveandexit.disabled=true;
	f1.save.disabled=true;
	f1.saveproceed.disabled=true;
	openWaitingProcess();
	f1.submit();	
	return true;
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

