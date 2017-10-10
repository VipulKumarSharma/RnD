<%
/***************************************************
 *The information contained here in is confidential and  
 * proprietary to MIND and forms the part of the MIND  
 *Author				:SACHIN GUPTA
 *Date of Creation 		:08 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for create the Travel Requsition
 *Modification 	    	:1 .Change the Accomodation Information.
						 2. Add function for disable and enable Reason For skipping area
						 3. Added code for showing its Primary site also	
						 4. Primary Site should be viewed only once
						 5,
						 6, 7. Introduced for the Gender, this code is compatible to the previous options where User has not 
							entered the gender i.e GENDER =null
                         8. code added for checking defined workflow for selected site on 29-May-07 by shiv  sharma  
						 9. code changed for showing '-' in place  of 0.0 on 09-Jul-07 
						 10 code added for showing default Policies page for site where Policies page is not uploaded 
						 11.Code added for the showing the appropriate message in case file not uploaded by Sanjeet Kumar 16-Jul-2007
						 12.Code added for showing alert if user dose not required accommodation in his journey on 4th jan 2008 by Shiv Sharma 
						 13.Code added for allowing the character & numeric in preferred Airline on                            4th Jan 2008 by Shiv Sharma 
						 14.Code change for showing age(Yr,month,days  ) to user but not storing   on 03-Mar-08 by shiv sharma   
						 15 Credit card entry in not mendatory . changes done by shiv sharma on 2/2/2009
						 16 added code by sachin on 2/17/2009 
						 17 //added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma 
						 18 Query changed for showing all user of UNit if usr is LA only for SMR on 04-03-2010
						 19 Commented Credit card no as it is not required for  to show any user on 10-03-2010 by shiv sharma 
						 Modified by vaibhav on jul 2 2010 to change date input format for credit card expiry date
                         
						
 *Reason of Modification: change suggested by MATA
						: New Functionality added 
 *Date of Modification  :1. 3 Nov 2006 
						:2. 12 Mar 2007
						:3. 26-Apr-2007
						:4. 27-Apr-2007
						:5.
						:6. 03-May-2007
						:7. 16-May-2007
					
 *Modified By	        :1. SACHIN GUPTA
						 2. SAMIR RANJAN PADHI
						 3. GAURAV AGGARWAL
						 4. GAURAV AGGARWAL
						 5. Shiv Sharma
						 6. GAURAV AGGARWAL
						 7. GAURAV AGGARWAL
						 
 *Editor				:Editplus
 
 *Modification          :sorting approver level 2
 *Modified By		    :Manoj
 *Date of Modification	:25 jan 2011
 
 *Modification          :Show alert if approvers name already in default workflow
 *Modified By		    :Manoj
 *Date of Modification	:25 march 2011
 
 *Modification			:Disable both designation and age textbox.
 *Modified By			:manoj chand			
 *Date of Modification  :18 april 2011

 *Modification			:modify workflow as per selected site
 *Date of modification  :12 Oct 2011
 *Modified By     		:Manoj Chand
 
 *Modification			:Add Board Member Dropdown for SMP  
 *Modified by			:Manoj Chand
 *Date of Modification	:28 Mar 2012
 
 *Modified By	  		:Manoj Chand
 *Date of Modification  : 04 Apr 2012
 *Modification 	  		:add a check for unit head approval level 1 and 2 selection is not mandatory in SMP site
 
 *Modification				:change in function defaultApproverList  
 *Modified by				:Manoj Chand
 *Date of Modification		:17 Apr 2012
 
 *Modification				:Show a message when transit house is selected  
 *Modified by				:Manoj Chand
 *Date of Modification		:24 Apr 2012
 
 *Modification				:Implementing multilingual feature  
 *Modified by				:Manoj Chand
 *Date of Modification		:22 May 2012
 
 *Modification				:Add 'AMEX' Card Type in Credit Card Information
 *Modified by				:Manoj Chand
 *Date of Modification		:26 July 2012
 
 *Modified By	        :MANOJ CHAND
 *Date of Modification  :01 Aug 2012
 *Description			:Provide Cost Centre Combobox for SMP Division
 
 *Modified By	        :MANOJ CHAND
 *Date of Modification  :06 Sept 2012
 *Description			:for smr site only originator name coming in select user combox from originator login.
 						 for LA all user of the selected site will come.
 						 
*Modified By	        	:MANOJ CHAND
*Date of Modification  		:19 OCT 2012
*Description				:IMPLEMENT SITE WISE FLAG TO SHOW BOARD MEMBER IN SMP

*Modified By	        :MANOJ CHAND
*Date of Modification   :07 Feb 2013
*Description			:IE Compatibility Issue resolved.

*Modified By			:Manoj Chand
*Date of Modification	:03 June 2013
*Modification			:Provision to display other site user in approval level 1 or 2.

*Modified By			:Manoj Chand
*Date of Modification	:23 July 2013
*Modification			:Mandatory selection of approval level 1 and 2 for mssl site.

*Modified By			:Manoj Chand
*Date of Modification	:22 Oct 2013
*Modification			:javascript validation to stop from typing --,'  symbol is added.
 *******************************************************/
%>
<%@ include  file="application.jsp" %>

<%@ page import = "java.sql.*" pageEncoding="UTF-8"%>


<html>

<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />

<style type="text/css">
<!--
.style2 {font-size: 10px; font-weight: bold; color: #FF7D00; }
.style1 {  visibility: hidden;}
-->
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>

<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css"/>
<!--@Gaurav 30-Apr-2007 Not in Use <script type="text/javascript" language="JavaScript1.2" src="style/company.js?buildstamp=2_0_0"></script>-->
<script language="JavaScript" src="style/pupdate.js?buildstamp=2_0_0"></script>
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
<script language="JavaScript" src="scripts/BackSpaceDisable.js?buildstamp=2_0_0"></script>
<SCRIPT language="JavaScript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></SCRIPT>

<script>
//function added by manoj chand on 21 feb 2012 to replace multiple spaces with single space
function removeSpaces(str) {
	str = str.replace(/\s{2,}/g,' ');
 	return str;
}
</script>

<%
//Global Variables declared and initialized
request.setCharacterEncoding("UTF-8");
String strSql                   =  null;              // String for Sql String
ResultSet rs,rs1,rs2            =  null;              // Object for ResultSet
String strSiteId                =  "";
String strUserId                =  "";
String strDivId                 =  "";
String strDeptId                =  "";
String strDesigName             =  "";
String strAge                   =  "";
String strAge1                  =  "";                 //This Age get from the Table when TravelId is already created       

String actualAge				="";
String strSex                   =  "";
String strMessage               =  "";

String strUserNameId            =  "";  
String strSiteNameId            =  "";
String strDesigNameId           =  "";   
String strMealId                =  ""; 
String strVisaRequired          =  "";
String strVisaComment           =  "";

String strDepCity               =  "";                              
String strDepCity1              =  "";                              


String strDepDate               =  "";                              
String strArrCity               =  "";
String strArrCity1              =  "";



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
String strPlace                 =  "";
 

String strCheckin				=  "";
String strCheckout    			=  ""; 

String strRemarks               =  "";
//NEW
String strReasonForTravel       =  "";
String strReasonForSkip         =  "";
//

String strTravelMode1           =  "";
String strTravelMode2           =  "";
String strTravelClass1          =  "";
String strTravelClass2          =  "";
String strManager               =  ""; 
String strHod                   =  ""; 
String strBoardMember           =  "";
String strSelectManagerRadio    =  ""; 
String strPreferTime1           =  "";
String strPreferTime2           =  "";

String strTravelReqId           =  "";
String strTravelId				=  "";
String strTravelReqNo           =  "";  

String strIntermiId             =  "";

String strScriptRunFlag         =  "";         //This flag is user for showing data when we change the travel mode or we can say when we call the setValue() value java script method
String strSiteId1= ""; //Vijay 02/04/2007
String strCARD_TYPE  ="";
///22-02-2007
String strCARD_HOLDER_NAME ="";
String strCARD_NUMBER1 ="";
String strCARD_NUMBER2 ="";
String strCARD_NUMBER3 ="";
String strCARD_NUMBER4 ="";
String strCVV_NUMBER ="";
String strCARD_EXP_DATE ="";
String strGender ="";

String strPreferSeatfwd="";
String strPreferSeatRet="";	
String strMonth="";
String strYear="";
String strCostCentre="";
String strShowflag="n";

strCARD_TYPE					= request.getParameter("CARD_TYPE")==null?"-1":request.getParameter("CARD_TYPE") ;  
strCARD_HOLDER_NAME =  request.getParameter("cardHolderName")==null ?"" :request.getParameter("cardHolderName") ; 
strCARD_NUMBER1			= request.getParameter("CARD_NUMBER1");
strCARD_NUMBER2			= request.getParameter("CARD_NUMBER2");
strCARD_NUMBER3			= request.getParameter("CARD_NUMBER3");
strCARD_NUMBER4			= request.getParameter("CARD_NUMBER4");
strCARD_EXP_DATE			= request.getParameter("CARD_EXP_DATE");

strScriptRunFlag                =  request.getParameter("scriptRunFlag");   

strSiteId                       =  request.getParameter("site");  
strUserId                       =  request.getParameter("userName");

strSex							=  request.getParameter("sex")==null ?"1" :request.getParameter("sex") ; 
strMealId                       =  request.getParameter("meal"); 
strTravelMode1                  =  request.getParameter("travelMode1");  
strTravelMode2                  =  request.getParameter("travelMode2");  
strTravelClass1                 =  request.getParameter("travelClass1");  
strTravelClass2                 =  request.getParameter("travelClass2");  
strAge                          =  request.getParameter("age");
strAge1                         =  request.getParameter("age");
strManager                      =  request.getParameter("manager");
strHod                          =  request.getParameter("hod");
//added by manoj chand on 27 march 2012
strBoardMember					=  request.getParameter("boardmember");
strSelectManagerRadio           =  request.getParameter("selectManager");

strPreferTime1                  =  request.getParameter("preferTime1");
strPreferTime2                  =  request.getParameter("preferTime2");


strDepCity                      =  request.getParameter("depCity"); 

strDepCity1                     =  request.getParameter("depCity1")==null ?"" :request.getParameter("depCity1") ; 


strDepDate                      =  request.getParameter("depDate"); 
strArrCity                      =  request.getParameter("arrCity");

strArrCity1                     =  request.getParameter("arrCity1")==null ?"" :request.getParameter("arrCity1");


strReturnDate                   =  request.getParameter("returnDate");
strNameOfAirline1               =  request.getParameter("nameOfAirline1");
strNameOfAirline2               =  request.getParameter("nameOfAirline2");



strVisaRequired                 =  request.getParameter("visa"); 
strVisaComment                  =  request.getParameter("visaComment");
strInsuranceRequired            =  request.getParameter("insurance"); 
strNominee                      =  request.getParameter("nominee");
strRelation                     =  request.getParameter("relation"); 
strInsuranceComment             =  request.getParameter("insuranceComment");
strHotelRequired                =  request.getParameter("hotel") == null ? "0" : request.getParameter("hotel"); 
strBudgetCurrency               =  request.getParameter("currency");
strHotelBudget                  =  request.getParameter("budget");

strCheckin						= request.getParameter("checkin") == null ? "" : request.getParameter("checkin");
strCheckout					= request.getParameter("checkout") == null ? "" : request.getParameter("checkout");
strPlace			            =request.getParameter("place")==null?"":request.getParameter("place");


strRemarks                      =  request.getParameter("otherComment"); 

strTravelReqId                  =  request.getParameter("travelReqId");    // for hidden field
strTravelId                     =  request.getParameter("travelId");       // for hidden field
strTravelReqNo                  =  request.getParameter("travelReqNo");    // for hidden field
strMessage                      =  request.getParameter("message");  

//new code
strReasonForTravel				=  request.getParameter("reasonForTravel");
strReasonForSkip                =  request.getParameter("reasonForSkip");
strCostCentre					=  request.getParameter("costcentre")==null?"0":request.getParameter("costcentre");
//System.out.println("strCostCentre---->"+strCostCentre);
String strAppLvl3flg = "";
String strAppLvl3flgforBM = "";
String strMandatatoryApvFlag = "";

//code added by Gurmeet Singh on 17 january 2014
String strManagerSelected = "";
String strHodSelected = "";
String strBoardMemberSelected =  "";
//Added By Gurmeet Singh
String strUserAccessCheckFlag = "";	
	
//code added by manoj chand on 27 march 2012 to CHECK WHETHER DIVISION OF USER IS SMP OR NOT.
strSql="SELECT SHOW_APP_LVL_3 FROM M_DIVISION MD INNER JOIN	M_USERINFO MU ON MU.DIV_ID=MD.DIV_ID WHERE USERID="+Suser_id;
//System.out.println("strSql --->"+strSql);
rs       =   dbConBean.executeQuery(strSql);  
if(rs.next())
{
	strAppLvl3flg=rs.getString("SHOW_APP_LVL_3");
}
rs.close();
rs=null;

 // Code added by Sanjeet Kumar on 16-july-2007 for giving a proper information incase site not uploaded
 	//SpolicyPath variable used on 07 jan 2013 for getting company policy path
   	//String Path	=application.getInitParameter("companyPolicyPath");
	File UploadFile=new File(SpolicyPath+"/"+strSiteFullName+"/"+strSiteFullName+".html");			  


//Added  on 29-May-07 by shiv 
String strButtonState="";

strIntermiId					=	request.getParameter("interimId")== null ? "" : request.getParameter("interimId");

if(strMessage != null && strMessage.equals("save"))
{
    strMessage = dbLabelBean.getLabel("message.global.savedsuccessfully",strsesLanguage);
}
else if(strMessage != null && strMessage.equals("notSave"))
{
    strMessage = dbLabelBean.getLabel("message.global.couldnotsave",strsesLanguage);; 
}
else
{
     strMessage = ""; 
}


if(strTravelId==null)
{
  strTravelReqId = "new";
  strTravelId    = "new";
}
else if(strTravelId !=null && strTravelId.equals(""))
{
  strTravelReqId = "new";
  strTravelId    = "new";
}
else if(strTravelId !=null && strTravelId.equals("new"))
{
  strTravelReqId = "new";
  strTravelId    = "new";
}
else if(strScriptRunFlag != null && strScriptRunFlag.equals("yes"))
{
}
else 
{
	strUserAccessCheckFlag = securityUtilityBean.validateAuthEditTravelReq(strTravelId, "I", Suser_id);
	if(strUserAccessCheckFlag.equals("420")){
		dbConBean.close();  
		securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_IntTrv_Details.jsp", "Unauthorized Access");
		response.sendRedirect("UnauthorizedAccess.jsp");
		return;
	} else {
	
	strSql = "SELECT TRAVEL_REQ_ID,SITE_ID,TRAVELLER_ID,AGE,SEX,MEAL,VISA_REQUIRED,VISA_COMMENT, DBO.CONVERTDATEDMY1(TRAVEL_DATE)AS TRAVEL_DATE, INSURANCE_REQUIRED,NOMINEE, RELATION, INSURANCE_COMMENTS, HOTEL_REQUIRED,RTRIM(LTRIM(BUDGET_CURRENCY))AS BUDGET_CURRENCY , ISNULL(HOTEL_BUDGET,'') AS HOTEL_BUDGET, REMARKS,  DBO.CONVERTDATEDMY1(CHECK_IN_DATE)AS CHECK_IN_DATE, DBO.CONVERTDATEDMY1(CHECK_OUT_DATE)AS CHECK_OUT_DATE,   RTRIM(LTRIM(APPROVER_SELECTION)) AS APPROVER_SELECTION, MANAGER_ID,HOD_ID,  LTRIM(RTRIM(ISNULL(CARD_TYPE,''))) AS CARD_TYPE,LTRIM(RTRIM(ISNULL(CARD_NUMBER1,''))) AS CARD_NUMBER1,LTRIM(RTRIM(ISNULL(CARD_NUMBER2,''))) AS CARD_NUMBER2 ,LTRIM(RTRIM(ISNULL(CARD_NUMBER3,''))) AS CARD_NUMBER3, LTRIM(RTRIM(ISNULL(CARD_NUMBER4,''))) AS CARD_NUMBER4 ,LTRIM(RTRIM(ISNULL(CVV_NUMBER,''))) AS CVV_NUMBER,LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(CARD_EXP_DATE),''))) AS CARD_EXP_DATE,ISNULL(REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL,ISNULL(REASON_FOR_SKIP,'') AS REASON_FOR_SKIP, ISNULL(PLACE,'') AS  PLACE, ISNULL(CARD_HOLDER_NAME,'') AS CARD_HOLDER_NAME,BOARD_MEMBER_ID,CC_ID FROM  T_TRAVEL_DETAIL_INT  (NOLOCK) WHERE TRAVEL_ID="+strTravelId+" AND APPLICATION_ID=1 AND STATUS_ID=10";
   
 

	//, ISNULL(CARD_HOLDER_NAME,'') AS CARD_HOLDER_NAME
    rs       =   dbConBean.executeQuery(strSql);  
    if(rs.next())
    {
		strTravelReqId       = rs.getString("TRAVEL_REQ_ID");
		strSiteId            = rs.getString("SITE_ID");
		strUserId            = rs.getString("TRAVELLER_ID");
		strAge1              = rs.getString("AGE");
		strSex               = rs.getString("SEX");
		strMealId            = rs.getString("MEAL");
		strVisaRequired      = rs.getString("VISA_REQUIRED");
		strVisaComment       = rs.getString("VISA_COMMENT");
		strDepDate           = rs.getString("TRAVEL_DATE");
        strInsuranceRequired = rs.getString("INSURANCE_REQUIRED");  
		strNominee           = rs.getString("NOMINEE");   
		strRelation          = rs.getString("RELATION");   
        strInsuranceComment  = rs.getString("INSURANCE_COMMENTS");   
		strHotelRequired     = rs.getString("HOTEL_REQUIRED");   
        strBudgetCurrency    = rs.getString("BUDGET_CURRENCY");     
        strHotelBudget       = rs.getString("HOTEL_BUDGET"); 

		// added code by shiv on 09-Jul-07
			if ( strHotelBudget!= null && strHotelBudget.equals("0.0")) {
			strHotelBudget = "";
			}
			
		strRemarks           = rs.getString("REMARKS");   
		strCheckin			 = rs.getString("CHECK_IN_DATE");   
		strCheckout			 = rs.getString("CHECK_OUT_DATE");   
		strSelectManagerRadio= rs.getString("APPROVER_SELECTION");

//NEW		
		strManager           = rs.getString("MANAGER_ID");
		strHod               = rs.getString("HOD_ID");
//		
		strCARD_TYPE		 = rs.getString("CARD_TYPE");

		strCARD_NUMBER1		 = rs.getString("CARD_NUMBER1");
		strCARD_NUMBER2		 = rs.getString("CARD_NUMBER2");
		strCARD_NUMBER3		 = rs.getString("CARD_NUMBER3");
		strCARD_NUMBER4		 = rs.getString("CARD_NUMBER4");
		strCVV_NUMBER		 = rs.getString("CVV_NUMBER");
		strCARD_EXP_DATE	 = rs.getString("CARD_EXP_DATE");
//new
		strReasonForTravel   = rs.getString("REASON_FOR_TRAVEL");
		strReasonForSkip     = rs.getString("REASON_FOR_SKIP");
		strPlace			 = rs.getString("PLACE"); 

//22-02-2007
		strCARD_HOLDER_NAME= rs.getString("CARD_HOLDER_NAME");
        strBoardMember		=	rs.getString("BOARD_MEMBER_ID");
        strCostCentre		=	rs.getString("CC_ID");
//System.out.println("strBoardMember--->"+strBoardMember);
	  

//22-02-2007		
//
		
	}
	rs.close();
	//added by manoj chand on 26 july 2012 to get month and year from card expiry date
	if(strCARD_EXP_DATE!=null && !strCARD_EXP_DATE.equals("")){
	strMonth=strCARD_EXP_DATE.substring(3,5);
	strYear=strCARD_EXP_DATE.substring(6,10);
	}

	/*if(strSelectManagerRadio != null && strSelectManagerRadio.equals("manual"))
	{
      strSql = "SELECT TOP 2(APPROVER_ID) AS APPROVER_ID, ORDER_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_TYPE='I' AND APPLICATION_ID=1 AND STATUS_ID=10 ORDER BY 2";
      rs       =   dbConBean.executeQuery(strSql);  
      while(rs.next())
      {
         if(rs.getRow() == 1)
		 {
			 strManager           = rs.getString("APPROVER_ID");
		 }
		 if(rs.getRow() == 2)
		 {
			 strHod               = rs.getString("APPROVER_ID");
		 }		
	  }
	  rs.close();
	}*/
    

	//strSql ="SELECT TRAVEL_FROM, TRAVEL_TO, RTRIM(LTRIM(TRAVEL_MODE)) AS TRAVEL_MODE, MODE_NAME, RTRIM(LTRIM(TRAVEL_CLASS)) AS TRAVEL_CLASS, RTRIM(LTRIM(TIMINGS)) AS TIMINGS FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravelId+" AND JOURNEY_ORDER=1 AND APPLICATION_ID=1";
	strSql ="SELECT     TRAVEL_FROM, TRAVEL_TO, RTRIM(LTRIM(TRAVEL_MODE)) AS TRAVEL_MODE, MODE_NAME, RTRIM(LTRIM(TRAVEL_CLASS)) AS TRAVEL_CLASS , "+ 
	        " RTRIM(LTRIM(TIMINGS)) AS TIMINGS,ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED  FROM  T_JOURNEY_DETAILS_INT (NOLOCK) WHERE TRAVEL_ID="+strTravelId+" AND JOURNEY_ORDER=1 AND APPLICATION_ID=1";
	
	
	
	
	
    rs       =   dbConBean.executeQuery(strSql);  
    if(rs.next())
    {
		strDepCity           = rs.getString("TRAVEL_FROM"); 
		strArrCity           = rs.getString("TRAVEL_TO");
		strTravelMode1       = rs.getString("TRAVEL_MODE");
		strNameOfAirline1    = rs.getString("MODE_NAME");
		strTravelClass1      = rs.getString("TRAVEL_CLASS");
		strPreferTime1       = rs.getString("TIMINGS");
		strPreferSeatfwd       = rs.getString("SEAT_PREFFERED"); //added new on 07 jan 2009 
		if(strPreferSeatfwd.equalsIgnoreCase("")) 
		{
			strPreferSeatfwd="1"; 
		}
	}
	rs.close();

	strSql = "SELECT  RETURN_FROM, RETURN_TO, dbo.CONVERTDATEDMY1(TRAVEL_DATE) AS RETURN_DATE, RTRIM(LTRIM(TRAVEL_MODE)) AS TRAVEL_MODE, " +
	         " MODE_NAME, RTRIM(LTRIM(TRAVEL_CLASS)) AS TRAVEL_CLASS, RTRIM(LTRIM(TIMINGS)) AS TIMINGS, ISNULL(SEAT_PREFFERED,'1') AS SEAT_PREFFERED "+
             " FROM  T_RET_JOURNEY_DETAILS_INT (NOLOCK) WHERE TRAVEL_ID="+strTravelId+" AND JOURNEY_ORDER=1 AND APPLICATION_ID=1";
	
	
    rs       =   dbConBean.executeQuery(strSql);  
    if(rs.next())
    {
		strDepCity1           = rs.getString("RETURN_FROM");
		strArrCity1           = rs.getString("RETURN_TO");
		strReturnDate        = rs.getString("RETURN_DATE");		
		strTravelMode2       = rs.getString("TRAVEL_MODE");
		strNameOfAirline2    = rs.getString("MODE_NAME");		
		strTravelClass2      = rs.getString("TRAVEL_CLASS");
		strPreferTime2       = rs.getString("TIMINGS");
		strPreferSeatRet       = rs.getString("SEAT_PREFFERED"); //added new on 07 jan 2009 
		if(strPreferSeatRet.equalsIgnoreCase("")) 
		{
			strPreferSeatRet="1"; 
		}
	}
	rs.close();
	}
}

if(strCostCentre==null)
	strCostCentre="0";
//set the meal value
if(strMealId == null)
  strMealId = "1";
//set travel mode 1 and 2
if(strTravelMode1 == null)
   strTravelMode1 = "1";
if(strTravelMode2 == null)
   strTravelMode2 = "1";
//set travel class
if(strTravelClass1 == null)
   strTravelClass1 = "1";
if(strTravelClass2 == null)
   strTravelClass2 = "1";

//set Manager
if(strManager == null)
   strManager = "S";
//set Hod
if(strHod == null)
   strHod = "S";

if(strBoardMember==null)
	strBoardMember="B";
//set selectManager Radio
if(strSelectManagerRadio == null)
   strSelectManagerRadio = "manual";

//set Prefer time
if(strPreferTime1 == null)
   strPreferTime1 = "1";
if(strPreferTime2 == null)
   strPreferTime2 = "1";

//set Visa Comment
if(strVisaRequired == null)
   strVisaRequired = "1";
if(strVisaComment == null)
   strVisaComment = "";
if(strNominee == null)
   strNominee = "";
if(strRelation == null)
   strRelation = "";
if(strInsuranceComment == null)
   strInsuranceComment = "";
if(strHotelBudget == null || strHotelBudget.equals("0"))
   strHotelBudget = "";
if(strBudgetCurrency == null)
   strBudgetCurrency = "USD";
if(strRemarks == null)
   strRemarks = "";

if(strCheckin == null)
   strCheckin = "";
if(strCheckout == null)
   strCheckout = "";



if(strDepCity == null)
   strDepCity = "";
if(strDepDate == null)
   strDepDate = "";
if(strArrCity == null)
   strArrCity = "";
if(strReturnDate == null)
   strReturnDate = "";
if(strNameOfAirline1 == null)
   strNameOfAirline1 = "";
if(strNameOfAirline2 == null)
   strNameOfAirline2 = "";
if(strCARD_NUMBER1==null)
   strCARD_NUMBER1="";
if(strCARD_NUMBER2==null)
	strCARD_NUMBER2="";
if(strCARD_NUMBER3==null)
	strCARD_NUMBER3="";
if(strCARD_NUMBER4==null)
	strCARD_NUMBER4="";
if(strCVV_NUMBER==null)
	strCVV_NUMBER="";

//NEW
if(strReasonForTravel==null)
	strReasonForTravel="";
if(strReasonForSkip==null)
	strReasonForSkip="";
//



//set the site value
if(strSiteId == null)
{
   strSiteId = strSiteIdSS;	
}
if(strSiteId != null && strSiteId.equals("S"))
{
	strSiteId = "0";
}

//set the userid and site id
if(strUserId == null)
{
   strUserId    = Suser_id;
 
   strDesigName = strDesigFullName;         //get name from the session strDesigShortName of application.jsp
}
else if(strUserId.equals("S") || strUserId.equals("-1"))
{
   strDesigName = "";
}
else if(strUserId.equals(Suser_id))
{
	strUserId    = Suser_id;
	
    strDesigName = strDesigFullName;         //get name from the session strDesigFullName of application.jsp
}
else
{
	strSql = "SELECT ISNULL(dbo.DESIGNATIONNAME(DESIG_ID),'') AS DESIG FROM M_USERINFO (NOLOCK) WHERE USERID="+strUserId+" AND STATUS_ID=10 AND APPLICATION_ID=1";
    rs       =   dbConBean.executeQuery(strSql); 
	if(rs.next())
	{
        strDesigName = rs.getString("DESIG"); 
	}
	rs.close();
}

String strUnit_Head="0";
strSql="SELECT A.UNIT_HEAD FROM USER_MULTIPLE_ACCESS AS A INNER JOIN M_USERINFO AS B ON A.USERID = B.USERID WHERE (A.STATUS_ID = 10) AND (B.STATUS_ID = 10) AND (A.UNIT_HEAD = 1) AND A.USERID = "+strUserId+" AND A.SITE_ID = "+strSiteId+" ";
//System.out.println("strSql--->"+strSql);
rs = dbConBean.executeQuery(strSql); 
if (rs.next()) {
	strUnit_Head = rs.getString("UNIT_HEAD");	
}
rs.close();

//added by manoj chand on 01 august 2012 to get cost centre id
rs=null;
strSql =   "SELECT 1 FROM M_COST_CENTRE WHERE SITE_ID="+strSiteId+" AND M_COST_CENTRE.STATUS_ID=10";
rs       =   dbConBean.executeQuery(strSql);
if(rs.next()){
	strShowflag="y";
}
rs.close();

//code added by manoj chand on 19 oct 2012 to CHECK WHETHER site OF USER IS SMP OR NOT.
strSql="SELECT SHOW_APP_LVL_3,MANDATORY_APP_FLAG FROM dbo.M_SITE ms WHERE ms.STATUS_ID=10 and ms.SITE_ID="+strSiteId;
rs       =   dbConBean.executeQuery(strSql);  
if(rs.next())
{
	strAppLvl3flgforBM=rs.getString("SHOW_APP_LVL_3");
	strMandatatoryApvFlag=rs.getString("MANDATORY_APP_FLAG");
}
rs.close();

//System.out.println("strAppLvl3flg--->"+strAppLvl3flg);
//System.out.println("strMandatatoryApvFlag--->"+strMandatatoryApvFlag);

 // get the current date for checking the departureDate and arrivalDate
  Date currentDate = new Date();
  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
  String strCurrentDate = (sdf.format(currentDate)).trim();
  
%>

<!--Java Script -->
<script language=JavaScript>
//code added on 11-Jul-07 by shiv 
/*
function openPolicies()
{
	if(MM_openBrWin('Companies_Policies/<%=strSiteFullName%>/<%=strSiteFullName%>.html','','scrollbars=yes,resizable=yes,width=700,height=300'))
	{
	return true;
   	}
	else
	{
	MM_openBrWin('Companies_Policies/Policies.html','','scrollbars=yes,resizable=yes,width=700,height=300');
	}
	   
}*/
// Function added by vaibhav on jul 2 2010 to change date input format for credit card expiry date

function expiryDate()
{
	document.frm.CARD_EXP_DATE.value ='';
	var selIndex = document.frm.yearSelect.selectedIndex;
	var year = document.frm.yearSelect.options[selIndex].text;
	//alert(year);
	if(year!='YEAR')
	{
		var selIndex = document.frm.monSelect.selectedIndex;
		var month = document.frm.monSelect.options[selIndex].text;
		//alert(month);
		if(month!='MONTH')
		{
			//alert('01'+'/'+month+'/'+year);
			document.frm.CARD_EXP_DATE.value = '01'+'/'+month+'/'+year;
			
		}
	}
}

function CreditCheck(frm)
{
if(document.frm.CARD_TYPE.value=='-1')
	{
		document.frm.cardHolderName.value="";
		//document.frm.CARD_NUMBER1.value="";
		//document.frm.CARD_NUMBER2.value="";
		//document.frm.CARD_NUMBER3.value="";
		//document.frm.CARD_NUMBER4.value="";
		//document.frm.CVV_NUMBER.value="";
		document.frm.CARD_EXP_DATE.value="";

		document.frm.cardHolderName.disabled=true;
		//document.frm.CARD_NUMBER1.disabled=true;
		//document.frm.CARD_NUMBER2.disabled=true;
		//document.frm.CARD_NUMBER3.disabled=true;
		//document.frm.CARD_NUMBER4.disabled=true;
		//document.frm.CVV_NUMBER.disabled=true;
		document.frm.CARD_EXP_DATE.disabled=true;
		document.frm.monSelect.value='';
		document.frm.yearSelect.value='';
		document.frm.monSelect.disabled=true;
		document.frm.yearSelect.disabled=true;
}
else
	{
		document.frm.cardHolderName.disabled=false;
		//document.frm.CARD_NUMBER1.disabled=false;
		//document.frm.CARD_NUMBER2.disabled=false;
		//document.frm.CARD_NUMBER3.disabled=false;
		//document.frm.CARD_NUMBER4.disabled=false; 
		//document.frm.CVV_NUMBER.disabled=false;
		document.frm.CARD_EXP_DATE.disabled=false;
		document.frm.monSelect.disabled=false;
		document.frm.yearSelect.disabled=false;
	}
}

  function setValue()
  {
	  var site               = document.frm.site.value;
	  var username           = document.frm.userName.value;
	  var meal               = document.frm.meal.value;
	  var tMode1             = document.frm.travelMode1.value; 
  	  var tMode2             = document.frm.travelMode2.value; 
	  var tClass1            = document.frm.travelClass1.value; 
	  var tClass2            = document.frm.travelClass2.value; 
	  var age                = document.frm.age.value;
	  var sex                = "1";
	  if(document.frm.sex[0].checked)
	  {
		  sex = "1";
	  }

	  var manager            = document.frm.manager.value;
	  var hod                = document.frm.hod.value;

      var selectManager      = "automatic"; 
  	  if(document.frm.selectManager[0].checked)
	  {
		  selectManager = "manual";
	  }	  


	  var preferTime1        = document.frm.preferTime1.value;                           
	  var preferTime2        = document.frm.preferTime2.value;
      var visa               = "2";	 
	  if(document.frm.visa[0].checked)
	  {
		  visa = "1";
	  }	  
	  
	  //alert("visa is=="+visa);
	  var visaComment        = document.frm.visaComment.value;	 
	  var insurance          = "2";
	  if(document.frm.insurance[0].checked)
	  {
		  insurance = "1";
	  }
	  //alert("insurance is=="+insurance);
       
	  var nominee            = document.frm.nominee.value;	 
	  var relation           = document.frm.relation.value;	 
	  var insuranceComment   = document.frm.insuranceComment.value;	 

	 // var hotel              = "2";
	    var hotel			   = document.frm.hotel.value;
	  if(document.frm.hotel[0].checked)
	  {
		  hotel = "1";
	  }
	  //alert("hotel is=="+hotel);
	  
	  var currency           = document.frm.currency.value;	 
  	  var budget             = document.frm.budget.value;	 
   	  var otherComment       = document.frm.otherComment.value;	 

	  var depCity            = document.frm.depCity.value;	 

	  var depCity1            = document.frm.depCity1.value;	 
	  
	  var depDate            = document.frm.depDate.value;	 
	  var arrCity            = document.frm.arrCity.value;	 
	  
	  var arrCity1           = document.frm.arrCity1.value;	 

	  var returnDate         = document.frm.returnDate.value;	 
	  var nameOfAirline1     = document.frm.nameOfAirline1.value;	 
	  var nameOfAirline2     = document.frm.nameOfAirline2.value;	 
	  
	  var reasonForTravel    = document.frm.reasonForTravel.value;	 
  	  var reasonForSkip      = document.frm.reasonForSkip.value;	 


	  var scriptRunFlag      = "yes";  


	  

	  
	  var travelId            = document.frm.travelId.value;
	  var travelReqId     = document.frm.travelReqId.value;
	  var travelReqNo   = document.frm.travelReqNo.value;
	  if(site == "S")
	  {
		  username = "S";
	  }
	  if(username == "")
	  {
		username = "S"
	  }
	  if(manager == "")
		  manager = "S";
	  if(hod == "")
		  hod = "S";
	   //alert("site is=="+site );
	   //alert("userName is=="+username);
	  window.location.href = "T_IntTrv_Details.jsp?site="+site+"&userName="+username+"&meal="+meal+"&travelMode1="+tMode1+"&travelMode2="+tMode2+"&travelClass1="+tClass1+"&travelClass2="+tClass2+"&age="+age+"&sex="+sex+"&manager="+manager+"&hod="+hod+"&selectManager="+selectManager+"&preferTime1="+preferTime1+"&preferTime2="+preferTime2+"&travelId="+travelId+"&travelReqId="+travelReqId+"&travelReqNo="+travelReqNo+"&visa="+visa+"&visaComment="+visaComment+"&insurance="+insurance+"&nominee="+nominee+"&relation="+relation+"&insuranceComment="+insuranceComment+"&hotel="+hotel+"&currency="+currency+"&budget="+budget+"&otherComment="+otherComment+"&depCity="+depCity+"&depDate="+depDate+"&arrCity="+arrCity+"&returnDate="+returnDate+"&nameOfAirline1="+nameOfAirline1+"&nameOfAirline2="+nameOfAirline2+"&scriptRunFlag="+scriptRunFlag+"&interimId=<%=strIntermiId%>&reasonForTravel="+reasonForTravel+"&reasonForSkip="+reasonForSkip+"&depCity1="+depCity1+"&arrCity1="+arrCity1;
  }

  function setValue1(strFlag)
  {    
	  
	  var smpsitebmflag_val='<%=strAppLvl3flgforBM%>';
       
	  if(strFlag=='user')
	  {		  
		  document.frm.scriptRunFlag.value="yes";
		  document.frm.manager.value = "";
	      document.frm.hod.value = "";
	      
	      if(smpsitebmflag_val=='y'){
				document.frm.boardmember.value = ""
			}
	      
	  }
	  if(strFlag=='site')
	  {
		//added by manoj chand on 03 august 2012
		  if(document.frm.costcentre!=null || document.frm.costcentre!=undefined){
		  document.frm.costcentre.value="0";
		  }
		  document.frm.scriptRunFlag.value="yes";
		  document.frm.userName.value="-1";
		  document.frm.manager.value="S";
		  document.frm.hod.value="S";
		  document.frm.age.value="";
		  document.frm.sex[0].checked=true;
	  }
	  document.frm.action="T_IntTrv_Details.jsp";
	  //alert(document.frm.userName.value);
	  document.frm.submit();

   
  }


/**

 CHANGE BY SAMIR RANJAN PADHI ON (3/12/2007)
 FUNCTION USE FOR DISABLE AND ENABLE THE "Reason for Skipping " TEXTAREA

*/


		function skipDisabled(f2,flag)
		{
		//alert(flag);
	if(flag=='first')
	{
	//JQUERY DROPDOWN FILLING IMPLEMENTAION STARTS
		//$.noConflict();
		jQuery(document).ready(function($) {
			//$("#firstapprover").change(
				//function() {
					//alert('hello...........');
					var siteid= document.frm.site.value;
					var managerId = $("#firstapprover option:selected").val();
					//var urlParams2 = '<%="&SITE_ID="+strSiteIdSS+"&sp_role="+SSstrSplRole+"&reqpage=approver1&traveltype=I"%>';
					var urlParams2 = '<%="&sp_role="+SSstrSplRole+"&reqpage=approver1&traveltype=I"%>';
					var urlParams = "managerId="+managerId+"&SITE_ID="+siteid+urlParams2;
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
			                		//document.getElementById('firstapprover').value='S';
			                }


			            	 
			            },
						error: function(){
							alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
			            }
			          });
			//	}
		//	);
		});

	}//end if

		String.prototype.trim = function() {
			return this.replace(/^\s+|\s+$/g,"");
		}
		//JQUERY DROPDOWN FILLING IMPLEMENTAION ENDS

		
		//JQUERY DROPDOWN FILLING IMPLEMENTAION STARTS
		//$.noConflict();
		if(flag=='second')
			{
		jQuery(document).ready(function($) {
			//$("#firstapprover").change(
				//function() {
					//alert('hello...........');
					var siteid=document.frm.site.value;
					var managerId = $("#secondapprover option:selected").val();
					//var urlParams2 = '<%="&SITE_ID="+strSiteIdSS+"&sp_role="+SSstrSplRole+"&reqpage=approver2&traveltype=I"%>';
					var urlParams2 = '<%="&sp_role="+SSstrSplRole+"&reqpage=approver2&traveltype=I"%>';
					var urlParams = "managerId="+managerId+"&SITE_ID="+siteid+urlParams2;
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
			                		//document.getElementById('secondapprover').value='S';
			                }


			            	 
			            },
						error: function(){
							alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
			            }
			          });
			//	}
		//	);
		});

	}// end if


			if((f2.manager.value != 'S' && f2.manager.value != '') 
				&& (f2.hod.value != 'S' && f2.hod.value != ''))
			{
				f2.reasonForSkip.disabled=true;
				f2.reasonForSkip.value="";
			}

		else if((f2.manager.value == 'S' || f2.manager.value == '') && 
				(f2.hod.value == 'S' || f2.hod.value == ''))
			{
				f2.reasonForSkip.disabled=false;
			}
		
			else if((f2.manager.value != 'S' || f2.manager.value != '') && 
				(f2.hod.value == 'S' || f2.hod.value == ''))
			{
				f2.reasonForSkip.disabled=false;
			}
	
			else if((f2.manager.value == 'S' || f2.manager.value == '') && 
				(f2.hod.value != 'S' || f2.hod.value != ''))
			{
				f2.reasonForSkip.disabled=false;
			}

		}

		// END OF skipDisabled() FUNCTION ON 3/12/2007


  function checkData(f1,actionFlag)
  {
    f1.whatAction.value=actionFlag;
	//alert("Travel Id =="+f1.travelId.value);
	//alert("Travel Req Id =="+f1.travelReqId.value);
	//return false;
	
	//added by manoj on 08 Dec 2011 to prevent to going save & next when no traveller name is selected. || f1.userName.value == '-1'
	if(f1.userName.value == 'S' || f1.userName.value == '' || f1.userName.value == '-1')
	{
       alert('<%=dbLabelBean.getLabel("alert.global.travellername",strsesLanguage)%>');
	   f1.userName.focus();
	   return false;  
	}
	if(f1.age.value=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.global.age",strsesLanguage)%>');
		f1.age.focus();
		return false;
	}

	var x='<%=strAppLvl3flg%>';
	var y='<%=strShowflag%>';
	if(x=='Y' && y=='y'){
	if(f1.costcentre.value=='0'){
		alert('<%=dbLabelBean.getLabel("alert.global.costcentre",strsesLanguage)%>');
		f1.costcentre.focus();
		return false;
	}
	}	
    if(f1.visa[1].checked)
	{
       if(f1.visaComment.value=="")
		{  
		  alert('<%=dbLabelBean.getLabel("alert.global.visacomments",strsesLanguage)%>');
		  f1.visaComment.focus();
		  return false;
		}
	}

	if(f1.depCity.value=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
		f1.depCity.focus();
		return false;
	}
	if(f1.arrCity.value=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
		f1.arrCity.focus();
		return false;
	}
    if(f1.depDate.value=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>'); 
		f1.depDate.focus();
		return false;
	}
	
    if(f1.depCity1.value!=''  ||  f1.arrCity1.value!=''  || f1.returnDate.value!='')
		{

		 if(f1.depCity1.value=='')
	         {
		     alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
		     f1.depCity1.focus();
		     return false;
	        }
	    if(f1.arrCity1.value=='')
	       {
		     alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
		     f1.arrCity1.focus();
	     	return false;
        	}
       if(f1.returnDate.value=='')
	       {
	    	alert('<%=dbLabelBean.getLabel("alert.global.departuredate",strsesLanguage)%>');
		    f1.returnDate.focus();
		   return false;
	        }
			 
  }
	if(f1.nameOfAirline1.value=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.global.preferredairline",strsesLanguage)%>');
		f1.nameOfAirline1.focus();
		return false;
	}
	
   /* if(f1.returnDate.value=='')
	{
		alert("Please fill the Departure Date from Destination");
		f1.returnDate.focus();
		return false;
	}*/
	if(f1.returnDate.value!='')
	{
		//spaceChecking(f1.nameOfAirline2);
		if(f1.nameOfAirline2.value == '')
		{
		  alert('<%=dbLabelBean.getLabel("alert.global.preferredairline",strsesLanguage)%>');
		  f1.nameOfAirline2.focus();
		  return false;
		}
	}
	if(f1.insurance[0].checked)
	{
       //alert("11");
       if(f1.nominee.value=="")
		{
		  alert('<%=dbLabelBean.getLabel("alert.global.nominee",strsesLanguage)%>');
		  f1.nominee.focus();
		  return false;
		}
		if(f1.relation.value=="")
		{
		  alert('<%=dbLabelBean.getLabel("alert.createrequest.relationwithnominee",strsesLanguage)%>');
		  f1.relation.focus();
		  return false;
		}
	}

	if(f1.insurance[1].checked)
	{
		if(f1.insuranceComment.value=="")
		{
		  alert('<%=dbLabelBean.getLabel("alert.global.insurancecomment",strsesLanguage)%>');
		  f1.insuranceComment.focus();
		  return false;
		}
	}
///sks 16122007
   if(f1.reasonForTravel.value == "")
	{
		alert('<%=dbLabelBean.getLabel("alert.global.enterreasonfortravel",strsesLanguage)%>');
		f1.reasonForTravel.focus();
		return false;	
	}
///sks 16122007

//code added by manoj chand on 23 july 2013 to make mandatory selection of user for mssl unit.
var var_mand_flag = '<%=strMandatatoryApvFlag%>';
if(var_mand_flag=='Y'){
	if(f1.manager.value=='S' || f1.hod.value=='S'){
		alert('<%=dbLabelBean.getLabel("alert.createrequest.bothapprovallevelismandatory",strsesLanguage)%>');
		if(f1.manager.value=='S')
			frm.manager.focus();
		else
			frm.hod.focus();
		return false;
	}
	
}else{
 //code added by manoj chand on 28 March 2012 to validate at least one level approver is selected.
 //code added by manoj chand on 04 April 2012 this check will work only when travel is not equal to unit head.
	var divflag='<%=strAppLvl3flg%>';
	var unitHeadFlag='<%=strUnit_Head%>';
	//alert('unitHeadFlag--->'+unitHeadFlag);
	if(divflag=='Y' && unitHeadFlag!='1'){
		if(f1.manager.value=='S' && f1.hod.value=='S'){
			alert('<%=dbLabelBean.getLabel("alert.global.approvallevel1or2",strsesLanguage)%>');
			frm.manager.focus();
			return false;
		}
	}

	if(f1.selectManager[0].checked)
	{
		if(f1.manager.disabled == false)
		{
			//new
			if((f1.manager.value == 'S' || f1.manager.value == '') && (f1.hod.value == 'S' || f1.hod.value == '')) 
			{
			   //alert("Please select the Manager");
			   //alert("Please select the Approval Level 1 or Approval Level 2 or both");
			   if(f1.reasonForSkip.value == '')
			   {
					alert('<%=dbLabelBean.getLabel("alert.global.reasonforskippingapprovallevel1or2",strsesLanguage)%>');
				   //f1.manager.focus();
				   frm.reasonForSkip.focus();				
				   return false;  
			   }
			}
			else if((f1.manager.value == 'S' || f1.manager.value == '') && (f1.hod.value != 'S' || f1.hod.value != ''))  
			{
			   if(f1.reasonForSkip.value == '')
			   {
					alert('<%=dbLabelBean.getLabel("alert.global.reasonforskippingapprovallevel1",strsesLanguage)%>');
					frm.reasonForSkip.focus();				
					return false;  
			   }
			}
			else if((f1.manager.value != 'S' || f1.manager.value != '') && (f1.hod.value == 'S' || f1.hod.value == ''))
			{
			   if(f1.reasonForSkip.value == '')
			   {
					alert('<%=dbLabelBean.getLabel("alert.global.reasonforskippingapprovallevel2",strsesLanguage)%>');
					frm.reasonForSkip.focus();				
					return false;  
			   }
			}
		
		}
	}
}//end else block
	//code added by manoj chand on 28 March 2012 to make mandator selection for board member
	var smpsitebmflag_val='<%=strAppLvl3flgforBM%>';
	if(smpsitebmflag_val=='y' && f1.boardmember!=undefined){
		if((f1.boardmember.value!=null && (f1.boardmember.value=='B' || f1.boardmember.value==''))){
			alert('<%=dbLabelBean.getLabel("alert.global.boardmember",strsesLanguage)%>');
			frm.boardmember.focus();
			return false;
		}
	}
	//approverList();


	if(f1.hotel.value == "1" || f1.hotel.value=="2")
	{
		if(f1.place.value == "")
		{
			alert('<%=dbLabelBean.getLabel("alert.global.preferredplace",strsesLanguage)%>');
			f1.place.focus();
			return false;
		} 		
		if(f1.checkin.value == "")
		{
			alert('<%=dbLabelBean.getLabel("alert.global.checkindate",strsesLanguage)%>');
			f1.checkin.focus();
			return false;
		}
		if(f1.checkout.value == "")
		{
			alert('<%=dbLabelBean.getLabel("alert.global.checkoutdate",strsesLanguage)%>');
			f1.checkout.focus();
			return false;
		}
		if(f1.hotel.value == "1")
		{
			if(f1.budget.value=="" || f1.budget.value=="0")
			{
			  alert('<%=dbLabelBean.getLabel("alert.global.budget",strsesLanguage)%>');
			  f1.budget.focus();
			  return false;
			}
		}
	}

	//code added for showing alert if user dose not required accommodation in his journey on 4th jan 2008 by shiv sharma 
 	if(f1.hotel.value == "0")
	  {
	 
		if (f1.otherComment.value=='')
		  {  
			alert('<%=dbLabelBean.getLabel("alert.global.enterremarksifaccomodationnotrequired",strsesLanguage)%>');
		      f1.otherComment.focus();
		     return false;
		  }

	}

//new

//

	var todayDate  =  f1.todayDate.value;  
    var depDate    =  f1.depDate.value;
    var returnDate =  f1.returnDate.value;
    var flag = checkDate(f1,todayDate,depDate,f1.todayDate,f1.depDate,'<%=dbLabelBean.getLabel("alert.global.departuredateoffwdjourneynotsmallerthantodaydate",strsesLanguage)%>','no');
    if(flag == false)
  	  return flag;
	if(returnDate != null && returnDate != '')
	{
 	  flag = checkDate(f1,todayDate,returnDate,f1.todayDate,f1.returnDate,'<%=dbLabelBean.getLabel("alert.global.departuredateofreturnjourneynotsmallerthantodyadate",strsesLanguage)%>','no');
      if(flag == false)
  	    return flag; 
	  flag = checkDate(f1,depDate,returnDate,f1.depDate,f1.returnDate,'<%=dbLabelBean.getLabel("alert.global.departuredateofreturnjourneynotsmallerthandeptdateoffwdjourney",strsesLanguage)%>','no');
      if(flag == false)
  	    return flag; 
	}

    if(f1.hotel.value == "1" || f1.hotel.value=="2")
    { 
		var checkInDate   = f1.checkin.value;
		var checkOutDate  = f1.checkout.value;
		flag =  checkDate(f1,todayDate,checkInDate,f1.todayDate,f1.checkin,'<%=dbLabelBean.getLabel("alert.global.checkindatecannotsmallerthantodaydate",strsesLanguage)%> ','no');
		if(flag == false)
		  return flag; 
		flag =  checkDate(f1,todayDate,checkOutDate,f1.todayDate,f1.checkout,'<%=dbLabelBean.getLabel("alert.global.checkoutdatecannotsmallerthantodaydate",strsesLanguage)%>','no');
		if(flag == false)
		  return flag; 
		flag =  checkDate(f1,checkInDate,checkOutDate,f1.checkin,f1.checkout,'<%=dbLabelBean.getLabel("alert.global.checkoutdatecannotsmallerthancheckindate",strsesLanguage)%>','no');
		if(flag == false)
		  return flag; 
		flag =  checkDate(f1,depDate,checkInDate,f1.depDate,f1.checkin,'<%=dbLabelBean.getLabel("alert.global.checkindatecannotsmallerthandeparturedate",strsesLanguage)%>','no');
		if(flag == false)
		  return flag; 
		flag =  checkDate(f1,checkOutDate,returnDate,f1.returnDate,f1.checkout,'<%=dbLabelBean.getLabel("alert.global.checkoutdatecannotbegreaterthandeparturedate",strsesLanguage)%>','no');
		if(flag == false)
		  return flag; 

	}

 // Credit card entry in not mendatory . changes done by shiv sharma on 2/2/2009
//if(f1.hotel.value == "1" || f1.hotel.value=="2")
	{
   
  if(f1.CARD_TYPE.value == "-1"){
   //alert("Credit Card is mandatory, if you required Hotel/Transit House for accommodation on travelling.");
  // f1.CARD_TYPE.focus();
  // return false;
   }else{ 
   		if(f1.CARD_TYPE.value != -1 )
	     {   
		   if(f1.cardHolderName.value == "")
	        {
			alert('<%=dbLabelBean.getLabel("alert.global.creaditcardholdername",strsesLanguage)%>');
			f1.cardHolderName.focus();
			return false;
		   }
		/*if(f1.CARD_NUMBER1.value == "" || f1.CARD_NUMBER1.value.length < 4)
	    {
			alert("Please enter Credit Card Number ");
			f1.CARD_NUMBER1.focus();
			return false;
		}
		
  	    if(f1.CARD_NUMBER2.value == "" || f1.CARD_NUMBER2.value.length < 4)
		{
			alert("Please enter Credit Card Number");
			f1.CARD_NUMBER2.focus();
			return false;
		}
	    if(f1.CARD_NUMBER3.value == "" || f1.CARD_NUMBER3.value.length < 4)
		{
			alert("Please enter Credit Card Number");
			f1.CARD_NUMBER3.focus();
			return false;
		}

		if(f1.CARD_NUMBER4.value == "" || f1.CARD_NUMBER4.value.length < 4)
		{
			alert("Please enter Credit Card Number");
			f1.CARD_NUMBER4.focus();
			return false;
		}
		*/ 
		
	    if(f1.CARD_EXP_DATE.value == "")
		{
			alert('<%=dbLabelBean.getLabel("alert.global.creditcardexpirydate",strsesLanguage)%>');
			//commented by vaibhav
			//f1.CARD_EXP_DATE.focus();
			if(f1.monSelect.value==''){
			f1.monSelect.focus();
			}
			else{
				if(f1.yearSelect.value==''){
					f1.yearSelect.focus();
				}
				}
			return false;
		}
  	   /*if(f1.CVV_NUMBER.value == "" || f1.CVV_NUMBER.value.length < 3)
		{
			alert("Please enter Credit Card 3 Digit CVV Number");
			f1.CVV_NUMBER.focus();
			return false;
		}*/
	   }
	}
	//return true;
  }	
	var CARD_EXP_DATE = f1.CARD_EXP_DATE.value;
	var flag = checkDate(f1,todayDate,CARD_EXP_DATE,f1.todayDate,f1.CARD_EXP_DATE,'<%=dbLabelBean.getLabel("label.global.creditcardexpired",strsesLanguage)%> ','no');
	if(flag == false)
	  return flag;

    //added code by sachin on 2/17/2009 
	f1.saveProceed.disabled=true;  //added by sachin
	f1.save.disabled=true;  //added by sachin
	f1.saveExit.disabled=true;  //added by sachin
	
	f1.submit();

	return true;
  }


function visaOnClick(f1)
{
	if(f1.visa[0].checked)
	{
		f1.visaComment.value="";
		f1.visaComment.disabled=true;
	}
	if(f1.visa[1].checked)
	{
		f1.visaComment.disabled=false;
		f1.visaComment.focus();
	}
}
function insuranceOnClick(f1)
{
	if(f1.insurance[0].checked)
	{
		f1.insuranceComment.value="";
		f1.nominee.disabled=false;
		f1.relation.disabled=false;
		f1.insuranceComment.disabled=true;
		f1.nominee.focus();
		
	}
	if(f1.insurance[1].checked)
	{
		f1.nominee.value="";
		f1.relation.value="";
		f1.nominee.disabled=true;
		f1.relation.disabled=true;
		f1.insuranceComment.disabled=false;
		f1.insuranceComment.focus();				
	}
}

function hotelOnClick(f1)
{
	if(f1.hotel[0].checked)
	{
		f1.budget.disabled=false;
		f1.currency.disabled=false;
		f1.budget.focus();
		
	}
	if(f1.hotel[1].checked)
	{
		f1.budget.value="";
		f1.budget.disabled=true;
		f1.currency.disabled=true;
		//f1.otherComment.focus();		
	}
}

function transitOnClick(f1)
{
	//alert(f1.hotel.value);
	var hotelValue = f1.hotel.value;
	if(hotelValue != null && hotelValue == "0")
	{
		document.getElementById('hidethis').style.display = 'none';
		f1.budget.value="";
		//f1.place.value="";
		f1.budget.disabled=true;
		f1.currency.disabled=true;
		f1.checkin.disabled=true;
		f1.checkout.disabled=true;
		f1.place.disabled=true;
	}
	else
	{
		if(hotelValue != null && hotelValue == "1"){
			document.getElementById('hidethis').style.display = 'none'; 
		}
		if(hotelValue != null && hotelValue == "2"){
			document.getElementById('hidethis').style.display = ''; 
		}
		f1.budget.disabled=false;
		f1.place.disabled=false;
		f1.currency.disabled=false;
		f1.checkin.disabled=false;
		f1.checkout.disabled=false;
		f1.place.disabled=false;
		f1.place.focus();
	}	

 

}

function selectManagerOnClick(f1)  //selectManager Radio Button is clicked
{
	if(f1.selectManager[0].checked)
	{
		f1.manager.disabled=false;
		f1.hod.disabled=false;
	}
	if(f1.selectManager[1].checked)
	{
		f1.manager.disabled=true;
		f1.hod.disabled=true;
		var userid = document.frm.userName.value;	
		var win = window.open('T_Travel_ManagerAuto.jsp?userid='+userid+'&traveltype=INT&strSiteId='+ <%=strSiteIdSS%>,'AutoSelection','scrollbars=yes,resizable=no,width=550,height=150');
		win.focus();
	}
}

//Checking the date of departure and arrival date from the current date(second date should not be the smalle from the first date
function checkDate(form1,firstDate,secondDate,firstDateName,secondDateName,message1,message2)
{
	//Second date should be equal or greater from the first date
	//get today date info
	var todayDate=firstDate;                //today date
	//alert("firstDate is=="+todayDate);
	var dDate=secondDate;
	//alert("dob is"+DOB);

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
	
	if(year>year1)
	{
		 alert(message1);
		 secondDateName.value="";
		 //Commented by vaibhav
		 //secondDateName.focus();
		 return false;
	}//end of if
	
	if((year==year1)&&(month>month1))
	{
		 alert(message1);
		 secondDateName.value="";
		 //commented by vaibhav
		// secondDateName.focus();
		 return false;
	}//end of elseif
	
	if((year==year1)&&(month==month1)&&(day>day1))
	{		
		 alert(message1);
		 secondDateName.value="";
		 //Commented by vaibhav
		 //secondDateName.focus();
		 return false;
	}//end of elseif
}

function test1(obj1, length, str)
{	
	var obj;

	if(obj1=='age')
	{
		obj = document.frm.age;
	}
	if(obj1=='depCity')
	{
		 obj = document.frm.depCity;
	}
	
	if(obj1=='arrCity')
	{
		 obj = document.frm.arrCity;
	}
	if(obj1=='nameOfAirline1')
	{
		 obj = document.frm.nameOfAirline1;
	}	
	if(obj1=='depCity1')
	{
		 obj = document.frm.depCity1;
	}	
	if(obj1=='arrCity1')
	{
		 obj = document.frm.arrCity1;
	}
	if(obj1=='nameOfAirline2')
	{
		 obj = document.frm.nameOfAirline2;
	}	
	if(obj1=='nominee')
	{
		 obj = document.frm.nominee;
	}	
	if(obj1=='relation')
	{
		 obj = document.frm.relation;
	}	
	if(obj1=='visaComment')
	{
		 obj = document.frm.visaComment;
		 upToTwoHyphen(obj);
	}
	if(obj1=='insuranceComment')
	{
		 obj = document.frm.insuranceComment;
		 upToTwoHyphen(obj);
	}
	if(obj1=='otherComment')
	{
		 obj = document.frm.otherComment;
		 upToTwoHyphen(obj);
	}
//new
	if(obj1=='reasonForTravel')
	{
		 obj = document.frm.reasonForTravel;
		 upToTwoHyphen(obj);
	}
	if(obj1=='reasonForSkip')
	{
		 obj = document.frm.reasonForSkip;
		 upToTwoHyphen(obj);
	}
//
	if(obj1=='budget')
	{
		 obj = document.frm.budget;
		 zeroChecking(obj);
	}  

//New
	if(obj1=='place')
	{
		 obj = document.frm.place;
	}  
//



///22-02-2007
if(obj1=='cardHolderName')
	{
		 obj = document.frm.cardHolderName;
	} 

///22-02-2007

	if(obj1=='CARD_NUMBER1')
	{
		 obj = document.frm.CARD_NUMBER1;
	} 

	if(obj1=='CARD_NUMBER2')
	{
		 obj = document.frm.CARD_NUMBER2;
	} 

	if(obj1=='CARD_NUMBER3')
	{
		 obj = document.frm.CARD_NUMBER3;
	} 

	if(obj1=='CARD_NUMBER4')
	{
		 obj = document.frm.CARD_NUMBER4;
	} 

	if(obj1=='CVV_NUMBER')
	{
		 //obj = document.frm.CVV_NUMBER;
	} 

	//alert(""+obj11);
	charactercheck(obj,str);
	limitlength(obj, length);
	//zeroChecking(obj); //function for checking leading zero and spaces
	spaceChecking(obj);
}
function MM_openBrWin(theURL,winName,features)
 { 
		   window.open(theURL,winName,features);
 }
 function MM_openBrWindow()
 { 
   var id =	document.frm.interimId.value;
   window.open('InternationalInterimJourney.jsp?interimTravelId='+id+'&actualTravelId=<%=strTravelId%>','SEARCH','scrollbars=yes,resizable=yes,width=800,height=480');
 }
 function setId(id) 
 {
	document.frm.interimId.value = id;

 }


/*function skip(frm,skip)
{
	if(skip == "skip")
	{
		//alert("Plese give the reason for skip approval selection");
		if(confirm('Are you sure you want to skip the Approval Selection 1 and Approval Selection 2 !'))
		{
			alert("Please give the reason for skipping Approval Selection.");
			frm.manager.disabled		= true;
			frm.hod.disabled			= true;
			frm.reasonForSkip.disabled  = false;
			frm.skip11.disabled         = true;
			frm.unskip11.disabled		= false;
			frm.reasonForSkip.value     = "";
			frm.reasonForSkip.focus();
			return true;
		}
		else
		{
			return false;
		}
	}
	if(skip == "unskip")
	{
		//alert("Plese give the reason for skip approval selection");
		if(confirm('Are you sure you want to unskip the Approval Selection 1 and Approval Selection 2 !'))
		{
			frm.manager.disabled		= false;
			frm.hod.disabled			= false;
			frm.reasonForSkip.disabled  = true;
			frm.skip11.disabled         = false;
			frm.unskip11.disabled       = true;
			frm.reasonForSkip.value     = "";
			return true;
		}
		else
		{
			return false;
		}
	}
}*/

//function for showing the default approver list
function defaultApproverList(frm)
{
	//traveller id fetch and send in url by manoj chand on 17 april 2012
	var siteId = document.frm.site.value;
	var travellerId=document.frm.userName.value;
	var url = 'T_DefaultApproverList.jsp?traveltype=INT&siteId='+siteId+'&traveller='+travellerId;;
	//window.open('T_DefaultApproverList.jsp?traveltype=INT&siteId=<%=strSiteIdSS%>','DefaultApprovers','scrollbars=yes,resizable=no,width=550,height=350');
	window.open(url,'DefaultApprovers','scrollbars=yes,resizable=no,width=550,height=350');
	
}




function key(e) 
{
  var k = document.layers ? e.which :document.all ? event.keyCode :document.getElementById ? e.keyCode : 0;
  if (k==8) 
  {
    return false;
  }  
}
if (typeof window.event != 'undefined')
     document.onkeydown = function()
                          {
                             //alert(event.srcElement.tagName.toUpperCase());
                             if (event.srcElement.tagName.toUpperCase() != 'INPUT' && event.srcElement.tagName.toUpperCase() !='TEXTAREA')
                                return (event.keyCode != 8);
                           }
   else
     document.onkeypress = function(e)
                           {
                             if (e.target.nodeName.toUpperCase() != 'INPUT' && e.target.nodeName.toUpperCase() != 'TEXTAREA')
                             return (e.keyCode != 8);
                           }

</script>
</head>
  <%  //code added by Shiv on 28 -May-07 for checking workflow for selected  site open
      //added new to flag to configure dynamic workflow of SMR sites on 26-Oct-09  
            if(strSiteId!="0")
		     {   
				  strSql="SELECT APPROVER_ID FROM M_DEFAULT_APPROVERS  (NOLOCK) WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='I' AND   sp_role="+SSstrSplRole+" and STATUS_ID=10 AND APPLICATION_ID=1";  
		             rs  =  dbConBean.executeQuery(strSql);  
					   if(!rs.next())
                          {  strButtonState="disabled";  
						       %>
								   <script language="javascript">
									alert('<%=dbLabelBean.getLabel("alert.global.cannotproceed",strsesLanguage)%>');
									</script> 
					           <%
		           		    }
		                   rs.close();	 
            } 
  //code added on 28 -May-07 for checking workflow for  selected  site close
  %>

<!--
// CHANGE BY SAMIR RANJAN PADHI ON (3/12/2007)
// FUNCTION skipDisabled() USE FOR DISABLE AND ENABLE THE "Reason for Skipping " TEXTAREA 
// THIS FUNCTION ADDED IN "onLoad()" EVENT OF "body"
-->

<body onLoad="CreditCheck();skipDisabled(frm,'abcd');">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="85%" height="36" class="bodyline-top"><img src="images/NewHeading1.png?buildstamp=2_0_0" width="374" height="26" /></td>
    <td width="15%" align="center" class="bodyline-top"><img src="images/BigIcon.gif?buildstamp=2_0_0" width="46" height="31" /></td>
  </tr> 
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:-10px; padding-top:0px;">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><div align="center"><img src="images\newTabs\1.png?buildstamp=2_0_0" width="486" height="43" /></div></td>
  </tr>
</table>  
<form name="frm" action="T_IntTrv_Details_Post.jsp" style="margin-top:-20px; padding-top:0px;" >   
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="center" style="padding-top:5px;">
	    <table width="85%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="14" background="images/index_01.png?buildstamp=2_0_0"></td>
            <td height="29" align="left" background="images/headerBG.png?buildstamp=2_0_0"><img src="images/formTitIcon.png?buildstamp=2_0_0" width="30" height="29" align="absmiddle" /><span class="formTit"><%=dbLabelBean.getLabel("label.createrequest.createinternationalrequest",strsesLanguage) %> </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="#" title="Company Policy" onClick="<% 
			  // code by sanjeet kumar on 16-july-2007 for giving proper information if site not uploaded.
			  if(UploadFile.exists()) {
			  	%> MM_openBrWin('Companies_Policies/<%=strSiteFullName%>/<%=strSiteFullName%>.html','','scrollbars=yes,resizable=yes,width=700,height=300')
				<%; } else{%> MM_openBrWin('Companies_Policies/notexist.html','','scrollbars=yes,resizable=yes,width=700,height=300')<%;} %>" ><img src="images/IconPolicy.png?buildstamp=2_0_0" width="69" height="16" border="0" /></a><span class="formTit" style="text-align:right">
			<a href="#" onClick="MM_openBrWin('helpinternational travel.html#300a','','scrollbars=yes,resizable=yes,width=700,height=300')">
			  <img src="images/help.png?buildstamp=2_0_0" width="44" height="16" border="0" >
            </a>
		  </td>
          
            <td width="11" background="images/index_03.png?buildstamp=2_0_0"></td><br>

          </tr>
          <tr>
          <td width="14" background="images/index_01.png?buildstamp=2_0_0"></td>
          <td valign="top" bgcolor="#FFFFFF">
		  
		    <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="25" colspan="2" align="left" valign="bottom" bgcolor="#FFFFFF" class="formfirstfield"><%=dbLabelBean.getLabel("label.global.basicinformation",strsesLanguage) %> <%=strMessage%> </td>
              </tr>
              <tr>
                <td height="30" colspan="2" align="left" bgcolor="#FFFFFF" class="formtxt"><%=dbLabelBean.getLabel("label.global.fieldsmarkedwithanasterisk",strsesLanguage) %> (<span class="starcolour">*</span>) <%=dbLabelBean.getLabel("label.global.aremandatory",strsesLanguage) %></td>
              </tr>
              <tr>
                <td width="51%" height="34" align="left" valign="top" bgcolor="#FFFFFF" class="forminnerbrdff">
				  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="30" colspan="2" valign="bottom" class="label2"><span class="label1"><%=dbLabelBean.getLabel("label.global.personaladdress",strsesLanguage) %></span></td>
                    </tr>
                    <tr>
                      <td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.createrequest.selectunit",strsesLanguage) %> </td>      
                      <td width="49%" height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.createrequest.travellername",strsesLanguage) %><span class="starcolour">*</span></td>
                    </tr>
                    <tr>
                      <td height="30" valign="top">
                        <select name="site" onChange= "return setValue1('site');"    class="textBoxCss"><!--Site  disabled-->
                           
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
<%                    }
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
                   
                      <td valign="top">
                        <span class="formtr11"> 
                          <select name="userName" onChange= "return setValue1('user');"  class="textBoxCss"><!--Traveller Name -->
                            <option value="-1" selected><%=dbLabelBean.getLabel("label.createrequest.travellername",strsesLanguage) %></option>
							<%
                             //For Population of Name Combo according to the Site 
                         
                             
                             //System.out.println("ssflage===="+ssflage);
							//Query changed for showing all user of UNit if usr is LA only for SMR on 04-03-2010
							if(ssflage.equals("1") && strAppLvl3flg.equalsIgnoreCase("N")){
								if(SuserRoleOther.equals("LA")){
									 // strSql =   "select userid, dbo.user_name(userid) As UserName from M_userInfo (NOLOCK) where site_id="+strSiteId+" and status_id=10 and application_id=1 order by 2";
									 strSql=" SELECT     USERID, DBO.USER_NAME(USERID) AS USERNAME "+
								 "FROM         M_USERINFO WITH (NOLOCK) WHERE     (SITE_ID = "+strSiteId+") AND (STATUS_ID = 10) AND (APPLICATION_ID = 1) "+
								 " UNION SELECT USERID,DBO.USER_NAME(USERID) AS USERNAME "+
								 " FROM USER_MULTIPLE_ACCESS WHERE (SITE_ID = "+strSiteId+") AND (STATUS_ID = 10) ORDER BY USERNAME";
									  //System.out.println("strSql------LA---->"+strSql);
								}else{
									//query opened by manoj chand on 06 sept 2012 to show originator only his name in select user combobox.
									strSql =   "select userid, dbo.user_name(userid) As UserName from M_userInfo (NOLOCK) where userid="+Suser_id+" and status_id=10 and application_id=1 order by 2";
									/*strSql=" SELECT     USERID, DBO.USER_NAME(USERID) AS USERNAME "+
								 "FROM         M_USERINFO WITH (NOLOCK) WHERE     (SITE_ID = "+strSiteId+") AND (STATUS_ID = 10) AND (APPLICATION_ID = 1) "+
								 " UNION SELECT USERID,DBO.USER_NAME(USERID) AS USERNAME "+
								 " FROM USER_MULTIPLE_ACCESS WHERE (SITE_ID = "+strSiteId+") AND (STATUS_ID = 10) ORDER BY USERNAME";*/
									//System.out.println("strSql------ELSE LA---->"+strSql);
								} 
								
							}else{
							// strSql =   "select userid, dbo.user_name(userid) As UserName from M_userInfo (NOLOCK) where site_id="+strSiteId+" and status_id=10 and application_id=1 order by 2";
							// CONDITION FOR LA OR UNIT HEAD =1 IS ADDED BY MANOJ CHAND ON 05 AUG 2013
							 strSql=" SELECT     USERID, DBO.USER_NAME(USERID) AS USERNAME "+
								 "FROM         M_USERINFO WITH (NOLOCK) WHERE     (SITE_ID = "+strSiteId+") AND (STATUS_ID = 10) AND (APPLICATION_ID = 1) "+
								 " UNION SELECT USERID,DBO.USER_NAME(USERID) AS USERNAME "+
								 " FROM USER_MULTIPLE_ACCESS WHERE (SITE_ID = "+strSiteId+") AND (USER_MULTIPLE_ACCESS.ROLE_ID='LA' OR  USER_MULTIPLE_ACCESS.UNIT_HEAD=1) AND (STATUS_ID = 10) ORDER BY USERNAME";
							// System.out.println("strSql------ELSE---->"+strSql);
							}
                             rs       =   dbConBean.executeQuery(strSql);  
                             while(rs.next())
                             {
								%>							  
                              <option value="<%=rs.getString("UserId")%>"><%=rs.getString("UserName")%></option>
									<%
                         	 }
						 
							 
							 rs.close();	  
%>
                          </select>
                          <script language="javascript">
						    //alert("<%=strUserId%>");
						    document.frm.userName.value="<%=strUserId%>";							
                          </script>
                        </span>
                      </td>
                    </tr>
                    <tr>
                      <td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage) %></td> 
                      <td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.age",strsesLanguage) %></td>         
                    </tr>
                    <tr>
                      <td height="30" valign="top">                                        <!--DESIGNATION-->
				        <input name="designation" value="<%=strDesigName%>" readonly type="text" class="textBoxCss" id="test232" size="15" disabled="disabled" />
				      </td>
<%
//For finding the date of birth of traveller

if(strUserId.equals("") || strUserId.equals("S")) 
{
  strAge = "";
}
else
{
  //@Gaurav 16-May-2007 Changed the query needed for the Gender 
  
	 //code change for showing age(Yr,month,days  ) to user but not storing-------on 03-Mar-08 by shiv sharma     
  strSql = "SELECT dbo.CalAge_YYMMDD(DOB,GETDATE()), GENDER FROM M_USERINFO (NOLOCK) WHERE USERID="+strUserId;


 
  rs       =   dbConBean.executeQuery(strSql);  
  if(rs.next())
  {
	strAge = rs.getString(1);
	strGender=rs.getString(2);	
  }  
  //@Gaurav End of Code
  rs.close();

  if(strAge == null)
    strAge = "";
  if(strAge != null && strAge.equals("0"))
    strAge="";
  if(strAge != null && strAge.equals("-1"))
    strAge="";
 

	  strSql = "SELECT dbo.CALAGE(DOB,GETDATE()), GENDER FROM M_USERINFO (NOLOCK) WHERE USERID="+strUserId;
	  rs       =   dbConBean.executeQuery(strSql);  
	  if(rs.next())
	  {
		actualAge = rs.getString(1);
	  }  
	  rs.close();
	  if(actualAge == null)
		actualAge = "";
	  if(actualAge != null && actualAge.equals("0"))
		actualAge="";
	  if(actualAge != null && actualAge.equals("-1"))
		actualAge="";

}
///if(strAge == null)
 // strAge = "";

%>
                      <td height="30" valign="top">   <!--AGE-->
					    <input name="age" value="<%=strAge%>" readOnly type="text" class="textBoxCss" size="25"   maxlength="2" disabled="disabled" /> 
					  </td>
                    </tr>

                    <tr>
                      <td height="25" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage) %></span></td><!--SEX-->
                      <td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.mealpreference",strsesLanguage) %>
                        <!-- added by manoj chand on 01 aug 2012 to show cost centre for SMP division -->
                    <% if(strAppLvl3flg.trim().equalsIgnoreCase("Y") && strShowflag.equalsIgnoreCase("y")) {
                    %>
                    &nbsp;&nbsp;&nbsp;<%= dbLabelBean.getLabel("label.createrequest.costcentre",strsesLanguage) %><span class="starcolour">*</span>                  
                    <%} %>
                      
                      
                      
                      
                      
                      </td><!--MEAL-->
                    </tr>
                    <tr>
                      <td height="30" valign="top">
					  
					  
					 <!--@Gaurav  Introduced for the Gender, this code is compatible to the previous options where User has not 
					   entered the gender i.e GENDER =null-->
		    		     <%						
						if(strGender!=null){
								if(strGender.equals("Male")  ){%>
									<input name="sex" type="radio" value="1" checked disabled/><span class="label2"><%=dbLabelBean.getLabel("label.global.male",strsesLanguage) %> 	
									<input name="sex" type="radio" value="2" disabled/><%=dbLabelBean.getLabel("label.global.female",strsesLanguage) %></span>
									<% strSex= "1"; %>
							  <%}else{%>
									<input name="sex" type="radio" value="1"  disabled/><span class="label2"><%=dbLabelBean.getLabel("label.global.male",strsesLanguage) %> 	
									<input name="sex" type="radio" value="2" checked disabled/><%=dbLabelBean.getLabel("label.global.female",strsesLanguage) %></span>
									<% strSex= "2"; %>									
								<%}
					  }else{%>
						  <input name="sex" type="radio" value="1" checked /><span class="label2"><%=dbLabelBean.getLabel("label.global.male",strsesLanguage) %> 	
						  <input name="sex" type="radio" value="2" /><%=dbLabelBean.getLabel("label.global.female",strsesLanguage) %></span>	
						  <% strSex= "1"; %>
						<%}%>
						<!--End Code-->					  				  
					  </td>
					  <script language="javascript">
                            var aa ="<%=strSex%>";							
							if(aa != null && aa == "2")
							{
							   document.frm.sex[1].checked=true;
							}
							if(aa != null && aa == "1")
							{
							   document.frm.sex[0].checked=true;
							}
							
                       </script>                      
					  <td height="30" valign="top">
				        <span class="label2">
                          <select name="meal"  class="textBoxCss"><!--MEAL PREFFERENCES -->
<%
                     //For Population of Meal Combo 
                             strSql =   "SELECT MEAL_ID, MEAL_NAME FROM M_MEAL (NOLOCK) WHERE TRAVEL_AGENCY_ID = 1 AND AND STATUS_ID =10 ORDER BY MEAL_ID";
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
                        </span>
                        <!-- cost centre drop down added by manoj chand on 01 august 2012 -->
                        <%
                        if(strAppLvl3flg.trim().equalsIgnoreCase("Y") && strShowflag.equalsIgnoreCase("y")){
                        %>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="label2">
                          <select name="costcentre"  class="textBoxCss">
                          <option value="0"><%=dbLabelBean.getLabel("label.handover.select",strsesLanguage) %></option>
<%                           strSql =   "SELECT CC_ID,CC_CODE+' - '+CC_DESC+'' AS CC_CODE FROM M_COST_CENTRE WHERE SITE_ID="+strSiteId+" AND M_COST_CENTRE.STATUS_ID=10 ORDER BY CC_CODE";
                             rs       =   dbConBean.executeQuery(strSql);  
                             while(rs.next())
                             {
%>
                              <option value="<%=rs.getString("CC_ID")%>"><%=rs.getString("CC_CODE")%></option>
<%
                         	 }
                             rs.close();	  
%>
                          </select>
                          <script language="javascript">
                            document.frm.costcentre.value="<%=strCostCentre%>";
                          </script>
                        </span>
                        <%} %>
                        
                        
				      </td>
                    </tr>
                    
                  </table>
			    </td>


                <td width="49%" height="34" align="left" valign="top" bgcolor="#FFFFFF" class="forminnerbrdff">
				  <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr><td height="30"  valign="bottom" colspan="3"><span class="label1"><%=dbLabelBean.getLabel("label.global.visarequired",strsesLanguage) %></span><span class="starcolour">* </span></td>     </tr>
                    <tr><td >&nbsp;</td><td>&nbsp;</td>
                        <td height="25" align="left" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.visacomments",strsesLanguage) %></span></td>
                    </tr>
                    <tr>                                         
                      <td valign="top" class="label2" >                <!--VISA REQUIRED-->
					    <input name="visa" type="radio" value="1" checked="checked" onClick="visaOnClick(this.form)"/><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage) %>
					  </td>
                      <td valign="top" class="label2">
					    <input name="visa" type="radio" value="2" onClick="visaOnClick(this.form)"/><%=dbLabelBean.getLabel("label.global.no",strsesLanguage) %>
					  </td>
                      <td height="45" align="left" valign="top" class="label2"><!--VISA COMMENT-->
					    <textarea name="visaComment" disabled onKeyUp="return test1('visaComment', 100, 'all')" maxlength="200"><%=strVisaComment%></textarea>
					  </td>
					   <script language="javascript">
                            var aa ="<%=strVisaRequired%>";
							if(aa != null && aa == "2")
							{
							  // alert("visa value no is=="+aa);
							   document.frm.visa[1].checked=true;
							   document.frm.visaComment.disabled=false;							   
							}							
                       </script>
                    </tr>
                    <tr>
                      <td height="45" colspan="3" valign="top" class="label2" ><span class="formtxt2"><%=dbLabelBean.getLabel("label.createrequest.donotrequirevisathenputthereason",strsesLanguage) %> </span></td>
                    </tr>
                  </table>
				</td>
              </tr>
              <tr>
                <td height="34" align="left" bgcolor="#FFFFFF" class="forminnerbrdff">
<table width="100%" border="0" cellspacing="0" cellpadding="0" >   <!--ITINERARY INFORMATION -->
                    <tr><td height="30" colspan="4" valign="bottom" class="label1"><%=dbLabelBean.getLabel("label.global.additinerary",strsesLanguage) %></td>
                    </tr>
					<tr><td height="30" colspan="4" valign="bottom" class="label1"><%=dbLabelBean.getLabel("label.global.forwardjourney",strsesLanguage)%><span class="starcolour">*</span></td></tr>
                    <tr>
                      <td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage) %></td>

					  <td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage) %></td><!--New -->

                      <td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage) %> </td>
                      <td valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage) %></td>
                      <!--<td height="25" valign="bottom"><span class="label2">Mode</span></td>-->
                    </tr>
                    <tr>
                      <td height="30" valign="top">
					    <input name="depCity" type="text" class="textBoxCss" size="16" value="<%=strDepCity%>" onKeyUp="return test1('depCity', 30, 'c')" maxlength="30"/>					  
					   </td>
					   <td height="30" valign="top"><span class="label2"><!--ARRIVAL CITY -->
                        <input name="arrCity" type="text" class="textBoxCss" size="16" value="<%=strArrCity%>" onKeyUp="return test1('arrCity', 30, 'c')" maxlength="30" />
                        </span>					  
						</td>

                      <td valign="top">    <!--Reaching Date at Destination-->
					    <input name="depDate" type="text" class="textBoxCss" id="test2" size="6" value="<%=strDepDate%>" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" />

						<a href="javascript:show_calendar('frm.depDate','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;">
						
						<img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>
					  </td>
                      <td valign="top">
					    <select name="preferTime1" class="textBoxCss">
<%
                     //For Population of Prefer Timing Combo 
                             strSql =   "SELECT TIME_ID, PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY DISPLAY_ORDER ASC";
                             rs       =   dbConBean.executeQuery(strSql);  
                             while(rs.next())
                             {
%>
                              <option value="<%=rs.getString("TIME_ID")%>"><%=rs.getString("PREFER_TIME")%></option>
<%
                         	 }
                             rs.close();	  
%>

                        </select>
						<script language="javascript">
                            document.frm.preferTime1.value="<%=strPreferTime1%>";
                        </script>					  </td>
                     
                    </tr> 
                    <tr>
					   	
                      <td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage) %></td>  
                      <td height="25" colspan="1" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.class",strsesLanguage) %></td>
                      <td height="25"   colspan="2" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage) %></td>  
                    </tr>
                    <tr>
					                                                                 <!-- TRAVEL MODE 1 -->
					    <!-- 
					    <select name="travelMode1" onChange= "return setValue1('user');"  class="textBoxCss">
                          <option value="1" selected="selected">Air</option>
                          <option value="2">Train</option> 
                        </select>
						<script language="javascript">
                            document.frm.travelMode1.value="<%=strTravelMode1%>";
                        </script>			
                         
                        		  </td>	
                        		  -->
                        
                      <td height="30" valign="top" class="label2"><!-- NAME OF AIRLINE/TRAIN  1 -->
					    <input name="nameOfAirline1" type="text" class="textBoxCss" size="16" value="<%=strNameOfAirline1%>" onKeyUp="return test1('nameOfAirline1', 30, 'cn')" maxlength="30" />					  </td>
                      <td height="25"   valign="top" class="label2">
					    <select name="travelClass1" class="textBoxCss">
<%
                     //For Population of Travel Class Combo For Departure
					       if(strTravelMode1.equals("2"))
                             strSql =   "SELECT TRAIN_ID, ELIGIBILITY FROM M_TRAIN_CLASS (NOLOCK) WHERE STATUS_ID=10";
                           else
						     strSql =   "SELECT AIR_ID, ELIGIBILITY FROM M_AIRLINE_CLASS (NOLOCK) WHERE STATUS_ID=10";
                           
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
						<script language="javascript">
                            document.frm.travelClass1.value="<%=strTravelClass1%>";
                        </script>					  </td>
                      <td height="25" valign="top"> <!--  new field for seat preffered forword    -->
                      
                      
					    <select name="seatpreffredForjony" class="textBoxCss">
<%
                            //For Population of seat prefference Combo For Departure
					   
						     strSql =   "SELECT  seat_id, Seat_Name FROM  M_SEAT_PREFER (NOLOCK) WHERE  (Mode_id = 1) AND (TRAVEL_AGENCY_ID = 1) AND (STATUS_ID = 10)";
                           
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
						<script language="javascript"> 
						   var seat='<%=strPreferSeatfwd%>'; 
						   if (seat==''){
						     document.frm.seatpreffredForjony.value="1";
						     }else{
						     document.frm.seatpreffredForjony.value="<%=strPreferSeatfwd%>";
						     }
                        </script>				
                      
                      
                      
                      
                      </td>
                    </tr>
					
					
					<!-- RETURN JOURNEY INFORMATION -->
					<tr><td height="30" colspan="4" valign="bottom" class="label1"><%=dbLabelBean.getLabel("label.global.returnjourney",strsesLanguage) %></td>
                    </tr>

                    <tr>
					  <td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage) %></td>
                      <td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage) %></td>
                      <td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage) %></td>
                      <td valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage) %></td>
                    </tr>
                    <tr>
					  <td height="30" valign="top">
					    <input name="depCity1" type="text" class="textBoxCss" size="16" value="<%=strDepCity1%>" onKeyUp="return test1('depCity1', 30, 'c')" maxlength="30"/>					  
					   </td>
                      <td height="30" valign="top"><span class="label2"><!--ARRIVAL CITY -->
                        <input name="arrCity1" type="text" class="textBoxCss" size="16" value="<%=strArrCity1%>" onKeyUp="return test1('arrCity1', 30, 'c')" maxlength="30" />
                        </span>					  </td>
                      <td valign="top" nowrap="nowrap"><!-- Departure Date from Destination -->
					    <input name="returnDate" type="text" class="textBoxCss" id="test2" size="6" value="<%=strReturnDate%>" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"  />
						<a href="javascript:show_calendar('frm.returnDate','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>					  </td>
                      <td valign="top">
					    <select name="preferTime2" class="textBoxCss">
<%
                        //For Population of Prefer Timing Combo 
                             strSql =   "SELECT TIME_ID, PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY DISPLAY_ORDER ASC";
                             rs       =   dbConBean.executeQuery(strSql);  
                             while(rs.next())
                             {
%>
                              <option value="<%=rs.getString("TIME_ID")%>"><%=rs.getString("PREFER_TIME")%></option>
<%
                         	 }
                             rs.close();	  
%>
                        </select>
						<script language="javascript">
                            document.frm.preferTime2.value="<%=strPreferTime2%>";
                        </script>					  </td>
                      
                    </tr>

                    <tr> 
                      
                      <td height="25" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.preferredairline",strsesLanguage) %></span></td>
                      <td height="25" colspan="1" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.class",strsesLanguage) %></span></td>
                      <td valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage) %></td>
                        
                      
                      

                    </tr>
                    <tr>
					                                        <!-- TRAVEL MODE  2-->
					  <!-- 
					    <select name="travelMode2" onChange="return setValue1('user');" class="textBoxCss">
                          <option value="1" selected>Air</option>
                          <option value="2">Train </option>  
                        </select>
						<script language="javascript">
                            document.frm.travelMode2.value="<%=strTravelMode2%>";
                        </script>
                         -->
                          
						<!-- Code added for allowing the character & numeric in preferred Airline  on 4th Jan 2008 by Shiv Sharma -->
                      <td height="30" valign="top"><span class="label2">                     <!-- NAME OF AIRLINE/TRAIN  2 -->  
                        <input name="nameOfAirline2" type="text" class="textBoxCss" size="16" value="<%=strNameOfAirline2%>" onKeyUp="return test1('nameOfAirline2', 30, 'cn')" maxlength="30" /></span>					  </td>
                      <td height="30" colspan="1" valign="top">                               <!-- TRAVEL CLASS  2 -->
					    <select name="travelClass2" class="textBoxCss">
                         <%
                     //For Population of Arrival Travel Class Combo For Arival
					       if(strTravelMode2.equals("2"))
                             strSql =   "SELECT TRAIN_ID, ELIGIBILITY FROM M_TRAIN_CLASS (NOLOCK) WHERE STATUS_ID=10";
                           else
						     strSql =   "SELECT AIR_ID, ELIGIBILITY FROM M_AIRLINE_CLASS (NOLOCK) WHERE STATUS_ID=10";
                           
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
						<script language="javascript">
                            document.frm.travelClass2.value="<%=strTravelClass2%>";
                        </script></td>
                    
                    <td valign="top"><!--  new field for seat preffered forword    -->
                  
                                                  <!-- TRAVEL CLASS  2 -->
					    <select name="seatpreffredRetjony" class="textBoxCss">
                         <%
                     //For Population of seat prefference Combo For Departure Arival
					     
						   strSql =   "SELECT  seat_id, Seat_Name FROM  M_SEAT_PREFER (NOLOCK) WHERE (Mode_id = 1) AND (TRAVEL_AGENCY_ID = 1) AND (STATUS_ID = 10)";
                           
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
						<script language="javascript"> 
						      var  seat="<%=strPreferSeatRet%>";
						    
						      if (seat==''){   
                            document.frm.seatpreffredRetjony.value="1";
                            }else{
                            document.frm.seatpreffredRetjony.value="<%=strPreferSeatRet%>";
                            }
                        </script>
                    
                    </td></tr>
					<tr><td><a href="#" onClick="MM_openBrWindow()"><img src="images/InterimJourney.gif?buildstamp=2_0_0" width="167" height="27" align="top" border="0" /></a></td></tr>
					<tr>
					   <td height="30" colspan="4" valign="top" class="formtxt2"><%=dbLabelBean.getLabel("label.global.interimflights",strsesLanguage) %></td>
                    </tr>
					 <tr>
		                <td height="25" align="left" valign="top"><span class="label2"><%=dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage) %>&nbsp;&nbsp;</span></td>
				        <td height="25" align="left" valign="top"><span class="label2">&nbsp;&nbsp;&nbsp;</span></td>
		             </tr>
					 <tr>
		                <td height="30" colspan="4" valign="top" class="label2" ><!--Reason for Travel-->
					      <textarea name="reasonForTravel" onKeyUp="return test1('reasonForTravel', 200, 'all')" maxlength="200"><%=strReasonForTravel%></textarea>			  
						</td>
				        <td height="25" align="left" valign="top"><span class="label2">&nbsp;&nbsp;&nbsp;</span></td>
		              </tr>
                  </table>
				</td>
                <td height="34" align="left" valign="top" bgcolor="#FFFFFF" class="forminnerbrdff">
				  <table width="100%" border="0" cellpadding="0" cellspacing="0" >
                    <tr>
                      <td height="30" colspan="5" align="left" class="label1"><%=dbLabelBean.getLabel("label.createrequest.travelinsurancerequired",strsesLanguage) %><span class="starcolour">* </span></td>
                    </tr>
                    <tr>
                      <td height="25" align="left" valign="top" >&nbsp;</td>
                      <td height="25" align="left" valign="bottom">&nbsp;</td>
                      <td height="25" align="left" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.nominee",strsesLanguage) %></span></td>
                      <td height="25" align="left" valign="bottom" colspan="2"><span class="label2"><%=dbLabelBean.getLabel("label.createrequest.relation",strsesLanguage) %></span></td>
                    </tr>
                    <tr>
                      <td height="30" valign="top" nowrap="nowrap" >             <!--INSURANCE REQUIRED-->
					    <input name="insurance" type="radio" value="1" checked="checked" onClick="insuranceOnClick(this.form)"/><span class="label2"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage) %></span></td>
                      <td height="30" valign="top" nowrap="nowrap"><input name="insurance" type="radio" value="2" onClick="insuranceOnClick(this.form)" /><span class="label2"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage) %></span>
					  </td>
                      <td height="30" align="left" valign="top"><!--NOMINEE-->
					    <input name="nominee" type="text" class="textBoxCss" size="10" value="<%=strNominee%>" onKeyUp="return test1('nominee', 30, 'c')" maxlength="30"/>
					  </td>
                      <td height="30" colspan="2" align="left" valign="top"><!--RELATION-->
					    <input name="relation" type="text" class="textBoxCss" size="10" value="<%=strRelation%>" onKeyUp="return test1('relation', 30, 'c')" maxlength="30"/>
					  </td>
                    </tr>
                    <tr>
                      <td class="label2" >&nbsp;</td>
                      <td class="label2">&nbsp;</td>
                      <td colspan="3" align="left" valign="bottom" class="label2"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %></td>
                    </tr>
                    <tr>
                      <td colspan="2" class="label2" >&nbsp;</td>
                      <td height="45" colspan="3" align="left" valign="top" class="label2"><!--INSURANCE COMMENTS-->
					    <textarea name="insuranceComment" disabled onKeyUp="return test1('insuranceComment', 100, 'all')" maxlength="200"><%=strInsuranceComment%></textarea>
					  </td>
                    </tr>
					<!--JAVA SCRIPT -->
					<script language="javascript">
                            var aa ="<%=strInsuranceRequired%>";
							if(aa != null && aa == "2")
							{
							   //alert("insurance value no is=="+aa);
							   document.frm.insurance[1].checked=true;
							   document.frm.insuranceComment.disabled=false;							   
                               document.frm.nominee.value="";							   
							   document.frm.relation.value="";							     
							   document.frm.nominee.disabled=true;							   
							   document.frm.relation.disabled=true;							   
							}							
                     </script>
                    <tr>
                      <td height="45" colspan="5" class="formtxt2" ><%=dbLabelBean.getLabel("label.createrequest.requireinsurancethenspecifynominee",strsesLanguage) %> &amp; <%=dbLabelBean.getLabel("label.createrequest.relationcomments",strsesLanguage) %> </td>
                    </tr>
                  </table>
				</td>
              </tr>
              <tr>
                <td height="34" align="left" bgcolor="#FFFFFF" class="forminnerbrdff" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="30" colspan="2"><span class="label1"><%=dbLabelBean.getLabel("label.createrequest.selectapprovallevel",strsesLanguage) %></span><span class="starcolour">*</span></td>
              </tr>
	
	
	
			  <tr>
                <td height="25" align="left" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage) %>&nbsp;&nbsp;</span></td>
                <td height="25" align="left" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage) %>&nbsp;&nbsp;&nbsp;</span></td>
              </tr>
              <tr>
                <td height="30" align="left" valign="top">

<!--

// CHANGE BY SAMIR RANJAN PADHI ON (3/12/2007)
// CALL FUNCTION FOR DISABLE AND ENABLE THE "Reason for Skipping " TEXTAREA 
// ADD ONE FUNCTION ON "onChange" event in "manager" FIELD i.e skipDisabled(this.form)

-->
				  <select name="manager" id="firstapprover" class="textBoxCss" onChange="skipDisabled(this.form,'first');">  
				  <%  // MODIFICATION END   <!--MANAGER COMBO--> %>
							
				    <option value="S"><%=dbLabelBean.getLabel("label.createrequest.selectapprovallevel1",strsesLanguage) %></option> 
<%
                     //For Population of Manager Class Combo for the particular site
					 //AND USERID NOT IN(SELECT APPROVER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='I' AND STATUS_ID=10)
					 //ADD APPROVERS WHO HAS APPROVER LEVEL 2
					 //this query is commented by manoj chand on 31 May 2013
                 //strSql = "Select USERID, dbo.user_name(USERID)AS PM FROM M_USERINFO (NOLOCK) WHERE APPROVER_LEVEL=1 AND SITE_ID="+strSiteId+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 2";
//strSql = "Select USERID, dbo.user_name(USERID)AS PM FROM M_USERINFO (NOLOCK) WHERE APPROVER_LEVEL=1 AND SITE_ID="+strSiteId+" AND STATUS_ID=10 AND APPLICATION_ID=1 and userid not in ((SELECT APPROVER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='I' AND  sp_role="+SSstrSplRole+" AND STATUS_ID=10 AND APPLICATION_ID=1)) ORDER BY 2";
//added by manoj chand on 31 May 2013 to add otherside user in approver level 1
				strSql="Select USERID, dbo.user_name(USERID)AS PM FROM M_USERINFO (NOLOCK) WHERE APPROVER_LEVEL=1 AND SITE_ID="+strSiteId+" AND STATUS_ID=10 AND APPLICATION_ID=1 UNION SELECT UAM.USERID,dbo.user_name(UAM.USERID)AS PM  FROM USER_MULTIPLE_ACCESS UAM WHERE SITE_ID="+strSiteId+" AND APPROVAL_LVL1='Y' AND STATUS_ID=10 ORDER BY 2";
//System.out.println("strSql approver level one------>"+strSql);

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
                 
                 <%
                 if(strTravelId !=null && strTravelId.equals("new")) {	
                 	strSql="SELECT TOP 1 MANAGER_ID, HOD_ID, BOARD_MEMBER_ID FROM T_TRAVEL_DETAIL_INT INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_INT.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND TRAVEL_TYPE='I' AND T_TRAVEL_STATUS.TRAVEL_STATUS_ID = 10 WHERE TRAVELLER_ID = "+strUserId+" ORDER BY C_DATETIME DESC";
                 	rs       =   dbConBean.executeQuery(strSql); 
                 	if(rs.next()) {
                	 strManagerSelected = rs.getString("MANAGER_ID");
                	 strHodSelected = rs.getString("HOD_ID");
                	 strBoardMemberSelected = rs.getString("BOARD_MEMBER_ID");
              		}
                 	rs.close();
                 }
                 
                 if(strManager !=null && !strManager.equals("") && !strManager.equalsIgnoreCase("S")){%>
	                  <script language="javascript">
	                  	document.frm.manager.value="<%=strManager%>";
	                  </script>
                  <% }
                  else if (strManagerSelected == null || strManagerSelected.equals("")){%>
                  	   <script language="javascript">
                  		 document.frm.manager.value="<%=strManager%>";
	                  </script>
	              <% } 
                  else { %>
	                  <script language="javascript">
		                  var firstApprover = document.getElementById("firstapprover");
		                  var firstAppVal;
		                  var i;
		                  for (i = 0; i < firstApprover.length; i++) {
		                  	firstAppVal = firstApprover.options[i].value;	                    	
		                  	if(firstAppVal == <%=strManagerSelected%>){	                    		
		                  		document.frm.manager.value="<%=strManagerSelected%>"; 
		                  		break;
		                  	} else if(firstAppVal != <%=strManagerSelected%>){                    		
		                  		document.frm.manager.value="S";
		                  	} 
		                  }
	            	   </script> 
            	 <% } %>                 	
				</td>
				</td>
                <td height="30" align="left" valign="top"><span class="label2">

<!--

// CHANGE BY SAMIR RANJAN PADHI ON (3/12/2007)
// CALL FUNCTION FOR DISABLE AND ENABLE THE "Reason for Skipping " TEXTAREA 
// ADD ONE FUNCTION ON "onChange" event in "manager" FIELD i.e skipDisabled(this.form)

-->

                  <select name="hod" id="secondapprover" class="textBoxCss" onChange="skipDisabled(this.form,'second');">    
				<%  // MODIFICATION END %>
							   
							   <!--HOD COMBO--> 
				     <option value="S"><%=dbLabelBean.getLabel("label.createrequest.selectapprovallevel2",strsesLanguage)%></option>
<%
                     //For Population of HOD Class Combo for the particular site
				     //ADD APPROVERS WHO HAS APPROVER LEVEL 2  
		/*			   strSql =   "Select USERID, dbo.user_name(USERID)AS HOD FROM M_USERINFO (NOLOCK) WHERE APPROVER_LEVEL=2 AND SITE_ID="+strSiteId+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 2";
System.out.println("strSQL INT-1->"+strSql);
         			   rs       =   dbConBean.executeQuery(strSql);  
                       while(rs.next())
                       {*/
%>
                      <%--    <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> --%>
<%
                  /*     }
                       rs.close();	
					   //ADD GLOBAL APPROVER		
					   strSql =   "Select USERID, dbo.user_name(USERID)AS HOD FROM M_USERINFO (NOLOCK) WHERE APPROVER_LEVEL=3 AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 2"; System.out.println("strSQL INT-2->"+strSql);*/
 					   //added by manoj
 					   //this query is commented by manoj chand on 31 May 2013
 					   //strSql =   "Select USERID, dbo.user_name(USERID)AS HOD FROM M_USERINFO (NOLOCK) WHERE ((APPROVER_LEVEL=2 AND SITE_ID="+strSiteId+") or (APPROVER_LEVEL=3)) AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 2";
					   //strSql =   "Select USERID, dbo.user_name(USERID)AS HOD FROM M_USERINFO (NOLOCK) WHERE ((APPROVER_LEVEL=2 AND SITE_ID="+strSiteId+") or (APPROVER_LEVEL=3)) AND STATUS_ID=10 AND APPLICATION_ID=1 and userid not in ((SELECT APPROVER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='I' AND  sp_role="+SSstrSplRole+" AND STATUS_ID=10 AND APPLICATION_ID=1)) ORDER BY 2";
					   //added by manoj chand on 31 May 2013 to add otherside user in approver level 2
					   strSql="Select USERID, dbo.user_name(USERID)AS HOD FROM M_USERINFO (NOLOCK) WHERE ((APPROVER_LEVEL=2 AND SITE_ID="+strSiteId+") or (APPROVER_LEVEL=3)) AND STATUS_ID=10 AND APPLICATION_ID=1 UNION SELECT UAM.USERID,dbo.user_name(UAM.USERID)AS PM  FROM USER_MULTIPLE_ACCESS UAM WHERE SITE_ID="+strSiteId+" AND APPROVAL_LVL2='Y' AND STATUS_ID=10 ORDER BY 2";
					   //System.out.println("strSQL INT-5->"+strSql);
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
                  <%if(strHod !=null && !strHod.equals("") && !strHod.equalsIgnoreCase("S")){%>
					  <script language="javascript">
	                       document.frm.hod.value="<%=strHod%>";
	                  </script>
                  <%} 
                  else if (strHodSelected == null || strHodSelected.equals("")){%>
                   <script language="javascript">
	                       document.frm.hod.value="<%=strHod%>";
	                  </script>
                  <% }
                  else { %>
	                 	 <script language="javascript">
	                 	var secondApprover = document.getElementById("secondapprover");
	                 	var secondAppVal;
	                 	var i;
	                 	for (i = 0; i < secondApprover.length; i++) {
	                 		secondAppVal = secondApprover.options[i].value;	                    	
	                 		if(secondAppVal == <%=strHodSelected%>){	                    		
	                 			document.frm.hod.value="<%=strHodSelected%>"; 
	                 			break;
	                 		} else if(secondAppVal != <%=strHodSelected%>){                    		
	                 			document.frm.hod.value="S";
	                 		} 
	                 	}
	            		 </script> 
            	 <% } %>                     	
    			</td>	
              </tr>
					  
			  <tr>
			    <td height="25" align="left" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.reasonforskipping",strsesLanguage) %></span></td>
			    <% if(strAppLvl3flgforBM.trim().equalsIgnoreCase("Y")) {%>
			    <td height="25" align="left" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.boardmember",strsesLanguage) %></span></td>	
			    <%} %>
			  </tr>		  
			  <tr>
				<td>
				  <textarea name="reasonForSkip" disabled onKeyUp="return test1('reasonForSkip', 200, 'all')" maxlength="200" rows="4" cols="20"><%=strReasonForSkip%></textarea>			  
				</td>
				
				<% if(!strAppLvl3flgforBM.trim().equalsIgnoreCase("Y")) {%>
				<td class="label2" >
				<a href="#" onClick="return defaultApproverList(this.form);"><%=dbLabelBean.getLabel("link.global.viewallapprovers",strsesLanguage) %></a>
				</td>
				<%} %>
				
	<!-- added by Manoj Chand on 27 March 2012 to add board member combobox for smp sites -->
	<% if(strAppLvl3flgforBM.trim().equalsIgnoreCase("Y")) {%>
				<td height="30" align="left" valign="top">
				<select name="boardmember" id="thirdapprover" class="textBoxCss" onChange="skipDisabled(this.form,'third');">
				<option value="B"><%=dbLabelBean.getLabel("label.createrequest.selectboardmember",strsesLanguage) %></option> 
<%  
		//For Population of Board Members for SMP DIVISION 
                 strSql = "SELECT USERID, DBO.user_name(USERID) AS BM FROM M_BOARD_MEMBER WHERE M_BOARD_MEMBER.SITE_ID="+strSiteId+" AND M_BOARD_MEMBER.STATUS_ID=10";
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
                  <%if(strBoardMember !=null && !strBoardMember.equals("") && !strBoardMember.equalsIgnoreCase("B")) {%>
	                  <script language="javascript">
	                       document.frm.boardmember.value="<%=strBoardMember%>";
	                  </script>
                  <%} 
                  else if (strBoardMemberSelected == null || strBoardMemberSelected.equals("")){%>
                  <script language="javascript">
	                       document.frm.boardmember.value="<%=strBoardMember%>";
	                  </script>
                  <% }
                  else { %>
                	  <script language="javascript">
                	  var thirdApprover = document.getElementById("thirdapprover");
                	  var thirdAppVal;
                	  var i;
                	  for (i = 0; i < thirdApprover.length; i++) {
                	  	thirdAppVal = thirdApprover.options[i].value;	                    	
                	  	if(thirdAppVal == <%=strBoardMemberSelected%>){	                    		
                	  		document.frm.boardmember.value="<%=strBoardMemberSelected%>";
                	  		break;
                	  	} else if(thirdAppVal != <%=strBoardMemberSelected%>){                    		
                	  		document.frm.boardmember.value="B";
                	  	} 
                	  }
            		  </script>
                  		 
            		<% } %>			
				</td>
				
				
			
				</td>
			  </tr>
			  
			  		  
              <tr>
              <td class="label2"><a href="#" onClick="return defaultApproverList(this.form);"><%=dbLabelBean.getLabel("link.global.viewallapprovers",strsesLanguage) %></a></td>
              <td>&nbsp;</td>
              </tr>
              <%} %>	
              
              
			  <tr>
                <td height="25" align="left"><!--MANUAL SELECTION-->
				  <span class="label2" style="display:none">
                  <input name="selectManager" type="radio" value="manual" checked="checked" onClick="selectManagerOnClick(this.form)" /><!-- Select Manager Redio Button -->
                   <%=dbLabelBean.getLabel("label.createrequest.selectmanually",strsesLanguage) %></span>
				</td>
                <td height="25" align="left" class="label2">&nbsp;</td>
              </tr>
              


              <tr>
                <td height="30" align="left" valign="top"><span style="display:none">             <!--AUTOMATIC SELECTION-->
				  <input name="selectManager" type="radio" value="automatic" onClick="selectManagerOnClick(this.form)"/></span> <!-- Select Manager Redio Button -->
                  <span class="menu"><span class="label2" style="display:none"><%=dbLabelBean.getLabel("label.createrequest.automaticselection",strsesLanguage) %> </span></span>
				</td>
				<script language="javascript">
                  var aa ="<%=strSelectManagerRadio%>";
				  if(aa != null && aa == "automatic")
				  {				
					  //alert(aa);
					   document.frm.selectManager[1].checked=true;	
					   document.frm.manager.disabled = true;
					   document.frm.hod.disabled = true;
				  }
				  if(aa != null && aa == "skip")
				  {
					   document.frm.manager.disabled = true;
					   document.frm.hod.disabled = true;
					   //document.frm.skip11.disabled = true;
					   //document.frm.unskip11.disabled = false;
					   document.frm.reasonForSkip.disabled = false;					   
				  }
				  if(aa != null && aa == "manual")
				  {
					   document.frm.manager.disabled = false;
					   document.frm.hod.disabled = false;
					   //document.frm.skip11.disabled = false;
					   //document.frm.unskip11.disabled = true;
					   document.frm.reasonForSkip.disabled = false;					   //noted
				  }

               </script>
                <td height="30" align="left" valign="top">&nbsp;</td>
              </tr>
              <tr>
                <td height="30" colspan="2" align="left" valign="top"><span class="formtxt2" style="display:none"><%=dbLabelBean.getLabel("label.createrequest.automaticselectionmessage",strsesLanguage) %> </span></td>
              </tr>
           </table>
		 </td>
         <td height="34" align="left" valign="top" bgcolor="#FFFFFF" class="forminnerbrdff">

		 
		 
		 <!--  -->
		   <table width="100%" border="0" cellpadding="0" cellspacing="0" valign="top"  >
             <tr>
               <td height="30" colspan="4" class="label1" style="margin-top:0px; padding-top:0px;" valign="top" ><%=dbLabelBean.getLabel("label.global.accomodationrequired",strsesLanguage) %><span class="starcolour">*</span></td>
             </tr>
             <tr>
               <td width="29%" height="20" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.staytype",strsesLanguage) %></td>  
               <!-- hotel combo used for transit type-->
               <td width="38%"  align="left" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage) %></td>
               <td width="33%" height="20" align="left"   valign="bottom"  class="label2"><%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage) %></td>
             </tr>
             <tr height="15">               

			   <td height="10" valign="top"><select name="hotel" class="textBoxCss" onChange="return transitOnClick(this.form);" >
						<option value = "0"><%=dbLabelBean.getLabel("label.global.na",strsesLanguage) %></option>
						<option value="1"><%=dbLabelBean.getLabel("label.global.hotel",strsesLanguage) %></option>
						<option value = "2"><%=dbLabelBean.getLabel("label.global.transithouse",strsesLanguage) %></option>
						<script language="javascript">
                			document.frm.hotel.value= "<%=strHotelRequired%>"; 
		        		</script> 
					</select>
&nbsp;&nbsp; </td>



			   <td align="left" valign="top" height="10">
			     <select name="currency" class="textBoxCss"><!--BUDGET CURRENCY-->
<%
                     //For Population of Currenc Combo for the particular site
                       strSql =   "Select Currency, Currency from m_currency (NOLOCK) where status_id=10";
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
				 <script language="javascript">
                       document.frm.currency.value="<%=strBudgetCurrency%>";
                 </script>                 </td>
               <td height="10" align="left" valign="top"><span class="label2">     <!--BUDGET-->
               </span>			   <span class="label2">
               <input name="place" type="text" value="<%=strPlace%>" size="13"  class="textBoxCss" onKeyUp="return test1('place',20, 'c')" maxlength="20"><!-- -->
                
             </tr>
			 
			 <!-- Transit house message added by manoj chand -->
			 <tr id="hidethis" style="display: none;">
			 <td colspan="3" class="formtxt2"><span style="color:red;"><%=dbLabelBean.getLabel("label.global.smokingmessage",strsesLanguage) %></span></td>
			 </tr>
			 
			 
			 
			 
			 <tr>                                                              <!--CHECK_IN AND CHECK_OUT DATE-->
				  <td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage) %></td>
				  <td height="25" align="left" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage) %></td><br>
				  <td height="25" align="left" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.budget",strsesLanguage) %></td>
			 </tr>

			 <tr><td height="30" valign="top"><input name="checkin" type="text" class="textBoxCss" id="test223" size="6" onFocus="javascript:vDateType='DD/MM/YYYY'"
									onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
									onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
									onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"><a href="javascript:show_calendar('frm.checkin','a','a','DD/MM/YYYY');"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>
					 <script language="javascript">
                        document.frm.checkin.value="<%=strCheckin%>";
                     </script>
				  </td>
				  
				  <td height="30" align="left" valign="top"><input name="checkout" type="text" class="textBoxCss" id="test224" size="6" onFocus="javascript:vDateType='DD/MM/YYYY'"

									onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
									onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
									onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);">
					  <a href="javascript:show_calendar('frm.checkout','a','a','DD/MM/YYYY');"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img border="0"
									name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle">					  </a>
	                  <script language="javascript">
                       document.frm.checkout.value="<%=strCheckout%>";
                      </script>  				  </td>							
			      <td height="30" align="left" valign="top"><span class="label2">
			        <input name="budget" type="text"  size="4"  class="textBoxCss" maxlength="10"  value="<%=strHotelBudget%>" onKeyUp="return test1('budget',12, 'n')" >
			      </span></td>
			 </tr>	

             <!-- JAVA SCRIPT for setting the Accomodation detail enable or disable according the transit type -->
  		     <script language="javascript">
                  var aa ="<%=strHotelRequired%>";
				  if(aa != null && aa == "0")
				  {
					   //alert("hotel value no is=="+aa);
					   document.frm.budget.disabled=true;
					   document.frm.place.disabled=true;
					   document.frm.currency.disabled=true;
					   document.frm.checkin.disabled=true;
					   document.frm.checkout.disabled=true;
				  }
			 </script>



             <tr>
               <td height="25" colspan="4" class="formtxt2" ><%=dbLabelBean.getLabel("label.global.requirehotelthenspecifyhotelbudget",strsesLanguage) %></td>
             </tr>
             <tr>
               <td height="25" colspan="4" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%>  </td>
			    <!--<td height="25" colspan="4" valign="bottom" class="label2" >Reason for travel </td>-->
             </tr>
             <tr>
               <td height="30" colspan="4" class="label2"   ><!--OTHER COMMENT-->
			     <textarea  name="otherComment" onKeyUp="return test1('otherComment', 200, 'all')" onblur="this.value=removeSpaces(this.value);" maxlength="200"><%=strRemarks%></textarea>			   </td>
			    <!--<td height="30" colspan="4" class="label2" >
			      <textarea name="reasonForTravel" onKeyUp="return test1('reasonForTravel', 200, 'all')" maxlength="200"><%=strReasonForTravel%></textarea>			  
				</td>-->
             </tr>
           </table>


	     </td>
       </tr>  
       
        <tr>
            <td colspan="2" align="left" class="forminnerbrdff"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                
				
				<td height="30" colspan="4" class="label1"><%=dbLabelBean.getLabel("label.global.creditcardinfo",strsesLanguage) %></td>
              </tr>
              <tr>
                <td width="12%" height="25" valign="bottom" class="label2" ><%=dbLabelBean.getLabel("label.global.cardtype",strsesLanguage) %> </td>
				<td width="26%" height="25" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.creditcardholder",strsesLanguage) %></span></td> 
                <!-- <td width="26%" height="25" valign="bottom"><span class="label2">Credit Card Number</span></td> -->
                <td width="46%" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.expirydate",strsesLanguage) %> </span></td>
                <td width="48%" valign="bottom"><span class="label2"><!--CVV Number--> </span></td>
              </tr>
              <tr>
			   <%
				if(strCARD_TYPE==null || strCARD_TYPE=="")
				{
				strCARD_TYPE="-1";

				}
				%>
				<!-- add AMEX as a credit card type on 26 july 2012 by manoj chand -->
                <td height="30" valign="top" ><select name="CARD_TYPE" class="textBoxCss" onChange="return CreditCheck(frm);">
                   <option value = "-1"><%=dbLabelBean.getLabel("label.global.na",strsesLanguage) %></option>
					<option value="0"><%=dbLabelBean.getLabel("label.global.visa",strsesLanguage) %></option>
                    <option value="1"><%=dbLabelBean.getLabel("label.global.master",strsesLanguage) %></option>
                    <option value="2"><%=dbLabelBean.getLabel("label.createrequest.amex",strsesLanguage)%></option>
                </select></td>
				<script language="javascript">
                				document.frm.CARD_TYPE.value= "<%=strCARD_TYPE%>";
		         </script>
<!-- 22-02-2007  -->

<td height="21" valign="top"><span class="formtxt2">
                  <input name="cardHolderName" type="text"  class="textBoxCss"  size="25" maxlength="40" onKeyUp="return test1('cardHolderName', 40, 'c')" value="<%=strCARD_HOLDER_NAME%>" class="textBoxCss"/>
<!-- 22-02-2007  --></td>
               <!-- <td height="21" valign="top"><span class="formtxt2">
                   <input name="CARD_NUMBER1" type="text" value="<%//=strCARD_NUMBER1%>" class="textBoxCss"  size="1" maxlength="4"onKeyUp="return test1('CARD_NUMBER1', 4, 'n')"  class="textBoxCss" />
-
				<input name="CARD_NUMBER2" type="text" value="<%//=strCARD_NUMBER2%>" class="textBoxCss"  size="1" maxlength="4" onKeyUp="return test1('CARD_NUMBER2', 4, 'n')"  class="textBoxCss"/>
-
				<input name="CARD_NUMBER3" type="text" value="<%//=strCARD_NUMBER3%>" class="textBoxCss"  size="1" maxlength="4" onKeyUp="return test1('CARD_NUMBER3', 4, 'n')"  class="textBoxCss"/>
-
				<input name="CARD_NUMBER4" type="text" value="<%//=strCARD_NUMBER4%>" class="textBoxCss"  size="1" maxlength="4" onKeyUp="return test1('CARD_NUMBER4', 4, 'n')"  class="textBoxCss"/>
				 
                </span></td>
                --> 
                <td height="21" valign="top">
				
				<input name="CARD_EXP_DATE" type="hidden" class="textBoxCss" id="test23" size="6" value="<%=strCARD_EXP_DATE%>" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"  />
					<!--  Modification by vaibhav starts -->
					<!--  <a href="javascript:show_calendar('frm.CARD_EXP_DATE','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a> -->
                 		<select name="monSelect" class="textBoxCss" onchange = "return expiryDate()"> 
                 		<option value=""><%=dbLabelBean.getLabel("label.global.month",strsesLanguage)%></option>
                 		<option value="01">01</option>
                 		<option value="02">02</option>
                 		<option value="03">03</option>
                 		<option value="04">04</option>
                 		<option value="05">05</option>
                 		<option value="06">06</option>
                 		<option value="07">07</option>
                 		<option value="08">08</option>
                 		<option value="09">09</option>
                 		<option value="10">10</option>
                 		<option value="11">11</option>
                 		<option value="12">12</option>
                 		</select>
                 		
                 		<script type="text/javascript">
                 		document.frm.monSelect.value='<%=strMonth%>';
                 		</script>
                 		
                 		<% int year =  Calendar.getInstance().get(Calendar.YEAR);
                 			int count = 0;
                 		%>
                 		
                 		<select name="yearSelect" class="textBoxCss" onchange = "return expiryDate()"> 
                 		<option value=""><%=dbLabelBean.getLabel("label.global.year",strsesLanguage)%></option>
                 		<%while(count < 15){%>
                 		<option value="<%=year%>"><%=year%></option>
                 		<%year = year+1;count = count+1;
                 		}%>
                 				
                 		</select>
                 		<script type="text/javascript">
                 		document.frm.yearSelect.value='<%=strYear%>';
                 		</script>
                 		<!--  Modification by vaibhav ends -->
                  </td>
              </tr>

              <tr>
                <td height="25" colspan="4" class="formtxt2" ><%=dbLabelBean.getLabel("alert.global.creditcarddetails",strsesLanguage) %> </td>
              </tr>
            </table></td>
            </tr>

       <tr>    
                 <td align="right" bgcolor="#efefef" class="newformbot" colspan="2">
                   <!-- modified by shiv on 29-May-07 added  "strButtonState" open   -->   
						<input type="submit" class="formButton" name="saveExit" value="<%=dbLabelBean.getLabel("button.global.saveandexit",strsesLanguage) %>"   <%=strButtonState%>  onClick="return checkData(this.form,'saveExit');"/> 
						<input type="submit" class="formButton" name="save" value="<%=dbLabelBean.getLabel("button.global.save",strsesLanguage) %>"   <%=strButtonState%> onClick="return checkData(this.form,'save');"/> 
						<input type="submit" class="formButton" name="saveProceed"    <%=strButtonState%> value="<%=dbLabelBean.getLabel("button.global.saveandnext",strsesLanguage) %>" onClick="return checkData(this.form,'saveProceed');"/> 		    
					 <!-- modified by shiv on 29-May-07 added  "strButtonState" close   -->   
    		  </td>
        </tr>
     </table>
    </td>
    <td width="11" background="images/index_03.png?buildstamp=2_0_0"></td>
  </tr>
  <tr>
    <td width="14" height="20" background="images/index_04.png?buildstamp=2_0_0"><img src="images/index_04.png?buildstamp=2_0_0" width="14" height="20" /></td>
    <td height="20" background="images/index_05.png?buildstamp=2_0_0">&nbsp;</td>
    <td width="11" height="20" background="images/index_06.png?buildstamp=2_0_0"></td>
  </tr>
</table>
</td>
</tr>
</table>
   <input type="hidden" name="todayDate" value="<%=strCurrentDate%>"/> <!--  HIDDEN FIELD  -->
   <input type="hidden" name="travelId" value="<%=strTravelId%>"/> <!--  HIDDEN FIELD  -->
   <input type="hidden" name="travelReqId" value="<%=strTravelReqId%>"/> <!--  HIDDEN FIELD  -->
   <input type="hidden" name="travelReqNo" value="<%=strTravelReqNo%>"/> <!--  HIDDEN FIELD  -->
   <input type="hidden" name="whatAction"/> <!--  HIDDEN FIELD  -->
   <input type ="hidden" name = "interimId"  value = "<%= strIntermiId %>" /><!--  HIDDEN FIELD  -->
   <input type ="hidden" name = "scriptRunFlag"  /><!--  HIDDEN FIELD  -->
   <input type ="hidden" name = "sex"  value = "<%= strSex %>" /><!--  HIDDEN FIELD  -->
   <input type ="hidden" name = "strSex"  value = "<%= strSex %>" /><!--  HIDDEN FIELD  -->
   <input type ="hidden" name = "actualAge"  value = "<%=actualAge %>" /><!--  HIDDEN FIELD  -->
   <input type="hidden" name="hidAppLvl3flg" value="<%=strAppLvl3flg %>" />
   <input type="hidden" name="hidAppLvl3showbmflg" value="<%=strAppLvl3flgforBM%>" />
</form>
<!-- End of Form -->
<%
   dbConBean.close();// CLOSE ALL CONNECTION
%>




 
</body>
</html>
