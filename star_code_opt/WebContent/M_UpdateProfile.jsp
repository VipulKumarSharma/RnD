	
<% 
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:24 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for updating the M_USERINFO in the STAR Database
 *Modification 			: empcode char & numeric
								  2.Change the query for display the user info in edit form
								  3.Add the  secret question combobox  and answer field
								  4.SELECT THE APPROPRIATE QUESTION IN COMBOBOX
								  5.Add the  gender field .
								  6. code added for updating the user those are in deactivated user List,  by shiv sharma on 23-May-07
								  7. status_id  is removed  for showing "report to person" for deactivted user. by shiv on 24-May-07. 
								  8.  change the calender icon(converted it to drop down selection for date)  by  shiv  on 07-Jun-07.  
								  9.  Text color (  field color green) change  by shiv on 03-Aug-07 
								 10. Added a new field identity field on 22-Oct-07 by Shiv Sharma    
								 11. Changes the name of jsp on report to function by shiv sharma on 06-11-2008
								 12. Added  new fields for windows user id,domian id flag on 05-02-2009 by shiv sharma  
								 13. Extends field length for windows user id 05-10-2009 by shiv sharma  
								 14: change text domian name to network domain name on 25 feb 2010  by shiv sharma 
 *Reason of Modification: 
 *Date of Modification  : 19/03/2007, 20/03/2007 by Shiv Sharma,09/04/2007
									  11/04/2007,
									  14/04/2007
									  17/04/2007
									  20/04/2007

 *Modified By			: 1.Vijay Singh
								  2.Vijay Singh
								  3.VIJAY SINGH
								  4.Vijay Singh
								  5.Vijay Singh
 *Revision History		:Last name is not mendatory 
 *Editor				:Editplus
 
 *Modified By			: Manoj Chand
 *Date of Modification	: 29 Feb 2012
 *Modification			: RESOLVE ERROR OF All THREE DATE FIELD i.e. DOB, DATE OF ISSUE, EXPIRY DATE GET BLANK ON DATE CHANGE
 
 *Modified By					:Manoj Chand
 *Date of Modification			:03 July 2011
 *Modification					:change query to remove closed unit from unit dropdown 	
 
 *Modified By					:Manoj Chand
 *Date of Modification			:14 August 2012
 *Modification					:showing workflow dropdown for LA and link to show existing workflow
 
 *Modified By					:Manoj Chand
 *Date of Modification			:19 Sept 2012
 *Modification					:showing alert regarding profile deactivation to user.
 
 *Modified By					:Manoj Chand
 *Date of Modification			:23 Jan 2013
 *Modification					:display alert to STARS Admin or Local Admin when user workflow number updated and user some requests are pending for approval.
 
 *Modified By			:Manoj Chand
 *Date of Modification	:22 Oct 2013
 *Modification			:javascript validation to stop from typing --,'  symbol is added.
 *******************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
<%@page import="java.net.URLDecoder"%>

<%-- Import Statements  --%>
<%@ include  file="importStatement.jsp" %>
<html>
<head>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<SCRIPT language="JavaScript" src="ScriptLibrary/popcalendar.js?buildstamp=2_0_0"></SCRIPT>  <!-- added by shiv on 07-Jun-07 -->
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT language="JavaScript" src="LocalScript/M_UpdateProfile.js?buildstamp=2_0_0"></SCRIPT>
 <link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" /><BASE>
 <script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
 
 <script>
 function openVisaUploadWindow(theURL,winName) {
 	var width 	= 600;
	var height 	= 150;
	var left 	= parseInt((screen.availWidth/2) - (width/2));
	var top 	= parseInt((screen.availHeight/2) - (height/2));
	
	var windowFeatures = "width=570,height=300,menubar=no,scrollbars=no,resizable=no,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;
	window.open(theURL,winName,windowFeatures);	  
 }
 
 function downloadVisaWindow(theURL) {
	 window.open(theURL,'viewVisa','menubar=0,resizable=yes,width=980,height=450,scrollbars=yes,left=15');
 }
	 
 function MM_openBrWindow(theURL,winName) 
 {
	 	var width = 600;
		var height = 150;
		var left = parseInt((screen.availWidth/2) - (width/2));
		var top = parseInt((screen.availHeight/2) - (height/2));
		var windowFeatures = "width=" + width + ",height=" + height + ",menubar=no,scrollbars=yes,resizable=yes,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;
		window.open(theURL,winName,windowFeatures);	  
 //window.open(theURL,winName,features);
 }

 function showpassportlink(){
	 document.getElementById('viewpassport').style.visibility='visible';
 }

 function MM_openBrWindow1(theURL,winName) 
 {
	 	var width = 700;
		var height = 300;
		var left = parseInt((screen.availWidth/2) - (width/2));
		var top = parseInt((screen.availHeight/2) - (height/2));
		var windowFeatures = "width=" + width + ",height=" + height + ",menubar=no,scrollbars=yes,resizable=no,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;
		window.open(theURL,winName,windowFeatures);	  
 //window.open(theURL,winName,features);
 }
 
 </script>
 
<%
request.setCharacterEncoding("UTF-8");
// Global Variables declared and initialized
String strSql                   =  null;              // String for Sql String
ResultSet rs,rs1,rs2            =  null;              // Object for ResultSet
String FIRSTNAME                =  "";
String LASTNAME                 =  "";
/// 

String EMP_CODE                =  "";
////
String PIN                      =  "";
String EMAIL                    =  "";
String SITE_ID                  =  "";
String DIV_ID                   =  "";
String DEPT_ID                  =  "";
String DESIG_ID                 =  "";
String REPORT_TO                =  "";
String SECRET_QUESTION          =  "";
String SECRET_ANSWER            =  "";
String PASSPORT_NO              =  "";
String nationality              =  "";
String DATE_ISSUE               =  request.getParameter("dateOfIssue")==null?"":request.getParameter("dateOfIssue");
String ECNR                     =  "";
String EXPIRY_DATE              =  "";
String FF_NUMBER                =  "";
String FF_NUMBER1               =  "";
String FF_NUMBER2               =  "";
String strUserName  			=  "";

//new 16-02-2007
String strCurrentAddress	=	"";
String strAirLineName		=	"";
String strAirLineName1		=	"";
String strAirLineName2		=	"";
String SECRET_ANSWER_decrypt="";
//


//Mukesh Mishra
String FF_NUMBER3               =  "";
String FF_NUMBER4               =  "";
String strAirLineName3		=	"";
String strAirLineName4		=	"";
String hotelChain="";
String hotelChain1="";
String hotelChain2="";
String hotelChain3="";
String hotelChain4="";
String hotelNumber="";
String hotelNumber1="";
String hotelNumber2="";
String hotelNumber3="";
String hotelNumber4="";
String passportIssuCountry = "";

String PLACE_ISSUE              =  "";
String DOB                      =  "";
String ADDRESS                  =  "";
String CONTACT_NUMBER           =  "";
String strMessage               =  "";
String[] arrayRadio 			= {dbLabelBean.getLabel("label.mylinks.unitid",strsesLanguage),dbLabelBean.getLabel("label.mylinks.acrosstheunit",strsesLanguage)};


String strEmailIDAccess         =	"readOnly";
String strGender					=	""; //add by vijay on 20/04/2007


String strWinUserID             =""; 
String strDomainName			="";



//added  new code on 23-May-07 open  
String strDeactiveflag="";
strDeactiveflag= request.getParameter("Deactiveflag");
//added  new code on 23-May-07 open 

if((SuserRoleOther.trim().equals("LA")) || (SuserRole.trim().equals("AD")))
{
	strEmailIDAccess  =  "";
}

//System.out.println("request.getParameter()"+request.getParameter("strMessage"));
strMessage          =  URLDecoder.decode((request.getParameter("strMessage")==null || request.getParameter("strMessage")=="")?dbLabelBean.getLabel("submenu.mylinks.updateprofile",strsesLanguage):request.getParameter("strMessage"), "UTF-8");
String strMsg		=  URLDecoder.decode((request.getParameter("Message")==null) ? "" : request.getParameter("Message"), "UTF-8");
//System.out.println("strMsg--->"+strMsg);



String strDivNameId	= (request.getParameter("division")==null || request.getParameter("division")=="")?"-1":request.getParameter("division");

String	strSiteNameId		=  (request.getParameter("site")==null || request.getParameter("site")=="")?"-1":request.getParameter("site");

String		strDeptNameId		=  (request.getParameter("department")==null || request.getParameter("department")=="")?"-1":request.getParameter("department");

String		strDesigNameId		=  (request.getParameter("designation")==null || request.getParameter("designation")=="")?"-1":request.getParameter("designation");

String      changeCombo         =  (request.getParameter("changeCombo")==null || request.getParameter("changeCombo")=="")?"no":request.getParameter("changeCombo");


String strUserId                =  request.getParameter("userId");  // get the user id if admin update the profile 

//added by manoj chand on 19 sept 2012 to fetch local admin
String strSiteID=request.getParameter("siteid")==null?"":request.getParameter("siteid");
String strLocalAdmin="";
String strGenderType="";
String strDeactiveMsg="";
//strSql="SELECT ISNULL(dbo.user_name(USERID),'-') AS NAME FROM M_USERROLE WHERE SITE_ID='"+strSiteID+"' AND STATUS_ID=10";
strSql="SELECT ISNULL(dbo.user_name(urm.USERID),'-') AS NAME,isnull(rtrim(uim.GENDER),'') as gender from M_USERROLE urm inner join"+
		" m_userinfo uim  on uim.USERID=urm.USERID WHERE urm.SITE_ID='"+strSiteID+"' AND urm.STATUS_ID=10 and uim.STATUS_ID=10";
//System.out.println("0 strSql======="+strSql);
  rs = dbConBean.executeQuery(strSql);
if(rs.next()){
	strLocalAdmin=rs.getString("NAME").trim();
	strGenderType=rs.getString("gender").trim();
	if(strLocalAdmin.equals("-")){
		strDeactiveMsg=dbLabelBean.getLabel("alert.updateprofile.starsadministratorwould",strsesLanguage);
	}
	if(!strLocalAdmin.equals("-") && strGenderType.equalsIgnoreCase("Male")){
		strLocalAdmin="("+dbLabelBean.getLabel("alert.updateprofile.mr",strsesLanguage)+" "+strLocalAdmin+")";
		strDeactiveMsg=dbLabelBean.getLabel("alert.updateprofile.yourlocaladmin",strsesLanguage)+" "+strLocalAdmin+" "+dbLabelBean.getLabel("alert.updateprofile.verifydetailskindlycontacthim",strsesLanguage);
	}
	if(!strLocalAdmin.equals("-") && strGenderType.equalsIgnoreCase("Female")){
		strLocalAdmin="("+dbLabelBean.getLabel("alert.updateprofile.ms",strsesLanguage)+" "+strLocalAdmin+")";
		strDeactiveMsg=dbLabelBean.getLabel("alert.updateprofile.yourlocaladmin",strsesLanguage)+" "+strLocalAdmin+" "+dbLabelBean.getLabel("alert.updateprofile.verifydetailskindlycontacther",strsesLanguage);
	}
}else{
	//System.out.println("else block");
	strDeactiveMsg=dbLabelBean.getLabel("alert.updateprofile.starsadministratorwould",strsesLanguage);
}
//End Here

String strIdentityproof					= "";
String strIdentityproofNo			    = "";
String strMiddleName                    = "";
String strdeptHead						= "";
String strTravelAgencyCode				= "1";
String strSAPUserSyncFlag				= "N";

byte[] FileBytes  = null;
strIdentityproof			= request.getParameter("strIdentityproof") == null ? "-1" : request.getParameter("strIdentityproof");
String strLanguage= request.getParameter("language")== null ? "en_US" : request.getParameter("language");
String strSp_role				="";
if(strUserId == null)
{
   strUserId = Suser_id;    // Suser_id is login person userid
}
        
    //sql for getting the information for display from M_UserInfo Table
	//@ Vijay Singh 09/04/2007 changes in database query
	// change database query to select the gender
	// Query changes for window user id and domain name on 05-03-2009 by sharma 
    strSql="SELECT FIRSTNAME,LASTNAME,PIN,LTRIM(RTRIM(EMAIL)) AS EMAIL,SITE_ID,DIV_ID,DEPT_ID,DESIG_ID,ISNULL(REPORT_TO,'') AS REPORT_TO,ISNULL(SECRET_QUESTION,'') AS SECRET_QUESTION,ISNULL(SECRET_ANSWER,'') AS SECRET_ANSWER,LTRIM(RTRIM(ISNULL(PASSPORT_NO,''))) AS PASSPORT_NO,ISNULL(.DBO.CONVERTDATEDMY1(DATE_ISSUE),'') AS DATE_ISSUE,ISNULL(ECNR,'') AS ECNR,ISNULL(.DBO.CONVERTDATEDMY1(EXPIRY_DATE),'') AS EXPIRY_DATE, ISNULL(FF_NUMBER,'') AS FF_NUMBER,ISNULL(FF_NUMBER1,'') AS FF_NUMBER1, ISNULL(FF_NUMBER2,'') AS FF_NUMBER2,ISNULL(PLACE_ISSUE,'') AS PLACE_ISSUE,ISNULL(.DBO.CONVERTDATEDMY1(DOB),'') AS DOB, ISNULL(ADDRESS,'') AS ADDRESS,ISNULL(CONTACT_NUMBER,''),ISNULL(CURRENT_ADDRESS,'') AS CURRENT_ADDRESS, ISNULL(FF_AIR_NAME,'') AS FF_AIR_NAME, ISNULL(FF_AIR_NAME1,'') AS FF_AIR_NAME1, ISNULL(FF_AIR_NAME2,'') AS FF_AIR_NAME2,EMP_CODE, GENDER, ISNULL(IDENTITY_ID,-1) AS IDENTITY_ID,ISNULL(IDENTITY_NO,'') AS IDENTITY_NO,isnull(MIDDLENAME ,'') as MIDDLENAME,WIN_USER_ID, DOMAIN_NAME,LANGUAGE_PREF,P_FILE,SP_ROLE, USERNAME, NATIONALITY, ISNULL(COST_CENTER_ID,'0') AS COSTCENTRE, ISNULL(DEPT_HEAD,'') AS DEPT_HEAD,ISNULL(FF_NUMBER3,'') AS FF_NUMBER3,ISNULL(FF_NUMBER4,'') AS FF_NUMBER4,ISNULL(FF_AIR_NAME3,'') AS FF_AIR_NAME3,ISNULL(FF_AIR_NAME4,'') AS FF_AIR_NAME4,ISNULL(HOTEL_NAME,'') AS HOTEL_NAME,ISNULL(HOTEL_NAME1,'') AS HOTEL_NAME1,ISNULL(HOTEL_NAME2,'') AS HOTEL_NAME2,ISNULL(HOTEL_NAME3,'') AS HOTEL_NAME3,ISNULL(HOTEL_NAME4,'') AS HOTEL_NAME4,ISNULL(HOTEL_NUMBER,'') AS HOTEL_NUMBER,ISNULL(HOTEL_NUMBER1,'') AS HOTEL_NUMBER1,ISNULL(HOTEL_NUMBER2,'') AS HOTEL_NUMBER2,ISNULL(HOTEL_NUMBER3,'') AS HOTEL_NUMBER3,ISNULL(HOTEL_NUMBER4,'') AS HOTEL_NUMBER4, ISNULL(PASSPORT_ISSUE_COUNTRY,'0') AS PASSPORT_ISSUE_COUNTRY FROM M_USERINFO WHERE USERID='"+strUserId+"' and  application_id=1";//2/28/2007
//System.out.println("1 strSql======="+strSql);

    rs = dbConBean.executeQuery(strSql);
	if(rs.next())
	{
		FIRSTNAME        = rs.getString(1);
		LASTNAME         = rs.getString(2);
		PIN              = rs.getString(3);
		EMAIL            = rs.getString(4);
		
		if(changeCombo !=null && changeCombo.equals("yes"))
        {
	    	
		}
		else
		{
           strSiteNameId    = rs.getString(5);
    	   strDivNameId     = rs.getString(6);
	       strDeptNameId    = rs.getString(7);
		   strDesigNameId   = rs.getString(8);
		}
		
		REPORT_TO        = rs.getString(9);
		SECRET_QUESTION  = rs.getString(10);
		
		SECRET_ANSWER   = rs.getString(11);
		PASSPORT_NO     = rs.getString(12);
		DATE_ISSUE      = rs.getString(13);
		ECNR            = rs.getString(14);
		EXPIRY_DATE     = rs.getString(15);
		FF_NUMBER       = rs.getString(16);
		FF_NUMBER1      = rs.getString(17);
		FF_NUMBER2      = rs.getString(18);
		PLACE_ISSUE     = rs.getString(19);
		DOB             = rs.getString(20);
		ADDRESS         = rs.getString(21);
		CONTACT_NUMBER  = rs.getString(22);
		


		//NEW 16-02-2007 SACHIN
		strCurrentAddress	=	rs.getString("CURRENT_ADDRESS");
		strAirLineName		=	rs.getString("FF_AIR_NAME");
		strAirLineName1		=	rs.getString("FF_AIR_NAME1");
		strAirLineName2		=	rs.getString("FF_AIR_NAME2");
		EMP_CODE         = rs.getString("EMP_CODE");
		//
		//Mukesh Mishra
		strAirLineName3		=	rs.getString("FF_AIR_NAME3");
		strAirLineName4	=	rs.getString("FF_AIR_NAME4");
		FF_NUMBER3      = rs.getString("FF_NUMBER3");
		FF_NUMBER4      = rs.getString("FF_NUMBER4");
		hotelChain          =rs.getString("HOTEL_NAME");
		hotelChain1          =rs.getString("HOTEL_NAME1");
		hotelChain2          =rs.getString("HOTEL_NAME2");
		hotelChain3          =rs.getString("HOTEL_NAME3");
		hotelChain4          =rs.getString("HOTEL_NAME4");
		hotelNumber          =rs.getString("HOTEL_NUMBER");
		hotelNumber1          =rs.getString("HOTEL_NUMBER1");
		hotelNumber2          =rs.getString("HOTEL_NUMBER2");
		hotelNumber3          =rs.getString("HOTEL_NUMBER3");
		hotelNumber4          =rs.getString("HOTEL_NUMBER4");
		passportIssuCountry	  =rs.getString("PASSPORT_ISSUE_COUNTRY");
		
		strGender		= rs.getString("GENDER"); //add by vijay on 20/04/2007
        /// added by shiv on 10/18/2007 
		strIdentityproof					= rs.getString("IDENTITY_ID");
		strIdentityproofNo			= rs.getString("IDENTITY_NO");
		strMiddleName			    = rs.getString("MIDDLENAME");

		strWinUserID                ="strWinUserID" ; 
		strDomainName				="strDomainName";
		

		strWinUserID       =rs.getString("WIN_USER_ID"); 	
		strDomainName	   =rs.getString("DOMAIN_NAME");;	 
		strLanguage		   =rs.getString("LANGUAGE_PREF");
		if(strLanguage!=null && strLanguage.equals("")){
			strLanguage="en_US";
		}
		 
		FileBytes=rs.getBytes("P_FILE");
		strSp_role=rs.getString("SP_ROLE");
		//System.out.println("strSp_role--->"+strSp_role);
		strUserName=rs.getString("USERNAME");
		nationality = rs.getString("NATIONALITY");
	}
	strdeptHead =  rs.getString("DEPT_HEAD"); 
	
	rs.close();
//SECRET_ANSWER=dbUtility.decryptFromDecimalToString(SECRET_ANSWER);
   //Get the name of Report_To Person
   String strReportPersonName = "";                      //define the variable for getting the name of reporting person
   String strDeptHeadPersonName = "";
   //query for the getting the name for reporting person 

   //status_id  removed  by shiv on 24-May-07 open
   strSql = "select ISNULL(dbo.user_name(Report_to),''),ISNULL(dbo.user_name(DEPT_HEAD),'')  from M_userInfo where USERID='"+strUserId+"' and  application_id=1";
   //status_id  removed  by shiv on 24-May-07 close
   //System.out.println("strSql--->"+strSql);
   
   rs     = dbConBean.executeQuery(strSql);    //Get the resultset form the M_UserInfo
   if(rs.next())
   {
         strReportPersonName = (rs.getString(1) == null || "-".equals(rs.getString(1))) ? "" :  rs.getString(1);
         strDeptHeadPersonName = (rs.getString(2) == null || "-".equals(rs.getString(2))) ? "" :  rs.getString(2);
   }
   rs.close();
   
   rs=null;
   strSql =   "SELECT TRAVEL_AGENCY_ID, SAP_USER_SYNC_FLAG FROM M_SITE WHERE SITE_ID="+strSiteNameId+" AND STATUS_ID = 10";
   rs     =   dbConBean.executeQuery(strSql);
   if(rs.next()) {
	   strTravelAgencyCode 	= rs.getString("TRAVEL_AGENCY_ID");
	   strSAPUserSyncFlag	= rs.getString("SAP_USER_SYNC_FLAG");
   }
   rs.close();

  // get the current date for checking the expiryDate and DateOfBirth
  Date currentDate = new Date();
  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
  String strCurrentDate = (sdf.format(currentDate)).trim();
%>

<script language=JavaScript>
	
	function sapUserSyncAlert() {
		alert('<%=dbLabelBean.getLabel("alert.sapusersync.cannotupdateuser",strsesLanguage)%>');
	}
	
 	function setValue() {
		 document.frm.action="M_UpdateProfile.jsp?changeCombo=yes";
		 document.frm.designation.value="-1";
		 document.frm.department.value="-1";
		 document.frm.submit();
		
		 /* var div  = document.frm.division.value;
		 var site = document.frm.site.value;
		 var dept = document.frm.department.value;
		 if(div == "S")
		 {
			site = "S";
			dept = "S";
		 }
		 if(site == "S")
		 {
			dept = "S"
		 }	
		 //alert("div is =="+ div+"  site is=="+site+"  dept is=="+dept );
		 window.location.href = "M_UpdateProfile.jsp?division="+div+"&site="+site+"&department="+dept+"&changeCombo=yes&"+"userId="+<%=strUserId%>;*/
 	}

  //Added By Vijay Singh ON 11/04/2007 TO ENABLE AND DISABLE THE FUNCTIONALITY
		 function questOther()
		{

			if(document.frm.quest_secret1.value=="Others")
			{
				document.frm.secretQuestion.disabled=false;
				document.frm.secretAnswer.value="";
				document.frm.secretQuestion.focus();
			}
			else
			{
				document.frm.secretQuestion.value="";
				document.frm.secretAnswer.value="";
				document.frm.secretQuestion.disabled=true;
			}
		}
		//END MODIFICATION
		//Added By Vijay Singh ON 17/04/2007 FOR SELECTING THE QUESTION FROM THE OPTION LIST
		function optionValue()
		{
			var question;
			for(var i=0;i<document.frm.quest_secret1.length;i++)
			{
				question=document.frm.quest_secret1[i].value;
								
				if(question=="<%=SECRET_QUESTION%>")
				{
					document.frm.quest_secret1.value="<%=SECRET_QUESTION%>";
					document.frm.secretQuestion.value="";
					document.frm.secretQuestion.disabled=true;
					break;
				}
				else  
				{
					document.frm.secretQuestion.disabled=false;
					document.frm.quest_secret1.value="Others";
					document.frm.secretQuestion.value="<%=SECRET_QUESTION%>";
					if(document.frm.secretQuestion.value=='')
					{
						document.frm.quest_secret1.value="-1";
						document.frm.secretQuestion.disabled=true;
					}
				}
			}
				
		}
//END MODIFICATION
//Added By Vijay Singh ON 20/04/2007 FOR SELECTING THE GENDER FROM THE OPTION LIST

		function gender()
		{
			var gender;
			for(var j=0;j<document.frm.gender.length;j++)
			{
				gender=document.frm.gender[j].value;
				if(gender=="<%=strGender%>")
				{
					document.frm.gender.value="<%=strGender%>";
					break;
				}
				else
				{
					document.frm.gender.value="-1";
				}
			}

		}
//END MODIFICATION
  var travelAgencyCode ='<%=strTravelAgencyCode%>';
	
  function checkData(f1)
  {
			
	if(f1.firstName.value=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.global.firstname",strsesLanguage)%>');
		f1.firstName.focus();
		return false;
	}
	
	if(f1.lastName.value =='' && travelAgencyCode == '2')
	{
		alert('<%=dbLabelBean.getLabel("label.global.lastname",strsesLanguage)%>');
		f1.lastName.focus();
		return false;
	}
	
	if(f1.gender.value=='-1')
	{
		alert('<%=dbLabelBean.getLabel("alert.global.gender",strsesLanguage)%>');
		f1.gender.focus();
		return false;
	}
	
	if(f1.email.value=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.mylinks.enteremail",strsesLanguage)%>');
		f1.email.focus();
		return false;
	}
	var flag = echeck(window.document.frm.email.value);
	if (flag == false)
	{
		f1.email.focus();
		return flag;
	}
    if(f1.division.value == '-1' || f1.division.value == '')
	{
       alert('<%=dbLabelBean.getLabel("alert.mylinks.selectdivision",strsesLanguage)%>');
	   f1.division.focus();
	   return false;  
	}
	if(f1.site.value == '-1' || f1.site.value == '')
	{
       alert('<%=dbLabelBean.getLabel("alert.handover.pleaseselectsite",strsesLanguage)%>');
	   f1.site.focus();  
	   return false;  
	}
	
	
	if(f1.department.value == '-1' || f1.department.value == '')
	{
		if(travelAgencyCode =='2') {
			alert('<%=dbLabelBean.getLabel("alert.global.costcentre",strsesLanguage)%>');
		} else {
			alert('<%=dbLabelBean.getLabel("alert.mylinks.selectdepartment",strsesLanguage)%>');
		}
        
	   f1.department.focus();
	   return false;  
	}

	if(f1.designation.value == '-1' || f1.designation.value == '')
	{
       alert('<%=dbLabelBean.getLabel("alert.global.designation",strsesLanguage)%>');
	   f1.designation.focus();
	   return false;  
	}
	///2/28/2007 
 
	if(f1.empcode.value == '')
	{
       alert('<%=dbLabelBean.getLabel("alert.mylinks.enteremployeecode",strsesLanguage)%>');
	   f1.empcode.focus();
	   return false;  
	}
	 //Added By Vijay Singh on 11/04/2007 check for secret Question and Answer 
			
			 if(f1.quest_secret1.value=='-1'&& f1.secretQuestion.value=='')
			 {
				 alert('<%=dbLabelBean.getLabel("alert.mylinks.selectsecretquestion",strsesLanguage)%>');
				 f1.quest_secret1.focus();
				 return false;
			 }
			 //@ Vijay Singh 14/04/2007 Change the functionality of secret question
			 if(f1.secretQuestion.disabled==false && f1.secretQuestion.value=='')
			 {
				 alert('<%=dbLabelBean.getLabel("alert.mylinks.entersecretquestion",strsesLanguage)%>');
				 f1.secretQuestion.focus();
				 return false;
			 }
		/*	 if(f1.quest_secret1.value=='Others' &&f1.secretQuestion.disabled==false && f1.secretQuestion.value=='')
			 {

				alert("Please Enter Your  Secret Question");
				f1.secretQuestion.focus();
				return false;
			  }*/
			   if(f1.secretAnswer.value=='')
			 {
				 alert('<%=dbLabelBean.getLabel("alert.mylinks.entersecretanswer",strsesLanguage)%>');
				 f1.secretAnswer.focus();
				 return false;
			 }
			   if(f1.secretQuestion.disabled==false && f1.secretQuestion.value!='')
			  {
				f1.question_other.value=f1.secretQuestion.value;
				
			  }
			  else
			  {
				  f1.question_other.value = '-';
			  }
	    	 //END MODIFICATION ON 11/04/2007.		  


		//empcode
				if(f1.dateOfBirth.value == 'S' || f1.dateOfBirth.value == '')
				{
			       alert('<%=dbLabelBean.getLabel("alert.global.dob",strsesLanguage)%>');
				   f1.dateOfBirth.focus();
				   return false;  
				}  
	    	 
// 				if(f1.repToUserId.value == '' || f1.report.value == '')
// 				{
<%-- 			       alert('<%=dbLabelBean.getLabel("alert.global.reportto",strsesLanguage)%>'); --%>
// 				   f1.report.focus();
// 				   return false;  
// 				}
// 				if(f1.deptHeadUserId.value == '' || f1.deptHead.value == '')
// 				{
<%-- 			       alert('<%=dbLabelBean.getLabel("alert.global.deptHead",strsesLanguage)%>'); --%>
// 				   f1.deptHead.focus();
// 				   return false;  
// 				}
	
		//added new  for Identity   on 23-Oct-07  by Shiv Sharma           
               if(f1.identityProof.value!="-1")
			  {
				if (f1.identityproofno.value=='')
				  {
					alert('<%=dbLabelBean.getLabel("alert.createrequest.identityproofnumber",strsesLanguage)%>');
					f1.identityproofno.focus();
					 return false;  
				}
			} 
			
		//added by shiv sharma  on 03-02-2009
			//winUserID domainname
			
			if(f1.winUserID.value!='')
			  {
				if (f1.domainname.value=='')
				  {
					alert('<%=dbLabelBean.getLabel("alert.mylinks.enternetworkdomainname",strsesLanguage)%>');
					 f1.domainname.focus();
					 return false;  

				}
			}	
//added by manoj chand on 14 august 2012 to show workflow number alert message.
if(f1.sp_role!=null || f1.sp_role!=undefined){
			if(f1.sp_role.value=='-1' || f1.sp_role.value=='')
			  {
					alert('<%=dbLabelBean.getLabel("alert.administration.pleaseselectworkflownumber",strsesLanguage)%>');
					 f1.sp_role.focus();
					 return false;  
			}	
}
	var flag;
	if(travelAgencyCode == '2') {
		flag = checkPassportInfoGmbH(f1);
	} else {
		flag = checkPassportInfo(f1); //checking if any passport informations are filled.
	}
	
	if(flag == false)
		return flag;
	flag =  checkDOB(f1);
	if(flag == false)
		return flag;

    var flag = CheckFFDetail(f1); 
       if(flag == false)
	  {
		return flag;
	  }
	//encryption();
	
    //added by manoj chand on 23 jan 2013 to make check and show alert when changing workflow number.
	if(f1.sp_role!=null || f1.sp_role!=undefined){
	if(f1.sp_role.value!='<%=strSp_role%>'){	    	
	var resflag =	fun_checkuserrequest(f1.sp_role.value);
	if(resflag=='Y'){
		alert('<%=dbLabelBean.getLabel("alert.updateprofile.cannotupdateworkflownumber",strsesLanguage)%>');
		f1.sp_role.value='<%=strSp_role%>';
		return false;
	}
	}
	}

	return true;
  }
  function encryption()
         {
			 //added the secret answer field for encript password @Vijay 11/04/2007
            var secret_answer="<%=SECRET_ANSWER%>";
			alert("Encrypted newSecret_answer with key is being sent to request "+secret_answer);
           // var newSecret_answer=encrypt(secret_answer);
			//document.form.secretAnswer.value=newSecret_answer;
					
            return true;
         }  

// fuction for get the value from the ReportTo Link
  function ReportToWindowOpen(filename) 
  {    
	designation = showModalDialog(filename+"?DIV_ID="+document.frm.division.value+"&DEPT_ID="+document.frm.department.value+
			"&DESIG_ID="+document.frm.designation.value+
			"&SITE_ID="+document.frm.site.value,
			"Win","scrollbars=no,resizable=no,menubar=no,width=350,height=350");

	if(designation==null)
	{
    	document.frm.reportTo.value="";
	}
	else
	{
		document.frm.reportTo.value =designation.flag;
		var userid = designation.userid;
		document.frm.repToUserId.value =designation.userid;
		//alert(userid);
	}
 }


function test1(obj1, length, str)
{	
	var obj;

	if(obj1=='firstName')
	{
		obj = document.frm.firstName;
	}
	if(obj1=='lastName')
	{
		 obj = document.frm.lastName;
	}	
	if(obj1=='middleName')
	{
		 obj = document.frm.middleName;
	}	
    if(obj1=='empcode')
	{
		 obj = document.frm.empcode;
		 //zeroChecking(obj);
	}
    if(obj1=='identityproofno')
	{
		 obj = document.frm.identityproofno;
		 upToTwoHyphen(obj);
	}	

	if(obj1=='eMail')
	{
		 obj = document.frm.email;
		 upToTwoHyphen(obj);
	}	

	if(obj1=='secretQuestion')
	{
		 obj = document.frm.secretQuestion;
		 upToTwoHyphen(obj);
	}	
	if(obj1=='secretAnswer')
	{
		 obj = document.frm.secretAnswer;
	}	
	if(obj1=='passportNo')
	{
		 obj = document.frm.passportNo;
		 upToTwoHyphen(obj);
	}	
	if(obj1=='nationality')
	{
		 obj = document.frm.nationality;
		 upToTwoHyphen(obj);
	}
	if(obj1=='ffNo')
	{
		 obj = document.frm.ffNo;
	}
	if(obj1=='ffNo1')
	{
		 obj = document.frm.ffNo1;
	}	
	if(obj1=='ffNo2')
	{
		 obj = document.frm.ffNo2;
	}
	//Mukesh Mishra
	if(obj1=='ffNo3')
	{
		 obj = document.frm.ffNo3;
	}
	if(obj1=='ffNo4')
	{
		 obj = document.frm.ffNo4;
	}
	if(obj1=='airLineName')
	{
		 obj = document.frm.airLineName;
	}	
	if(obj1=='airLineName1')
	{
		 obj = document.frm.airLineName1;
	}	
	if(obj1=='airLineName2')
	{
		 obj = document.frm.airLineName2;
	}
	//Mukesh Mishra
	if(obj1=='airLineName3')
	{
		 obj = document.frm.airLineName3;
	}
	if(obj1=='airLineName4')
	{
		 obj = document.frm.airLineName4;
	}
	if(obj1=='hotelChain')
	{
		 obj = document.frm.hotelChain;
	}
	if(obj1=='hotelChain1')
	{
		 obj = document.frm.hotelChain1;
	}
	if(obj1=='hotelChain2')
	{
		 obj = document.frm.hotelChain2;
	}
	if(obj1=='hotelChain3')
	{
		 obj = document.frm.hotelChain3;
	}
	if(obj1=='hotelChain4')
	{
		 obj = document.frm.hotelChain4;
	}
	if(obj1=='hotelNumber')
	{
		 obj = document.frm.hotelNumber;
	}
	if(obj1=='hotelNumber1')
	{
		 obj = document.frm.hotelNumber1;
	}
	if(obj1=='hotelNumber2')
	{
		 obj = document.frm.hotelNumber2;
	}
	if(obj1=='hotelNumber3')
	{
		 obj = document.frm.hotelNumber3;
	}
	if(obj1=='hotelNumber4')
	{
		 obj = document.frm.hotelNumber4;
	}
	if(obj1=='placeOfIssue')
	{
		 obj = document.frm.placeOfIssue;
	}	
	if(obj1=='address')
	{
		 obj = document.frm.address;
		 upToTwoHyphen(obj);
	}	
	if(obj1=='current_address')
	{
		 obj = document.frm.current_address;
		 upToTwoHyphen(obj);
	}	
	if(obj1=='contactNo')
	{
		 obj = document.frm.contactNo;
		 upToTwoHyphen(obj);
	}
	//add by Vijay on 20/04/2007 
	if(obj1=='gender')
	{
		obj = document.frm.gender;
	}
	if(obj1=='winUserID')
	{
		 obj = document.frm.winUserID;
		 upToTwoHyphen(obj);
	}	
	if(obj1=='domainname')
	{
		 obj = document.frm.domainname;
		 upToTwoHyphen(obj);
	}	
	
	if(obj1=='userName')
	{
		 obj = document.frm.userName;
		 upToTwoHyphen(obj);
	}
    
//	var obj11 = document.frm.obj.value;
//	alert(""+obj11);
	charactercheck(obj,str);
	limitlength(obj, length);
	//zeroChecking(obj); //function for checking leading zero and spaces
	spaceChecking(obj);
}



	function report_to(filename,k)
	{
		reportto = showModalDialog(filename+"&site_id="+document.frm.reportto[k].value+"&i="+k,"Win","scrollbars=yes,resizable=no,menubar=no,width=350,height=350");
		if(reportto==null)
		{	document.frm.report.value="";
		}
		else
		{	document.frm.report.value=reportto.flag;
			document.frm.repToUserId.value=reportto.userid;
		}
	}
		
	function dept_Head(filename,k)
	{
		//alert(filename);
		deptHead = showModalDialog(filename+"&site_id="+document.frm.reportto[k].value+"&selectHod=Y"+"&i="+k,"Win","scrollbars=yes,resizable=no,menubar=no,width=350,height=350");

  		if(deptHead==null)
		{	document.frm.deptHead.value="";
		}
		else
		{	document.frm.deptHead.value=deptHead.flag;
			document.frm.deptHeadUserId.value=deptHead.userid;
		}
	}


 // added  on 07-Jun-07  by  shiv   
  function button_onclick(obj) 
	    {
	             popUpCalendar(obj,obj,"dd/mm/yyyy");
		}

//added by manoj chand on 23 jan 2013 to check whether user have some requests in movement.
  function fun_checkuserrequest(workflownumber){
  			var var_userid='<%=strUserId%>';
  			var urlParams = 'strFlag=CheckUserRequest&userid='+var_userid;
  			var ret_flag;
  			if(workflownumber!='-1'){
  			jQuery.ajax({
  	            type: "post",
  	            url: "AjaxMaster.jsp",
  	            async: false,
  	            data: urlParams,
  	            success: function(result){
  					ret_flag=jQuery.trim(result);
  	            },
  				error: function(){
  					alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
  	            }
  	          });
  			}
  			return ret_flag;
  }

  
</script>

</head>



<!-- Start of body -->

<body onload="optionValue();gender();"><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>

<!-- Start of Form -->
<form method=post name=frm action="M_UpdateProfilePost.jsp" >
<script type="text/javascript">
var msg='<%=strMsg%>';
var var_DeactivatMsg='<%=strDeactiveMsg%>';
if(msg=='deactivated'){
	alert('<%=dbLabelBean.getLabel("alert.updateprofile.yourstarsaccount",strsesLanguage)%>'+var_DeactivatMsg);
	document.frm.action='sessionExpired.jsp';
	document.frm.submit();
}
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td height="32" class="bodyline-top">
	<ul class="pagebullet">
	<%if(strMessage.equals(dbLabelBean.getLabel("label.mylinks.userprofilenotupdated",strsesLanguage)) || strMessage.equals(dbLabelBean.getLabel("label.mylinks.profilecouldnotbesaved",strsesLanguage))){ %>
      <li class="pageHead"><Font color='red'><%=strMessage%></Font></li>
     <%} else{ %>
      <li class="pageHead"><%=strMessage%></li>
     <%} %>
    </ul>	</td>	
  </tr>
</table><br></br>
<table width="88%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
<tr align="left">
  <td colspan="4" class="selectedmenubg">&nbsp;</td>
  </tr>
<tr align="left"><!-- text color change  by shiv on 03-Aug-07 open --> 
  <td colspan="4" class="dataLabel"><%=dbLabelBean.getLabel("label.mylinks.updateyouruserid",strsesLanguage)%> <font color='red' size=1> <%=dbLabelBean.getLabel("label.mylinks.incaseyoumakeanychanges",strsesLanguage)%> </font ><font color='#33CC00' size=1><%=dbLabelBean.getLabel("label.mylinks.nameunitdesignationdepartmentempcode",strsesLanguage)%></font > <font color='red' size=1> <%=dbLabelBean.getLabel("label.mylinks.youraccessinstarswouldbedisabled",strsesLanguage)%></font></td><!-- text color change  by shiv on 03-Aug-07 close -->
  </tr>
<tr align="left"> 
  <td width="10%" class="formtr1"><FONT SIZE="" COLOR="#FF3300">* </FONT><%=dbLabelBean.getLabel("label.global.firstname",strsesLanguage)%> </td>  
  <!--  FIRST NAME  -->
  <td width="20%" class="formtr1"><input type="text" name="firstName" size="25" onKeyUp="return test1('firstName', 29, 'c')" maxlength="50"  class="textBoxCss" value="<%=FIRSTNAME%>"/> <%=dbLabelBean.getLabel("label.mylinks.asperpassport",strsesLanguage)%>  
     </td>
  <td width="11%" class="formtr1"> <FONT SIZE="" COLOR="#FF3300"></FONT>&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.mylinks.middlename",strsesLanguage)%>  
     </td>  
  <!--  Middle NAME  -->
  <td width="10%" class="formtr1"><input type="text" name="middleName" size="25" onKeyUp="return test1('middleName', 29, 'c')" maxlength="50" class="textBoxCss" value="<%=strMiddleName%>"/>
    <%=dbLabelBean.getLabel("label.mylinks.asperpassport",strsesLanguage)%>  
     <br> 
    </td>
</tr>
<tr align="left">
  <td width="120"  class="formtr1">
<% 			if(("2").equals(strTravelAgencyCode)) { %>				   		
		   		<FONT SIZE="" COLOR="#FF3300">* </FONT>
<% 			} else { %>
				&nbsp;&nbsp;&nbsp;
<%			} %>
			<%=dbLabelBean.getLabel("label.global.lastname",strsesLanguage)%>
  </td>  
  <!--  LAST NAME  -->
  <td width="328"  colspan="1" class="formtr1"><input type="text" name="lastName" size="25" onKeyUp="return test1('lastName', 29, 'c')" maxlength="50" class="textBoxCss" value="<%=LASTNAME%>"/>   
         <%=dbLabelBean.getLabel("label.mylinks.asperpassport",strsesLanguage)%> </td>
   <td width="11%" class="formtr1">&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.mylinks.language",strsesLanguage)%></td>
   <td width="120" class="formtr1">
	   <select id="language" name="language" class="textBoxCss">  
								  <% 
								  rs=null;
								  strSql = "SELECT DISTINCT LANG_ID,LANG_VALUE,LANGUAGE_NAME FROM LANGUAGE_MST WHERE LANGUAGE_MST.STATUS_ID=10 ORDER BY LANGUAGE_MST.LANG_ID";
		                           rs       =   dbConBean.executeQuery(strSql);  
								   while(rs.next())
		                          {
								   %>       
		                            <option value="<%=rs.getString("LANG_VALUE")%>"><%=rs.getString("LANGUAGE_NAME")%></option>
									<%
									}
		                           rs.close();
		                           %>
		 </select>
		 <script>
		 document.getElementById('language').value='<%=strLanguage%>';
		 </script>
   </td>
</tr>
<%
  strSql =   "select Div_id, Div_Name from M_Division where status_id=10 and application_id=1 order by 1";
  rs     =   dbConBean.executeQuery(strSql);  
  rs.close();
%>

<tr align="left">
  <td class="formtr1"><FONT SIZE="" COLOR="#FF3300">* </FONT><%=dbLabelBean.getLabel("label.mylinks.email",strsesLanguage)%></td>  <!--  EMAIL  -->
  <td class="formtr1"><input type="text" name="email" size="25" maxlength="50" onKeyUp="return test1('eMail', 50, 'txt')" class="textBoxCss" <%=strEmailIDAccess%> value="<%=EMAIL%>"/></td>
	<input type="hidden" name="division"> 
<% 
	rs = dbConBean.executeQuery("SELECT  DIV_ID FROM M_SITE WHERE APPLICATION_ID=1 and SITE_ID="+strSiteNameId); 
	while(rs.next())
	{
		strDivNameId=rs.getString(1);
	}
	rs.close();
%>
  
		<script language="javascript">
		document.frm.division.value="<%=strDivNameId%>";
		//alert(document.frm.division.value);
		</script>
   
  <td class="formtr1"><FONT SIZE="" COLOR="#FF3300">* </FONT><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage)%></td>  <!--  Site  -->
  <td class="formtr1">
    <select name="site" onChange= "return setValue();"  class="textBoxCss">
      <option value="-1" selected><%=dbLabelBean.getLabel("label.createrequest.selectunit",strsesLanguage)%></option>
<%
    //For Population of Site Combo according to the division
    if(strDivNameId != null && strDivNameId.equals("S"))
    {
      //strSql =   "select site_id, site_Name from M_Site where status_id=10 and application_id=1 order by 1";
    }
    else
    {
	  //New Check for local administrator
	  //query change by manoj chand on 03 july 2012 to not show closed unit in unit combobox.
	  if((SuserRole.trim().equals("AD")))
	  {	
   			strSql =   "SELECT SITE_ID,SITE_NAME FROM M_SITE WHERE  APPLICATION_ID=1 AND STATUS_ID = 10 AND (M_SITE.CLOSED_UNIT_FLAG is null or M_SITE.CLOSED_UNIT_FLAG='') ORDER BY SITE_NAME ";
	  }
	  else
	  {
		    strSql = "SELECT SITE_ID,SITE_NAME FROM M_SITE WHERE APPLICATION_ID=1 AND STATUS_ID = 10 AND (M_SITE.CLOSED_UNIT_FLAG is null or M_SITE.CLOSED_UNIT_FLAG='') ORDER BY SITE_NAME";	
	  }
      rs       =   dbConBean.executeQuery(strSql);  
      while(rs.next())
      {
%>
        <option value="<%=rs.getString("SITE_ID")%>"><%=rs.getString("SITE_NAME")%></option>
<%
	  }
      rs.close();	  
	}
%>
    </select>
	<script language="javascript">
	  document.frm.site.value="<%=strSiteNameId%>";
	</script>  </td>
  </tr>


 <tr align="left">	
  <td class="formtr1"><FONT SIZE="" COLOR="#FF3300">* </FONT> 
  	<%	if(strTravelAgencyCode.equals("2")) { %>
		<%=dbLabelBean.getLabel("label.createrequest.costcentre",strsesLanguage)%>
		
	<%	} else { %>
		<%=dbLabelBean.getLabel("label.requestdetails.department",strsesLanguage)%>
		
	<% 	} %>
  	
  </td>  <!--  Department  -->

  <td class="formtr1">
    <select name="department" class="textBoxCss">
    <%	if(strTravelAgencyCode.equals("2")){ %>
		<option value="-1" selected><%=dbLabelBean.getLabel("label.createrequest.selectcostcentre",strsesLanguage)%></option>
		
	<%	} else { %>
		<option value="-1" selected><%=dbLabelBean.getLabel("label.mylinks.selectdepartment",strsesLanguage)%></option>
		
	<% 	}
       //For Population of Department Combo according to the site
       if(strSiteNameId != null && strSiteNameId.equals("S")) 
       {
        //strSql =   "select dept_id, dept_name from M_Department order by 1";
       }
       else
       {
    	 strSql =   "select dept_id, dept_name from M_Department where div_id="+strDivNameId+" and site_id="+strSiteNameId+" and status_id=10 and application_id=1  order by dept_name";
         rs       =   dbConBean.executeQuery(strSql);  
	     while(rs.next())
	     {
%>
	        <option value="<%=rs.getString("Dept_Id")%>"><%=rs.getString("Dept_Name")%></option>
<%
	     }
         rs.close();	  
	   }
%>
    </select>
	<script language="javascript">
      document.frm.department.value="<%=strDeptNameId%>";
	</script>  </td>

<%
  //For Population of Designation Combo 
  strSql =   "SELECT DESIG_ID,DESIG_NAME  FROM M_DESIGNATION where site_id="+strSiteNameId+" AND APPLICATION_ID=1 AND STATUS_ID = 10 ORDER BY DESIG_NAME";

  rs     =   dbConBean.executeQuery(strSql);  
%>


  <td class="formtr1"><FONT SIZE="" COLOR="#FF3300">* </FONT><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%></td>  <!--  Designation  -->
  <td class="formtr1">
    <select name="designation"  class="textBoxCss">
      <option value="-1" selected><%=dbLabelBean.getLabel("label.global.selectyourdesignation",strsesLanguage)%></option>
<%
	  while(rs.next())
	  {
%>
	     <option value="<%=rs.getString("Desig_Id")%>"><%=rs.getString("Desig_Name")%></option>
<%
	  }
      rs.close();	  
%>
    </select>
	<script language="javascript">
      document.frm.designation.value="<%=strDesigNameId%>";
	</script>  </td>
  </tr>
  <tr>
<!-- 2/28/2007 by shiv -->
<td class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.mylinks.employeecode",strsesLanguage)%></td>
<td width="328" class="formtr1">
	<input type="text" name="empcode" size="15" maxlength="30" class="textBoxCss" onKeyUp="return test1('empcode', 30, 'cn')" value="<%=EMP_CODE%>"
	<% if("Y".equalsIgnoreCase(strSAPUserSyncFlag)) {%>
		readonly="readonly" onfocus="javascript:sapUserSyncAlert();blur();"
	<% } %>
	/>
</td>

<!-- @ Vijay Singh changes on 20/04/2007 for Adding the gender-->

<td  class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%> </td>
	 
	  <td class="formtr1">
			<select name="gender" class="textBoxCss">
				<option value="-1"><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%></option>
				<option value="Male"><%=dbLabelBean.getLabel("label.global.male",strsesLanguage)%></option>
				<option value="Female"><%=dbLabelBean.getLabel("label.global.female",strsesLanguage)%></option>
			</select>
	</td>
   <!--End Modification-->


</tr>

  <tr>
<!--10/18/2007 by shiv  open-->
<td class="formtr1"><font size="" color="#FF3300"></font>&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.proofofidentity",strsesLanguage)%></td>
<td width="328" class="formtr1">
		<select name="identityProof" class="textBoxCss">
							<%	
								strSql = "SELECT IDENTITY_ID, IDENTITY_NAME FROM m_IDENTITY_PROOF WHERE STATUS_ID=10 ";
									rs = dbConBean.executeQuery(strSql); 
							%>
									  <option value="-1"> <%=dbLabelBean.getLabel("label.createrequest.proofofidentity",strsesLanguage)%></option>
							<%
									while(rs.next()) 
									{ 
							%>
									  <option value = <%=rs.getString("IDENTITY_ID")%> > <%= rs.getString("IDENTITY_NAME") %></option>
							<%
									}
									rs.close();
							%>
        </select></td>

		     <script language="javascript">
						  if('<%=strIdentityproof%>' == '')
						  {  
								document.frm.identityProof.value="-1";
						  }
							  else	
								document.frm.identityProof.value="<%=strIdentityproof%>";
                          </script>
			 

 
 <td class="formtr1">&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.identityproofnumber",strsesLanguage)%> <font size="" color="#FF3300"></font> </td>
		  <td class="formtr1">
				<input type='text' name='identityproofno' onKeyUp="return test1('identityproofno', 30, 'all')" value="<%=strIdentityproofNo%>"  class="textBoxCss" /></td>

		<script language="javascript">
	 					document.frm.identityproofno.value="<%=strIdentityproofNo%>";
	    </script>
       
			  
	 
   <!--End Modification-->
 

</tr>

<!-- added new on 2/2/2009 for update window user id and domian name  -->

  <tr>
 <!-- Added  new fields for windows user id,domian id  flag  on 05-02-2009 by shiv sharma   -->

<td class="formtr1"><font size="" color="#FF3300"></font>&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.mylinks.windowsuserid",strsesLanguage)%></td><td width="328" class="formtr1">
	<input type='text' name='winUserID' value="<%=strWinUserID%>"  class="textBoxCss" onKeyUp="return test1('winUserID', 50, 'All')" /></td> 

		<script language="javascript">
	 					document.frm.winUserID.value="<%=strWinUserID%>"; 
	    </script>    

 
 <td class="formtr1">&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.mylinks.networkdomainname",strsesLanguage)%> <font size="" color="#FF3300"></font> </td>
		  <td class="formtr1">
				<input type='text' name='domainname' value="<%=strDomainName%>"  class="textBoxCss"  onKeyUp="return test1('domainname', 30, 'All')"/></td>

		<script language="javascript">
	 					document.frm.domainname.value="<%=strDomainName%>";
	    </script>
    <!--End Modification-->
</tr>

 <tr>
 <!-- Added  new fields for user name on 19-02-2015  -->
<td class="formtr1">&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.mail.username",strsesLanguage)%></td>
<td width="328" class="formtr1">
	<input name="userName" type="text" class="textBoxCss" onKeyUp="return test1('userName', 50, 'an')" size="25" maxlength="50" value="<%=strUserName%>" readonly="readonly"/>
</td> 
 
 <input type="hidden" name="costcentre" value="0">
 <!--  added by manoj chand on 13 august to show workflow dropdown to local admin -->
 
<%  if(SuserRoleOther.trim().equals("LA") && !strSiteNameId.equalsIgnoreCase("-1")) { %>

<td class="formtr1"><font size="" color="#FF3300">* </font>&nbsp;<%=dbLabelBean.getLabel("label.administration.workflownumber",strsesLanguage) %></td>
<td class="formtr1">
<select class="textBoxCss" name="sp_role">
<option value="-1"><%=dbLabelBean.getLabel("label.administration.selectworkflow",strsesLanguage) %></option>
			<%
			rs=null;
			String strSProle="";
			strSql="select distinct sp_role from M_DEFAULT_APPROVERS where M_DEFAULT_APPROVERS.SITE_ID="+strSiteNameId+" and M_DEFAULT_APPROVERS.STATUS_ID=10";
			rs = dbConBean.executeQuery(strSql); 
			while(rs.next()){
			  strSProle=rs.getString(1);
				%>
				<option VALUE="<%=strSProle %>"><%=dbLabelBean.getLabel("label.user.workflow",strsesLanguage) %> <%=strSProle %></option>
				<%
			}
			rs.close();
			
		%>
		<script language="javascript">
						  document.frm.sp_role.value="<%=strSp_role%>";  
						</script>
			</select>&nbsp;&nbsp;<a  id="a_showworkflow" href="#" onClick="MM_openBrWindow1('M_dispWorkflow.jsp?siteid=<%=strSiteNameId%>','dispWorkflow')"><%=dbLabelBean.getLabel("label.administration.seeworkflow",strsesLanguage) %></a>
</td>
<%	} else { %>
	<td class="formtr1" colspan="2"></td>
<%	} %>
</tr>

<!-- End Here -->
<!-- -->

<!--10/18/2007 by shiv close-->


			<tr align="center">
			<td colspan="4" align="left" style="font-size: 13px;"><span class="dataLabel"><%=dbLabelBean.getLabel("label.mylinks.selectthepersonreportto",strsesLanguage)%>(<%=dbLabelBean.getLabel("label.global.approverlevel1",strsesLanguage)%>)</span></td>
			</tr>
			<tr align="center">
              <% // Changes the name of jsp on report to function by shiv sharma on 06-11-2008 %> 
			<% for(int i=0;i<=1;i++) {
				if((SuserRoleOther.trim().equals("LA")) || (SuserRole.trim().equals("AD"))) {
			%> 
						<td class="formtr1"><input type="radio" value=<%=strSiteNameId%> name="reportto" onClick="report_to('report_to_container.jsp?lang=<%=strsesLanguage %>','<%=i%>');"><%=arrayRadio[i]%></td>
			<% 	} else { 
			%> 
				<td class="formtr1"><input type="radio" value=<%=strSiteNameId%> name="reportto"><%=arrayRadio[i]%></td>
			<%	}
			} 
			%>
			<td class="formtr1"><input type="text" name="report" size="20" value="<%=strReportPersonName%>" readonly class="textBoxCss" >
			<td class="formtr1">			</tr>
			
			<!-- Section to Select HOD is added on 17/8/2015 by Sandeep Malik -->
		    <tr align="center">
		      <td colspan="4" align="left" style="font-size: 13px;"><span class="dataLabel"><%=dbLabelBean.getLabel("label.mylinks.selectthepersondepthead",strsesLanguage)%>(<%=dbLabelBean.getLabel("label.global.approverlevel2",strsesLanguage)%>)</span></td>
		    </tr>
		    <tr align="center">
		       <%//Changes the name of jsp on report to function by shiv sharma on 06-11-2008 %>
		      <% for(int i=0;i<=1;i++) { 
		    	  if((SuserRoleOther.trim().equals("LA")) || (SuserRole.trim().equals("AD"))) { 
		       %>
		      		<td class="formtr1"><input type="radio" value=<%=strSiteNameId%> name="deptHeadId" onClick="dept_Head('report_to_container.jsp?lang=<%=strsesLanguage %>','<%=i%>');"><%=arrayRadio[i]%></td>
		      <% } else { 
		      %> 
		      		<td class="formtr1"><input type="radio" value=<%=strSiteNameId%> name="deptHeadId"><%=arrayRadio[i]%></td>
		      <% } 
		    	} 
		       %>
		      <td class="formtr1"><input name="deptHead" type="text" class="textBoxCss" value="<%=strDeptHeadPersonName%>" size="34" maxlength="25" readonly >
		    <td class="formtr1">    </tr>
    		<!-- Section to Select HOD is Ended -->
			
  <tr align="center">
    <td colspan="4" align="left" class="dataLabel"><%=dbLabelBean.getLabel("label.mylinks.ifyouforgetyourpassword",strsesLanguage)%></td>
  </tr>
  <tr align="center">
    <td class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.mylinks.secretquestion",strsesLanguage)%></td>  <!--  SECRET QUESTION  -->
	<!--@ Vijay Singh add the option for secret question -->
      <td class="formtr1">
			<select name="quest_secret1" class="textBoxCss" onChange="questOther();">
				<option value="-1"><%=dbLabelBean.getLabel("label.mylinks.selectyourquestion",strsesLanguage)%></option>
				<option value="Your college Name"><%=dbLabelBean.getLabel("label.mylinks.collegename",strsesLanguage)%></option>
				<option value="Your Mothers Maiden Name"><%=dbLabelBean.getLabel("label.mylinks.mothersmaidenname",strsesLanguage)%></option>
				<option value="Your Native Place"><%=dbLabelBean.getLabel("label.mylinks.nativeplace",strsesLanguage)%></option>
				<option value="Your Pet Name"><%=dbLabelBean.getLabel("label.mylinks.petname",strsesLanguage)%></option>
				<option value="Others"><%=dbLabelBean.getLabel("label.mylinks.others",strsesLanguage)%></option>
			</select>
	</td>
	   <!--@ END MODIFICATION-->
  <td class="formtr1" colspan="2">
  <input type="text" name="secretQuestion" size="30" onKeyUp="return test1('secretQuestion', 100, 'all')" maxlength="100" class="textBoxCss" value="" /></td>
</tr>
<tr>
  <td class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.mylinks.secretanswer",strsesLanguage)%> </td>  <!--  SECRET ANSWER  -->
  <td class="formtr1"><input type="password" name="secretAnswer" size="20" onKeyUp="return test1('secretAnswer', 16, 'pwd')" maxlength="15" class="textBoxCss" value="<%=SECRET_ANSWER%>"/><span></td>
  <td class="formtr1"></td>
  <td class="formtr1"></td>
</tr>
  <tr align="center">
    <td colspan="4" align="left" class="formtr1"><span style="font-family:Arial; font-size:8.5pt; color:black; "><%=dbLabelBean.getLabel("label.mylinks.providecomplexanswer",strsesLanguage)%></span></td>
  </tr>
  <tr align="center">
    <td colspan="4" align="left" class="dataLabel"><%=dbLabelBean.getLabel("label.mylinks.updatepassportdetails",strsesLanguage)%></td>
  </tr>
  
  <tr align="center">
    <td width="116" class="formtr1"><%=dbLabelBean.getLabel("label.createrequest.passportnumber",strsesLanguage)%></td>  <!--  PASSPORT NO  -->
  	<td width="220" class="formtr1">
  		<input type="text" name="passportNo" size="25" onKeyUp="return test1('passportNo', 49, 'all')" maxlength="49" class="textBoxCss" value="<%=PASSPORT_NO%>"/><br>
  		<a id="uploadpassport" title="" href="javascript:MM_openBrWindow('M_UploadPassport.jsp?userid=<%=strUserId %>','UploadPassport');"><%=dbLabelBean.getLabel("label.updateprofile.attachpassport",strsesLanguage)%></a>&nbsp;&nbsp;&nbsp;&nbsp;<a id="viewpassport" style="visibility: hidden;" title="" href="javascript:downloadVisaWindow('./DownloadPassportFile?userid=<%=strUserId %>');"><%=dbLabelBean.getLabel("label.updateprofile.viewpassport",strsesLanguage)%></a>
  	</td>
  	<td width="120" class="formtr1"><%=dbLabelBean.getLabel("label.user.nationality",strsesLanguage)%></td>  <!--  PASSPORT NO  -->
    <td width="328" class="formtr1">
  		<input type="text" name="nationality" size="25" onKeyUp="return test1('nationality', 50, 'all')" maxlength="50" class="textBoxCss" value="<%=nationality == null ? "" : nationality%>"/><br>
  	</td>
  </tr>
  
  <tr align="left">
	  <td class="formtr1"><%=dbLabelBean.getLabel("label.visa.passportissuingcountry",strsesLanguage)%></td>
	  <td class="formtr1">
	  	<select name="pp_issu_Country" id="pp_issu_Country" class="textBoxCss" style="width: 174px;">
	  		<option value="0"><%=dbLabelBean.getLabel("label.createrequest.visacountry",strsesLanguage)%></option>
	<%		rs = dbConBean.executeQuery("SELECT COUNTRY_ID, COUNTRY_CODE, COUNTRY_NAME FROM M_COUNTRY WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY COUNTRY_NAME");  
		    while(rs.next()) {
	%>		<option value="<%=rs.getString("COUNTRY_ID")%>"><%=rs.getString("COUNTRY_NAME")%></option>
	<% 		}
    		rs.close();	
	%>  </select>
		<script language="javascript">
      		document.frm.pp_issu_Country.value="<%=passportIssuCountry%>";
		</script>
	  </td>
	  <td class="formtr1"><%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%> </td>  <!--  PLACE OF ISSUE  -->
	  <td class="formtr1"><input type="text" name="placeOfIssue" size="25" onKeyUp="return test1('placeOfIssue', 99, 'c')"  maxlength="99" class="textBoxCss" value="<%=PLACE_ISSUE%>"/></td>
  </tr>
  <tr align="left">
 	<td class="formtr1"><%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%> <%=dbLabelBean.getLabel("label.mylinks.ddmmyyyy",strsesLanguage)%></td>  <!--  DATE OF ISSUE  -->
	<td class="formtr1"><input type="text" name="dateOfIssue" size="10" maxlength="10" class="textBoxCss" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  value="<%=DATE_ISSUE %>" onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" />			 
      <a href="javascript:show_calendar('frm.dateOfIssue','a','a','DD/MM/YYYY');" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;">
      <IMG  border="0" height=14 alt="<%=dbLabelBean.getLabel("label.register.calender",strsesLanguage)%>" src="images/calender.png?buildstamp=2_0_0"   width=17></a>
   </td>
   <td class="formtr1" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.expirydate",strsesLanguage)%> <%=dbLabelBean.getLabel("label.mylinks.ddmmyyyy",strsesLanguage)%></td>
   <td class="formtr1"><input type="text" name="expireDate" size="10" maxlength="10" class="textBoxCss"  onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  value="<%=EXPIRY_DATE %>" onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"/>
     <a href="javascript:show_calendar('frm.expireDate','a','a','DD/MM/YYYY');" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;">
	 <img  border="0" height=14 alt="<%=dbLabelBean.getLabel("label.register.calender",strsesLanguage)%>" src="images/calender.png?buildstamp=2_0_0"   width=17 />
	</a>
   </td>
 </tr>
 	
 <tr align="left">
	<td valign="top" class="formtr1" width="12%" ><%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.mylinks.ddmmyyyy",strsesLanguage)%></td>  <!--  DOB  -->
	<td valign="top" class="formtr1"><input type="text" name="dateOfBirth"  size="10" maxlength="10" class="textBoxCss"  onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  value="<%=DOB %>" onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"/>
	     <a href="javascript:show_calendar('frm.dateOfBirth','a','a','DD/MM/YYYY');" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;">
	     <img border="0"  height=14 alt="<%=dbLabelBean.getLabel("label.register.calender",strsesLanguage)%>" src="images/calender.png?buildstamp=2_0_0"   width=17 />
	    </a>  
	</td>
  	<td class="formtr1"> <%=dbLabelBean.getLabel("label.global.contactno",strsesLanguage)%> </td>  <!--  CONTACT NO.  -->
  	<td class="formtr1"><input type="text" name="contactNo" size="18" onKeyUp="return test1('contactNo', 19, 'phone')" maxlength="20" class="textBoxCss" value="<%=CONTACT_NUMBER%>"/></td>
 </tr>
  
 <tr align="left">
 	<td class="formtr1"><%=dbLabelBean.getLabel("label.global.emigrationclearancerequired",strsesLanguage)%></td>  <!--  ECR  -->
    <td class="formtr1" colspan="3">
      <input name="ecnr" type="radio" value="1" /><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%> 
      <input name="ecnr" type="radio" checked = "checked"  value="2"/><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
      <input name="ecnr" type="radio"  value="3"/><%=dbLabelBean.getLabel("label.global.na",strsesLanguage)%>
      
      <script language="javascript">
		document.frm.ecnr.value ="<%=ECNR%>";
		if (document.frm.ecnr.value == 1) 
		{
			document.frm.ecnr[0].checked = true;
		}
		else if (document.frm.ecnr.value == 2) 
		{
			document.frm.ecnr[1].checked = true;		
		}
		else if (document.frm.ecnr.value == 3) 
		{
			document.frm.ecnr[2].checked = true;		
		}
	</script>
	</td>
 </tr>
  
<tr align="left">
	<td class="formtr1"><%=dbLabelBean.getLabel("label.createrequest.frequentflyerdetails",strsesLanguage)%></td>
	<td class="formtr1">
		<table width="258" border="0" cellpadding="0" cellspacing="0">
			<tr>
	          	<td align="left" valign="bottom" class="formtr1"><span class="label2">&nbsp;<%=dbLabelBean.getLabel("label.createrequest.airlinenames",strsesLanguage)%></span></td>
	          	<td align="left" valign="bottom" class="formtr1"><span class="label2">&nbsp;<%=dbLabelBean.getLabel("label.createrequest.airlinenumber",strsesLanguage)%></span></td>
	        </tr>
	        <tr>
	  		  	<td width="128" align="center" class="formtr1"><input name="airLineName" type="text" value="<%=strAirLineName%>" class="textBoxCss" size="15" onKeyUp="return test1('airLineName', 20, 'cn')"/></td>
	          	<td width="130" align="center" class="formtr1"><input name="ffNo" type="text"   class="textBoxCss" size="20" onKeyUp="return test1('ffNo', 20, 'cn')"/>
	          		<script language="javascript">
						document.frm.ffNo.value ="<%= FF_NUMBER.trim() %>";
					</script>
	          	</td>
			</tr>
			<tr>
	  		  	<td align="center" class="formtr1"><input name="airLineName1" type="text" value="<%=strAirLineName1%>" class="textBoxCss" size="15" onKeyUp="return test1('airLineName1', 20, 'cn')"/></td>
	          	<td align="center" class="formtr1"><input name="ffNo1" type="text"  class="textBoxCss" size="20" onKeyUp="return test1('ffNo1', 20, 'cn')"/>
					  <script language="javascript">
							document.frm.ffNo1.value ="<%= FF_NUMBER1.trim() %>";
					  </script>
	          	</td>
			</tr>
			<tr>
	  		  	<td align="center" class="formtr1"><input name="airLineName2" type="text" value="<%=strAirLineName2%>" class="textBoxCss" size="15" onKeyUp="return test1('airLineName2', 20, 'cn')"/></td>
	          	<td align="center" class="formtr1"><input name="ffNo2" type="text"  class="textBoxCss" size="20" onKeyUp="return test1('ffNo2', 20, 'cn')"/>
        			<script language="javascript">
						document.frm.ffNo2.value ="<%= FF_NUMBER2.trim() %>";
					</script>
	          	</td>
			</tr>
			<tr>
	  		  	<td align="center" class="formtr1"><input name="airLineName3" type="text" value="<%=strAirLineName3%>" class="textBoxCss" size="15" onKeyUp="return test1('airLineName3', 20, 'cn')"/></td>
	          	<td align="center" class="formtr1"><input name="ffNo3" type="text"  class="textBoxCss" size="20" onKeyUp="return test1('ffNo3', 20, 'cn')"/>
		  			<script language="javascript">
						document.frm.ffNo3.value ="<%= FF_NUMBER3.trim() %>";
					</script>
	          	</td>
			</tr>
			<tr>
	  		  	<td align="center" class="formtr1"><input name="airLineName4" type="text" value="<%=strAirLineName4%>" class="textBoxCss" size="15" onKeyUp="return test1('airLineName4', 20, 'cn')"/></td>
	          	<td align="center" class="formtr1"><input name="ffNo4" type="text"  class="textBoxCss" size="20" onKeyUp="return test1('ffNo4', 20, 'cn')"/></span>
		  			<script language="javascript">
						document.frm.ffNo4.value ="<%= FF_NUMBER4.trim() %>";
					</script>
	          	</td>
			</tr>
		</table>
	</td>
	
	<td class="formtr1"><%=dbLabelBean.getLabel("label.global.hotelrewardcard",strsesLanguage)%></td>
      
     <td class="formtr1">
     	<table width="258" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          	<td align="left" valign="bottom" class="formtr1"><span class="label2">&nbsp;<%=dbLabelBean.getLabel("label.global.hotelchain",strsesLanguage)%></span></td>
	          	<td align="left" valign="bottom" class="formtr1"><span class="label2">&nbsp;<%=dbLabelBean.getLabel("label.requestdetails.number",strsesLanguage)%></span></td>
	        </tr>
	        <tr>
	          	<td width="128" align="center" class="formtr1"><input name="hotelChain" type="text" value="<%=hotelChain%>" class="textBoxCss" size="15" onKeyUp="return test1('hotelChain', 20, 'cn')"/></td>
	          	<td width="130" align="center" class="formtr1"><input name="hotelNumber" type="text" value="<%=hotelNumber%>" class="textBoxCss" size="20" onKeyUp="return test1('hotelNumber', 20, 'cn')"/>
					<script language="javascript">
					document.frm.hotelNumber.value ="<%= hotelNumber.trim() %>";
					</script>
				</td>
			</tr>	        
			<tr>
	          	<td align="center" class="formtr1"><input name="hotelChain1" type="text" value="<%=hotelChain1%>" class="textBoxCss" size="15" onKeyUp="return test1('hotelChain1', 20, 'cn')"/></td>
	          	<td align="center" class="formtr1"><input name="hotelNumber1" type="text" value="<%=hotelNumber1%>" class="textBoxCss" size="20" onKeyUp="return test1('hotelNumber1', 20, 'cn')"/>
					<script language="javascript">
						document.frm.hotelNumber1.value ="<%= hotelNumber1.trim() %>";
					</script>
				</td>
			</tr>
			<tr>
	          	<td align="center" class="formtr1"><input name="hotelChain2" type="text" value="<%=hotelChain2%>" class="textBoxCss" size="15" onKeyUp="return test1('hotelChain2', 20, 'cn')"/></td>
	          	<td align="center" class="formtr1"><input name="hotelNumber2" type="text" value="<%=hotelNumber2%>" class="textBoxCss" size="20" onKeyUp="return test1('hotelNumber2', 20, 'cn')"/>
					<script language="javascript">
						document.frm.hotelNumber2.value ="<%= hotelNumber2.trim() %>";
					</script>
				</td>
			</tr>
			<tr>
	          	<td align="center" class="formtr1"><input name="hotelChain3" type="text" value="<%=hotelChain3%>" class="textBoxCss" size="15" onKeyUp="return test1('hotelChain3', 20, 'cn')"/></td>
	          	<td align="center" class="formtr1"><input name="hotelNumber3" type="text" value="<%=hotelNumber3%>" class="textBoxCss" size="20" onKeyUp="return test1('hotelNumber3', 20, 'cn')"/>
					<script language="javascript">
						document.frm.hotelNumber3.value ="<%= hotelNumber3.trim() %>";
					</script>
				</td>
			</tr>
			<tr>
	          	<td align="center" class="formtr1"><input name="hotelChain4" type="text" value="<%=hotelChain4%>" class="textBoxCss" size="15" onKeyUp="return test1('hotelChain4', 20, 'cn')"/></td>
	          	<td align="center" class="formtr1"><input name="hotelNumber4" type="text" value="<%=hotelNumber4%>" class="textBoxCss" size="20" onKeyUp="return test1('hotelNumber4', 20, 'cn')"/>
					<script language="javascript">
						document.frm.hotelNumber4.value ="<%= hotelNumber4.trim() %>";
					</script>
				</td>
			</tr>
      	</table>
      </td>
</tr>	
 
<%    
	if(!strTravelAgencyCode.equals("2")) {
%> 
	 <tr align="left">
	    <td valign="top" class="formtr1"><%=dbLabelBean.getLabel("label.createrequest.permanentaddress",strsesLanguage)%></td>
	    <td valign="middle" class="formtr1"><textarea name="address" rows="5" cols="30" onKeyUp="return test1('address', 149, 'all')" id="address"><%=ADDRESS.trim()%></textarea></td>
		<td valign="top" class="formtr1"><%=dbLabelBean.getLabel("label.createrequest.currentaddress",strsesLanguage)%> </td>  
		<td valign="middle" class="formtr1"><textarea name="current_address" rows="5" cols="30" onKeyUp="return test1('current_address', 149, 'all')" id="textarea"><%=strCurrentAddress.trim()%></textarea></td>
	 </tr>
<% } %>    
  	
  <tr align="center"> 
    <td colspan="4" class="formtr1" style="font-size: 14px;text-align: center;">
      <input type="submit" name="Submit" value="<%=dbLabelBean.getLabel("label.suggestions.update",strsesLanguage)%>" class="formButton" onClick="return checkData(this.form)" >  <!--SUBMIT BUTTON-->
    <!--<input type="reset" name="reset" value="Reset" class="formButton">-->
       
        <input type="hidden" name="status_id" value="10" >                  <!--  HIDDEN FIELD  -->
		<input type="hidden" name="repTo" value=<%=REPORT_TO%>>             <!--  HIDDEN FIELD  -->
		<input type="hidden" name="repToUserId" value="s1">                 <!--  HIDDEN FIELD  -->
		<input type="hidden" name="deptHeadUserId" value=<%=strdeptHead%>>      <!--  HIDDEN FIELD  -->
		<input type="hidden" name="todayDate" value="<%=strCurrentDate%>"/> <!--  HIDDEN FIELD  -->
		<input type="hidden" name="userId" value="<%=strUserId%>"/>         <!--  HIDDEN FIELD  -->
		<input type="hidden" name="Deactiveflag" value="<%=strDeactiveflag%>"/>         <!--  HIDDEN FIELD  --><!-- added by shiv on 23-May-07 -->
		<input type="hidden" name="question_other" value="" >				<!-- Add by Vijay on 11/04/2007  for other secret question-->
	</td>
  </tr>
  
  	<tr align="center">
    	<td colspan="4" align="left" class="dataLabel"><%=dbLabelBean.getLabel("label.visa.visadetails",strsesLanguage)%>!</td>
  	</tr>
	
	<tr align="center" >
		<td colspan="4">
			<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
				<thead>
					<tr  class="formtr2" style="background-color: #dfdfdf;">
						<th width="5%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></th>
						<th width="20%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.user.country",strsesLanguage)%></th>
						<th width="15%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.personnelbooking.visaissuancedate",strsesLanguage)%></th>
						<th width="15%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.visa.validfrom",strsesLanguage)%></th>
						<th width="15%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.visa.validto",strsesLanguage)%></th>
						<th width="15%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.visa.stayduration",strsesLanguage)%></th>
						<th width="15%" nowrap="nowrap"><%=dbLabelBean.getLabel("link.createeditlist.edit",strsesLanguage)%> | <%=dbLabelBean.getLabel("label.global.download",strsesLanguage)%></th>
					</tr>
				</thead>
				<tbody>
		<%	int sNum = 0 ;
			boolean visaExist = false;
			ResultSet rSet = null;
			String countryCode, visaCountry, visaIssuDate, visaValidFrom, visaValidTo, stayDuration, visaFilename ;
			rSet = dbConBean.executeQuery("SELECT USER_VISA_ID, isnull((select COUNTRY_NAME from M_COUNTRY where COUNTRY_ID=M_USERVISA.VISA_COUNTRY),'-') AS COUNTRY_NAME, M_USERVISA.VISA_COUNTRY, dbo.CONVERTDATEDMY1(VISA_ISSUANCE_DATE) AS VISA_ISSUANCE_DATE, dbo.CONVERTDATEDMY1(VISA_VALID_FROM) AS VISA_VALID_FROM, dbo.CONVERTDATEDMY1(VISA_VALID_TO) AS VISA_VALID_TO, isnull(VISA_STAY_DURATION,'0 Days') AS VISA_STAY_DURATION, VISA_FILENAME FROM M_USERVISA WHERE CONVERT(DATE,VISA_VALID_TO)>= CONVERT(DATE,DATEADD(DD,0,GETDATE())) AND USERID= "+strUserId); 
			while(rSet.next()) {
				
				visaExist = true;
				countryCode		= rSet.getString("VISA_COUNTRY") == null ? "0" : rSet.getString("VISA_COUNTRY").trim();
				visaCountry		= rSet.getString("COUNTRY_NAME") == null ? "-" : rSet.getString("COUNTRY_NAME").trim();
				visaIssuDate	= rSet.getString("VISA_ISSUANCE_DATE") == null ? "-" : rSet.getString("VISA_ISSUANCE_DATE").trim();
				visaValidFrom	= rSet.getString("VISA_VALID_FROM") == null ? "-" : rSet.getString("VISA_VALID_FROM").trim();
				visaValidTo		= rSet.getString("VISA_VALID_TO") == null ? "-" : rSet.getString("VISA_VALID_TO").trim();
				stayDuration	= rSet.getString("VISA_STAY_DURATION") == null ? "0 Day(s)" : rSet.getString("VISA_STAY_DURATION").trim();
				visaFilename	= rSet.getString("VISA_FILENAME") == null ? "-" : rSet.getString("VISA_FILENAME").trim();
		%>			<tr>
						<td width="5%"  class="formtr1"><b><%=++sNum %></b></td>
						<td width="20%" class="formtr1" nowrap="nowrap"><%=visaCountry %></td>
						<td width="15%" class="formtr1"><%=visaIssuDate %></td>
						<td width="15%" class="formtr1"><%=visaValidFrom %></td>
						<td width="15%" class="formtr1"><%=visaValidTo %></td>
						<td width="15%" class="formtr1"><%=stayDuration %></td>
						<td width="15%" class="formtr1">
							<a  id="editVisaInfo" href="javascript:openVisaUploadWindow('M_UploadVISA.jsp?userid=<%=strUserId%>&userVisaId=<%=rSet.getString("USER_VISA_ID").trim() %>','UploadVISA');"><%=dbLabelBean.getLabel("link.createeditlist.edit",strsesLanguage)%></a> | 
							<a  id="downloadVisa" href="javascript:downloadVisaWindow('./DownloadVISAFile?userid=<%=strUserId%>&visaCountry=<%=countryCode%>');"><%=dbLabelBean.getLabel("label.global.download",strsesLanguage)%></a>
						</td>
					</tr>
		<%	} rSet.close();
			if(!visaExist) {
		%>			<tr>
						<td colspan="7"  class="formtr1" style="color:red;font-family:arial,helvetica,sans-serif;font-size: 11px;font-weight: bold;text-align: center;"><%=dbLabelBean.getLabel("label.visa.novisauploadedyet",strsesLanguage)%></td>
					</tr>
		<%	} %>				
				</tbody>
			</table>
		</td>
	</tr>  
	
	<tr align="center">
	  	<td width="220" class="formtr1" colspan="4">
	  		<a id="uploadVisa" title="" href="javascript:openVisaUploadWindow('M_UploadVISA.jsp?userid=<%=strUserId%>','UploadVISA');"><%=dbLabelBean.getLabel("label.visa.attachvisa",strsesLanguage)%></a>
	  	</td>
  	</tr>

</table>
</form>
  <%if(FileBytes!=null){ %>
	  <script>
	  showpassportlink();
	  </script>	  
 <%} %> 
<!-- End of Form -->
</body>
</html>
<%
   dbConBean.close();  // CLOSE ALL CONNECTION
%>

