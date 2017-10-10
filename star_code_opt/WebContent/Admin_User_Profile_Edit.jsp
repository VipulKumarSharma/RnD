		
	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:Shiv Sharma
	 *Date of Creation 		:18 April  2007
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:This is t jsp file  for updating the M_USERINFO in the STAR Database
	 *Modification 			: epmcode char & numeric 
							: On Deactivated user List fields are not shown beacuse of  an extra check in the SQL Query consisting of status_id=10
							  This change will remove the check of status_id by Gaurav Aggarwal on 23-May-2007	
						    : Added  new fields for windows user id,domian id & sso flage on 05-02-2009 by shiv sharma    	  
						    : Extends field length for windows user id 05-10-2009 by shiv sharma 
						    : code change for allowing multiple Local admin for one unit on 16 march 2010 by shiv sharma 
	 *Reason of Modification: Bug Fixing
	 *Date of Modification  : 19/03/2007, 3/20/2007, 15-May-2007 by Shiv Sharma
	 *Revision History		:Last name is not mendatory 
	 *Editor				:Editplus
	 		 :Modified by vaibhav on Aug 20 2010 to give billing approver rights

	 *Modified By		: Manoj Chand
	 *Date of Modification: 28 Mar 2012
	 *Modification		:add Board Member Dropdown for SMP
	 
	 *Modified By					:Manoj Chand
	 *Date of Modification			:03 July 2011
	 *Modification					:change query to remove closed unit from unit dropdown
	 
	 *Modified By					:Manoj Chand
	 *Date of Modification			:14 August 2012
	 *Modification					:showing workflow dropdown for STARS ADMIN and link to show existing workflow
	 
	 *Modified By					:Manoj Chand
	 *Date of Modification			:23 Jan 2013
	 *Modification					:display alert to STARS Admin or Local Admin when user workflow number updated and user some requests are pending for approval.
	 
	 *Modified By					:Manoj Chand
	 *Date of Modification			:03 June 2013
	 *Modification					:Provision to give access of a site to user for approval level 1 and 2.
	 
	 *Modified By					:Manoj Chand
	 *Date of Modification			:22 Oct 2013
	 *Modification					:javascript validation to stop from typing --,'  symbol is added.
	 *******************************************************/
	%>
	<%-- Import Statements  --%>
	<%@ page pageEncoding="UTF-8" %>
	<%@page import="java.net.URLDecoder"%>
	<%@ include  file="importStatement.jsp" %>
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
	<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
	<SCRIPT language="JavaScript" src="LocalScript/M_UpdateProfile.js?buildstamp=2_0_0"></SCRIPT>
	 <link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" /><BASE>
	 <script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
	<%
	// Global Variables declared and initialized
	String strSql                   =  null;              // String for Sql String
	ResultSet rs,rs2,rs_BA,rs_BM    =  null;              // Object for ResultSet
	ResultSet rs1            =  null;
	String FIRSTNAME                =  "";
	String LASTNAME                 =  "";
	Statement stmt						=null;
	Connection con						=null;
	String  sSqlStr=							null;
	String strSiteId							="";
	String strSiteName					="";
	String    s_desgnm	="";
	String   s_desgid="";
	String s_levelnm="";
	String  strRoleid	="";
	String strDisableButton="";
	String s_deptname			="";
	 String strdept_ID	="";		  
	 String strUnit_head	="";
	 String updateProfile="";
	
	String strPrimarySite			="";
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
	String DATE_ISSUE               =  "";
	String ECNR                     =  "";
	String EXPIRY_DATE              =  "";
	String FF_NUMBER                =  "";
	String FF_NUMBER1                =  "";
	String FF_NUMBER2                =  "";
	String strSendingSMSFlag		=	"N";		//Added by Sachin for SMS Sending Checkbox on 20th Nov 2008
	
	
	//new 16-02-2007
	String strCurrentAddress	=	"";
	String strAirLineName		=	"";
	String strAirLineName1		=	"";
	String strAirLineName2		=	"";
	
	//
	
	String PLACE_ISSUE              =  "";
	String DOB                      =  "";
	String ADDRESS                  =  "";
	String CONTACT_NUMBER           =  "";
	String strMessage               =  "";
	String[] arrayRadio 			= {dbLabelBean.getLabel("label.mylinks.unitid",strsesLanguage),dbLabelBean.getLabel("label.mylinks.acrosstheunit",strsesLanguage)};
	
	String strWinUserID             =""; 
	String strDomainName			="";
	String strSsoflag 				="";
	
	String strSp_role				="";
	String strUserName  			="";
	String strUserNameOld  			="";
	
	String strEmailIDAccess         = "readOnly"; 
	String strMiddleName			="";
	String strRelievingDate         ="";
	String strTravelAgencyCode		=  "1";
	String strSAPUserSyncFlag		= "N";
	
	if((SuserRoleOther.trim().equals("LA")) || (SuserRole.trim().equals("AD")))
	{
		strEmailIDAccess  =  "";
	}
//System.out.println("messg--->"+request.getParameter("strMessage"));
	strMessage  				=  URLDecoder.decode((request.getParameter("strMessage")==null || request.getParameter("strMessage")=="") ? dbLabelBean.getLabel("submenu.mylinks.updateprofile",strsesLanguage) : request.getParameter("strMessage"), "UTF-8"); 
	String  strDivNameId		=  (request.getParameter("division")==null || request.getParameter("division")=="")?"-1":request.getParameter("division");
	String	strSiteNameId		=  (request.getParameter("site")==null || request.getParameter("site")=="")?"-1":request.getParameter("site");
	String	strDeptNameId		=  (request.getParameter("department")==null || request.getParameter("department")=="")?"-1":request.getParameter("department");
	String	strDesigNameId		=  (request.getParameter("designation")==null || request.getParameter("designation")=="")?"-1":request.getParameter("designation");
	String	strRoleID			=  (request.getParameter("roleid")==null || request.getParameter("roleid")=="")?"-1":request.getParameter("roleid");
	String  changeCombo         =  (request.getParameter("changeCombo")==null || request.getParameter("changeCombo")=="")?"no":request.getParameter("changeCombo");
	String 	strUserId           =  request.getParameter("userId");  // get the user id if admin update the profile 
	strUserName					=  URLDecoder.decode((request.getParameter("userName")==null ? "":request.getParameter("userName")), "UTF-8"); 
	String strUserDivName="";
	
	//System.out.println("strMessage--->"+ strMessage);
	if(strUserId == null)
	{
	   strUserId = Suser_id;    // Suser_id is login person userid
	}
	    
	//strSql="select LTRIM(RTRIM(dbo.DIVNAME_FROM_USERID("+strUserId+")))";
	strSql="SELECT SHOW_APP_LVL_3 FROM M_DIVISION MD INNER JOIN	M_USERINFO MU ON MU.DIV_ID=MD.DIV_ID WHERE USERID="+strUserId;
	rs = dbConBean.executeQuery(strSql);
	if(rs.next())
	{
		strUserDivName = rs.getString("SHOW_APP_LVL_3");
	}
	//System.out.println("strDivName--->"+strUserDivName);
	//System.out.println("SuserRole--->"+SuserRole);
	rs.close();
	rs=null;
	
	
	  // sql for getting the information for display from M_UserInfo Table
	  // strSql="SELECT FIRSTNAME,LASTNAME,PIN,LTRIM(RTRIM(EMAIL)) AS EMAIL,SITE_ID,DIV_ID,DEPT_ID,DESIG_ID,ISNULL(REPORT_TO,'') AS REPORT_TO,ISNULL(SECRET_QUESTION,'') AS SECRET_QUESTION,ISNULL(SECRET_ANSWER,'') AS SECRET_ANSWER,ISNULL(PASSPORT_NO,'') AS PASSPORT_NO,ISNULL(.DBO.CONVERTDATEDMY1(DATE_ISSUE),'') AS DATE_ISSUE,ISNULL(ECNR,'') AS ECNR,ISNULL(.DBO.CONVERTDATEDMY1(EXPIRY_DATE),'') AS EXPIRY_DATE, ISNULL(FF_NUMBER,'') AS FF_NUMBER,ISNULL(FF_NUMBER1,'') AS FF_NUMBER1, ISNULL(FF_NUMBER2,'') AS FF_NUMBER2,ISNULL(PLACE_ISSUE,'') AS PLACE_ISSUE,ISNULL(.DBO.CONVERTDATEDMY1(DOB),'') AS DOB, ISNULL(ADDRESS,'') AS ADDRESS,ISNULL(CONTACT_NUMBER,''),                 ISNULL(CURRENT_ADDRESS,'') AS CURRENT_ADDRESS, ISNULL(FF_AIR_NAME,'') AS FF_AIR_NAME, ISNULL(FF_AIR_NAME1,'') AS FF_AIR_NAME1, ISNULL(FF_AIR_NAME2,'') AS FF_AIR_NAME2,EMP_CODE FROM M_USERINFO WHERE USERID='"+strUserId+"' and status_id=10 and application_id=1";                                          
	  // 2/28/2007
	  
	//System.out.println("1 strSql======="+strSql);
	// @Gaurav Aggarwal on 23-May-2007	
	//Query changed on 05-03-2009 for windows user id,domain name sso flage by shiv sharma    
		strSql="SELECT FIRSTNAME,LASTNAME,PIN,LTRIM(RTRIM(EMAIL)) AS EMAIL,SITE_ID,DIV_ID,DEPT_ID," +
		       " DESIG_ID,ISNULL(REPORT_TO,'') AS REPORT_TO,ISNULL(SECRET_QUESTION,'') AS SECRET_QUESTION, "+
		       " ISNULL(SECRET_ANSWER,'') AS SECRET_ANSWER,ISNULL(PASSPORT_NO,'') AS PASSPORT_NO,ISNULL(.DBO.CONVERTDATEDMY1(DATE_ISSUE),'') AS DATE_ISSUE, " +
		       " ISNULL(ECNR,'') AS ECNR,ISNULL(.DBO.CONVERTDATEDMY1(EXPIRY_DATE),'') AS EXPIRY_DATE, "+ 
		       " ISNULL(FF_NUMBER,'') AS FF_NUMBER,ISNULL(FF_NUMBER1,'') AS FF_NUMBER1, ISNULL(FF_NUMBER2,'') AS FF_NUMBER2," +
		       " ISNULL(PLACE_ISSUE,'') AS PLACE_ISSUE,ISNULL(.DBO.CONVERTDATEDMY1(DOB),'') AS DOB, "+
		      " ISNULL(ADDRESS,'') AS ADDRESS,ISNULL(CONTACT_NUMBER,'') AS CONTACT_NUMBER,"+
		       " ISNULL(CURRENT_ADDRESS,'') AS CURRENT_ADDRESS, ISNULL(FF_AIR_NAME,'') AS FF_AIR_NAME, "+
		       " ISNULL(FF_AIR_NAME1,'') AS FF_AIR_NAME1, ISNULL(FF_AIR_NAME2,'') AS FF_AIR_NAME2,"+
		       " EMP_CODE,LTRIM(RTRIM(SENDSMS_FLAG)) AS SENDSMS_FLAG,isnull(MIDDLENAME,'') as MIDDLENAME,SSO_ENABLE, "+
		       " WIN_USER_ID, DOMAIN_NAME,SP_role, USERNAME, ISNULL(.DBO.CONVERTDATEDMY1(DISABLEDTIME),'') AS DISABLEDTIME, ISNULL(COST_CENTER_ID,'0') AS COSTCENTRE FROM M_USERINFO WHERE USERID='"+strUserId+"' and application_id=1";                                          
	// End of change	
	
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
			SECRET_ANSWER    = rs.getString(11);
			PASSPORT_NO      = rs.getString(12);
			DATE_ISSUE       = rs.getString(13);
			ECNR             = rs.getString(14);
			EXPIRY_DATE      = rs.getString(15);
			FF_NUMBER        = rs.getString(16);
			FF_NUMBER1        = rs.getString(17);
			FF_NUMBER2       = rs.getString(18);
			PLACE_ISSUE      = rs.getString(19);
			DOB              = rs.getString(20);
			ADDRESS          = rs.getString(21);
			CONTACT_NUMBER   = rs.getString(22);				
	
	
			//NEW 16-02-2007 SACHIN
			strCurrentAddress	=	rs.getString("CURRENT_ADDRESS");
			strAirLineName		=	rs.getString("FF_AIR_NAME");
			strAirLineName1		=	rs.getString("FF_AIR_NAME1");
			strAirLineName2		=	rs.getString("FF_AIR_NAME2");
			 EMP_CODE           =   rs.getString("EMP_CODE");
			//
			strSendingSMSFlag	=	rs.getString("SENDSMS_FLAG");	//Added by Sachin for SMS Sending Checkbox on 20th Nov 2008
			strMiddleName	    =	rs.getString("MIDDLENAME");
			
			strSsoflag			=   rs.getString("SSO_ENABLE");   //added new on 2/3/2009 by shiv sharma 
			strWinUserID        =   rs.getString("WIN_USER_ID");  /// added new on 2/3/2009 by shiv sharma    
	        strDomainName		=	rs.getString("DOMAIN_NAME");   //added new on 2/3/2009 by shiv sharma 
	        strSp_role			=	rs.getString("SP_role");       //addeds new on 30 Oct 2009 by Shiv Sharma 
	        
	        if(strUserName == null || strUserName.equals("")) {
	        	strUserName 		=	rs.getString("USERNAME");
	        }
	         
	        strUserNameOld      =	rs.getString("USERNAME"); 			
	        strRelievingDate	=	rs.getString("DISABLEDTIME");
		}
		rs.close();  
		
		//System.out.println("strSiteNameId=============================="+strSiteNameId);	
	
	   //Get the name of Report_To Person
	   String strReportPersonName = "";                      //define the variable for getting the name of reporting person
	   //query for the getting the name for reporting person 
	 //  strSql = "select ISNULL(dbo.user_name(Report_to),'-') from M_userInfo where USERID='"+strUserId+"' and status_id=10 and application_id=1";
	 //@Gaurav Aggarwal on 23-May-2007	
	   strSql = "select ISNULL(dbo.user_name(Report_to),'-') from M_userInfo where USERID='"+strUserId+"' and application_id=1";
	 // End of change  
	   rs     = dbConBean.executeQuery(strSql);    //Get the resultset form the M_UserInfo
	   if(rs.next())
	   { 
	         strReportPersonName = rs.getString(1);
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
	
	<!--Java Script -->
	<script language=JavaScript>
		
		function sapUserSyncAlert() {
			alert('<%=dbLabelBean.getLabel("alert.sapusersync.cannotupdateuser",strsesLanguage)%>');
		}
	
		function forwardDelete(strUserId,strSiteId,strUnitHead)
				{
					if(confirm('<%=dbLabelBean.getLabel("alert.master.areyousurewanttodeletethisrecord",strsesLanguage)%>'))
					       {
							window.location.href="M_deleteUserRole.jsp?strUserId="+strUserId+"&strSiteId="+strSiteId+"&unithead="+strUnitHead;
	 				       }
					else
					     {
						    return false;
					    }
	         		 }
	
	      // added on 18 th april
	       function setValue()
	           {
		           document.frm.action="M_UpdateProfile.jsp?changeCombo=yes";
		           document.frm.designation.value="-1";
				   document.frm.department.value="-1";
				   document.frm.submit();
	           }
	      //
	
	  function checkdatanew(f1)
	      { 
			   if(f1.userSite.value == '-1' || f1.userSite.value == '')
					{
					   alert('<%=dbLabelBean.getLabel("alert.master.pleaseselecttheunit",strsesLanguage)%>');
					   f1.userSite.focus();
					   return false;  
					}
		 					
				<%--	if(f1.LocalAdmin.value == '-1' || f1.LocalAdmin.value == '')
					  {
						   alert('<%=dbLabelBean.getLabel("alert.master.pleaseselectthelocaladmin",strsesLanguage)%>');
						   f1.LocalAdmin.focus();
						   return false;  
					  }
	
					 if(f1.UnitHead.value == '-1' || f1.UnitHead.value == '')
							{
								   alert('<%=dbLabelBean.getLabel("alert.master.pleaseselecttheunithead",strsesLanguage)%>');
								   f1.UnitHead.focus();
								   return false;  
							 }
					 if(f1.billApprover.value == '-1' || f1.billApprover.value == '')
						{
							   alert('<%=dbLabelBean.getLabel("alert.master.pleaseselectthebillingapprover",strsesLanguage)%>');
							   f1.billApprover.focus();
							   return false;  
						 }
					 
					 if(f1.branchManager!=null || f1.branchManager!=undefined){
					 if(f1.branchManager.value == '-1' || f1.branchManager.value == '')
						{
							   alert('<%=dbLabelBean.getLabel("alert.global.boardmember",strsesLanguage)%>');
							   f1.branchManager.focus();
							   return false;  
						 }
					 } --%>

				if(f1.branchManager != undefined){
					if(f1.accountant.checked==false && f1.travelCoordinator.checked==false && f1.LocalAdmin.checked==false && f1.UnitHead.checked==false && f1.billApprover.checked==false && f1.branchManager.checked==false && f1.approvallevel1.checked==false && f1.approvallevel2.checked==false){
						alert('<%=dbLabelBean.getLabel("label.user.pleaseselectatleast",strsesLanguage)%>');
						return false;	
					}
				}else{
					if(f1.accountant.checked==false && f1.travelCoordinator.checked==false && f1.LocalAdmin.checked==false && f1.UnitHead.checked==false && f1.billApprover.checked==false && f1.approvallevel1.checked==false && f1.approvallevel2.checked==false){
						alert('<%=dbLabelBean.getLabel("label.user.pleaseselectatleast",strsesLanguage)%>');
					return false;
					}
				}
				
	      }
	
	  function setValue()
	         {
					 document.frm.action="Admin_User_Profile_Edit.jsp?changeCombo=yes";
					 document.frm.designation.value="-1";
					 document.frm.department.value="-1";
					 document.frm.submit();
	          }
	
	  function checkData(f1)
			  {
				   var travelAgencyCode	=	'<%=strTravelAgencyCode%>';
				   
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
						
					   /*
						if(f1.LocalAdmin.value == '-1' || f1.LocalAdmin.value == '')
								{
								   alert("Please select the Local Admin");
								   f1.LocalAdmin.focus();
								   return false;  
								}
								*/
	
						///added on 23/04/2007
						
						///added on 23/04/2007
	
						///2/28/2007 
					 
						if(f1.empcode.value == '')
								{
								   alert('<%=dbLabelBean.getLabel("alert.mylinks.enteremployeecode",strsesLanguage)%>');
								   f1.empcode.focus();
								   return false;  
								}
					  
	
							//empcode
						if(f1.dateOfBirth.value == 'S' || f1.dateOfBirth.value == '')
								{
								   alert('<%=dbLabelBean.getLabel("alert.global.dob",strsesLanguage)%>');
								   f1.dateOfBirth.focus();
								   return false;  
								} 
//added by manoj chand on 14 aug 2012 to show alert for workflow number
						if(f1.sp_role.value == '-1' || f1.sp_role.value == '')
						{
						   alert('<%=dbLabelBean.getLabel("alert.administration.pleaseselectworkflownumber",strsesLanguage)%>');
						   f1.sp_role.focus();
						   return false;  
						} 
					  
						 var   flag =  checkDOBOnly(f1);
							 if(flag == false)
							   return flag;						   
							   
						//check SMS access flag and mob no
						if(f1.smsFlag.checked==true){
							var mobNoLength = f1.mobNo.value.length;
							if(f1.mobNo.value==""){
								alert('<%=dbLabelBean.getLabel("alert.master.toactivatesmsaccessmobilenumberismandatory",strsesLanguage)%>');
								f1.mobNo.focus();
								return false;
							}
							else if(mobNoLength <10){
								alert('<%=dbLabelBean.getLabel("alert.master.mobilenumbermustbeminimumtendigits",strsesLanguage)%>');
								f1.mobNo.focus();
								return false;
							}
						}
						
						if(f1.mobNo.value!=""){				  
							var mobNoLength = f1.mobNo.value.length;
							if(mobNoLength <10){
								alert('<%=dbLabelBean.getLabel("alert.master.mobilenumbermustbeminimumtendigits",strsesLanguage)%>');
								f1.mobNo.focus();
								return false;
							}
						} 

					//added by manoj chand on 23 jan 2013 to make check while changing workflow number.
					if(f1.sp_role.value!='<%=strSp_role%>'){	
					var resflag =	fun_checkuserrequest(f1.sp_role.value);
					if(resflag=='Y'){
						alert('<%=dbLabelBean.getLabel("alert.updateprofile.cannotupdateworkflownumber",strsesLanguage)%>');
						f1.sp_role.value='<%=strSp_role%>';
						return false;
					}
					}
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
	                
	                
	                if(obj1=='middlename')
					{
						 obj = document.frm.middlename;
					}	
					 //2/28/2007
					if(obj1=='empcode')
					{
						 obj = document.frm.empcode;
						 //zeroChecking(obj);
					}	
				    //2/28/2007
				    
				    if(obj1=='userName')
					{
						 obj = document.frm.userName;
						 upToTwoHyphen(obj);
					}
	
					if(obj1=='eMail')
					{
						 obj = document.frm.email;
						 upToTwoHyphen(obj);
					}
					
					if(obj1=='mobNo')
					{
						obj = document.frm.mobNo;
					}	
					// addded new on 2/3/2009  by shiv sharma 
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
					if(obj1=='sp_role')
					{
						obj = document.frm.sp_role;
					}
	
					charactercheck(obj,str);
					limitlength(obj, length);
					//zeroChecking(obj); //function for checking leading zero and spaces
					spaceChecking(obj);
	 }
	
	function report_to(filename,k)
			{
						reportto = showModalDialog(filename+"&site_id="+document.frm.reportto[k].value+"&i="+k,"Win","scrollbars=yes,resizable=no,menubar=no,width=350,height=350");
						if(reportto==null)
							{
							document.frm.report.value="";
							}
						else
							{
							document.frm.report.value=reportto.flag;
							document.frm.repToUserId.value=reportto.userid;
							}
			}
//added by manoj chand on 14 aug 2012 to open see workflow window.
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


//added by manoj chand on 23 jan 2013 to check whether user have some requests in movement.
function fun_checkuserrequest(workflownumber){
			var var_userid='<%=strUserId%>';
			var urlParams = 'strFlag=CheckUserRequest&userid='+var_userid;
			var ret_flag;
			if(workflownumber!='-1'){
			$.ajax({
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
	
	<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
	     <table width="100%" border="0" cellspacing="0" cellpadding="10">
	            <tr>
	               <td height="38" class="bodyline-top">
					   <ul class="pagebullet">
						<li class="pageHead"><%=strMessage%></li>
					   </ul> 
				   </td>	
	           </tr>
	</table>
	<!-- Start of Form -->
	<Form method=post name=frm action="Admin_User_Profile_Post.jsp" > 
	        <table width="85%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
	           <tr align="left">
	                  <td colspan="4" class="selectedmenubg">&nbsp;</td>
	           </tr>
	           <tr align="left"> 
	            <td colspan="4" class="dataLabel"><%=dbLabelBean.getLabel("label.mylinks.updateyouruserid",strsesLanguage)%> <font color='red' size=1>  <!-- (In case you make any change in the name, unit, designation, department,employee code or date of birth, your access on STARS would be disabled. Your access would be enabled when your local administrator has made the verification.) --></font></td>
	            </tr>
	             <tr align="left">
							   <td width="15%" class="formtr1"><FONT SIZE="" COLOR="#FF3300">* </FONT><%=dbLabelBean.getLabel("label.global.firstname",strsesLanguage)%></td>
							   <!--  FIRST NAME  -->
							   <td width="25%" class="formtr1"><input type="text" name="firstName" size="25" onKeyUp="return test1('firstName', 29, 'c')" maxlength="50"  class="textBoxCss" value="<%=FIRSTNAME%>"/>  
										   <BR><%=dbLabelBean.getLabel("label.mylinks.asperpassport",strsesLanguage)%></td>
							   <td width="12%" class="formtr1"> <FONT SIZE="" COLOR="#FF3300"></FONT>&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.mylinks.middlename",strsesLanguage)%> </td>  
												  <!--  LAST NAME  -->
							   <td width="35%" class="formtr1"><input type="text" name="middlename" size="25" onKeyUp="return test1('middlename', 29, 'c')" maxlength="50" class="textBoxCss" value="<%=strMiddleName%>"/>   
												<%=dbLabelBean.getLabel("label.mylinks.asperpassport",strsesLanguage)%></td>
	              </tr>
	              
	               <tr align="left">
							   
							   <td width="120" class="formtr1"> 
					<% 			if(("2").equals(strTravelAgencyCode)) { %>				   		
							   		<FONT SIZE="" COLOR="#FF3300">* </FONT>
					<% 			} else { %>
									&nbsp;&nbsp;
					<%			} %>		   	
							   	<%=dbLabelBean.getLabel("label.global.lastname",strsesLanguage)%></td>  
												  <!--  LAST NAME  -->
							   <td width="328" class="formtr1"><input type="text" name="lastName" size="25" onKeyUp="return test1('lastName', 29, 'c')" maxlength="50" class="textBoxCss" value="<%=LASTNAME%>"/>   
											  <BR>	<%=dbLabelBean.getLabel("label.mylinks.asperpassport",strsesLanguage)%> </td>
							   
							   
							   <td width="116" class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.mylinks.employeecode",strsesLanguage)%></td>  
								
							   <td width="150" class="formtr1"><input type="text" name="empcode" size="25" maxlength="30" class="textBoxCss" onKeyUp="return test1('empcode', 30, 'cn')" value="<%=EMP_CODE%>"
							   	<% if("Y".equalsIgnoreCase(strSAPUserSyncFlag)) {%>
									readonly="readonly" onfocus="javascript:sapUserSyncAlert();blur();"
								<% } %>/>
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
	                         
	                         			String 	strSmrSiteFlag="";
										  rs = dbConBean.executeQuery("SELECT  DIV_ID,ISNULL(SMR_SITE_FLAG,'n') as SMR_SITE_FLAG FROM M_SITE WHERE APPLICATION_ID=1 and SITE_ID="+strSiteNameId); 
										  while(rs.next())
													 {
													 strDivNameId=rs.getString(1);
													 strSmrSiteFlag=rs.getString("SMR_SITE_FlAG"); 
													 }
										  
										  String strcolspan="";
										     	if(strSmrSiteFlag.equalsIgnoreCase("n")){
										     		strcolspan="2";	
										     	}else{
										     		strcolspan="1";
										     	}  
													 rs.close();
													 
													 
													 //System.out.println("strcolspan==="+strcolspan);
										  %>
	  
							<script language="javascript">
								document.frm.division.value="<%=strDivNameId%>";
								//alert(document.frm.division.value);
								</script>
						   
	                      <td class="formtr1"><FONT SIZE="" COLOR="#FF3300">* </FONT><%=dbLabelBean.getLabel("label.master.primaryunit",strsesLanguage)%></td>  <!--  Site  -->
	                      <td class="formtr1">
	                      <!-- return setValue(); -->
	      
	
	   
					<select name="site" onChange= "return setValue();"  class="textBoxCss">
							<option value="-1" selected><%=dbLabelBean.getLabel("label.createrequest.selectunit",strsesLanguage)%></option>
											<% //For Population of Site Combo according to the division
												if(strDivNameId != null && strDivNameId.equals("S"))
												{
												  
												}
												else
												{
												//New Check for local administrator
												if((SuserRole.trim().equals("AD")))  //-------------showing all site for administrator ---------------------
													{		   		  
													strSql = "SELECT SITE_ID,SITE_NAME FROM M_SITE WHERE  APPLICATION_ID=1 AND STATUS_ID = 10 AND (M_SITE.CLOSED_UNIT_FLAG is null or M_SITE.CLOSED_UNIT_FLAG='') ORDER BY SITE_NAME";
													}
													else if(SuserRole.trim().equals("LA"))   // ----showing site from where user (LA) has  registered -------------------- --"
													{		
													strSql = "SELECT SITE_ID,SITE_NAME FROM M_SITE WHERE site_id=(select site_id  from M_userinfo where userid="+strUserId+" and APPLICATION_ID=1 AND STATUS_ID = 10) AND (M_SITE.CLOSED_UNIT_FLAG is null or M_SITE.CLOSED_UNIT_FLAG='') ORDER BY SITE_NAME";
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
					</script>
					</td>
				</tr>
				 <tr align="left">	
	                      <td class="formtr1"><FONT SIZE="" COLOR="#FF3300">* </FONT> 
	                      	<%	if(strTravelAgencyCode.equals("2")) { %>
								<%=dbLabelBean.getLabel("label.createrequest.costcentre",strsesLanguage)%>
								
							<%	} else { %>
								<%=dbLabelBean.getLabel("label.requestdetails.department",strsesLanguage)%>
								
							<% 	} %>
	                      </td>  

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
								  strSql =   "SELECT DESIG_ID,DESIG_NAME  FROM M_DESIGNATION where site_id="+strSiteNameId+" AND APPLICATION_ID=1 AND        					 STATUS_ID = 10 ORDER BY DESIG_NAME";
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
	                    <tr>	<!-- 2/28/2007 by shiv -->
	                          <td class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.mail.username",strsesLanguage)%></td>
						      <td width="328" class="formtr1">
	                                <input name="userName" type="text" class="textBoxCss" onKeyUp="return test1('userName', 50, 'an')" size="25" maxlength="50" value="<%=strUserName%>"/>  
							  </td>
	
	                           <td class="formtr1">&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.requestdetails.dob",strsesLanguage)%></td><td class="formtr1"><input type="text" name="dateOfBirth"  size="10" maxlength="10"    
							           class="textBoxCss" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"  value="<%=DOB%>"/>
	                                     <a href="javascript:show_calendar('frm.dateOfBirth','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a> 
							   </td>
	                   </tr>
	
	
					     <tr>
						<!--10/18/2007 by shiv  open--> 
						<!--  Added  new fields for windows user id,domian id & sso flage on 05-02-2009 by shiv sharma -->
						<td class="formtr1"><font size="" color="#FF3300"></font>&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.mylinks.windowsuserid",strsesLanguage)%></td><td width="328" class="formtr1">
							<input type='text' name='winUserID' value="<%=strWinUserID%>"  class="textBoxCss"  onKeyUp="return test1('winUserID', 50, 'all')"/></td>
	
								<script language="javascript">
												document.frm.winUserID.value="<%=strWinUserID%>"; 
								</script>    
	
						 
						 <td class="formtr1">&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.master.domainname",strsesLanguage)%> <font size="" color="#FF3300"></font> </td>
								  <td class="formtr1">
										<input type='text' name='domainname' value="<%=strDomainName%>"  class="textBoxCss" onKeyUp="return test1('domainname', 30, 'All')"/></td>
	
								<script language="javascript">
												document.frm.domainname.value="<%=strDomainName%>";
								</script>
	 
	
						   <!--End Modification-->
	
						</tr>
						<tr>	<!-- 17/06/2015 by gurmeet -->
	                          <td class="formtr1">&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.relievingdate",strsesLanguage)%></td>
						      <td class="formtr1">
						      	<input type="text" name="relievingDate" size="10" maxlength="10" class="textBoxCss" 
						      		onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" 
						      		onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"  
						      		value="<%=strRelievingDate%>"/>
						      		<a href="javascript:show_calendar('frm.relievingDate','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a> 
							  </td>
							  <td  colspan="1" class="formtr1"><font size="" color="#FF3300">* </font>&nbsp;<%=dbLabelBean.getLabel("label.administration.workflownumber",strsesLanguage) %></td>
							  <td  colspan="1"  class="formtr1">
								<select class="textBoxCss" name="sp_role">
									 <option value="-1"><%=dbLabelBean.getLabel("label.administration.selectworkflow",strsesLanguage) %></option>
					<%
								rs=null;
								String strSProle="";
								strSql="select distinct sp_role from M_DEFAULT_APPROVERS where M_DEFAULT_APPROVERS.SITE_ID="+strSiteNameId+" and M_DEFAULT_APPROVERS.STATUS_ID=10";
								//System.out.println("strSql--->"+strSql);
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
								</select>&nbsp;&nbsp;<a  id="a_showworkflow" href="#" onClick="MM_openBrWindow1('M_dispWorkflow.jsp?siteid=<%=strSiteNameId%>','dispWorkflow')">see workflow</a>
							  </td>
	            </tr>
										
				<tr> 
						<!--10/18/2007 by shiv  open-->
						<td class="formtr1"><font size="" color="#FF3300"></font>&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.master.singlesignonenable",strsesLanguage)%>    
						</td>
						<td class="formtr1">  
							<input type="radio" value="y"   name="ssoflag" ><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%> &nbsp;&nbsp; &nbsp;
							&nbsp;
							<input type="radio" value="n" name="ssoflag" ><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
						</td> 
	
							<script language="javascript"> 
							var flag='<%=strSsoflag%>';
							///lert(flag);
							if (flag=='y'){
								document.frm.ssoflag[0].checked=true; 
								}
								else{
								document.frm.ssoflag[1].checked=true;  
								}
								
							</script> 
							
			                <td class="formtr1" colspan="2"><input type="hidden" name="costcentre" value="0"></td>
				</tr> 
	                   <!--  new code added by shiv  12 April 2007  -->
		              <tr align="center">
				                    <td colspan="4" align="left" class="dataLabel"><%=dbLabelBean.getLabel("label.mylinks.selectthepersonreportto",strsesLanguage)%>(<%=dbLabelBean.getLabel("label.global.approverlevel1",strsesLanguage)%>)</td>
				       </tr>
			 	       <tr align="center">
				                      <% for(int i=0;i<=1;i++) 
									             {     %>
				                                        <td class="formtr1">
				                                        <input type="radio" value=<%=strSiteNameId%> name="reportto" onClick="report_to('report_to.jsp?lang=<%=strsesLanguage %>','<%=i%>');"><%=arrayRadio[i]%></td>    
				                                          <% 
												 } %>
				                    <td class="formtr1">
									            <input type="text" name="report" size="20" value="<%=strReportPersonName%>" readonly class="textBoxCss" >
									            <!-- Added By Sachin for SMS Sending Flag on 20 Nov 2008 Start -->
				                                 <td class="formtr1">
				                                 	<%=dbLabelBean.getLabel("label.master.smsaccess",strsesLanguage)%><input type="checkbox" value="Y" name="smsFlag"/>
													&nbsp;&nbsp;&nbsp;&nbsp;
													<%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%> <input type="text" name="mobNo" maxlength="20" onKeyUp="return test1('mobNo', 20, 'n')"   class="textBoxCss" size="17" value="<%=CONTACT_NUMBER.trim()%>" />
				                                 </td>
				                                 <script>
				                                 	 var smsFlag	=	"<%=strSendingSMSFlag.toUpperCase()%>";	
				                                 	 if(smsFlag == 'Y')
				                                 	 	 document.forms[0].smsFlag.checked=true;
				                                 	 else
					                                     document.forms[0].smsFlag.checked=false;
				                                 </script>
				                                <!-- Added By Sachin for SMS Sending Flag on 20 Nov 2008 End -->
					 </tr>
	
	<!-- 2/28/2007 by shiv-->
	 				 <tr align="center">
						<td colspan="10" class="formtr1" style="font-size: 14px;text-align: center;">
							<input type="submit" name="Submit" class="formButton" onClick="return checkData(this.form)" 
								value="<%=dbLabelBean.getLabel("label.suggestions.update",strsesLanguage)%>">
						</td>
					 </tr>
	</table>

	<table width="85%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
			
			<tr>
				<td class="dataLabel" colspan=7><b><%=dbLabelBean.getLabel("label.master.grantaccess",strsesLanguage)%></b></td>
			</tr>
			<tr align="center">
				<td class="formhead" width="3%">&nbsp;</td>
				<td class="formhead" width="11%"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage)%>
					&nbsp; &nbsp;</td>
				<!-- <td class="formhead" width="11%">Department</td>
					           <td class="formhead" width="11%">Designation</td> 
					           <td class="formhead" width="11%">Role</td>  -->
				
				
				<td class="formhead" width="11%" nowrap="">Travel Coordinator</td>
				<td class="formhead" width="11%" nowrap="">Accountant</td>
								           
				<td class="formhead" width="11%"><%=dbLabelBean.getLabel("label.master.localadmin",strsesLanguage)%></td>
				<td class="formhead" width="11%"><%=dbLabelBean.getLabel("label.requestdetails.unithead",strsesLanguage)%></td>
				<td class="formhead" width="11%"><%=dbLabelBean.getLabel("label.requestdetails.billingapprover",strsesLanguage)%></td>
				<!-- code added by manoj chand on 27 Mar 2012 to add dropdown for branch manager -->
				<%if(strUserDivName.equalsIgnoreCase("Y") && SuserRole.equalsIgnoreCase("AD")) {%>
				<td class="formhead" width="11%"><%=dbLabelBean.getLabel("label.global.boardmember",strsesLanguage)%></td>
				<%} %>
				<td class="formhead" width="11%"><%=dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage)%></td>
				<td class="formhead" width="11%"><%=dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage)%></td>
				<td class="formhead" width="11%"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td>
			</tr>
			<!--new cdoe 123 open   upper code--------->
			<tr align="center">
				<td class="formtr1" width="3%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%>
				</td>
				<td class="formtr1" width="11%"><input type=hidden name=usId
					value="<%=strUserId.trim()%>"> <select name="userSite"
					class="textBoxCss">
						<!-- TD for unit -->
						<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectunit",strsesLanguage)%></option>
						<%  
						                    if((SuserRole.trim().equals("AD")))
											  {	
													strSql =   "SELECT SITE_ID,SITE_NAME FROM M_SITE WHERE  APPLICATION_ID=1 AND STATUS_ID = 10 ORDER BY SITE_NAME ";
											  }
											  else
											  {
													strSql = "SELECT SITE_ID,SITE_NAME FROM M_SITE WHERE APPLICATION_ID=1 AND STATUS_ID = 10 ORDER BY SITE_NAME";	
											  }
							                        sSqlStr	="SELECT DISTINCT ISNULL(SITE_ID,'-') AS SITE_ID, ISNULL(SITE_NAME,'-') AS SITE_NAME FROM M_SITE WHERE STATUS_ID=10 ORDER BY 2 ";
	                                                 rs       =   dbConBean.executeQuery(sSqlStr);    						 
	                       	                         while(rs.next())
								                        {
								                        strSiteId	=	rs.getString("SITE_ID");       
									                    strSiteName	=	rs.getString("SITE_NAME"); 
						%>
						<option value="<%=strSiteId%>">
							<%=strSiteName%>
						</option>
						<%  
														}
									         rs.close();
	                               //	}
									%>

				</select></td>
				
				<td class="formtr1" width="11%" style="text-align: center">
					<input type="checkbox" name="travelCoordinator" value="Y">
				</td>
				
				<td class="formtr1" width="11%" style="text-align: center">
					<input type="checkbox" name="accountant" value="Y">
				</td>
				
				<!--  commented by shiv on 18th April '07    -->
				<!--  open              
							<td class="formtr1"  width="11%">  
								 <select name="usDept" class="textBoxCss"> <!-- TD for depart ment  
												 <option value="-1" >Select your department</option>  
												<% /*
												
												
												sSqlStr		="select dept_id, dept_name from M_Department where status_id=10 and application_id=1  order by 1 ";
											
												rs       =   dbConBean.executeQuery(sSqlStr);    						 
											   
											while(rs.next())
												{
														 strdept_ID	=	rs.getString("dept_id").trim();
														 s_deptname	=	rs.getString("dept_name").trim();
														*/	%>
												<option value="<%=strdept_ID%>" > <%=s_deptname%> </option>
												<%/*
												}
													rs.close();
												
											*/	%>
											</select>&nbsp;
											 
								</td>
							<td class="formtr1"  width="11%">
							<!-- TD for designation 
											 close         -->
				<!--   <select name="usdesg" class="textBoxCss">
													 <option value="-1" >Select  Your designation</option>
													<% 
													
													
													sSqlStr		="SELECT ISNULL(DESIG_ID,'-') AS DESIG_ID, ISNULL(DESIG_NAME,'-') AS DESIG_NAME FROM M_DESIGNATION WHERE STATUS_ID=10 ORDER BY 2 ";
													 rs       =   dbConBean.executeQuery(sSqlStr);    						 
	
												while(rs.next())
													{
	
															 s_desgid	=	rs.getString("DESIG_ID").trim();
														 s_desgnm	=	rs.getString("DESIG_NAME").trim();
															%>
												<option value="<%=s_desgid%>" > <%=s_desgnm%> </option>
													<%
													}
														rs.close();
													
													%>
													</select>  </td>
							 -->
				<!--  commented by shiv on 18th April '07    -->
				<!-- TD for ROLE  -->

				<!-- <td class="formtr1"  width="11%">  
							<select name="roleid" class="textBoxCss">
													 <option value="-1" >Select Your Role</option> -->
				<!-- <%
													//sSqlStr		="SELECT DISTINCT ISNULL(ROLE_ID,'-') AS ROLE_ID  FROM M_USERINFO  ORDER BY 1 ";
												sSqlStr="  SELECT DISTINCT ISNULL(ROLE_ID,'-') AS ROLE_ID  FROM M_USERINFO  where role_id!='ad' ORDER BY 1 ";
													 rs       =   dbConBean.executeQuery(sSqlStr);    						 
												while(rs.next())
													{
															//String s_levelid	=	rs.getString(1).trim();
															   s_levelnm	=	rs.getString("ROLE_ID").trim();
																%>
													<option value="<%=s_levelnm%>" > <%=s_levelnm%> </option>
												  
													<%
	
													}
														rs.close();
														
													%> 
												</select>
												
													
													</td>
	
												</td> -->
				<td class="formtr1" width="11%" style="text-align: center">
					<%--<select name="LocalAdmin" class="textBoxCss">
														  <option value="-1" >   &nbsp;       &nbsp;        <%=dbLabelBean.getLabel("label.master.localadmin",strsesLanguage)%>     &nbsp;      &nbsp;    </option>
														  <option value="y"> <%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%> </option>
														  <option value="N"> <%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%> </option>  
													</select>
											  --%> <input type="checkbox" name="LocalAdmin" value="y">
				</td>
				<td class="formtr1" width="11%" style="text-align: center">
					<%--<select name="UnitHead" class="textBoxCss">
															 <option value="-1" >   &nbsp;       &nbsp;        <%=dbLabelBean.getLabel("label.requestdetails.unithead",strsesLanguage)%>     &nbsp;      &nbsp;    </option>
															 <option value="1"> <%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%> </option>
															 <option value="0"> <%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%> </option>  
			                                     </select>
			                                     --%> <input type="checkbox"
					name="UnitHead" value="1">
				</td>
				<td class="formtr1" width="11%" style="text-align: center">
					<!-- TD for Unit head added on 23/04/2007  -->&nbsp;&nbsp; <%--<select name="billApprover" class="textBoxCss">
															 <option value="-1" >   &nbsp;       &nbsp;        <%=dbLabelBean.getLabel("label.requestdetails.billingapprover",strsesLanguage)%>     &nbsp;      &nbsp;    </option>
															 <option value="1"> <%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%> </option>
															 <option value="0"> <%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%> </option>  
			                                     </select>
			                                     --%> <input type="checkbox"
					name="billApprover" value="1">
				</td>
				<!-- code added by manoj chand on 27 Mar 2012 to add dropdown for branch manager -->
				<%if(strUserDivName.equalsIgnoreCase("Y") && SuserRole.equalsIgnoreCase("AD")) {%>
				<td class="formtr1" width="11%" style="text-align: center">
					<%--&nbsp;&nbsp; 
	                                           <select name="branchManager" class="textBoxCss">
															 <option value="-1" >   &nbsp;       &nbsp;        <%=dbLabelBean.getLabel("label.global.boardmember",strsesLanguage)%>     &nbsp;      &nbsp;    </option>
															 <option value="Y"> Yes </option>
															 <option value="N"> No </option>  
			                                     </select>
										   --%> <input type="checkbox" name="branchManager" value="Y">
				</td>
				<%} %>
				<!-- end here -->
				<td class="formtr1" width="11%" style="text-align: center"><input
					type="checkbox" name="approvallevel1" value="Y"></td>
				<td class="formtr1" width="11%" style="text-align: center"><input
					type="checkbox" name="approvallevel2" value="Y"></td>
				<td class="formtr1" width="11%" style="text-align: center;"><input
					type="submit" name="Submit"	value="<%=dbLabelBean.getLabel("label.master.add",strsesLanguage)%>"
					class="formButton" onClick="return checkdatanew(frm);">
				</td>
			</tr>
			<tr>
			</tr>
			<!--new code 123 upper code close  -->

			<!-- lower code open -->
			<% 
												   
	
									 String strSITE_name			= "";
									 String strdept_name			= "";
									 String strDesig_name			= ""; 
									 String strRoleidnew			= ""; 
									 String strSite_idnew			= "";
									 String localadmin				= "";
									 String strBilling_Approver		= "";
									 String strBranch_Manager		= "";
									 String strApprovalLvl1 		= "";
									 String strApprovalLvl2 		= "";
									 
									 String strAccountant			= "";
									 String strTravelCoordinator	= "";
									 
									 int Sn=1;  
			 	                     //sSqlStr="SELECT  ISNULL(dbo.SITENAME(SITE_ID),'') as SITENAME,ISNULL(dbo.DEPARTMENTNAME(DEPARTMENT_ID),'') as DEPARTMENTNAME,ISNULL(dbo.DESIGNATIONNAME(DESIG_ID),'')  AS DESIGNATIONNAME, Role_ID,SITE_ID, ISNULL(UNIT_HEAD,'') AS UNIT_HEAD   FROM user_multiple_access   where  userid="+strUserId+" AND status_id=10 ";
									// Query changed by vaibhav on Aug 20 2010
			 	                   /* sSqlStr="SELECT     ISNULL(dbo.SITENAME(UMA.SITE_ID), '') AS SITENAME, ISNULL(dbo.DEPARTMENTNAME(UMA.DEPARTMENT_ID), '') AS DEPARTMENTNAME," +
			 	                    	" ISNULL(dbo.DESIGNATIONNAME(UMA.DESIG_ID), '') AS DESIGNATIONNAME, UMA.ROLE_ID, UMA.SITE_ID, ISNULL(UMA.UNIT_HEAD, '') AS UNIT_HEAD " +
			 	                    	" , CASE WHEN APPROVER_ID IS NULL THEN 'N' ELSE 'Y' END AS BILLING_APPROVER " +
			 	                    	" ,CASE WHEN UMA.USERID=(SELECT USERID FROM M_BOARD_MEMBER WHERE SITE_ID=UMA.SITE_ID AND USERID=UMA.USERID AND STATUS_ID=10) THEN 'Y' ELSE 'N' END AS BOARD_MEMBER"+
			 	                    	" FROM         USER_MULTIPLE_ACCESS UMA LEFT JOIN M_BILLING_APPROVER MBA ON MBA.APPROVER_ID = UMA.USERID AND UMA.SITE_ID = MBA.SITE_ID " +
			 	                    	" WHERE     (USERID ="+strUserId+") AND (STATUS_ID = 10) " +
			 	                    	" UNION ALL " +
			 	                    	" SELECT     ISNULL(dbo.SITENAME(UMA.SITE_ID), '') AS SITENAME,  '' AS DEPARTMENTNAME, '' AS DESIGNATIONNAME," + 
			 	                    	" '' as ROLE_ID, UMA.SITE_ID, 0 AS UNIT_HEAD, 'Y' BILLING_APPROVER,'N'" +
			 	                    	" FROM         M_BILLING_APPROVER UMA " +
			 	                    	" WHERE     (APPROVER_ID ="+strUserId+") and not exists (select 1 from USER_MULTIPLE_ACCESS (nolock) where site_id= UMA.SITE_ID and USERID = UMA.Approver_id and (STATUS_ID = 10))";*/
			 	                    	
			 	                   sSqlStr= " SELECT ISNULL(dbo.SITENAME(UMA.SITE_ID), '') AS SITENAME, "+
				 	                    	" ISNULL(dbo.DEPARTMENTNAME(UMA.DEPARTMENT_ID), '') AS DEPARTMENTNAME, "+
				 	                    	" ISNULL(dbo.DESIGNATIONNAME(UMA.DESIG_ID), '') AS DESIGNATIONNAME, "+
				 	                    	" UMA.ROLE_ID,UMA.SITE_ID,  ISNULL(UMA.UNIT_HEAD, '') AS UNIT_HEAD  , "+
				 	                    	" CASE WHEN APPROVER_ID IS NULL THEN 'N' ELSE 'Y' END AS BILLING_APPROVER, "+
				 	                    	" CASE WHEN MBM.USERID IS NULL THEN 'N' ELSE 'Y' END AS BOARD_MEMBER, "+
				 	                    	" UMA.APPROVAL_LVL1 AS AP_LVL1, "+
				 	                    	" UMA.APPROVAL_LVL2 AS AP_LVL2, "+
				 	                    	" CASE WHEN EXISTS(SELECT 1 FROM M_USERROLE WHERE USERID=UMA.USERID AND SITE_ID=UMA.SITE_ID AND STATUS_ID=10 AND ROLE_ID='TC') "+
				 	                    	" THEN 'Y' ELSE 'N' END AS TRAVEL_COORDINATOR,CASE WHEN EXISTS(SELECT 1 FROM M_USERROLE WHERE USERID=UMA.USERID AND SITE_ID=UMA.SITE_ID AND STATUS_ID=10 AND ROLE_ID='AC') "+ 
				 	                    	" THEN 'Y' ELSE 'N' END AS ACCOUNTANT "+
				 	                    	" FROM USER_MULTIPLE_ACCESS UMA (NOLOCK) "+
				 	                    	" LEFT JOIN M_BILLING_APPROVER MBA (NOLOCK) "+
				 	                    	" ON MBA.APPROVER_ID = UMA.USERID AND UMA.SITE_ID = MBA.SITE_ID "+
				 	                    	" LEFT JOIN M_BOARD_MEMBER MBM  (NOLOCK) ON MBM.SITE_ID=UMA.SITE_ID "+
				 	                    	" AND UMA.USERID=MBM.USERID AND MBM.STATUS_ID=10 "+
				 	                    	" WHERE (UMA.USERID ="+strUserId+") AND (UMA.STATUS_ID = 10) "+
				 	                    	" UNION ALL "+
				 	                    	" SELECT ISNULL(dbo.SITENAME(UMA.SITE_ID), '') AS SITENAME, "+
				 	                    	" '' AS DEPARTMENTNAME, '' AS DESIGNATIONNAME, '' as ROLE_ID, "+
				 	                    	" UMA.SITE_ID, 0 AS UNIT_HEAD, 'Y' BILLING_APPROVER ,CASE WHEN MBM.USERID IS NULL THEN 'N' ELSE 'Y' END AS BOARD_MEMBER, "+
				 	                    	" 'N' AS AP_LVL1,'N' AS AP_LVL2,'N' ,'N' "+
				 	                    	" FROM M_BILLING_APPROVER UMA (NOLOCK) "+
				 	                    	" LEFT JOIN M_BOARD_MEMBER MBM  (NOLOCK) "+
				 	                    	" ON MBM.SITE_ID=UMA.SITE_ID AND UMA.APPROVER_ID=MBM.USERID AND MBM.STATUS_ID=10 "+
				 	                    	" AND (UMA.APPROVER_ID ="+strUserId+") "+
				 	                    	" WHERE (UMA.APPROVER_ID ="+strUserId+") "+
				 	                    	" and not exists (select 1 from USER_MULTIPLE_ACCESS (nolock) "+
				 	                    	" where site_id= UMA.SITE_ID and USERID = UMA.Approver_id "+
				 	                    	" and (STATUS_ID = 10)) "+
				 	                    	" UNION ALL "+
				 	                    	" SELECT ISNULL(dbo.SITENAME(MBM.SITE_ID), '') AS SITENAME, "+
				 	                    	" '' AS DEPARTMENTNAME, '' AS DESIGNATIONNAME,'' as ROLE_ID, MBM.SITE_ID, 0 AS UNIT_HEAD, 'N' BILLING_APPROVER,'Y', "+
				 	                    	" 'N' AS AP_LVL1 ,'N' AS AP_LVL2,'N','N' FROM M_BOARD_MEMBER MBM (NOLOCK) "+
				 	                    	" WHERE(USERID="+strUserId+") "+
				 	                    	" and not exists(select 1 from USER_MULTIPLE_ACCESS (nolock) where site_id= MBM.SITE_ID "+
				 	                    	" and USERID = MBM.USERID and (STATUS_ID = 10)) "+
				 	                    	" AND NOT EXISTS (SELECT 1 FROM M_BILLING_APPROVER (NOLOCK) WHERE SITE_ID = MBM.SITE_ID "+
				 	                    	" AND APPROVER_ID=MBM.USERID AND STATUS_ID=10) AND STATUS_ID=10 "+
				 	                    	" UNION ALL "+
				 	                    	" SELECT ISNULL(dbo.SITENAME(UR.SITE_ID), '') AS SITENAME, "+
				 	                    	" '' AS DEPARTMENTNAME, '' AS DESIGNATIONNAME,'' as ROLE_ID, UR.SITE_ID, 0 AS UNIT_HEAD, 'N' BILLING_APPROVER,'N', "+
				 	                    	" 'N' AS AP_LVL1 ,'N' AS AP_LVL2,TCROLE,ACROLE  FROM (SELECT SITE_ID,USERID, "+
				 	                    	" MAX(CASE WHEN ROLE_ID='TC' THEN 'Y' ELSE 'N' END) AS TCROLE, "+
				 	                    	" MAX(CASE WHEN ROLE_ID='AC' THEN 'Y' ELSE 'N' END) AS ACROLE FROM  M_USERROLE(NOLOCK) "+
				 	                    	" WHERE (USERID="+strUserId+") GROUP BY SITE_ID,USERID) AS UR "+
				 	                    	" WHERE NOT EXISTS (SELECT 1 FROM USER_MULTIPLE_ACCESS (NOLOCK) WHERE USER_MULTIPLE_ACCESS.SITE_ID = UR.SITE_ID "+
				 	                    	" AND USER_MULTIPLE_ACCESS.USERID=UR.USERID AND USER_MULTIPLE_ACCESS.STATUS_ID=10) "+
				 	                    	" AND NOT EXISTS (SELECT 1 FROM M_BILLING_APPROVER (NOLOCK) WHERE M_BILLING_APPROVER.SITE_ID = UR.SITE_ID "+
				 	                    	" AND M_BILLING_APPROVER.APPROVER_ID=UR.USERID) "+
				 	                    	" AND NOT EXISTS (SELECT 1 FROM M_BOARD_MEMBER (NOLOCK) WHERE M_BOARD_MEMBER.SITE_ID = UR.SITE_ID "+
				 	                    	" AND M_BOARD_MEMBER.USERID=UR.USERID AND M_BOARD_MEMBER.STATUS_ID=10)";


					   				//System.out.println("sSqlStr===============>"+sSqlStr);
									 rs1       =   dbConBean1.executeQuery(sSqlStr);    						 
										while(rs1.next())
									  { 
	                  				       strSITE_name  		= rs1.getString("SITENAME");
										   strdept_name  		= rs1.getString("DEPARTMENTNAME");
										   strDesig_name 		= rs1.getString("DESIGNATIONNAME");
										   strRoleidnew  		= rs1.getString("Role_ID");
										   strSite_idnew 		= rs1.getString("SITE_ID");
										   strUnit_head	 		= rs1.getString("UNIT_HEAD");
										   strBranch_Manager	= rs1.getString("BOARD_MEMBER");
										   strApprovalLvl1 		= rs1.getString("AP_LVL1");
										   strApprovalLvl2 		= rs1.getString("AP_LVL2");
										   strTravelCoordinator	= rs1.getString("TRAVEL_COORDINATOR");
										   strAccountant		= rs1.getString("ACCOUNTANT");
										   
										   if(strTravelCoordinator.equals("") || strTravelCoordinator == null)
											   strTravelCoordinator="N";
										   if(strAccountant.equals("") || strAccountant == null)
											   strAccountant="N";
										   
										   if(strApprovalLvl1.equals(""))
											   strApprovalLvl1="N";
										   if(strApprovalLvl2.equals(""))
											   strApprovalLvl2="N";
						                                           // if(LocalAdmin.equals("y")) 
		                                   { 
												strSql="SELECT distinct USERID,SITE_ID FROM M_USERROLE  WHERE USERID="+strUserId+" and site_id="+strSite_idnew+" and status_id=10  and ROLE_ID='LA'";
												//System.out.println("strSql--->"+strSql);
												rs     = dbConBean.executeQuery(strSql);
												if(!rs.next())
												{                      
													localadmin="N"; 
												} 
												else
												{
												  	localadmin="Y"; 
												}
	          							   }	
	 
		   
											 if(strUnit_head.equals("1"))
											  {
												strUnit_head="Y";
											   }
											   else 
											  {
												strUnit_head="N";
											   }
											 
											 
											
													strSql="SELECT distinct BA.APPROVER_ID,BA.SITE_ID FROM M_BILLING_APPROVER BA inner join M_USERINFO mui on BA.APPROVER_ID = mui.userid WHERE BA.APPROVER_ID ="+strUserId+" and BA.site_id="+strSite_idnew+" and mui.STATUS_ID=10 "; 
													rs_BA    = dbConBean.executeQuery(strSql);
													if(!rs_BA.next())
														{                      
														strBilling_Approver="N"; 
														} 
													  else
														 {
														  strBilling_Approver="Y"; 
														 }
													rs_BA.close();
													
													/*if(strUserDivName.equalsIgnoreCase("SMP") && SuserRole.equalsIgnoreCase("AD"))
													{
													strSql="SELECT BM.USERID,BM.SITE_ID FROM M_BOARD_MEMBER BM "+ 
														   " INNER JOIN M_USERINFO MU"+
														   " ON BM.USERID=MU.USERID"+
														   " WHERE BM.SITE_ID='"+strSite_idnew+"' AND BM.USERID='"+strUserId+"' AND BM.STATUS_ID=10 AND MU.STATUS_ID=10";
													System.out.println("strSql--->"+strSql);
													rs_BM    = dbConBean.executeQuery(strSql);
													if(!rs_BM.next())
														{                      
														strBranch_Manager="N"; 
														} 
													  else
														 {
														  strBranch_Manager="Y"; 
														 }
													rs_BM.close();
													}*/
													
													
											 
				                    %>
			<tr align="center">
				<td class="formtr1" width="3%" style="text-align: center;"><%=Sn%></td>
				<td class="formtr1" width="11%" style="text-align: center;"><%=strSITE_name%></td>
				<td class="formtr1" width="11%" style="text-align: center;"><%=strTravelCoordinator%></td>
				<td class="formtr1" width="11%" style="text-align: center;"><%=strAccountant%></td>
				<td class="formtr1" width="11%" style="text-align: center;"><%=localadmin%></td>
				<td class="formtr1" width="11%" style="text-align: center;"><%=strUnit_head%></td>
				<td class="formtr1" width="11%" style="text-align: center;"><%=strBilling_Approver%></td>
				<!-- added by manoj chand on 27 March 2012 to display Branch Manager for SMP Sites -->
				<%if(strUserDivName.equalsIgnoreCase("Y") && SuserRole.equalsIgnoreCase("AD")) {%>
				<td class="formtr1" width="11%" style="text-align: center;"><%=strBranch_Manager%></td>
				<%} %>
				<!-- End Here -->
				<td class="formtr1" width="11%" style="text-align: center;"><%=strApprovalLvl1%></td>
				<td class="formtr1" width="11%" style="text-align: center;"><%=strApprovalLvl2%></td>
				<td class="formtr1" width="11%" style="text-align: center;"><INPUT
					TYPE=button size="12"
					VALUE=" <%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage)%> "
					CLASS=formbutton
					onClick="return forwardDelete(<%=strUserId%>,<%=strSite_idnew%>,'<%=strUnit_head%>');"
					<%=strDisableButton%>></td>
			</tr>
				<% 
											Sn++;
									  }
											rs1.close();
							              %>

				<!-- <table width="85%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder"> -->
			
			<input type="hidden" name="status_id" value="10">
			<!--  HIDDEN FIELD  -->
			<input type="hidden" name="repTo" value=<%=REPORT_TO%>>
			<!--  HIDDEN FIELD  -->
			<input type="hidden" name="repToUserId" value="s1">
			<!--  HIDDEN FIELD  -->
			<input type="hidden" name="todayDate" value="<%=strCurrentDate%>" />
			<!--  HIDDEN FIELD  -->
			<input type="hidden" name="userId" value="<%=strUserId%>" />
			<!--  HIDDEN FIELD  -->
			<input type="hidden" name="userDivision" value="<%=strUserDivName%>" />
			<input type="hidden" name="userNameOld" value="<%=strUserNameOld%>" />

		</table>
	<script type="text/javascript">
	$( document ).ready(function() {
		$('[name=userSite]').change(function() {
			
			var siteIdVal  = $('[name=userSite]').val();
			var workflowNo = '<%=strSp_role%>';
			
			if (siteIdVal != '-1') {
				var urlParams = 'siteId='+siteIdVal+'&sp_role='+workflowNo+'&reqpage=checkWorkflowExistance';
				
				$.ajax({
			        type: "post",
			        url: "AjaxMaster.jsp",
			        async: false,
			        data: urlParams,
			        success: function(result){
			        	ret_flag=jQuery.trim(result);
			        	if (ret_flag == 'false') {
			        		alert("<%=dbLabelBean.getLabel("alert.workflow.workflowdoesnotexist",strsesLanguage)%>");
			        	}
			        },
			        error:function(){
			        	alert('Jquery Error [Grant access to user : check workflow existence]');
			        }
			      });
			}
		});
	});
	</script>
	</form><!-- End of Form -->
	     </body>
	</html>
			<%
			   dbConBean.close();  // CLOSE ALL CONNECTION
			%>
